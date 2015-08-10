@echo off

echo Downloading GNU Tools for ARM Embedded Processors and MBed Libs...
tools\scriptcs\scriptcs.exe -ScriptName scripts\DownloadToolChain_Main.csx -- %*
