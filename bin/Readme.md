# Readme

## Overview

This directory contains all scripts

## Dependency download scripts

TODO redo in python, backup files in .Net class's for other project

 * download_deps.py - Download depnds and extract to the deps folder for mbed

## MBed Wrapper scripts

This directory contains a set of python scripts that act as an overlay
on top of the existing mbed python scripts
the idea is we can add in our own targets and settings within lib\mbed\extra_targets

 * workspace_tools/build.py - mbed build wrapper
 * workspace_tools/make.py - mbed make wrapper

There's also a Visual Studio solution for debugging under the vsdebug sub directory
