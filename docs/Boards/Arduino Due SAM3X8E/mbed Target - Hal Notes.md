# mbed Target - Hal Notes

## Overview

This is just a brief list of things done to create the additional target TARGET_ARDUINODUE in the overlay directory
these notes are a bit scrappy at the moment, as I'm just trying to get it to work first then tidy up later

The layout is:

 * hal\Target_Manufactuer\Target_Family\Target_CPU\Target_Board
 * hal\TARGET_Atmel\TARGET_SAM\TARGET_SAM3X\TARGET_ARDUINODUE


### Links

For arduino files to use as an example

 * https://github.com/arduino/Arduino/tree/master/hardware/arduino/sam
 * https://github.com/arduino/Arduino/tree/master/hardware/arduino/sam/system


## TARGET_Atmel Directory

At the top level hal\TARGET_Atmel\ we already have the following directories
from the existing mbed sources

 * common - files match against asf
 * common2 - files match against asf

For the config directory
TODO these may be SAM0 specific, we might need to write new ones for the SAM / SAM3x8E targets
and move this directory into the SAM0 directory
most of them seem to be includes with example projects in the asf

 * conf_board.h - empty
 * conf_clocks.h - lots of stuff in
 * conf_dma.h - one liner
 * conf_extint.h - one liner
 * conf_spi.h - 3 lines


## TARGET_SAM Directory

For the hal\TARGET_Atmel\TARGET_SAM directory


### Utils subdirectory

I looks like we need some headers from the utils directory under cmsis





### Drivers subdirectory

we need to create a new directory hal\TARGET_Atmel\TARGET_SAM\drivers
looking at the existing SAM0 drivers directory to see which files we need to copy over
we need to copy the following from deps\atmel-asf\sam\drivers

TODO


### API Headers

Next we need to locate some headers within the hal\TARGET_Atmel\TARGET_SAM directory
these should in theory be common to all of the sam series of CPU's

TODO For now I've just made a copy of the ones from sam0
I need to check these ones over


## TARGET_ARDUINODUE Directory

For the hal\TARGET_Atmel\TARGET_SAM\TARGET_SAM3X8E\TARGET_ARDUINODUE directory
We need a single device.h file

according to the docs device.h is the main entry point for mbed for the target
It just a list of features that are enabled for that given target

 * https://developer.mbed.org/handbook/mbed-SDK-porting


## API Testing

The main 2 api's we need to port to test are

 * gpio
 * us_ticker_api

 * we need to set almost all values in device.h to 0
 * try and compile / run the hello world


## TODO

 * next try and use TESTTARGET to compile the LPC example code first to make sure the extra targets directories work

