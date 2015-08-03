# GBD.Embedded.DotMbed

## Overview

This project is a series of build scripts and modifications to allow for more automated building of mbed based C++ projects on ARM
The original build glue logic is from another project called gcc4mbed from Adam Green
but the plan is to use those makefiles to create a series of cmake files / .net .csx scripts for ninja build to build the source
also since Visual Studio is my chosen IDE I want to try and get tighter integration working for debugging
In theory with a Segger or LPCLink it should be possible to single step the code on a real board / inspect variables etc

Be warned at the moment this isn't much more than some rough notes and a demo of getting mbed to work under a couple of different boards
This is currently still a work in process / place to put all my notes on stuff as I figure it out
see the **docs** sub directory for most of what I've figured out so far

Goals:

 * Get mbed working with a LPC 1347 Xpresso board / LPC-Link (done)
 * Get mbed working on the Arduino Due using a J-Link Segger
 * Update the build process to use cmake / ninja-build tools
 * Get debugging with VS 2015 GDB working
 * Make things a bit more automated and clearer for adding new boards / support (make things as easy as possible)
 * Have tighter integration with VS2015 so that when we add a source file to the VCXProj file it's auto included into the build process
