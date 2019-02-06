#!/bin/bash

#
# uSFI Project
# Compiler script for driver code  
#
# Author: Zelalem Aweke (zaweke@umich.edu)
#

#Script takes two arguments:
#First argument is a flag that indicates usfi pass
#Second argument is module number

SRC_DIR=src
#Set this to the right path
LLVM_PASS_PATH=.
SRC=$(find $SRC_DIR -name '*.c')
INCS="-I./inc -I../common/inc -I../../common/inc -I../common/CMSIS/Include "
DRI_NAME=gpio
#Stopped the error in openocd
DRIVER_FUN="-F HAL_GPIO_Init -F HAL_GPIO_DeInit -F HAL_GPIO_ReadPin -F HAL_GPIO_WritePin \
-F HAL_GPIO_TogglePin -F HAL_GPIO_LockPin -F HAL_GPIO_EXTI_IRQHandler -F HAL_GPIO_EXTI_Callback"


 

export GPIO_FUNS=$DRIVER_FUN

# MCU FLAGS
MCFLAGS="-mcpu=cortex-m4 -mthumb -mlittle-endian -mfpu=fpv4-sp-d16 -mfloat-abi=hard -mthumb-interwork"

rm *bc

#Generate llvm bitcode files from source files
for file in $SRC
do
	clang -emit-llvm -c $file $INCS -o $file.bc
done


#Link bitcode files
llvm-link -o combined.bc $(find $SRC_DIR -name '*.bc') 

if [ $1 = "USFI_PASS" ]; then
#Task anotate pass
opt -load  $LLVM_PASS_PATH/task-attribute.so -task-attribute -d $DRIVER_FUN -n $DRI_NAME -m 10 <combined.bc> combined_$DRI_NAME.bc

rm combined.bc
fi
rm -r $SRC_DIR/*bc
