/*
 * uSFI Project
 * Definition of uSFI interface functions  
 *
 * Author: Zelalem Aweke (zaweke@umich.edu)
 */

#ifndef USFI_H
#define USFI_H

#include <inttypes.h>
#include <stdlib.h>

/* MPU attributes */
#define portMPU_REGION_NO_ACCESS				( 0x0UL << 24UL )
#define portMPU_REGION_READ_WRITE				( 0x03UL << 24UL )
#define portMPU_REGION_PRIVILEGED_READ_ONLY		( 0x05UL << 24UL )
#define portMPU_REGION_READ_ONLY				( 0x06UL << 24UL )
#define portMPU_REGION_PRIVILEGED_READ_WRITE	( 0x01UL << 24UL )
#define portMPU_REGION_CACHEABLE_BUFFERABLE		( 0x07UL << 16UL )
#define portMPU_REGION_EXECUTE_NEVER			( 0x01UL << 28UL )

/* MPU region numbers */
#define portUNPRIVILEGED_FLASH_REGION		( 0UL )
#define portPUBLIC_RAM_REGION			( 1UL )
#define portGENERAL_PERIPHERALS_REGION		( 2UL )
#define portRCC_REGION	(3UL)
#define portSTACK_REGION					( 4UL )
#define portGENERAL_PERIPHERALS_REGION2 (5UL)

/* Constants required to access and manipulate the MPU. */
#define portMPU_TYPE_REG						( * ( ( volatile uint32_t * ) 0xe000ed90 ) )
#define portMPU_REGION_BASE_ADDRESS_REG			( * ( ( volatile uint32_t * ) 0xe000ed9C ) )
#define portMPU_REGION_ATTRIBUTE_REG			( * ( ( volatile uint32_t * ) 0xe000edA0 ) )
#define portMPU_CTRL_REG						( * ( ( volatile uint32_t * ) 0xe000ed94 ) )
#define portMPU_REGION_NUM						( * ( ( volatile uint32_t * ) 0xe000ed98 ) )
#define portEXPECTED_MPU_TYPE_VALUE				( 8UL << 8UL ) /* 8 regions, unified. */
#define portMPU_ENABLE							( 0x01UL )
#define portMPU_BACKGROUND_ENABLE				( 1UL << 2UL )
#define portPRIVILEGED_EXECUTION_START_ADDRESS	( 0UL )
#define portMPU_REGION_VALID					( 0x10UL )
#define portMPU_REGION_ENABLE					( 0x01UL )
#define portPERIPHERALS_START_ADDRESS			0x40000000UL
#define portPERIPHERALS_END_ADDRESS				0x5FFFFFFFUL
#define portRCC_START_ADDRESS	0x40023800UL
#define portRCC_END_ADDRESS	0x40023BFFUL


#define EXIT_SVC 255
#define TOTAL_NUM_MODULES 250
#define TOTAL_NUM_REGIONS 8
#define TOTAL_NUM_IO	8
#define MODULE_SETTING_STACK_SIZE 16
#define DEFAULT_STACK_DEPTH	128


typedef struct PERMISSION_IO{
	volatile uint32_t regionBaseAddress;
	volatile uint32_t regionAttribute;
}xPERMISSION_IO;

typedef struct MPU_REGION_REGISTERS
{
	volatile uint32_t regionBaseAddress;
	volatile uint32_t regionAttribute;
} xMPU_REGION_REGISTERS;


typedef struct MODULE_SETTINGS
{
	volatile uint32_t stackPointer;
	/* Stack 
	   IO
	   Private data
	   Heap	*/

	xMPU_REGION_REGISTERS xRegion[ TOTAL_NUM_REGIONS ];
	/*Flag to specify whether the module has privileged access */
	volatile uint32_t controlReg; 
} xMODULE_SETTINGS;

/* usfi code to configure and initialize modules.
*  This functions reside in .text.usfi section. */

/* Create module 
* @param modNum: module identification number
* 
* @param pxStack: pointer to module stack
*
* @param ulStackDepth: stack depth
*
* @param perIO: IO permissions for module
*
* @param numIO: Number of IO permissions
*
* @param privilaged: indicates whether module is privileged or not
*/
int createModule(uint8_t modNum, uint32_t *pxStack, uint32_t ulStackDepth, xPERMISSION_IO *perIO, 
				uint32_t numIO, uint32_t privileged)  __attribute__ ((section (".text.usfi")));

/* Initialize usfi: This function configures regions for Module 0. 
* Module 0 is a privileged module (the module has access to the entire memory.
* Execution starts in this module.
*
* @param pxStack: pointer to module stack
*
* @param ulStackDepth: stack depth
*
*/

void initUSFI(uint32_t *pxStack, uint32_t ulStackDepth) __attribute__ ((section (".text.usfi")));

/* Initial configuration of MPU */

void prvSetupMPU( void ) __attribute__ ((section (".text.usfi")));

#endif
