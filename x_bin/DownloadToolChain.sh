#!/bin/bash

echo Downloading GNU Tools for ARM Embedded Processors and MBed Libs...
mono tools\scriptcs\scriptcs.exe -ScriptName scripts\DownloadToolChain_Main.csx
