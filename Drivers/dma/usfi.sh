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
LLVM_PASS_PATH=.
SRC=$(find $SRC_DIR -name '*.c')
INCS="-I./inc -I../common/inc -I../common/CMSIS/Include -I../../common/inc"
DRI_NAME=dma
DRIVER_FUN="-F HAL_DMA_Init -F HAL_DMA_DeInit -F HAL_DMA_Start -F HAL_DMA_Start_IT -F HAL_DMA_Abort -F HAL_DMA_Abort_IT \
-F HAL_DMA_PollForTransfer -F HAL_DMA_IRQHandler -F HAL_DMA_CleanCallbacks -F HAL_DMA_RegisterCallback -F HAL_DMA_UnRegisterCallback \
-F HAL_DMA_GetState -F HAL_DMA_GetError -F DMA_SetConfig -F DMA_CalcBaseAndBitshift -F DMA_CheckFifoParam" 
# MCU FLAGS
MCFLAGS="-mcpu=cortex-m4 -mthumb -mlittle-endian -mfpu=fpv4-sp-d16 -mfloat-abi=hard -mthumb-interwork"

export DMA_FUNS=$DRIVER_FUN

rm  *bc

#Generate llvm bitcode files from source files
for file in $SRC
do
	clang -emit-llvm -c $file $INCS -o $file.bc
done


#Link bitcode files
llvm-link -o combined.bc $(find $SRC_DIR -name '*.bc') 

if [ $1 = "USFI_PASS" ]; then
#Task anotate pass
opt -load  $LLVM_PASS_PATH/task-attribute.so -task-attribute -d $DRIVER_FUN -n $DRI_NAME -m 11 <combined.bc> combined_$DRI_NAME.bc


rm combined.bc
fi
rm -r $SRC_DIR/*bc
