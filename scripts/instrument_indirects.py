#Modify and rearrange bounds checking instructions for indirect branches and returns

from optparse import OptionParser

parser = OptionParser()
parser.add_option("-i", "--file", type="string", dest="filename",
                  help="input llvm assembly file", metavar="FILE")
parser.add_option("-o", "--outputfile", type="string", dest="outputfilename",
                  help="output llvm assembly file")


(options, args) = parser.parse_args()

def replacePop (inputFile):
	conditionCodes = ["popeq", "popne", "popcs", "pophs", "popcc","poplo", "popmi", "poppl", "popvs", "popvc", "pophi", "popls", "popge", "poplt", "popgt", "pople", "popal" ]
	with open(inputFile, 'r') as file, open("output.s", 'w') as outputfile:
		#for line in file:
		lines = file.readlines()
		i = 0
		while i < len(lines):
			#Look for end of bounds checking mark
			if "boundcheckend" in lines[i]:
				#Look for pop instruction until end of function
				#TODO: look for better identification of end of function
				while ".size" not in lines[i]:
					if "pop" in lines[i]:
						line = lines[i]
						nline = line.split()
						if 'pc}' in nline:
							#Check if it is a conditional pop instruction
							conditional = 0
							if nline[0][0:5] in conditionCodes:
								conditional = 1
								cond = nline[0][3:len(nline)]
								
								#Check for condition
								condCode = cond[0:2]
								
								#if condCode in conditionCodes:
									#Look for ifthen block. IT instruction should be 
									#within the previous three instructions
								j = i-1
								found = 0
								while j > i-4:
									opcode = lines[j].split()[0]
									if  (len(opcode) > 1) and (opcode[0:2] == "it"):
										newit = opcode + opcode[len(opcode)-1]
										lines[j] = lines[j].replace(opcode, newit)
										found = 1
									j = j-1
								if(found == 0):
									print "Conditional pop, w/o it block"
									exit()

							
							lines[i] = lines[i].replace("pc}", "lr}")

							if conditional == 1:
								cond = nline[0][3:5]
								#outputfile.write("\tbx" + cond + "\tlr\n")
								lines.insert(i+1,"\tbx" + cond + "\tlr\n")
							else:
								#outputfile.write("\tbx\tlr\n")
								lines.insert(i+1,"\tbx\tlr\n")
					i = i+1

			i = i+1

	#Write to file
		for line in lines:
			outputfile.write(line)
	return outputfile

def getRegister (epilog):
	regs = ["r0","r1","r2","r3"]
	for reg in regs:
		done = 1
		for line in epilog:
			if reg in line:
				done = 0
				break
		if(done):
			return reg
	print "No free registers!"
	return

def replaceRegCheck(checkseq, reg):
	defaultReg = "r0"
	newseq = []
	for line in checkseq:
		nline = line.replace(defaultReg, reg)
		newseq.append(nline)
	return newseq

def replaceAddressCheck(checkseq, modName, section, driver):
	startAddL = ":lower16:" + section +"_start" 
	startAddH = ":upper16:" + section +"_start" 
	endAddL = ":lower16:" + section +"_end"
	endAddH = ":upper16:" + section +"_end"
	gatewayL = ":lower16:" +  "gateway_ret_" + modName 
	gatewayH = ":upper16:" +  "gateway_ret_" + modName
	newseq = []
	for line in checkseq:
		if "#9999" in line:
			line = line.replace("#9999", startAddL)
		elif "#8888" in line:
			line = line.replace("#8888", startAddH)
		elif "#7777" in line:
			line = line.replace("#7777", endAddL)
		elif "#6666" in line:
			line = line.replace("#6666", endAddH)
		if driver:
			if "#5555" in line:
				line = line.replace("#5555", gatewayL)
			elif "#4444" in line:
				line = line.replace("#4444", gatewayH)
		newseq.append(line)
	return newseq




asmFile = replacePop(options.filename)
#Go through assembly file looking for 
#bounds checking instructions. These 
#are identified by the lables.
with open(asmFile.name, 'r') as file, open(options.outputfilename, 'w') as outputfile:
	#Number of instructions in the check sequence
	#N = 10

	lines = file.readlines()
	seq = 0;
	i = 0
	length = len(lines)
	while i < length:
		line = lines[i]
		if "boundcheckstart" in line:
			#get check sequence (next N instructions)
			cStart = i+1
			cEnd = i+1

			while "boundcheckend" not in lines[cEnd]:
				cEnd = cEnd + 1
			
			checkseq = lines[cStart : cEnd]  
			eStart = cEnd+1
			eEnd = eStart
			#j = i + 1
			skip = 0
			#Get instructions after check sequence ("epilog")
			while (("bx" not in lines[eEnd]) and ("blx" not in lines[eEnd])):
				#We reached a different bound check.
				#This happens when llc optimizes multiple indirect calls
				#into a single indirect call and multiple direct branches

				if "boundcheckstart" in lines[eEnd]:
					skip = 1
					#i = eEnd
					break
				else:
					eEnd = eEnd + 1
					#j = j+1
					#print lines[j]
					if(eEnd >= length):
						print "Reached end of line 0!"
						exit()

			if (skip == 0): #Indirect branch found

				#Lable is of the form:
				#boundcheckstart."function_name"."text.module.module_name"
				nline = line.split(".")
				functionName = nline[1]
				section = "." + nline[2] + "." + nline[3] + "." + nline[4]
				#checkseq = ['\tpush {r0}\n', '\tmovw r0, #9999\n', '\tmovt r0, #8888\n', '\tcmp lr, r0\n', '\tit cc\n', '\tblcc exceptionFun\n', 
				#'\tmovw r0, #7777\n', '\tmovt r0, #6666\n', '\tcmp lr, r0\n', '\tit cs\n', '\tblcs exceptionFun\n', '\tpop {r0}\n']
				
				epilog = lines[eStart:eEnd]
				#i = eEnd
				#print "epilog:", epilog
				#print "check sequence:", checkseq
				
				checkseq = replaceAddressCheck(checkseq, nline[4], section, 1)
				newseq = epilog + checkseq
				lines[cStart:eEnd-1] = newseq
				del lines[eEnd -1]
				length = len(lines)
		i = i+1

	#Write to file
	for line in lines:
		outputfile.write(line)
	

