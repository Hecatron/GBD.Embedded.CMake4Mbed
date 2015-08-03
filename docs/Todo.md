# TODO

## GDB Debugging

1. compiling and using mri.h for serial gdb, at the moment it may only be targeted for one specific device
so we need to experiment

2. Using Segger for gdb debugging via VS2015
3. create better generic scripts for starting the GDB server / Uploading code under bin/

4. one of the generic scripts is buildenv.cmd
    // gcc/bin/buildenv.cmd
    // REM Uncomment next line and set destination drive to match mbed device
    // REM SET LPC_DEPLOY=copy PROJECT.bin f:\
    // SET PATH=%~dp0;%~dp0..\..\external\win32;%PATH%

    // This specifies the destination for deployment, and includes make into the path for building
    // Also there is the option for GCC4MBED_TYPE=Debug to specify debugging within the code

## Build Process

1. look at moving to cmake / ninjabuild for the build scripts, using gcc4mbed make files as a basis
2. look at creating an app which reads in an xml file and the vcxproj file and spits out a makefile for building (similar to premake / cmake)
this way when we add a file to the visual studio project file it will be auto included into the make process
also we need to consider building on multiple platforms such as linux
Ideally I need an app to convert between templates VCXProject <-> cmake only templates

3. create a couple of example templates
The first should be cmake only withot VS Project files just for building the source
The second should be a VS based template with cmake files located in a cmake subdirectory

gcc4mbed.c should be part of the template, although we can put a copy of it under lib/gcc4mbed
also lib/templates is a good place to locate the templates

4. have a directory lib/mbed
which is an overlay / sits on top of the existing mbed directories
we want to avoid putting new files into the existing mbed source tree
this way we can locate our own targets / boards here
also we can prefix our own targets with DOTMBED_ just as a way of setting them apart from the exsitng mbed files / targets

5. If we decide to use ninja build, it needs to be built under the VS2013 command prompt (not 2015 that one doesn't work)
using configure.py --bootstrap
we can put the precompiled code under bin/tools/

6. one idea is a self extracting exe with the tools we can install
then a visual studio plugin to create project files based on it

## Arduino Due

1 . try copying the cmsis files from the arduino ide for mbed on the arduino due
use the lib/mbed subdirectory for any new source files

http://www.doulos.com/knowhow/arm/CMSIS/
http://forum.arduino.cc/index.php?topic=131777.0
https://github.com/adamgreen/gcc4mbed/blob/master/notes/new_devices.creole
https://developer.mbed.org/handbook/mbed-SDK-porting

## Arm Emulation

Is this possible, not sure if the LPC GUI has something for it
getting feedback on pin states would be good inside VS

