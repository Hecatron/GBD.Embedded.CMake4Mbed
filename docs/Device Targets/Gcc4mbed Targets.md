# Gcc4mbed Targets

## Overview

With gcc4mbed this currently uses the makefile system to handle compiling code
it doesn't directly rely on the python scripts provided by Mbed.
But it does have per device makefiles which is information copy / pasted from the build.py output for compiling against different targets
also it does include code from mbed's cmsis and hal directories for a given device

In this git repo I've bundled all the makefiles into a directory called **oldmake**
Eventually I plan on replacing these with cmake files located in **lib/cmake**


## Create a new gcc4mbed device makefile

The first step is to create a new device makefile under oldmake such as LPC1347-device.mk

The fields to look at include:

  * MBED_DEVICE should match the name used above for the -m option
  * The filename should match against MBED_DEVICE i.e. LPC1347-device.mk
  * TARGETS_FOR_DEVICE should match the above targets for the device
  * GCC_DEFINES inclues defines sucg as -D__CORTEX_M3 -DARM_MATH_CM3
  * C_FLAGS / ASM_FLAGS / LD_FLAGS specify the cpu type such as -mcpu=cortex-m3
  * LSCRIPT defines a linker script to be used
  * MBED_TARGET = NXP_LPC1347 I think is the name of the build subdirectory used within mbed so could probably be anything
    see deps\mbed\Release
