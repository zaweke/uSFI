#!/bin/bash

#
# uSFI Project
# Compiler script for driver code  
#
# Author: Zelalem Aweke (zaweke@umich.edu)
#

SRC_DIR=src
#Set this to the right path
LLVM_PASS_PATH=.
DRIVERS_DIR=..
SRC=$(find $SRC_DIR -name '*.c')
INCS="-I./inc -I../dma/inc -I../common/inc -I../common/CMSIS/Include -I../../common/inc"
DRI_NAME=uart
DRIVER_FUN="-F HAL_UART_Init -F HAL_HalfDuplex_Init -F HAL_LIN_Init -F HAL_MultiProcessor_Init \
-F HAL_UART_DeInit -F HAL_UART_MspDeInit -F HAL_UART_MspInit -F HAL_UART_Transmit -F HAL_UART_Receive \
-F HAL_UART_Transmit_IT -F HAL_UART_Receive_IT -F HAL_UART_Transmit_DMA -F HAL_UART_Receive_DMA -F HAL_UART_DMAPause \
-F HAL_UART_DMAResume -F HAL_UART_DMAStop -F HAL_UART_IRQHandler -F HAL_UART_TxCpltCallback -F HAL_UART_TxHalfCpltCallback \
-F HAL_UART_RxCpltCallback -F HAL_UART_RxHalfCpltCallback -F HAL_UART_ErrorCallback -F HAL_LIN_SendBreak -F HAL_MultiProcessor_EnterMuteMode \
-F HAL_MultiProcessor_ExitMuteMode -F HAL_HalfDuplex_EnableTransmitter -F HAL_HalfDuplex_EnableReceiver -F HAL_UART_GetState -F HAL_UART_GetError \
-F UART_EndTxTransfer -F UART_EndRxTransfer -F UART_DMATransmitCplt -F UART_DMAReceiveCplt -F UART_DMATxHalfCplt -F UART_DMARxHalfCplt \
-F UART_DMAError -F UART_DMAAbortOnError -F UART_Transmit_IT -F UART_EndTransmit_IT -F UART_Receive_IT -F UART_WaitOnFlagUntilTimeout \
-F UART_SetConfig"

export UART_FUNS=$DRIVER_FUN

# MCU FLAGS
MCFLAGS="-mcpu=cortex-m4 -mthumb -mlittle-endian -mfpu=fpv4-sp-d16 -mfloat-abi=hard -mthumb-interwork"

rm -r *bc

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
