# mbed Target - Hal Notes

## Overview

This is just a brief list of things done to create the additional target TARGET_ARDUINODUE in the overlay directory
these notes are a bit scrappy at the moment, as I'm just trying to get it to work first then tidy up later

The layout is:

 * hal\Target_Manufactuer\Target_Family\Target_CPU\Target_Board
 * hal\TARGET_Atmel\TARGET_SAM\TARGET_SAM3X\TARGET_ARDUINODUE

## HAL

For arduino files to use as an example

 * https://github.com/arduino/Arduino/tree/master/hardware/arduino/sam
 * https://github.com/arduino/Arduino/tree/master/hardware/arduino/sam/system

## Drivers directory

it looks like the existing target for the Sam21 CPU was using a limited set of files from
deps\atmel-asf\sam0\drivers

we want to do something similar but with
deps\atmel-asf\sam\drivers

For now I've just copied the entire drivers directory across to the family directory
lib\mbed\extra_targets\hal\TARGET_Atmel\TARGET_SAM3X

TODO this needs strimming down to just what we need
since it's around 200Mb

## Common Atmel files

it looks like we have a set of files in the TARGET_Atmel directory from the original mbed sources
that provide some board related info, it looks like this was originally part of the asf directory from

 * atmel-asf\common
 * atmel-asf\common2
 * TODO not sure where the files in config originated from

## Main Target device .h

The entry point for mbed is device.h
according to the docs https://developer.mbed.org/handbook/mbed-SDK-porting

the main 2 api's we need to port to test are

 * gpio
 * us_ticker_api

 * we need to set almost all values in device.h to 0
 * try and compile / run the hello world

## TODO

 * next try and use TESTTARGET to compile the LPC example code first to make sure the extra targets directories work
