# Gcc4Mbed - Target

## Overview

By default the gcc4mbed source does not include a target setup for the LPC1347
However mbed does have this device setup as a target, so we just need to create a new make file to allow us to use it

I've already set this up as **oldmake\LPC1347-device.mk**
originally this was a copy of the LPC1768-device.mk file but with a few tweaks / changes

## TODO

TODO I'll probably be replacing this as I try to redo the build script logic with cmake
and create a custom target with different pin numbers
