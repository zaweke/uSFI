#/bin/bash

#
# uSFI Project
# Compiler script for Led blink example  
#
# Author: Zelalem Aweke (zaweke@umich.edu)
#

#Compile with uSFI enabled
MODE="USFI_PASS"

USFI_DIR=../uSFI
SRC__DIR_=.
DRI_DIR=../Drivers
DRI_COMMON_DIR=../Drivers/common/SRC_
COMMON_DIR=../common

USFI_SRC_=$(find $USFI_DIR -name '*.c')
SRC_=$(find $SRC__DIR_ -name '*.c')
DRIVER_SRC_=$(find $DRI_DIR -name '*.c')
DRIVER_COMMON_SRC_=$(find $DRI_COMMON_DIR -name '*.c')
COMMON_SRC_=$(find $COMMON_DIR -name '*.c')
SCRIPTS=$(find $DRI_DIR -name 'usfi.sh')

INCS_="-I. -I../Drivers/gpio/inc -I../Drivers/uart/inc -I../Drivers/dma/inc -I../Drivers/common/inc -I../Drivers/common/CMSIS/Include -I../common/inc -I../uSFI"

find $USFI_DIR -type f -name '*.o' -delete
find $SRC__DIR_ -type f -name '*.bc' -delete
find $SRC__DIR_ -type f -name '*.o' -delete
find $DRIVER_SRC_ -type f -name '*.bc' -delete
find $DRIVER_COMMON_SRC_ -type f -name '*.bc' -delete
find $COMMON_SRC_ -type f -name '*.bc' -delete


echo "Compiling uSFI API ..."
for file in $USFI_SRC_
do
	arm-none-eabi-gcc -g -mpure-code -mcpu=cortex-m4 -mlittle-endian -mthumb -mfloat-abi=hard -mfpu=fpv4-sp-d16 $INCS_ -c  $file -o $file.o
done


echo "Compiling Drivers ..."
#Run scripts in driver directories
CUR_DIR=$(pwd)
for file in $SCRIPTS
do
	directory=$(dirname $file)
	echo $directory
	cd $directory
	. usfi.sh $MODE
	cd $CUR_DIR
done

#Here we are manually adding 
#functions to modules
GPIO_FUNS+=" -F initGPIO"
UART_FUNS+=" -F initUART"
UART_FUNS+=" $DMA_FUNS"

DRIVER_FUNS=("$GPIO_FUNS" "$UART_FUNS")

#Gateway functions for each module
GATEWAYS=( "gateway_gpio" "gateway_uart")

for file in $SRC_
do
	clang -emit-llvm -c $file $INCS_ -o $file.bc
done


for file in $COMMON_SRC_
do
	clang -emit-llvm -c $file $INCS_ -o $file.bc
done


#Link bitcode files including driver bitcode files
llvm-link -o combined_annotated.bc $(find $SRC__DIR_ -name '*.bc') $(find $DRI_DIR -name '*.bc') $(find $COMMON_DIR -name '*.bc') 

#Compile to target assembly
llc -mtriple=thumb-none-eabi -mcpu=cortex-m4 -float-abi=hard -filetype=asm -o Led_blink.s combined_annotated.bc

echo "Replacing calls ..."
#Replace driver function calls with calls to a gateway functions
for ((i = 0; i < ${#DRIVER_FUNS[@]}; i++))
do
	mv Led_blink.s Led_blink_.s
	python ../scripts/rewrite_branches.py -i Led_blink_.s ${DRIVER_FUNS[$i]} -o Led_blink.s -n ${GATEWAYS[$i]}
done


echo "Finalizing return instrumentation ..."
#Finish up indirect branch/return instrumentation
python ../scripts/instrument_indirects.py -i Led_blink.s -o Led_blink_final.s

arm-none-eabi-gcc  -g -mpure-code -mcpu=cortex-m4 -mthumb -mfloat-abi=hard -mfpu=fpv4-sp-d16 -T stm32_flash.ld -o Led_blink.elf Led_blink_final.s startup_stm32f446xx.s $(find $USFI_DIR -name '*.o')

arm-none-eabi-objcopy -O binary Led_blink.elf Led_blink.bin

echo "Done compiling!"


