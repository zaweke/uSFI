/*
 * uSFI Project
 * Syscall handler for stm32f4xx devices
 *
 * Author: Zelalem Aweke (zaweke@umich.edu)
 */


/** 
  ******************************************************************************
  * @file    GPIO/GPIO_IOToggle/Src/stm32f4xx_it.c
  * @author  MCD Application Team
  * @version V1.0.2
  * @date    06-May-2016
  * @brief   Main Interrupt Service Routines.
  *          This file provides template for all exceptions handler and
  *          peripherals interrupt service routine.
  ******************************************************************************
  * @attention
  *
  * <h2><center>&copy; COPYRIGHT(c) 2016 STMicroelectronics</center></h2>
  *
  * Redistribution and use in source and binary forms, with or without modification,
  * are permitted provided that the following conditions are met:
  *   1. Redistributions of source code must retain the above copyright notice,
  *      this list of conditions and the following disclaimer.
  *   2. Redistributions in binary form must reproduce the above copyright notice,
  *      this list of conditions and the following disclaimer in the documentation
  *      and/or other materials provided with the distribution.
  *   3. Neither the name of STMicroelectronics nor the names of its contributors
  *      may be used to endorse or promote products derived from this software
  *      without specific prior written permission.
  *
  * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
  * AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
  * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
  * DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE
  * FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
  * DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
  * SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
  * CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
  * OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
  * OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
  *
  ******************************************************************************
  */

/* Includes ------------------------------------------------------------------*/
#include <stdio.h>
#include <stdlib.h>
#include "stm32f4xx_it.h"
#include "stm32f4xx_hal.h"
#include "usfi.h"

/** @addtogroup STM32F4xx_HAL_Examples
  * @{
  */

/** @addtogroup GPIO_IOToggle
  * @{
  */

/* Private typedef -----------------------------------------------------------*/
/* Private define ------------------------------------------------------------*/
/* Private macro -------------------------------------------------------------*/
/* Private variables ---------------------------------------------------------*/

/* Private function prototypes -----------------------------------------------*/
/* Private functions ---------------------------------------------------------*/

 void SVC_Handler(void) __attribute__ (( naked )) __attribute__ ((section (".text.usfi")));
 void SVC_Handler_main(unsigned int * svc_args);


/******************************************************************************/
/*            Cortex-M4 Processor Exceptions Handlers                         */
/******************************************************************************/

/**
  * @brief  This function handles NMI exception.
  * @param  None
  * @retval None


  */
void NMI_Handler(void)
{
}

/**
  * @brief  This function handles Hard Fault exception.
  * @param  None
  * @retval None
  */
void HardFault_Handler(void)
{
  /* Go to infinite loop when Hard Fault exception occurs */
  while (1)
  {
  }
}

/**
  * @brief  This function handles Memory Manage exception.
  * @param  None
  * @retval None
  */
void MemManage_Handler(void)
{
  /* Go to infinite loop when Memory Manage exception occurs */
  while (1)
  {
  }
}

/**
  * @brief  This function handles Bus Fault exception.
  * @param  None
  * @retval None
  */
void BusFault_Handler(void)
{
  /* Go to infinite loop when Bus Fault exception occurs */
  while (1)
  {
  }
}

/**
  * @brief  This function handles Usage Fault exception.
  * @param  None
  * @retval None
  */
void UsageFault_Handler(void)
{
  /* Go to infinite loop when Usage Fault exception occurs */
  while (1)
  {
  }
}

/**
  * @brief  This function handles SVCall exception.
  * @param  None
  * @retval None
  */
void SVC_Handler(void)
{
  __asm volatile
  (
      " mrs r0, psp \n"
      " b %0  \n"
      ::"i"(SVC_Handler_main):
  );

}

/**
 * @brief The real function that handles SVCall exceptions.
 * @param 
 */
void SVC_Handler_main(unsigned int * svc_args){
    uint8_t svc_number;
    unsigned int i;
    /*
    * Stack contains:
    * r0, r1, r2, r3, r12, r14, the return address and xPSR
    * First argument (r0) is svc_args[0]
    */

    /* Get SVC number */
    svc_number = ((uint8_t *)svc_args[6])[-2];
    /* r0 in stack holds address of the function 
    to call */
    //void* br_address = svc_args[0];
    uint32_t offset = svc_number*sizeof(xMODULE_SETTINGS);
    switch(svc_number)
    {
        /* Handle exit calls.
        * Exit from a module. This syscall is issued 
        when a callee module returns to a different caller 
        module.
        *
        * This piece of code restores module configuration 
        * to the caller modules 
        * ( MPU configuration + module stack)
        * */

        case EXIT_SVC:
          
          __asm volatile (
           " ldr r1, =moduleSettingStackPtr \n"

           " ldr r2, [r1]   \n" /* moduleSettingStackPtr-=1 */
           " subs r2, #24   \n"
           " str  r2, [r1]  \n" 

           //First round
           " ldmia r2!, {r0-r1,r3-r6,r8-r10}  \n"
           " ldr r11, =0xe000ed9c \n" /*Region Base Address register. */
           " stmia r11!,  {r1,r3-r5}  \n"

          /* Copy old stack to the new one */
           " mrs r1, psp  \n"
           " msr psp, r0 \n" /* update stack pointer */
           " ldmia r1!, {r3-r6,r8-r11}  \n"
           " stmia r0!, {r3-r6,r8-r11}  \n"

           //Second round
           // .. 
           // r10 = privilege bit
           " ldmia r2!, {r0-r1,r3-r6,r8-r10}  \n"
           " msr control, r10 \n" /* set privilege level */

          ::"r"(offset):"r0","r1","r2","r3","r4","r5","r6","r8","r9","r10", "r11");

          break;
        
        /* Handle other syscalls.
        These are used to swith to other modules.
        *
        * TODO: check that
          the function pointer points to a function 
          exported by the callee module 
        */
        default: 

        __asm volatile (
           " ldr r12, =moduleSettingListPtr  \n"
           " ldr r1, =moduleSettingStackPtr \n"

           " ldr r12, [r12]   \n" /*moduleSettingList*/
           " add r12, %0     \n" /*now r0 points to moduleSettingList[svc_number]*/

           /* Save stack pointer of old stack */
           /* moduleSettingStack[moduleSettingStackPtr].stackPointer = psp + 28*4 */

           " ldr r2, [r1] \n" 

           " mrs r3, psp  \n"
           " str r3, [r2] \n"

           " adds r2, #24   \n" /* moduleSettingStackPtr+=1 */
           " str  r2, [r1]  \n" 

           //There are 18 elements in the setting
           //(16 MPU config values, stack pointer 
           //and privilege bit)
           //The configuration needs to be done in
           //two rounds


           // r0 = stack pointer
           // r1 = Region 0 base address register
           // r2 = Region 0 attribute register
           // r3 = Region 1 base address register
           // r4 = Region 1 attribute register 
           // ...

           //First round
           " ldmia r12!, {r0-r1,r3-r6,r8-r10}  \n"
           " stmia r2!,  {r0-r1,r3-r6,r8-r10}  \n"

           " ldr r11, =0xe000ed9c \n" /*Region Base Address register. */
           " stmia r11!,  {r1,r3-r5} \n"

           /* Copy old stack to the new one */
           //r0 = new stack pointer
           " mrs r1, psp  \n"
           " sub r0, r0, #32  \n"
           " msr psp, r0  \n"

           /* copy data from the old stack to 
           the new stack */
           " ldmia r1!, {r3-r6,r8-r11}  \n"
           " stmia r0!, {r3-r6,r8-r11}  \n"

           //Second round
           // .. 
           // r10 = privilege bit
           " ldmia r12!, {r0-r1,r3-r6,r8-r10}  \n"
           " stmia r2!,  {r0-r1,r3-r6,r8-r10}  \n"

           " msr control, r10 \n" /* set privilege level */

          ::"r"(offset):"r0","r1","r2","r3","r4","r5","r6","r8","r9","r10", "r11", "r12");
      
          break;
    }
}

/**
  * @brief  This function handles Debug Monitor exception.
  * @param  None
  * @retval None
  */
void DebugMon_Handler(void)
{
}

/**
  * @brief  This function handles PendSVC exception.
  * @param  None
  * @retval None
  */
void PendSV_Handler(void)
{
}

/**
  * @brief  This function handles SysTick Handler.
  * @param  None
  * @retval None
  */
void SysTick_Handler(void)
{
  HAL_IncTick();
}

/******************************************************************************/
/*                 STM32F4xx Peripherals Interrupt Handlers                   */
/*  Add here the Interrupt Handler for the used peripheral(s) (PPP), for the  */
/*  available peripheral interrupt handler's name please refer to the startup */
/*  file (startup_stm32f4xx.s).                                               */
/******************************************************************************/

/**
  * @brief  This function handles PPP interrupt request.
  * @param  None
  * @retval None
  */
/*void PPP_IRQHandler(void)
{
}*/


/**
  * @}
  */

/**
  * @}
  */

/************************ (C) COPYRIGHT STMicroelectronics *****END OF FILE****/
