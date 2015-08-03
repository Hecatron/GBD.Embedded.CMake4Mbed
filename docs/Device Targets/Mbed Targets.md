# Mbed Targets

## Overview

I've put some information together here on how the targets for mbed work
gcc4mbed doesn't directly rely on the output from build.py, it has it's own seperate setup for device targets
gcc4mbed uses the same headers / sources but has it's own definitions for c flags and which devices are associates with which headers

if we want to copy across information outputed from build.py (like build flags) to setup a new target for gcc4mbed
then we need to know how to get the info out of build.py

Ideally I'm looking at replace the build scripts with cmake and I want the ability to add custom boards later on
also getting the Arduino Due working is something I want to try using ASF sources

The main targets I'm interested in are

  * LPCXpresso LPC1347
  Board Type - LPC1347
  Defined within mbed\libraries\mbed\targets\hal\TARGET_NXP\TARGET_LPC13XX

  * Arduino Due
  Board Type - ARDUINO_DUE_X
  Defined within mbed\libraries\mbed\target\hal\TARGET_Atmel\common\boards\board.h

### Links

 * https://github.com/adamgreen/gcc4mbed/blob/master/notes/new_devices.creole
 * https://developer.mbed.org/handbook/mbed-SDK-porting
 * https://developer.mbed.org/handbook/mbed-library-internals

## Targets

### Build.py target definition

The place where all the target definitions exist within mbed is **workspace_tools/targets.py**

This includes a class definition

class LPC1768(LPCTarget):
    def __init__(self):
        LPCTarget.__init__(self)
        self.core = "Cortex-M3"
        self.extra_labels = ['NXP', 'LPC176X', 'MBED_LPC1768']
        self.supported_toolchains = ["ARM", "uARM", "GCC_ARM", "GCC_CS", "GCC_CR", "IAR"]
        self.detect_code = ["1010"]

An addition to the TARGETS list

  TARGETS = [
      LPC2368(),
      LPC1768(),
      LPC11U24(),
      KL25Z(),
      LPC812(),
      LPC4088(),
      LPC4330(),
  ]

There's also some code under workspace_tools/export that's worth investigating
including workspace_tools\export\gccarm.py

### MBed

With mbed there is a concept of targets, from what I can gather each target doesn't just represent a CPU
but can also represent a board configuration as well (the exposed pin numbers on a board for example)
The entry point for mbed's target system is build.py which seems to be a script for testing the different targets against the mbed code base
and exporting information about how each of the targets should compile

The mbed-SDK-porting link above has more information related to this above
each of the targets can be viewed under **mbed\libraries\mbed\targets**

When creating new targets there are 2 main areas to be aware of

 * cmsis - Cortex Microcontroller Software Interface Standard
 * Hal - Hardware Abstraction Layer

If we look at the target LPC13XX for example, this has 2 directories setup

 * mbed\libraries\mbed\targets\cmsis\TARGET_NXP\TARGET_LPC13XX
 * mbed\libraries\mbed\targets\hal\TARGET_NXP\TARGET_LPC13XX

### CMSIS

Cmsis stands for Cortex Microcontroller Software Interface Standard and consits of 3 layers

 * The Core Modules, these are headers provided typically by Arm for a specific Arm Family of devices
   Such as the Core-m0, Core-m3 etc

    core_cmFunc.h
    core_cmInstr.h
    cortex_cm0.h / cortex_cm0plus.h / core_cm3.h / cortex_cm4.h 

 * The chip manufacturer provided headers, these are headers usually provided by the manufacturer of the chip
   for Cmsis, this include NXP, Atmel etc

    startup_DEVICE.s
    system_DEVICE.c
    system_DEVICE.h
    DEVICE.h 

 * There is also a final layer that integrates cmsis into the mbed sdk
   these are used to dynamically set the vector table and to configure the memory model for the given C standard library:

    cmsis_nvic.c
    cmsis_nvic.h
    sys.cpp
    TARGET.sct
    cmsis.h 

### Hal

Hal stands for Hardware Abstraction Layer
This contains any headers / code required for peripherals on the chip such as serial / analouge ports / pmw outputs etc

## Running the mbed python build script

### Missing python modules

For the purposes of the above I'm using python 2.7 under windows, however there are some python modules I had to install using pip

  C:\Python27\Scripts\pip.exe install colorama
  C:\Python27\Scripts\pip.exe install jinja2
  C:\Python27\Scripts\pip.exe install prettytable

### Running the mbed script

In order to get some of the values we need for the device makefile we're going to setup we need to run the mbed build script and look at the output

  cd deps\mbed
  SET PATH=%PATH%;D:\SourceControl\GitRepos\GBD.Embedded.DotMbed\deps\gcc-arm-none-eabi\bin\;D:\SourceControl\GitRepos\GBD.Embedded.DotMbed\oldmake;
  workspace_tools\build.py -m LPC1347 -t GCC_ARM -v

to get a list of available devices

  workspace_tools\build.py --help
  workspace_tools\build.py -S

Note the path to gcc's bin directory needs to be absolute when adding it to the path (not relative)

The output will look something like this:

  [DEBUG] Command: arm-none-eabi-gcc
  -std=gnu99 -c -Wall -Wextra -Wno-unused-parameter -Wno-missing-field-initializers -fmessage-length=0 -fno-exceptions -fno-builtin -ffunction-sections
  -fdata-sections -MMD -fno-delete-null-pointer-checks -fomit-frame-pointer -mcpu=cortex-m3 -mthumb -O2
  -DTARGET_LPC1347 -DTARGET_M3 -DTARGET_CORTEX_M -DTARGET_NXP -DTARGET_LPC13XX
  -DTOOLCHAIN_GCC_ARM -DTOOLCHAIN_GCC
  -D__CORTEX_M3 -DARM_MATH_CM3
  -DMBED_BUILD_TIMESTAMP=1437992469.86 -D__MBED__=1
  -ID:\SourceControl\GitRepos\GBD.Embedded.DotMbed\deps\mbed\libraries\mbed\common
  -ID:\SourceControl\GitRepos\GBD.Embedded.DotMbed\deps\mbed\build\mbed
  -ID:\SourceControl\GitRepos\GBD.Embedded.DotMbed\deps\mbed\build\mbed\TARGET_LPC1347
  -ID:\SourceControl\GitRepos\GBD.Embedded.DotMbed\deps\mbed\build\mbed\TARGET_LPC1347\TARGET_NXP
  -ID:\SourceControl\GitRepos\GBD.Embedded.DotMbed\deps\mbed\build\mbed\TARGET_LPC1347\TARGET_NXP\TARGET_LPC13XX
  -ID:\SourceControl\GitRepos\GBD.Embedded.DotMbed\deps\mbed\build\mbed\TARGET_LPC1347\TOOLCHAIN_GCC_ARM
  -o D:\SourceControl\GitRepos\GBD.Embedded.DotMbed\deps\mbed\build\mbed\.temp\TARGET_LPC1347\TOOLCHAIN_GCC_ARM\.\board.o
  D:\SourceControl\GitRepos\GBD.Embedded.DotMbed\deps\mbed\libraries\mbed\common\board.c
