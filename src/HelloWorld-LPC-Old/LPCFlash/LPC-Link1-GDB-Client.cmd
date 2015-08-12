@echo off

REM Bin Directory for the gdb exe
REM set GBDBinDir=C:\nxp\LPCXpresso_7.9.0_455\lpcxpresso\tools\bin
set GBDBinDir=D:\SourceControl\GitRepos\GBD.Embedded.CMake4Mbed\deps\gcc-arm-none-eabi\bin

REM Name of the gdb exe
set GBDBin=%GBDBinDir%\arm-none-eabi-gdb.exe

REM Run the flash tool as a gdb server
echo Running:
echo %GBDBin% --command LPC-Link1-GDB-Client.txt
%GBDBin% --command LPC-Link1-GDB-Client.txt
rem %GBDBin%