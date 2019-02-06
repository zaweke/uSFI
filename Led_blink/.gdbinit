#OpenOCD GDB server, enable semihosting, program the flash, and wait for command
target extended localhost:3333
monitor arm semihosting enable
monitor reset halt
load
monitor reset halt

#Enable cycle counter
#set {int} 0xE0001000 = 0x40000001 

#Clear counter
#set {int} 0xE0001004 = 0 

#c
#x/d 0xE0001004

#monitor reset init





