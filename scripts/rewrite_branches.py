#Changes calls to given functions to calls to a provided gateway function
#This one replaces "bl" instructions of ARM

from optparse import OptionParser
import linecache

#get input arguments
#-f "filename" -s "list of symbols" -n "new_symbol" -o "output filename"
#Inputs:
#Input assembly file name
#List of symbols (functions) to modify
#New symbol
#Output file name
parser = OptionParser()
parser.add_option("-i", "--file", type="string", dest="filename",
                  help="input llvm assembly file", metavar="FILE")
parser.add_option("-o", "--outputfile", type="string", dest="outputfilename",
                  help="output llvm assembly file")
parser.add_option("-F", "--symbol", type="string", dest="symbols",
                  help="list of symbols", action="append")
parser.add_option("-n", "--nsymbol", type="string", dest="newsymbol",
                  help="new symbol")

(options, args) = parser.parse_args()

def getCallAsm(funName, newFun):
	asmString = "\t push {r4} \n" + "\t movw r4, :lower16:" + funName + "\n" \
	"\t movt r4, :upper16:" + funName + "\n" \
	"\t bl " + newFun + "\n" + "\t pop {r4} \n"

	return asmString





def getFunction(file, linenum):
	#go backwards looking for the function name
	line = linecache.getline(file.name, linenum)
	while ("@ @" not in line):
		linenum = linenum - 1
		line = linecache.getline(file.name, linenum)

	#extract function name
	nline = line.split("@")
	#remove newline
	ret = nline[2].split("\n")
	return ret[0]


#Open assembly file
with open(options.filename, 'r') as file, open(options.outputfilename, 'w') as outputfile:
#Go through file line by line looking for 
#calls to functions in the list (bl func_name)
#for line in filedata.splitlines():
	for linenum, line in enumerate(file,1):
		if "bl" in line:
			nline = line.strip()
			#split line into two with tab
			sline = nline.split("\t",1)
			#Make sure it is a 'bl' instruction
			if sline[0] == "bl":
				if sline[1] in options.symbols:
					#get caller function
					fun = getFunction(file, linenum)
					#print "fun:", fun
					#print "called fun", sline[1]
					#if called function is not in the same section as the caller
					if (fun not in options.symbols):
						#change symbol with the new symbol
						#newsymbol = "gateway_" + sline[1]
						#newline = line.replace(sline[1], newsymbol)
						newline = getCallAsm(sline[1], options.newsymbol)
						outputfile.write(newline)
						#print "Replaced",sline[1],"at line",linenum
					else:
						#print "found call to same section"
						#print linenum, ":", fun
						outputfile.write(line)
				else:
					outputfile.write(line)
			else:
				outputfile.write(line)
		else:
			outputfile.write(line)
