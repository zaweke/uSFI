	.syntax unified
	.cpu	cortex-m4
	.eabi_attribute	6, 13
	.eabi_attribute	7, 77
	.eabi_attribute	8, 0
	.eabi_attribute	9, 2
	.fpu	vfpv4-d16
	.eabi_attribute	20, 1
	.eabi_attribute	21, 1
	.eabi_attribute	23, 3
	.eabi_attribute	24, 1
	.eabi_attribute	25, 1
	.eabi_attribute	27, 1
	.eabi_attribute	28, 1
	.eabi_attribute	36, 1
	.eabi_attribute	44, 0
	.file	"combined_annotated.bc"
	.section	.text.module.gpio,"ax",%progbits
	.globl	initGPIO
	.align	2
	.type	initGPIO,%function
	.code	16                      @ @initGPIO
	.thumb_func
initGPIO:
@ BB#0:                                 @ %entry
	push	{r7, lr}
	mov	r7, sp
	sub	sp, #24
	movs	r0, #1
	add	r1, sp, #4
	str	r0, [sp, #8]
	str	r0, [sp, #12]
	movs	r0, #3
	str	r0, [sp, #16]
	movs	r0, #32
	str	r0, [sp, #4]
	movs	r0, #0
	movt	r0, #16386
	bl	HAL_GPIO_Init
	add	sp, #24
	pop	{r7, pc}
.Ltmp0:
	.size	initGPIO, .Ltmp0-initGPIO

	.globl	toggleLED
	.align	2
	.type	toggleLED,%function
	.code	16                      @ @toggleLED
	.thumb_func
toggleLED:
@ BB#0:                                 @ %entry
	push	{r7, lr}
	movs	r0, #0
	movs	r1, #32
	mov	r7, sp
	movt	r0, #16386
	 push {r4} 
	 movw r4, :lower16:HAL_GPIO_TogglePin
	 movt r4, :upper16:HAL_GPIO_TogglePin
	 bl gateway_gpio
	 pop {r4} 
	mov.w	r0, #1000
	bl	HAL_Delay
	pop	{r7, pc}
.Ltmp1:
	.size	toggleLED, .Ltmp1-toggleLED

	.section	.text.module.uart,"ax",%progbits
	.globl	initUART
	.align	2
	.type	initUART,%function
	.code	16                      @ @initUART
	.thumb_func
initUART:
@ BB#0:                                 @ %entry
	push	{r4, r5, r7, lr}
	add	r7, sp, #8
	sub	sp, #8
	movw	r1, :lower16:UGPIO_InitStruct
	str	r0, [sp]
	movs	r4, #12
	movs	r0, #2
	movs	r5, #0
	movs	r2, #7
	movt	r1, :upper16:UGPIO_InitStruct
	str	r4, [r1]
	str	r0, [r1, #4]
	movs	r0, #0
	str	r5, [r1, #8]
	str	r5, [r1, #12]
	str	r2, [r1, #16]
	movt	r0, #16386
	 push {r4} 
	 movw r4, :lower16:HAL_GPIO_Init
	 movt r4, :upper16:HAL_GPIO_Init
	 bl gateway_gpio
	 pop {r4} 
	ldr	r0, [sp]
	movw	r1, #17408
	movt	r1, #16384
	str	r1, [r0]
	mov.w	r1, #9600
	ldr	r0, [sp]
	str	r1, [r0, #4]
	ldr	r0, [sp]
	str	r5, [r0, #8]
	ldr	r0, [sp]
	str	r5, [r0, #12]
	ldr	r0, [sp]
	str	r5, [r0, #16]
	ldr	r0, [sp]
	str	r4, [r0, #20]
	ldr	r0, [sp]
	str	r5, [r0, #24]
	ldr	r0, [sp]
	bl	HAL_UART_Init
	add	sp, #8
	pop	{r4, r5, r7, pc}
.Ltmp2:
	.size	initUART, .Ltmp2-initUART

	.globl	sendMsg
	.align	2
	.type	sendMsg,%function
	.code	16                      @ @sendMsg
	.thumb_func
sendMsg:
@ BB#0:                                 @ %entry
	push	{r4, r5, r7, lr}
	add	r7, sp, #8
	sub	sp, #16
	str	r0, [sp, #8]
	mov	r4, r1
	ldr	r5, [sp, #8]
	mov	r0, r4
	str	r4, [sp]
	bl	strlen
	uxth	r2, r0
	mov	r0, r5
	mov	r1, r4
	movw	r3, #65535
	 push {r4} 
	 movw r4, :lower16:HAL_UART_Transmit
	 movt r4, :upper16:HAL_UART_Transmit
	 bl gateway_uart
	 pop {r4} 
	ldr	r0, [sp, #8]
	movw	r1, :lower16:.L.str
	movs	r2, #2
	movw	r3, #65535
	movt	r1, :upper16:.L.str
	 push {r4} 
	 movw r4, :lower16:HAL_UART_Transmit
	 movt r4, :upper16:HAL_UART_Transmit
	 bl gateway_uart
	 pop {r4} 
	add	sp, #16
	pop	{r4, r5, r7, pc}
.Ltmp3:
	.size	sendMsg, .Ltmp3-sendMsg

	.text
	.globl	main
	.align	2
	.type	main,%function
	.code	16                      @ @main
	.thumb_func
main:
@ BB#0:                                 @ %do.end5
	push.w	{r4, r5, r6, r7, r11, lr}
	add	r7, sp, #12
	sub	sp, #40
	movw	r5, :lower16:msg
	movw	r0, :lower16:.L.str1
	movs	r4, #0
	movt	r5, :upper16:msg
	movt	r0, :upper16:.L.str1
	str	r4, [sp, #36]
	str	r0, [r5]
	bl	HAL_Init
	bl	SystemClock_Config
	movw	r0, #14384
	str	r4, [sp, #32]
	movs	r6, #1
	add	r3, sp, #20
	movs	r2, #128
	movt	r0, #16386
	ldr	r1, [r0]
	orr	r1, r1, #1
	str	r1, [r0]
	ldr	r0, [r0]
	and	r0, r0, #1
	str	r0, [sp, #32]
	ldr	r0, [sp, #32]
	str	r4, [sp, #28]
	movw	r0, #14400
	movt	r0, #16386
	ldr	r1, [r0]
	orr	r1, r1, #131072
	str	r1, [r0]
	ldr	r0, [r0]
	and	r0, r0, #131072
	str	r0, [sp, #28]
	ldr	r0, [sp, #28]
	str	r6, [sp]
	str	r4, [sp, #4]
	movw	r0, :lower16:.Lmain.permissionGPIO
	movt	r0, :upper16:.Lmain.permissionGPIO
	ldr	r1, [r0]
	ldr	r0, [r0, #4]
	str	r0, [sp, #24]
	movw	r0, :lower16:.Lmain.permissionUART
	str	r1, [sp, #20]
	movt	r0, :upper16:.Lmain.permissionUART
	ldr	r1, [r0]
	ldr	r0, [r0, #4]
	str	r0, [sp, #16]
	str	r1, [sp, #12]
	movw	r1, :lower16:main.module_stack
	movs	r0, #10
	movt	r1, :upper16:main.module_stack
	bl	createModule
	movw	r1, :lower16:main.uart_stack
	add	r3, sp, #12
	movs	r0, #11
	movs	r2, #128
	str	r6, [sp]
	str	r4, [sp, #4]
	movt	r1, :upper16:main.uart_stack
	bl	createModule
	movw	r4, :lower16:main.main_stack
	movs	r1, #128
	movt	r4, :upper16:main.main_stack
	mov	r0, r4
	bl	initUSFI
	str	r4, [sp, #8]
	@APP
	 msr psp, r4   

	@NO_APP
	@APP
	 mov r0, #3    
 msr control, r0  
 isb       

	@NO_APP
	 push {r4} 
	 movw r4, :lower16:initGPIO
	 movt r4, :upper16:initGPIO
	 bl gateway_gpio
	 pop {r4} 
	movw	r4, :lower16:huart2
	movt	r4, :upper16:huart2
	mov	r0, r4
	 push {r4} 
	 movw r4, :lower16:initUART
	 movt r4, :upper16:initUART
	 bl gateway_uart
	 pop {r4} 
.LBB4_1:                                @ %while.body
                                        @ =>This Inner Loop Header: Depth=1
	bl	toggleLED
	ldr	r1, [r5]
	mov	r0, r4
	bl	sendMsg
	b	.LBB4_1
.Ltmp4:
	.size	main, .Ltmp4-main

	.align	2
	.type	SystemClock_Config,%function
	.code	16                      @ @SystemClock_Config
	.thumb_func
SystemClock_Config:
@ BB#0:                                 @ %do.end
	push	{r4, r5, r7, lr}
	add	r7, sp, #8
	sub	sp, #80
	movw	r0, #14400
	movs	r4, #0
	movs	r5, #2
	str	r4, [sp, #4]
	str	r4, [sp]
	movt	r0, #16386
	ldr	r1, [r0]
	orr	r1, r1, #268435456
	str	r1, [r0]
	ldr	r0, [r0]
	and	r0, r0, #268435456
	str	r0, [sp]
	ldr	r0, [sp]
	movs	r0, #1
	str	r0, [sp, #8]
	movs	r0, #5
	str	r0, [sp, #12]
	mov.w	r0, #4194304
	str	r5, [sp, #32]
	str	r0, [sp, #36]
	movs	r0, #8
	str	r0, [sp, #40]
	mov.w	r0, #360
	str	r0, [sp, #44]
	movs	r0, #7
	str	r5, [sp, #48]
	str	r0, [sp, #52]
	add	r0, sp, #8
	str	r5, [sp, #56]
	bl	HAL_RCC_OscConfig
	str	r0, [sp, #4]
	cbz	r0, .LBB5_2
.LBB5_1:                                @ %while.body
                                        @ =>This Inner Loop Header: Depth=1
	b	.LBB5_1
.LBB5_2:                                @ %if.end
	movs	r0, #15
	movs	r1, #5
	str	r0, [sp, #60]
	mov.w	r0, #5120
	str	r5, [sp, #64]
	str	r4, [sp, #68]
	str	r0, [sp, #72]
	mov.w	r0, #4096
	str	r0, [sp, #76]
	add	r0, sp, #60
	bl	HAL_RCC_ClockConfig
	cmp	r0, #0
	str	r0, [sp, #4]
	itt	eq
	addeq	sp, #80
	popeq	{r4, r5, r7, pc}
.LBB5_3:                                @ %while.body10
                                        @ =>This Inner Loop Header: Depth=1
	b	.LBB5_3
.Ltmp5:
	.size	SystemClock_Config, .Ltmp5-SystemClock_Config

	.globl	SystemInit
	.align	2
	.type	SystemInit,%function
	.code	16                      @ @SystemInit
	.thumb_func
SystemInit:
@ BB#0:                                 @ %entry
	movw	r0, #14336
	movs	r2, #0
	movw	r3, #65535
	movt	r0, #16386
	movt	r3, #65270
	ldr	r1, [r0]
	orr	r1, r1, #1
	str	r1, [r0]
	movw	r1, #14344
	movt	r1, #16386
	str	r2, [r1]
	ldr	r1, [r0]
	ands	r1, r3
	movw	r3, #12304
	str	r1, [r0]
	movw	r1, #14340
	movt	r3, #9216
	movt	r1, #16386
	str	r3, [r1]
	ldr	r1, [r0]
	bic	r1, r1, #262144
	str	r1, [r0]
	movw	r0, #14348
	mov.w	r1, #134217728
	movt	r0, #16386
	str	r2, [r0]
	movw	r0, #60680
	movt	r0, #57344
	str	r1, [r0]
	bx	lr
.Ltmp6:
	.size	SystemInit, .Ltmp6-SystemInit

	.globl	SystemCoreClockUpdate
	.align	2
	.type	SystemCoreClockUpdate,%function
	.code	16                      @ @SystemCoreClockUpdate
	.thumb_func
SystemCoreClockUpdate:
@ BB#0:                                 @ %entry
	sub	sp, #20
	movs	r0, #0
	movs	r1, #2
	str	r0, [sp, #16]
	str	r0, [sp, #12]
	str	r0, [sp, #4]
	movw	r0, #14344
	str	r1, [sp, #8]
	str	r1, [sp]
	movt	r0, #16386
	ldr	r1, [r0]
	and	r1, r1, #12
	str	r1, [sp, #16]
	cmp	r1, #8
	beq	.LBB7_3
@ BB#1:                                 @ %entry
	cmp	r1, #4
	bne	.LBB7_5
@ BB#2:                                 @ %sw.bb5
	movw	r1, :lower16:SystemCoreClock
	movw	r2, #4608
	movt	r1, :upper16:SystemCoreClock
	movt	r2, #122
	str	r2, [r1]
	b	.LBB7_8
.LBB7_3:                                @ %sw.bb6
	movw	r1, #14340
	movt	r1, #16386
	ldr	r2, [r1]
	and	r2, r2, #4194304
	lsrs	r2, r2, #22
	str	r2, [sp, #4]
	ldr	r2, [r1]
	and	r2, r2, #63
	str	r2, [sp]
	ldr	r2, [sp, #4]
	cbz	r2, .LBB7_6
@ BB#4:                                 @ %if.then
	ldr	r2, [sp]
	movw	r3, #4608
	movt	r3, #122
	b	.LBB7_7
.LBB7_5:                                @ %entry
	movw	r2, #9216
	cmp	r1, #0
	movw	r1, :lower16:SystemCoreClock
	movt	r1, :upper16:SystemCoreClock
	movt	r2, #244
	str	r2, [r1]
	b	.LBB7_8
.LBB7_6:                                @ %if.else
	ldr	r2, [sp]
	movw	r3, #9216
	movt	r3, #244
.LBB7_7:                                @ %if.end
	udiv	r12, r3, r2
	ldr	r3, [r1]
	movw	r2, #32704
	ands	r2, r3
	lsrs	r2, r2, #6
	mul	r2, r12, r2
	str	r2, [sp, #12]
	ldr	r1, [r1]
	movs	r2, #2
	and	r1, r1, #196608
	add.w	r1, r2, r1, lsr #15
	ldr	r2, [sp, #12]
	str	r1, [sp, #8]
	udiv	r1, r2, r1
	movw	r2, :lower16:SystemCoreClock
	movt	r2, :upper16:SystemCoreClock
	str	r1, [r2]
.LBB7_8:                                @ %sw.epilog
	ldr	r0, [r0]
	movw	r1, :lower16:AHBPrescTable
	movt	r1, :upper16:AHBPrescTable
	and	r0, r0, #240
	lsrs	r0, r0, #4
	ldrb	r0, [r1, r0]
	movw	r1, :lower16:SystemCoreClock
	movt	r1, :upper16:SystemCoreClock
	ldr	r2, [r1]
	str	r0, [sp, #16]
	lsr.w	r0, r2, r0
	str	r0, [r1]
	add	sp, #20
	bx	lr
.Ltmp7:
	.size	SystemCoreClockUpdate, .Ltmp7-SystemCoreClockUpdate

	.section	.text.module.uart,"ax",%progbits
	.globl	HAL_UART_Init
	.align	2
	.type	HAL_UART_Init,%function
	.code	16                      @ @HAL_UART_Init
	.thumb_func
HAL_UART_Init:
@ BB#0:                                 @ %entry
	push	{r7, lr}
	mov	r7, sp
	sub	sp, #8
	str	r0, [sp]
	cmp	r0, #0
	beq	.LBB8_4
@ BB#1:                                 @ %if.end3
	ldr	r0, [sp]
	ldr	r0, [r0, #60]
	cbnz	r0, .LBB8_3
@ BB#2:                                 @ %if.then5
	ldr	r0, [sp]
	movs	r1, #0
	str	r1, [r0, #56]
	ldr	r0, [sp]
	bl	HAL_UART_MspInit
.LBB8_3:                                @ %if.end6
	ldr	r0, [sp]
	movs	r1, #36
	str	r1, [r0, #60]
	ldr	r0, [sp]
	ldr	r0, [r0]
	ldr	r1, [r0, #12]
	bic	r1, r1, #8192
	str	r1, [r0, #12]
	ldr	r0, [sp]
	bl	UART_SetConfig
	ldr	r0, [sp]
	movs	r2, #32
	ldr	r0, [r0]
	ldr	r1, [r0, #16]
	bic	r1, r1, #18432
	str	r1, [r0, #16]
	ldr	r0, [sp]
	ldr	r0, [r0]
	ldr	r1, [r0, #20]
	bic	r1, r1, #42
	str	r1, [r0, #20]
	ldr	r0, [sp]
	ldr	r0, [r0]
	ldr	r1, [r0, #12]
	orr	r1, r1, #8192
	str	r1, [r0, #12]
	movs	r1, #0
	ldr	r0, [sp]
	str	r1, [r0, #68]
	ldr	r0, [sp]
	str	r2, [r0, #60]
	ldr	r0, [sp]
	str	r2, [r0, #64]
	str	r1, [sp, #4]
	b	.LBB8_5
.LBB8_4:                                @ %if.then
	movs	r0, #1
	str	r0, [sp, #4]
.LBB8_5:                                @ %return
	ldr	r0, [sp, #4]
	@APP
	boundcheckstart.HAL_UART_Init.text.module.uart.ret:

	@NO_APP
	add	sp, #8
	pop	{r7, lr}
	push {r0}
 	movw r0, :lower16:gateway_ret_uart
 	movt r0, :upper16:gateway_ret_uart
 	bic lr,lr,#1
 	cmp lr, r0
 	beq end_of_check_HAL_UART_Init0
 	movw r0, :lower16:.text.module.uart_start
 	movt r0, :upper16:.text.module.uart_start
 	cmp lr, r0
 	it cc
 	blcc exceptionFun
 	movw r0, :lower16:.text.module.uart_end
 	movt r0, :upper16:.text.module.uart_end
 	cmp lr, r0
 	it cs
 	blcs exceptionFun
end_of_check_HAL_UART_Init0:
	pop {r0}
 	orr lr,lr,#1
	bx	lr
.Ltmp8:
	.size	HAL_UART_Init, .Ltmp8-HAL_UART_Init

	.weak	HAL_UART_MspInit
	.align	2
	.type	HAL_UART_MspInit,%function
	.code	16                      @ @HAL_UART_MspInit
	.thumb_func
HAL_UART_MspInit:
@ BB#0:                                 @ %entry
	sub	sp, #8
	str	r0, [sp]
	@APP
	boundcheckstart.HAL_UART_MspInit.text.module.uart.ret:

	@NO_APP
	add	sp, #8
	push {r0}
 	movw r0, :lower16:gateway_ret_uart
 	movt r0, :upper16:gateway_ret_uart
 	bic lr,lr,#1
 	cmp lr, r0
 	beq end_of_check_HAL_UART_MspInit1
 	movw r0, :lower16:.text.module.uart_start
 	movt r0, :upper16:.text.module.uart_start
 	cmp lr, r0
 	it cc
 	blcc exceptionFun
 	movw r0, :lower16:.text.module.uart_end
 	movt r0, :upper16:.text.module.uart_end
 	cmp lr, r0
 	it cs
 	blcs exceptionFun
end_of_check_HAL_UART_MspInit1:
	pop {r0}
 	orr lr,lr,#1
	bx	lr
.Ltmp9:
	.size	HAL_UART_MspInit, .Ltmp9-HAL_UART_MspInit

	.globl	HAL_HalfDuplex_Init
	.align	2
	.type	HAL_HalfDuplex_Init,%function
	.code	16                      @ @HAL_HalfDuplex_Init
	.thumb_func
HAL_HalfDuplex_Init:
@ BB#0:                                 @ %entry
	push	{r7, lr}
	mov	r7, sp
	sub	sp, #8
	str	r0, [sp]
	cmp	r0, #0
	beq	.LBB10_4
@ BB#1:                                 @ %if.end
	ldr	r0, [sp]
	ldr	r0, [r0, #60]
	cbnz	r0, .LBB10_3
@ BB#2:                                 @ %if.then2
	ldr	r0, [sp]
	movs	r1, #0
	str	r1, [r0, #56]
	ldr	r0, [sp]
	bl	HAL_UART_MspInit
.LBB10_3:                               @ %if.end3
	ldr	r0, [sp]
	movs	r1, #36
	str	r1, [r0, #60]
	ldr	r0, [sp]
	ldr	r0, [r0]
	ldr	r1, [r0, #12]
	bic	r1, r1, #8192
	str	r1, [r0, #12]
	ldr	r0, [sp]
	bl	UART_SetConfig
	ldr	r0, [sp]
	movs	r2, #32
	ldr	r0, [r0]
	ldr	r1, [r0, #16]
	bic	r1, r1, #18432
	str	r1, [r0, #16]
	ldr	r0, [sp]
	ldr	r0, [r0]
	ldr	r1, [r0, #20]
	bic	r1, r1, #34
	str	r1, [r0, #20]
	ldr	r0, [sp]
	ldr	r0, [r0]
	ldr	r1, [r0, #20]
	orr	r1, r1, #8
	str	r1, [r0, #20]
	ldr	r0, [sp]
	ldr	r0, [r0]
	ldr	r1, [r0, #12]
	orr	r1, r1, #8192
	str	r1, [r0, #12]
	movs	r1, #0
	ldr	r0, [sp]
	str	r1, [r0, #68]
	ldr	r0, [sp]
	str	r2, [r0, #60]
	ldr	r0, [sp]
	str	r2, [r0, #64]
	str	r1, [sp, #4]
	b	.LBB10_5
.LBB10_4:                               @ %if.then
	movs	r0, #1
	str	r0, [sp, #4]
.LBB10_5:                               @ %return
	ldr	r0, [sp, #4]
	@APP
	boundcheckstart.HAL_HalfDuplex_Init.text.module.uart.ret:

	@NO_APP
	add	sp, #8
	pop	{r7, lr}
	push {r0}
 	movw r0, :lower16:gateway_ret_uart
 	movt r0, :upper16:gateway_ret_uart
 	bic lr,lr,#1
 	cmp lr, r0
 	beq end_of_check_HAL_HalfDuplex_Init3
 	movw r0, :lower16:.text.module.uart_start
 	movt r0, :upper16:.text.module.uart_start
 	cmp lr, r0
 	it cc
 	blcc exceptionFun
 	movw r0, :lower16:.text.module.uart_end
 	movt r0, :upper16:.text.module.uart_end
 	cmp lr, r0
 	it cs
 	blcs exceptionFun
end_of_check_HAL_HalfDuplex_Init3:
	pop {r0}
 	orr lr,lr,#1
	bx	lr
.Ltmp10:
	.size	HAL_HalfDuplex_Init, .Ltmp10-HAL_HalfDuplex_Init

	.globl	HAL_LIN_Init
	.align	2
	.type	HAL_LIN_Init,%function
	.code	16                      @ @HAL_LIN_Init
	.thumb_func
HAL_LIN_Init:
@ BB#0:                                 @ %entry
	push	{r7, lr}
	mov	r7, sp
	sub	sp, #16
	str	r0, [sp, #8]
	str	r1, [sp, #4]
	ldr	r0, [sp, #8]
	cmp	r0, #0
	beq	.LBB11_4
@ BB#1:                                 @ %if.end
	ldr	r0, [sp, #8]
	ldr	r0, [r0, #60]
	cbnz	r0, .LBB11_3
@ BB#2:                                 @ %if.then2
	ldr	r0, [sp, #8]
	movs	r1, #0
	str	r1, [r0, #56]
	ldr	r0, [sp, #8]
	bl	HAL_UART_MspInit
.LBB11_3:                               @ %if.end3
	ldr	r0, [sp, #8]
	movs	r1, #36
	str	r1, [r0, #60]
	ldr	r0, [sp, #8]
	ldr	r0, [r0]
	ldr	r1, [r0, #12]
	bic	r1, r1, #8192
	str	r1, [r0, #12]
	ldr	r0, [sp, #8]
	bl	UART_SetConfig
	ldr	r0, [sp, #8]
	ldr	r0, [r0]
	ldr	r1, [r0, #16]
	bic	r1, r1, #2048
	str	r1, [r0, #16]
	ldr	r0, [sp, #8]
	ldr	r0, [r0]
	ldr	r1, [r0, #20]
	bic	r1, r1, #42
	str	r1, [r0, #20]
	ldr	r0, [sp, #8]
	ldr	r0, [r0]
	ldr	r1, [r0, #16]
	orr	r1, r1, #16384
	str	r1, [r0, #16]
	ldr	r0, [sp, #8]
	ldr	r0, [r0]
	ldr	r1, [r0, #16]
	bic	r1, r1, #32
	str	r1, [r0, #16]
	ldr	r0, [sp, #8]
	ldr	r1, [sp, #4]
	ldr	r0, [r0]
	ldr	r2, [r0, #16]
	orrs	r1, r2
	movs	r2, #32
	str	r1, [r0, #16]
	ldr	r0, [sp, #8]
	ldr	r0, [r0]
	ldr	r1, [r0, #12]
	orr	r1, r1, #8192
	str	r1, [r0, #12]
	movs	r1, #0
	ldr	r0, [sp, #8]
	str	r1, [r0, #68]
	ldr	r0, [sp, #8]
	str	r2, [r0, #60]
	ldr	r0, [sp, #8]
	str	r2, [r0, #64]
	str	r1, [sp, #12]
	b	.LBB11_5
.LBB11_4:                               @ %if.then
	movs	r0, #1
	str	r0, [sp, #12]
.LBB11_5:                               @ %return
	ldr	r0, [sp, #12]
	@APP
	boundcheckstart.HAL_LIN_Init.text.module.uart.ret:

	@NO_APP
	add	sp, #16
	pop	{r7, lr}
	push {r0}
 	movw r0, :lower16:gateway_ret_uart
 	movt r0, :upper16:gateway_ret_uart
 	bic lr,lr,#1
 	cmp lr, r0
 	beq end_of_check_HAL_LIN_Init4
 	movw r0, :lower16:.text.module.uart_start
 	movt r0, :upper16:.text.module.uart_start
 	cmp lr, r0
 	it cc
 	blcc exceptionFun
 	movw r0, :lower16:.text.module.uart_end
 	movt r0, :upper16:.text.module.uart_end
 	cmp lr, r0
 	it cs
 	blcs exceptionFun
end_of_check_HAL_LIN_Init4:
	pop {r0}
 	orr lr,lr,#1
	bx	lr
.Ltmp11:
	.size	HAL_LIN_Init, .Ltmp11-HAL_LIN_Init

	.globl	HAL_MultiProcessor_Init
	.align	2
	.type	HAL_MultiProcessor_Init,%function
	.code	16                      @ @HAL_MultiProcessor_Init
	.thumb_func
HAL_MultiProcessor_Init:
@ BB#0:                                 @ %entry
	push	{r7, lr}
	mov	r7, sp
	sub	sp, #16
	str	r0, [sp, #8]
	strb.w	r1, [sp, #4]
	str	r2, [sp]
	ldr	r0, [sp, #8]
	cmp	r0, #0
	beq	.LBB12_4
@ BB#1:                                 @ %if.end
	ldr	r0, [sp, #8]
	ldr	r0, [r0, #60]
	cbnz	r0, .LBB12_3
@ BB#2:                                 @ %if.then2
	ldr	r0, [sp, #8]
	movs	r1, #0
	str	r1, [r0, #56]
	ldr	r0, [sp, #8]
	bl	HAL_UART_MspInit
.LBB12_3:                               @ %if.end3
	ldr	r0, [sp, #8]
	movs	r1, #36
	str	r1, [r0, #60]
	ldr	r0, [sp, #8]
	ldr	r0, [r0]
	ldr	r1, [r0, #12]
	bic	r1, r1, #8192
	str	r1, [r0, #12]
	ldr	r0, [sp, #8]
	bl	UART_SetConfig
	ldr	r0, [sp, #8]
	ldr	r0, [r0]
	ldr	r1, [r0, #16]
	bic	r1, r1, #18432
	str	r1, [r0, #16]
	ldr	r0, [sp, #8]
	ldr	r0, [r0]
	ldr	r1, [r0, #20]
	bic	r1, r1, #42
	str	r1, [r0, #20]
	ldr	r0, [sp, #8]
	ldr	r0, [r0]
	ldr	r1, [r0, #16]
	bic	r1, r1, #15
	str	r1, [r0, #16]
	ldr	r0, [sp, #8]
	ldrb.w	r1, [sp, #4]
	ldr	r0, [r0]
	ldr	r2, [r0, #16]
	orrs	r1, r2
	str	r1, [r0, #16]
	ldr	r0, [sp, #8]
	ldr	r0, [r0]
	ldr	r1, [r0, #12]
	bic	r1, r1, #2048
	str	r1, [r0, #12]
	ldr	r0, [sp, #8]
	ldr	r1, [sp]
	ldr	r0, [r0]
	ldr	r2, [r0, #12]
	orrs	r1, r2
	movs	r2, #32
	str	r1, [r0, #12]
	ldr	r0, [sp, #8]
	ldr	r0, [r0]
	ldr	r1, [r0, #12]
	orr	r1, r1, #8192
	str	r1, [r0, #12]
	movs	r1, #0
	ldr	r0, [sp, #8]
	str	r1, [r0, #68]
	ldr	r0, [sp, #8]
	str	r2, [r0, #60]
	ldr	r0, [sp, #8]
	str	r2, [r0, #64]
	str	r1, [sp, #12]
	b	.LBB12_5
.LBB12_4:                               @ %if.then
	movs	r0, #1
	str	r0, [sp, #12]
.LBB12_5:                               @ %return
	ldr	r0, [sp, #12]
	@APP
	boundcheckstart.HAL_MultiProcessor_Init.text.module.uart.ret:

	@NO_APP
	add	sp, #16
	pop	{r7, lr}
	push {r0}
 	movw r0, :lower16:gateway_ret_uart
 	movt r0, :upper16:gateway_ret_uart
 	bic lr,lr,#1
 	cmp lr, r0
 	beq end_of_check_HAL_MultiProcessor_Init5
 	movw r0, :lower16:.text.module.uart_start
 	movt r0, :upper16:.text.module.uart_start
 	cmp lr, r0
 	it cc
 	blcc exceptionFun
 	movw r0, :lower16:.text.module.uart_end
 	movt r0, :upper16:.text.module.uart_end
 	cmp lr, r0
 	it cs
 	blcs exceptionFun
end_of_check_HAL_MultiProcessor_Init5:
	pop {r0}
 	orr lr,lr,#1
	bx	lr
.Ltmp12:
	.size	HAL_MultiProcessor_Init, .Ltmp12-HAL_MultiProcessor_Init

	.globl	HAL_UART_DeInit
	.align	2
	.type	HAL_UART_DeInit,%function
	.code	16                      @ @HAL_UART_DeInit
	.thumb_func
HAL_UART_DeInit:
@ BB#0:                                 @ %entry
	push	{r7, lr}
	mov	r7, sp
	sub	sp, #8
	str	r0, [sp]
	cmp	r0, #0
	beq	.LBB13_2
@ BB#1:                                 @ %if.end
	ldr	r0, [sp]
	movs	r1, #36
	str	r1, [r0, #60]
	ldr	r0, [sp]
	bl	HAL_UART_MspDeInit
	ldr	r1, [sp]
	movs	r0, #0
	str	r0, [r1, #68]
	ldr	r1, [sp]
	str	r0, [r1, #60]
	ldr	r1, [sp]
	str	r0, [r1, #64]
	ldr	r1, [sp]
	str	r0, [r1, #56]
	movs	r0, #0
	b	.LBB13_3
.LBB13_2:                               @ %if.then
	movs	r0, #1
.LBB13_3:                               @ %return
	str	r0, [sp, #4]
	ldr	r0, [sp, #4]
	@APP
	boundcheckstart.HAL_UART_DeInit.text.module.uart.ret:

	@NO_APP
	add	sp, #8
	pop	{r7, lr}
	push {r0}
 	movw r0, :lower16:gateway_ret_uart
 	movt r0, :upper16:gateway_ret_uart
 	bic lr,lr,#1
 	cmp lr, r0
 	beq end_of_check_HAL_UART_DeInit6
 	movw r0, :lower16:.text.module.uart_start
 	movt r0, :upper16:.text.module.uart_start
 	cmp lr, r0
 	it cc
 	blcc exceptionFun
 	movw r0, :lower16:.text.module.uart_end
 	movt r0, :upper16:.text.module.uart_end
 	cmp lr, r0
 	it cs
 	blcs exceptionFun
end_of_check_HAL_UART_DeInit6:
	pop {r0}
 	orr lr,lr,#1
	bx	lr
.Ltmp13:
	.size	HAL_UART_DeInit, .Ltmp13-HAL_UART_DeInit

	.weak	HAL_UART_MspDeInit
	.align	2
	.type	HAL_UART_MspDeInit,%function
	.code	16                      @ @HAL_UART_MspDeInit
	.thumb_func
HAL_UART_MspDeInit:
@ BB#0:                                 @ %entry
	sub	sp, #8
	str	r0, [sp]
	@APP
	boundcheckstart.HAL_UART_MspDeInit.text.module.uart.ret:

	@NO_APP
	add	sp, #8
	push {r0}
 	movw r0, :lower16:gateway_ret_uart
 	movt r0, :upper16:gateway_ret_uart
 	bic lr,lr,#1
 	cmp lr, r0
 	beq end_of_check_HAL_UART_MspDeInit7
 	movw r0, :lower16:.text.module.uart_start
 	movt r0, :upper16:.text.module.uart_start
 	cmp lr, r0
 	it cc
 	blcc exceptionFun
 	movw r0, :lower16:.text.module.uart_end
 	movt r0, :upper16:.text.module.uart_end
 	cmp lr, r0
 	it cs
 	blcs exceptionFun
end_of_check_HAL_UART_MspDeInit7:
	pop {r0}
 	orr lr,lr,#1
	bx	lr
.Ltmp14:
	.size	HAL_UART_MspDeInit, .Ltmp14-HAL_UART_MspDeInit

	.globl	HAL_UART_Transmit
	.align	2
	.type	HAL_UART_Transmit,%function
	.code	16                      @ @HAL_UART_Transmit
	.thumb_func
HAL_UART_Transmit:
@ BB#0:                                 @ %entry
	push.w	{r4, r7, r11, lr}
	add	r7, sp, #4
	sub	sp, #40
	str	r0, [sp, #32]
	movs	r0, #0
	str	r1, [sp, #24]
	strh.w	r2, [sp, #20]
	str	r3, [sp, #16]
	str	r0, [sp, #4]
	ldr	r0, [sp, #32]
	ldr	r0, [r0, #60]
	cmp	r0, #32
	bne	.LBB15_4
@ BB#1:                                 @ %if.then
	ldr	r0, [sp, #24]
	cmp	r0, #0
	itt	ne
	ldrhne.w	r0, [sp, #20]
	cmpne	r0, #0
	bne	.LBB15_3
@ BB#2:                                 @ %if.then5
	movs	r0, #1
	b	.LBB15_5
.LBB15_3:                               @ %do.body
	ldr	r0, [sp, #32]
	ldr	r0, [r0, #56]
	cmp	r0, #1
	bne	.LBB15_7
.LBB15_4:                               @ %if.else53
	movs	r0, #2
.LBB15_5:                               @ %return
	str	r0, [sp, #36]
.LBB15_6:                               @ %return
	ldr	r0, [sp, #36]
	@APP
	boundcheckstart.HAL_UART_Transmit.text.module.uart.ret:

	@NO_APP
	add	sp, #40
	pop.w	{r4, r7, r11, lr}
	push {r0}
 	movw r0, :lower16:gateway_ret_uart
 	movt r0, :upper16:gateway_ret_uart
 	bic lr,lr,#1
 	cmp lr, r0
 	beq end_of_check_HAL_UART_Transmit8
 	movw r0, :lower16:.text.module.uart_start
 	movt r0, :upper16:.text.module.uart_start
 	cmp lr, r0
 	it cc
 	blcc exceptionFun
 	movw r0, :lower16:.text.module.uart_end
 	movt r0, :upper16:.text.module.uart_end
 	cmp lr, r0
 	it cs
 	blcs exceptionFun
end_of_check_HAL_UART_Transmit8:
	pop {r0}
 	orr lr,lr,#1
	bx	lr
.LBB15_7:                               @ %do.end
	ldr	r0, [sp, #32]
	movs	r1, #1
	str	r1, [r0, #56]
	movs	r1, #0
	ldr	r0, [sp, #32]
	str	r1, [r0, #68]
	movs	r1, #33
	ldr	r0, [sp, #32]
	str	r1, [r0, #60]
	bl	HAL_GetTick
	str	r0, [sp, #4]
	ldr	r0, [sp, #32]
	ldrh.w	r1, [sp, #20]
	strh	r1, [r0, #36]
	ldr	r0, [sp, #32]
	ldrh.w	r1, [sp, #20]
	strh	r1, [r0, #38]
	b	.LBB15_9
.LBB15_8:                               @ %if.end38
                                        @   in Loop: Header=BB15_9 Depth=1
	ldr	r0, [sp, #24]
	adds	r1, r0, #1
	str	r1, [sp, #24]
	ldr	r1, [sp, #32]
	ldrb	r0, [r0]
	ldr	r1, [r1]
	str	r0, [r1, #4]
.LBB15_9:                               @ %while.cond
                                        @ =>This Inner Loop Header: Depth=1
	ldr	r0, [sp, #32]
	ldrh	r0, [r0, #38]
	cbz	r0, .LBB15_14
@ BB#10:                                @ %while.body
                                        @   in Loop: Header=BB15_9 Depth=1
	ldr	r0, [sp, #32]
	ldrh	r1, [r0, #38]
	subs	r1, #1
	strh	r1, [r0, #38]
	ldr	r0, [sp, #32]
	ldr	r0, [r0, #8]
	cmp.w	r0, #4096
	bne	.LBB15_13
@ BB#11:                                @ %if.then19
                                        @   in Loop: Header=BB15_9 Depth=1
	ldr	r1, [sp, #16]
	ldr	r3, [sp, #4]
	ldr	r0, [sp, #32]
	movs	r2, #0
	str	r1, [sp]
	movs	r1, #128
	bl	UART_WaitOnFlagUntilTimeout
	cmp	r0, #0
	bne	.LBB15_15
@ BB#12:                                @ %if.end24
                                        @   in Loop: Header=BB15_9 Depth=1
	ldr	r0, [sp, #24]
	ldr	r1, [sp, #32]
	str	r0, [sp, #8]
	ldrh	r0, [r0]
	ldr	r1, [r1]
	bfc	r0, #9, #23
	str	r0, [r1, #4]
	ldr	r0, [sp, #32]
	ldr	r0, [r0, #16]
	cmp	r0, #0
	ldr	r0, [sp, #24]
	ite	ne
	addne	r0, #1
	addeq	r0, #2
	str	r0, [sp, #24]
	b	.LBB15_9
.LBB15_13:                              @ %if.else33
                                        @   in Loop: Header=BB15_9 Depth=1
	ldr	r1, [sp, #16]
	ldr	r3, [sp, #4]
	ldr	r0, [sp, #32]
	movs	r2, #0
	str	r1, [sp]
	movs	r1, #128
	bl	UART_WaitOnFlagUntilTimeout
	cmp	r0, #0
	beq	.LBB15_8
	b	.LBB15_15
.LBB15_14:                              @ %while.end
	ldr	r1, [sp, #16]
	ldr	r3, [sp, #4]
	ldr	r0, [sp, #32]
	movs	r2, #0
	movs	r4, #0
	str	r1, [sp]
	movs	r1, #64
	bl	UART_WaitOnFlagUntilTimeout
	cmp	r0, #0
	beq	.LBB15_16
.LBB15_15:                              @ %if.then23
	movs	r0, #3
	b	.LBB15_5
.LBB15_16:                              @ %do.end52
	ldr	r0, [sp, #32]
	movs	r1, #32
	str	r1, [r0, #60]
	ldr	r0, [sp, #32]
	str	r4, [r0, #56]
	str	r4, [sp, #36]
	b	.LBB15_6
.Ltmp15:
	.size	HAL_UART_Transmit, .Ltmp15-HAL_UART_Transmit

	.globl	HAL_UART_Receive
	.align	2
	.type	HAL_UART_Receive,%function
	.code	16                      @ @HAL_UART_Receive
	.thumb_func
HAL_UART_Receive:
@ BB#0:                                 @ %entry
	push	{r7, lr}
	mov	r7, sp
	sub	sp, #40
	str	r0, [sp, #32]
	movs	r0, #0
	str	r1, [sp, #24]
	strh.w	r2, [sp, #20]
	str	r3, [sp, #16]
	str	r0, [sp, #4]
	ldr	r0, [sp, #32]
	ldr	r0, [r0, #64]
	cmp	r0, #32
	bne	.LBB16_4
@ BB#1:                                 @ %if.then
	ldr	r0, [sp, #24]
	cmp	r0, #0
	itt	ne
	ldrhne.w	r0, [sp, #20]
	cmpne	r0, #0
	bne	.LBB16_3
@ BB#2:                                 @ %if.then5
	movs	r0, #1
	b	.LBB16_5
.LBB16_3:                               @ %do.body
	ldr	r0, [sp, #32]
	ldr	r0, [r0, #56]
	cmp	r0, #1
	bne	.LBB16_7
.LBB16_4:                               @ %if.else64
	movs	r0, #2
.LBB16_5:                               @ %return
	str	r0, [sp, #36]
.LBB16_6:                               @ %return
	ldr	r0, [sp, #36]
	@APP
	boundcheckstart.HAL_UART_Receive.text.module.uart.ret:

	@NO_APP
	add	sp, #40
	pop	{r7, lr}
	push {r0}
 	movw r0, :lower16:gateway_ret_uart
 	movt r0, :upper16:gateway_ret_uart
 	bic lr,lr,#1
 	cmp lr, r0
 	beq end_of_check_HAL_UART_Receive10
 	movw r0, :lower16:.text.module.uart_start
 	movt r0, :upper16:.text.module.uart_start
 	cmp lr, r0
 	it cc
 	blcc exceptionFun
 	movw r0, :lower16:.text.module.uart_end
 	movt r0, :upper16:.text.module.uart_end
 	cmp lr, r0
 	it cs
 	blcs exceptionFun
end_of_check_HAL_UART_Receive10:
	pop {r0}
 	orr lr,lr,#1
	bx	lr
.LBB16_7:                               @ %do.end
	ldr	r0, [sp, #32]
	movs	r1, #1
	str	r1, [r0, #56]
	movs	r1, #0
	ldr	r0, [sp, #32]
	str	r1, [r0, #68]
	movs	r1, #34
	ldr	r0, [sp, #32]
	str	r1, [r0, #64]
	bl	HAL_GetTick
	str	r0, [sp, #4]
	ldr	r0, [sp, #32]
	ldrh.w	r1, [sp, #20]
	strh	r1, [r0, #44]
	ldr	r0, [sp, #32]
	ldrh.w	r1, [sp, #20]
	strh	r1, [r0, #46]
	b	.LBB16_9
.LBB16_8:                               @ %if.else52
                                        @   in Loop: Header=BB16_9 Depth=1
	ldr	r0, [sp, #32]
	ldr	r0, [r0]
	ldr	r0, [r0, #4]
	ldr	r1, [sp, #24]
	adds	r2, r1, #1
	and	r0, r0, #127
	str	r2, [sp, #24]
	strb	r0, [r1]
.LBB16_9:                               @ %while.cond
                                        @ =>This Inner Loop Header: Depth=1
	ldr	r0, [sp, #32]
	ldrh	r0, [r0, #46]
	cmp	r0, #0
	beq	.LBB16_18
@ BB#10:                                @ %while.body
                                        @   in Loop: Header=BB16_9 Depth=1
	ldr	r0, [sp, #32]
	ldrh	r1, [r0, #46]
	subs	r1, #1
	strh	r1, [r0, #46]
	ldr	r0, [sp, #32]
	ldr	r0, [r0, #8]
	cmp.w	r0, #4096
	bne	.LBB16_14
@ BB#11:                                @ %if.then19
                                        @   in Loop: Header=BB16_9 Depth=1
	ldr	r1, [sp, #16]
	ldr	r3, [sp, #4]
	ldr	r0, [sp, #32]
	movs	r2, #0
	str	r1, [sp]
	movs	r1, #32
	bl	UART_WaitOnFlagUntilTimeout
	cmp	r0, #0
	bne	.LBB16_19
@ BB#12:                                @ %if.end24
                                        @   in Loop: Header=BB16_9 Depth=1
	ldr	r0, [sp, #24]
	str	r0, [sp, #8]
	ldr	r0, [sp, #32]
	ldr	r0, [r0, #16]
	cbnz	r0, .LBB16_17
@ BB#13:                                @ %if.then28
                                        @   in Loop: Header=BB16_9 Depth=1
	ldr	r0, [sp, #32]
	ldr	r0, [r0]
	ldr	r0, [r0, #4]
	ldr	r1, [sp, #8]
	bfc	r0, #9, #23
	strh	r0, [r1]
	ldr	r0, [sp, #24]
	adds	r0, #2
	str	r0, [sp, #24]
	b	.LBB16_9
.LBB16_14:                              @ %if.else37
                                        @   in Loop: Header=BB16_9 Depth=1
	ldr	r1, [sp, #16]
	ldr	r3, [sp, #4]
	ldr	r0, [sp, #32]
	movs	r2, #0
	str	r1, [sp]
	movs	r1, #32
	bl	UART_WaitOnFlagUntilTimeout
	cbnz	r0, .LBB16_19
@ BB#15:                                @ %if.end42
                                        @   in Loop: Header=BB16_9 Depth=1
	ldr	r0, [sp, #32]
	ldr	r0, [r0, #16]
	cmp	r0, #0
	bne	.LBB16_8
@ BB#16:                                @ %if.then47
                                        @   in Loop: Header=BB16_9 Depth=1
	ldr	r0, [sp, #32]
	ldr	r0, [r0]
	ldr	r0, [r0, #4]
	ldr	r1, [sp, #24]
	adds	r2, r1, #1
	str	r2, [sp, #24]
	strb	r0, [r1]
	b	.LBB16_9
.LBB16_17:                              @ %if.else30
                                        @   in Loop: Header=BB16_9 Depth=1
	ldr	r0, [sp, #32]
	ldr	r0, [r0]
	ldr	r0, [r0, #4]
	ldr	r1, [sp, #8]
	uxtb	r0, r0
	strh	r0, [r1]
	ldr	r0, [sp, #24]
	adds	r0, #1
	str	r0, [sp, #24]
	b	.LBB16_9
.LBB16_18:                              @ %do.end63
	ldr	r0, [sp, #32]
	movs	r1, #32
	str	r1, [r0, #64]
	movs	r1, #0
	ldr	r0, [sp, #32]
	str	r1, [r0, #56]
	str	r1, [sp, #36]
	b	.LBB16_6
.LBB16_19:                              @ %if.then23
	movs	r0, #3
	b	.LBB16_5
.Ltmp16:
	.size	HAL_UART_Receive, .Ltmp16-HAL_UART_Receive

	.globl	HAL_UART_Transmit_IT
	.align	2
	.type	HAL_UART_Transmit_IT,%function
	.code	16                      @ @HAL_UART_Transmit_IT
	.thumb_func
HAL_UART_Transmit_IT:
@ BB#0:                                 @ %entry
	sub	sp, #24
	str	r0, [sp, #16]
	str	r1, [sp, #8]
	strh.w	r2, [sp, #4]
	ldr	r0, [sp, #16]
	ldr	r0, [r0, #60]
	cmp	r0, #32
	bne	.LBB17_4
@ BB#1:                                 @ %if.then
	ldr	r0, [sp, #8]
	cmp	r0, #0
	itt	ne
	ldrhne.w	r0, [sp, #4]
	cmpne	r0, #0
	bne	.LBB17_3
@ BB#2:                                 @ %if.then4
	movs	r0, #1
	b	.LBB17_5
.LBB17_3:                               @ %do.body
	ldr	r0, [sp, #16]
	ldr	r0, [r0, #56]
	cmp	r0, #1
	bne	.LBB17_7
.LBB17_4:                               @ %if.else14
	movs	r0, #2
.LBB17_5:                               @ %return
	str	r0, [sp, #20]
.LBB17_6:                               @ %return
	ldr	r0, [sp, #20]
	@APP
	boundcheckstart.HAL_UART_Transmit_IT.text.module.uart.ret:

	@NO_APP
	add	sp, #24
	push {r0}
 	movw r0, :lower16:gateway_ret_uart
 	movt r0, :upper16:gateway_ret_uart
 	bic lr,lr,#1
 	cmp lr, r0
 	beq end_of_check_HAL_UART_Transmit_IT11
 	movw r0, :lower16:.text.module.uart_start
 	movt r0, :upper16:.text.module.uart_start
 	cmp lr, r0
 	it cc
 	blcc exceptionFun
 	movw r0, :lower16:.text.module.uart_end
 	movt r0, :upper16:.text.module.uart_end
 	cmp lr, r0
 	it cs
 	blcs exceptionFun
end_of_check_HAL_UART_Transmit_IT11:
	pop {r0}
 	orr lr,lr,#1
	bx	lr
.LBB17_7:                               @ %do.end13
	ldr	r0, [sp, #16]
	movs	r1, #1
	movs	r2, #33
	str	r1, [r0, #56]
	ldr	r0, [sp, #16]
	ldr	r1, [sp, #8]
	str	r1, [r0, #32]
	ldr	r0, [sp, #16]
	ldrh.w	r1, [sp, #4]
	strh	r1, [r0, #36]
	ldr	r0, [sp, #16]
	ldrh.w	r1, [sp, #4]
	strh	r1, [r0, #38]
	movs	r1, #0
	ldr	r0, [sp, #16]
	str	r1, [r0, #68]
	ldr	r0, [sp, #16]
	str	r2, [r0, #60]
	ldr	r0, [sp, #16]
	str	r1, [r0, #56]
	ldr	r0, [sp, #16]
	ldr	r0, [r0]
	ldr	r2, [r0, #12]
	orr	r2, r2, #128
	str	r2, [r0, #12]
	str	r1, [sp, #20]
	b	.LBB17_6
.Ltmp17:
	.size	HAL_UART_Transmit_IT, .Ltmp17-HAL_UART_Transmit_IT

	.globl	HAL_UART_Receive_IT
	.align	2
	.type	HAL_UART_Receive_IT,%function
	.code	16                      @ @HAL_UART_Receive_IT
	.thumb_func
HAL_UART_Receive_IT:
@ BB#0:                                 @ %entry
	sub	sp, #24
	str	r0, [sp, #16]
	str	r1, [sp, #8]
	strh.w	r2, [sp, #4]
	ldr	r0, [sp, #16]
	ldr	r0, [r0, #64]
	cmp	r0, #32
	bne	.LBB18_4
@ BB#1:                                 @ %if.then
	ldr	r0, [sp, #8]
	cmp	r0, #0
	itt	ne
	ldrhne.w	r0, [sp, #4]
	cmpne	r0, #0
	bne	.LBB18_3
@ BB#2:                                 @ %if.then4
	movs	r0, #1
	b	.LBB18_5
.LBB18_3:                               @ %do.body
	ldr	r0, [sp, #16]
	ldr	r0, [r0, #56]
	cmp	r0, #1
	bne	.LBB18_7
.LBB18_4:                               @ %if.else16
	movs	r0, #2
.LBB18_5:                               @ %return
	str	r0, [sp, #20]
.LBB18_6:                               @ %return
	ldr	r0, [sp, #20]
	@APP
	boundcheckstart.HAL_UART_Receive_IT.text.module.uart.ret:

	@NO_APP
	add	sp, #24
	push {r0}
 	movw r0, :lower16:gateway_ret_uart
 	movt r0, :upper16:gateway_ret_uart
 	bic lr,lr,#1
 	cmp lr, r0
 	beq end_of_check_HAL_UART_Receive_IT12
 	movw r0, :lower16:.text.module.uart_start
 	movt r0, :upper16:.text.module.uart_start
 	cmp lr, r0
 	it cc
 	blcc exceptionFun
 	movw r0, :lower16:.text.module.uart_end
 	movt r0, :upper16:.text.module.uart_end
 	cmp lr, r0
 	it cs
 	blcs exceptionFun
end_of_check_HAL_UART_Receive_IT12:
	pop {r0}
 	orr lr,lr,#1
	bx	lr
.LBB18_7:                               @ %do.end13
	ldr	r0, [sp, #16]
	movs	r1, #1
	movs	r2, #34
	str	r1, [r0, #56]
	ldr	r0, [sp, #16]
	ldr	r1, [sp, #8]
	str	r1, [r0, #40]
	ldr	r0, [sp, #16]
	ldrh.w	r1, [sp, #4]
	strh	r1, [r0, #44]
	ldr	r0, [sp, #16]
	ldrh.w	r1, [sp, #4]
	strh	r1, [r0, #46]
	movs	r1, #0
	ldr	r0, [sp, #16]
	str	r1, [r0, #68]
	ldr	r0, [sp, #16]
	str	r2, [r0, #64]
	ldr	r0, [sp, #16]
	str	r1, [r0, #56]
	ldr	r0, [sp, #16]
	ldr	r0, [r0]
	ldr	r2, [r0, #20]
	orr	r2, r2, #1
	str	r2, [r0, #20]
	ldr	r0, [sp, #16]
	ldr	r0, [r0]
	ldr	r2, [r0, #12]
	orr	r2, r2, #288
	str	r2, [r0, #12]
	str	r1, [sp, #20]
	b	.LBB18_6
.Ltmp18:
	.size	HAL_UART_Receive_IT, .Ltmp18-HAL_UART_Receive_IT

	.globl	HAL_UART_Transmit_DMA
	.align	2
	.type	HAL_UART_Transmit_DMA,%function
	.code	16                      @ @HAL_UART_Transmit_DMA
	.thumb_func
HAL_UART_Transmit_DMA:
@ BB#0:                                 @ %entry
	push.w	{r4, r7, r11, lr}
	add	r7, sp, #4
	sub	sp, #24
	str	r0, [sp, #16]
	str	r1, [sp, #8]
	strh.w	r2, [sp, #4]
	ldr	r0, [sp, #16]
	ldr	r0, [r0, #60]
	cmp	r0, #32
	bne	.LBB19_4
@ BB#1:                                 @ %if.then
	ldr	r0, [sp, #8]
	cmp	r0, #0
	itt	ne
	ldrhne.w	r0, [sp, #4]
	cmpne	r0, #0
	bne	.LBB19_3
@ BB#2:                                 @ %if.then4
	movs	r0, #1
	b	.LBB19_5
.LBB19_3:                               @ %do.body
	ldr	r0, [sp, #16]
	ldr	r0, [r0, #56]
	cmp	r0, #1
	bne	.LBB19_7
.LBB19_4:                               @ %if.else21
	movs	r0, #2
.LBB19_5:                               @ %return
	str	r0, [sp, #20]
.LBB19_6:                               @ %return
	ldr	r0, [sp, #20]
	@APP
	boundcheckstart.HAL_UART_Transmit_DMA.text.module.uart.ret:

	@NO_APP
	add	sp, #24
	pop.w	{r4, r7, r11, lr}
	push {r0}
 	movw r0, :lower16:gateway_ret_uart
 	movt r0, :upper16:gateway_ret_uart
 	bic lr,lr,#1
 	cmp lr, r0
 	beq end_of_check_HAL_UART_Transmit_DMA13
 	movw r0, :lower16:.text.module.uart_start
 	movt r0, :upper16:.text.module.uart_start
 	cmp lr, r0
 	it cc
 	blcc exceptionFun
 	movw r0, :lower16:.text.module.uart_end
 	movt r0, :upper16:.text.module.uart_end
 	cmp lr, r0
 	it cs
 	blcs exceptionFun
end_of_check_HAL_UART_Transmit_DMA13:
	pop {r0}
 	orr lr,lr,#1
	bx	lr
.LBB19_7:                               @ %do.end19
	ldr	r0, [sp, #16]
	movs	r1, #1
	movs	r4, #0
	str	r1, [r0, #56]
	ldr	r0, [sp, #16]
	ldr	r1, [sp, #8]
	str	r1, [r0, #32]
	ldr	r0, [sp, #16]
	ldrh.w	r1, [sp, #4]
	strh	r1, [r0, #36]
	ldr	r0, [sp, #16]
	ldrh.w	r1, [sp, #4]
	strh	r1, [r0, #38]
	movs	r1, #33
	ldr	r0, [sp, #16]
	str	r4, [r0, #68]
	ldr	r0, [sp, #16]
	str	r1, [r0, #60]
	movw	r1, :lower16:UART_DMATransmitCplt
	ldr	r0, [sp, #16]
	movt	r1, :upper16:UART_DMATransmitCplt
	ldr	r0, [r0, #48]
	str	r1, [r0, #64]
	movw	r1, :lower16:UART_DMATxHalfCplt
	ldr	r0, [sp, #16]
	movt	r1, :upper16:UART_DMATxHalfCplt
	ldr	r0, [r0, #48]
	str	r1, [r0, #68]
	movw	r1, :lower16:UART_DMAError
	ldr	r0, [sp, #16]
	movt	r1, :upper16:UART_DMAError
	ldr	r0, [r0, #48]
	str	r1, [r0, #80]
	ldr	r0, [sp, #16]
	ldr	r0, [r0, #48]
	str	r4, [r0, #84]
	add	r0, sp, #8
	str	r0, [sp]
	ldr	r0, [sp, #16]
	ldrh.w	r3, [sp, #4]
	ldr	r1, [sp, #8]
	ldr	r2, [r0]
	ldr	r0, [r0, #48]
	adds	r2, #4
	bl	HAL_DMA_Start_IT
	ldr	r0, [sp, #16]
	mvn	r1, #64
	ldr	r0, [r0]
	str	r1, [r0]
	ldr	r0, [sp, #16]
	str	r4, [r0, #56]
	ldr	r0, [sp, #16]
	ldr	r0, [r0]
	ldr	r1, [r0, #20]
	orr	r1, r1, #128
	str	r1, [r0, #20]
	str	r4, [sp, #20]
	b	.LBB19_6
.Ltmp19:
	.size	HAL_UART_Transmit_DMA, .Ltmp19-HAL_UART_Transmit_DMA

	.globl	HAL_UART_Receive_DMA
	.align	2
	.type	HAL_UART_Receive_DMA,%function
	.code	16                      @ @HAL_UART_Receive_DMA
	.thumb_func
HAL_UART_Receive_DMA:
@ BB#0:                                 @ %entry
	push.w	{r4, r7, r11, lr}
	add	r7, sp, #4
	sub	sp, #24
	str	r0, [sp, #16]
	str	r1, [sp, #8]
	strh.w	r2, [sp, #4]
	ldr	r0, [sp, #16]
	ldr	r0, [r0, #64]
	cmp	r0, #32
	bne	.LBB20_4
@ BB#1:                                 @ %if.then
	ldr	r0, [sp, #8]
	cmp	r0, #0
	itt	ne
	ldrhne.w	r0, [sp, #4]
	cmpne	r0, #0
	bne	.LBB20_3
@ BB#2:                                 @ %if.then4
	movs	r0, #1
	b	.LBB20_5
.LBB20_3:                               @ %do.body
	ldr	r0, [sp, #16]
	ldr	r0, [r0, #56]
	cmp	r0, #1
	bne	.LBB20_7
.LBB20_4:                               @ %if.else25
	movs	r0, #2
.LBB20_5:                               @ %return
	str	r0, [sp, #20]
.LBB20_6:                               @ %return
	ldr	r0, [sp, #20]
	@APP
	boundcheckstart.HAL_UART_Receive_DMA.text.module.uart.ret:

	@NO_APP
	add	sp, #24
	pop.w	{r4, r7, r11, lr}
	push {r0}
 	movw r0, :lower16:gateway_ret_uart
 	movt r0, :upper16:gateway_ret_uart
 	bic lr,lr,#1
 	cmp lr, r0
 	beq end_of_check_HAL_UART_Receive_DMA17
 	movw r0, :lower16:.text.module.uart_start
 	movt r0, :upper16:.text.module.uart_start
 	cmp lr, r0
 	it cc
 	blcc exceptionFun
 	movw r0, :lower16:.text.module.uart_end
 	movt r0, :upper16:.text.module.uart_end
 	cmp lr, r0
 	it cs
 	blcs exceptionFun
end_of_check_HAL_UART_Receive_DMA17:
	pop {r0}
 	orr lr,lr,#1
	bx	lr
.LBB20_7:                               @ %do.end24
	ldr	r0, [sp, #16]
	movs	r1, #1
	movs	r4, #0
	str	r1, [r0, #56]
	ldr	r0, [sp, #16]
	ldr	r1, [sp, #8]
	str	r1, [r0, #40]
	ldr	r0, [sp, #16]
	ldrh.w	r1, [sp, #4]
	strh	r1, [r0, #44]
	movs	r1, #34
	ldr	r0, [sp, #16]
	str	r4, [r0, #68]
	ldr	r0, [sp, #16]
	str	r1, [r0, #64]
	movw	r1, :lower16:UART_DMAReceiveCplt
	ldr	r0, [sp, #16]
	movt	r1, :upper16:UART_DMAReceiveCplt
	ldr	r0, [r0, #52]
	str	r1, [r0, #64]
	movw	r1, :lower16:UART_DMARxHalfCplt
	ldr	r0, [sp, #16]
	movt	r1, :upper16:UART_DMARxHalfCplt
	ldr	r0, [r0, #52]
	str	r1, [r0, #68]
	movw	r1, :lower16:UART_DMAError
	ldr	r0, [sp, #16]
	movt	r1, :upper16:UART_DMAError
	ldr	r0, [r0, #52]
	str	r1, [r0, #80]
	ldr	r0, [sp, #16]
	ldr	r0, [r0, #52]
	str	r4, [r0, #84]
	add	r0, sp, #8
	str	r0, [sp]
	ldr	r0, [sp, #16]
	ldrh.w	r3, [sp, #4]
	ldr	r2, [sp, #8]
	ldr	r1, [r0]
	ldr	r0, [r0, #52]
	adds	r1, #4
	bl	HAL_DMA_Start_IT
	ldr	r0, [sp, #16]
	ldr	r0, [r0]
	ldr	r1, [r0, #12]
	orr	r1, r1, #256
	str	r1, [r0, #12]
	ldr	r0, [sp, #16]
	ldr	r0, [r0]
	ldr	r1, [r0, #20]
	orr	r1, r1, #1
	str	r1, [r0, #20]
	ldr	r0, [sp, #16]
	ldr	r0, [r0]
	ldr	r1, [r0, #20]
	orr	r1, r1, #64
	str	r1, [r0, #20]
	ldr	r0, [sp, #16]
	str	r4, [r0, #56]
	str	r4, [sp, #20]
	b	.LBB20_6
.Ltmp20:
	.size	HAL_UART_Receive_DMA, .Ltmp20-HAL_UART_Receive_DMA

	.globl	HAL_UART_DMAPause
	.align	2
	.type	HAL_UART_DMAPause,%function
	.code	16                      @ @HAL_UART_DMAPause
	.thumb_func
HAL_UART_DMAPause:
@ BB#0:                                 @ %do.body
	sub	sp, #16
	str	r0, [sp, #8]
	movs	r0, #0
	str	r0, [sp, #4]
	ldr	r0, [sp, #8]
	ldr	r0, [r0, #56]
	cmp	r0, #1
	bne	.LBB21_2
@ BB#1:                                 @ %if.then
	movs	r0, #2
	str	r0, [sp, #12]
	b	.LBB21_8
.LBB21_2:                               @ %do.end
	ldr	r0, [sp, #8]
	movs	r1, #1
	str	r1, [r0, #56]
	ldr	r0, [sp, #8]
	ldr	r0, [r0]
	ldr	r0, [r0, #20]
	and	r0, r0, #128
	lsrs	r0, r0, #7
	str	r0, [sp, #4]
	ldr	r0, [sp, #8]
	ldr	r0, [r0, #60]
	cmp	r0, #33
	bne	.LBB21_4
@ BB#3:                                 @ %land.lhs.true
	ldr	r0, [sp, #4]
	cmp	r0, #0
	itttt	ne
	ldrne	r0, [sp, #8]
	ldrne	r0, [r0]
	ldrne	r1, [r0, #20]
	bicne	r1, r1, #128
	it	ne
	strne	r1, [r0, #20]
.LBB21_4:                               @ %if.end9
	ldr	r0, [sp, #8]
	ldr	r0, [r0]
	ldr	r0, [r0, #20]
	and	r0, r0, #64
	lsrs	r0, r0, #6
	str	r0, [sp, #4]
	ldr	r0, [sp, #8]
	ldr	r0, [r0, #64]
	cmp	r0, #34
	bne	.LBB21_7
@ BB#5:                                 @ %land.lhs.true17
	ldr	r0, [sp, #4]
	cbz	r0, .LBB21_7
@ BB#6:                                 @ %if.then19
	ldr	r0, [sp, #8]
	ldr	r0, [r0]
	ldr	r1, [r0, #12]
	bic	r1, r1, #256
	str	r1, [r0, #12]
	ldr	r0, [sp, #8]
	ldr	r0, [r0]
	ldr	r1, [r0, #20]
	bic	r1, r1, #1
	str	r1, [r0, #20]
	ldr	r0, [sp, #8]
	ldr	r0, [r0]
	ldr	r1, [r0, #20]
	bic	r1, r1, #64
	str	r1, [r0, #20]
.LBB21_7:                               @ %do.end31
	ldr	r0, [sp, #8]
	movs	r1, #0
	str	r1, [r0, #56]
	str	r1, [sp, #12]
.LBB21_8:                               @ %return
	ldr	r0, [sp, #12]
	@APP
	boundcheckstart.HAL_UART_DMAPause.text.module.uart.ret:

	@NO_APP
	add	sp, #16
	push {r0}
 	movw r0, :lower16:gateway_ret_uart
 	movt r0, :upper16:gateway_ret_uart
 	bic lr,lr,#1
 	cmp lr, r0
 	beq end_of_check_HAL_UART_DMAPause20
 	movw r0, :lower16:.text.module.uart_start
 	movt r0, :upper16:.text.module.uart_start
 	cmp lr, r0
 	it cc
 	blcc exceptionFun
 	movw r0, :lower16:.text.module.uart_end
 	movt r0, :upper16:.text.module.uart_end
 	cmp lr, r0
 	it cs
 	blcs exceptionFun
end_of_check_HAL_UART_DMAPause20:
	pop {r0}
 	orr lr,lr,#1
	bx	lr
.Ltmp21:
	.size	HAL_UART_DMAPause, .Ltmp21-HAL_UART_DMAPause

	.globl	HAL_UART_DMAResume
	.align	2
	.type	HAL_UART_DMAResume,%function
	.code	16                      @ @HAL_UART_DMAResume
	.thumb_func
HAL_UART_DMAResume:
@ BB#0:                                 @ %do.body
	sub	sp, #16
	str	r0, [sp, #8]
	ldr	r0, [r0, #56]
	cmp	r0, #1
	bne	.LBB22_2
@ BB#1:                                 @ %if.then
	movs	r0, #2
	str	r0, [sp, #12]
	b	.LBB22_7
.LBB22_2:                               @ %do.end
	ldr	r0, [sp, #8]
	movs	r1, #1
	str	r1, [r0, #56]
	ldr	r0, [sp, #8]
	ldr	r0, [r0, #60]
	cmp	r0, #33
	bne	.LBB22_4
@ BB#3:                                 @ %if.then3
	ldr	r0, [sp, #8]
	ldr	r0, [r0]
	ldr	r1, [r0, #20]
	orr	r1, r1, #128
	str	r1, [r0, #20]
.LBB22_4:                               @ %if.end4
	ldr	r0, [sp, #8]
	ldr	r0, [r0, #64]
	cmp	r0, #34
	bne	.LBB22_6
@ BB#5:                                 @ %do.end10
	movs	r0, #0
	str	r0, [sp, #4]
	ldr	r0, [sp, #8]
	ldr	r0, [r0]
	ldr	r0, [r0]
	str	r0, [sp, #4]
	ldr	r0, [sp, #8]
	ldr	r0, [r0]
	ldr	r0, [r0, #4]
	str	r0, [sp, #4]
	ldr	r0, [sp, #4]
	ldr	r0, [sp, #8]
	ldr	r0, [r0]
	ldr	r1, [r0, #12]
	orr	r1, r1, #256
	str	r1, [r0, #12]
	ldr	r0, [sp, #8]
	ldr	r0, [r0]
	ldr	r1, [r0, #20]
	orr	r1, r1, #1
	str	r1, [r0, #20]
	ldr	r0, [sp, #8]
	ldr	r0, [r0]
	ldr	r1, [r0, #20]
	orr	r1, r1, #64
	str	r1, [r0, #20]
.LBB22_6:                               @ %do.end22
	ldr	r0, [sp, #8]
	movs	r1, #0
	str	r1, [r0, #56]
	str	r1, [sp, #12]
.LBB22_7:                               @ %return
	ldr	r0, [sp, #12]
	@APP
	boundcheckstart.HAL_UART_DMAResume.text.module.uart.ret:

	@NO_APP
	add	sp, #16
	push {r0}
 	movw r0, :lower16:gateway_ret_uart
 	movt r0, :upper16:gateway_ret_uart
 	bic lr,lr,#1
 	cmp lr, r0
 	beq end_of_check_HAL_UART_DMAResume21
 	movw r0, :lower16:.text.module.uart_start
 	movt r0, :upper16:.text.module.uart_start
 	cmp lr, r0
 	it cc
 	blcc exceptionFun
 	movw r0, :lower16:.text.module.uart_end
 	movt r0, :upper16:.text.module.uart_end
 	cmp lr, r0
 	it cs
 	blcs exceptionFun
end_of_check_HAL_UART_DMAResume21:
	pop {r0}
 	orr lr,lr,#1
	bx	lr
.Ltmp22:
	.size	HAL_UART_DMAResume, .Ltmp22-HAL_UART_DMAResume

	.globl	HAL_UART_DMAStop
	.align	2
	.type	HAL_UART_DMAStop,%function
	.code	16                      @ @HAL_UART_DMAStop
	.thumb_func
HAL_UART_DMAStop:
@ BB#0:                                 @ %entry
	push	{r7, lr}
	mov	r7, sp
	sub	sp, #16
	str	r0, [sp, #8]
	movs	r0, #0
	str	r0, [sp, #4]
	ldr	r0, [sp, #8]
	ldr	r0, [r0]
	ldr	r0, [r0, #20]
	and	r0, r0, #128
	lsrs	r0, r0, #7
	str	r0, [sp, #4]
	ldr	r0, [sp, #8]
	ldr	r0, [r0, #60]
	cmp	r0, #33
	bne	.LBB23_5
@ BB#1:                                 @ %land.lhs.true
	ldr	r0, [sp, #4]
	cbz	r0, .LBB23_5
@ BB#2:                                 @ %if.then
	ldr	r0, [sp, #8]
	ldr	r0, [r0]
	ldr	r1, [r0, #20]
	bic	r1, r1, #128
	str	r1, [r0, #20]
	ldr	r0, [sp, #8]
	ldr	r0, [r0, #48]
	cbz	r0, .LBB23_4
@ BB#3:                                 @ %if.then8
	ldr	r0, [sp, #8]
	ldr	r0, [r0, #48]
	bl	HAL_DMA_Abort
.LBB23_4:                               @ %if.end
	ldr	r0, [sp, #8]
	bl	UART_EndTxTransfer
.LBB23_5:                               @ %if.end10
	ldr	r0, [sp, #8]
	ldr	r0, [r0]
	ldr	r0, [r0, #20]
	and	r0, r0, #64
	lsrs	r0, r0, #6
	str	r0, [sp, #4]
	ldr	r0, [sp, #8]
	ldr	r0, [r0, #64]
	cmp	r0, #34
	bne	.LBB23_10
@ BB#6:                                 @ %land.lhs.true18
	ldr	r0, [sp, #4]
	cbz	r0, .LBB23_10
@ BB#7:                                 @ %if.then20
	ldr	r0, [sp, #8]
	ldr	r0, [r0]
	ldr	r1, [r0, #20]
	bic	r1, r1, #64
	str	r1, [r0, #20]
	ldr	r0, [sp, #8]
	ldr	r0, [r0, #52]
	cbz	r0, .LBB23_9
@ BB#8:                                 @ %if.then26
	ldr	r0, [sp, #8]
	ldr	r0, [r0, #52]
	bl	HAL_DMA_Abort
.LBB23_9:                               @ %if.end29
	ldr	r0, [sp, #8]
	bl	UART_EndRxTransfer
.LBB23_10:                              @ %if.end30
	@APP
	boundcheckstart.HAL_UART_DMAStop.text.module.uart.ret:

	@NO_APP
	movs	r0, #0
	add	sp, #16
	pop	{r7, lr}
	push {r0}
 	movw r0, :lower16:gateway_ret_uart
 	movt r0, :upper16:gateway_ret_uart
 	bic lr,lr,#1
 	cmp lr, r0
 	beq end_of_check_HAL_UART_DMAStop22
 	movw r0, :lower16:.text.module.uart_start
 	movt r0, :upper16:.text.module.uart_start
 	cmp lr, r0
 	it cc
 	blcc exceptionFun
 	movw r0, :lower16:.text.module.uart_end
 	movt r0, :upper16:.text.module.uart_end
 	cmp lr, r0
 	it cs
 	blcs exceptionFun
end_of_check_HAL_UART_DMAStop22:
	pop {r0}
 	orr lr,lr,#1
	bx	lr
.Ltmp23:
	.size	HAL_UART_DMAStop, .Ltmp23-HAL_UART_DMAStop

	.globl	HAL_UART_IRQHandler
	.align	2
	.type	HAL_UART_IRQHandler,%function
	.code	16                      @ @HAL_UART_IRQHandler
	.thumb_func
HAL_UART_IRQHandler:
@ BB#0:                                 @ %entry
	push	{r7, lr}
	mov	r7, sp
	sub	sp, #32
	str	r0, [sp, #24]
	ldr	r0, [r0]
	ldr	r0, [r0]
	str	r0, [sp, #20]
	ldr	r0, [sp, #24]
	ldr	r0, [r0]
	ldr	r0, [r0, #12]
	str	r0, [sp, #16]
	ldr	r0, [sp, #24]
	ldr	r0, [r0]
	ldr	r0, [r0, #20]
	str	r0, [sp, #12]
	movs	r0, #0
	str	r0, [sp, #8]
	str	r0, [sp, #4]
	ldr	r0, [sp, #20]
	ands	r0, r0, #15
	str	r0, [sp, #8]
	bne	.LBB24_3
@ BB#1:                                 @ %if.then
	ldrb.w	r0, [sp, #20]
	tst.w	r0, #32
	itt	ne
	ldrbne.w	r0, [sp, #16]
	tstne.w	r0, #32
	beq	.LBB24_3
@ BB#2:                                 @ %if.then7
	ldr	r0, [sp, #24]
	bl	UART_Receive_IT
	b	.LBB24_29
.LBB24_3:                               @ %if.end8
	ldr	r0, [sp, #8]
	cmp	r0, #0
	beq.w	.LBB24_23
@ BB#4:                                 @ %land.lhs.true10
	ldrb.w	r0, [sp, #12]
	tst.w	r0, #1
	bne	.LBB24_6
@ BB#5:                                 @ %lor.lhs.false
	ldrh.w	r0, [sp, #16]
	tst.w	r0, #288
	beq.w	.LBB24_23
.LBB24_6:                               @ %if.then15
	ldrb.w	r0, [sp, #20]
	tst.w	r0, #1
	beq	.LBB24_8
@ BB#7:                                 @ %land.lhs.true18
	ldrb.w	r0, [sp, #17]
	tst.w	r0, #1
	itttt	ne
	ldrne	r0, [sp, #24]
	ldrne	r1, [r0, #68]
	orrne	r1, r1, #1
	strne	r1, [r0, #68]
.LBB24_8:                               @ %if.end22
	ldrb.w	r0, [sp, #20]
	tst.w	r0, #4
	beq	.LBB24_10
@ BB#9:                                 @ %land.lhs.true25
	ldrb.w	r0, [sp, #12]
	tst.w	r0, #1
	itttt	ne
	ldrne	r0, [sp, #24]
	ldrne	r1, [r0, #68]
	orrne	r1, r1, #2
	strne	r1, [r0, #68]
.LBB24_10:                              @ %if.end31
	ldrb.w	r0, [sp, #20]
	tst.w	r0, #2
	beq	.LBB24_12
@ BB#11:                                @ %land.lhs.true34
	ldrb.w	r0, [sp, #12]
	tst.w	r0, #1
	itttt	ne
	ldrne	r0, [sp, #24]
	ldrne	r1, [r0, #68]
	orrne	r1, r1, #4
	strne	r1, [r0, #68]
.LBB24_12:                              @ %if.end40
	ldrb.w	r0, [sp, #20]
	tst.w	r0, #8
	beq	.LBB24_14
@ BB#13:                                @ %land.lhs.true43
	ldrb.w	r0, [sp, #12]
	tst.w	r0, #1
	itttt	ne
	ldrne	r0, [sp, #24]
	ldrne	r1, [r0, #68]
	orrne	r1, r1, #8
	strne	r1, [r0, #68]
.LBB24_14:                              @ %if.end49
	ldr	r0, [sp, #24]
	ldr	r0, [r0, #68]
	cmp	r0, #0
	beq.w	.LBB24_29
@ BB#15:                                @ %if.then52
	ldrb.w	r0, [sp, #20]
	tst.w	r0, #32
	beq	.LBB24_17
@ BB#16:                                @ %land.lhs.true55
	ldrb.w	r0, [sp, #16]
	tst.w	r0, #32
	itt	ne
	ldrne	r0, [sp, #24]
	blne	UART_Receive_IT
.LBB24_17:                              @ %if.end60
	ldr	r0, [sp, #24]
	ldr	r0, [r0]
	ldr	r0, [r0, #20]
	and	r0, r0, #64
	lsrs	r0, r0, #6
	str	r0, [sp, #4]
	ldr	r0, [sp, #24]
	ldr	r0, [r0, #68]
	tst.w	r0, #8
	bne	.LBB24_19
@ BB#18:                                @ %lor.lhs.false69
	ldr	r0, [sp, #4]
	cmp	r0, #0
	beq	.LBB24_28
.LBB24_19:                              @ %if.then70
	ldr	r0, [sp, #24]
	bl	UART_EndRxTransfer
	ldr	r0, [sp, #24]
	ldr	r0, [r0]
	ldr	r0, [r0, #20]
	tst.w	r0, #64
	beq	.LBB24_27
@ BB#20:                                @ %if.then76
	ldr	r0, [sp, #24]
	ldr	r0, [r0]
	ldr	r1, [r0, #20]
	bic	r1, r1, #64
	str	r1, [r0, #20]
	ldr	r0, [sp, #24]
	ldr	r0, [r0, #52]
	cmp	r0, #0
	beq	.LBB24_27
@ BB#21:                                @ %if.then82
	ldr	r0, [sp, #24]
	movw	r1, :lower16:UART_DMAAbortOnError
	movt	r1, :upper16:UART_DMAAbortOnError
	ldr	r0, [r0, #52]
	str	r1, [r0, #84]
	ldr	r0, [sp, #24]
	ldr	r0, [r0, #52]
	bl	HAL_DMA_Abort_IT
	cmp	r0, #0
	beq	.LBB24_29
@ BB#22:                                @ %if.then88
	ldr	r0, [sp, #24]
	ldr	r0, [r0, #52]
	ldr	r1, [r0, #84]
	@APP
	boundcheckstart.HAL_UART_IRQHandler.text.module.uart.indirect_0:

	@NO_APP
	push {lr}
 	mov lr, r0
	push {r0}
 	movw r0, :lower16:.text.module.uart_start
 	movt r0, :upper16:.text.module.uart_start
 	cmp lr, r0
 	it cc
	blcc exceptionFun
 	movw r0, :lower16:.text.module.uart_end
 	movt r0, :upper16:.text.module.uart_end
 	cmp lr, r0
 	it cs
 	blcs exceptionFun
 	pop {r0}
	pop {lr}
	blx	r1
	b	.LBB24_29
.LBB24_23:                              @ %if.end100
	ldrb.w	r0, [sp, #20]
	tst.w	r0, #128
	itt	ne
	ldrbne.w	r0, [sp, #16]
	tstne.w	r0, #128
	beq	.LBB24_25
@ BB#24:                                @ %if.then108
	ldr	r0, [sp, #24]
	bl	UART_Transmit_IT
	b	.LBB24_29
.LBB24_25:                              @ %if.end110
	ldrb.w	r0, [sp, #20]
	tst.w	r0, #64
	beq	.LBB24_29
@ BB#26:                                @ %land.lhs.true114
	ldrb.w	r0, [sp, #16]
	tst.w	r0, #64
	itt	ne
	ldrne	r0, [sp, #24]
	blne	UART_EndTransmit_IT
	b	.LBB24_29
.LBB24_27:                              @ %if.else94
	ldr	r0, [sp, #24]
	bl	HAL_UART_ErrorCallback
	b	.LBB24_29
.LBB24_28:                              @ %if.else96
	ldr	r0, [sp, #24]
	bl	HAL_UART_ErrorCallback
	ldr	r0, [sp, #24]
	movs	r1, #0
	str	r1, [r0, #68]
.LBB24_29:                              @ %if.end120
	@APP
	boundcheckstart.HAL_UART_IRQHandler.text.module.uart.ret:

	@NO_APP
	add	sp, #32
	pop	{r7, lr}
	push {r0}
 	movw r0, :lower16:gateway_ret_uart
 	movt r0, :upper16:gateway_ret_uart
 	bic lr,lr,#1
 	cmp lr, r0
 	beq end_of_check_HAL_UART_IRQHandler25
 	movw r0, :lower16:.text.module.uart_start
 	movt r0, :upper16:.text.module.uart_start
 	cmp lr, r0
 	it cc
 	blcc exceptionFun
 	movw r0, :lower16:.text.module.uart_end
 	movt r0, :upper16:.text.module.uart_end
 	cmp lr, r0
 	it cs
 	blcs exceptionFun
end_of_check_HAL_UART_IRQHandler25:
	pop {r0}
 	orr lr,lr,#1
	bx	lr
.Ltmp24:
	.size	HAL_UART_IRQHandler, .Ltmp24-HAL_UART_IRQHandler

	.weak	HAL_UART_ErrorCallback
	.align	2
	.type	HAL_UART_ErrorCallback,%function
	.code	16                      @ @HAL_UART_ErrorCallback
	.thumb_func
HAL_UART_ErrorCallback:
@ BB#0:                                 @ %entry
	sub	sp, #8
	str	r0, [sp]
	@APP
	boundcheckstart.HAL_UART_ErrorCallback.text.module.uart.ret:

	@NO_APP
	add	sp, #8
	push {r0}
 	movw r0, :lower16:gateway_ret_uart
 	movt r0, :upper16:gateway_ret_uart
 	bic lr,lr,#1
 	cmp lr, r0
 	beq end_of_check_HAL_UART_ErrorCallback28
 	movw r0, :lower16:.text.module.uart_start
 	movt r0, :upper16:.text.module.uart_start
 	cmp lr, r0
 	it cc
 	blcc exceptionFun
 	movw r0, :lower16:.text.module.uart_end
 	movt r0, :upper16:.text.module.uart_end
 	cmp lr, r0
 	it cs
 	blcs exceptionFun
end_of_check_HAL_UART_ErrorCallback28:
	pop {r0}
 	orr lr,lr,#1
	bx	lr
.Ltmp25:
	.size	HAL_UART_ErrorCallback, .Ltmp25-HAL_UART_ErrorCallback

	.weak	HAL_UART_TxCpltCallback
	.align	2
	.type	HAL_UART_TxCpltCallback,%function
	.code	16                      @ @HAL_UART_TxCpltCallback
	.thumb_func
HAL_UART_TxCpltCallback:
@ BB#0:                                 @ %entry
	sub	sp, #8
	str	r0, [sp]
	@APP
	boundcheckstart.HAL_UART_TxCpltCallback.text.module.uart.ret:

	@NO_APP
	add	sp, #8
	push {r0}
 	movw r0, :lower16:gateway_ret_uart
 	movt r0, :upper16:gateway_ret_uart
 	bic lr,lr,#1
 	cmp lr, r0
 	beq end_of_check_HAL_UART_TxCpltCallback31
 	movw r0, :lower16:.text.module.uart_start
 	movt r0, :upper16:.text.module.uart_start
 	cmp lr, r0
 	it cc
 	blcc exceptionFun
 	movw r0, :lower16:.text.module.uart_end
 	movt r0, :upper16:.text.module.uart_end
 	cmp lr, r0
 	it cs
 	blcs exceptionFun
end_of_check_HAL_UART_TxCpltCallback31:
	pop {r0}
 	orr lr,lr,#1
	bx	lr
.Ltmp26:
	.size	HAL_UART_TxCpltCallback, .Ltmp26-HAL_UART_TxCpltCallback

	.weak	HAL_UART_TxHalfCpltCallback
	.align	2
	.type	HAL_UART_TxHalfCpltCallback,%function
	.code	16                      @ @HAL_UART_TxHalfCpltCallback
	.thumb_func
HAL_UART_TxHalfCpltCallback:
@ BB#0:                                 @ %entry
	sub	sp, #8
	str	r0, [sp]
	@APP
	boundcheckstart.HAL_UART_TxHalfCpltCallback.text.module.uart.ret:

	@NO_APP
	add	sp, #8
	push {r0}
 	movw r0, :lower16:gateway_ret_uart
 	movt r0, :upper16:gateway_ret_uart
 	bic lr,lr,#1
 	cmp lr, r0
 	beq end_of_check_HAL_UART_TxHalfCpltCallback32
 	movw r0, :lower16:.text.module.uart_start
 	movt r0, :upper16:.text.module.uart_start
 	cmp lr, r0
 	it cc
 	blcc exceptionFun
 	movw r0, :lower16:.text.module.uart_end
 	movt r0, :upper16:.text.module.uart_end
 	cmp lr, r0
 	it cs
 	blcs exceptionFun
end_of_check_HAL_UART_TxHalfCpltCallback32:
	pop {r0}
 	orr lr,lr,#1
	bx	lr
.Ltmp27:
	.size	HAL_UART_TxHalfCpltCallback, .Ltmp27-HAL_UART_TxHalfCpltCallback

	.weak	HAL_UART_RxCpltCallback
	.align	2
	.type	HAL_UART_RxCpltCallback,%function
	.code	16                      @ @HAL_UART_RxCpltCallback
	.thumb_func
HAL_UART_RxCpltCallback:
@ BB#0:                                 @ %entry
	sub	sp, #8
	str	r0, [sp]
	@APP
	boundcheckstart.HAL_UART_RxCpltCallback.text.module.uart.ret:

	@NO_APP
	add	sp, #8
	push {r0}
 	movw r0, :lower16:gateway_ret_uart
 	movt r0, :upper16:gateway_ret_uart
 	bic lr,lr,#1
 	cmp lr, r0
 	beq end_of_check_HAL_UART_RxCpltCallback33
 	movw r0, :lower16:.text.module.uart_start
 	movt r0, :upper16:.text.module.uart_start
 	cmp lr, r0
 	it cc
 	blcc exceptionFun
 	movw r0, :lower16:.text.module.uart_end
 	movt r0, :upper16:.text.module.uart_end
 	cmp lr, r0
 	it cs
 	blcs exceptionFun
end_of_check_HAL_UART_RxCpltCallback33:
	pop {r0}
 	orr lr,lr,#1
	bx	lr
.Ltmp28:
	.size	HAL_UART_RxCpltCallback, .Ltmp28-HAL_UART_RxCpltCallback

	.weak	HAL_UART_RxHalfCpltCallback
	.align	2
	.type	HAL_UART_RxHalfCpltCallback,%function
	.code	16                      @ @HAL_UART_RxHalfCpltCallback
	.thumb_func
HAL_UART_RxHalfCpltCallback:
@ BB#0:                                 @ %entry
	sub	sp, #8
	str	r0, [sp]
	@APP
	boundcheckstart.HAL_UART_RxHalfCpltCallback.text.module.uart.ret:

	@NO_APP
	add	sp, #8
	push {r0}
 	movw r0, :lower16:gateway_ret_uart
 	movt r0, :upper16:gateway_ret_uart
 	bic lr,lr,#1
 	cmp lr, r0
 	beq end_of_check_HAL_UART_RxHalfCpltCallback34
 	movw r0, :lower16:.text.module.uart_start
 	movt r0, :upper16:.text.module.uart_start
 	cmp lr, r0
 	it cc
 	blcc exceptionFun
 	movw r0, :lower16:.text.module.uart_end
 	movt r0, :upper16:.text.module.uart_end
 	cmp lr, r0
 	it cs
 	blcs exceptionFun
end_of_check_HAL_UART_RxHalfCpltCallback34:
	pop {r0}
 	orr lr,lr,#1
	bx	lr
.Ltmp29:
	.size	HAL_UART_RxHalfCpltCallback, .Ltmp29-HAL_UART_RxHalfCpltCallback

	.globl	HAL_LIN_SendBreak
	.align	2
	.type	HAL_LIN_SendBreak,%function
	.code	16                      @ @HAL_LIN_SendBreak
	.thumb_func
HAL_LIN_SendBreak:
@ BB#0:                                 @ %do.body
	sub	sp, #8
	str	r0, [sp]
	ldr	r0, [r0, #56]
	cmp	r0, #1
	bne	.LBB30_2
@ BB#1:                                 @ %if.then
	movs	r0, #2
	str	r0, [sp, #4]
	b	.LBB30_3
.LBB30_2:                               @ %do.end5
	ldr	r0, [sp]
	movs	r1, #1
	str	r1, [r0, #56]
	movs	r1, #36
	ldr	r0, [sp]
	str	r1, [r0, #60]
	ldr	r0, [sp]
	ldr	r0, [r0]
	ldr	r1, [r0, #12]
	orr	r1, r1, #1
	str	r1, [r0, #12]
	movs	r1, #32
	ldr	r0, [sp]
	str	r1, [r0, #60]
	movs	r1, #0
	ldr	r0, [sp]
	str	r1, [r0, #56]
	str	r1, [sp, #4]
.LBB30_3:                               @ %return
	ldr	r0, [sp, #4]
	@APP
	boundcheckstart.HAL_LIN_SendBreak.text.module.uart.ret:

	@NO_APP
	add	sp, #8
	push {r0}
 	movw r0, :lower16:gateway_ret_uart
 	movt r0, :upper16:gateway_ret_uart
 	bic lr,lr,#1
 	cmp lr, r0
 	beq end_of_check_HAL_LIN_SendBreak35
 	movw r0, :lower16:.text.module.uart_start
 	movt r0, :upper16:.text.module.uart_start
 	cmp lr, r0
 	it cc
 	blcc exceptionFun
 	movw r0, :lower16:.text.module.uart_end
 	movt r0, :upper16:.text.module.uart_end
 	cmp lr, r0
 	it cs
 	blcs exceptionFun
end_of_check_HAL_LIN_SendBreak35:
	pop {r0}
 	orr lr,lr,#1
	bx	lr
.Ltmp30:
	.size	HAL_LIN_SendBreak, .Ltmp30-HAL_LIN_SendBreak

	.globl	HAL_MultiProcessor_EnterMuteMode
	.align	2
	.type	HAL_MultiProcessor_EnterMuteMode,%function
	.code	16                      @ @HAL_MultiProcessor_EnterMuteMode
	.thumb_func
HAL_MultiProcessor_EnterMuteMode:
@ BB#0:                                 @ %do.body
	sub	sp, #8
	str	r0, [sp]
	ldr	r0, [r0, #56]
	cmp	r0, #1
	bne	.LBB31_2
@ BB#1:                                 @ %if.then
	movs	r0, #2
	str	r0, [sp, #4]
	b	.LBB31_3
.LBB31_2:                               @ %do.end5
	ldr	r0, [sp]
	movs	r1, #1
	str	r1, [r0, #56]
	movs	r1, #36
	ldr	r0, [sp]
	str	r1, [r0, #60]
	ldr	r0, [sp]
	ldr	r0, [r0]
	ldr	r1, [r0, #12]
	orr	r1, r1, #2
	str	r1, [r0, #12]
	movs	r1, #32
	ldr	r0, [sp]
	str	r1, [r0, #60]
	movs	r1, #0
	ldr	r0, [sp]
	str	r1, [r0, #56]
	str	r1, [sp, #4]
.LBB31_3:                               @ %return
	ldr	r0, [sp, #4]
	@APP
	boundcheckstart.HAL_MultiProcessor_EnterMuteMode.text.module.uart.ret:

	@NO_APP
	add	sp, #8
	push {r0}
 	movw r0, :lower16:gateway_ret_uart
 	movt r0, :upper16:gateway_ret_uart
 	bic lr,lr,#1
 	cmp lr, r0
 	beq end_of_check_HAL_MultiProcessor_EnterMuteMode36
 	movw r0, :lower16:.text.module.uart_start
 	movt r0, :upper16:.text.module.uart_start
 	cmp lr, r0
 	it cc
 	blcc exceptionFun
 	movw r0, :lower16:.text.module.uart_end
 	movt r0, :upper16:.text.module.uart_end
 	cmp lr, r0
 	it cs
 	blcs exceptionFun
end_of_check_HAL_MultiProcessor_EnterMuteMode36:
	pop {r0}
 	orr lr,lr,#1
	bx	lr
.Ltmp31:
	.size	HAL_MultiProcessor_EnterMuteMode, .Ltmp31-HAL_MultiProcessor_EnterMuteMode

	.globl	HAL_MultiProcessor_ExitMuteMode
	.align	2
	.type	HAL_MultiProcessor_ExitMuteMode,%function
	.code	16                      @ @HAL_MultiProcessor_ExitMuteMode
	.thumb_func
HAL_MultiProcessor_ExitMuteMode:
@ BB#0:                                 @ %do.body
	sub	sp, #8
	str	r0, [sp]
	ldr	r0, [r0, #56]
	cmp	r0, #1
	bne	.LBB32_2
@ BB#1:                                 @ %if.then
	movs	r0, #2
	str	r0, [sp, #4]
	b	.LBB32_3
.LBB32_2:                               @ %do.end5
	ldr	r0, [sp]
	movs	r1, #1
	str	r1, [r0, #56]
	movs	r1, #36
	ldr	r0, [sp]
	str	r1, [r0, #60]
	ldr	r0, [sp]
	ldr	r0, [r0]
	ldr	r1, [r0, #12]
	bic	r1, r1, #2
	str	r1, [r0, #12]
	movs	r1, #32
	ldr	r0, [sp]
	str	r1, [r0, #60]
	movs	r1, #0
	ldr	r0, [sp]
	str	r1, [r0, #56]
	str	r1, [sp, #4]
.LBB32_3:                               @ %return
	ldr	r0, [sp, #4]
	@APP
	boundcheckstart.HAL_MultiProcessor_ExitMuteMode.text.module.uart.ret:

	@NO_APP
	add	sp, #8
	push {r0}
 	movw r0, :lower16:gateway_ret_uart
 	movt r0, :upper16:gateway_ret_uart
 	bic lr,lr,#1
 	cmp lr, r0
 	beq end_of_check_HAL_MultiProcessor_ExitMuteMode37
 	movw r0, :lower16:.text.module.uart_start
 	movt r0, :upper16:.text.module.uart_start
 	cmp lr, r0
 	it cc
 	blcc exceptionFun
 	movw r0, :lower16:.text.module.uart_end
 	movt r0, :upper16:.text.module.uart_end
 	cmp lr, r0
 	it cs
 	blcs exceptionFun
end_of_check_HAL_MultiProcessor_ExitMuteMode37:
	pop {r0}
 	orr lr,lr,#1
	bx	lr
.Ltmp32:
	.size	HAL_MultiProcessor_ExitMuteMode, .Ltmp32-HAL_MultiProcessor_ExitMuteMode

	.globl	HAL_HalfDuplex_EnableTransmitter
	.align	2
	.type	HAL_HalfDuplex_EnableTransmitter,%function
	.code	16                      @ @HAL_HalfDuplex_EnableTransmitter
	.thumb_func
HAL_HalfDuplex_EnableTransmitter:
@ BB#0:                                 @ %do.body
	sub	sp, #16
	str	r0, [sp, #8]
	movs	r0, #0
	ldr	r1, [sp, #8]
	str	r0, [sp, #4]
	ldr	r1, [r1, #56]
	cmp	r1, #1
	bne	.LBB33_2
@ BB#1:                                 @ %if.then
	movs	r0, #2
	b	.LBB33_3
.LBB33_2:                               @ %do.end7
	ldr	r1, [sp, #8]
	movs	r2, #1
	str	r2, [r1, #56]
	movs	r2, #36
	ldr	r1, [sp, #8]
	str	r2, [r1, #60]
	ldr	r1, [sp, #8]
	ldr	r1, [r1]
	ldr	r1, [r1, #12]
	ldr	r2, [sp, #8]
	str	r1, [sp, #4]
	bic	r1, r1, #12
	str	r1, [sp, #4]
	orr	r1, r1, #8
	str	r1, [sp, #4]
	ldr	r2, [r2]
	str	r1, [r2, #12]
	movs	r2, #32
	ldr	r1, [sp, #8]
	str	r2, [r1, #60]
	ldr	r1, [sp, #8]
	str	r0, [r1, #56]
.LBB33_3:                               @ %return
	str	r0, [sp, #12]
	ldr	r0, [sp, #12]
	@APP
	boundcheckstart.HAL_HalfDuplex_EnableTransmitter.text.module.uart.ret:

	@NO_APP
	add	sp, #16
	push {r0}
 	movw r0, :lower16:gateway_ret_uart
 	movt r0, :upper16:gateway_ret_uart
 	bic lr,lr,#1
 	cmp lr, r0
 	beq end_of_check_HAL_HalfDuplex_EnableTransmitter38
 	movw r0, :lower16:.text.module.uart_start
 	movt r0, :upper16:.text.module.uart_start
 	cmp lr, r0
 	it cc
 	blcc exceptionFun
 	movw r0, :lower16:.text.module.uart_end
 	movt r0, :upper16:.text.module.uart_end
 	cmp lr, r0
 	it cs
 	blcs exceptionFun
end_of_check_HAL_HalfDuplex_EnableTransmitter38:
	pop {r0}
 	orr lr,lr,#1
	bx	lr
.Ltmp33:
	.size	HAL_HalfDuplex_EnableTransmitter, .Ltmp33-HAL_HalfDuplex_EnableTransmitter

	.globl	HAL_HalfDuplex_EnableReceiver
	.align	2
	.type	HAL_HalfDuplex_EnableReceiver,%function
	.code	16                      @ @HAL_HalfDuplex_EnableReceiver
	.thumb_func
HAL_HalfDuplex_EnableReceiver:
@ BB#0:                                 @ %do.body
	sub	sp, #16
	str	r0, [sp, #8]
	movs	r0, #0
	ldr	r1, [sp, #8]
	str	r0, [sp, #4]
	ldr	r1, [r1, #56]
	cmp	r1, #1
	bne	.LBB34_2
@ BB#1:                                 @ %if.then
	movs	r0, #2
	b	.LBB34_3
.LBB34_2:                               @ %do.end7
	ldr	r1, [sp, #8]
	movs	r2, #1
	str	r2, [r1, #56]
	movs	r2, #36
	ldr	r1, [sp, #8]
	str	r2, [r1, #60]
	ldr	r1, [sp, #8]
	ldr	r1, [r1]
	ldr	r1, [r1, #12]
	ldr	r2, [sp, #8]
	str	r1, [sp, #4]
	bic	r1, r1, #12
	str	r1, [sp, #4]
	orr	r1, r1, #4
	str	r1, [sp, #4]
	ldr	r2, [r2]
	str	r1, [r2, #12]
	movs	r2, #32
	ldr	r1, [sp, #8]
	str	r2, [r1, #60]
	ldr	r1, [sp, #8]
	str	r0, [r1, #56]
.LBB34_3:                               @ %return
	str	r0, [sp, #12]
	ldr	r0, [sp, #12]
	@APP
	boundcheckstart.HAL_HalfDuplex_EnableReceiver.text.module.uart.ret:

	@NO_APP
	add	sp, #16
	push {r0}
 	movw r0, :lower16:gateway_ret_uart
 	movt r0, :upper16:gateway_ret_uart
 	bic lr,lr,#1
 	cmp lr, r0
 	beq end_of_check_HAL_HalfDuplex_EnableReceiver39
 	movw r0, :lower16:.text.module.uart_start
 	movt r0, :upper16:.text.module.uart_start
 	cmp lr, r0
 	it cc
 	blcc exceptionFun
 	movw r0, :lower16:.text.module.uart_end
 	movt r0, :upper16:.text.module.uart_end
 	cmp lr, r0
 	it cs
 	blcs exceptionFun
end_of_check_HAL_HalfDuplex_EnableReceiver39:
	pop {r0}
 	orr lr,lr,#1
	bx	lr
.Ltmp34:
	.size	HAL_HalfDuplex_EnableReceiver, .Ltmp34-HAL_HalfDuplex_EnableReceiver

	.globl	HAL_UART_GetState
	.align	2
	.type	HAL_UART_GetState,%function
	.code	16                      @ @HAL_UART_GetState
	.thumb_func
HAL_UART_GetState:
@ BB#0:                                 @ %entry
	sub	sp, #16
	str	r0, [sp, #8]
	movs	r0, #0
	str	r0, [sp, #4]
	str	r0, [sp]
	ldr	r0, [sp, #8]
	ldr	r0, [r0, #60]
	str	r0, [sp, #4]
	ldr	r0, [sp, #8]
	ldr	r0, [r0, #64]
	ldr	r1, [sp, #4]
	str	r0, [sp]
	orrs	r0, r1
	@APP
	boundcheckstart.HAL_UART_GetState.text.module.uart.ret:

	@NO_APP
	add	sp, #16
	push {r0}
 	movw r0, :lower16:gateway_ret_uart
 	movt r0, :upper16:gateway_ret_uart
 	bic lr,lr,#1
 	cmp lr, r0
 	beq end_of_check_HAL_UART_GetState40
 	movw r0, :lower16:.text.module.uart_start
 	movt r0, :upper16:.text.module.uart_start
 	cmp lr, r0
 	it cc
 	blcc exceptionFun
 	movw r0, :lower16:.text.module.uart_end
 	movt r0, :upper16:.text.module.uart_end
 	cmp lr, r0
 	it cs
 	blcs exceptionFun
end_of_check_HAL_UART_GetState40:
	pop {r0}
 	orr lr,lr,#1
	bx	lr
.Ltmp35:
	.size	HAL_UART_GetState, .Ltmp35-HAL_UART_GetState

	.globl	HAL_UART_GetError
	.align	2
	.type	HAL_UART_GetError,%function
	.code	16                      @ @HAL_UART_GetError
	.thumb_func
HAL_UART_GetError:
@ BB#0:                                 @ %entry
	sub	sp, #8
	str	r0, [sp]
	ldr	r0, [r0, #68]
	@APP
	boundcheckstart.HAL_UART_GetError.text.module.uart.ret:

	@NO_APP
	add	sp, #8
	push {r0}
 	movw r0, :lower16:gateway_ret_uart
 	movt r0, :upper16:gateway_ret_uart
 	bic lr,lr,#1
 	cmp lr, r0
 	beq end_of_check_HAL_UART_GetError41
 	movw r0, :lower16:.text.module.uart_start
 	movt r0, :upper16:.text.module.uart_start
 	cmp lr, r0
 	it cc
 	blcc exceptionFun
 	movw r0, :lower16:.text.module.uart_end
 	movt r0, :upper16:.text.module.uart_end
 	cmp lr, r0
 	it cs
 	blcs exceptionFun
end_of_check_HAL_UART_GetError41:
	pop {r0}
 	orr lr,lr,#1
	bx	lr
.Ltmp36:
	.size	HAL_UART_GetError, .Ltmp36-HAL_UART_GetError

	.section	.text.usfi,"ax",%progbits
	.globl	gateway_uart
	.align	2
	.type	gateway_uart,%function
	.code	16                      @ @gateway_uart
	.thumb_func
gateway_uart:
@ BB#0:                                 @ %entry
	@APP
		push {lr}
	svc #11 
boundcheckstart.gateway.text.module.uart.ret:
	push {r0}
 	movw r0, :lower16:.text.module.uart_start
 	movt r0, :upper16:.text.module.uart_start
 	cmp r4,r0
 	it cc
	blcc exceptionFun
 	movw r0, :lower16:.text.module.uart_end
 	movt r0, :upper16:.text.module.uart_end
 	cmp r4,r0
 	it cs
 	blcs exceptionFun
 	pop {r0}
	 blx r4
.global gateway_ret_uart
gateway_ret_uart:
	svc #255 
	pop {lr}

	@NO_APP
	bx	lr
.Ltmp37:
	.size	gateway_uart, .Ltmp37-gateway_uart

	.section	.text.module.uart,"ax",%progbits
	.align	2
	.type	UART_SetConfig,%function
	.code	16                      @ @UART_SetConfig
	.thumb_func
UART_SetConfig:
@ BB#0:                                 @ %entry
	push.w	{r4, r5, r6, r7, r8, r9, r10, r11, lr}
	add	r7, sp, #12
	sub	sp, #12
	str	r0, [sp, #8]
	movs	r0, #0
	str	r0, [sp, #4]
	ldr	r0, [sp, #8]
	ldr	r0, [r0]
	ldr	r0, [r0, #16]
	ldr	r1, [sp, #8]
	str	r0, [sp, #4]
	bic	r0, r0, #12288
	str	r0, [sp, #4]
	ldr	r1, [r1, #12]
	orrs	r0, r1
	ldr	r1, [sp, #8]
	str	r0, [sp, #4]
	ldr	r1, [r1]
	str	r0, [r1, #16]
	movw	r1, #27123
	ldr	r0, [sp, #8]
	movt	r1, #65535
	ldr	r0, [r0]
	ldr	r0, [r0, #12]
	str	r0, [sp, #4]
	ands	r0, r1
	ldr	r1, [sp, #8]
	str	r0, [sp, #4]
	ldr	r2, [r1, #8]
	ldr	r4, [r1, #16]
	ldr	r3, [r1, #20]
	ldr	r1, [r1, #28]
	orrs	r2, r4
	orrs	r2, r3
	orrs	r1, r2
	orrs	r0, r1
	ldr	r1, [sp, #8]
	str	r0, [sp, #4]
	ldr	r1, [r1]
	str	r0, [r1, #12]
	ldr	r0, [sp, #8]
	ldr	r0, [r0]
	ldr	r0, [r0, #20]
	ldr	r1, [sp, #8]
	str	r0, [sp, #4]
	bic	r0, r0, #768
	str	r0, [sp, #4]
	ldr	r1, [r1, #24]
	orrs	r0, r1
	ldr	r1, [sp, #8]
	str	r0, [sp, #4]
	ldr	r1, [r1]
	str	r0, [r1, #20]
	ldr	r0, [sp, #8]
	ldr	r0, [r0, #28]
	cmp.w	r0, #32768
	bne	.LBB38_4
@ BB#1:                                 @ %if.then
	ldr	r0, [sp, #8]
	movw	r1, #4096
	movt	r1, #16385
	ldr	r0, [r0]
	cmp	r0, r1
	beq.w	.LBB38_7
@ BB#2:                                 @ %lor.lhs.false
	ldr	r0, [sp, #8]
	movw	r1, #5120
	movt	r1, #16385
	ldr	r0, [r0]
	cmp	r0, r1
	beq.w	.LBB38_7
@ BB#3:                                 @ %if.else
	bl	HAL_RCC_GetPCLK1Freq
	mov	r8, r0
	ldr	r0, [sp, #8]
	ldr.w	r9, [r0, #4]
	bl	HAL_RCC_GetPCLK1Freq
	ldr	r1, [sp, #8]
	movs	r6, #25
	muls	r0, r6, r0
	ldr	r1, [r1, #4]
	lsls	r1, r1, #1
	udiv	r4, r0, r1
	bl	HAL_RCC_GetPCLK1Freq
	ldr	r1, [sp, #8]
	movw	r5, #34079
	muls	r0, r6, r0
	mov.w	r10, #100
	mov.w	r11, #50
	lsl.w	r2, r9, #1
	movt	r5, #20971
	ldr	r1, [r1, #4]
	lsls	r1, r1, #1
	udiv	r0, r0, r1
	umull	r0, r1, r0, r5
	lsrs	r0, r1, #5
	mls	r0, r0, r10, r4
	add.w	r0, r11, r0, lsl #3
	umull	r0, r1, r0, r5
	mov.w	r0, #496
	and.w	r0, r0, r1, lsr #4
	mul	r1, r8, r6
	udiv	r1, r1, r2
	umull	r1, r2, r1, r5
	movw	r1, #65520
	movt	r1, #32767
	and.w	r1, r1, r2, lsr #1
	add.w	r8, r1, r0
	bl	HAL_RCC_GetPCLK1Freq
	ldr	r1, [sp, #8]
	muls	r0, r6, r0
	ldr	r1, [r1, #4]
	lsls	r1, r1, #1
	udiv	r4, r0, r1
	bl	HAL_RCC_GetPCLK1Freq
	b	.LBB38_8
.LBB38_4:                               @ %if.else122
	ldr	r0, [sp, #8]
	movw	r1, #4096
	movt	r1, #16385
	ldr	r0, [r0]
	cmp	r0, r1
	beq.w	.LBB38_9
@ BB#5:                                 @ %lor.lhs.false125
	ldr	r0, [sp, #8]
	movw	r1, #5120
	movt	r1, #16385
	ldr	r0, [r0]
	cmp	r0, r1
	beq.w	.LBB38_9
@ BB#6:                                 @ %if.else179
	bl	HAL_RCC_GetPCLK1Freq
	mov	r8, r0
	ldr	r0, [sp, #8]
	ldr.w	r9, [r0, #4]
	bl	HAL_RCC_GetPCLK1Freq
	ldr	r1, [sp, #8]
	movs	r6, #25
	muls	r0, r6, r0
	ldr	r1, [r1, #4]
	lsls	r1, r1, #2
	udiv	r4, r0, r1
	bl	HAL_RCC_GetPCLK1Freq
	ldr	r1, [sp, #8]
	movw	r5, #34079
	muls	r0, r6, r0
	mov.w	r10, #100
	mov.w	r11, #50
	lsl.w	r2, r9, #2
	movt	r5, #20971
	ldr	r1, [r1, #4]
	lsls	r1, r1, #2
	udiv	r0, r0, r1
	umull	r0, r1, r0, r5
	lsrs	r0, r1, #5
	mls	r0, r0, r10, r4
	add.w	r0, r11, r0, lsl #4
	umull	r0, r1, r0, r5
	movs	r0, #240
	and.w	r0, r0, r1, lsr #5
	mul	r1, r8, r6
	udiv	r1, r1, r2
	umull	r1, r2, r1, r5
	movw	r1, #65520
	movt	r1, #32767
	and.w	r1, r1, r2, lsr #1
	add.w	r8, r1, r0
	bl	HAL_RCC_GetPCLK1Freq
	ldr	r1, [sp, #8]
	muls	r0, r6, r0
	ldr	r1, [r1, #4]
	lsls	r1, r1, #2
	udiv	r4, r0, r1
	bl	HAL_RCC_GetPCLK1Freq
	b	.LBB38_10
.LBB38_7:                               @ %if.then27
	bl	HAL_RCC_GetPCLK2Freq
	mov	r8, r0
	ldr	r0, [sp, #8]
	ldr.w	r9, [r0, #4]
	bl	HAL_RCC_GetPCLK2Freq
	ldr	r1, [sp, #8]
	movs	r6, #25
	muls	r0, r6, r0
	ldr	r1, [r1, #4]
	lsls	r1, r1, #1
	udiv	r4, r0, r1
	bl	HAL_RCC_GetPCLK2Freq
	ldr	r1, [sp, #8]
	movw	r5, #34079
	muls	r0, r6, r0
	mov.w	r10, #100
	mov.w	r11, #50
	lsl.w	r2, r9, #1
	movt	r5, #20971
	ldr	r1, [r1, #4]
	lsls	r1, r1, #1
	udiv	r0, r0, r1
	umull	r0, r1, r0, r5
	lsrs	r0, r1, #5
	mls	r0, r0, r10, r4
	add.w	r0, r11, r0, lsl #3
	umull	r0, r1, r0, r5
	mov.w	r0, #496
	and.w	r0, r0, r1, lsr #4
	mul	r1, r8, r6
	udiv	r1, r1, r2
	umull	r1, r2, r1, r5
	movw	r1, #65520
	movt	r1, #32767
	and.w	r1, r1, r2, lsr #1
	add.w	r8, r1, r0
	bl	HAL_RCC_GetPCLK2Freq
	ldr	r1, [sp, #8]
	muls	r0, r6, r0
	ldr	r1, [r1, #4]
	lsls	r1, r1, #1
	udiv	r4, r0, r1
	bl	HAL_RCC_GetPCLK2Freq
.LBB38_8:                               @ %if.end231
	ldr	r1, [sp, #8]
	muls	r0, r6, r0
	ldrd	r2, r3, [r1]
	lsls	r1, r3, #1
	udiv	r0, r0, r1
	umull	r0, r1, r0, r5
	lsrs	r0, r1, #5
	mls	r0, r0, r10, r4
	add.w	r0, r11, r0, lsl #3
	umull	r0, r1, r0, r5
	ubfx	r0, r1, #5, #3
	b	.LBB38_11
.LBB38_9:                               @ %if.then128
	bl	HAL_RCC_GetPCLK2Freq
	mov	r8, r0
	ldr	r0, [sp, #8]
	ldr.w	r9, [r0, #4]
	bl	HAL_RCC_GetPCLK2Freq
	ldr	r1, [sp, #8]
	movs	r6, #25
	muls	r0, r6, r0
	ldr	r1, [r1, #4]
	lsls	r1, r1, #2
	udiv	r4, r0, r1
	bl	HAL_RCC_GetPCLK2Freq
	ldr	r1, [sp, #8]
	movw	r5, #34079
	muls	r0, r6, r0
	mov.w	r10, #100
	mov.w	r11, #50
	lsl.w	r2, r9, #2
	movt	r5, #20971
	ldr	r1, [r1, #4]
	lsls	r1, r1, #2
	udiv	r0, r0, r1
	umull	r0, r1, r0, r5
	lsrs	r0, r1, #5
	mls	r0, r0, r10, r4
	add.w	r0, r11, r0, lsl #4
	umull	r0, r1, r0, r5
	movs	r0, #240
	and.w	r0, r0, r1, lsr #5
	mul	r1, r8, r6
	udiv	r1, r1, r2
	umull	r1, r2, r1, r5
	movw	r1, #65520
	movt	r1, #32767
	and.w	r1, r1, r2, lsr #1
	add.w	r8, r1, r0
	bl	HAL_RCC_GetPCLK2Freq
	ldr	r1, [sp, #8]
	muls	r0, r6, r0
	ldr	r1, [r1, #4]
	lsls	r1, r1, #2
	udiv	r4, r0, r1
	bl	HAL_RCC_GetPCLK2Freq
.LBB38_10:                              @ %if.end231
	ldr	r1, [sp, #8]
	muls	r0, r6, r0
	ldrd	r2, r3, [r1]
	lsls	r1, r3, #2
	udiv	r0, r0, r1
	umull	r0, r1, r0, r5
	lsrs	r0, r1, #5
	mls	r0, r0, r10, r4
	add.w	r0, r11, r0, lsl #4
	umull	r0, r1, r0, r5
	ubfx	r0, r1, #5, #4
.LBB38_11:                              @ %if.end231
	orr.w	r0, r0, r8
	str	r0, [r2, #8]
	@APP
	boundcheckstart.UART_SetConfig.text.module.uart.ret:

	@NO_APP
	add	sp, #12
	pop.w	{r4, r5, r6, r7, r8, r9, r10, r11, lr}
	push {r0}
 	movw r0, :lower16:gateway_ret_uart
 	movt r0, :upper16:gateway_ret_uart
 	bic lr,lr,#1
 	cmp lr, r0
 	beq end_of_check_UART_SetConfig2
 	movw r0, :lower16:.text.module.uart_start
 	movt r0, :upper16:.text.module.uart_start
 	cmp lr, r0
 	it cc
 	blcc exceptionFun
 	movw r0, :lower16:.text.module.uart_end
 	movt r0, :upper16:.text.module.uart_end
 	cmp lr, r0
 	it cs
 	blcs exceptionFun
end_of_check_UART_SetConfig2:
	pop {r0}
 	orr lr,lr,#1
	bx	lr
.Ltmp38:
	.size	UART_SetConfig, .Ltmp38-UART_SetConfig

	.align	2
	.type	UART_WaitOnFlagUntilTimeout,%function
	.code	16                      @ @UART_WaitOnFlagUntilTimeout
	.thumb_func
UART_WaitOnFlagUntilTimeout:
@ BB#0:                                 @ %entry
	push	{r7, lr}
	mov	r7, sp
	sub	sp, #24
	str	r0, [sp, #16]
	ldr	r0, [r7, #8]
	str	r1, [sp, #12]
	str	r2, [sp, #8]
	str	r3, [sp, #4]
	str	r0, [sp]
.LBB39_1:                               @ %while.cond
                                        @ =>This Inner Loop Header: Depth=1
	ldr	r0, [sp, #16]
	ldr	r0, [r0]
	ldr	r0, [r0]
	ldr	r1, [sp, #12]
	ands	r0, r1
	cmp	r0, r1
	mov.w	r0, #0
	it	eq
	moveq	r0, #1
	ldr	r1, [sp, #8]
	cmp	r0, r1
	bne	.LBB39_6
@ BB#2:                                 @ %while.body
                                        @   in Loop: Header=BB39_1 Depth=1
	ldr	r0, [sp]
	cmp.w	r0, #-1
	beq	.LBB39_1
@ BB#3:                                 @ %if.then
                                        @   in Loop: Header=BB39_1 Depth=1
	ldr	r0, [sp]
	cbz	r0, .LBB39_5
@ BB#4:                                 @ %lor.lhs.false
                                        @   in Loop: Header=BB39_1 Depth=1
	bl	HAL_GetTick
	ldr	r1, [sp, #4]
	subs	r0, r0, r1
	ldr	r1, [sp]
	cmp	r0, r1
	bls	.LBB39_1
.LBB39_5:                               @ %do.end
	ldr	r0, [sp, #16]
	ldr	r0, [r0]
	ldr	r1, [r0, #12]
	bic	r1, r1, #416
	str	r1, [r0, #12]
	ldr	r0, [sp, #16]
	ldr	r0, [r0]
	ldr	r1, [r0, #20]
	bic	r1, r1, #1
	str	r1, [r0, #20]
	movs	r1, #32
	ldr	r0, [sp, #16]
	str	r1, [r0, #60]
	ldr	r0, [sp, #16]
	str	r1, [r0, #64]
	movs	r1, #0
	ldr	r0, [sp, #16]
	str	r1, [r0, #56]
	movs	r0, #3
	b	.LBB39_7
.LBB39_6:                               @ %while.end
	movs	r0, #0
.LBB39_7:                               @ %return
	str	r0, [sp, #20]
	ldr	r0, [sp, #20]
	@APP
	boundcheckstart.UART_WaitOnFlagUntilTimeout.text.module.uart.ret:

	@NO_APP
	add	sp, #24
	pop	{r7, lr}
	push {r0}
 	movw r0, :lower16:gateway_ret_uart
 	movt r0, :upper16:gateway_ret_uart
 	bic lr,lr,#1
 	cmp lr, r0
 	beq end_of_check_UART_WaitOnFlagUntilTimeout9
 	movw r0, :lower16:.text.module.uart_start
 	movt r0, :upper16:.text.module.uart_start
 	cmp lr, r0
 	it cc
 	blcc exceptionFun
 	movw r0, :lower16:.text.module.uart_end
 	movt r0, :upper16:.text.module.uart_end
 	cmp lr, r0
 	it cs
 	blcs exceptionFun
end_of_check_UART_WaitOnFlagUntilTimeout9:
	pop {r0}
 	orr lr,lr,#1
	bx	lr
.Ltmp39:
	.size	UART_WaitOnFlagUntilTimeout, .Ltmp39-UART_WaitOnFlagUntilTimeout

	.align	2
	.type	UART_DMATransmitCplt,%function
	.code	16                      @ @UART_DMATransmitCplt
	.thumb_func
UART_DMATransmitCplt:
@ BB#0:                                 @ %entry
	push	{r7, lr}
	mov	r7, sp
	sub	sp, #16
	str	r0, [sp, #8]
	ldr	r0, [r0, #60]
	str	r0, [sp]
	ldr	r0, [sp, #8]
	ldr	r0, [r0]
	ldr	r0, [r0]
	tst.w	r0, #256
	beq	.LBB40_2
@ BB#1:                                 @ %if.else
	ldr	r0, [sp]
	bl	HAL_UART_TxCpltCallback
	b	.LBB40_3
.LBB40_2:                               @ %if.then
	ldr	r0, [sp]
	movs	r1, #0
	strh	r1, [r0, #38]
	ldr	r0, [sp]
	ldr	r0, [r0]
	ldr	r1, [r0, #20]
	bic	r1, r1, #128
	str	r1, [r0, #20]
	ldr	r0, [sp]
	ldr	r0, [r0]
	ldr	r1, [r0, #12]
	orr	r1, r1, #64
	str	r1, [r0, #12]
.LBB40_3:                               @ %if.end
	@APP
	boundcheckstart.UART_DMATransmitCplt.text.module.uart.ret:

	@NO_APP
	add	sp, #16
	pop	{r7, lr}
	push {r0}
 	movw r0, :lower16:gateway_ret_uart
 	movt r0, :upper16:gateway_ret_uart
 	bic lr,lr,#1
 	cmp lr, r0
 	beq end_of_check_UART_DMATransmitCplt14
 	movw r0, :lower16:.text.module.uart_start
 	movt r0, :upper16:.text.module.uart_start
 	cmp lr, r0
 	it cc
 	blcc exceptionFun
 	movw r0, :lower16:.text.module.uart_end
 	movt r0, :upper16:.text.module.uart_end
 	cmp lr, r0
 	it cs
 	blcs exceptionFun
end_of_check_UART_DMATransmitCplt14:
	pop {r0}
 	orr lr,lr,#1
	bx	lr
.Ltmp40:
	.size	UART_DMATransmitCplt, .Ltmp40-UART_DMATransmitCplt

	.align	2
	.type	UART_DMATxHalfCplt,%function
	.code	16                      @ @UART_DMATxHalfCplt
	.thumb_func
UART_DMATxHalfCplt:
@ BB#0:                                 @ %entry
	push	{r7, lr}
	mov	r7, sp
	sub	sp, #16
	str	r0, [sp, #8]
	ldr	r0, [r0, #60]
	str	r0, [sp]
	bl	HAL_UART_TxHalfCpltCallback
	@APP
	boundcheckstart.UART_DMATxHalfCplt.text.module.uart.ret:

	@NO_APP
	add	sp, #16
	pop	{r7, lr}
	push {r0}
 	movw r0, :lower16:gateway_ret_uart
 	movt r0, :upper16:gateway_ret_uart
 	bic lr,lr,#1
 	cmp lr, r0
 	beq end_of_check_UART_DMATxHalfCplt15
 	movw r0, :lower16:.text.module.uart_start
 	movt r0, :upper16:.text.module.uart_start
 	cmp lr, r0
 	it cc
 	blcc exceptionFun
 	movw r0, :lower16:.text.module.uart_end
 	movt r0, :upper16:.text.module.uart_end
 	cmp lr, r0
 	it cs
 	blcs exceptionFun
end_of_check_UART_DMATxHalfCplt15:
	pop {r0}
 	orr lr,lr,#1
	bx	lr
.Ltmp41:
	.size	UART_DMATxHalfCplt, .Ltmp41-UART_DMATxHalfCplt

	.align	2
	.type	UART_DMAError,%function
	.code	16                      @ @UART_DMAError
	.thumb_func
UART_DMAError:
@ BB#0:                                 @ %entry
	push	{r7, lr}
	mov	r7, sp
	sub	sp, #16
	str	r0, [sp, #8]
	movs	r0, #0
	str	r0, [sp, #4]
	ldr	r0, [sp, #8]
	ldr	r0, [r0, #60]
	str	r0, [sp]
	ldr	r0, [r0]
	ldr	r0, [r0, #20]
	and	r0, r0, #128
	lsrs	r0, r0, #7
	str	r0, [sp, #4]
	ldr	r0, [sp]
	ldr	r0, [r0, #60]
	cmp	r0, #33
	bne	.LBB42_3
@ BB#1:                                 @ %land.lhs.true
	ldr	r0, [sp, #4]
	cbz	r0, .LBB42_3
@ BB#2:                                 @ %if.then
	ldr	r0, [sp]
	movs	r1, #0
	strh	r1, [r0, #38]
	ldr	r0, [sp]
	bl	UART_EndTxTransfer
.LBB42_3:                               @ %if.end
	ldr	r0, [sp]
	ldr	r0, [r0]
	ldr	r0, [r0, #20]
	and	r0, r0, #64
	lsrs	r0, r0, #6
	str	r0, [sp, #4]
	ldr	r0, [sp]
	ldr	r0, [r0, #64]
	cmp	r0, #34
	bne	.LBB42_6
@ BB#4:                                 @ %land.lhs.true10
	ldr	r0, [sp, #4]
	cbz	r0, .LBB42_6
@ BB#5:                                 @ %if.then12
	ldr	r0, [sp]
	movs	r1, #0
	strh	r1, [r0, #46]
	ldr	r0, [sp]
	bl	UART_EndRxTransfer
.LBB42_6:                               @ %if.end13
	ldr	r0, [sp]
	ldr	r1, [r0, #68]
	orr	r1, r1, #16
	str	r1, [r0, #68]
	ldr	r0, [sp]
	bl	HAL_UART_ErrorCallback
	@APP
	boundcheckstart.UART_DMAError.text.module.uart.ret:

	@NO_APP
	add	sp, #16
	pop	{r7, lr}
	push {r0}
 	movw r0, :lower16:gateway_ret_uart
 	movt r0, :upper16:gateway_ret_uart
 	bic lr,lr,#1
 	cmp lr, r0
 	beq end_of_check_UART_DMAError16
 	movw r0, :lower16:.text.module.uart_start
 	movt r0, :upper16:.text.module.uart_start
 	cmp lr, r0
 	it cc
 	blcc exceptionFun
 	movw r0, :lower16:.text.module.uart_end
 	movt r0, :upper16:.text.module.uart_end
 	cmp lr, r0
 	it cs
 	blcs exceptionFun
end_of_check_UART_DMAError16:
	pop {r0}
 	orr lr,lr,#1
	bx	lr
.Ltmp42:
	.size	UART_DMAError, .Ltmp42-UART_DMAError

	.align	2
	.type	UART_DMAReceiveCplt,%function
	.code	16                      @ @UART_DMAReceiveCplt
	.thumb_func
UART_DMAReceiveCplt:
@ BB#0:                                 @ %entry
	push	{r7, lr}
	mov	r7, sp
	sub	sp, #16
	str	r0, [sp, #8]
	ldr	r0, [r0, #60]
	str	r0, [sp]
	ldr	r0, [sp, #8]
	ldr	r0, [r0]
	ldr	r0, [r0]
	tst.w	r0, #256
	bne	.LBB43_2
@ BB#1:                                 @ %if.then
	ldr	r0, [sp]
	movs	r1, #0
	strh	r1, [r0, #46]
	ldr	r0, [sp]
	ldr	r0, [r0]
	ldr	r1, [r0, #12]
	bic	r1, r1, #256
	str	r1, [r0, #12]
	ldr	r0, [sp]
	ldr	r0, [r0]
	ldr	r1, [r0, #20]
	bic	r1, r1, #1
	str	r1, [r0, #20]
	ldr	r0, [sp]
	ldr	r0, [r0]
	ldr	r1, [r0, #20]
	bic	r1, r1, #64
	str	r1, [r0, #20]
	movs	r1, #32
	ldr	r0, [sp]
	str	r1, [r0, #64]
.LBB43_2:                               @ %if.end
	ldr	r0, [sp]
	bl	HAL_UART_RxCpltCallback
	@APP
	boundcheckstart.UART_DMAReceiveCplt.text.module.uart.ret:

	@NO_APP
	add	sp, #16
	pop	{r7, lr}
	push {r0}
 	movw r0, :lower16:gateway_ret_uart
 	movt r0, :upper16:gateway_ret_uart
 	bic lr,lr,#1
 	cmp lr, r0
 	beq end_of_check_UART_DMAReceiveCplt18
 	movw r0, :lower16:.text.module.uart_start
 	movt r0, :upper16:.text.module.uart_start
 	cmp lr, r0
 	it cc
 	blcc exceptionFun
 	movw r0, :lower16:.text.module.uart_end
 	movt r0, :upper16:.text.module.uart_end
 	cmp lr, r0
 	it cs
 	blcs exceptionFun
end_of_check_UART_DMAReceiveCplt18:
	pop {r0}
 	orr lr,lr,#1
	bx	lr
.Ltmp43:
	.size	UART_DMAReceiveCplt, .Ltmp43-UART_DMAReceiveCplt

	.align	2
	.type	UART_DMARxHalfCplt,%function
	.code	16                      @ @UART_DMARxHalfCplt
	.thumb_func
UART_DMARxHalfCplt:
@ BB#0:                                 @ %entry
	push	{r7, lr}
	mov	r7, sp
	sub	sp, #16
	str	r0, [sp, #8]
	ldr	r0, [r0, #60]
	str	r0, [sp]
	bl	HAL_UART_RxHalfCpltCallback
	@APP
	boundcheckstart.UART_DMARxHalfCplt.text.module.uart.ret:

	@NO_APP
	add	sp, #16
	pop	{r7, lr}
	push {r0}
 	movw r0, :lower16:gateway_ret_uart
 	movt r0, :upper16:gateway_ret_uart
 	bic lr,lr,#1
 	cmp lr, r0
 	beq end_of_check_UART_DMARxHalfCplt19
 	movw r0, :lower16:.text.module.uart_start
 	movt r0, :upper16:.text.module.uart_start
 	cmp lr, r0
 	it cc
 	blcc exceptionFun
 	movw r0, :lower16:.text.module.uart_end
 	movt r0, :upper16:.text.module.uart_end
 	cmp lr, r0
 	it cs
 	blcs exceptionFun
end_of_check_UART_DMARxHalfCplt19:
	pop {r0}
 	orr lr,lr,#1
	bx	lr
.Ltmp44:
	.size	UART_DMARxHalfCplt, .Ltmp44-UART_DMARxHalfCplt

	.align	2
	.type	UART_EndTxTransfer,%function
	.code	16                      @ @UART_EndTxTransfer
	.thumb_func
UART_EndTxTransfer:
@ BB#0:                                 @ %entry
	sub	sp, #8
	str	r0, [sp]
	ldr	r0, [r0]
	ldr	r1, [r0, #12]
	bic	r1, r1, #192
	str	r1, [r0, #12]
	movs	r1, #32
	ldr	r0, [sp]
	str	r1, [r0, #60]
	@APP
	boundcheckstart.UART_EndTxTransfer.text.module.uart.ret:

	@NO_APP
	add	sp, #8
	push {r0}
 	movw r0, :lower16:gateway_ret_uart
 	movt r0, :upper16:gateway_ret_uart
 	bic lr,lr,#1
 	cmp lr, r0
 	beq end_of_check_UART_EndTxTransfer23
 	movw r0, :lower16:.text.module.uart_start
 	movt r0, :upper16:.text.module.uart_start
 	cmp lr, r0
 	it cc
 	blcc exceptionFun
 	movw r0, :lower16:.text.module.uart_end
 	movt r0, :upper16:.text.module.uart_end
 	cmp lr, r0
 	it cs
 	blcs exceptionFun
end_of_check_UART_EndTxTransfer23:
	pop {r0}
 	orr lr,lr,#1
	bx	lr
.Ltmp45:
	.size	UART_EndTxTransfer, .Ltmp45-UART_EndTxTransfer

	.align	2
	.type	UART_EndRxTransfer,%function
	.code	16                      @ @UART_EndRxTransfer
	.thumb_func
UART_EndRxTransfer:
@ BB#0:                                 @ %entry
	sub	sp, #8
	str	r0, [sp]
	ldr	r0, [r0]
	ldr	r1, [r0, #12]
	bic	r1, r1, #288
	str	r1, [r0, #12]
	ldr	r0, [sp]
	ldr	r0, [r0]
	ldr	r1, [r0, #20]
	bic	r1, r1, #1
	str	r1, [r0, #20]
	movs	r1, #32
	ldr	r0, [sp]
	str	r1, [r0, #64]
	@APP
	boundcheckstart.UART_EndRxTransfer.text.module.uart.ret:

	@NO_APP
	add	sp, #8
	push {r0}
 	movw r0, :lower16:gateway_ret_uart
 	movt r0, :upper16:gateway_ret_uart
 	bic lr,lr,#1
 	cmp lr, r0
 	beq end_of_check_UART_EndRxTransfer24
 	movw r0, :lower16:.text.module.uart_start
 	movt r0, :upper16:.text.module.uart_start
 	cmp lr, r0
 	it cc
 	blcc exceptionFun
 	movw r0, :lower16:.text.module.uart_end
 	movt r0, :upper16:.text.module.uart_end
 	cmp lr, r0
 	it cs
 	blcs exceptionFun
end_of_check_UART_EndRxTransfer24:
	pop {r0}
 	orr lr,lr,#1
	bx	lr
.Ltmp46:
	.size	UART_EndRxTransfer, .Ltmp46-UART_EndRxTransfer

	.align	2
	.type	UART_Receive_IT,%function
	.code	16                      @ @UART_Receive_IT
	.thumb_func
UART_Receive_IT:
@ BB#0:                                 @ %entry
	push	{r7, lr}
	mov	r7, sp
	sub	sp, #16
	str	r0, [sp, #8]
	ldr	r0, [r0, #64]
	cmp	r0, #34
	bne	.LBB47_4
@ BB#1:                                 @ %if.then
	ldr	r0, [sp, #8]
	ldr	r0, [r0, #8]
	cmp.w	r0, #4096
	bne	.LBB47_5
@ BB#2:                                 @ %if.then2
	ldr	r0, [sp, #8]
	ldr	r0, [r0, #40]
	str	r0, [sp]
	ldr	r0, [sp, #8]
	ldr	r0, [r0, #16]
	cmp	r0, #0
	beq	.LBB47_6
@ BB#3:                                 @ %if.else
	ldr	r0, [sp, #8]
	ldr	r0, [r0]
	ldr	r0, [r0, #4]
	ldr	r1, [sp]
	uxtb	r0, r0
	strh	r0, [r1]
	ldr	r0, [sp, #8]
	ldr	r1, [r0, #40]
	adds	r1, #1
	str	r1, [r0, #40]
	b	.LBB47_7
.LBB47_4:                               @ %if.else43
	movs	r0, #2
	b	.LBB47_10
.LBB47_5:                               @ %if.else13
	ldr	r0, [sp, #8]
	ldr	r0, [r0, #16]
	cmp	r0, #0
	ldr	r0, [sp, #8]
	ldr	r0, [r0]
	ldr	r0, [r0, #4]
	ldr	r1, [sp, #8]
	ldr	r2, [r1, #40]
	add.w	r3, r2, #1
	str	r3, [r1, #40]
	it	ne
	andne	r0, r0, #127
	strb	r0, [r2]
	b	.LBB47_7
.LBB47_6:                               @ %if.then5
	ldr	r0, [sp, #8]
	ldr	r0, [r0]
	ldr	r0, [r0, #4]
	ldr	r1, [sp]
	bfc	r0, #9, #23
	strh	r0, [r1]
	ldr	r0, [sp, #8]
	ldr	r1, [r0, #40]
	adds	r1, #2
	str	r1, [r0, #40]
.LBB47_7:                               @ %if.end32
	ldr	r0, [sp, #8]
	ldrh	r1, [r0, #46]
	subs	r1, #1
	strh	r1, [r0, #46]
	movw	r0, #65535
	tst	r1, r0
	bne	.LBB47_9
@ BB#8:                                 @ %if.then36
	ldr	r0, [sp, #8]
	ldr	r0, [r0]
	ldr	r1, [r0, #12]
	bic	r1, r1, #288
	str	r1, [r0, #12]
	ldr	r0, [sp, #8]
	ldr	r0, [r0]
	ldr	r1, [r0, #20]
	bic	r1, r1, #1
	str	r1, [r0, #20]
	movs	r1, #32
	ldr	r0, [sp, #8]
	str	r1, [r0, #64]
	ldr	r0, [sp, #8]
	bl	HAL_UART_RxCpltCallback
.LBB47_9:                               @ %if.end42
	movs	r0, #0
.LBB47_10:                              @ %return
	str	r0, [sp, #12]
	ldr	r0, [sp, #12]
	@APP
	boundcheckstart.UART_Receive_IT.text.module.uart.ret:

	@NO_APP
	add	sp, #16
	pop	{r7, lr}
	push {r0}
 	movw r0, :lower16:gateway_ret_uart
 	movt r0, :upper16:gateway_ret_uart
 	bic lr,lr,#1
 	cmp lr, r0
 	beq end_of_check_UART_Receive_IT26
 	movw r0, :lower16:.text.module.uart_start
 	movt r0, :upper16:.text.module.uart_start
 	cmp lr, r0
 	it cc
 	blcc exceptionFun
 	movw r0, :lower16:.text.module.uart_end
 	movt r0, :upper16:.text.module.uart_end
 	cmp lr, r0
 	it cs
 	blcs exceptionFun
end_of_check_UART_Receive_IT26:
	pop {r0}
 	orr lr,lr,#1
	bx	lr
.Ltmp47:
	.size	UART_Receive_IT, .Ltmp47-UART_Receive_IT

	.align	2
	.type	UART_DMAAbortOnError,%function
	.code	16                      @ @UART_DMAAbortOnError
	.thumb_func
UART_DMAAbortOnError:
@ BB#0:                                 @ %entry
	push	{r7, lr}
	mov	r7, sp
	sub	sp, #16
	str	r0, [sp, #8]
	movs	r1, #0
	ldr	r0, [r0, #60]
	str	r0, [sp]
	strh	r1, [r0, #46]
	ldr	r0, [sp]
	strh	r1, [r0, #38]
	ldr	r0, [sp]
	bl	HAL_UART_ErrorCallback
	@APP
	boundcheckstart.UART_DMAAbortOnError.text.module.uart.ret:

	@NO_APP
	add	sp, #16
	pop	{r7, lr}
	push {r0}
 	movw r0, :lower16:gateway_ret_uart
 	movt r0, :upper16:gateway_ret_uart
 	bic lr,lr,#1
 	cmp lr, r0
 	beq end_of_check_UART_DMAAbortOnError27
 	movw r0, :lower16:.text.module.uart_start
 	movt r0, :upper16:.text.module.uart_start
 	cmp lr, r0
 	it cc
 	blcc exceptionFun
 	movw r0, :lower16:.text.module.uart_end
 	movt r0, :upper16:.text.module.uart_end
 	cmp lr, r0
 	it cs
 	blcs exceptionFun
end_of_check_UART_DMAAbortOnError27:
	pop {r0}
 	orr lr,lr,#1
	bx	lr
.Ltmp48:
	.size	UART_DMAAbortOnError, .Ltmp48-UART_DMAAbortOnError

	.align	2
	.type	UART_Transmit_IT,%function
	.code	16                      @ @UART_Transmit_IT
	.thumb_func
UART_Transmit_IT:
@ BB#0:                                 @ %entry
	sub	sp, #16
	str	r0, [sp, #8]
	ldr	r0, [r0, #60]
	cmp	r0, #33
	bne	.LBB49_4
@ BB#1:                                 @ %if.then
	ldr	r0, [sp, #8]
	ldr	r0, [r0, #8]
	cmp.w	r0, #4096
	bne	.LBB49_5
@ BB#2:                                 @ %if.then2
	ldr	r0, [sp, #8]
	ldr	r1, [sp, #8]
	ldr	r0, [r0, #32]
	str	r0, [sp]
	ldrh	r0, [r0]
	ldr	r1, [r1]
	bfc	r0, #9, #23
	str	r0, [r1, #4]
	ldr	r0, [sp, #8]
	ldr	r0, [r0, #16]
	cmp	r0, #0
	beq	.LBB49_6
@ BB#3:                                 @ %if.else
	ldr	r0, [sp, #8]
	ldr	r1, [r0, #32]
	adds	r1, #1
	str	r1, [r0, #32]
	b	.LBB49_7
.LBB49_4:                               @ %if.else30
	movs	r0, #2
	b	.LBB49_10
.LBB49_5:                               @ %if.else12
	ldr	r0, [sp, #8]
	ldr	r1, [r0, #32]
	adds	r2, r1, #1
	str	r2, [r0, #32]
	ldrb	r0, [r1]
	ldr	r1, [sp, #8]
	ldr	r1, [r1]
	str	r0, [r1, #4]
	b	.LBB49_7
.LBB49_6:                               @ %if.then8
	ldr	r0, [sp, #8]
	ldr	r1, [r0, #32]
	adds	r1, #2
	str	r1, [r0, #32]
.LBB49_7:                               @ %if.end20
	ldr	r0, [sp, #8]
	ldrh	r1, [r0, #38]
	subs	r1, #1
	strh	r1, [r0, #38]
	movw	r0, #65535
	tst	r1, r0
	bne	.LBB49_9
@ BB#8:                                 @ %if.then24
	ldr	r0, [sp, #8]
	ldr	r0, [r0]
	ldr	r1, [r0, #12]
	bic	r1, r1, #128
	str	r1, [r0, #12]
	ldr	r0, [sp, #8]
	ldr	r0, [r0]
	ldr	r1, [r0, #12]
	orr	r1, r1, #64
	str	r1, [r0, #12]
.LBB49_9:                               @ %if.end29
	movs	r0, #0
.LBB49_10:                              @ %return
	str	r0, [sp, #12]
	ldr	r0, [sp, #12]
	@APP
	boundcheckstart.UART_Transmit_IT.text.module.uart.ret:

	@NO_APP
	add	sp, #16
	push {r0}
 	movw r0, :lower16:gateway_ret_uart
 	movt r0, :upper16:gateway_ret_uart
 	bic lr,lr,#1
 	cmp lr, r0
 	beq end_of_check_UART_Transmit_IT29
 	movw r0, :lower16:.text.module.uart_start
 	movt r0, :upper16:.text.module.uart_start
 	cmp lr, r0
 	it cc
 	blcc exceptionFun
 	movw r0, :lower16:.text.module.uart_end
 	movt r0, :upper16:.text.module.uart_end
 	cmp lr, r0
 	it cs
 	blcs exceptionFun
end_of_check_UART_Transmit_IT29:
	pop {r0}
 	orr lr,lr,#1
	bx	lr
.Ltmp49:
	.size	UART_Transmit_IT, .Ltmp49-UART_Transmit_IT

	.align	2
	.type	UART_EndTransmit_IT,%function
	.code	16                      @ @UART_EndTransmit_IT
	.thumb_func
UART_EndTransmit_IT:
@ BB#0:                                 @ %entry
	push	{r7, lr}
	mov	r7, sp
	sub	sp, #8
	str	r0, [sp]
	ldr	r0, [r0]
	ldr	r1, [r0, #12]
	bic	r1, r1, #64
	str	r1, [r0, #12]
	movs	r1, #32
	ldr	r0, [sp]
	str	r1, [r0, #60]
	ldr	r0, [sp]
	bl	HAL_UART_TxCpltCallback
	@APP
	boundcheckstart.UART_EndTransmit_IT.text.module.uart.ret:

	@NO_APP
	movs	r0, #0
	add	sp, #8
	pop	{r7, lr}
	push {r0}
 	movw r0, :lower16:gateway_ret_uart
 	movt r0, :upper16:gateway_ret_uart
 	bic lr,lr,#1
 	cmp lr, r0
 	beq end_of_check_UART_EndTransmit_IT30
 	movw r0, :lower16:.text.module.uart_start
 	movt r0, :upper16:.text.module.uart_start
 	cmp lr, r0
 	it cc
 	blcc exceptionFun
 	movw r0, :lower16:.text.module.uart_end
 	movt r0, :upper16:.text.module.uart_end
 	cmp lr, r0
 	it cs
 	blcs exceptionFun
end_of_check_UART_EndTransmit_IT30:
	pop {r0}
 	orr lr,lr,#1
	bx	lr
.Ltmp50:
	.size	UART_EndTransmit_IT, .Ltmp50-UART_EndTransmit_IT

	.section	privileged_functions,"ax",%progbits
	.globl	HAL_Init
	.align	2
	.type	HAL_Init,%function
	.code	16                      @ @HAL_Init
	.thumb_func
HAL_Init:
@ BB#0:                                 @ %entry
	push	{r7, lr}
	movw	r0, #15360
	mov	r7, sp
	movt	r0, #16386
	ldr	r1, [r0]
	orr	r1, r1, #512
	str	r1, [r0]
	ldr	r1, [r0]
	orr	r1, r1, #1024
	str	r1, [r0]
	ldr	r1, [r0]
	orr	r1, r1, #256
	str	r1, [r0]
	movs	r0, #3
	bl	HAL_NVIC_SetPriorityGrouping
	movs	r0, #15
	bl	HAL_InitTick
	bl	HAL_MspInit
	movs	r0, #0
	pop	{r7, pc}
.Ltmp51:
	.size	HAL_Init, .Ltmp51-HAL_Init

	.weak	HAL_InitTick
	.align	2
	.type	HAL_InitTick,%function
	.code	16                      @ @HAL_InitTick
	.thumb_func
HAL_InitTick:
@ BB#0:                                 @ %entry
	push	{r7, lr}
	mov	r7, sp
	sub	sp, #8
	str	r0, [sp, #4]
	movw	r0, :lower16:SystemCoreClock
	movw	r1, #19923
	movt	r0, :upper16:SystemCoreClock
	movt	r1, #4194
	ldr	r0, [r0]
	umull	r0, r1, r0, r1
	lsrs	r0, r1, #6
	bl	HAL_SYSTICK_Config
	ldr	r1, [sp, #4]
	mov.w	r0, #-1
	movs	r2, #0
	bl	HAL_NVIC_SetPriority
	movs	r0, #0
	add	sp, #8
	pop	{r7, pc}
.Ltmp52:
	.size	HAL_InitTick, .Ltmp52-HAL_InitTick

	.weak	HAL_MspInit
	.align	2
	.type	HAL_MspInit,%function
	.code	16                      @ @HAL_MspInit
	.thumb_func
HAL_MspInit:
@ BB#0:                                 @ %entry
	bx	lr
.Ltmp53:
	.size	HAL_MspInit, .Ltmp53-HAL_MspInit

	.globl	HAL_DeInit
	.align	2
	.type	HAL_DeInit,%function
	.code	16                      @ @HAL_DeInit
	.thumb_func
HAL_DeInit:
@ BB#0:                                 @ %entry
	push	{r7, lr}
	movw	r0, #14368
	mov.w	r1, #-1
	movs	r2, #0
	mov	r7, sp
	movt	r0, #16386
	str	r1, [r0]
	str	r2, [r0]
	movw	r0, #14372
	movt	r0, #16386
	str	r1, [r0]
	str	r2, [r0]
	movw	r0, #14352
	movt	r0, #16386
	str	r1, [r0]
	str	r2, [r0]
	movw	r0, #14356
	movt	r0, #16386
	str	r1, [r0]
	str	r2, [r0]
	movw	r0, #14360
	movt	r0, #16386
	str	r1, [r0]
	str	r2, [r0]
	bl	HAL_MspDeInit
	movs	r0, #0
	pop	{r7, pc}
.Ltmp54:
	.size	HAL_DeInit, .Ltmp54-HAL_DeInit

	.weak	HAL_MspDeInit
	.align	2
	.type	HAL_MspDeInit,%function
	.code	16                      @ @HAL_MspDeInit
	.thumb_func
HAL_MspDeInit:
@ BB#0:                                 @ %entry
	bx	lr
.Ltmp55:
	.size	HAL_MspDeInit, .Ltmp55-HAL_MspDeInit

	.weak	HAL_IncTick
	.align	2
	.type	HAL_IncTick,%function
	.code	16                      @ @HAL_IncTick
	.thumb_func
HAL_IncTick:
@ BB#0:                                 @ %entry
	movw	r0, :lower16:uwTick
	movt	r0, :upper16:uwTick
	ldr	r1, [r0]
	adds	r1, #1
	str	r1, [r0]
	bx	lr
.Ltmp56:
	.size	HAL_IncTick, .Ltmp56-HAL_IncTick

	.weak	HAL_GetTick
	.align	2
	.type	HAL_GetTick,%function
	.code	16                      @ @HAL_GetTick
	.thumb_func
HAL_GetTick:
@ BB#0:                                 @ %entry
	movw	r0, :lower16:uwTick
	movt	r0, :upper16:uwTick
	ldr	r0, [r0]
	bx	lr
.Ltmp57:
	.size	HAL_GetTick, .Ltmp57-HAL_GetTick

	.weak	HAL_Delay
	.align	2
	.type	HAL_Delay,%function
	.code	16                      @ @HAL_Delay
	.thumb_func
HAL_Delay:
@ BB#0:                                 @ %entry
	push	{r7, lr}
	mov	r7, sp
	sub	sp, #8
	str	r0, [sp, #4]
	movs	r0, #0
	str	r0, [sp]
	bl	HAL_GetTick
	str	r0, [sp]
.LBB58_1:                               @ %while.cond
                                        @ =>This Inner Loop Header: Depth=1
	bl	HAL_GetTick
	ldr	r1, [sp]
	subs	r0, r0, r1
	ldr	r1, [sp, #4]
	cmp	r0, r1
	blo	.LBB58_1
@ BB#2:                                 @ %while.end
	add	sp, #8
	pop	{r7, pc}
.Ltmp58:
	.size	HAL_Delay, .Ltmp58-HAL_Delay

	.weak	HAL_SuspendTick
	.align	2
	.type	HAL_SuspendTick,%function
	.code	16                      @ @HAL_SuspendTick
	.thumb_func
HAL_SuspendTick:
@ BB#0:                                 @ %entry
	movw	r0, #57360
	movt	r0, #57344
	ldr	r1, [r0]
	bic	r1, r1, #2
	str	r1, [r0]
	bx	lr
.Ltmp59:
	.size	HAL_SuspendTick, .Ltmp59-HAL_SuspendTick

	.weak	HAL_ResumeTick
	.align	2
	.type	HAL_ResumeTick,%function
	.code	16                      @ @HAL_ResumeTick
	.thumb_func
HAL_ResumeTick:
@ BB#0:                                 @ %entry
	movw	r0, #57360
	movt	r0, #57344
	ldr	r1, [r0]
	orr	r1, r1, #2
	str	r1, [r0]
	bx	lr
.Ltmp60:
	.size	HAL_ResumeTick, .Ltmp60-HAL_ResumeTick

	.globl	HAL_GetHalVersion
	.align	2
	.type	HAL_GetHalVersion,%function
	.code	16                      @ @HAL_GetHalVersion
	.thumb_func
HAL_GetHalVersion:
@ BB#0:                                 @ %entry
	movw	r0, #256
	movt	r0, #261
	bx	lr
.Ltmp61:
	.size	HAL_GetHalVersion, .Ltmp61-HAL_GetHalVersion

	.globl	HAL_GetREVID
	.align	2
	.type	HAL_GetREVID,%function
	.code	16                      @ @HAL_GetREVID
	.thumb_func
HAL_GetREVID:
@ BB#0:                                 @ %entry
	movw	r0, #8192
	movt	r0, #57348
	ldr	r0, [r0]
	lsrs	r0, r0, #16
	bx	lr
.Ltmp62:
	.size	HAL_GetREVID, .Ltmp62-HAL_GetREVID

	.globl	HAL_GetDEVID
	.align	2
	.type	HAL_GetDEVID,%function
	.code	16                      @ @HAL_GetDEVID
	.thumb_func
HAL_GetDEVID:
@ BB#0:                                 @ %entry
	movw	r0, #8192
	movt	r0, #57348
	ldr	r0, [r0]
	bfc	r0, #12, #20
	bx	lr
.Ltmp63:
	.size	HAL_GetDEVID, .Ltmp63-HAL_GetDEVID

	.globl	HAL_DBGMCU_EnableDBGSleepMode
	.align	2
	.type	HAL_DBGMCU_EnableDBGSleepMode,%function
	.code	16                      @ @HAL_DBGMCU_EnableDBGSleepMode
	.thumb_func
HAL_DBGMCU_EnableDBGSleepMode:
@ BB#0:                                 @ %entry
	movw	r0, #8196
	movt	r0, #57348
	ldr	r1, [r0]
	orr	r1, r1, #1
	str	r1, [r0]
	bx	lr
.Ltmp64:
	.size	HAL_DBGMCU_EnableDBGSleepMode, .Ltmp64-HAL_DBGMCU_EnableDBGSleepMode

	.globl	HAL_DBGMCU_DisableDBGSleepMode
	.align	2
	.type	HAL_DBGMCU_DisableDBGSleepMode,%function
	.code	16                      @ @HAL_DBGMCU_DisableDBGSleepMode
	.thumb_func
HAL_DBGMCU_DisableDBGSleepMode:
@ BB#0:                                 @ %entry
	movw	r0, #8196
	movt	r0, #57348
	ldr	r1, [r0]
	bic	r1, r1, #1
	str	r1, [r0]
	bx	lr
.Ltmp65:
	.size	HAL_DBGMCU_DisableDBGSleepMode, .Ltmp65-HAL_DBGMCU_DisableDBGSleepMode

	.globl	HAL_DBGMCU_EnableDBGStopMode
	.align	2
	.type	HAL_DBGMCU_EnableDBGStopMode,%function
	.code	16                      @ @HAL_DBGMCU_EnableDBGStopMode
	.thumb_func
HAL_DBGMCU_EnableDBGStopMode:
@ BB#0:                                 @ %entry
	movw	r0, #8196
	movt	r0, #57348
	ldr	r1, [r0]
	orr	r1, r1, #2
	str	r1, [r0]
	bx	lr
.Ltmp66:
	.size	HAL_DBGMCU_EnableDBGStopMode, .Ltmp66-HAL_DBGMCU_EnableDBGStopMode

	.globl	HAL_DBGMCU_DisableDBGStopMode
	.align	2
	.type	HAL_DBGMCU_DisableDBGStopMode,%function
	.code	16                      @ @HAL_DBGMCU_DisableDBGStopMode
	.thumb_func
HAL_DBGMCU_DisableDBGStopMode:
@ BB#0:                                 @ %entry
	movw	r0, #8196
	movt	r0, #57348
	ldr	r1, [r0]
	bic	r1, r1, #2
	str	r1, [r0]
	bx	lr
.Ltmp67:
	.size	HAL_DBGMCU_DisableDBGStopMode, .Ltmp67-HAL_DBGMCU_DisableDBGStopMode

	.globl	HAL_DBGMCU_EnableDBGStandbyMode
	.align	2
	.type	HAL_DBGMCU_EnableDBGStandbyMode,%function
	.code	16                      @ @HAL_DBGMCU_EnableDBGStandbyMode
	.thumb_func
HAL_DBGMCU_EnableDBGStandbyMode:
@ BB#0:                                 @ %entry
	movw	r0, #8196
	movt	r0, #57348
	ldr	r1, [r0]
	orr	r1, r1, #4
	str	r1, [r0]
	bx	lr
.Ltmp68:
	.size	HAL_DBGMCU_EnableDBGStandbyMode, .Ltmp68-HAL_DBGMCU_EnableDBGStandbyMode

	.globl	HAL_DBGMCU_DisableDBGStandbyMode
	.align	2
	.type	HAL_DBGMCU_DisableDBGStandbyMode,%function
	.code	16                      @ @HAL_DBGMCU_DisableDBGStandbyMode
	.thumb_func
HAL_DBGMCU_DisableDBGStandbyMode:
@ BB#0:                                 @ %entry
	movw	r0, #8196
	movt	r0, #57348
	ldr	r1, [r0]
	bic	r1, r1, #4
	str	r1, [r0]
	bx	lr
.Ltmp69:
	.size	HAL_DBGMCU_DisableDBGStandbyMode, .Ltmp69-HAL_DBGMCU_DisableDBGStandbyMode

	.globl	HAL_EnableCompensationCell
	.align	2
	.type	HAL_EnableCompensationCell,%function
	.code	16                      @ @HAL_EnableCompensationCell
	.thumb_func
HAL_EnableCompensationCell:
@ BB#0:                                 @ %entry
	sub	sp, #8
	movs	r0, #1
	movw	r2, #1024
	str	r0, [sp, #4]
	@APP
	rbit r1, r0
	@NO_APP
	movt	r2, #16935
	str	r1, [sp]
	clz	r1, r1
	str.w	r0, [r2, r1, lsl #2]
	add	sp, #8
	bx	lr
.Ltmp70:
	.size	HAL_EnableCompensationCell, .Ltmp70-HAL_EnableCompensationCell

	.globl	HAL_DisableCompensationCell
	.align	2
	.type	HAL_DisableCompensationCell,%function
	.code	16                      @ @HAL_DisableCompensationCell
	.thumb_func
HAL_DisableCompensationCell:
@ BB#0:                                 @ %entry
	sub	sp, #8
	movs	r0, #1
	movw	r1, #1024
	movs	r2, #0
	str	r0, [sp, #4]
	@APP
	rbit r0, r0
	@NO_APP
	movt	r1, #16935
	str	r0, [sp]
	clz	r0, r0
	str.w	r2, [r1, r0, lsl #2]
	add	sp, #8
	bx	lr
.Ltmp71:
	.size	HAL_DisableCompensationCell, .Ltmp71-HAL_DisableCompensationCell

	.globl	HAL_NVIC_SetPriorityGrouping
	.align	2
	.type	HAL_NVIC_SetPriorityGrouping,%function
	.code	16                      @ @HAL_NVIC_SetPriorityGrouping
	.thumb_func
HAL_NVIC_SetPriorityGrouping:
@ BB#0:                                 @ %entry
	push	{r7, lr}
	mov	r7, sp
	sub	sp, #8
	str	r0, [sp, #4]
	bl	NVIC_SetPriorityGrouping
	add	sp, #8
	pop	{r7, pc}
.Ltmp72:
	.size	HAL_NVIC_SetPriorityGrouping, .Ltmp72-HAL_NVIC_SetPriorityGrouping

	.globl	HAL_NVIC_SetPriority
	.align	2
	.type	HAL_NVIC_SetPriority,%function
	.code	16                      @ @HAL_NVIC_SetPriority
	.thumb_func
HAL_NVIC_SetPriority:
@ BB#0:                                 @ %entry
	push.w	{r4, r7, r11, lr}
	add	r7, sp, #4
	sub	sp, #16
	str	r0, [sp, #12]
	movs	r0, #0
	str	r1, [sp, #8]
	str	r2, [sp, #4]
	str	r0, [sp]
	bl	NVIC_GetPriorityGrouping
	ldr	r2, [sp, #4]
	ldr	r1, [sp, #8]
	ldr	r4, [sp, #12]
	str	r0, [sp]
	bl	NVIC_EncodePriority
	mov	r1, r0
	mov	r0, r4
	bl	NVIC_SetPriority
	add	sp, #16
	pop.w	{r4, r7, r11, pc}
.Ltmp73:
	.size	HAL_NVIC_SetPriority, .Ltmp73-HAL_NVIC_SetPriority

	.globl	HAL_NVIC_EnableIRQ
	.align	2
	.type	HAL_NVIC_EnableIRQ,%function
	.code	16                      @ @HAL_NVIC_EnableIRQ
	.thumb_func
HAL_NVIC_EnableIRQ:
@ BB#0:                                 @ %entry
	push	{r7, lr}
	mov	r7, sp
	sub	sp, #8
	str	r0, [sp, #4]
	bl	NVIC_EnableIRQ
	add	sp, #8
	pop	{r7, pc}
.Ltmp74:
	.size	HAL_NVIC_EnableIRQ, .Ltmp74-HAL_NVIC_EnableIRQ

	.globl	HAL_NVIC_DisableIRQ
	.align	2
	.type	HAL_NVIC_DisableIRQ,%function
	.code	16                      @ @HAL_NVIC_DisableIRQ
	.thumb_func
HAL_NVIC_DisableIRQ:
@ BB#0:                                 @ %entry
	push	{r7, lr}
	mov	r7, sp
	sub	sp, #8
	str	r0, [sp, #4]
	bl	NVIC_DisableIRQ
	add	sp, #8
	pop	{r7, pc}
.Ltmp75:
	.size	HAL_NVIC_DisableIRQ, .Ltmp75-HAL_NVIC_DisableIRQ

	.globl	HAL_NVIC_SystemReset
	.align	2
	.type	HAL_NVIC_SystemReset,%function
	.code	16                      @ @HAL_NVIC_SystemReset
	.thumb_func
HAL_NVIC_SystemReset:
@ BB#0:                                 @ %entry
	push	{r7, lr}
	mov	r7, sp
	bl	NVIC_SystemReset
	pop	{r7, pc}
.Ltmp76:
	.size	HAL_NVIC_SystemReset, .Ltmp76-HAL_NVIC_SystemReset

	.globl	HAL_SYSTICK_Config
	.align	2
	.type	HAL_SYSTICK_Config,%function
	.code	16                      @ @HAL_SYSTICK_Config
	.thumb_func
HAL_SYSTICK_Config:
@ BB#0:                                 @ %entry
	push	{r7, lr}
	mov	r7, sp
	sub	sp, #8
	str	r0, [sp, #4]
	bl	SysTick_Config
	add	sp, #8
	pop	{r7, pc}
.Ltmp77:
	.size	HAL_SYSTICK_Config, .Ltmp77-HAL_SYSTICK_Config

	.globl	HAL_MPU_ConfigRegion
	.align	2
	.type	HAL_MPU_ConfigRegion,%function
	.code	16                      @ @HAL_MPU_ConfigRegion
	.thumb_func
HAL_MPU_ConfigRegion:
@ BB#0:                                 @ %entry
	push.w	{r11, lr}
	sub	sp, #8
	str	r0, [sp]
	movw	r1, #60824
	ldrb	r0, [r0, #1]
	movt	r1, #57344
	str	r0, [r1]
	ldr	r0, [sp]
	ldrb	r0, [r0]
	cbz	r0, .LBB78_2
@ BB#1:                                 @ %if.then
	ldr	r0, [sp]
	movw	r1, #60828
	movt	r1, #57344
	ldr	r0, [r0, #4]
	str	r0, [r1]
	ldr	r0, [sp]
	ldrb	r2, [r0, #12]
	ldrb	r1, [r0, #11]
	ldrb	r3, [r0, #10]
	ldrb.w	r12, [r0]
	ldrb.w	lr, [r0, #8]
	lsls	r2, r2, #28
	orr.w	r1, r2, r1, lsl #24
	ldrb	r2, [r0, #9]
	orr.w	r1, r1, r3, lsl #19
	ldrb	r3, [r0, #13]
	orr.w	r1, r1, r3, lsl #18
	ldrb	r3, [r0, #14]
	ldrb	r0, [r0, #15]
	orr.w	r1, r1, r3, lsl #17
	orr.w	r0, r1, r0, lsl #16
	movw	r1, #60832
	orr.w	r0, r0, r2, lsl #8
	movt	r1, #57344
	orr.w	r0, r0, lr, lsl #1
	orr.w	r0, r0, r12
	str	r0, [r1]
	add	sp, #8
	pop.w	{r11, pc}
.LBB78_2:                               @ %if.else
	movw	r0, #60828
	movs	r1, #0
	movt	r0, #57344
	str	r1, [r0]
	movw	r0, #60832
	movt	r0, #57344
	str	r1, [r0]
	add	sp, #8
	pop.w	{r11, pc}
.Ltmp78:
	.size	HAL_MPU_ConfigRegion, .Ltmp78-HAL_MPU_ConfigRegion

	.globl	HAL_NVIC_GetPriorityGrouping
	.align	2
	.type	HAL_NVIC_GetPriorityGrouping,%function
	.code	16                      @ @HAL_NVIC_GetPriorityGrouping
	.thumb_func
HAL_NVIC_GetPriorityGrouping:
@ BB#0:                                 @ %entry
	push	{r7, lr}
	mov	r7, sp
	bl	NVIC_GetPriorityGrouping
	pop	{r7, pc}
.Ltmp79:
	.size	HAL_NVIC_GetPriorityGrouping, .Ltmp79-HAL_NVIC_GetPriorityGrouping

	.globl	HAL_NVIC_GetPriority
	.align	2
	.type	HAL_NVIC_GetPriority,%function
	.code	16                      @ @HAL_NVIC_GetPriority
	.thumb_func
HAL_NVIC_GetPriority:
@ BB#0:                                 @ %entry
	push	{r7, lr}
	mov	r7, sp
	sub	sp, #24
	str	r0, [sp, #20]
	str	r1, [sp, #16]
	str	r2, [sp, #8]
	str	r3, [sp]
	ldr	r0, [sp, #20]
	bl	NVIC_GetPriority
	ldr	r3, [sp]
	ldr	r2, [sp, #8]
	ldr	r1, [sp, #16]
	bl	NVIC_DecodePriority
	add	sp, #24
	pop	{r7, pc}
.Ltmp80:
	.size	HAL_NVIC_GetPriority, .Ltmp80-HAL_NVIC_GetPriority

	.globl	HAL_NVIC_SetPendingIRQ
	.align	2
	.type	HAL_NVIC_SetPendingIRQ,%function
	.code	16                      @ @HAL_NVIC_SetPendingIRQ
	.thumb_func
HAL_NVIC_SetPendingIRQ:
@ BB#0:                                 @ %entry
	push	{r7, lr}
	mov	r7, sp
	sub	sp, #8
	str	r0, [sp, #4]
	bl	NVIC_SetPendingIRQ
	add	sp, #8
	pop	{r7, pc}
.Ltmp81:
	.size	HAL_NVIC_SetPendingIRQ, .Ltmp81-HAL_NVIC_SetPendingIRQ

	.globl	HAL_NVIC_GetPendingIRQ
	.align	2
	.type	HAL_NVIC_GetPendingIRQ,%function
	.code	16                      @ @HAL_NVIC_GetPendingIRQ
	.thumb_func
HAL_NVIC_GetPendingIRQ:
@ BB#0:                                 @ %entry
	push	{r7, lr}
	mov	r7, sp
	sub	sp, #8
	str	r0, [sp, #4]
	bl	NVIC_GetPendingIRQ
	add	sp, #8
	pop	{r7, pc}
.Ltmp82:
	.size	HAL_NVIC_GetPendingIRQ, .Ltmp82-HAL_NVIC_GetPendingIRQ

	.globl	HAL_NVIC_ClearPendingIRQ
	.align	2
	.type	HAL_NVIC_ClearPendingIRQ,%function
	.code	16                      @ @HAL_NVIC_ClearPendingIRQ
	.thumb_func
HAL_NVIC_ClearPendingIRQ:
@ BB#0:                                 @ %entry
	push	{r7, lr}
	mov	r7, sp
	sub	sp, #8
	str	r0, [sp, #4]
	bl	NVIC_ClearPendingIRQ
	add	sp, #8
	pop	{r7, pc}
.Ltmp83:
	.size	HAL_NVIC_ClearPendingIRQ, .Ltmp83-HAL_NVIC_ClearPendingIRQ

	.globl	HAL_NVIC_GetActive
	.align	2
	.type	HAL_NVIC_GetActive,%function
	.code	16                      @ @HAL_NVIC_GetActive
	.thumb_func
HAL_NVIC_GetActive:
@ BB#0:                                 @ %entry
	push	{r7, lr}
	mov	r7, sp
	sub	sp, #8
	str	r0, [sp, #4]
	bl	NVIC_GetActive
	add	sp, #8
	pop	{r7, pc}
.Ltmp84:
	.size	HAL_NVIC_GetActive, .Ltmp84-HAL_NVIC_GetActive

	.globl	HAL_SYSTICK_CLKSourceConfig
	.align	2
	.type	HAL_SYSTICK_CLKSourceConfig,%function
	.code	16                      @ @HAL_SYSTICK_CLKSourceConfig
	.thumb_func
HAL_SYSTICK_CLKSourceConfig:
@ BB#0:                                 @ %entry
	str	r0, [sp, #-4]!
	cmp	r0, #4
	movw	r0, #57360
	movt	r0, #57344
	ldr	r1, [r0]
	ite	ne
	bicne	r1, r1, #4
	orreq	r1, r1, #4
	str	r1, [r0]
	add	sp, #4
	bx	lr
.Ltmp85:
	.size	HAL_SYSTICK_CLKSourceConfig, .Ltmp85-HAL_SYSTICK_CLKSourceConfig

	.globl	HAL_SYSTICK_IRQHandler
	.align	2
	.type	HAL_SYSTICK_IRQHandler,%function
	.code	16                      @ @HAL_SYSTICK_IRQHandler
	.thumb_func
HAL_SYSTICK_IRQHandler:
@ BB#0:                                 @ %entry
	push	{r7, lr}
	mov	r7, sp
	bl	HAL_SYSTICK_Callback
	pop	{r7, pc}
.Ltmp86:
	.size	HAL_SYSTICK_IRQHandler, .Ltmp86-HAL_SYSTICK_IRQHandler

	.weak	HAL_SYSTICK_Callback
	.align	2
	.type	HAL_SYSTICK_Callback,%function
	.code	16                      @ @HAL_SYSTICK_Callback
	.thumb_func
HAL_SYSTICK_Callback:
@ BB#0:                                 @ %entry
	bx	lr
.Ltmp87:
	.size	HAL_SYSTICK_Callback, .Ltmp87-HAL_SYSTICK_Callback

	.weak	HAL_RCC_DeInit
	.align	2
	.type	HAL_RCC_DeInit,%function
	.code	16                      @ @HAL_RCC_DeInit
	.thumb_func
HAL_RCC_DeInit:
@ BB#0:                                 @ %entry
	bx	lr
.Ltmp88:
	.size	HAL_RCC_DeInit, .Ltmp88-HAL_RCC_DeInit

	.weak	HAL_RCC_OscConfig
	.align	2
	.type	HAL_RCC_OscConfig,%function
	.code	16                      @ @HAL_RCC_OscConfig
	.thumb_func
HAL_RCC_OscConfig:
@ BB#0:                                 @ %entry
	push.w	{r4, r5, r6, r7, r8, lr}
	add	r7, sp, #12
	sub	sp, #56
	str	r0, [sp, #8]
	movs	r0, #0
	str	r0, [sp, #4]
	ldr	r0, [sp, #8]
	ldr	r0, [r0]
	tst.w	r0, #1
	beq	.LBB89_13
@ BB#1:                                 @ %if.then
	movw	r0, #14344
	movt	r0, #16386
	ldr	r1, [r0]
	and	r1, r1, #12
	cmp	r1, #4
	beq	.LBB89_4
@ BB#2:                                 @ %lor.lhs.false
	ldr	r0, [r0]
	and	r0, r0, #12
	cmp	r0, #8
	bne	.LBB89_6
@ BB#3:                                 @ %land.lhs.true
	movw	r0, #14340
	movt	r0, #16386
	ldr	r0, [r0]
	tst.w	r0, #4194304
	beq	.LBB89_6
.LBB89_4:                               @ %if.then7
	movw	r0, #14336
	movt	r0, #16386
	ldr	r0, [r0]
	ands	r0, r0, #131072
	it	ne
	movne	r0, #1
	cmp	r0, #0
	beq	.LBB89_13
@ BB#5:                                 @ %land.lhs.true11
	ldr	r0, [sp, #8]
	ldr	r0, [r0, #4]
	cmp	r0, #0
	bne	.LBB89_13
	b	.LBB89_53
.LBB89_6:                               @ %if.else
	ldr	r0, [sp, #8]
	movw	r1, #14338
	movt	r1, #16386
	ldr	r0, [r0, #4]
	strb	r0, [r1]
	ldr	r0, [sp, #8]
	ldr	r0, [r0, #4]
	cbz	r0, .LBB89_10
@ BB#7:                                 @ %if.then18
	bl	HAL_GetTick
	movw	r4, #14336
	str	r0, [sp, #4]
	movt	r4, #16386
.LBB89_8:                               @ %while.cond
                                        @ =>This Inner Loop Header: Depth=1
	ldr	r0, [r4]
	ands	r0, r0, #131072
	it	ne
	movne	r0, #1
	cbnz	r0, .LBB89_13
@ BB#9:                                 @ %while.body
                                        @   in Loop: Header=BB89_8 Depth=1
	bl	HAL_GetTick
	ldr	r1, [sp, #4]
	subs	r0, r0, r1
	cmp	r0, #101
	blo	.LBB89_8
	b	.LBB89_60
.LBB89_10:                              @ %if.else30
	bl	HAL_GetTick
	movw	r4, #14336
	str	r0, [sp, #4]
	movt	r4, #16386
.LBB89_11:                              @ %while.cond32
                                        @ =>This Inner Loop Header: Depth=1
	ldr	r0, [r4]
	ands	r0, r0, #131072
	it	ne
	movne	r0, #1
	cbz	r0, .LBB89_13
@ BB#12:                                @ %while.body39
                                        @   in Loop: Header=BB89_11 Depth=1
	bl	HAL_GetTick
	ldr	r1, [sp, #4]
	subs	r0, r0, r1
	cmp	r0, #101
	blo	.LBB89_11
	b	.LBB89_60
.LBB89_13:                              @ %if.end49
	ldr	r0, [sp, #8]
	ldr	r0, [r0]
	tst.w	r0, #2
	beq.w	.LBB89_28
@ BB#14:                                @ %if.then54
	movw	r0, #14344
	movt	r0, #16386
	ldr	r1, [r0]
	tst.w	r1, #12
	beq	.LBB89_21
@ BB#15:                                @ %lor.lhs.false58
	ldr	r0, [r0]
	and	r0, r0, #12
	cmp	r0, #8
	bne	.LBB89_17
@ BB#16:                                @ %land.lhs.true62
	movw	r0, #14340
	movt	r0, #16386
	ldr	r0, [r0]
	tst.w	r0, #4194304
	beq	.LBB89_21
.LBB89_17:                              @ %if.else81
	ldr	r0, [sp, #8]
	ldr	r0, [r0, #12]
	cbz	r0, .LBB89_24
@ BB#18:                                @ %if.then85
	movs	r0, #0
	movs	r1, #1
	movt	r0, #16967
	str	r1, [r0]
	bl	HAL_GetTick
	movw	r4, #14336
	str	r0, [sp, #4]
	movt	r4, #16386
.LBB89_19:                              @ %while.cond87
                                        @ =>This Inner Loop Header: Depth=1
	ldr	r0, [r4]
	ands	r0, r0, #2
	it	ne
	movne	r0, #1
	cmp	r0, #0
	bne	.LBB89_27
@ BB#20:                                @ %while.body94
                                        @   in Loop: Header=BB89_19 Depth=1
	bl	HAL_GetTick
	ldr	r1, [sp, #4]
	subs	r0, r0, r1
	cmp	r0, #3
	blo	.LBB89_19
	b	.LBB89_60
.LBB89_21:                              @ %if.then66
	movw	r0, #14336
	movt	r0, #16386
	ldr	r1, [r0]
	ands	r1, r1, #2
	it	ne
	movne	r1, #1
	cbz	r1, .LBB89_23
@ BB#22:                                @ %land.lhs.true73
	ldr	r1, [sp, #8]
	ldr	r1, [r1, #12]
	cmp	r1, #1
	bne.w	.LBB89_53
.LBB89_23:                              @ %if.else77
	ldr	r1, [r0]
	ldr	r2, [sp, #8]
	movs	r3, #248
	ldr	r2, [r2, #16]
	str	r3, [sp, #20]
	@APP
	rbit r3, r3
	@NO_APP
	bic	r1, r1, #248
	str	r3, [sp, #16]
	clz	r3, r3
	lsls	r2, r3
	orrs	r1, r2
	str	r1, [r0]
	b	.LBB89_28
.LBB89_24:                              @ %if.else107
	movs	r0, #0
	movs	r1, #0
	movt	r0, #16967
	str	r1, [r0]
	bl	HAL_GetTick
	movw	r4, #14336
	str	r0, [sp, #4]
	movt	r4, #16386
.LBB89_25:                              @ %while.cond109
                                        @ =>This Inner Loop Header: Depth=1
	ldr	r0, [r4]
	ands	r0, r0, #2
	it	ne
	movne	r0, #1
	cbz	r0, .LBB89_28
@ BB#26:                                @ %while.body116
                                        @   in Loop: Header=BB89_25 Depth=1
	bl	HAL_GetTick
	ldr	r1, [sp, #4]
	subs	r0, r0, r1
	cmp	r0, #3
	blo	.LBB89_25
	b	.LBB89_60
.LBB89_27:                              @ %while.end101
	ldr	r0, [r4]
	ldr	r1, [sp, #8]
	movs	r2, #248
	ldr	r1, [r1, #16]
	str	r2, [sp, #28]
	@APP
	rbit r2, r2
	@NO_APP
	bic	r0, r0, #248
	str	r2, [sp, #24]
	clz	r2, r2
	lsls	r1, r2
	orrs	r0, r1
	str	r0, [r4]
.LBB89_28:                              @ %if.end126
	ldr	r0, [sp, #8]
	ldr	r0, [r0]
	tst.w	r0, #8
	beq	.LBB89_36
@ BB#29:                                @ %if.then131
	ldr	r0, [sp, #8]
	ldr	r0, [r0, #20]
	cbz	r0, .LBB89_33
@ BB#30:                                @ %if.then134
	movw	r0, #3712
	movs	r1, #1
	movt	r0, #16967
	str	r1, [r0]
	bl	HAL_GetTick
	movw	r4, #14452
	str	r0, [sp, #4]
	movt	r4, #16386
.LBB89_31:                              @ %while.cond136
                                        @ =>This Inner Loop Header: Depth=1
	ldr	r0, [r4]
	ands	r0, r0, #2
	it	ne
	movne	r0, #1
	cbnz	r0, .LBB89_36
@ BB#32:                                @ %while.body143
                                        @   in Loop: Header=BB89_31 Depth=1
	bl	HAL_GetTick
	ldr	r1, [sp, #4]
	subs	r0, r0, r1
	cmp	r0, #3
	blo	.LBB89_31
	b	.LBB89_60
.LBB89_33:                              @ %if.else151
	movw	r0, #3712
	movs	r1, #0
	movt	r0, #16967
	str	r1, [r0]
	bl	HAL_GetTick
	movw	r4, #14452
	str	r0, [sp, #4]
	movt	r4, #16386
.LBB89_34:                              @ %while.cond153
                                        @ =>This Inner Loop Header: Depth=1
	ldr	r0, [r4]
	ands	r0, r0, #2
	it	ne
	movne	r0, #1
	cbz	r0, .LBB89_36
@ BB#35:                                @ %while.body160
                                        @   in Loop: Header=BB89_34 Depth=1
	bl	HAL_GetTick
	ldr	r1, [sp, #4]
	subs	r0, r0, r1
	cmp	r0, #3
	blo	.LBB89_34
	b	.LBB89_60
.LBB89_36:                              @ %if.end169
	ldr	r0, [sp, #8]
	ldr	r0, [r0]
	tst.w	r0, #4
	beq	.LBB89_47
@ BB#37:                                @ %do.end
	movs	r0, #0
	movw	r4, #28672
	str	r0, [sp]
	movw	r0, #14400
	movt	r4, #16384
	movt	r0, #16386
	ldr	r1, [r0]
	orr	r1, r1, #268435456
	str	r1, [r0]
	ldr	r0, [r0]
	and	r0, r0, #268435456
	str	r0, [sp]
	ldr	r0, [sp]
	ldr	r0, [r4]
	orr	r0, r0, #256
	str	r0, [r4]
	bl	HAL_GetTick
	str	r0, [sp, #4]
.LBB89_38:                              @ %while.cond179
                                        @ =>This Inner Loop Header: Depth=1
	ldr	r0, [r4]
	tst.w	r0, #256
	bne	.LBB89_40
@ BB#39:                                @ %while.body183
                                        @   in Loop: Header=BB89_38 Depth=1
	bl	HAL_GetTick
	ldr	r1, [sp, #4]
	subs	r0, r0, r1
	cmp	r0, #3
	blo	.LBB89_38
	b	.LBB89_60
.LBB89_40:                              @ %while.end190
	ldr	r0, [sp, #8]
	movw	r4, #14448
	movt	r4, #16386
	ldr	r0, [r0, #8]
	strb	r0, [r4]
	ldr	r0, [sp, #8]
	ldr	r0, [r0, #8]
	cbz	r0, .LBB89_44
@ BB#41:                                @ %if.then195
	bl	HAL_GetTick
	movw	r5, #5001
	str	r0, [sp, #4]
.LBB89_42:                              @ %while.cond197
                                        @ =>This Inner Loop Header: Depth=1
	ldr	r0, [r4]
	ands	r0, r0, #2
	it	ne
	movne	r0, #1
	cbnz	r0, .LBB89_47
@ BB#43:                                @ %while.body204
                                        @   in Loop: Header=BB89_42 Depth=1
	bl	HAL_GetTick
	ldr	r1, [sp, #4]
	subs	r0, r0, r1
	cmp	r0, r5
	blo	.LBB89_42
	b	.LBB89_60
.LBB89_44:                              @ %if.else212
	bl	HAL_GetTick
	movw	r5, #5001
	str	r0, [sp, #4]
.LBB89_45:                              @ %while.cond214
                                        @ =>This Inner Loop Header: Depth=1
	ldr	r0, [r4]
	ands	r0, r0, #2
	it	ne
	movne	r0, #1
	cbz	r0, .LBB89_47
@ BB#46:                                @ %while.body221
                                        @   in Loop: Header=BB89_45 Depth=1
	bl	HAL_GetTick
	ldr	r1, [sp, #4]
	subs	r0, r0, r1
	cmp	r0, r5
	blo	.LBB89_45
	b	.LBB89_60
.LBB89_47:                              @ %if.end230
	ldr	r0, [sp, #8]
	ldr	r0, [r0, #24]
	cmp	r0, #0
	beq.w	.LBB89_61
@ BB#48:                                @ %if.then233
	movw	r0, #14344
	movt	r0, #16386
	ldr	r0, [r0]
	and	r0, r0, #12
	cmp	r0, #8
	beq	.LBB89_53
@ BB#49:                                @ %if.then237
	ldr	r0, [sp, #8]
	ldr	r0, [r0, #24]
	cmp	r0, #2
	bne	.LBB89_54
@ BB#50:                                @ %if.then242
	movw	r8, #96
	movs	r0, #0
	movt	r8, #16967
	str.w	r0, [r8]
	bl	HAL_GetTick
	movw	r4, #14336
	str	r0, [sp, #4]
	movt	r4, #16386
.LBB89_51:                              @ %while.cond244
                                        @ =>This Inner Loop Header: Depth=1
	ldr	r0, [r4]
	ands	r0, r0, #33554432
	it	ne
	movne	r0, #1
	cbz	r0, .LBB89_57
@ BB#52:                                @ %while.body251
                                        @   in Loop: Header=BB89_51 Depth=1
	bl	HAL_GetTick
	ldr	r1, [sp, #4]
	subs	r0, r0, r1
	cmp	r0, #3
	blo	.LBB89_51
	b	.LBB89_60
.LBB89_53:                              @ %if.then13
	movs	r0, #1
	b	.LBB89_62
.LBB89_54:                              @ %if.else291
	movs	r0, #96
	movs	r1, #0
	movt	r0, #16967
	str	r1, [r0]
	bl	HAL_GetTick
	movw	r4, #14336
	str	r0, [sp, #4]
	movt	r4, #16386
.LBB89_55:                              @ %while.cond293
                                        @ =>This Inner Loop Header: Depth=1
	ldr	r0, [r4]
	ands	r0, r0, #33554432
	it	ne
	movne	r0, #1
	cmp	r0, #0
	beq	.LBB89_61
@ BB#56:                                @ %while.body300
                                        @   in Loop: Header=BB89_55 Depth=1
	bl	HAL_GetTick
	ldr	r1, [sp, #4]
	subs	r0, r0, r1
	cmp	r0, #3
	blo	.LBB89_55
	b	.LBB89_60
.LBB89_57:                              @ %while.end258
	ldr	r0, [sp, #8]
	movw	r3, #32704
	mov.w	r6, #196608
	mov.w	r2, #251658240
	ldr.w	r12, [r0, #28]
	ldr.w	lr, [r0, #32]
	ldr	r0, [r0, #36]
	str	r3, [sp, #36]
	@APP
	rbit r3, r3
	@NO_APP
	ldr	r5, [sp, #8]
	str	r3, [sp, #32]
	clz	r3, r3
	ldr	r5, [r5, #40]
	str	r6, [sp, #44]
	@APP
	rbit r6, r6
	@NO_APP
	ldr	r1, [sp, #8]
	lsls	r0, r3
	orr.w	r3, r12, lr
	str	r6, [sp, #40]
	orrs	r0, r3
	mov.w	r3, #-1
	clz	r6, r6
	ldr	r1, [r1, #44]
	str	r2, [sp, #52]
	@APP
	rbit r2, r2
	@NO_APP
	add.w	r3, r3, r5, lsr #1
	str	r2, [sp, #48]
	lsls	r3, r6
	clz	r2, r2
	orrs	r0, r3
	lsls	r1, r2
	orrs	r0, r1
	movw	r1, #14340
	movt	r1, #16386
	str	r0, [r1]
	movs	r0, #1
	str.w	r0, [r8]
	bl	HAL_GetTick
	str	r0, [sp, #4]
.LBB89_58:                              @ %while.cond276
                                        @ =>This Inner Loop Header: Depth=1
	ldr	r0, [r4]
	ands	r0, r0, #33554432
	it	ne
	movne	r0, #1
	cbnz	r0, .LBB89_61
@ BB#59:                                @ %while.body283
                                        @   in Loop: Header=BB89_58 Depth=1
	bl	HAL_GetTick
	ldr	r1, [sp, #4]
	subs	r0, r0, r1
	cmp	r0, #3
	blo	.LBB89_58
.LBB89_60:                              @ %if.then28
	movs	r0, #3
	b	.LBB89_62
.LBB89_61:                              @ %if.end311
	movs	r0, #0
.LBB89_62:                              @ %return
	str	r0, [sp, #12]
	ldr	r0, [sp, #12]
	add	sp, #56
	pop.w	{r4, r5, r6, r7, r8, pc}
.Ltmp89:
	.size	HAL_RCC_OscConfig, .Ltmp89-HAL_RCC_OscConfig

	.globl	HAL_RCC_ClockConfig
	.align	2
	.type	HAL_RCC_ClockConfig,%function
	.code	16                      @ @HAL_RCC_ClockConfig
	.thumb_func
HAL_RCC_ClockConfig:
@ BB#0:                                 @ %entry
	push.w	{r4, r5, r6, r7, r11, lr}
	add	r7, sp, #12
	sub	sp, #24
	movw	r4, #15360
	str	r0, [sp, #8]
	movs	r0, #0
	str	r1, [sp, #4]
	movt	r4, #16386
	str	r0, [sp]
	ldr	r0, [sp, #4]
	ldr	r1, [r4]
	and	r1, r1, #15
	cmp	r0, r1
	bls	.LBB90_2
@ BB#1:                                 @ %if.then
	ldr	r0, [sp, #4]
	strb	r0, [r4]
	ldr	r0, [r4]
	ldr	r1, [sp, #4]
	and	r0, r0, #15
	cmp	r0, r1
	bne.w	.LBB90_27
.LBB90_2:                               @ %if.end5
	ldr	r0, [sp, #8]
	ldr	r0, [r0]
	tst.w	r0, #2
	beq	.LBB90_4
@ BB#3:                                 @ %if.then9
	movw	r0, #14344
	movt	r0, #16386
	ldr	r1, [r0]
	ldr	r2, [sp, #8]
	ldr	r2, [r2, #8]
	bic	r1, r1, #240
	orrs	r1, r2
	str	r1, [r0]
.LBB90_4:                               @ %if.end11
	ldr	r0, [sp, #8]
	ldr	r0, [r0]
	tst.w	r0, #1
	beq.w	.LBB90_25
@ BB#5:                                 @ %if.then16
	ldr	r0, [sp, #8]
	ldr	r0, [r0, #4]
	cmp	r0, #1
	bne	.LBB90_7
@ BB#6:                                 @ %if.then19
	movw	r0, #14336
	movt	r0, #16386
	ldr	r0, [r0]
	ands	r0, r0, #131072
	it	ne
	movne	r0, #1
	cmp	r0, #0
	bne	.LBB90_11
	b	.LBB90_27
.LBB90_7:                               @ %if.else
	ldr	r0, [sp, #8]
	ldr	r0, [r0, #4]
	cmp	r0, #2
	beq	.LBB90_9
@ BB#8:                                 @ %lor.lhs.false
	ldr	r0, [sp, #8]
	ldr	r0, [r0, #4]
	cmp	r0, #3
	bne	.LBB90_10
.LBB90_9:                               @ %if.then33
	movw	r0, #14336
	movt	r0, #16386
	ldr	r0, [r0]
	ands	r0, r0, #33554432
	it	ne
	movne	r0, #1
	cmp	r0, #0
	bne	.LBB90_11
	b	.LBB90_27
.LBB90_10:                              @ %if.else42
	movw	r0, #14336
	movt	r0, #16386
	ldr	r0, [r0]
	ands	r0, r0, #2
	it	ne
	movne	r0, #1
	cmp	r0, #0
	beq	.LBB90_27
.LBB90_11:                              @ %if.end52
	movw	r5, #14344
	movt	r5, #16386
	ldr	r0, [r5]
	ldr	r1, [sp, #8]
	ldr	r1, [r1, #4]
	bic	r0, r0, #3
	orrs	r0, r1
	str	r0, [r5]
	bl	HAL_GetTick
	str	r0, [sp]
	ldr	r0, [sp, #8]
	ldr	r0, [r0, #4]
	cmp	r0, #1
	bne	.LBB90_15
@ BB#12:
	movw	r6, #5001
.LBB90_13:                              @ %while.cond
                                        @ =>This Inner Loop Header: Depth=1
	ldr	r0, [r5]
	and	r0, r0, #12
	cmp	r0, #4
	beq	.LBB90_25
@ BB#14:                                @ %while.body
                                        @   in Loop: Header=BB90_13 Depth=1
	bl	HAL_GetTick
	ldr	r1, [sp]
	subs	r0, r0, r1
	cmp	r0, r6
	blo	.LBB90_13
	b	.LBB90_24
.LBB90_15:                              @ %if.else68
	ldr	r0, [sp, #8]
	ldr	r0, [r0, #4]
	cmp	r0, #2
	bne	.LBB90_19
@ BB#16:
	movw	r6, #5001
.LBB90_17:                              @ %while.cond73
                                        @ =>This Inner Loop Header: Depth=1
	ldr	r0, [r5]
	and	r0, r0, #12
	cmp	r0, #8
	beq	.LBB90_25
@ BB#18:                                @ %while.body77
                                        @   in Loop: Header=BB90_17 Depth=1
	bl	HAL_GetTick
	ldr	r1, [sp]
	subs	r0, r0, r1
	cmp	r0, r6
	blo	.LBB90_17
	b	.LBB90_24
.LBB90_19:                              @ %if.else85
	ldr	r0, [sp, #8]
	movw	r6, #5001
	ldr	r0, [r0, #4]
	cmp	r0, #3
	bne	.LBB90_22
.LBB90_20:                              @ %while.cond90
                                        @ =>This Inner Loop Header: Depth=1
	ldr	r0, [r5]
	and	r0, r0, #12
	cmp	r0, #12
	beq	.LBB90_25
@ BB#21:                                @ %while.body94
                                        @   in Loop: Header=BB90_20 Depth=1
	bl	HAL_GetTick
	ldr	r1, [sp]
	subs	r0, r0, r1
	cmp	r0, r6
	blo	.LBB90_20
	b	.LBB90_24
.LBB90_22:                              @ %while.cond103
                                        @ =>This Inner Loop Header: Depth=1
	ldr	r0, [r5]
	tst.w	r0, #12
	beq	.LBB90_25
@ BB#23:                                @ %while.body107
                                        @   in Loop: Header=BB90_22 Depth=1
	bl	HAL_GetTick
	ldr	r1, [sp]
	subs	r0, r0, r1
	cmp	r0, r6
	blo	.LBB90_22
.LBB90_24:                              @ %if.then66
	movs	r0, #3
	b	.LBB90_33
.LBB90_25:                              @ %if.end118
	ldr	r0, [sp, #4]
	ldr	r1, [r4]
	and	r1, r1, #15
	cmp	r0, r1
	bhs	.LBB90_28
@ BB#26:                                @ %if.then122
	ldr	r0, [sp, #4]
	strb	r0, [r4]
	ldr	r0, [r4]
	ldr	r1, [sp, #4]
	and	r0, r0, #15
	cmp	r0, r1
	beq	.LBB90_28
.LBB90_27:                              @ %if.then4
	movs	r0, #1
	b	.LBB90_33
.LBB90_28:                              @ %if.end129
	ldr	r0, [sp, #8]
	ldr	r0, [r0]
	tst.w	r0, #4
	beq	.LBB90_30
@ BB#29:                                @ %if.then134
	movw	r0, #14344
	movt	r0, #16386
	ldr	r1, [r0]
	ldr	r2, [sp, #8]
	ldr	r2, [r2, #12]
	bic	r1, r1, #7168
	orrs	r1, r2
	str	r1, [r0]
.LBB90_30:                              @ %if.end137
	ldr	r0, [sp, #8]
	ldr	r0, [r0]
	tst.w	r0, #8
	beq	.LBB90_32
@ BB#31:                                @ %if.then142
	movw	r0, #14344
	movt	r0, #16386
	ldr	r1, [r0]
	ldr	r2, [sp, #8]
	ldr	r2, [r2, #16]
	bic	r1, r1, #57344
	orr.w	r1, r1, r2, lsl #3
	str	r1, [r0]
.LBB90_32:                              @ %if.end145
	bl	HAL_RCC_GetSysClockFreq
	movw	r1, #14344
	movs	r2, #240
	movt	r1, #16386
	ldr	r1, [r1]
	str	r2, [sp, #20]
	@APP
	rbit r2, r2
	@NO_APP
	str	r2, [sp, #16]
	clz	r2, r2
	and	r1, r1, #240
	lsrs	r1, r2
	movw	r2, :lower16:APBAHBPrescTable
	movt	r2, :upper16:APBAHBPrescTable
	ldrb	r1, [r2, r1]
	lsrs	r0, r1
	movw	r1, :lower16:SystemCoreClock
	movt	r1, :upper16:SystemCoreClock
	str	r0, [r1]
	movs	r0, #15
	bl	HAL_InitTick
	movs	r0, #0
.LBB90_33:                              @ %return
	str	r0, [sp, #12]
	ldr	r0, [sp, #12]
	add	sp, #24
	pop.w	{r4, r5, r6, r7, r11, pc}
.Ltmp90:
	.size	HAL_RCC_ClockConfig, .Ltmp90-HAL_RCC_ClockConfig

	.weak	HAL_RCC_GetSysClockFreq
	.align	2
	.type	HAL_RCC_GetSysClockFreq,%function
	.code	16                      @ @HAL_RCC_GetSysClockFreq
	.thumb_func
HAL_RCC_GetSysClockFreq:
@ BB#0:                                 @ %entry
	push.w	{r11, lr}
	sub	sp, #40
	movs	r0, #0
	str	r0, [sp, #12]
	str	r0, [sp, #8]
	str	r0, [sp, #4]
	str	r0, [sp]
	movw	r0, #14344
	movt	r0, #16386
	ldr	r0, [r0]
	and	r0, r0, #12
	cmp	r0, #8
	beq	.LBB91_3
@ BB#1:                                 @ %entry
	cmp	r0, #4
	bne	.LBB91_5
@ BB#2:                                 @ %sw.bb1
	movw	r0, #30784
	movt	r0, #381
	b	.LBB91_8
.LBB91_3:                               @ %sw.bb2
	movw	r0, #14340
	movt	r0, #16386
	ldr	r1, [r0]
	and	r1, r1, #63
	str	r1, [sp, #12]
	ldr	r1, [r0]
	tst.w	r1, #4194304
	beq	.LBB91_6
@ BB#4:                                 @ %if.then
	ldr.w	r12, [sp, #12]
	ldr.w	lr, [r0]
	movw	r3, #32704
	movw	r2, #30784
	str	r3, [sp, #20]
	@APP
	rbit r1, r3
	@NO_APP
	movt	r2, #381
	str	r1, [sp, #16]
	b	.LBB91_7
.LBB91_5:                               @ %entry
	cmp	r0, #0
	movw	r0, #9216
	movt	r0, #244
	b	.LBB91_8
.LBB91_6:                               @ %if.else
	ldr.w	r12, [sp, #12]
	ldr.w	lr, [r0]
	movw	r2, #9216
	movw	r3, #32704
	str	r3, [sp, #28]
	@APP
	rbit r1, r3
	@NO_APP
	movt	r2, #244
	str	r1, [sp, #24]
.LBB91_7:                               @ %if.end
	and.w	r3, r3, lr
	clz	r1, r1
	udiv	r2, r2, r12
	lsr.w	r1, r3, r1
	muls	r1, r2, r1
	str	r1, [sp, #8]
	ldr	r0, [r0]
	mov.w	r1, #196608
	str	r1, [sp, #36]
	@APP
	rbit r1, r1
	@NO_APP
	str	r1, [sp, #32]
	clz	r1, r1
	and	r0, r0, #196608
	lsrs	r0, r1
	ldr	r1, [sp, #8]
	adds	r0, #1
	lsls	r0, r0, #1
	str	r0, [sp, #4]
	udiv	r0, r1, r0
.LBB91_8:                               @ %sw.epilog
	str	r0, [sp]
	ldr	r0, [sp]
	add	sp, #40
	pop.w	{r11, pc}
.Ltmp91:
	.size	HAL_RCC_GetSysClockFreq, .Ltmp91-HAL_RCC_GetSysClockFreq

	.globl	HAL_RCC_MCOConfig
	.align	2
	.type	HAL_RCC_MCOConfig,%function
	.code	16                      @ @HAL_RCC_MCOConfig
	.thumb_func
HAL_RCC_MCOConfig:
@ BB#0:                                 @ %entry
	push	{r7, lr}
	mov	r7, sp
	sub	sp, #40
	str	r0, [sp, #36]
	str	r1, [sp, #32]
	str	r2, [sp, #28]
	ldr	r0, [sp, #36]
	cmp	r0, #0
	beq	.LBB92_2
@ BB#1:                                 @ %do.end8
	movw	r1, #14384
	movs	r0, #0
	str	r0, [sp]
	movt	r1, #16386
	ldr	r2, [r1]
	orr	r2, r2, #4
	str	r2, [r1]
	ldr	r1, [r1]
	and	r1, r1, #4
	str	r1, [sp]
	ldr	r1, [sp]
	mov.w	r1, #512
	str	r1, [sp, #8]
	movs	r1, #2
	str	r1, [sp, #12]
	movs	r1, #3
	str	r1, [sp, #20]
	str	r0, [sp, #16]
	str	r0, [sp, #24]
	movw	r0, #2048
	add	r1, sp, #8
	movt	r0, #16386
	 push {r4} 
	 movw r4, :lower16:HAL_GPIO_Init
	 movt r4, :upper16:HAL_GPIO_Init
	 bl gateway_gpio
	 pop {r4} 
	movw	r0, #14344
	movt	r0, #16386
	ldr	r1, [r0]
	ldr	r2, [sp, #28]
	ldr	r3, [sp, #32]
	orr.w	r2, r3, r2, lsl #3
	bic	r1, r1, #-134217728
	b	.LBB92_3
.LBB92_2:                               @ %do.end
	movw	r1, #14384
	movs	r0, #0
	str	r0, [sp, #4]
	movt	r1, #16386
	ldr	r2, [r1]
	orr	r2, r2, #1
	str	r2, [r1]
	ldr	r1, [r1]
	and	r1, r1, #1
	str	r1, [sp, #4]
	ldr	r1, [sp, #4]
	mov.w	r1, #256
	str	r1, [sp, #8]
	movs	r1, #2
	str	r1, [sp, #12]
	movs	r1, #3
	str	r1, [sp, #20]
	str	r0, [sp, #16]
	str	r0, [sp, #24]
	movs	r0, #0
	add	r1, sp, #8
	movt	r0, #16386
	 push {r4} 
	 movw r4, :lower16:HAL_GPIO_Init
	 movt r4, :upper16:HAL_GPIO_Init
	 bl gateway_gpio
	 pop {r4} 
	movw	r0, #14344
	movt	r0, #16386
	ldr	r1, [r0]
	ldr	r2, [sp, #28]
	ldr	r3, [sp, #32]
	orrs	r2, r3
	bic	r1, r1, #123731968
.LBB92_3:                               @ %if.end
	orrs	r1, r2
	str	r1, [r0]
	add	sp, #40
	pop	{r7, pc}
.Ltmp92:
	.size	HAL_RCC_MCOConfig, .Ltmp92-HAL_RCC_MCOConfig

	.globl	HAL_RCC_EnableCSS
	.align	2
	.type	HAL_RCC_EnableCSS,%function
	.code	16                      @ @HAL_RCC_EnableCSS
	.thumb_func
HAL_RCC_EnableCSS:
@ BB#0:                                 @ %entry
	movs	r0, #76
	movs	r1, #1
	movt	r0, #16967
	str	r1, [r0]
	bx	lr
.Ltmp93:
	.size	HAL_RCC_EnableCSS, .Ltmp93-HAL_RCC_EnableCSS

	.globl	HAL_RCC_DisableCSS
	.align	2
	.type	HAL_RCC_DisableCSS,%function
	.code	16                      @ @HAL_RCC_DisableCSS
	.thumb_func
HAL_RCC_DisableCSS:
@ BB#0:                                 @ %entry
	movs	r0, #76
	movs	r1, #0
	movt	r0, #16967
	str	r1, [r0]
	bx	lr
.Ltmp94:
	.size	HAL_RCC_DisableCSS, .Ltmp94-HAL_RCC_DisableCSS

	.globl	HAL_RCC_GetHCLKFreq
	.align	2
	.type	HAL_RCC_GetHCLKFreq,%function
	.code	16                      @ @HAL_RCC_GetHCLKFreq
	.thumb_func
HAL_RCC_GetHCLKFreq:
@ BB#0:                                 @ %entry
	movw	r0, :lower16:SystemCoreClock
	movt	r0, :upper16:SystemCoreClock
	ldr	r0, [r0]
	bx	lr
.Ltmp95:
	.size	HAL_RCC_GetHCLKFreq, .Ltmp95-HAL_RCC_GetHCLKFreq

	.globl	HAL_RCC_GetPCLK1Freq
	.align	2
	.type	HAL_RCC_GetPCLK1Freq,%function
	.code	16                      @ @HAL_RCC_GetPCLK1Freq
	.thumb_func
HAL_RCC_GetPCLK1Freq:
@ BB#0:                                 @ %entry
	push	{r7, lr}
	mov	r7, sp
	sub	sp, #8
	bl	HAL_RCC_GetHCLKFreq
	movw	r1, #14344
	mov.w	r2, #7168
	movt	r1, #16386
	ldr	r1, [r1]
	str	r2, [sp, #4]
	@APP
	rbit r2, r2
	@NO_APP
	str	r2, [sp]
	clz	r2, r2
	and	r1, r1, #7168
	lsrs	r1, r2
	movw	r2, :lower16:APBAHBPrescTable
	movt	r2, :upper16:APBAHBPrescTable
	ldrb	r1, [r2, r1]
	lsrs	r0, r1
	add	sp, #8
	pop	{r7, pc}
.Ltmp96:
	.size	HAL_RCC_GetPCLK1Freq, .Ltmp96-HAL_RCC_GetPCLK1Freq

	.globl	HAL_RCC_GetPCLK2Freq
	.align	2
	.type	HAL_RCC_GetPCLK2Freq,%function
	.code	16                      @ @HAL_RCC_GetPCLK2Freq
	.thumb_func
HAL_RCC_GetPCLK2Freq:
@ BB#0:                                 @ %entry
	push	{r7, lr}
	mov	r7, sp
	sub	sp, #8
	bl	HAL_RCC_GetHCLKFreq
	movw	r1, #14344
	mov.w	r2, #57344
	movt	r1, #16386
	ldr	r1, [r1]
	str	r2, [sp, #4]
	@APP
	rbit r2, r2
	@NO_APP
	str	r2, [sp]
	clz	r2, r2
	and	r1, r1, #57344
	lsrs	r1, r2
	movw	r2, :lower16:APBAHBPrescTable
	movt	r2, :upper16:APBAHBPrescTable
	ldrb	r1, [r2, r1]
	lsrs	r0, r1
	add	sp, #8
	pop	{r7, pc}
.Ltmp97:
	.size	HAL_RCC_GetPCLK2Freq, .Ltmp97-HAL_RCC_GetPCLK2Freq

	.weak	HAL_RCC_GetOscConfig
	.align	2
	.type	HAL_RCC_GetOscConfig,%function
	.code	16                      @ @HAL_RCC_GetOscConfig
	.thumb_func
HAL_RCC_GetOscConfig:
@ BB#0:                                 @ %entry
	sub	sp, #40
	movs	r1, #15
	str	r0, [sp]
	str	r1, [r0]
	movw	r0, #14336
	movt	r0, #16386
	ldr	r1, [r0]
	tst.w	r1, #262144
	beq	.LBB98_2
@ BB#1:                                 @ %if.then
	ldr	r1, [sp]
	movs	r2, #5
	b	.LBB98_3
.LBB98_2:                               @ %if.else
	ldr	r1, [r0]
	tst.w	r1, #65536
	ldr	r1, [sp]
	ite	eq
	moveq	r2, #0
	movne	r2, #1
.LBB98_3:                               @ %if.end7
	str	r2, [r1, #4]
	ldr	r1, [r0]
	tst.w	r1, #1
	ldr	r1, [sp]
	ite	eq
	moveq	r2, #0
	movne	r2, #1
	str	r2, [r1, #12]
	movs	r2, #248
	ldr	r1, [r0]
	str	r2, [sp, #12]
	@APP
	rbit r2, r2
	@NO_APP
	str	r2, [sp, #8]
	clz	r2, r2
	and	r1, r1, #248
	lsrs	r1, r2
	ldr	r2, [sp]
	str	r1, [r2, #16]
	movw	r1, #14448
	movt	r1, #16386
	ldr	r2, [r1]
	tst.w	r2, #4
	beq	.LBB98_5
@ BB#4:                                 @ %if.then17
	ldr	r1, [sp]
	movs	r2, #5
	b	.LBB98_6
.LBB98_5:                               @ %if.else18
	ldr	r1, [r1]
	tst.w	r1, #1
	ldr	r1, [sp]
	ite	eq
	moveq	r2, #0
	movne	r2, #1
.LBB98_6:                               @ %if.end26
	str	r2, [r1, #8]
	movw	r1, #14452
	movt	r1, #16386
	ldr	r1, [r1]
	tst.w	r1, #1
	ldr	r1, [sp]
	ite	eq
	moveq	r2, #0
	movne	r2, #1
	str	r2, [r1, #20]
	ldr	r0, [r0]
	tst.w	r0, #16777216
	ldr	r0, [sp]
	ite	eq
	moveq	r1, #1
	movne	r1, #2
	str	r1, [r0, #24]
	movw	r0, #14340
	movt	r0, #16386
	ldr	r1, [r0]
	ldr	r2, [sp]
	and	r1, r1, #4194304
	str	r1, [r2, #28]
	ldr	r1, [r0]
	ldr	r2, [sp]
	and	r1, r1, #63
	str	r1, [r2, #32]
	movw	r2, #32704
	ldr	r1, [r0]
	str	r2, [sp, #20]
	@APP
	rbit r3, r2
	@NO_APP
	str	r3, [sp, #16]
	ands	r1, r2
	clz	r2, r3
	lsrs	r1, r2
	ldr	r2, [sp]
	str	r1, [r2, #36]
	mov.w	r2, #196608
	ldr	r1, [r0]
	str	r2, [sp, #28]
	@APP
	rbit r2, r2
	@NO_APP
	str	r2, [sp, #24]
	clz	r2, r2
	and	r1, r1, #196608
	add.w	r1, r1, #65536
	lsls	r1, r1, #1
	lsrs	r1, r2
	ldr	r2, [sp]
	str	r1, [r2, #40]
	mov.w	r1, #251658240
	ldr	r0, [r0]
	str	r1, [sp, #36]
	@APP
	rbit r1, r1
	@NO_APP
	str	r1, [sp, #32]
	clz	r1, r1
	and	r0, r0, #251658240
	lsrs	r0, r1
	ldr	r1, [sp]
	str	r0, [r1, #44]
	add	sp, #40
	bx	lr
.Ltmp98:
	.size	HAL_RCC_GetOscConfig, .Ltmp98-HAL_RCC_GetOscConfig

	.globl	HAL_RCC_GetClockConfig
	.align	2
	.type	HAL_RCC_GetClockConfig,%function
	.code	16                      @ @HAL_RCC_GetClockConfig
	.thumb_func
HAL_RCC_GetClockConfig:
@ BB#0:                                 @ %entry
	sub	sp, #16
	str	r0, [sp, #8]
	str	r1, [sp]
	movs	r1, #15
	ldr	r0, [sp, #8]
	str	r1, [r0]
	movw	r0, #14344
	movt	r0, #16386
	ldr	r1, [r0]
	ldr	r2, [sp, #8]
	and	r1, r1, #3
	str	r1, [r2, #4]
	ldr	r1, [r0]
	ldr	r2, [sp, #8]
	and	r1, r1, #240
	str	r1, [r2, #8]
	ldr	r1, [r0]
	ldr	r2, [sp, #8]
	and	r1, r1, #7168
	str	r1, [r2, #12]
	ldr	r0, [r0]
	ldr	r1, [sp, #8]
	and	r0, r0, #57344
	lsrs	r0, r0, #3
	str	r0, [r1, #16]
	movw	r0, #15360
	movt	r0, #16386
	ldr	r0, [r0]
	ldr	r1, [sp]
	and	r0, r0, #15
	str	r0, [r1]
	add	sp, #16
	bx	lr
.Ltmp99:
	.size	HAL_RCC_GetClockConfig, .Ltmp99-HAL_RCC_GetClockConfig

	.globl	HAL_RCC_NMI_IRQHandler
	.align	2
	.type	HAL_RCC_NMI_IRQHandler,%function
	.code	16                      @ @HAL_RCC_NMI_IRQHandler
	.thumb_func
HAL_RCC_NMI_IRQHandler:
@ BB#0:                                 @ %entry
	push	{r7, lr}
	movw	r0, #14348
	mov	r7, sp
	movt	r0, #16386
	ldr	r0, [r0]
	tst.w	r0, #128
	it	eq
	popeq	{r7, pc}
	bl	HAL_RCC_CSSCallback
	movw	r0, #14350
	movs	r1, #128
	movt	r0, #16386
	strb	r1, [r0]
	pop	{r7, pc}
.Ltmp100:
	.size	HAL_RCC_NMI_IRQHandler, .Ltmp100-HAL_RCC_NMI_IRQHandler

	.weak	HAL_RCC_CSSCallback
	.align	2
	.type	HAL_RCC_CSSCallback,%function
	.code	16                      @ @HAL_RCC_CSSCallback
	.thumb_func
HAL_RCC_CSSCallback:
@ BB#0:                                 @ %entry
	bx	lr
.Ltmp101:
	.size	HAL_RCC_CSSCallback, .Ltmp101-HAL_RCC_CSSCallback

	.text
	.align	2
	.type	NVIC_SetPriorityGrouping,%function
	.code	16                      @ @NVIC_SetPriorityGrouping
	.thumb_func
NVIC_SetPriorityGrouping:
@ BB#0:                                 @ %entry
	sub	sp, #12
	str	r0, [sp, #8]
	and	r0, r0, #7
	movw	r2, #63743
	str	r0, [sp]
	movw	r0, #60684
	movt	r0, #57344
	ldr	r1, [r0]
	str	r1, [sp, #4]
	ands	r1, r2
	ldr	r2, [sp]
	str	r1, [sp, #4]
	orr.w	r1, r1, r2, lsl #8
	orr	r1, r1, #67108864
	orr	r1, r1, #33161216
	str	r1, [sp, #4]
	str	r1, [r0]
	add	sp, #12
	bx	lr
.Ltmp102:
	.size	NVIC_SetPriorityGrouping, .Ltmp102-NVIC_SetPriorityGrouping

	.align	2
	.type	NVIC_GetPriorityGrouping,%function
	.code	16                      @ @NVIC_GetPriorityGrouping
	.thumb_func
NVIC_GetPriorityGrouping:
@ BB#0:                                 @ %entry
	movw	r0, #60684
	movt	r0, #57344
	ldr	r0, [r0]
	and	r0, r0, #1792
	lsrs	r0, r0, #8
	bx	lr
.Ltmp103:
	.size	NVIC_GetPriorityGrouping, .Ltmp103-NVIC_GetPriorityGrouping

	.align	2
	.type	NVIC_EncodePriority,%function
	.code	16                      @ @NVIC_EncodePriority
	.thumb_func
NVIC_EncodePriority:
@ BB#0:                                 @ %entry
	sub	sp, #24
	str	r0, [sp, #20]
	str	r1, [sp, #16]
	movs	r1, #0
	str	r2, [sp, #12]
	ldr	r0, [sp, #20]
	and	r0, r0, #7
	str	r0, [sp, #8]
	rsbs.w	r0, r0, #7
	sbc	r2, r1, #0
	cmp	r0, #4
	it	hi
	movhi	r1, #1
	cmp	r2, #0
	ite	ne
	movne	r2, #1
	moveq	r2, r1
	movs	r1, #1
	cmp	r2, #0
	itte	eq
	ldreq	r0, [sp, #8]
	rsbeq.w	r0, r0, #7
	movne	r0, #4
	str	r0, [sp, #4]
	ldr	r0, [sp, #8]
	adds	r0, #4
	cmp	r0, #7
	itte	hs
	ldrhs	r0, [sp, #8]
	subhs	r0, #3
	movlo	r0, #0
	ldr	r3, [sp, #12]
	lsl.w	r2, r1, r0
	str	r0, [sp]
	subs	r2, #1
	ands	r2, r3
	ldr	r3, [sp, #4]
	lsls	r1, r3
	ldr	r3, [sp, #16]
	subs	r1, #1
	ands	r1, r3
	lsl.w	r0, r1, r0
	orrs	r0, r2
	add	sp, #24
	bx	lr
.Ltmp104:
	.size	NVIC_EncodePriority, .Ltmp104-NVIC_EncodePriority

	.align	2
	.type	NVIC_SetPriority,%function
	.code	16                      @ @NVIC_SetPriority
	.thumb_func
NVIC_SetPriority:
@ BB#0:                                 @ %entry
	sub	sp, #8
	str	r0, [sp, #4]
	str	r1, [sp]
	ldr	r0, [sp, #4]
	cmp.w	r0, #-1
	ble	.LBB105_2
@ BB#1:                                 @ %if.else
	ldr	r0, [sp]
	ldr	r1, [sp, #4]
	movw	r2, #58368
	movt	r2, #57344
	lsls	r0, r0, #4
	strb	r0, [r1, r2]
	add	sp, #8
	bx	lr
.LBB105_2:                              @ %if.then
	ldr	r0, [sp, #4]
	ldr	r1, [sp]
	movw	r2, #60692
	movt	r2, #57344
	and	r0, r0, #15
	lsls	r1, r1, #4
	strb	r1, [r0, r2]
	add	sp, #8
	bx	lr
.Ltmp105:
	.size	NVIC_SetPriority, .Ltmp105-NVIC_SetPriority

	.align	2
	.type	NVIC_EnableIRQ,%function
	.code	16                      @ @NVIC_EnableIRQ
	.thumb_func
NVIC_EnableIRQ:
@ BB#0:                                 @ %entry
	str	r0, [sp, #-4]!
	and	r1, r0, #31
	movs	r2, #1
	lsrs	r0, r0, #5
	lsl.w	r1, r2, r1
	movw	r2, #57600
	movt	r2, #57344
	str.w	r1, [r2, r0, lsl #2]
	add	sp, #4
	bx	lr
.Ltmp106:
	.size	NVIC_EnableIRQ, .Ltmp106-NVIC_EnableIRQ

	.align	2
	.type	NVIC_DisableIRQ,%function
	.code	16                      @ @NVIC_DisableIRQ
	.thumb_func
NVIC_DisableIRQ:
@ BB#0:                                 @ %entry
	str	r0, [sp, #-4]!
	and	r1, r0, #31
	movs	r2, #1
	lsrs	r0, r0, #5
	lsl.w	r1, r2, r1
	movw	r2, #57728
	movt	r2, #57344
	str.w	r1, [r2, r0, lsl #2]
	add	sp, #4
	bx	lr
.Ltmp107:
	.size	NVIC_DisableIRQ, .Ltmp107-NVIC_DisableIRQ

	.align	2
	.type	NVIC_SystemReset,%function
	.code	16                      @ @NVIC_SystemReset
	.thumb_func
NVIC_SystemReset:
@ BB#0:                                 @ %entry
	movw	r0, #60684
	@APP
	dsb 0xF
	@NO_APP
	movs	r2, #4
	movt	r0, #57344
	movt	r2, #1530
	ldr	r1, [r0]
	and	r1, r1, #1792
	orrs	r1, r2
	str	r1, [r0]
	@APP
	dsb 0xF
	@NO_APP
.LBB108_1:                              @ %for.cond
                                        @ =>This Inner Loop Header: Depth=1
	@APP
	nop
	@NO_APP
	b	.LBB108_1
.Ltmp108:
	.size	NVIC_SystemReset, .Ltmp108-NVIC_SystemReset

	.align	2
	.type	SysTick_Config,%function
	.code	16                      @ @SysTick_Config
	.thumb_func
SysTick_Config:
@ BB#0:                                 @ %entry
	push.w	{r4, r7, r11, lr}
	add	r7, sp, #4
	sub	sp, #8
	str	r0, [sp]
	movs	r4, #0
	subs	r0, #1
	sbc	r1, r4, #0
	cmp.w	r0, #16777216
	mov.w	r0, #0
	it	lo
	movlo	r0, #1
	cmp	r1, #0
	it	ne
	movne	r0, r4
	cbnz	r0, .LBB109_2
@ BB#1:                                 @ %if.then
	movs	r0, #1
	str	r0, [sp, #4]
	b	.LBB109_3
.LBB109_2:                              @ %if.end
	ldr	r0, [sp]
	movw	r1, #57364
	movt	r1, #57344
	subs	r0, #1
	str	r0, [r1]
	mov.w	r0, #-1
	movs	r1, #15
	bl	NVIC_SetPriority
	movw	r0, #57368
	movs	r1, #7
	movt	r0, #57344
	str	r4, [r0]
	movw	r0, #57360
	movt	r0, #57344
	str	r1, [r0]
	str	r4, [sp, #4]
.LBB109_3:                              @ %return
	ldr	r0, [sp, #4]
	add	sp, #8
	pop.w	{r4, r7, r11, pc}
.Ltmp109:
	.size	SysTick_Config, .Ltmp109-SysTick_Config

	.align	2
	.type	NVIC_GetPriority,%function
	.code	16                      @ @NVIC_GetPriority
	.thumb_func
NVIC_GetPriority:
@ BB#0:                                 @ %entry
	sub	sp, #8
	str	r0, [sp]
	cmp.w	r0, #-1
	ble	.LBB110_2
@ BB#1:                                 @ %if.else
	ldr	r0, [sp]
	movw	r1, #58368
	b	.LBB110_3
.LBB110_2:                              @ %if.then
	ldr	r0, [sp]
	movw	r1, #60692
	and	r0, r0, #15
.LBB110_3:                              @ %return
	movt	r1, #57344
	ldrb	r0, [r0, r1]
	lsrs	r0, r0, #4
	str	r0, [sp, #4]
	ldr	r0, [sp, #4]
	add	sp, #8
	bx	lr
.Ltmp110:
	.size	NVIC_GetPriority, .Ltmp110-NVIC_GetPriority

	.align	2
	.type	NVIC_DecodePriority,%function
	.code	16                      @ @NVIC_DecodePriority
	.thumb_func
NVIC_DecodePriority:
@ BB#0:                                 @ %entry
	sub	sp, #40
	str	r1, [sp, #32]
	str	r0, [sp, #36]
	movs	r1, #0
	str	r2, [sp, #24]
	str	r3, [sp, #16]
	ldr	r0, [sp, #32]
	and	r0, r0, #7
	str	r0, [sp, #12]
	rsbs.w	r0, r0, #7
	sbc	r2, r1, #0
	cmp	r0, #4
	it	hi
	movhi	r1, #1
	cmp	r2, #0
	ite	ne
	movne	r2, #1
	moveq	r2, r1
	cmp	r2, #0
	mov.w	r2, #1
	itte	eq
	ldreq	r0, [sp, #12]
	rsbeq.w	r0, r0, #7
	movne	r0, #4
	str	r0, [sp, #8]
	ldr	r0, [sp, #12]
	adds	r0, #4
	cmp	r0, #7
	itte	hs
	ldrhs	r0, [sp, #12]
	subhs	r0, #3
	movlo	r0, #0
	ldr	r1, [sp, #36]
	str	r0, [sp, #4]
	lsr.w	r0, r1, r0
	ldr	r1, [sp, #8]
	lsl.w	r1, r2, r1
	subs	r1, #1
	ands	r0, r1
	ldr	r1, [sp, #24]
	str	r0, [r1]
	ldr	r0, [sp, #4]
	ldr	r1, [sp, #36]
	lsl.w	r0, r2, r0
	subs	r0, #1
	ands	r0, r1
	ldr	r1, [sp, #16]
	str	r0, [r1]
	add	sp, #40
	bx	lr
.Ltmp111:
	.size	NVIC_DecodePriority, .Ltmp111-NVIC_DecodePriority

	.align	2
	.type	NVIC_SetPendingIRQ,%function
	.code	16                      @ @NVIC_SetPendingIRQ
	.thumb_func
NVIC_SetPendingIRQ:
@ BB#0:                                 @ %entry
	str	r0, [sp, #-4]!
	and	r1, r0, #31
	movs	r2, #1
	lsrs	r0, r0, #5
	lsl.w	r1, r2, r1
	movw	r2, #57856
	movt	r2, #57344
	str.w	r1, [r2, r0, lsl #2]
	add	sp, #4
	bx	lr
.Ltmp112:
	.size	NVIC_SetPendingIRQ, .Ltmp112-NVIC_SetPendingIRQ

	.align	2
	.type	NVIC_GetPendingIRQ,%function
	.code	16                      @ @NVIC_GetPendingIRQ
	.thumb_func
NVIC_GetPendingIRQ:
@ BB#0:                                 @ %entry
	str	r0, [sp, #-4]!
	movw	r1, #57856
	lsrs	r0, r0, #5
	movs	r2, #1
	movt	r1, #57344
	ldr.w	r0, [r1, r0, lsl #2]
	ldr	r1, [sp]
	and	r1, r1, #31
	lsl.w	r1, r2, r1
	ands	r0, r1
	it	ne
	movne	r0, #1
	add	sp, #4
	bx	lr
.Ltmp113:
	.size	NVIC_GetPendingIRQ, .Ltmp113-NVIC_GetPendingIRQ

	.align	2
	.type	NVIC_ClearPendingIRQ,%function
	.code	16                      @ @NVIC_ClearPendingIRQ
	.thumb_func
NVIC_ClearPendingIRQ:
@ BB#0:                                 @ %entry
	str	r0, [sp, #-4]!
	and	r1, r0, #31
	movs	r2, #1
	lsrs	r0, r0, #5
	lsl.w	r1, r2, r1
	movw	r2, #57984
	movt	r2, #57344
	str.w	r1, [r2, r0, lsl #2]
	add	sp, #4
	bx	lr
.Ltmp114:
	.size	NVIC_ClearPendingIRQ, .Ltmp114-NVIC_ClearPendingIRQ

	.align	2
	.type	NVIC_GetActive,%function
	.code	16                      @ @NVIC_GetActive
	.thumb_func
NVIC_GetActive:
@ BB#0:                                 @ %entry
	str	r0, [sp, #-4]!
	movw	r1, #58112
	lsrs	r0, r0, #5
	movs	r2, #1
	movt	r1, #57344
	ldr.w	r0, [r1, r0, lsl #2]
	ldr	r1, [sp]
	and	r1, r1, #31
	lsl.w	r1, r2, r1
	ands	r0, r1
	it	ne
	movne	r0, #1
	add	sp, #4
	bx	lr
.Ltmp115:
	.size	NVIC_GetActive, .Ltmp115-NVIC_GetActive

	.section	.text.module.dma,"ax",%progbits
	.globl	HAL_DMA_Init
	.align	2
	.type	HAL_DMA_Init,%function
	.code	16                      @ @HAL_DMA_Init
	.thumb_func
HAL_DMA_Init:
@ BB#0:                                 @ %entry
	push.w	{r4, r5, r6, r7, r11, lr}
	add	r7, sp, #12
	sub	sp, #24
	movs	r4, #0
	str	r0, [sp, #16]
	str	r4, [sp, #12]
	bl	HAL_GetTick
	str	r0, [sp, #8]
	ldr	r0, [sp, #16]
	cmp	r0, #0
	beq	.LBB116_5
@ BB#1:                                 @ %do.end
	ldr	r0, [sp, #16]
	movs	r1, #2
	str	r4, [r0, #52]
	ldr	r0, [sp, #16]
	str	r1, [r0, #56]
	ldr	r0, [sp, #16]
	ldr	r0, [r0]
	ldr	r1, [r0]
	bic	r1, r1, #1
	str	r1, [r0]
.LBB116_2:                              @ %while.cond
                                        @ =>This Inner Loop Header: Depth=1
	ldr	r0, [sp, #16]
	ldr	r0, [r0]
	ldr	r0, [r0]
	tst.w	r0, #1
	beq	.LBB116_6
@ BB#3:                                 @ %while.body
                                        @   in Loop: Header=BB116_2 Depth=1
	bl	HAL_GetTick
	ldr	r1, [sp, #8]
	subs	r0, r0, r1
	cmp	r0, #6
	blo	.LBB116_2
@ BB#4:                                 @ %if.then12
	ldr	r0, [sp, #16]
	movs	r1, #32
	str	r1, [r0, #88]
	movs	r1, #3
	ldr	r0, [sp, #16]
	str	r1, [r0, #56]
	b	.LBB116_12
.LBB116_5:                              @ %if.then
	movs	r0, #1
	str	r0, [sp, #20]
	b	.LBB116_13
.LBB116_6:                              @ %while.end
	ldr	r0, [sp, #16]
	movw	r1, #32831
	movt	r1, #61456
	ldr	r0, [r0]
	ldr	r0, [r0]
	str	r0, [sp, #12]
	ands	r0, r1
	ldr	r1, [sp, #16]
	str	r0, [sp, #12]
	ldr.w	r12, [r1, #4]
	ldr	r3, [r1, #8]
	ldr	r4, [r1, #12]
	ldr	r2, [r1, #16]
	ldr.w	lr, [r1, #20]
	ldr	r5, [r1, #24]
	ldr	r6, [r1, #28]
	ldr	r1, [r1, #32]
	orr.w	r3, r3, r12
	orrs	r3, r4
	orrs	r2, r3
	orr.w	r2, r2, lr
	orrs	r2, r5
	orrs	r2, r6
	orrs	r1, r2
	orrs	r0, r1
	str	r0, [sp, #12]
	ldr	r0, [sp, #16]
	ldr	r0, [r0, #36]
	cmp	r0, #4
	bne	.LBB116_8
@ BB#7:                                 @ %if.then36
	ldr	r0, [sp, #16]
	ldr	r1, [r0, #44]
	ldr	r0, [r0, #48]
	orrs	r0, r1
	ldr	r1, [sp, #12]
	orrs	r0, r1
	str	r0, [sp, #12]
.LBB116_8:                              @ %if.end41
	ldr	r0, [sp, #16]
	ldr	r1, [sp, #12]
	ldr	r0, [r0]
	str	r1, [r0]
	ldr	r0, [sp, #16]
	ldr	r0, [r0]
	ldr	r0, [r0, #20]
	ldr	r1, [sp, #16]
	str	r0, [sp, #12]
	bic	r0, r0, #7
	str	r0, [sp, #12]
	ldr	r1, [r1, #36]
	orrs	r0, r1
	str	r0, [sp, #12]
	ldr	r0, [sp, #16]
	ldr	r0, [r0, #36]
	cmp	r0, #4
	bne	.LBB116_11
@ BB#9:                                 @ %if.then52
	ldr	r0, [sp, #16]
	ldr	r1, [sp, #12]
	ldr	r0, [r0, #40]
	orrs	r0, r1
	str	r0, [sp, #12]
	ldr	r0, [sp, #16]
	bl	DMA_CheckFifoParam
	cbz	r0, .LBB116_11
@ BB#10:                                @ %if.then57
	ldr	r0, [sp, #16]
	movs	r1, #64
	str	r1, [r0, #88]
	movs	r1, #1
	ldr	r0, [sp, #16]
	str	r1, [r0, #56]
	b	.LBB116_12
.LBB116_11:                             @ %if.end61
	ldr	r0, [sp, #16]
	ldr	r1, [sp, #12]
	ldr	r0, [r0]
	str	r1, [r0, #20]
	ldr	r0, [sp, #16]
	bl	DMA_CalcBaseAndBitshift
	ldr	r1, [sp, #16]
	str	r0, [sp]
	movs	r2, #63
	ldr	r1, [r1, #96]
	lsl.w	r1, r2, r1
	movs	r2, #1
	str	r1, [r0, #8]
	movs	r1, #0
	ldr	r0, [sp, #16]
	str	r1, [r0, #88]
	ldr	r0, [sp, #16]
	str	r2, [r0, #56]
.LBB116_12:                             @ %return
	str	r1, [sp, #20]
.LBB116_13:                             @ %return
	ldr	r0, [sp, #20]
	@APP
	boundcheckstart.HAL_DMA_Init.text.module.dma.ret:

	@NO_APP
	add	sp, #24
	pop.w	{r4, r5, r6, r7, r11, lr}
	push {r0}
 	movw r0, :lower16:gateway_ret_dma
 	movt r0, :upper16:gateway_ret_dma
 	bic lr,lr,#1
 	cmp lr, r0
 	beq end_of_check_HAL_DMA_Init0
 	movw r0, :lower16:.text.module.dma_start
 	movt r0, :upper16:.text.module.dma_start
 	cmp lr, r0
 	it cc
 	blcc exceptionFun
 	movw r0, :lower16:.text.module.dma_end
 	movt r0, :upper16:.text.module.dma_end
 	cmp lr, r0
 	it cs
 	blcs exceptionFun
end_of_check_HAL_DMA_Init0:
	pop {r0}
 	orr lr,lr,#1
	bx	lr
.Ltmp116:
	.size	HAL_DMA_Init, .Ltmp116-HAL_DMA_Init

	.globl	HAL_DMA_DeInit
	.align	2
	.type	HAL_DMA_DeInit,%function
	.code	16                      @ @HAL_DMA_DeInit
	.thumb_func
HAL_DMA_DeInit:
@ BB#0:                                 @ %entry
	push.w	{r4, r7, r11, lr}
	add	r7, sp, #4
	sub	sp, #16
	str	r0, [sp, #8]
	cmp	r0, #0
	beq	.LBB117_3
@ BB#1:                                 @ %if.end
	ldr	r0, [sp, #8]
	ldr	r0, [r0, #56]
	cmp	r0, #2
	bne	.LBB117_4
@ BB#2:                                 @ %if.then2
	movs	r0, #2
	str	r0, [sp, #12]
	b	.LBB117_5
.LBB117_3:                              @ %if.then
	movs	r0, #1
	str	r0, [sp, #12]
	b	.LBB117_5
.LBB117_4:                              @ %do.end
	ldr	r0, [sp, #8]
	movs	r4, #0
	ldr	r0, [r0]
	ldr	r1, [r0]
	bic	r1, r1, #1
	str	r1, [r0]
	movs	r1, #33
	ldr	r0, [sp, #8]
	ldr	r0, [r0]
	str	r4, [r0]
	ldr	r0, [sp, #8]
	ldr	r0, [r0]
	str	r4, [r0, #4]
	ldr	r0, [sp, #8]
	ldr	r0, [r0]
	str	r4, [r0, #8]
	ldr	r0, [sp, #8]
	ldr	r0, [r0]
	str	r4, [r0, #12]
	ldr	r0, [sp, #8]
	ldr	r0, [r0]
	str	r4, [r0, #16]
	ldr	r0, [sp, #8]
	ldr	r0, [r0]
	str	r1, [r0, #20]
	ldr	r0, [sp, #8]
	bl	DMA_CalcBaseAndBitshift
	ldr	r1, [sp, #8]
	str	r0, [sp]
	movs	r2, #63
	ldr	r1, [r1, #96]
	lsl.w	r1, r2, r1
	str	r1, [r0, #8]
	ldr	r0, [sp, #8]
	str	r4, [r0, #88]
	ldr	r0, [sp, #8]
	str	r4, [r0, #56]
	ldr	r0, [sp, #8]
	str	r4, [r0, #52]
	str	r4, [sp, #12]
.LBB117_5:                              @ %return
	ldr	r0, [sp, #12]
	@APP
	boundcheckstart.HAL_DMA_DeInit.text.module.dma.ret:

	@NO_APP
	add	sp, #16
	pop.w	{r4, r7, r11, lr}
	push {r0}
 	movw r0, :lower16:gateway_ret_dma
 	movt r0, :upper16:gateway_ret_dma
 	bic lr,lr,#1
 	cmp lr, r0
 	beq end_of_check_HAL_DMA_DeInit3
 	movw r0, :lower16:.text.module.dma_start
 	movt r0, :upper16:.text.module.dma_start
 	cmp lr, r0
 	it cc
 	blcc exceptionFun
 	movw r0, :lower16:.text.module.dma_end
 	movt r0, :upper16:.text.module.dma_end
 	cmp lr, r0
 	it cs
 	blcs exceptionFun
end_of_check_HAL_DMA_DeInit3:
	pop {r0}
 	orr lr,lr,#1
	bx	lr
.Ltmp117:
	.size	HAL_DMA_DeInit, .Ltmp117-HAL_DMA_DeInit

	.globl	HAL_DMA_Start
	.align	2
	.type	HAL_DMA_Start,%function
	.code	16                      @ @HAL_DMA_Start
	.thumb_func
HAL_DMA_Start:
@ BB#0:                                 @ %do.body
	push	{r7, lr}
	mov	r7, sp
	sub	sp, #24
	str	r0, [sp, #16]
	movs	r0, #0
	str	r1, [sp, #12]
	str	r2, [sp, #8]
	str	r3, [sp, #4]
	str	r0, [sp]
	ldr	r0, [sp, #16]
	ldr	r0, [r0, #52]
	cmp	r0, #1
	bne	.LBB118_2
@ BB#1:                                 @ %if.then
	movs	r0, #2
	b	.LBB118_6
.LBB118_2:                              @ %do.end
	ldr	r0, [sp, #16]
	movs	r1, #1
	str	r1, [r0, #52]
	ldr	r0, [sp, #16]
	ldr	r0, [r0, #56]
	cmp	r0, #1
	bne	.LBB118_4
@ BB#3:                                 @ %if.then3
	ldr	r0, [sp, #16]
	movs	r1, #2
	str	r1, [r0, #56]
	movs	r1, #0
	ldr	r0, [sp, #16]
	str	r1, [r0, #88]
	ldr	r3, [sp, #4]
	ldr	r2, [sp, #8]
	ldr	r1, [sp, #12]
	ldr	r0, [sp, #16]
	bl	DMA_SetConfig
	ldr	r0, [sp, #16]
	ldr	r0, [r0]
	ldr	r1, [r0]
	orr	r1, r1, #1
	str	r1, [r0]
	b	.LBB118_5
.LBB118_4:                              @ %do.end8
	ldr	r0, [sp, #16]
	movs	r1, #0
	str	r1, [r0, #52]
	movs	r0, #2
	str	r0, [sp]
.LBB118_5:                              @ %if.end9
	ldr	r0, [sp]
.LBB118_6:                              @ %return
	str	r0, [sp, #20]
	ldr	r0, [sp, #20]
	@APP
	boundcheckstart.HAL_DMA_Start.text.module.dma.ret:

	@NO_APP
	add	sp, #24
	pop	{r7, lr}
	push {r0}
 	movw r0, :lower16:gateway_ret_dma
 	movt r0, :upper16:gateway_ret_dma
 	bic lr,lr,#1
 	cmp lr, r0
 	beq end_of_check_HAL_DMA_Start4
 	movw r0, :lower16:.text.module.dma_start
 	movt r0, :upper16:.text.module.dma_start
 	cmp lr, r0
 	it cc
 	blcc exceptionFun
 	movw r0, :lower16:.text.module.dma_end
 	movt r0, :upper16:.text.module.dma_end
 	cmp lr, r0
 	it cs
 	blcs exceptionFun
end_of_check_HAL_DMA_Start4:
	pop {r0}
 	orr lr,lr,#1
	bx	lr
.Ltmp118:
	.size	HAL_DMA_Start, .Ltmp118-HAL_DMA_Start

	.globl	HAL_DMA_Start_IT
	.align	2
	.type	HAL_DMA_Start_IT,%function
	.code	16                      @ @HAL_DMA_Start_IT
	.thumb_func
HAL_DMA_Start_IT:
@ BB#0:                                 @ %do.body
	push	{r7, lr}
	mov	r7, sp
	sub	sp, #32
	str	r0, [sp, #24]
	movs	r0, #0
	str	r1, [sp, #20]
	str	r2, [sp, #16]
	str	r3, [sp, #12]
	str	r0, [sp, #8]
	ldr	r0, [sp, #24]
	ldr	r0, [r0, #92]
	str	r0, [sp]
	ldr	r0, [sp, #24]
	ldr	r0, [r0, #52]
	cmp	r0, #1
	bne	.LBB119_2
@ BB#1:                                 @ %if.then
	movs	r0, #2
	b	.LBB119_6
.LBB119_2:                              @ %do.end
	ldr	r0, [sp, #24]
	movs	r1, #1
	str	r1, [r0, #52]
	ldr	r0, [sp, #24]
	ldr	r0, [r0, #56]
	cmp	r0, #1
	bne	.LBB119_4
@ BB#3:                                 @ %if.then5
	ldr	r0, [sp, #24]
	movs	r1, #2
	str	r1, [r0, #56]
	movs	r1, #0
	ldr	r0, [sp, #24]
	str	r1, [r0, #88]
	ldr	r3, [sp, #12]
	ldr	r2, [sp, #16]
	ldr	r1, [sp, #20]
	ldr	r0, [sp, #24]
	bl	DMA_SetConfig
	ldr	r0, [sp, #24]
	movs	r1, #63
	ldr	r0, [r0, #96]
	lsl.w	r0, r1, r0
	ldr	r1, [sp]
	str	r0, [r1, #8]
	ldr	r0, [sp, #24]
	ldr	r0, [r0]
	ldr	r1, [r0]
	orr	r1, r1, #22
	str	r1, [r0]
	ldr	r0, [sp, #24]
	ldr	r0, [r0]
	ldr	r1, [r0, #20]
	orr	r1, r1, #128
	str	r1, [r0, #20]
	ldr	r0, [sp, #24]
	ldr	r0, [r0, #68]
	cmp	r0, #0
	itttt	ne
	ldrne	r0, [sp, #24]
	ldrne	r0, [r0]
	ldrne	r1, [r0]
	orrne	r1, r1, #8
	it	ne
	strne	r1, [r0]
	ldr	r0, [sp, #24]
	ldr	r0, [r0]
	ldr	r1, [r0]
	orr	r1, r1, #1
	str	r1, [r0]
	b	.LBB119_5
.LBB119_4:                              @ %do.end22
	ldr	r0, [sp, #24]
	movs	r1, #0
	str	r1, [r0, #52]
	movs	r0, #2
	str	r0, [sp, #8]
.LBB119_5:                              @ %if.end23
	ldr	r0, [sp, #8]
.LBB119_6:                              @ %return
	str	r0, [sp, #28]
	ldr	r0, [sp, #28]
	@APP
	boundcheckstart.HAL_DMA_Start_IT.text.module.dma.ret:

	@NO_APP
	add	sp, #32
	pop	{r7, lr}
	push {r0}
 	movw r0, :lower16:gateway_ret_dma
 	movt r0, :upper16:gateway_ret_dma
 	bic lr,lr,#1
 	cmp lr, r0
 	beq end_of_check_HAL_DMA_Start_IT6
 	movw r0, :lower16:.text.module.dma_start
 	movt r0, :upper16:.text.module.dma_start
 	cmp lr, r0
 	it cc
 	blcc exceptionFun
 	movw r0, :lower16:.text.module.dma_end
 	movt r0, :upper16:.text.module.dma_end
 	cmp lr, r0
 	it cs
 	blcs exceptionFun
end_of_check_HAL_DMA_Start_IT6:
	pop {r0}
 	orr lr,lr,#1
	bx	lr
.Ltmp119:
	.size	HAL_DMA_Start_IT, .Ltmp119-HAL_DMA_Start_IT

	.globl	HAL_DMA_Abort
	.align	2
	.type	HAL_DMA_Abort,%function
	.code	16                      @ @HAL_DMA_Abort
	.thumb_func
HAL_DMA_Abort:
@ BB#0:                                 @ %entry
	push	{r7, lr}
	mov	r7, sp
	sub	sp, #24
	str	r0, [sp, #16]
	ldr	r0, [r0, #92]
	str	r0, [sp, #8]
	bl	HAL_GetTick
	str	r0, [sp, #4]
	ldr	r0, [sp, #16]
	ldr	r0, [r0, #56]
	cmp	r0, #2
	beq	.LBB120_2
@ BB#1:                                 @ %do.end
	ldr	r0, [sp, #16]
	movs	r1, #128
	str	r1, [r0, #88]
	movs	r1, #0
	ldr	r0, [sp, #16]
	str	r1, [r0, #52]
	movs	r0, #1
	str	r0, [sp, #20]
	b	.LBB120_11
.LBB120_2:                              @ %if.else
	ldr	r0, [sp, #16]
	ldr	r0, [r0]
	ldr	r1, [r0]
	bic	r1, r1, #22
	str	r1, [r0]
	ldr	r0, [sp, #16]
	ldr	r0, [r0]
	ldr	r1, [r0, #20]
	bic	r1, r1, #128
	str	r1, [r0, #20]
	ldr	r0, [sp, #16]
	ldr	r0, [r0, #68]
	cbnz	r0, .LBB120_4
@ BB#3:                                 @ %lor.lhs.false
	ldr	r0, [sp, #16]
	ldr	r0, [r0, #76]
	cbz	r0, .LBB120_5
.LBB120_4:                              @ %if.then8
	ldr	r0, [sp, #16]
	ldr	r0, [r0]
	ldr	r1, [r0]
	bic	r1, r1, #8
	str	r1, [r0]
.LBB120_5:                              @ %if.end
	ldr	r0, [sp, #16]
	ldr	r0, [r0]
	ldr	r1, [r0]
	bic	r1, r1, #1
	str	r1, [r0]
.LBB120_6:                              @ %while.cond
                                        @ =>This Inner Loop Header: Depth=1
	ldr	r0, [sp, #16]
	ldr	r0, [r0]
	ldr	r0, [r0]
	tst.w	r0, #1
	beq	.LBB120_9
@ BB#7:                                 @ %while.body
                                        @   in Loop: Header=BB120_6 Depth=1
	bl	HAL_GetTick
	ldr	r1, [sp, #4]
	subs	r0, r0, r1
	cmp	r0, #6
	blo	.LBB120_6
@ BB#8:                                 @ %do.end27
	ldr	r0, [sp, #16]
	movs	r1, #32
	str	r1, [r0, #88]
	movs	r1, #0
	ldr	r0, [sp, #16]
	str	r1, [r0, #52]
	movs	r1, #3
	ldr	r0, [sp, #16]
	str	r1, [r0, #56]
	b	.LBB120_10
.LBB120_9:                              @ %if.end34
	ldr	r0, [sp, #16]
	movs	r1, #63
	movs	r2, #1
	ldr	r0, [r0, #96]
	lsl.w	r0, r1, r0
	ldr	r1, [sp, #8]
	str	r0, [r1, #8]
	movs	r1, #0
	ldr	r0, [sp, #16]
	str	r1, [r0, #52]
	ldr	r0, [sp, #16]
	str	r2, [r0, #56]
.LBB120_10:                             @ %return
	str	r1, [sp, #20]
.LBB120_11:                             @ %return
	ldr	r0, [sp, #20]
	@APP
	boundcheckstart.HAL_DMA_Abort.text.module.dma.ret:

	@NO_APP
	add	sp, #24
	pop	{r7, lr}
	push {r0}
 	movw r0, :lower16:gateway_ret_dma
 	movt r0, :upper16:gateway_ret_dma
 	bic lr,lr,#1
 	cmp lr, r0
 	beq end_of_check_HAL_DMA_Abort7
 	movw r0, :lower16:.text.module.dma_start
 	movt r0, :upper16:.text.module.dma_start
 	cmp lr, r0
 	it cc
 	blcc exceptionFun
 	movw r0, :lower16:.text.module.dma_end
 	movt r0, :upper16:.text.module.dma_end
 	cmp lr, r0
 	it cs
 	blcs exceptionFun
end_of_check_HAL_DMA_Abort7:
	pop {r0}
 	orr lr,lr,#1
	bx	lr
.Ltmp120:
	.size	HAL_DMA_Abort, .Ltmp120-HAL_DMA_Abort

	.globl	HAL_DMA_Abort_IT
	.align	2
	.type	HAL_DMA_Abort_IT,%function
	.code	16                      @ @HAL_DMA_Abort_IT
	.thumb_func
HAL_DMA_Abort_IT:
@ BB#0:                                 @ %entry
	sub	sp, #8
	str	r0, [sp]
	ldr	r0, [r0, #56]
	cmp	r0, #2
	beq	.LBB121_2
@ BB#1:                                 @ %if.then
	ldr	r0, [sp]
	movs	r1, #128
	str	r1, [r0, #88]
	movs	r0, #1
	b	.LBB121_3
.LBB121_2:                              @ %if.end
	ldr	r0, [sp]
	movs	r1, #5
	str	r1, [r0, #56]
	ldr	r0, [sp]
	ldr	r0, [r0]
	ldr	r1, [r0]
	bic	r1, r1, #1
	str	r1, [r0]
	movs	r0, #0
.LBB121_3:                              @ %return
	str	r0, [sp, #4]
	ldr	r0, [sp, #4]
	@APP
	boundcheckstart.HAL_DMA_Abort_IT.text.module.dma.ret:

	@NO_APP
	add	sp, #8
	push {r0}
 	movw r0, :lower16:gateway_ret_dma
 	movt r0, :upper16:gateway_ret_dma
 	bic lr,lr,#1
 	cmp lr, r0
 	beq end_of_check_HAL_DMA_Abort_IT8
 	movw r0, :lower16:.text.module.dma_start
 	movt r0, :upper16:.text.module.dma_start
 	cmp lr, r0
 	it cc
 	blcc exceptionFun
 	movw r0, :lower16:.text.module.dma_end
 	movt r0, :upper16:.text.module.dma_end
 	cmp lr, r0
 	it cs
 	blcs exceptionFun
end_of_check_HAL_DMA_Abort_IT8:
	pop {r0}
 	orr lr,lr,#1
	bx	lr
.Ltmp121:
	.size	HAL_DMA_Abort_IT, .Ltmp121-HAL_DMA_Abort_IT

	.globl	HAL_DMA_PollForTransfer
	.align	2
	.type	HAL_DMA_PollForTransfer,%function
	.code	16                      @ @HAL_DMA_PollForTransfer
	.thumb_func
HAL_DMA_PollForTransfer:
@ BB#0:                                 @ %entry
	push.w	{r4, r5, r6, r7, r11, lr}
	add	r7, sp, #12
	sub	sp, #40
	movs	r4, #0
	str	r0, [sp, #32]
	str	r1, [sp, #28]
	str	r2, [sp, #24]
	str	r4, [sp, #20]
	bl	HAL_GetTick
	str	r0, [sp, #12]
	ldr	r0, [sp, #32]
	ldr	r0, [r0, #56]
	cmp	r0, #2
	beq	.LBB122_2
@ BB#1:                                 @ %do.end
	ldr	r0, [sp, #32]
	movs	r1, #128
	str	r1, [r0, #88]
	ldr	r0, [sp, #32]
	str	r4, [r0, #52]
	movs	r0, #1
	b	.LBB122_29
.LBB122_2:                              @ %if.end
	ldr	r0, [sp, #32]
	ldr	r0, [r0]
	ldr	r0, [r0]
	tst.w	r0, #256
	beq	.LBB122_4
@ BB#3:                                 @ %if.then2
	ldr	r0, [sp, #32]
	mov.w	r1, #256
	str	r1, [r0, #88]
	movs	r0, #1
	b	.LBB122_29
.LBB122_4:                              @ %if.end4
	ldr	r0, [sp, #28]
	cmp	r0, #0
	beq	.LBB122_6
@ BB#5:                                 @ %if.else
	ldr	r0, [sp, #32]
	movs	r1, #16
	ldr	r0, [r0, #96]
	b	.LBB122_7
.LBB122_6:                              @ %if.then6
	ldr	r0, [sp, #32]
	movs	r1, #32
	ldr	r0, [r0, #96]
.LBB122_7:                              @ %if.end9
	lsl.w	r0, r1, r0
	movs	r5, #1
	movs	r6, #4
	movs	r4, #8
	str	r0, [sp, #16]
	ldr	r0, [sp, #32]
	movt	r5, #128
	movt	r6, #128
	ldr	r0, [r0, #92]
	str	r0, [sp]
	ldr	r0, [r0]
	str	r0, [sp, #8]
	b	.LBB122_9
.LBB122_8:                              @ %if.then61
                                        @   in Loop: Header=BB122_9 Depth=1
	ldr	r0, [sp, #32]
	ldr	r1, [r0, #88]
	orr	r1, r1, #4
	str	r1, [r0, #88]
	ldr	r0, [sp, #32]
	ldr	r1, [sp]
	ldr	r0, [r0, #96]
	lsl.w	r0, r6, r0
	str	r0, [r1, #8]
.LBB122_9:                              @ %while.cond
                                        @ =>This Inner Loop Header: Depth=1
	ldr	r0, [sp, #16]
	ldr	r1, [sp, #8]
	tst	r1, r0
	bne	.LBB122_11
@ BB#10:                                @ %land.rhs
                                        @   in Loop: Header=BB122_9 Depth=1
	ldr	r0, [sp, #32]
	ldr	r0, [r0, #88]
	tst.w	r0, #1
	mov.w	r0, #0
	it	eq
	moveq	r0, #1
	b	.LBB122_12
.LBB122_11:                             @   in Loop: Header=BB122_9 Depth=1
	movs	r0, #0
.LBB122_12:                             @ %land.end
                                        @   in Loop: Header=BB122_9 Depth=1
	cmp	r0, #1
	bne	.LBB122_21
@ BB#13:                                @ %while.body
                                        @   in Loop: Header=BB122_9 Depth=1
	ldr	r0, [sp, #24]
	cmp.w	r0, #-1
	beq	.LBB122_16
@ BB#14:                                @ %if.then19
                                        @   in Loop: Header=BB122_9 Depth=1
	ldr	r0, [sp, #24]
	cmp	r0, #0
	beq	.LBB122_24
@ BB#15:                                @ %lor.lhs.false
                                        @   in Loop: Header=BB122_9 Depth=1
	bl	HAL_GetTick
	ldr	r1, [sp, #12]
	subs	r0, r0, r1
	ldr	r1, [sp, #24]
	cmp	r0, r1
	bhi	.LBB122_24
.LBB122_16:                             @ %if.end32
                                        @   in Loop: Header=BB122_9 Depth=1
	ldr	r0, [sp]
	ldr	r0, [r0]
	ldr	r1, [sp, #32]
	str	r0, [sp, #8]
	ldr	r1, [r1, #96]
	lsl.w	r1, r4, r1
	tst	r0, r1
	beq	.LBB122_18
@ BB#17:                                @ %if.then39
                                        @   in Loop: Header=BB122_9 Depth=1
	ldr	r0, [sp, #32]
	ldr	r1, [r0, #88]
	orr	r1, r1, #1
	str	r1, [r0, #88]
	ldr	r0, [sp, #32]
	ldr	r1, [sp]
	ldr	r0, [r0, #96]
	lsl.w	r0, r4, r0
	str	r0, [r1, #8]
.LBB122_18:                             @ %if.end43
                                        @   in Loop: Header=BB122_9 Depth=1
	ldr	r0, [sp, #32]
	ldr	r1, [sp, #8]
	ldr	r0, [r0, #96]
	lsl.w	r0, r5, r0
	tst	r1, r0
	beq	.LBB122_20
@ BB#19:                                @ %if.then49
                                        @   in Loop: Header=BB122_9 Depth=1
	ldr	r0, [sp, #32]
	ldr	r1, [r0, #88]
	orr	r1, r1, #2
	str	r1, [r0, #88]
	ldr	r0, [sp, #32]
	ldr	r1, [sp]
	ldr	r0, [r0, #96]
	lsl.w	r0, r5, r0
	str	r0, [r1, #8]
.LBB122_20:                             @ %if.end55
                                        @   in Loop: Header=BB122_9 Depth=1
	ldr	r0, [sp, #32]
	ldr	r1, [sp, #8]
	ldr	r0, [r0, #96]
	lsl.w	r0, r6, r0
	tst	r1, r0
	beq	.LBB122_9
	b	.LBB122_8
.LBB122_21:                             @ %while.end
	ldr	r0, [sp, #32]
	ldr	r0, [r0, #88]
	cbz	r0, .LBB122_25
@ BB#22:                                @ %if.then71
	ldr	r0, [sp, #32]
	ldr	r0, [r0, #88]
	tst.w	r0, #1
	beq	.LBB122_25
@ BB#23:                                @ %do.end83
	ldr	r0, [sp, #32]
	bl	HAL_DMA_Abort
	ldr	r0, [sp, #32]
	movs	r1, #48
	ldr	r0, [r0, #96]
	lsl.w	r0, r1, r0
	ldr	r1, [sp]
	str	r0, [r1, #8]
	movs	r1, #0
	ldr	r0, [sp, #32]
	str	r1, [r0, #52]
	movs	r1, #1
	ldr	r0, [sp, #32]
	str	r1, [r0, #56]
	str	r1, [sp, #36]
	b	.LBB122_30
.LBB122_24:                             @ %do.end29
	ldr	r0, [sp, #32]
	movs	r1, #32
	str	r1, [r0, #88]
	movs	r1, #0
	ldr	r0, [sp, #32]
	str	r1, [r0, #52]
	movs	r1, #1
	ldr	r0, [sp, #32]
	str	r1, [r0, #56]
	movs	r0, #3
	b	.LBB122_29
.LBB122_25:                             @ %if.end86
	ldr	r0, [sp, #28]
	cmp	r0, #0
	beq	.LBB122_27
@ BB#26:                                @ %if.else97
	ldr	r0, [sp, #32]
	movs	r1, #16
	ldr	r0, [r0, #96]
	lsl.w	r0, r1, r0
	ldr	r1, [sp]
	str	r0, [r1, #8]
	b	.LBB122_28
.LBB122_27:                             @ %do.end95
	ldr	r0, [sp, #32]
	movs	r1, #48
	ldr	r0, [r0, #96]
	lsl.w	r0, r1, r0
	ldr	r1, [sp]
	str	r0, [r1, #8]
	movs	r1, #0
	ldr	r0, [sp, #32]
	str	r1, [r0, #52]
	movs	r1, #1
	ldr	r0, [sp, #32]
	str	r1, [r0, #56]
.LBB122_28:                             @ %if.end101
	ldr	r0, [sp, #20]
.LBB122_29:                             @ %return
	str	r0, [sp, #36]
.LBB122_30:                             @ %return
	ldr	r0, [sp, #36]
	@APP
	boundcheckstart.HAL_DMA_PollForTransfer.text.module.dma.ret:

	@NO_APP
	add	sp, #40
	pop.w	{r4, r5, r6, r7, r11, lr}
	push {r0}
 	movw r0, :lower16:gateway_ret_dma
 	movt r0, :upper16:gateway_ret_dma
 	bic lr,lr,#1
 	cmp lr, r0
 	beq end_of_check_HAL_DMA_PollForTransfer9
 	movw r0, :lower16:.text.module.dma_start
 	movt r0, :upper16:.text.module.dma_start
 	cmp lr, r0
 	it cc
 	blcc exceptionFun
 	movw r0, :lower16:.text.module.dma_end
 	movt r0, :upper16:.text.module.dma_end
 	cmp lr, r0
 	it cs
 	blcs exceptionFun
end_of_check_HAL_DMA_PollForTransfer9:
	pop {r0}
 	orr lr,lr,#1
	bx	lr
.Ltmp122:
	.size	HAL_DMA_PollForTransfer, .Ltmp122-HAL_DMA_PollForTransfer

	.globl	HAL_DMA_IRQHandler
	.align	2
	.type	HAL_DMA_IRQHandler,%function
	.code	16                      @ @HAL_DMA_IRQHandler
	.thumb_func
HAL_DMA_IRQHandler:
@ BB#0:                                 @ %entry
	push	{r7, lr}
	mov	r7, sp
	sub	sp, #24
	str	r0, [sp, #16]
	movs	r0, #0
	movw	r1, #33205
	movs	r2, #8
	str	r0, [sp, #8]
	movw	r0, :lower16:SystemCoreClock
	movt	r1, #6990
	movt	r0, :upper16:SystemCoreClock
	ldr	r0, [r0]
	umull	r0, r1, r0, r1
	lsrs	r0, r1, #10
	str	r0, [sp, #4]
	ldr	r0, [sp, #16]
	ldr	r0, [r0, #92]
	str	r0, [sp]
	ldr	r0, [r0]
	ldr	r1, [sp, #16]
	str	r0, [sp, #12]
	ldr	r1, [r1, #96]
	lsl.w	r1, r2, r1
	tst	r0, r1
	beq	.LBB123_3
@ BB#1:                                 @ %if.then
	ldr	r0, [sp, #16]
	ldr	r0, [r0]
	ldr	r0, [r0]
	tst.w	r0, #4
	beq	.LBB123_3
@ BB#2:                                 @ %if.then5
	ldr	r0, [sp, #16]
	ldr	r0, [r0]
	ldr	r1, [r0]
	bic	r1, r1, #4
	str	r1, [r0]
	movs	r1, #8
	ldr	r0, [sp, #16]
	ldr	r0, [r0, #96]
	lsl.w	r0, r1, r0
	ldr	r1, [sp]
	str	r0, [r1, #8]
	ldr	r0, [sp, #16]
	ldr	r1, [r0, #88]
	orr	r1, r1, #1
	str	r1, [r0, #88]
.LBB123_3:                              @ %if.end11
	ldr	r0, [sp, #16]
	ldr	r2, [sp, #12]
	ldr	r1, [r0, #96]
	movs	r0, #1
	movt	r0, #128
	lsl.w	r1, r0, r1
	tst	r2, r1
	beq	.LBB123_6
@ BB#4:                                 @ %if.then17
	ldr	r1, [sp, #16]
	ldr	r1, [r1]
	ldr	r1, [r1, #20]
	tst.w	r1, #128
	beq	.LBB123_6
@ BB#5:                                 @ %if.then22
	ldr	r1, [sp, #16]
	ldr	r1, [r1, #96]
	lsls	r0, r1
	ldr	r1, [sp]
	str	r0, [r1, #8]
	ldr	r0, [sp, #16]
	ldr	r1, [r0, #88]
	orr	r1, r1, #2
	str	r1, [r0, #88]
.LBB123_6:                              @ %if.end29
	ldr	r0, [sp, #16]
	ldr	r2, [sp, #12]
	ldr	r1, [r0, #96]
	movs	r0, #4
	movt	r0, #128
	lsl.w	r1, r0, r1
	tst	r2, r1
	beq	.LBB123_9
@ BB#7:                                 @ %if.then35
	ldr	r1, [sp, #16]
	ldr	r1, [r1]
	ldr	r1, [r1]
	tst.w	r1, #2
	beq	.LBB123_9
@ BB#8:                                 @ %if.then41
	ldr	r1, [sp, #16]
	ldr	r1, [r1, #96]
	lsls	r0, r1
	ldr	r1, [sp]
	str	r0, [r1, #8]
	ldr	r0, [sp, #16]
	ldr	r1, [r0, #88]
	orr	r1, r1, #4
	str	r1, [r0, #88]
.LBB123_9:                              @ %if.end48
	ldr	r0, [sp, #16]
	movs	r1, #16
	ldr	r0, [r0, #96]
	lsl.w	r0, r1, r0
	ldr	r1, [sp, #12]
	tst	r1, r0
	beq.w	.LBB123_22
@ BB#10:                                @ %if.then54
	ldr	r0, [sp, #16]
	ldr	r0, [r0]
	ldr	r0, [r0]
	tst.w	r0, #8
	beq.w	.LBB123_22
@ BB#11:                                @ %if.then60
	ldr	r0, [sp, #16]
	movs	r1, #16
	ldr	r0, [r0, #96]
	lsl.w	r0, r1, r0
	ldr	r1, [sp]
	str	r0, [r1, #8]
	ldr	r0, [sp, #16]
	ldr	r0, [r0]
	ldr	r0, [r0]
	tst.w	r0, #262144
	beq	.LBB123_15
@ BB#12:                                @ %if.then69
	ldr	r0, [sp, #16]
	ldr	r0, [r0]
	ldr	r0, [r0]
	tst.w	r0, #524288
	beq	.LBB123_19
@ BB#13:                                @ %if.else
	ldr	r0, [sp, #16]
	ldr	r0, [r0, #76]
	cmp	r0, #0
	beq.w	.LBB123_22
@ BB#14:                                @ %if.then83
	ldr	r0, [sp, #16]
	ldr	r1, [r0, #76]
	@APP
	boundcheckstart.HAL_DMA_IRQHandler.text.module.dma.indirect_1:
	push {lr}
 	mov lr, r0
	push {r0}
 	movw r0, #9999
 	movt r0, #8888
 	cmp lr, r0
 	it cc
	blcc exceptionFun
 	movw r0, #7777
 	movt r0, #6666
 	cmp lr, r0
 	it cs
 	blcs exceptionFun
 	pop {r0}
	pop {lr}
boundcheckend.HAL_DMA_IRQHandler.text.module.dma.indirect_2:

	@NO_APP
	b	.LBB123_21
.LBB123_15:                             @ %if.else87
	ldr	r0, [sp, #16]
	ldr	r0, [r0]
	ldr	r0, [r0]
	tst.w	r0, #256
	bne	.LBB123_17
@ BB#16:                                @ %if.then93
	ldr	r0, [sp, #16]
	ldr	r0, [r0]
	ldr	r1, [r0]
	bic	r1, r1, #8
	str	r1, [r0]
.LBB123_17:                             @ %if.end97
	ldr	r0, [sp, #16]
	ldr	r0, [r0, #68]
	cmp	r0, #0
	beq	.LBB123_22
@ BB#18:                                @ %if.then101
	ldr	r0, [sp, #16]
	ldr	r1, [r0, #68]
	@APP
	boundcheckstart.HAL_DMA_IRQHandler.text.module.dma.indirect_2:
	push {lr}
 	mov lr, r0
	push {r0}
 	movw r0, #9999
 	movt r0, #8888
 	cmp lr, r0
 	it cc
	blcc exceptionFun
 	movw r0, #7777
 	movt r0, #6666
 	cmp lr, r0
 	it cs
 	blcs exceptionFun
 	pop {r0}
	pop {lr}
boundcheckend.HAL_DMA_IRQHandler.text.module.dma.indirect_3:

	@NO_APP
	b	.LBB123_21
.LBB123_19:                             @ %if.then75
	ldr	r0, [sp, #16]
	ldr	r0, [r0, #68]
	cbz	r0, .LBB123_22
@ BB#20:                                @ %if.then78
	ldr	r0, [sp, #16]
	ldr	r1, [r0, #68]
	@APP
	boundcheckstart.HAL_DMA_IRQHandler.text.module.dma.indirect_0:

	@NO_APP
.LBB123_21:                             @ %if.end106
	push {lr}
 	mov lr, r0
	push {r0}
 	movw r0, :lower16:.text.module.dma_start
 	movt r0, :upper16:.text.module.dma_start
 	cmp lr, r0
 	it cc
	blcc exceptionFun
 	movw r0, :lower16:.text.module.dma_end
 	movt r0, :upper16:.text.module.dma_end
 	cmp lr, r0
 	it cs
 	blcs exceptionFun
 	pop {r0}
	pop {lr}
	blx	r1
.LBB123_22:                             @ %if.end106
	ldr	r0, [sp, #16]
	movs	r1, #32
	ldr	r0, [r0, #96]
	lsl.w	r0, r1, r0
	ldr	r1, [sp, #12]
	tst	r1, r0
	beq.w	.LBB123_41
@ BB#23:                                @ %if.then112
	ldr	r0, [sp, #16]
	ldr	r0, [r0]
	ldr	r0, [r0]
	tst.w	r0, #16
	beq.w	.LBB123_41
@ BB#24:                                @ %if.then118
	ldr	r0, [sp, #16]
	movs	r1, #32
	ldr	r0, [r0, #96]
	lsl.w	r0, r1, r0
	ldr	r1, [sp]
	str	r0, [r1, #8]
	ldr	r0, [sp, #16]
	ldr	r0, [r0, #56]
	cmp	r0, #5
	bne	.LBB123_30
@ BB#25:                                @ %if.then124
	ldr	r0, [sp, #16]
	ldr	r0, [r0]
	ldr	r1, [r0]
	bic	r1, r1, #22
	str	r1, [r0]
	ldr	r0, [sp, #16]
	ldr	r0, [r0]
	ldr	r1, [r0, #20]
	bic	r1, r1, #128
	str	r1, [r0, #20]
	ldr	r0, [sp, #16]
	ldr	r0, [r0, #68]
	cbnz	r0, .LBB123_27
@ BB#26:                                @ %lor.lhs.false
	ldr	r0, [sp, #16]
	ldr	r0, [r0, #76]
	cbz	r0, .LBB123_28
.LBB123_27:                             @ %if.then137
	ldr	r0, [sp, #16]
	ldr	r0, [r0]
	ldr	r1, [r0]
	bic	r1, r1, #8
	str	r1, [r0]
.LBB123_28:                             @ %do.end
	ldr	r0, [sp, #16]
	movs	r1, #63
	ldr	r0, [r0, #96]
	lsl.w	r0, r1, r0
	ldr	r1, [sp]
	str	r0, [r1, #8]
	movs	r1, #0
	ldr	r0, [sp, #16]
	str	r1, [r0, #52]
	movs	r1, #1
	ldr	r0, [sp, #16]
	str	r1, [r0, #56]
	ldr	r0, [sp, #16]
	ldr	r0, [r0, #84]
	cmp	r0, #0
	beq.w	.LBB123_50
@ BB#29:                                @ %if.then148
	ldr	r0, [sp, #16]
	ldr	r1, [r0, #84]
	@APP
	boundcheckstart.HAL_DMA_IRQHandler.text.module.dma.indirect_3:
	push {lr}
 	mov lr, r0
	push {r0}
 	movw r0, #9999
 	movt r0, #8888
 	cmp lr, r0
 	it cc
	blcc exceptionFun
 	movw r0, #7777
 	movt r0, #6666
 	cmp lr, r0
 	it cs
 	blcs exceptionFun
 	pop {r0}
	pop {lr}
boundcheckend.HAL_DMA_IRQHandler.text.module.dma.indirect_4:

	@NO_APP
	b	.LBB123_49
.LBB123_30:                             @ %if.end151
	ldr	r0, [sp, #16]
	ldr	r0, [r0]
	ldr	r0, [r0]
	tst.w	r0, #262144
	beq	.LBB123_34
@ BB#31:                                @ %if.then157
	ldr	r0, [sp, #16]
	ldr	r0, [r0]
	ldr	r0, [r0]
	tst.w	r0, #524288
	beq	.LBB123_38
@ BB#32:                                @ %if.else169
	ldr	r0, [sp, #16]
	ldr	r0, [r0, #64]
	cmp	r0, #0
	beq.w	.LBB123_41
@ BB#33:                                @ %if.then172
	ldr	r0, [sp, #16]
	ldr	r1, [r0, #64]
	@APP
	boundcheckstart.HAL_DMA_IRQHandler.text.module.dma.indirect_5:
	push {lr}
 	mov lr, r0
	push {r0}
 	movw r0, #9999
 	movt r0, #8888
 	cmp lr, r0
 	it cc
	blcc exceptionFun
 	movw r0, #7777
 	movt r0, #6666
 	cmp lr, r0
 	it cs
 	blcs exceptionFun
 	pop {r0}
	pop {lr}
boundcheckend.HAL_DMA_IRQHandler.text.module.dma.indirect_6:

	@NO_APP
	b	.LBB123_40
.LBB123_34:                             @ %if.else176
	ldr	r0, [sp, #16]
	ldr	r0, [r0]
	ldr	r0, [r0]
	tst.w	r0, #256
	bne	.LBB123_36
@ BB#35:                                @ %do.end188
	ldr	r0, [sp, #16]
	ldr	r0, [r0]
	ldr	r1, [r0]
	bic	r1, r1, #16
	str	r1, [r0]
	movs	r1, #0
	ldr	r0, [sp, #16]
	str	r1, [r0, #52]
	movs	r1, #1
	ldr	r0, [sp, #16]
	str	r1, [r0, #56]
.LBB123_36:                             @ %if.end190
	ldr	r0, [sp, #16]
	ldr	r0, [r0, #64]
	cmp	r0, #0
	beq	.LBB123_41
@ BB#37:                                @ %if.then194
	ldr	r0, [sp, #16]
	ldr	r1, [r0, #64]
	@APP
	boundcheckstart.HAL_DMA_IRQHandler.text.module.dma.indirect_6:
	push {lr}
 	mov lr, r0
	push {r0}
 	movw r0, #9999
 	movt r0, #8888
 	cmp lr, r0
 	it cc
	blcc exceptionFun
 	movw r0, #7777
 	movt r0, #6666
 	cmp lr, r0
 	it cs
 	blcs exceptionFun
 	pop {r0}
	pop {lr}
boundcheckend.HAL_DMA_IRQHandler.text.module.dma.indirect_7:

	@NO_APP
	b	.LBB123_40
.LBB123_38:                             @ %if.then163
	ldr	r0, [sp, #16]
	ldr	r0, [r0, #72]
	cbz	r0, .LBB123_41
@ BB#39:                                @ %if.then166
	ldr	r0, [sp, #16]
	ldr	r1, [r0, #72]
	@APP
	boundcheckstart.HAL_DMA_IRQHandler.text.module.dma.indirect_4:

	@NO_APP
.LBB123_40:                             @ %if.end199
	push {lr}
 	mov lr, r0
	push {r0}
 	movw r0, :lower16:.text.module.dma_start
 	movt r0, :upper16:.text.module.dma_start
 	cmp lr, r0
 	it cc
	blcc exceptionFun
 	movw r0, :lower16:.text.module.dma_end
 	movt r0, :upper16:.text.module.dma_end
 	cmp lr, r0
 	it cs
 	blcs exceptionFun
 	pop {r0}
	pop {lr}
	blx	r1
.LBB123_41:                             @ %if.end199
	ldr	r0, [sp, #16]
	ldr	r0, [r0, #88]
	cmp	r0, #0
	beq	.LBB123_50
@ BB#42:                                @ %if.then203
	ldr	r0, [sp, #16]
	ldr	r0, [r0, #88]
	tst.w	r0, #1
	beq	.LBB123_47
@ BB#43:                                @ %if.then208
	ldr	r0, [sp, #16]
	movs	r1, #5
	str	r1, [r0, #56]
	ldr	r0, [sp, #16]
	ldr	r0, [r0]
	ldr	r1, [r0]
	bic	r1, r1, #1
	str	r1, [r0]
.LBB123_44:                             @ %do.body213
                                        @ =>This Inner Loop Header: Depth=1
	ldr	r0, [sp, #8]
	adds	r0, #1
	str	r0, [sp, #8]
	ldr	r1, [sp, #4]
	cmp	r0, r1
	bhi	.LBB123_46
@ BB#45:                                @ %do.cond
                                        @   in Loop: Header=BB123_44 Depth=1
	ldr	r0, [sp, #16]
	ldr	r0, [r0]
	ldr	r0, [r0]
	tst.w	r0, #1
	bne	.LBB123_44
.LBB123_46:                             @ %do.end227
	ldr	r0, [sp, #16]
	movs	r1, #0
	str	r1, [r0, #52]
	movs	r1, #1
	ldr	r0, [sp, #16]
	str	r1, [r0, #56]
.LBB123_47:                             @ %if.end229
	ldr	r0, [sp, #16]
	ldr	r0, [r0, #80]
	cbz	r0, .LBB123_50
@ BB#48:                                @ %if.then232
	ldr	r0, [sp, #16]
	ldr	r1, [r0, #80]
	@APP
	boundcheckstart.HAL_DMA_IRQHandler.text.module.dma.indirect_7:

	@NO_APP
.LBB123_49:                             @ %if.end235
	push {lr}
 	mov lr, r0
	push {r0}
 	movw r0, :lower16:.text.module.dma_start
 	movt r0, :upper16:.text.module.dma_start
 	cmp lr, r0
 	it cc
	blcc exceptionFun
 	movw r0, :lower16:.text.module.dma_end
 	movt r0, :upper16:.text.module.dma_end
 	cmp lr, r0
 	it cs
 	blcs exceptionFun
 	pop {r0}
	pop {lr}
	blx	r1
.LBB123_50:                             @ %if.end235
	@APP
	boundcheckstart.HAL_DMA_IRQHandler.text.module.dma.ret:

	@NO_APP
	add	sp, #24
	pop	{r7, lr}
	push {r0}
 	movw r0, :lower16:gateway_ret_dma
 	movt r0, :upper16:gateway_ret_dma
 	bic lr,lr,#1
 	cmp lr, r0
 	beq end_of_check_HAL_DMA_IRQHandler10
 	movw r0, :lower16:.text.module.dma_start
 	movt r0, :upper16:.text.module.dma_start
 	cmp lr, r0
 	it cc
 	blcc exceptionFun
 	movw r0, :lower16:.text.module.dma_end
 	movt r0, :upper16:.text.module.dma_end
 	cmp lr, r0
 	it cs
 	blcs exceptionFun
end_of_check_HAL_DMA_IRQHandler10:
	pop {r0}
 	orr lr,lr,#1
	bx	lr
.Ltmp123:
	.size	HAL_DMA_IRQHandler, .Ltmp123-HAL_DMA_IRQHandler

	.globl	HAL_DMA_RegisterCallback
	.align	2
	.type	HAL_DMA_RegisterCallback,%function
	.code	16                      @ @HAL_DMA_RegisterCallback
	.thumb_func
HAL_DMA_RegisterCallback:
@ BB#0:                                 @ %do.body
	sub	sp, #24
	str	r0, [sp, #16]
	movs	r0, #0
	str	r1, [sp, #12]
	str	r2, [sp, #8]
	str	r0, [sp, #4]
	ldr	r0, [sp, #16]
	ldr	r0, [r0, #52]
	cmp	r0, #1
	bne	.LBB124_2
@ BB#1:                                 @ %if.then
	movs	r0, #2
	b	.LBB124_8
.LBB124_2:                              @ %do.end
	ldr	r1, [sp, #16]
	movs	r0, #1
	str	r0, [r1, #52]
	ldr	r1, [sp, #16]
	ldr	r1, [r1, #56]
	cmp	r1, #1
	bne	.LBB124_6
@ BB#3:                                 @ %if.then3
	ldr	r0, [sp, #12]
	cmp	r0, #5
	bhi	.LBB124_7
@ BB#4:                                 @ %if.then3
	tbb	[pc, r0]
.LJTI124_0_0:
	.byte	(.LBB124_5-.LJTI124_0_0)/2
	.byte	(.LBB124_9-.LJTI124_0_0)/2
	.byte	(.LBB124_10-.LJTI124_0_0)/2
	.byte	(.LBB124_11-.LJTI124_0_0)/2
	.byte	(.LBB124_12-.LJTI124_0_0)/2
	.byte	(.LBB124_13-.LJTI124_0_0)/2
	.align	1
.LBB124_5:                              @ %sw.bb
	ldr	r0, [sp, #16]
	ldr	r1, [sp, #8]
	str	r1, [r0, #64]
	b	.LBB124_7
.LBB124_6:                              @ %if.else9
	str	r0, [sp, #4]
.LBB124_7:                              @ %do.end13
	ldr	r0, [sp, #16]
	movs	r1, #0
	str	r1, [r0, #52]
	ldr	r0, [sp, #4]
.LBB124_8:                              @ %return
	str	r0, [sp, #20]
	ldr	r0, [sp, #20]
	@APP
	boundcheckstart.HAL_DMA_RegisterCallback.text.module.dma.ret:

	@NO_APP
	add	sp, #24
	push {r0}
 	movw r0, :lower16:gateway_ret_dma
 	movt r0, :upper16:gateway_ret_dma
 	bic lr,lr,#1
 	cmp lr, r0
 	beq end_of_check_HAL_DMA_RegisterCallback11
 	movw r0, :lower16:.text.module.dma_start
 	movt r0, :upper16:.text.module.dma_start
 	cmp lr, r0
 	it cc
 	blcc exceptionFun
 	movw r0, :lower16:.text.module.dma_end
 	movt r0, :upper16:.text.module.dma_end
 	cmp lr, r0
 	it cs
 	blcs exceptionFun
end_of_check_HAL_DMA_RegisterCallback11:
	pop {r0}
 	orr lr,lr,#1
	bx	lr
.LBB124_9:                              @ %sw.bb4
	ldr	r0, [sp, #16]
	ldr	r1, [sp, #8]
	str	r1, [r0, #68]
	b	.LBB124_7
.LBB124_10:                             @ %sw.bb5
	ldr	r0, [sp, #16]
	ldr	r1, [sp, #8]
	str	r1, [r0, #72]
	b	.LBB124_7
.LBB124_11:                             @ %sw.bb6
	ldr	r0, [sp, #16]
	ldr	r1, [sp, #8]
	str	r1, [r0, #76]
	b	.LBB124_7
.LBB124_12:                             @ %sw.bb7
	ldr	r0, [sp, #16]
	ldr	r1, [sp, #8]
	str	r1, [r0, #80]
	b	.LBB124_7
.LBB124_13:                             @ %sw.bb8
	ldr	r0, [sp, #16]
	ldr	r1, [sp, #8]
	str	r1, [r0, #84]
	b	.LBB124_7
.Ltmp124:
	.size	HAL_DMA_RegisterCallback, .Ltmp124-HAL_DMA_RegisterCallback

	.globl	HAL_DMA_UnRegisterCallback
	.align	2
	.type	HAL_DMA_UnRegisterCallback,%function
	.code	16                      @ @HAL_DMA_UnRegisterCallback
	.thumb_func
HAL_DMA_UnRegisterCallback:
@ BB#0:                                 @ %do.body
	sub	sp, #16
	str	r0, [sp, #8]
	movs	r0, #0
	str	r1, [sp, #4]
	str	r0, [sp]
	ldr	r0, [sp, #8]
	ldr	r0, [r0, #52]
	cmp	r0, #1
	bne	.LBB125_2
@ BB#1:                                 @ %if.then
	movs	r0, #2
	b	.LBB125_7
.LBB125_2:                              @ %do.end
	ldr	r1, [sp, #8]
	movs	r0, #1
	str	r0, [r1, #52]
	ldr	r1, [sp, #8]
	ldr	r1, [r1, #56]
	cmp	r1, #1
	bne	.LBB125_5
@ BB#3:                                 @ %if.then3
	ldr	r0, [sp, #4]
	cmp	r0, #6
	bls	.LBB125_8
@ BB#4:                                 @ %sw.default
	movs	r0, #1
.LBB125_5:                              @ %if.else16
	str	r0, [sp]
.LBB125_6:                              @ %do.end20
	ldr	r0, [sp, #8]
	movs	r1, #0
	str	r1, [r0, #52]
	ldr	r0, [sp]
.LBB125_7:                              @ %return
	str	r0, [sp, #12]
	ldr	r0, [sp, #12]
	@APP
	boundcheckstart.HAL_DMA_UnRegisterCallback.text.module.dma.ret:

	@NO_APP
	add	sp, #16
	push {r0}
 	movw r0, :lower16:gateway_ret_dma
 	movt r0, :upper16:gateway_ret_dma
 	bic lr,lr,#1
 	cmp lr, r0
 	beq end_of_check_HAL_DMA_UnRegisterCallback12
 	movw r0, :lower16:.text.module.dma_start
 	movt r0, :upper16:.text.module.dma_start
 	cmp lr, r0
 	it cc
 	blcc exceptionFun
 	movw r0, :lower16:.text.module.dma_end
 	movt r0, :upper16:.text.module.dma_end
 	cmp lr, r0
 	it cs
 	blcs exceptionFun
end_of_check_HAL_DMA_UnRegisterCallback12:
	pop {r0}
 	orr lr,lr,#1
	bx	lr
.LBB125_8:                              @ %if.then3
	tbb	[pc, r0]
.LJTI125_0_0:
	.byte	(.LBB125_9-.LJTI125_0_0)/2
	.byte	(.LBB125_10-.LJTI125_0_0)/2
	.byte	(.LBB125_11-.LJTI125_0_0)/2
	.byte	(.LBB125_12-.LJTI125_0_0)/2
	.byte	(.LBB125_13-.LJTI125_0_0)/2
	.byte	(.LBB125_14-.LJTI125_0_0)/2
	.byte	(.LBB125_15-.LJTI125_0_0)/2
	.align	1
.LBB125_9:                              @ %sw.bb
	ldr	r0, [sp, #8]
	movs	r1, #0
	str	r1, [r0, #64]
	b	.LBB125_6
.LBB125_10:                             @ %sw.bb4
	ldr	r0, [sp, #8]
	movs	r1, #0
	str	r1, [r0, #68]
	b	.LBB125_6
.LBB125_11:                             @ %sw.bb5
	ldr	r0, [sp, #8]
	movs	r1, #0
	str	r1, [r0, #72]
	b	.LBB125_6
.LBB125_12:                             @ %sw.bb6
	ldr	r0, [sp, #8]
	movs	r1, #0
	str	r1, [r0, #76]
	b	.LBB125_6
.LBB125_13:                             @ %sw.bb7
	ldr	r0, [sp, #8]
	movs	r1, #0
	str	r1, [r0, #80]
	b	.LBB125_6
.LBB125_14:                             @ %sw.bb8
	ldr	r0, [sp, #8]
	movs	r1, #0
	str	r1, [r0, #84]
	b	.LBB125_6
.LBB125_15:                             @ %sw.bb9
	ldr	r0, [sp, #8]
	movs	r1, #0
	str	r1, [r0, #64]
	ldr	r0, [sp, #8]
	str	r1, [r0, #68]
	ldr	r0, [sp, #8]
	str	r1, [r0, #72]
	ldr	r0, [sp, #8]
	str	r1, [r0, #76]
	ldr	r0, [sp, #8]
	str	r1, [r0, #80]
	ldr	r0, [sp, #8]
	str	r1, [r0, #84]
	b	.LBB125_6
.Ltmp125:
	.size	HAL_DMA_UnRegisterCallback, .Ltmp125-HAL_DMA_UnRegisterCallback

	.globl	HAL_DMA_GetState
	.align	2
	.type	HAL_DMA_GetState,%function
	.code	16                      @ @HAL_DMA_GetState
	.thumb_func
HAL_DMA_GetState:
@ BB#0:                                 @ %entry
	sub	sp, #8
	str	r0, [sp]
	ldr	r0, [r0, #56]
	@APP
	boundcheckstart.HAL_DMA_GetState.text.module.dma.ret:

	@NO_APP
	add	sp, #8
	push {r0}
 	movw r0, :lower16:gateway_ret_dma
 	movt r0, :upper16:gateway_ret_dma
 	bic lr,lr,#1
 	cmp lr, r0
 	beq end_of_check_HAL_DMA_GetState13
 	movw r0, :lower16:.text.module.dma_start
 	movt r0, :upper16:.text.module.dma_start
 	cmp lr, r0
 	it cc
 	blcc exceptionFun
 	movw r0, :lower16:.text.module.dma_end
 	movt r0, :upper16:.text.module.dma_end
 	cmp lr, r0
 	it cs
 	blcs exceptionFun
end_of_check_HAL_DMA_GetState13:
	pop {r0}
 	orr lr,lr,#1
	bx	lr
.Ltmp126:
	.size	HAL_DMA_GetState, .Ltmp126-HAL_DMA_GetState

	.globl	HAL_DMA_GetError
	.align	2
	.type	HAL_DMA_GetError,%function
	.code	16                      @ @HAL_DMA_GetError
	.thumb_func
HAL_DMA_GetError:
@ BB#0:                                 @ %entry
	sub	sp, #8
	str	r0, [sp]
	ldr	r0, [r0, #88]
	@APP
	boundcheckstart.HAL_DMA_GetError.text.module.dma.ret:

	@NO_APP
	add	sp, #8
	push {r0}
 	movw r0, :lower16:gateway_ret_dma
 	movt r0, :upper16:gateway_ret_dma
 	bic lr,lr,#1
 	cmp lr, r0
 	beq end_of_check_HAL_DMA_GetError14
 	movw r0, :lower16:.text.module.dma_start
 	movt r0, :upper16:.text.module.dma_start
 	cmp lr, r0
 	it cc
 	blcc exceptionFun
 	movw r0, :lower16:.text.module.dma_end
 	movt r0, :upper16:.text.module.dma_end
 	cmp lr, r0
 	it cs
 	blcs exceptionFun
end_of_check_HAL_DMA_GetError14:
	pop {r0}
 	orr lr,lr,#1
	bx	lr
.Ltmp127:
	.size	HAL_DMA_GetError, .Ltmp127-HAL_DMA_GetError

	.section	.text.usfi,"ax",%progbits
	.globl	gateway_dma
	.align	2
	.type	gateway_dma,%function
	.code	16                      @ @gateway_dma
	.thumb_func
gateway_dma:
@ BB#0:                                 @ %entry
	@APP
		push {lr}
	svc #11 
boundcheckstart.gateway.text.module.dma.ret:
	push {r0}
 	movw r0, :lower16:.text.module.dma_start
 	movt r0, :upper16:.text.module.dma_start
 	cmp r4,r0
 	it cc
	blcc exceptionFun
 	movw r0, :lower16:.text.module.dma_end
 	movt r0, :upper16:.text.module.dma_end
 	cmp r4,r0
 	it cs
 	blcs exceptionFun
 	pop {r0}
	 blx r4
.global gateway_ret_dma
gateway_ret_dma:
	svc #255 
	pop {lr}

	@NO_APP
	bx	lr
.Ltmp128:
	.size	gateway_dma, .Ltmp128-gateway_dma

	.section	.text.module.dma,"ax",%progbits
	.align	2
	.type	DMA_CheckFifoParam,%function
	.code	16                      @ @DMA_CheckFifoParam
	.thumb_func
DMA_CheckFifoParam:
@ BB#0:                                 @ %entry
	sub	sp, #16
	str	r0, [sp, #8]
	movs	r0, #0
	str	r0, [sp, #4]
	ldr	r0, [sp, #8]
	ldr	r0, [r0, #40]
	str	r0, [sp]
	ldr	r0, [sp, #8]
	ldr	r0, [r0, #24]
	cmp	r0, #0
	beq	.LBB129_4
@ BB#1:                                 @ %if.else
	ldr	r0, [sp, #8]
	ldr	r0, [r0, #24]
	cmp.w	r0, #8192
	bne	.LBB129_7
@ BB#2:                                 @ %if.then22
	ldr	r0, [sp]
	cmp	r0, #3
	bhi	.LBB129_12
@ BB#3:                                 @ %if.then22
	tbb	[pc, r0]
.LJTI129_0_0:
	.byte	(.LBB129_11-.LJTI129_0_0)/2
	.byte	(.LBB129_10-.LJTI129_0_0)/2
	.byte	(.LBB129_11-.LJTI129_0_0)/2
	.byte	(.LBB129_6-.LJTI129_0_0)/2
	.align	1
.LBB129_4:                              @ %if.then
	ldr	r0, [sp]
	cmp	r0, #2
	beq	.LBB129_10
@ BB#5:                                 @ %if.then
	cmp	r0, #1
	bne	.LBB129_9
.LBB129_6:                              @ %sw.bb5
	ldr	r0, [sp, #8]
	ldr	r0, [r0, #44]
	cmp.w	r0, #25165824
	beq	.LBB129_11
	b	.LBB129_12
.LBB129_7:                              @ %if.else40
	ldr	r0, [sp]
	cmp	r0, #3
	beq	.LBB129_10
@ BB#8:                                 @ %if.else40
	cmp	r0, #2
	bls	.LBB129_11
	b	.LBB129_12
.LBB129_9:                              @ %if.then
	cbnz	r0, .LBB129_12
.LBB129_10:                             @ %sw.bb42
	ldr	r0, [sp, #8]
	ldr	r0, [r0, #44]
	tst.w	r0, #16777216
	beq	.LBB129_12
.LBB129_11:                             @ %if.then47
	movs	r0, #1
	str	r0, [sp, #4]
.LBB129_12:                             @ %if.end52
	ldr	r0, [sp, #4]
	@APP
	boundcheckstart.DMA_CheckFifoParam.text.module.dma.ret:

	@NO_APP
	add	sp, #16
	push {r0}
 	movw r0, :lower16:gateway_ret_dma
 	movt r0, :upper16:gateway_ret_dma
 	bic lr,lr,#1
 	cmp lr, r0
 	beq end_of_check_DMA_CheckFifoParam1
 	movw r0, :lower16:.text.module.dma_start
 	movt r0, :upper16:.text.module.dma_start
 	cmp lr, r0
 	it cc
 	blcc exceptionFun
 	movw r0, :lower16:.text.module.dma_end
 	movt r0, :upper16:.text.module.dma_end
 	cmp lr, r0
 	it cs
 	blcs exceptionFun
end_of_check_DMA_CheckFifoParam1:
	pop {r0}
 	orr lr,lr,#1
	bx	lr
.Ltmp129:
	.size	DMA_CheckFifoParam, .Ltmp129-DMA_CheckFifoParam

	.align	2
	.type	DMA_CalcBaseAndBitshift,%function
	.code	16                      @ @DMA_CalcBaseAndBitshift
	.thumb_func
DMA_CalcBaseAndBitshift:
@ BB#0:                                 @ %entry
	sub	sp, #16
	str	r0, [sp, #8]
	movw	r1, #43691
	ldrb	r0, [r0]
	movt	r1, #43690
	subs	r0, #16
	umull	r0, r1, r0, r1
	lsrs	r0, r1, #4
	movw	r1, :lower16:DMA_CalcBaseAndBitshift.flagBitshiftOffset
	movt	r1, :upper16:DMA_CalcBaseAndBitshift.flagBitshiftOffset
	str	r0, [sp, #4]
	ldrb	r0, [r1, r0]
	ldr	r1, [sp, #8]
	str	r0, [r1, #96]
	ldr	r0, [sp, #4]
	cmp	r0, #4
	blo	.LBB130_2
@ BB#1:                                 @ %if.then
	ldr	r0, [sp, #8]
	movs	r2, #4
	ldr	r1, [r0]
	bfi	r1, r2, #0, #10
	b	.LBB130_3
.LBB130_2:                              @ %if.else
	ldr	r0, [sp, #8]
	ldr	r1, [r0]
	bfc	r1, #0, #10
.LBB130_3:                              @ %if.end
	str	r1, [r0, #92]
	ldr	r0, [sp, #8]
	ldr	r0, [r0, #92]
	@APP
	boundcheckstart.DMA_CalcBaseAndBitshift.text.module.dma.ret:

	@NO_APP
	add	sp, #16
	push {r0}
 	movw r0, :lower16:gateway_ret_dma
 	movt r0, :upper16:gateway_ret_dma
 	bic lr,lr,#1
 	cmp lr, r0
 	beq end_of_check_DMA_CalcBaseAndBitshift2
 	movw r0, :lower16:.text.module.dma_start
 	movt r0, :upper16:.text.module.dma_start
 	cmp lr, r0
 	it cc
 	blcc exceptionFun
 	movw r0, :lower16:.text.module.dma_end
 	movt r0, :upper16:.text.module.dma_end
 	cmp lr, r0
 	it cs
 	blcs exceptionFun
end_of_check_DMA_CalcBaseAndBitshift2:
	pop {r0}
 	orr lr,lr,#1
	bx	lr
.Ltmp130:
	.size	DMA_CalcBaseAndBitshift, .Ltmp130-DMA_CalcBaseAndBitshift

	.align	2
	.type	DMA_SetConfig,%function
	.code	16                      @ @DMA_SetConfig
	.thumb_func
DMA_SetConfig:
@ BB#0:                                 @ %entry
	sub	sp, #24
	str	r0, [sp, #16]
	str	r1, [sp, #12]
	str	r2, [sp, #8]
	str	r3, [sp, #4]
	ldr	r0, [sp, #16]
	ldr	r0, [r0]
	ldr	r1, [r0]
	bic	r1, r1, #262144
	str	r1, [r0]
	ldr	r0, [sp, #16]
	ldr	r1, [sp, #4]
	ldr	r0, [r0]
	str	r1, [r0, #4]
	ldr	r0, [sp, #16]
	ldr	r0, [r0, #8]
	cmp	r0, #64
	bne	.LBB131_2
@ BB#1:                                 @ %if.then
	ldr	r0, [sp, #16]
	ldr	r1, [sp, #8]
	ldr	r0, [r0]
	str	r1, [r0, #8]
	ldr	r0, [sp, #16]
	ldr	r1, [sp, #12]
	ldr	r0, [r0]
	b	.LBB131_3
.LBB131_2:                              @ %if.else
	ldr	r0, [sp, #16]
	ldr	r1, [sp, #12]
	ldr	r0, [r0]
	str	r1, [r0, #8]
	ldr	r0, [sp, #16]
	ldr	r1, [sp, #8]
	ldr	r0, [r0]
.LBB131_3:                              @ %if.end
	str	r1, [r0, #12]
	@APP
	boundcheckstart.DMA_SetConfig.text.module.dma.ret:

	@NO_APP
	add	sp, #24
	push {r0}
 	movw r0, :lower16:gateway_ret_dma
 	movt r0, :upper16:gateway_ret_dma
 	bic lr,lr,#1
 	cmp lr, r0
 	beq end_of_check_DMA_SetConfig5
 	movw r0, :lower16:.text.module.dma_start
 	movt r0, :upper16:.text.module.dma_start
 	cmp lr, r0
 	it cc
 	blcc exceptionFun
 	movw r0, :lower16:.text.module.dma_end
 	movt r0, :upper16:.text.module.dma_end
 	cmp lr, r0
 	it cs
 	blcs exceptionFun
end_of_check_DMA_SetConfig5:
	pop {r0}
 	orr lr,lr,#1
	bx	lr
.Ltmp131:
	.size	DMA_SetConfig, .Ltmp131-DMA_SetConfig

	.section	.text.module.gpio,"ax",%progbits
	.globl	HAL_GPIO_Init
	.align	2
	.type	HAL_GPIO_Init,%function
	.code	16                      @ @HAL_GPIO_Init
	.thumb_func
HAL_GPIO_Init:
@ BB#0:                                 @ %entry
	push.w	{r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub	sp, #36
	movw	r2, #14404
	movw	lr, #14344
	movw	r10, #15360
	movw	r9, #15364
	movw	r8, #15368
	movw	r4, #15372
	str	r0, [sp, #32]
	movs	r0, #0
	str	r1, [sp, #24]
	movw	r1, #65532
	mov.w	r12, #15
	movs	r3, #3
	str	r0, [sp, #16]
	str	r0, [sp, #12]
	str	r0, [sp, #8]
	str	r0, [sp, #20]
	movs	r0, #1
	movt	r1, #32767
	movt	r2, #16386
	movt	lr, #16385
	movt	r10, #16385
	movt	r9, #16385
	movt	r8, #16385
	movt	r4, #16385
	b	.LBB132_2
.LBB132_1:                              @ %for.inc
                                        @   in Loop: Header=BB132_2 Depth=1
	ldr	r5, [sp, #20]
	adds	r5, #1
	str	r5, [sp, #20]
.LBB132_2:                              @ %for.cond
                                        @ =>This Inner Loop Header: Depth=1
	ldr	r5, [sp, #20]
	cmp	r5, #15
	bhi.w	.LBB132_26
@ BB#3:                                 @ %for.body
                                        @   in Loop: Header=BB132_2 Depth=1
	ldr	r5, [sp, #20]
	ldr	r6, [sp, #24]
	lsl.w	r5, r0, r5
	str	r5, [sp, #16]
	ldr	r6, [r6]
	ands	r5, r6
	ldr	r6, [sp, #16]
	str	r5, [sp, #12]
	cmp	r5, r6
	bne	.LBB132_1
@ BB#4:                                 @ %if.then
                                        @   in Loop: Header=BB132_2 Depth=1
	ldr	r5, [sp, #24]
	ldr	r5, [r5, #4]
	cmp	r5, #2
	beq	.LBB132_6
@ BB#5:                                 @ %lor.lhs.false
                                        @   in Loop: Header=BB132_2 Depth=1
	ldr	r5, [sp, #24]
	ldr	r5, [r5, #4]
	cmp	r5, #18
	bne	.LBB132_7
.LBB132_6:                              @ %if.then5
                                        @   in Loop: Header=BB132_2 Depth=1
	ldr	r5, [sp, #20]
	ldr	r6, [sp, #32]
	and.w	r5, r1, r5, lsr #1
	add	r5, r6
	ldr	r5, [r5, #32]
	ldr	r6, [sp, #20]
	ldr	r7, [sp, #20]
	and	r6, r6, #7
	str	r5, [sp, #8]
	and	r7, r7, #7
	lsls	r6, r6, #2
	lsls	r7, r7, #2
	lsl.w	r6, r12, r6
	bics	r5, r6
	ldr	r6, [sp, #24]
	str	r5, [sp, #8]
	ldr	r6, [r6, #16]
	lsls	r6, r7
	ldr	r7, [sp, #32]
	orrs	r5, r6
	ldr	r6, [sp, #20]
	str	r5, [sp, #8]
	and.w	r6, r1, r6, lsr #1
	add	r6, r7
	str	r5, [r6, #32]
.LBB132_7:                              @ %if.end
                                        @   in Loop: Header=BB132_2 Depth=1
	ldr	r5, [sp, #32]
	ldr	r5, [r5]
	ldr	r6, [sp, #20]
	ldr	r7, [sp, #24]
	lsls	r6, r6, #1
	str	r5, [sp, #8]
	lsl.w	r6, r3, r6
	bics	r5, r6
	ldr	r6, [sp, #20]
	str	r5, [sp, #8]
	ldr	r7, [r7, #4]
	lsls	r6, r6, #1
	and	r7, r7, #3
	lsl.w	r6, r7, r6
	orrs	r5, r6
	ldr	r6, [sp, #32]
	str	r5, [sp, #8]
	str	r5, [r6]
	ldr	r5, [sp, #24]
	ldr	r5, [r5, #4]
	cmp	r5, #1
	beq	.LBB132_11
@ BB#8:                                 @ %lor.lhs.false28
                                        @   in Loop: Header=BB132_2 Depth=1
	ldr	r5, [sp, #24]
	ldr	r5, [r5, #4]
	cmp	r5, #2
	beq	.LBB132_11
@ BB#9:                                 @ %lor.lhs.false31
                                        @   in Loop: Header=BB132_2 Depth=1
	ldr	r5, [sp, #24]
	ldr	r5, [r5, #4]
	cmp	r5, #17
	beq	.LBB132_11
@ BB#10:                                @ %lor.lhs.false34
                                        @   in Loop: Header=BB132_2 Depth=1
	ldr	r5, [sp, #24]
	ldr	r5, [r5, #4]
	cmp	r5, #18
	bne	.LBB132_12
.LBB132_11:                             @ %if.then37
                                        @   in Loop: Header=BB132_2 Depth=1
	ldr	r5, [sp, #32]
	ldr	r5, [r5, #8]
	ldr	r6, [sp, #20]
	ldr	r7, [sp, #20]
	lsls	r6, r6, #1
	str	r5, [sp, #8]
	lsls	r7, r7, #1
	lsl.w	r6, r3, r6
	bics	r5, r6
	ldr	r6, [sp, #24]
	str	r5, [sp, #8]
	ldr	r6, [r6, #12]
	lsls	r6, r7
	orrs	r5, r6
	ldr	r6, [sp, #32]
	str	r5, [sp, #8]
	str	r5, [r6, #8]
	ldr	r5, [sp, #32]
	ldr	r5, [r5, #4]
	ldr	r6, [sp, #20]
	ldr	r7, [sp, #20]
	lsl.w	r6, r0, r6
	str	r5, [sp, #8]
	bics	r5, r6
	ldr	r6, [sp, #24]
	str	r5, [sp, #8]
	ldr	r6, [r6, #4]
	and	r6, r6, #16
	lsrs	r6, r6, #4
	lsls	r6, r7
	orrs	r5, r6
	ldr	r6, [sp, #32]
	str	r5, [sp, #8]
	str	r5, [r6, #4]
.LBB132_12:                             @ %if.end55
                                        @   in Loop: Header=BB132_2 Depth=1
	ldr	r5, [sp, #32]
	ldr	r5, [r5, #12]
	ldr	r6, [sp, #20]
	ldr	r7, [sp, #20]
	lsls	r6, r6, #1
	str	r5, [sp, #8]
	lsls	r7, r7, #1
	lsl.w	r6, r3, r6
	bics	r5, r6
	ldr	r6, [sp, #24]
	str	r5, [sp, #8]
	ldr	r6, [r6, #8]
	lsls	r6, r7
	orrs	r5, r6
	ldr	r6, [sp, #32]
	str	r5, [sp, #8]
	str	r5, [r6, #12]
	ldr	r5, [sp, #24]
	ldr	r5, [r5, #4]
	tst.w	r5, #268435456
	beq.w	.LBB132_1
@ BB#13:                                @ %do.end
                                        @   in Loop: Header=BB132_2 Depth=1
	mov.w	r11, #0
	str.w	r11, [sp, #4]
	ldr	r5, [r2]
	orr	r5, r5, #16384
	str	r5, [r2]
	ldr	r5, [r2]
	and	r5, r5, #16384
	str	r5, [sp, #4]
	ldr	r5, [sp, #4]
	ldr	r5, [sp, #20]
	bic	r5, r5, #3
	ldr.w	r5, [r5, lr]
	ldr	r6, [sp, #20]
	and	r6, r6, #3
	str	r5, [sp, #8]
	lsls	r6, r6, #2
	lsl.w	r6, r12, r6
	bics	r5, r6
	movs	r6, #0
	str	r5, [sp, #8]
	ldr	r5, [sp, #32]
	movt	r6, #16386
	cmp	r5, r6
	beq	.LBB132_25
@ BB#14:                                @ %cond.false
                                        @   in Loop: Header=BB132_2 Depth=1
	ldr	r5, [sp, #32]
	movw	r6, #1024
	movt	r6, #16386
	cmp	r5, r6
	bne	.LBB132_16
@ BB#15:                                @   in Loop: Header=BB132_2 Depth=1
	mov.w	r11, #1
	b	.LBB132_25
.LBB132_16:                             @ %cond.false81
                                        @   in Loop: Header=BB132_2 Depth=1
	ldr	r5, [sp, #32]
	movw	r6, #2048
	movt	r6, #16386
	cmp	r5, r6
	bne	.LBB132_18
@ BB#17:                                @   in Loop: Header=BB132_2 Depth=1
	mov.w	r11, #2
	b	.LBB132_25
.LBB132_18:                             @ %cond.false84
                                        @   in Loop: Header=BB132_2 Depth=1
	ldr	r5, [sp, #32]
	movw	r6, #3072
	movt	r6, #16386
	cmp	r5, r6
	bne	.LBB132_20
@ BB#19:                                @   in Loop: Header=BB132_2 Depth=1
	mov.w	r11, #3
	b	.LBB132_25
.LBB132_20:                             @ %cond.false87
                                        @   in Loop: Header=BB132_2 Depth=1
	ldr	r5, [sp, #32]
	movw	r6, #4096
	movt	r6, #16386
	cmp	r5, r6
	bne	.LBB132_22
@ BB#21:                                @   in Loop: Header=BB132_2 Depth=1
	mov.w	r11, #4
	b	.LBB132_25
.LBB132_22:                             @ %cond.false90
                                        @   in Loop: Header=BB132_2 Depth=1
	ldr	r5, [sp, #32]
	movw	r6, #5120
	movt	r6, #16386
	cmp	r5, r6
	bne	.LBB132_24
@ BB#23:                                @   in Loop: Header=BB132_2 Depth=1
	mov.w	r11, #5
	b	.LBB132_25
.LBB132_24:                             @ %cond.false93
                                        @   in Loop: Header=BB132_2 Depth=1
	ldr	r5, [sp, #32]
	movw	r6, #6144
	mov.w	r11, #7
	movt	r6, #16386
	cmp	r5, r6
	it	eq
	moveq.w	r11, #6
.LBB132_25:                             @ %cond.end104
                                        @   in Loop: Header=BB132_2 Depth=1
	ldr	r6, [sp, #20]
	uxtb.w	r5, r11
	and	r6, r6, #3
	lsls	r6, r6, #2
	lsls	r5, r6
	ldr	r6, [sp, #8]
	orrs	r5, r6
	ldr	r6, [sp, #20]
	str	r5, [sp, #8]
	bic	r6, r6, #3
	str.w	r5, [r6, lr]
	ldr.w	r5, [r10]
	ldr	r6, [sp, #12]
	str	r5, [sp, #8]
	bics	r5, r6
	str	r5, [sp, #8]
	ldr	r5, [sp, #24]
	ldr	r5, [r5, #4]
	tst.w	r5, #65536
	itttt	ne
	ldrne	r5, [sp, #12]
	ldrne	r6, [sp, #8]
	orrne	r5, r6
	strne	r5, [sp, #8]
	ldr	r5, [sp, #8]
	str.w	r5, [r10]
	ldr.w	r5, [r9]
	ldr	r6, [sp, #12]
	str	r5, [sp, #8]
	bics	r5, r6
	str	r5, [sp, #8]
	ldr	r5, [sp, #24]
	ldr	r5, [r5, #4]
	tst.w	r5, #131072
	itttt	ne
	ldrne	r5, [sp, #12]
	ldrne	r6, [sp, #8]
	orrne	r5, r6
	strne	r5, [sp, #8]
	ldr	r5, [sp, #8]
	str.w	r5, [r9]
	ldr.w	r5, [r8]
	ldr	r6, [sp, #12]
	str	r5, [sp, #8]
	bics	r5, r6
	str	r5, [sp, #8]
	ldr	r5, [sp, #24]
	ldr	r5, [r5, #4]
	tst.w	r5, #1048576
	itttt	ne
	ldrne	r5, [sp, #12]
	ldrne	r6, [sp, #8]
	orrne	r5, r6
	strne	r5, [sp, #8]
	ldr	r5, [sp, #8]
	str.w	r5, [r8]
	ldr	r5, [r4]
	ldr	r6, [sp, #12]
	str	r5, [sp, #8]
	bics	r5, r6
	str	r5, [sp, #8]
	ldr	r5, [sp, #24]
	ldr	r5, [r5, #4]
	tst.w	r5, #2097152
	itttt	ne
	ldrne	r5, [sp, #12]
	ldrne	r6, [sp, #8]
	orrne	r5, r6
	strne	r5, [sp, #8]
	ldr	r5, [sp, #8]
	str	r5, [r4]
	b	.LBB132_1
.LBB132_26:                             @ %for.end
	@APP
	boundcheckstart.HAL_GPIO_Init.text.module.gpio.ret:

	@NO_APP
	add	sp, #36
	pop.w	{r4, r5, r6, r7, r8, r9, r10, r11, lr}
	push {r0}
 	movw r0, :lower16:gateway_ret_gpio
 	movt r0, :upper16:gateway_ret_gpio
 	bic lr,lr,#1
 	cmp lr, r0
 	beq end_of_check_HAL_GPIO_Init0
 	movw r0, :lower16:.text.module.gpio_start
 	movt r0, :upper16:.text.module.gpio_start
 	cmp lr, r0
 	it cc
 	blcc exceptionFun
 	movw r0, :lower16:.text.module.gpio_end
 	movt r0, :upper16:.text.module.gpio_end
 	cmp lr, r0
 	it cs
 	blcs exceptionFun
end_of_check_HAL_GPIO_Init0:
	pop {r0}
 	orr lr,lr,#1
	bx	lr
.Ltmp132:
	.size	HAL_GPIO_Init, .Ltmp132-HAL_GPIO_Init

	.globl	HAL_GPIO_DeInit
	.align	2
	.type	HAL_GPIO_DeInit,%function
	.code	16                      @ @HAL_GPIO_DeInit
	.thumb_func
HAL_GPIO_DeInit:
@ BB#0:                                 @ %entry
	push.w	{r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub	sp, #28
	movw	r3, #14344
	movw	lr, #0
	movw	r9, #15360
	movw	r8, #15364
	movw	r12, #15368
	movw	r7, #15372
	str	r0, [sp, #24]
	movs	r0, #0
	str	r1, [sp, #20]
	movs	r1, #3
	movs	r2, #15
	str	r0, [sp, #12]
	str	r0, [sp, #8]
	str	r0, [sp, #4]
	str	r0, [sp, #16]
	movs	r0, #1
	movt	r3, #16385
	movt	lr, #16386
	movt	r9, #16385
	movt	r8, #16385
	movt	r12, #16385
	movt	r7, #16385
	b	.LBB133_2
.LBB133_1:                              @ %for.inc
                                        @   in Loop: Header=BB133_2 Depth=1
	ldr	r4, [sp, #16]
	adds	r4, #1
	str	r4, [sp, #16]
.LBB133_2:                              @ %for.cond
                                        @ =>This Inner Loop Header: Depth=1
	ldr	r4, [sp, #16]
	cmp	r4, #15
	bhi.w	.LBB133_19
@ BB#3:                                 @ %for.body
                                        @   in Loop: Header=BB133_2 Depth=1
	ldr	r4, [sp, #16]
	ldr	r5, [sp, #20]
	lsl.w	r4, r0, r4
	str	r4, [sp, #12]
	ands	r4, r5
	ldr	r5, [sp, #12]
	str	r4, [sp, #8]
	cmp	r4, r5
	bne	.LBB133_1
@ BB#4:                                 @ %if.then
                                        @   in Loop: Header=BB133_2 Depth=1
	ldr	r5, [sp, #24]
	ldr	r4, [sp, #16]
	ldr	r6, [r5]
	lsls	r4, r4, #1
	lsl.w	r4, r1, r4
	bic.w	r4, r6, r4
	movw	r6, #65532
	str	r4, [r5]
	movt	r6, #32767
	ldr	r4, [sp, #16]
	and	r5, r4, #7
	and.w	r4, r6, r4, lsr #1
	ldr	r6, [sp, #24]
	lsls	r5, r5, #2
	lsl.w	r5, r2, r5
	add	r4, r6
	ldr	r6, [r4, #32]
	bic.w	r5, r6, r5
	str	r5, [r4, #32]
	ldr	r5, [sp, #24]
	ldr	r4, [sp, #16]
	ldr	r6, [r5, #8]
	lsls	r4, r4, #1
	lsl.w	r4, r1, r4
	bic.w	r4, r6, r4
	str	r4, [r5, #8]
	ldr	r5, [sp, #24]
	ldr	r4, [sp, #16]
	ldr	r6, [r5, #4]
	lsl.w	r4, r0, r4
	bic.w	r4, r6, r4
	str	r4, [r5, #4]
	ldr	r5, [sp, #24]
	ldr	r4, [sp, #16]
	ldr	r6, [r5, #12]
	lsls	r4, r4, #1
	lsl.w	r4, r1, r4
	bic.w	r4, r6, r4
	str	r4, [r5, #12]
	ldr	r4, [sp, #16]
	bic	r4, r4, #3
	ldr	r4, [r4, r3]
	ldr	r5, [sp, #16]
	and	r5, r5, #3
	str	r4, [sp, #4]
	lsls	r5, r5, #2
	lsl.w	r5, r2, r5
	and.w	r11, r4, r5
	ldr	r4, [sp, #24]
	str.w	r11, [sp, #4]
	cmp	r4, lr
	bne	.LBB133_6
@ BB#5:                                 @   in Loop: Header=BB133_2 Depth=1
	mov.w	r10, #0
	b	.LBB133_17
.LBB133_6:                              @ %cond.false
                                        @   in Loop: Header=BB133_2 Depth=1
	ldr	r4, [sp, #24]
	movw	r5, #1024
	movt	r5, #16386
	cmp	r4, r5
	bne	.LBB133_8
@ BB#7:                                 @   in Loop: Header=BB133_2 Depth=1
	mov.w	r10, #1
	b	.LBB133_17
.LBB133_8:                              @ %cond.false30
                                        @   in Loop: Header=BB133_2 Depth=1
	ldr	r4, [sp, #24]
	movw	r5, #2048
	movt	r5, #16386
	cmp	r4, r5
	bne	.LBB133_10
@ BB#9:                                 @   in Loop: Header=BB133_2 Depth=1
	mov.w	r10, #2
	b	.LBB133_17
.LBB133_10:                             @ %cond.false33
                                        @   in Loop: Header=BB133_2 Depth=1
	ldr	r4, [sp, #24]
	movw	r5, #3072
	movt	r5, #16386
	cmp	r4, r5
	bne	.LBB133_12
@ BB#11:                                @   in Loop: Header=BB133_2 Depth=1
	mov.w	r10, #3
	b	.LBB133_17
.LBB133_12:                             @ %cond.false36
                                        @   in Loop: Header=BB133_2 Depth=1
	ldr	r4, [sp, #24]
	movw	r5, #4096
	movt	r5, #16386
	cmp	r4, r5
	bne	.LBB133_14
@ BB#13:                                @   in Loop: Header=BB133_2 Depth=1
	mov.w	r10, #4
	b	.LBB133_17
.LBB133_14:                             @ %cond.false39
                                        @   in Loop: Header=BB133_2 Depth=1
	ldr	r4, [sp, #24]
	movw	r5, #5120
	movt	r5, #16386
	cmp	r4, r5
	bne	.LBB133_16
@ BB#15:                                @   in Loop: Header=BB133_2 Depth=1
	mov.w	r10, #5
	b	.LBB133_17
.LBB133_16:                             @ %cond.false42
                                        @   in Loop: Header=BB133_2 Depth=1
	ldr	r4, [sp, #24]
	movw	r5, #6144
	mov.w	r10, #7
	movt	r5, #16386
	cmp	r4, r5
	it	eq
	moveq.w	r10, #6
.LBB133_17:                             @ %cond.end53
                                        @   in Loop: Header=BB133_2 Depth=1
	ldr	r5, [sp, #16]
	uxtb.w	r4, r10
	and	r5, r5, #3
	lsls	r5, r5, #2
	lsls	r4, r5
	cmp	r11, r4
	bne.w	.LBB133_1
@ BB#18:                                @ %if.then61
                                        @   in Loop: Header=BB133_2 Depth=1
	ldr	r4, [sp, #16]
	ldr	r5, [sp, #16]
	and	r4, r4, #3
	bic	r5, r5, #3
	lsls	r4, r4, #2
	lsl.w	r4, r2, r4
	str	r4, [sp, #4]
	ldr	r6, [r5, r3]
	bic.w	r4, r6, r4
	str	r4, [r5, r3]
	ldr	r4, [sp, #8]
	ldr.w	r5, [r9]
	bic.w	r4, r5, r4
	str.w	r4, [r9]
	ldr	r4, [sp, #8]
	ldr.w	r5, [r8]
	bic.w	r4, r5, r4
	str.w	r4, [r8]
	ldr	r4, [sp, #8]
	ldr.w	r5, [r12]
	bic.w	r4, r5, r4
	str.w	r4, [r12]
	ldr	r4, [sp, #8]
	ldr	r5, [r7]
	bic.w	r4, r5, r4
	str	r4, [r7]
	b	.LBB133_1
.LBB133_19:                             @ %for.end
	@APP
	boundcheckstart.HAL_GPIO_DeInit.text.module.gpio.ret:

	@NO_APP
	add	sp, #28
	pop.w	{r4, r5, r6, r7, r8, r9, r10, r11, lr}
	push {r0}
 	movw r0, :lower16:gateway_ret_gpio
 	movt r0, :upper16:gateway_ret_gpio
 	bic lr,lr,#1
 	cmp lr, r0
 	beq end_of_check_HAL_GPIO_DeInit1
 	movw r0, :lower16:.text.module.gpio_start
 	movt r0, :upper16:.text.module.gpio_start
 	cmp lr, r0
 	it cc
 	blcc exceptionFun
 	movw r0, :lower16:.text.module.gpio_end
 	movt r0, :upper16:.text.module.gpio_end
 	cmp lr, r0
 	it cs
 	blcs exceptionFun
end_of_check_HAL_GPIO_DeInit1:
	pop {r0}
 	orr lr,lr,#1
	bx	lr
.Ltmp133:
	.size	HAL_GPIO_DeInit, .Ltmp133-HAL_GPIO_DeInit

	.globl	HAL_GPIO_ReadPin
	.align	2
	.type	HAL_GPIO_ReadPin,%function
	.code	16                      @ @HAL_GPIO_ReadPin
	.thumb_func
HAL_GPIO_ReadPin:
@ BB#0:                                 @ %entry
	sub	sp, #16
	str	r0, [sp, #8]
	strh.w	r1, [sp, #4]
	ldr	r0, [sp, #8]
	ldr	r0, [r0, #16]
	ldrh.w	r1, [sp, #4]
	tst	r0, r1
	ite	eq
	moveq	r0, #0
	movne	r0, #1
	str	r0, [sp]
	ldr	r0, [sp]
	@APP
	boundcheckstart.HAL_GPIO_ReadPin.text.module.gpio.ret:

	@NO_APP
	add	sp, #16
	push {r0}
 	movw r0, :lower16:gateway_ret_gpio
 	movt r0, :upper16:gateway_ret_gpio
 	bic lr,lr,#1
 	cmp lr, r0
 	beq end_of_check_HAL_GPIO_ReadPin2
 	movw r0, :lower16:.text.module.gpio_start
 	movt r0, :upper16:.text.module.gpio_start
 	cmp lr, r0
 	it cc
 	blcc exceptionFun
 	movw r0, :lower16:.text.module.gpio_end
 	movt r0, :upper16:.text.module.gpio_end
 	cmp lr, r0
 	it cs
 	blcs exceptionFun
end_of_check_HAL_GPIO_ReadPin2:
	pop {r0}
 	orr lr,lr,#1
	bx	lr
.Ltmp134:
	.size	HAL_GPIO_ReadPin, .Ltmp134-HAL_GPIO_ReadPin

	.globl	HAL_GPIO_WritePin
	.align	2
	.type	HAL_GPIO_WritePin,%function
	.code	16                      @ @HAL_GPIO_WritePin
	.thumb_func
HAL_GPIO_WritePin:
@ BB#0:                                 @ %entry
	sub	sp, #16
	str	r0, [sp, #8]
	strh.w	r1, [sp, #4]
	str	r2, [sp]
	cbz	r2, .LBB135_2
@ BB#1:                                 @ %if.then
	ldr	r0, [sp, #8]
	ldrh.w	r1, [sp, #4]
	str	r1, [r0, #24]
	b	.LBB135_3
.LBB135_2:                              @ %if.else
	ldrh.w	r0, [sp, #4]
	ldr	r1, [sp, #8]
	lsls	r0, r0, #16
	str	r0, [r1, #24]
.LBB135_3:                              @ %if.end
	@APP
	boundcheckstart.HAL_GPIO_WritePin.text.module.gpio.ret:

	@NO_APP
	add	sp, #16
	push {r0}
 	movw r0, :lower16:gateway_ret_gpio
 	movt r0, :upper16:gateway_ret_gpio
 	bic lr,lr,#1
 	cmp lr, r0
 	beq end_of_check_HAL_GPIO_WritePin3
 	movw r0, :lower16:.text.module.gpio_start
 	movt r0, :upper16:.text.module.gpio_start
 	cmp lr, r0
 	it cc
 	blcc exceptionFun
 	movw r0, :lower16:.text.module.gpio_end
 	movt r0, :upper16:.text.module.gpio_end
 	cmp lr, r0
 	it cs
 	blcs exceptionFun
end_of_check_HAL_GPIO_WritePin3:
	pop {r0}
 	orr lr,lr,#1
	bx	lr
.Ltmp135:
	.size	HAL_GPIO_WritePin, .Ltmp135-HAL_GPIO_WritePin

	.globl	HAL_GPIO_TogglePin
	.align	2
	.type	HAL_GPIO_TogglePin,%function
	.code	16                      @ @HAL_GPIO_TogglePin
	.thumb_func
HAL_GPIO_TogglePin:
@ BB#0:                                 @ %entry
	sub	sp, #16
	str	r0, [sp, #8]
	strh.w	r1, [sp, #4]
	ldr	r1, [sp, #8]
	ldrh.w	r0, [sp, #4]
	ldr	r2, [r1, #20]
	eors	r0, r2
	str	r0, [r1, #20]
	@APP
	boundcheckstart.HAL_GPIO_TogglePin.text.module.gpio.ret:

	@NO_APP
	add	sp, #16
	push {r0}
 	movw r0, :lower16:gateway_ret_gpio
 	movt r0, :upper16:gateway_ret_gpio
 	bic lr,lr,#1
 	cmp lr, r0
 	beq end_of_check_HAL_GPIO_TogglePin4
 	movw r0, :lower16:.text.module.gpio_start
 	movt r0, :upper16:.text.module.gpio_start
 	cmp lr, r0
 	it cc
 	blcc exceptionFun
 	movw r0, :lower16:.text.module.gpio_end
 	movt r0, :upper16:.text.module.gpio_end
 	cmp lr, r0
 	it cs
 	blcs exceptionFun
end_of_check_HAL_GPIO_TogglePin4:
	pop {r0}
 	orr lr,lr,#1
	bx	lr
.Ltmp136:
	.size	HAL_GPIO_TogglePin, .Ltmp136-HAL_GPIO_TogglePin

	.globl	HAL_GPIO_LockPin
	.align	2
	.type	HAL_GPIO_LockPin,%function
	.code	16                      @ @HAL_GPIO_LockPin
	.thumb_func
HAL_GPIO_LockPin:
@ BB#0:                                 @ %entry
	sub	sp, #16
	str	r0, [sp, #8]
	mov.w	r0, #65536
	strh.w	r1, [sp, #4]
	str	r0, [sp]
	ldrh.w	r0, [sp, #4]
	ldr	r1, [sp]
	orrs	r0, r1
	str	r0, [sp]
	ldr	r0, [sp]
	ldr	r1, [sp, #8]
	str	r0, [r1, #28]
	ldr	r0, [sp, #8]
	ldrh.w	r1, [sp, #4]
	str	r1, [r0, #28]
	ldr	r0, [sp]
	ldr	r1, [sp, #8]
	str	r0, [r1, #28]
	ldr	r0, [sp, #8]
	ldr	r0, [r0, #28]
	str	r0, [sp]
	ldr	r0, [sp, #8]
	ldr	r0, [r0, #28]
	tst.w	r0, #65536
	ite	eq
	moveq	r0, #1
	movne	r0, #0
	str	r0, [sp, #12]
	ldr	r0, [sp, #12]
	@APP
	boundcheckstart.HAL_GPIO_LockPin.text.module.gpio.ret:

	@NO_APP
	add	sp, #16
	push {r0}
 	movw r0, :lower16:gateway_ret_gpio
 	movt r0, :upper16:gateway_ret_gpio
 	bic lr,lr,#1
 	cmp lr, r0
 	beq end_of_check_HAL_GPIO_LockPin5
 	movw r0, :lower16:.text.module.gpio_start
 	movt r0, :upper16:.text.module.gpio_start
 	cmp lr, r0
 	it cc
 	blcc exceptionFun
 	movw r0, :lower16:.text.module.gpio_end
 	movt r0, :upper16:.text.module.gpio_end
 	cmp lr, r0
 	it cs
 	blcs exceptionFun
end_of_check_HAL_GPIO_LockPin5:
	pop {r0}
 	orr lr,lr,#1
	bx	lr
.Ltmp137:
	.size	HAL_GPIO_LockPin, .Ltmp137-HAL_GPIO_LockPin

	.globl	HAL_GPIO_EXTI_IRQHandler
	.align	2
	.type	HAL_GPIO_EXTI_IRQHandler,%function
	.code	16                      @ @HAL_GPIO_EXTI_IRQHandler
	.thumb_func
HAL_GPIO_EXTI_IRQHandler:
@ BB#0:                                 @ %entry
	push	{r7, lr}
	mov	r7, sp
	sub	sp, #8
	strh.w	r0, [sp, #4]
	movw	r0, #15380
	movt	r0, #16385
	ldr	r1, [r0]
	ldrh.w	r2, [sp, #4]
	tst	r1, r2
	beq	.LBB138_2
@ BB#1:                                 @ %if.then
	ldrh.w	r1, [sp, #4]
	str	r1, [r0]
	ldrh.w	r0, [sp, #4]
	bl	HAL_GPIO_EXTI_Callback
.LBB138_2:                              @ %if.end
	@APP
	boundcheckstart.HAL_GPIO_EXTI_IRQHandler.text.module.gpio.ret:

	@NO_APP
	add	sp, #8
	pop	{r7, lr}
	push {r0}
 	movw r0, :lower16:gateway_ret_gpio
 	movt r0, :upper16:gateway_ret_gpio
 	bic lr,lr,#1
 	cmp lr, r0
 	beq end_of_check_HAL_GPIO_EXTI_IRQHandler6
 	movw r0, :lower16:.text.module.gpio_start
 	movt r0, :upper16:.text.module.gpio_start
 	cmp lr, r0
 	it cc
 	blcc exceptionFun
 	movw r0, :lower16:.text.module.gpio_end
 	movt r0, :upper16:.text.module.gpio_end
 	cmp lr, r0
 	it cs
 	blcs exceptionFun
end_of_check_HAL_GPIO_EXTI_IRQHandler6:
	pop {r0}
 	orr lr,lr,#1
	bx	lr
.Ltmp138:
	.size	HAL_GPIO_EXTI_IRQHandler, .Ltmp138-HAL_GPIO_EXTI_IRQHandler

	.weak	HAL_GPIO_EXTI_Callback
	.align	2
	.type	HAL_GPIO_EXTI_Callback,%function
	.code	16                      @ @HAL_GPIO_EXTI_Callback
	.thumb_func
HAL_GPIO_EXTI_Callback:
@ BB#0:                                 @ %entry
	sub	sp, #4
	strh.w	r0, [sp]
	@APP
	boundcheckstart.HAL_GPIO_EXTI_Callback.text.module.gpio.ret:

	@NO_APP
	add	sp, #4
	push {r0}
 	movw r0, :lower16:gateway_ret_gpio
 	movt r0, :upper16:gateway_ret_gpio
 	bic lr,lr,#1
 	cmp lr, r0
 	beq end_of_check_HAL_GPIO_EXTI_Callback7
 	movw r0, :lower16:.text.module.gpio_start
 	movt r0, :upper16:.text.module.gpio_start
 	cmp lr, r0
 	it cc
 	blcc exceptionFun
 	movw r0, :lower16:.text.module.gpio_end
 	movt r0, :upper16:.text.module.gpio_end
 	cmp lr, r0
 	it cs
 	blcs exceptionFun
end_of_check_HAL_GPIO_EXTI_Callback7:
	pop {r0}
 	orr lr,lr,#1
	bx	lr
.Ltmp139:
	.size	HAL_GPIO_EXTI_Callback, .Ltmp139-HAL_GPIO_EXTI_Callback

	.section	.text.usfi,"ax",%progbits
	.globl	gateway_gpio
	.align	2
	.type	gateway_gpio,%function
	.code	16                      @ @gateway_gpio
	.thumb_func
gateway_gpio:
@ BB#0:                                 @ %entry
	@APP
		push {lr}
	svc #10 
boundcheckstart.gateway.text.module.gpio.ret:
	push {r0}
 	movw r0, :lower16:.text.module.gpio_start
 	movt r0, :upper16:.text.module.gpio_start
 	cmp r4,r0
 	it cc
	blcc exceptionFun
 	movw r0, :lower16:.text.module.gpio_end
 	movt r0, :upper16:.text.module.gpio_end
 	cmp r4,r0
 	it cs
 	blcs exceptionFun
 	pop {r0}
	 blx r4
.global gateway_ret_gpio
gateway_ret_gpio:
	svc #255 
	pop {lr}

	@NO_APP
	bx	lr
.Ltmp140:
	.size	gateway_gpio, .Ltmp140-gateway_gpio

	.section	.text.common,"ax",%progbits
	.globl	exceptionFun
	.align	2
	.type	exceptionFun,%function
	.code	16                      @ @exceptionFun
	.thumb_func
exceptionFun:
@ BB#0:                                 @ %entry
	bx	lr
.Ltmp141:
	.size	exceptionFun, .Ltmp141-exceptionFun

	.type	UGPIO_InitStruct,%object @ @UGPIO_InitStruct
	.section	.data.public,"aw",%progbits
	.globl	UGPIO_InitStruct
	.align	2
UGPIO_InitStruct:
	.zero	20
	.size	UGPIO_InitStruct, 20

	.type	.L.str,%object          @ @.str
	.section	.rodata.str1.1,"aMS",%progbits,1
.L.str:
	.asciz	"\r\n"
	.size	.L.str, 3

	.type	.L.str1,%object         @ @.str1
.L.str1:
	.asciz	"Hello uSFI!"
	.size	.L.str1, 12

	.type	msg,%object             @ @msg
	.section	.data.public,"aw",%progbits
	.globl	msg
	.align	3
msg:
	.long	0
	.size	msg, 4

	.type	main.main_stack,%object @ @main.main_stack
	.section	.process_stack,"aw",%progbits
	.align	4
main.main_stack:
	.zero	512
	.size	main.main_stack, 512

	.type	main.module_stack,%object @ @main.module_stack
	.align	4
main.module_stack:
	.zero	512
	.size	main.module_stack, 512

	.type	main.uart_stack,%object @ @main.uart_stack
	.align	4
main.uart_stack:
	.zero	512
	.size	main.uart_stack, 512

	.type	.Lmain.permissionGPIO,%object @ @main.permissionGPIO
	.section	.rodata.cst8,"aM",%progbits,8
	.align	2
.Lmain.permissionGPIO:
	.long	1073872914              @ 0x40020012
	.long	318767123               @ 0x13000013
	.size	.Lmain.permissionGPIO, 8

	.type	.Lmain.permissionUART,%object @ @main.permissionUART
	.align	2
.Lmain.permissionUART:
	.long	1073759250              @ 0x40004412
	.long	318767123               @ 0x13000013
	.size	.Lmain.permissionUART, 8

	.type	huart2,%object          @ @huart2
	.section	.data.public,"aw",%progbits
	.globl	huart2
	.align	3
huart2:
	.zero	72
	.size	huart2, 72

	.type	SystemCoreClock,%object @ @SystemCoreClock
	.data
	.globl	SystemCoreClock
	.align	2
SystemCoreClock:
	.long	16000000                @ 0xf42400
	.size	SystemCoreClock, 4

	.type	AHBPrescTable,%object   @ @AHBPrescTable
	.section	.rodata,"a",%progbits
	.globl	AHBPrescTable
	.align	4
AHBPrescTable:
	.ascii	"\000\000\000\000\000\000\000\000\001\002\003\004\006\007\b\t"
	.size	AHBPrescTable, 16

	.type	uwTick,%object          @ @uwTick
	.comm	uwTick,4,4
	.type	APBAHBPrescTable,%object @ @APBAHBPrescTable
	.globl	APBAHBPrescTable
	.align	4
APBAHBPrescTable:
	.ascii	"\000\000\000\000\001\002\003\004\001\002\003\004\006\007\b\t"
	.size	APBAHBPrescTable, 16

	.type	DMA_CalcBaseAndBitshift.flagBitshiftOffset,%object @ @DMA_CalcBaseAndBitshift.flagBitshiftOffset
DMA_CalcBaseAndBitshift.flagBitshiftOffset:
	.ascii	"\000\006\020\026\000\006\020\026"
	.size	DMA_CalcBaseAndBitshift.flagBitshiftOffset, 8


	.ident	"clang version 3.4 (tags/RELEASE_34/final)"
	.ident	"clang version 3.4 (tags/RELEASE_34/final)"
	.ident	"clang version 3.4 (tags/RELEASE_34/final)"
	.ident	"clang version 3.4 (tags/RELEASE_34/final)"
	.ident	"clang version 3.4 (tags/RELEASE_34/final)"
	.ident	"clang version 3.4 (tags/RELEASE_34/final)"
	.ident	"clang version 3.4 (tags/RELEASE_34/final)"
	.ident	"clang version 3.4 (tags/RELEASE_34/final)"
	.ident	"clang version 3.4 (tags/RELEASE_34/final)"
