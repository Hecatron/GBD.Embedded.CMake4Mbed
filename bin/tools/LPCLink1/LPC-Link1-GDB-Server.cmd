@echo off

REM Bin Directory for the LPCXpresso Tools
set LPCBinDir=C:\nxp\LPCXpresso_7.9.0_455\lpcxpresso\bin

REM Which flash tool to use - LPC-Link1 V1.3 - LPC1347
set LPCFlashBin=%LPCBinDir%\crt_emu_lpc11_13_nxp

REM which Vendor option
set LPCVendor=NXP

REM which device option
set LPCDevice=LPC1347

Rem which method to upload the image
set LPCWireMode=hid

Rem Maximum Emulator speed
set LPCEmulatorSpeed=250

Rem Flash Driver
set LPCFlashDriver=LPC11_12_13_64K_8K.cfx

REM Options for the Flash Tool
set LPCFlashOpts= -g -4 -vendor=%LPCVendor% -p%LPCDevice% --wire=%LPCWireMode% -s%LPCEmulatorSpeed%
set LPCFlashOpts=%LPCFlashOpts% -flash-driver=%LPCFlashDriver% --server=:3333

REM Run the flash tool as a gdb server
echo Running:
echo %LPCFlashBin% %LPCFlashOpts%   
%LPCFlashBin% %LPCFlashOpts%
