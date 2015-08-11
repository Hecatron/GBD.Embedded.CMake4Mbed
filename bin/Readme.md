# Readme

## Overview

This directory contains scripts for:

 * Downloading dependencies - download_deps.py
 * Building mbed - mbed/build.py
 * Building mbed test projects - mbed/make.py

## Download Deps script

This script just downloads source code from a bunch of different sources
and extracts them into the /deps/ subdirectory

There are 2 setting files

 * DependSettings_win32.xml
 * DependSettings_linux.xml

You can customise these to download other sources from http or github if you'd like
The scripts within the scripts/ subdirectory are used to do the downloading

TODO the linux xml is just a copy of the windows one, need to adjust this for linux versions of gcc etc
and test

## MBed build script

This script is designed to build the required mbed library for the given device
so that it can be statically linked against from another project.
The script in this directory is basically a wrapper around the existing mbed build.py script
there's an option for altering the build output directory on the command line

  cd bin/mbed
  build.py -m TESTTARGET -t GCC_ARM --builddir ../../build

This is mostly used by the cmake scripts to alter the build destination
There is also changes within the private_paths.py and private_targets.py files
to allow for custom targets located within lib/mbed/extra_targets

At the moment I'm currently experimenting with trying to get mbed working on an Arduino Due
and possibly other boards in the future so this is just acting as an overlay

The scripts do involve the use of monkey patching, and redirecting of imports
which is an ugly hack, although once I've got things working I'll try and submit some changes
to the mbed git to see if these can be taken

## MBed make script

The mbed make.py script is designed to build test projects that can be uploaded to the board
to test out different features such as blinking an Led or I2c.
The wrapper script here just adds the same --builddir option for a different output directory
and allows using targets from the overlay lib/mbed/extra_targets

  cd bin/mbed
  make.py -m TESTTARGET -t GCC_ARM --builddir ../../build -p 0

## Visual Studio Debugging

Within the bin/vsdebug directory there is a Visual Studio solution for debugging some of the
build scripts within VS2015
