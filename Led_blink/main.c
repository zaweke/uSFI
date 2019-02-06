
/*
 * uSFI Project
 * POC code for LED Blink/UART communication  
 *
 * Author: Zelalem Aweke (zaweke@umich.edu)
 */

#include <stdint.h>
#include <string.h>
#include <stdlib.h>
#include <stdio.h>

#include "main.h"
#include "usfi.h"



/* IO access permission configurations */
#define GPIOA_REGION_BASE	    0x40020012 
#define GPIOA_REGION_ATTRIB	  0x13000013
#define USART2_REGION_BASE	  0x40004412 
#define USART2_REGION_ATTRIB  0x13000013


static void SystemClock_Config(void);

/* Module function prototypes 
*
* Here we have two modules - gpio and uart.
* The gpio module has access to GPIOA peripheral and
* uart module has access to UART2 peripheral */

/* Functions for gpio module */
void initGPIO() __attribute__ ((section (".text.module.gpio")));
void toggleLED() __attribute__ ((section (".text.module.gpio")));

/* Functions for uart module */
void initUART(UART_HandleTypeDef* huart2) __attribute__ ((section (".text.module.uart")));
void sendMsg(UART_HandleTypeDef *huart, char *msg)__attribute__ ((section (".text.module.uart")));

/* Public variables */
GPIO_InitTypeDef UGPIO_InitStruct __attribute__ ((section (".data.public")));
UART_HandleTypeDef huart2 __attribute__ ((section (".data.public")));
char *msg __attribute__ ((section (".data.public"))); 

/* Initialize GPIO pin for LED */
void initGPIO(){
  GPIO_InitTypeDef  GPIO_InitStruct;

  GPIO_InitStruct.Mode  = GPIO_MODE_OUTPUT_PP;
  GPIO_InitStruct.Pull  = GPIO_PULLUP;
  GPIO_InitStruct.Speed = GPIO_SPEED_FREQ_VERY_HIGH;

  GPIO_InitStruct.Pin = GPIO_PIN_5;
  HAL_GPIO_Init(GPIOA, &GPIO_InitStruct);
}

/* Toggle LED */
void toggleLED(){
   HAL_GPIO_TogglePin(GPIOA, GPIO_PIN_5);
   HAL_Delay(1000);
}

/* Initialize UART2 */
void initUART(UART_HandleTypeDef* huart2){

  UGPIO_InitStruct.Pin = GPIO_PIN_2 | GPIO_PIN_3;
  UGPIO_InitStruct.Mode = GPIO_MODE_AF_PP;
  UGPIO_InitStruct.Pull = GPIO_NOPULL;
  UGPIO_InitStruct.Speed = GPIO_SPEED_LOW;
  UGPIO_InitStruct.Alternate = GPIO_AF7_USART2 ;

  HAL_GPIO_Init(GPIOA, &UGPIO_InitStruct);

  huart2->Instance = USART2;
  huart2->Init.BaudRate = 9600;
  huart2->Init.WordLength = UART_WORDLENGTH_8B;
  huart2->Init.StopBits = UART_STOPBITS_1;
  huart2->Init.Parity = UART_PARITY_NONE;
  huart2->Init.Mode = UART_MODE_TX_RX;
  huart2->Init.HwFlowCtl = UART_HWCONTROL_NONE;

  HAL_UART_Init(huart2);
}

/* Send message over UART port */
void sendMsg(UART_HandleTypeDef *huart, char *msg){
  HAL_UART_Transmit(huart, (uint8_t*)msg, strlen(msg), 0xFFFF);
  HAL_UART_Transmit(huart, "\r\n", 2, 0xFFFF);
}

int main(void)
{

  msg = "Hello uSFI!";

  /* At this point we are in privileged mode */

  /* Initialize HAL library */
  HAL_Init();

  /* Configure the system clock */
  SystemClock_Config();
  
  /* -1- Enable GPIO Clock (to be able to program the configuration registers) */
  __HAL_RCC_GPIOA_CLK_ENABLE();
  __HAL_RCC_USART2_CLK_ENABLE();

  /* Stacks for the "main" module and the two other modules */
  static uint32_t main_stack[128] __attribute__ ((section (".process_stack")));
  static uint32_t module_stack[128] __attribute__ ((section (".process_stack")));
  static uint32_t uart_stack[128] __attribute__ ((section (".process_stack")));

  /* IO access permission vectors for the two modules */
  xPERMISSION_IO permissionGPIO[1] = {{GPIOA_REGION_BASE,GPIOA_REGION_ATTRIB}};
  xPERMISSION_IO permissionUART[1] = {{USART2_REGION_BASE,USART2_REGION_ATTRIB}};

  /* Create gpio module */
  createModule(10, module_stack, 128, &permissionGPIO,1,0);

  /* Create uart module */
  //TODO: This module is currently running as privileged,
  //Fix bug that arises when it runs as unprivileged 
  createModule(11, uart_stack, 128, &permissionUART,1,1);

  /* Initialize uSFI with main_stack */
  initUSFI(main_stack, 128);


  /* Set the stack pointer to point to main_stack */
  if(main_stack!= NULL){
    uint32_t currStack = ( uint32_t ) (main_stack);
    __asm volatile
    (
      " msr psp, %0   \n"
      ::"r"(currStack):);
  }

  /* Switch to unprivileged mode */
  __asm volatile
  (
    " mov r0, #3    \n"
    " msr control, r0  \n"
    " isb       \n"
    :::);

  /* The rest of the code */
  initGPIO();
  initUART(&huart2);

  /* Loop forever */
  while (1)
  {
    toggleLED();
    sendMsg(&huart2, msg);
  }
}


/* The code below is taken from STMicroelectronics */

/**
  * @brief  System Clock Configuration
  *         The system Clock is configured as follow : 
  *            System Clock source            = PLL (HSE)
  *            SYSCLK(Hz)                     = 180000000
  *            HCLK(Hz)                       = 180000000
  *            AHB Prescaler                  = 1
  *            APB1 Prescaler                 = 4
  *            APB2 Prescaler                 = 2
  *            HSE Frequency(Hz)              = 8000000
  *            PLL_M                          = 8
  *            PLL_N                          = 360
  *            PLL_P                          = 2
  *            PLL_Q                          = 7
  *            PLL_R                          = 2
  *            VDD(V)                         = 3.3
  *            Main regulator output voltage  = Scale1 mode
  *            Flash Latency(WS)              = 5
  * @param  None
  * @retval None
  */
static void SystemClock_Config(void)
{
  RCC_ClkInitTypeDef RCC_ClkInitStruct;
  RCC_OscInitTypeDef RCC_OscInitStruct;
  HAL_StatusTypeDef ret = HAL_OK;

  /* Enable Power Control clock */
  __HAL_RCC_PWR_CLK_ENABLE();

  /* The voltage scaling allows optimizing the power consumption when the device is 
     clocked below the maximum system frequency, to update the voltage scaling value 
     regarding system frequency refer to product datasheet.  */
  //__HAL_PWR_VOLTAGESCALING_CONFIG(PWR_REGULATOR_VOLTAGE_SCALE1);

  /* Enable HSE Oscillator and activate PLL with HSE as source */
  RCC_OscInitStruct.OscillatorType = RCC_OSCILLATORTYPE_HSE;
  RCC_OscInitStruct.HSEState = RCC_HSE_BYPASS;
  RCC_OscInitStruct.PLL.PLLState = RCC_PLL_ON;
  RCC_OscInitStruct.PLL.PLLSource = RCC_PLLSOURCE_HSE;
  RCC_OscInitStruct.PLL.PLLM = 8;
  RCC_OscInitStruct.PLL.PLLN = 360;
  RCC_OscInitStruct.PLL.PLLP = RCC_PLLP_DIV2;
  RCC_OscInitStruct.PLL.PLLQ = 7;
  RCC_OscInitStruct.PLL.PLLR = 2;
  
  ret = HAL_RCC_OscConfig(&RCC_OscInitStruct);
  if(ret != HAL_OK)
  {
    while(1) { ; }
  }
  
  /* Select PLL as system clock source and configure the HCLK, PCLK1 and PCLK2 clocks dividers */
  RCC_ClkInitStruct.ClockType = (RCC_CLOCKTYPE_SYSCLK | RCC_CLOCKTYPE_HCLK | RCC_CLOCKTYPE_PCLK1 | RCC_CLOCKTYPE_PCLK2);
  RCC_ClkInitStruct.SYSCLKSource = RCC_SYSCLKSOURCE_PLLCLK;
  RCC_ClkInitStruct.AHBCLKDivider = RCC_SYSCLK_DIV1;
  RCC_ClkInitStruct.APB1CLKDivider = RCC_HCLK_DIV4;  
  RCC_ClkInitStruct.APB2CLKDivider = RCC_HCLK_DIV2;  
  
  ret = HAL_RCC_ClockConfig(&RCC_ClkInitStruct, FLASH_LATENCY_5);
  if(ret != HAL_OK)
  {
    while(1) { ; }
  }
}

#ifdef  USE_FULL_ASSERT

/**
  * @brief  Reports the name of the source file and the source line number
  *         where the assert_param error has occurred.
  * @param  file: pointer to the source file name
  * @param  line: assert_param error line source number
  * @retval None
  */
void assert_failed(uint8_t *file, uint32_t line)
{
  /* User can add his own implementation to report the file name and line number,
     ex: printf("Wrong parameters value: file %s on line %d\r\n", file, line) */

  /* Infinite loop */
  while (1)
  {
  }
}
#endif
