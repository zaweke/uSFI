#ifndef USFI_H
#define USFI_H

#include <inttypes.h>
#include <stdlib.h>




#define EXIT_SVC 255
#define TOTAL_NUM_REGIONS 8
#define TOTAL_NUM_MODULES 250
#define MODULE_SETTING_STACK_SIZE 16
#define DEFAULT_STACK_DEPTH	128

#define SVC_IN_0 10



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
	volatile uint32_t controlReg; /*Flag to specify whether the module has privileged access */
} xMODULE_SETTINGS;


void createModule(uint8_t modNum, uint32_t *pxStack, uint32_t usStackDepth, xPERMISSION_IO *perIO, uint32_t privileged)  __attribute__ ((section (".text.usfi")));
void initUSFI(uint32_t *pxStack, uint32_t ulStackDepth) __attribute__ ((section (".text.usfi")));
void prvSetupMPU( void ) __attribute__ ((section (".text.usfi")));

#endif