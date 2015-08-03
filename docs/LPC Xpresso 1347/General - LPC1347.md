# General Info on the LPC1347 Xpresso Board

## Overview

This document is just some general info I've discovered in relation to the LPC1347 Xpresso Board
With the LPC1347 Xpresso board, there are two parts to the board

  * The LPC-Link1 side of the board that allows for programming and provides power
    this is very similar to the JLink Segger in that it also allows for debugging via SWD / Jtag / GDB
  * The "client" side of the board that is programmed which includes the LPC1347

For programming you'll probably want to install the LPC Xpresso Tools

 * IDE / Tools - https://www.lpcware.com/lpcxpresso/downloads/windows
 * Manual - https://www.lpcware.com/system/files/LPCXpresso_User_Guide_5.pdf


## Board Schematics

I've included a couple of links below to the board layout and schematics

 * http://www.embeddedartists.com/sites/default/files/docs/schematics/LPCXpressoLPC1347revA.pdf
 * http://www.microbuilder.eu/Images/Blog/QFP48_LPC1343_1347.png

## Pin Name issues

For mbed so far I've been using the **TARGET_LPC13XX** target
located under **deps\mbed\libraries\mbed\targets\cmsis\TARGET_NXP\TARGET_LPC13XX**

However this appears to have originally been setup for a different board
I think this one

 * https://developer.mbed.org/platforms/WiFi-DipCortex/

This isn't really that much of a problem since they both use the same processor
however one thing to watch out for is that the pin numbers and the pin's the LED's are connected to is a bit different

If you look at **PinNames.h**
Within **deps\mbed\libraries\mbed\targets\hal\TARGET_NXP\TARGET_LPC13XX**
you'll notice that the pin names come in two forms

  * p1, p2, p3 ,p4, p5, p6, p7
  * P0_1, P0_2, P0_3, P0_4, P0_5, P0_6, P0_7

The values p1, p2 etc I think relate to the dipcortex board which isn't much use for us here
This is also true of the LED1, LED2 etc pins which also map to different pin numbers

What we can use corretly is the pin identifiers P0_1 - P0_7 which do correctly map to labled pins on the xpresso board
The Led pin on the xpresso board is actually attached to P0_7, so this is the one we use for the blinky project


## Running Example projects

What I'm aiming for is the development of C++ Code via Visual Studio and mbed so that it will run on as many different types of boards as possible
with GDB Support for stepping through the code via ether a Segger or LPCLink

LPC tends to have it's own set of libraries called LPCOpen and I wanted to just get the basics working with this so that
I could see the command line options being passed to the flash tool and just to get an idea of what is possible

The LPC IDE appears to be a derrivative of the Eclipse IDE
In order to import some exampes into the LPC IDE

  * Click "Import Project" (Bottom Left)
  * Click "Browse LPCOpen resources"
  * Click Download "LPCOpen v2.xx for LPC13xx family devices"
  * Click on the link next to LPCXpresso
  * Download the zip, and select the Zip in the IDE window
  * Click Finish to import the example projects

At this stage we should now have some example projects imported
The most basic example for a blinky led is the periph_systick project

  * Highlight the periph_systick project
  * Select Build Debug in the toolbar for this project
  * Select Debug MCU to debug on the MCU device, the red led on the LPC-Link should light up when recieving data back

Note you may need to change the pin number to P0_7 for the led

## New Target

TODO Look into creating a new custom target with different pin numbering for the xpresso board
