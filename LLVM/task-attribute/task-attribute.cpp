/*
 * uSFI Project
 * LLVM pass. This pass does the following:  
 *  - Assignes text sections to functions
 *  - Generates gateway functions for modules
 *  - Instruments Indirect branches/calls and returns
 * Author: Zelalem Aweke (zaweke@umich.edu)
 */


#include <iostream>
#include <stdlib.h>
#include <cassert>
#include <set>
#include <map>
#include <vector>
#include "llvm/Pass.h"
#include "llvm/IR/Intrinsics.h"
#include "llvm/IR/Module.h"
#include "llvm/IR/Function.h"
#include "llvm/IR/Instructions.h"
#include "llvm/IR/Instruction.h"
#include "llvm/IR/IntrinsicInst.h"
#include "llvm/IR/Type.h"
#include "llvm/IR/Function.h"
//#include "llvm/Analysis/ProfileInfo.h"
#include "llvm/Support/raw_ostream.h"
#include "llvm/Analysis/CallGraph.h"
#include "llvm/Analysis/DominanceFrontier.h"
#include "llvm/Analysis/LoopInfo.h"
#include "llvm/ADT/PostOrderIterator.h"
#include "llvm/Analysis/PostDominators.h"

#include "llvm/ADT/BitVector.h"
#include "llvm/ADT/PostOrderIterator.h"
#include "llvm/ADT/SetVector.h"
#include "llvm/ADT/SmallPtrSet.h"
#include "llvm/IR/IRBuilder.h"
#include "llvm/Support/CommandLine.h"
#include "llvm/Transforms/Utils/Cloning.h"
#include "llvm/IR/InlineAsm.h"
#include <llvm/Assembly/PrintModulePass.h>
#include <llvm/Support/FormattedStream.h>
#include <llvm/Support/MathExtras.h>
#include <algorithm>


#define CLONE_FUNCTIONS 0
#define EXIT_SVC 255

using namespace llvm;

enum SectionOpts{
  d,l,t
};

//Section type option
static cl::opt<SectionOpts> SectionType(cl::desc("Choose Section Type"),
  cl::values(clEnumVal(d , "Driver"),
             clEnumVal(l, "Library"),
             clEnumVal(t, "Task"), NULL), cl::Required);

//Section name option
static cl::opt<std::string> SectionName("n", cl::desc("Specify section name"), cl::value_desc("section name"),cl::Required);
//List of entry functions option
static cl::list<std::string> EntryFuns("F",cl::desc("Specify task entry function names"), cl::ZeroOrMore, cl::value_desc("task entry function names"));
//Module number
static cl::opt<unsigned int> ModuleNumber("m", cl::desc("Specify module number"), cl::value_desc("Module Number"),cl::Required);


namespace {
  struct TaskAttribute : public ModulePass {
    std::vector<CallGraphNode*> callNodes;  /* Vector for callgraph nodes and thier children */

  static char ID;
  CallGraph *callG;

  int sharedId = 0;

  std::vector<std::string> taskSections;

  //External variables that specify start and end 
  //addresses of sections. The values are obtained from
  //linker script at link time
  std::vector<Constant*> startConstPtrs;
  std::vector<Constant*> endConstPtrs;

  std::vector<GlobalVariable*> startVars;
  std::vector<GlobalVariable*> endVars;

  //External variables that specify gateway return
  //address for drivers
  Constant* gatewayReturnPtr;

  unsigned int indirectCounter = 0;
  unsigned int labelCounter = 0;
  
  TaskAttribute() : ModulePass(ID) { }


/* Taken from ModuleLinker::linkFunctionBody function in LinkModules.cpp */
void copyFunction(Function *Dst, Function *Src) {

  ValueToValueMapTy ValueMap;
 
  assert(Src);

  // Go through and convert function arguments over, remembering the mapping.
  Function::arg_iterator DI = Dst->arg_begin();
  for (Function::arg_iterator I = Src->arg_begin(), E = Src->arg_end();
       I != E; ++I, ++DI) {
    DI->setName(I->getName());  // Copy the name over.

    // Add a mapping to our mapping.
    ValueMap[I] = DI;
  }

   // Clone the body of the function into the dest function.
   SmallVector<ReturnInst*, 8> Returns; // Ignore returns.
   CloneFunctionInto(Dst, Src, ValueMap, false, Returns, "", NULL, NULL);
}

/* Go through every BB searching for calls to oldF and replacing it with newF */
void changeCalls(Function *PF, Function *oldF, Function *newF){
  
  for( Function::iterator BB = PF->begin(); BB != PF->end(); BB++){
    for( BasicBlock::iterator I = BB->begin(); I != BB->end(); I++){
      if(CallInst* callI = dyn_cast<CallInst>(I)) {
        if(oldF == callI->getCalledFunction()){
          callI->setCalledFunction(newF);
        }
      }
    }
  }
}

/* Go through every BB searching for calls to oldF and replacing it with newF */
void addFunctions(CallGraphNode *node){
  Function *FI = node->getFunction();

  for( Function::iterator BB = FI->begin(); BB != FI->end(); BB++){
    for( BasicBlock::iterator I = BB->begin(); I != BB->end(); I++){
      if(CallInst* callI = dyn_cast<CallInst>(I)) {
        CallSite CS (callI);
        node->addCalledFunction(CS,callG->operator[](callI->getCalledFunction()));
      }
    }
  }
}

void updateSection(CallGraphNode *Node){
  if(!Node->empty()){
    std::string secName = Node->getFunction()->getSection();
    for(CallGraphNode::iterator it = Node->begin(); it != Node->end(); ++it){
   
        it->second->getFunction()->setSection(secName);
      updateSection(it->second);
    }
  }
} 


CallGraphNode * setSection(CallGraphNode *parentNode, CallGraphNode *node, std::string secName){

CallGraphNode *nextNode = node;
Function *FI = node->getFunction();

if (FI){
  errs() << FI->getName() <<"\n";
  //errs() << FI->isDeclaration() <<"\n";
    /* If it is a driver function (identified by the section) ignore. It will later be replaced with a gateway function with
    driver name, function name and driver function arguments as arguments to the gateway function */
    //TODO: if it is a driver, check if this is a call to another driver (compare the whole name)
    //if(FI->getSection().find(".text.driver") != std::string::npos){

  /* Function section is not assigned */
  if(FI->getSection().compare("") == 0){
    //Check if the function is defined. If it is not defined in the module, then it is assumed to be a 
    //driver or library function to be linked later on. If it is only a declaration, add the lib section to the 
    //list of accessable sections and move to the next function.
    if(FI->isDeclaration()){
        //TODO:Fix this
        //taskSections.push_back(".text.lib");
    }

    //Function is unassigned to any section and not a library function
    else{
      /* Set a new section name */
      /* Change section name of task entry function */
      FI->setSection(secName);
          /* Mark as visited */
      //visitedNodes.push_back(node);
    }
  }
}

return nextNode;
  
}

/* Go through the callgraph starting at Node and set text section name */ 
void getAllNodes(CallGraphNode *Node, std::string secName){
  if(!Node->empty()){
    //Node->dump();
    for(CallGraphNode::iterator it = Node->begin(); it != Node->end(); ++it){
   
        CallGraphNode *nextNode = setSection(Node, it->second, secName);
          //errs() << "node:"<< nextNode->getFunction()->getName() << "\n";
          //nextNode->dump();
        //Check for recursive functions
        if(nextNode == Node)
          break;

        getAllNodes(nextNode,secName);
    }
  }
} 

void declareSectionVariables(Module *mod, std::vector<std::string> sectionList, bool driver){
  //Declare external global variables that are a place holder
  //for section boundaries (section start and end addresses). The values of the boundaries are obtained
  //from the linker script at link time.
  ArrayType* ArrayTy = ArrayType::get(IntegerType::get(mod->getContext(), 32), 0);
  PointerType* PointerTy = PointerType::get(IntegerType::get(mod->getContext(), 8), 0);
  PointerType* PointerTy1 = PointerType::get(IntegerType::get(mod->getContext(), 32), 0);

  ConstantInt* const_int32_0 = ConstantInt::get(mod->getContext(), APInt(32, StringRef("0"), 10));
  std::vector<Constant*> constPtrIndices;
  constPtrIndices.push_back(const_int32_0);
  constPtrIndices.push_back(const_int32_0);


  //Declare section start and end address variables
  for(unsigned i=0; i < sectionList.size(); i++){
    std::string startName = sectionList[i];
    std::string endName = sectionList[i];
    startName = startName + "_start";
    endName = endName + "_end";

    //Section start address variable
    GlobalVariable* startVar = new GlobalVariable(/*Module=*/*mod, 
    /*Type=*/ArrayTy,
    /*isConstant=*/false,
    /*Linkage=*/GlobalValue::ExternalLinkage,
    /*Initializer=*/0, 
    /*Name=*/startName);

    startConstPtrs.push_back(ConstantExpr::getGetElementPtr(startVar, constPtrIndices));
    startVars.push_back(startVar);

    //Section end address variable
    GlobalVariable* endVar = new GlobalVariable(/*Module=*/*mod, 
    /*Type=*/ArrayTy,
    /*isConstant=*/false,
    /*Linkage=*/GlobalValue::ExternalLinkage,
    /*Initializer=*/0, 
    /*Name=*/endName);

    endConstPtrs.push_back(ConstantExpr::getGetElementPtr(endVar, constPtrIndices));
    endVars.push_back(endVar);
  }
}

void insertChecks(Module *mod, Function *F, Instruction *Inst, std::vector<std::string> sectionList, bool driver, bool ret){

  //PointerType* PointerTy = PointerType::get(IntegerType::get(mod->getContext(), 32), 0);
  std::vector<Type*>FuncTy_1_args;
  FunctionType* FuncTy_1 = FunctionType::get(
  /*Result=*/Type::getVoidTy(mod->getContext()),
  /*Params=*/FuncTy_1_args,
  /*isVarArg=*/false);

    //Exception function
    std::vector<Type*>FuncTy_6_args;
    FunctionType* FuncTy_6 = FunctionType::get(
    Type::getVoidTy(mod->getContext()),
    FuncTy_6_args,
    false);
    Function* func_exception = mod->getFunction("exceptionFun");
    if (!func_exception) {
      func_exception = Function::Create(
      FuncTy_6,
      GlobalValue::ExternalLinkage,
      "exceptionFun", mod); // (external, no body)
      func_exception->setCallingConv(CallingConv::C);
      func_exception->setSection(".text.common");
    }   
    unsigned i;
    //Add the bounds check instructions for all sections
    for(i=0; i < sectionList.size(); i++)
      //Lable to help rewrite bound addresses in the binary
      //Lable format: "section-name_ret_check_function-name"
      std::string asmString
      if(ret){
        asmString = "boundcheckstart." + F->getName().str() +  sectionList[i] + ".ret"  + ":\n";
      }
      else{ //Indirect branch/cal
        asmString = "boundcheckstart." + F->getName().str() +  sectionList[i] + ".indirect_" + std::to_string(indirectCounter) + ":\n";
        //Save lr and copy address to lr. r0 will be replaced by the address register
        asmString = asmString + "\tpush {lr}\n \tmov lr, r0\n";
        //Increment counter. Counter is used to avoid lable name conflicts 
        indirectCounter++;
      
      if(driver){ //TODO:Drivers can return to a call site from a gateway
         std::string label = "end_of_check_" + F->getName().str() + std::to_string(labelCounter++);
         //bic (bit clear) instruction 
         asmString = asmString + "\tpush {r0}\n \tmovw r0, #5555\n \tmovt r0, #4444\n \tbic lr,lr,#1\n \tcmp lr, r0\n \tbeq " + label + "\n \tmovw r0, #9999\n \tmovt r0, #8888\n \tcmp lr, r0\n \tit cc\n \tblcc exceptionFun\n \tmovw r0, #7777\n \tmovt r0, #6666\n \tcmp lr, r0\n \tit cs\n \tblcs exceptionFun\n" 
         + label + ":\n" + "\tpop {r0}\n \torr lr,lr,#1\n"
         if(!ret)
          asmString = asmString + "\tpop {lr}\n";
      
      else{
        asmString = asmString + "\tpush {r0}\n \tmovw r0, #9999\n \tmovt r0, #8888\n \tcmp lr, r0\n \tit cc\n\tblcc exceptionFun\n \tmovw r0, #7777\n \tmovt r0, #6666\n \tcmp lr, r0\n \tit cs\n \tblcs exceptionFun\n \tpop {r0}\n"
        if(!ret)
          asmString = asmString + "\tpop {lr}\n";
      
      if(ret)
          asmString = asmString + "boundcheckend." + F->getName().str() + sectionList[i] + ".ret"  + ":\n";
      else
          asmString = asmString + "boundcheckend." +  F->getName().str()  + sectionList[i] + ".indirect_"  + std::to_string(indirectCounter) + ":\n"
      //Bounds check instructions
      /*asmString = asmString + "movw r0, $0\nmovt r0, $1\ncmp lr, r0\nit cc\nblcc exceptionFun\nmovw r0, $2\nmovt r0, $3\ncmp lr, r0\nit cs\nblcs exceptionFun\n";*/
      InlineAsm* ptr_asm = InlineAsm::get(FuncTy_1,asmString,
       "~{dirflag},~{fpsr},~{flags}",true)
      std::vector<Value*> asm_params
     CallInst* asmCall = CallInst::Create(ptr_asm, asm_params, "", Inst);
     asmCall->setCallingConv(CallingConv::C);
     asmCall->setTailCall(false);
     AttributeSet asm_PAL;
     {
      SmallVector<AttributeSet, 4> Attrs;
      AttributeSet PAS;
      {
        AttrBuilder B;
        B.addAttribute(Attribute::NoUnwind);
        PAS = AttributeSet::get(mod->getContext(), ~0U, B);
      }

     Attrs.push_back(PAS);
     asm_PAL = AttributeSet::get(mod->getContext(), Attrs);

     }
      asmCall->setAttributes(asm_PAL);
    }
}

//Put checks before indirect branches and returns in all functions that 
//belong to section "sectionList[0]". The checks make sure that the branchs
//are within the list of sections "sectionList"
void instrumentIndirects(Module *mod, std::vector<std::string> sectionList){

  //Go through the functions in the driver section looking for
  //indirect branches and returns. Add checks before indirect branches
  for(Module::iterator F = mod->begin(); F != mod->end(); F++){
    if(F->getSection().compare(sectionList[0]) == 0){
      errs() << F->getName() << "\n";
      for(Function::iterator BB = F->begin(), E = F->end(); BB != E; ){
        BasicBlock *B = BB++;
         //errs() << *B << "\n";
        for(BasicBlock::iterator I = B->begin(), IE = B->end(); I != IE; ) {
          Instruction *II = I;

          //if(std::find(visitedInsts.begin(), visitedInsts.end(), II ) == visitedInsts.end()){
          if(IndirectBrInst* Inst = dyn_cast<IndirectBrInst>(II)){
            errs() << "Found indirect branch:" << "\n";
            errs() << *II;
            insertChecks(mod,F,II,sectionList,false, false);
            break;
          }
          
          else if(CallInst* Inst = dyn_cast<CallInst>(II)){
            if((!Inst->isInlineAsm()) && (Inst->getCalledFunction() == NULL)){  //Indirect function call 
              errs() << "Found indirect call:" << "\n";
              //errs() << *I;
              insertChecks(mod,F,II,sectionList,false, false);
              break;
            }

            else
              ++I;
          } 

          else
            ++I;
        }
      }
    }
  }
}

void instrumentReturns(Module *mod, std::vector<std::string> sectionList, bool driver){

  //TODO: replace 
  for(Module::iterator F = mod->begin(); F != mod->end(); F++){
    //sectionList[0] is the base section the function blongs to. The rest sections 
    //in the list are sections the function has access to
    //errs() << F->getName() << " ------ " << F->getSection() << "\n";
    //TODO:replace
     if(F->getSection().compare(sectionList[0]) == 0){
      //for(unsigned i=0; i < EntryFuns.size(); i++){
        //Function *F = mod->getFunction(EntryFuns[i]);
        errs() << F->getName() << ":\n";

        if(!F->empty()){
        ConstantInt* ci = ConstantInt::get(mod->getContext(), APInt(32, StringRef("0"), 10));
        //Get end basic block
        BasicBlock *BB = &(F->back());
        //Get return instruction
        if(BB){
          Instruction *Inst = BB->getTerminator();

          assert(Inst);
          insertChecks(mod, F, Inst,sectionList, driver, true);
        }
      }
      }
       //}     
    }
}

void generateGateways(Module *mod, std::string modName, unsigned int MN){


  ConstantInt* const_int32_0 = ConstantInt::get(IntegerType::get(mod->getContext(), 32), MN);
  ConstantInt* const_int32_1 = ConstantInt::get(IntegerType::get(mod->getContext(), 32), EXIT_SVC);

  // Type Definitions
 std::vector<Type*>FuncTy_0_args;
 FuncTy_0_args.push_back(IntegerType::get(mod->getContext(), 32));
 FuncTy_0_args.push_back(IntegerType::get(mod->getContext(), 32));
 FunctionType* FuncTy_0 = FunctionType::get(
  /*Result=*/Type::getVoidTy(mod->getContext()),
  /*Params=*/FuncTy_0_args,
  /*isVarArg=*/false);

 std::string funName = "gateway_" + modName;

 
 Function* func_gateway = mod->getFunction(funName);
 if (!func_gateway) {
 func_gateway = Function::Create(
  /*Type=*/FuncTy_0,
  /*Linkage=*/GlobalValue::ExternalLinkage,
  /*Name=*/funName, mod); 
 func_gateway->setCallingConv(CallingConv::C);
 func_gateway->setSection(".text.usfi");
 }
 AttributeSet func_gateway_PAL;
 {
  SmallVector<AttributeSet, 4> Attrs;
  AttributeSet PAS;
   {
    AttrBuilder B;
    B.addAttribute(Attribute::NoUnwind);
    B.addAttribute(Attribute::UWTable);
    PAS = AttributeSet::get(mod->getContext(), ~0U, B);
   }
  
  Attrs.push_back(PAS);
  func_gateway_PAL = AttributeSet::get(mod->getContext(), Attrs);
  
 }
 func_gateway->setAttributes(func_gateway_PAL);

 {
  
  BasicBlock* label_entry = BasicBlock::Create(mod->getContext(), "entry",func_gateway,0);
  std::string asmString;

  //Save lr
  asmString = "\tpush {lr}\n";

  //Entry SVC
  asmString = asmString + "\tsvc $0 \n";

  //Insert instructions that check bounds of target address
  //"r4" contains target address
  asmString = asmString + "boundcheckstart.gateway" +  ".text.module." + modName + ".ret:\n";
  asmString = asmString + "\tpush {r0}\n \tmovw r0, #9999\n \tmovt r0, #8888\n \tcmp r4," 
              "r0\n \tit cc\n\tblcc exceptionFun\n \tmovw r0, #7777\n \tmovt r0, #6666\n \tcmp r4," 
              "r0\n \tit cs\n \tblcs exceptionFun\n \tpop {r0}\n";

  asmString = asmString + "boundcheckend.gateway" +  ".text.module." + modName + ".ret:\n";


  //Call function
  asmString = asmString + "\t blx r4\n";

  asmString = asmString + ".global gateway_ret_" + modName + "\n"; 
  asmString = asmString + "gateway_ret_" + modName + ":\n";  

  //Exit SVC
  asmString = asmString + "\tsvc $1 \n";


  //Restore lr
  asmString = asmString + "\tpop {lr}\n";
  
  // Block entry (label_entry)
  InlineAsm* ptr_3 = InlineAsm::get(FuncTy_0, asmString, "i,i,~{dirflag},~{fpsr},~{flags}",true);

  std::vector<Value*> void_29_params;
  void_29_params.push_back(const_int32_0);
  void_29_params.push_back(const_int32_1);

  CallInst* void_2 = CallInst::Create(ptr_3, void_29_params, "", label_entry);
  void_2->setCallingConv(CallingConv::C);
  void_2->setTailCall(false);
  AttributeSet void_2_PAL;
  {
   SmallVector<AttributeSet, 4> Attrs;
   AttributeSet PAS;
    {
     AttrBuilder B;
     B.addAttribute(Attribute::NoUnwind);
     PAS = AttributeSet::get(mod->getContext(), ~0U, B);
    }
   
   Attrs.push_back(PAS);
   void_2_PAL = AttributeSet::get(mod->getContext(), Attrs);
   
  }
  void_2->setAttributes(void_2_PAL);
  
  ReturnInst::Create(mod->getContext(), label_entry);
  
 }
}

virtual bool runOnModule(Module &M) {

  bool changed = false;
  CallGraphNode *Node;
  std::vector<std::string> sectionList;
  bool driver = false;

  callG = &getAnalysis<CallGraph>();

  /* Set a new section name */
  std::string secName;
  switch(SectionType){
    case t:
    secName = ".text.module.";
    break;

    case l:
    secName = ".text.lib.";
    break;

    case d:
    secName = ".text.module.";
    driver = true;
    break;
  }
  secName = secName + SectionName;


  if(SectionType == l){
    //Go through all functions and instrument 
    //indirects and returns
    taskSections.push_back(secName);

    //First change section names
    for(Module::iterator F = M.begin(); F != M.end(); F++){
      F->setSection(secName);
    }
  }

  else{
    if(std::find(taskSections.begin(), taskSections.end(), secName ) == taskSections.end()) /* If not already added */
    taskSections.push_back(secName);
    /* Find entry functions, go through the call graph and change text section names 
    of associated functions to custom section names.                 */
    for(unsigned i=0; i < EntryFuns.size(); i++){
      if(Function *F = M.getFunction(EntryFuns[i])){
        errs() << "Fun:" << F->getName() << "\n";
    
        /* Change section name of task entry function */
        F->setSection(secName);
        /* Set section names of other functions called by the function */
        if((Node = callG->operator[](F))){
          /* Find all children nodes */
          getAllNodes(Node, secName);
        }
      }
    }

    for(unsigned i=0; i<taskSections.size(); i++)
      errs() << taskSections[i] << "\n";
        //sectionList.push_back(*it);
      //Instrument indirect branches and returns inside main task sections
      //TODO: Instrument functions inside shared sections
    declareSectionVariables(&M, taskSections, driver);
    instrumentIndirects(&M, taskSections);
    instrumentReturns(&M, taskSections, driver);
    generateGateways(&M, SectionName, ModuleNumber);
  }

  changed = true;

  return changed;
}

void getAnalysisUsage(AnalysisUsage &AU) const{
  AU.addRequired<CallGraph>();
}

}; //struct

} //namespace

char TaskAttribute::ID = 0;
static RegisterPass<TaskAttribute> X("task-attribute", "Sets section attribute for task functions", false, false);
