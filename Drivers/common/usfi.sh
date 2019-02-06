#!/bin/bash

SRC_DIR=src
SRC=$(find $SRC_DIR -name '*.c')
INCS="-I./inc -ICMSIS/Include -I../gpio/inc -I../../common/inc"

DRIVER_FUN="-F HAL_RCC_DeInit -F HAL_RCC_OscConfig -F HAL_RCC_ClockConfig -F HAL_RCC_MCOConfig \
-F HAL_RCC_EnableCSS -F HAL_RCC_DisableCSS -F HAL_RCC_GetSysClockFreq -F HAL_RCC_GetHCLKFreq \
-F HAL_RCC_GetPCLK1Freq -F HAL_RCC_GetPCLK2Freq -F HAL_RCC_GetOscConfig -F HAL_RCC_GetClockConfig \
-F HAL_RCC_NMI_IRQHandler -F HAL_RCC_CSSCallback -F HAL_IncTick -F HAL_Delay -F HAL_GetTick -F HAL_SuspendTick \
-F HAL_ResumeTick -F HAL_GetHalVersion -F HAL_GetREVID -F HAL_GetDEVID -F HAL_Delay"


export PRIV_FUNS=$DRIVER_FUN


rm -r *bc

#Generate llvm bitcode files from source files
for file in $SRC
do
	clang -emit-llvm -c $file $INCS -o $file.bc
done


#Link bitcode files
llvm-link -o combined.bc $(find $SRC_DIR -name '*.bc') 

rm -r $SRC_DIR/*bc
