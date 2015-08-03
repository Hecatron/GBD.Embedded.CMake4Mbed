# Deployment - Segger

## Overview

With the Arduino Due there is a SWD connector already soldered to the board ready for use
SWD is a new form of JTAG with fewer pins and smaller footprint
(10 Pin IDC but with non standard spacing of 0.05 inches or 1.27mm)

 * https://developer.mbed.org/cookbook/Arduino-Due
 * http://www.support.code-red-tech.com/CodeRedWiki/HardwareDebugConnections

It's possible to connect to this connetor via an externl board such as one supported by openocd
The Debuging board I'm using here is the JLink Segger Edu version from adafruit

 * http://www.adafruit.com/products/1369
 * http://www.adafruit.com/products/2094
 * http://www.adafruit.com/products/1675

This allows us to program / flash the device and in theory debug the device via a gdb server included with the JLink Software

## Board Connections

I've included some images here on how to attach the Segger to the Arduino
the SWD connector on the board doesn't have a keyway so it's important to get the cable the right way round

## Program the Arduino via Segger

TODO generate an elf via mbed first

TODO can we debug an Arduino compiled .elf via Visual Studio / JLink ?
