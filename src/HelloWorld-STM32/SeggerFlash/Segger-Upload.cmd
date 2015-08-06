@echo off

REM which elf file to upload
set ELFFile="D:\SourceControl\GitRepos\GBD.Embedded.CMake4Mbed\src\HelloWorld-STM32\NUCLEO_F103RB\HelloWorld-STM32.elf"

REM Bin Directory for the Segger Tools
set SeggerBinDir=C:\Program Files (x86)\SEGGER\JLink_V500j

REM Which flash tool to use
set SeggerFlashBin="%SeggerBinDir%\Jlink.exe"

REM Which device to use
set SeggerDevice=STM32F103RB

REM Options for the Flash Tool
set SeggerFlashOpts=-device %SeggerDevice% -CommanderScript Segger-Upload.txt

REM Run the flash tool
echo Running:
echo %SeggerFlashBin% %SeggerFlashOpts%
%SeggerFlashBin% %SeggerFlashOpts%
