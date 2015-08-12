@echo off

REM Bin Directory for the LPCXpresso Tools
set SeggerBinDir=C:\Program Files (x86)\SEGGER\JLink_V500l

REM Which flash tool to use - LPC-Link1 V1.3 - LPC1347
set SeggerGdbBin="%SeggerBinDir%\JLinkGDBServer.exe"

REM Which device to use
set SeggerDevice=STM32F103RB

REM Options for the Flash Tool
set SeggerFlashOpts=-device %SeggerDevice%

REM Run the gdb server TODO
echo Running:
echo %SeggerGdbBin% -select USB -device STM32F103RB -if SWD -speed 1000 -noir
%SeggerGdbBin% -select USB -device STM32F103RB -if SWD -speed 1000 -noir
