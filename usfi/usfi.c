#include "usfi.h"
#include <string.h>


/* uSFI data structures */
static xMODULE_SETTINGS  moduleSettingStack[MODULE_SETTING_STACK_SIZE] __attribute__ ((section (".data.usfi")));
xMODULE_SETTINGS* volatile moduleSettingStackPtr __attribute__ ((section (".data.usfi")));
static xMODULE_SETTINGS  moduleSettingList[TOTAL_NUM_MODULES] __attribute__ ((section (".data.usfi")));
xMODULE_SETTINGS* volatile moduleSettingListPtr __attribute__ ((section (".data.usfi")));


static uint32_t prvGetMPURegionSizeSetting( uint32_t ulActualSizeInBytes );




int createModule(uint8_t modNum, uint32_t *pxStack, uint32_t ulStackDepth, xPERMISSION_IO *perIO, uint32_t numIO, uint32_t privileged){

	int i;

	/* Set module stack region */
	if(pxStack != NULL){

		if( ulStackDepth > 0 )
		{

			/* We assume the stack grows down */
			uint32_t startOfStack = ( uint32_t ) pxStack - (ulStackDepth * ( uint32_t ) sizeof( uint32_t ));

			/* Define the region that allows access to the stack. */
	  		moduleSettingList[modNum].xRegion[0].regionBaseAddress =
	  				( startOfStack ) |
	  				( portMPU_REGION_VALID ) |
		 			( portSTACK_REGION ); /* Region number. */

	  		moduleSettingList[modNum].xRegion[0].regionAttribute = 
	  				( portMPU_REGION_READ_WRITE ) | /* Read and write. */
	  				( prvGetMPURegionSizeSetting( ulStackDepth * ( uint32_t ) sizeof( uint32_t ) ) ) |
	  				( portMPU_REGION_CACHEABLE_BUFFERABLE ) |
	  				( portMPU_REGION_ENABLE );
	  		moduleSettingList[modNum].stackPointer = ( uint32_t ) (pxStack - 8);
	 	}
	 }

	/* Set module periherals */
	if(numIO > TOTAL_NUM_IO){
		return -1;
	} 

	for(i=0; i<numIO; i++){
		moduleSettingList[modNum].xRegion[i+1].regionBaseAddress = perIO[i]->regionBaseAddress;
		moduleSettingList[modNum].xRegion[i+1].regionAttribute = perIO[i]->regionAttribute;
	}

	/* Clear unused regions */
	for(i = i+1;i<TOTAL_NUM_REGIONS;i++){
		moduleSettingList[modNum].xRegion[i].regionBaseAddress = 0;
		moduleSettingList[modNum].xRegion[i].regionAttribute = 0;
	}

	/* Set privileg bit */
	if(privileged)
		moduleSettingList[modNum].controlReg = 2;
	else
		moduleSettingList[modNum].controlReg = 3;

	return 0;
}


/* Module 0 is the usfi module. It has access to the entire memory. 
This function configures regions for Module 0 */

void initUSFI(uint32_t *pxStack, uint32_t ulStackDepth){

	int i;
	//Set the setting stack pointer to 0
	moduleSettingStackPtr = &moduleSettingStack[0];
	moduleSettingListPtr = &moduleSettingList[0];
	//Put initial setting in the stack
	if(pxStack != NULL){

		if( ulStackDepth > 0 )
		{
			/* Assumes the stack grows down */
			uint32_t startOfStack = ( uint32_t ) pxStack - (ulStackDepth * ( uint32_t ) sizeof( uint32_t ));
			/* Define the region that allows access to the stack. */
	  		moduleSettingStack[0].xRegion[0].regionBaseAddress =
	  				( startOfStack ) |
	  				( portMPU_REGION_VALID ) |
		 			( portSTACK_REGION ); /* Region number. */

	  		moduleSettingStack[0].xRegion[0].regionAttribute = 
	  				( portMPU_REGION_READ_WRITE ) | /* Read and write. */
	  				( prvGetMPURegionSizeSetting( ulStackDepth * ( uint32_t ) sizeof( uint32_t ) ) ) |
	  				( portMPU_REGION_CACHEABLE_BUFFERABLE ) |
	  				( portMPU_REGION_ENABLE );

	  		/*configure MPU to enable the stack */
	  		portMPU_REGION_BASE_ADDRESS_REG = moduleSettingStack[0].xRegion[0].regionBaseAddress;
	  		portMPU_REGION_ATTRIBUTE_REG = moduleSettingStack[0].xRegion[0].regionAttribute;

	  		moduleSettingStack[0].stackPointer = ( uint32_t ) (pxStack - 8);
	 	}
	 }

	/*Module has access to all periherals */
	moduleSettingStack[0].xRegion[1].regionBaseAddress = ( portPERIPHERALS_START_ADDRESS ) |
										   ( portMPU_REGION_VALID ) |
										   ( portGENERAL_PERIPHERALS_REGION );

	moduleSettingStack[0].xRegion[1].regionAttribute  =   ( portMPU_REGION_PRIVILEGED_READ_WRITE | portMPU_REGION_EXECUTE_NEVER ) |
										   ( prvGetMPURegionSizeSetting( portPERIPHERALS_END_ADDRESS - portPERIPHERALS_START_ADDRESS ) ) |
										   ( portMPU_REGION_ENABLE );


	for(i=2;i<8;i++){
		moduleSettingStack[0].xRegion[i].regionBaseAddress = 0;
		moduleSettingStack[0].xRegion[i].regionAttribute = 0;
	}

	/* Module is privileged */
	moduleSettingStack[0].controlReg = 2;
	
	/* Setup default settings (no access to peripherals and no stacks configured) */
	prvSetupMPU();

}

void prvSetupMPU( void )
{

extern uint32_t __FLASH_segment_start__[];
extern uint32_t __FLASH_segment_end__[];
extern uint32_t __public_data_start__[];
extern uint32_t __public_data_end__[];


		/* Check the expected MPU is present. */
	if( portMPU_TYPE_REG == portEXPECTED_MPU_TYPE_VALUE )
	{

		/* Setup the entire flash for unprivileged read only access. */
		portMPU_REGION_BASE_ADDRESS_REG =	( ( uint32_t ) __FLASH_segment_start__ ) | /* Base address. */
											( portMPU_REGION_VALID ) |
											( portUNPRIVILEGED_FLASH_REGION );

		portMPU_REGION_ATTRIBUTE_REG =	( portMPU_REGION_READ_ONLY ) |
										( portMPU_REGION_CACHEABLE_BUFFERABLE ) |
										( prvGetMPURegionSizeSetting( ( uint32_t ) __FLASH_segment_end__ - ( uint32_t ) __FLASH_segment_start__ ) ) |
										( portMPU_REGION_ENABLE );
		
		/* Configure public data region as readable and writable by all modules */ 

		portMPU_REGION_BASE_ADDRESS_REG =	( ( uint32_t ) __public_data_start__ ) | /* Base address.*/ 
		 									( portMPU_REGION_VALID ) |
		 									( portPUBLIC_RAM_REGION );

		portMPU_REGION_ATTRIBUTE_REG =	( portMPU_REGION_READ_WRITE ) |
		 								( portMPU_REGION_CACHEABLE_BUFFERABLE ) |
		 								prvGetMPURegionSizeSetting( ( uint32_t ) __public_data_end__ - ( uint32_t ) __public_data_start__ ) |
		 								( portMPU_REGION_ENABLE );

		/* Initialize peripheral MPU setting to be accessed by privileged code only*/
		portMPU_REGION_BASE_ADDRESS_REG = ( portPERIPHERALS_START_ADDRESS ) |
										   ( portMPU_REGION_VALID ) |
										   ( portGENERAL_PERIPHERALS_REGION );

		portMPU_REGION_ATTRIBUTE_REG =   ( portMPU_REGION_PRIVILEGED_READ_WRITE | portMPU_REGION_EXECUTE_NEVER ) |
										   ( prvGetMPURegionSizeSetting( portPERIPHERALS_END_ADDRESS - portPERIPHERALS_START_ADDRESS ) ) |
										   ( portMPU_REGION_ENABLE );

		/*RCC region is configured as unprivilaged here for test as it is commonly used by many tasks. It is possible to
		create a gateway and access it like the rest of the peripherals*/
		portMPU_REGION_BASE_ADDRESS_REG = ( portRCC_START_ADDRESS ) |
										   ( portMPU_REGION_VALID ) |
										   ( portRCC_REGION );

		portMPU_REGION_ATTRIBUTE_REG =   ( portMPU_REGION_READ_WRITE | portMPU_REGION_EXECUTE_NEVER ) |
										   ( prvGetMPURegionSizeSetting( portRCC_END_ADDRESS - portRCC_START_ADDRESS ) ) |
										   ( portMPU_REGION_ENABLE );


		/* Enable the MPU with the background region configured. */
		portMPU_CTRL_REG |= ( portMPU_ENABLE | portMPU_BACKGROUND_ENABLE );
	}
	
}

static uint32_t prvGetMPURegionSizeSetting( uint32_t ulActualSizeInBytes )
{
uint32_t ulRegionSize, ulReturnValue = 4;

	/* 32 is the smallest region size, 31 is the largest valid value for
	ulReturnValue. */
	for( ulRegionSize = 32UL; ulReturnValue < 31UL; ( ulRegionSize <<= 1UL ) )
	{
		if( ulActualSizeInBytes <= ulRegionSize )
		{
			break;
		}
		else
		{
			ulReturnValue++;
		}
	}

	/* Shift the code by one before returning so it can be written directly
	into the the correct bit position of the attribute register. */
	return ( ulReturnValue << 1UL );
}

