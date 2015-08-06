@echo off

REM Uncomment next line and set destination drive to match mbed device
REM SET LPC_DEPLOY=copy PROJECT.bin f:\

REM Set path for make and gcc
SET PATH=%PATH%;..\..\deps\gcc-arm-none-eabi\bin\;..\..\oldmake;

REM do build
rem make
