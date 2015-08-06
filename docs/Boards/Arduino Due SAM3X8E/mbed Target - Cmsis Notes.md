# mbed Target - Cmsis Notes

## Overview

This is just a brief list of things done to create the additional target for the arduino due in the overlay directory
This is still a work in progress


## Directory layout

It looks like cmsis.h is the main entry point for the target in cmsis and device.h for hal

 * cmsis is the first set of files to be setup, they specfy CPU specific values, typically surrounding the IRQ Numbers / vector (address) positions
 * hal specify's how the CPU ties into peripherals such as gpio / pmw / serial etc on the chip

Layouts generally are:

 * CMSIS     - Target_Manufacturer\Target_Family\Target_CPU
 * ToolChain - Target_Manufacturer\Target_Family\Target_CPU\TOOLCHAIN_GCC_ARM
 * HAL       - Target_Manufacturer\Target_Family\Target_CPU\Target_Board(Optional)

In some cases the target just relates to a CPU, in others a board which uses that CPU and may have additional features
This is the optional Target_Board directory within the HAL tree

Within the ASF library the Atmel ARM devices seem to be split into 2 directories sam and sam0
I've left SAM21 as the sam0 directory, and created a new TARGET_SAM directory to match against the atmel-asf\sam directory
since the SAM3X8E falls into this other catagory

for the arduino I'm using the following layout

 * lib\mbed\extra_targets\cmsis\TARGET_Atmel\TARGET_SAM\TARGET_SAM3X8E
 * lib\mbed\extra_targets\cmsis\TARGET_Atmel\TARGET_SAM\TARGET_SAM3X8E\TOOLCHAIN_GCC_ARM
 * lib\mbed\extra_targets\hal\TARGET_Atmel\TARGET_SAM\TARGET_SAM3X8E\TARGET_ARDUINODUE


## Targets

The name of the class within the target.py file (ARDUINODUE) will first pick up the directory TARGET_ARDUINODUE
I've also added the parent directories to extra labels self.extra_labels = ['Atmel', 'SAM', 'SAM3X8E']
I'm not sure if this is needed, but I think it might indicate to the build system to look in those parent directories for additional headers
which is what I need anyway

From what I can gather mbed auto compiles and links any .c files it finds in the cmsis / hal directories
so we need to be careful about only including what we need

Additional values within the target include

 * ARDUINO_DUE_X for the board definition in the macros's
 *  __SAM3X8E__ to select the right CPU in the macro's


## CMSIS Core Files

Because I'm using a seperate directory for the targets, I've copied the core headers across
This is something used for all ARM devices

 * deps/mbed/libraries/mbed/targets/cmsis -> lib/mbed/extra_targets/cmsis


## TARGET_Atmel Directory

For the Atmel directory at the top I needed to first copy over some files from the common directory for cmsis compile
First I created a new directory TARGET_Atmel\common\utils
Then copied across some of the files from the asf common directory atmel-asf\common\utils

 * parts.*
 * interrupt.h
 * interrupt directory


## TARGET_SAM Directory

For the SAM directory TARGET_Atmel\TARGET_SAM

First we create a directory called utils
TARGET_Atmel\TARGET_SAM\utils

next we're going to copy across some but not all of the files from the ASF
from atmel-asf\sam\utils

  utils\compiler.h
  utils\status_codes.h
  utils\preprocessor\*
  utils\header_files\*
  utils\cmsis\sam3x\include\*


## TARGET_SAM3X8E Directory

For the SAM3X8E directory TARGET_Atmel\TARGET_SAM\TARGET_SAM3X8E

I've copied a generic cmsis.h across from another target
the only line to modify here is the one that includes the device header, in this case I've set it to sam3xa.h

Also I've copied cmsis_nvic.h / cmsis_nvic.c from one of the other SAM Targets
it looks like the only values to look out for are

 * cmsis_nvic.h - NVIC_NUM_VECTORS / NVIC_USER_IRQ_OFFSET
 * cmsis_nvic.c - NVIC_FLASH_VECTOR_ADDRESS / NVIC_RAM_VECTOR_ADDRESS

We also need a couple of system files

 * atmel-asf\sam\utils\cmsis\sam3x\source\templates\system_sam3x.*
 * atmel-asf\sam\utils\cmsis\sam3x\source\templates\exceptions.*


## TOOLCHAIN_GCC_ARM Directory

For the toolchain directory TARGET_Atmel\TARGET_SAM\TARGET_SAM3X8E\TOOLCHAIN_GCC_ARM

I've copied files from

 * deps\atmel-asf\sam\utils\cmsis\sam3x\source\templates\gcc

For the linker scripts located under
deps\atmel-asf\sam\utils\linker_scripts\sam3x\sam3x8\gcc

we should only copy one of the files - flash.ld, this is because the mbed build scripts just use the first one they can find


### cmsis_nvic.h

For the IRQ Numbers it looks like these can be split into 2 sections

 * IRQ's specific to the ARM Cortex type (M0 / M3 etc) for exception purposes
 * IRQ's specific to the device type

For NVIC_USER_IRQ_OFFSET this is the offset for the start of the device specific IRQ's (2nd section)
these are the ones labled in the sam3x83 pdf as IRQ0 - IRQ29, starting after Systick typically
Looking at the source code of sam3x8e.h and the pdf for the sam3x8e means the offset is 16
This seems to be standard for M3 / M4 I think, although M0 I think might be shorter

 * http://www.atmel.com/images/atmel-11057-32-bit-cortex-m3-microcontroller-sam3x-sam3a_datasheet.pdf

For NVIC_NUM_VECTORS this needs to be the total number of bytes allocated to the device specific IRQ's
(IRQ0 - IRQ29 in the pdf) in this case 44 looking at the enum of IRQn in sam3x8e.h and the pdf on **page 74**


### cmsis_nvic.c

For the Flash Vector address NVIC_FLASH_VECTOR_ADDRESS it seems to be quite common for this to be set to address 0x00
so we can ignore this one

Looking at the pdf on page 62 the SRAM address NVIC_RAM_VECTOR_ADDRESS should be 0x20000000


## TODO

 * The startup file in the toolchain directory is C instead of .S assembler
   this seems to compile into the cmsis source okay so I've left it in, not sure if it's needed though
   gcc4mbed seems to use the .ld file for linkage so hopefully we can ignore the startup file
   further investigation needed to see if it's required
