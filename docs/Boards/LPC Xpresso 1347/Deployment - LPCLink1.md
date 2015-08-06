# Deployment - LPC1347 / LPCLink1

## Overview

With the xpresso board we can use the LPC Downloaded tools to program the board via LPCLink1
we can attach to the programming side and program .elf images from mbed to this device

 * IDE / Tools - https://www.lpcware.com/lpcxpresso/downloads/windows
 * Manual - https://www.lpcware.com/system/files/LPCXpresso_User_Guide_5.pdf

Attaching a JLink / Segger should be possible but it would mean breaking apart both sides of the board
The SWD connection on the LPCLink is an output (not an input) which allows the LPC Link side
to be used for programming other LPC Devices via the SWD Connector

 * http://visualgdb.com/tutorials/arm/nxp_lpc/


## Programming ia LPC Link1


### Booting the LPC Link1

The first step is that we need to boot the LPC Link1 side of the board
normally this is triggered during a debug session with the LPC IDE, but since we're not using that here
we first need to boot the board manually

  * http://www.support.code-red-tech.com/CodeRedWiki/BootingLPCLink
  * https://www.lpcware.com/content/faq/lpcxpresso/booting-lpc-link

When you connect this board for the first time, it will show up under windows as a DFU Device
This can be seen under **Control Panel -> Devices and Printers**

This is typically the command we need to run from a command prompt to initialise the LPCLink1

  C:\nxp\LPCXpresso_7.9.0_455\lpcxpresso\bin\boot_link1.cmd

The board will then change it's name from a **DFU Device** into a **LPC Debug Probe**
If you see a **LPC134x HID** device listed, typically this is what the client side of the board shows up as via USB


### Flashing the LPC via LPC-Link

When flashing firmware images via the LPC Xpresso GUI usually these files end in a **.axf extension**
These files are actually **.elf files**, and we can flash files compiled from mbed without any problems

I've included some details on scripts I've setup for flashing mbed .elf files below
This section just gives a simple break down of some of the options passed on the command line to the tool used to flash via the LPCLink1 board

In this example the tool we want to use is LPC1347 is **crt_emu_lpc11_13_nxp.exe**
Usually located under **C:\nxp\LPCXpresso_7.9.0_455\lpcxpresso\bin**
This tool also doubles up as a GDB Server for debugging purposes

One of the best ways to figure out the command line options is to ether run crt_emu_lpc11_13_nxp.exe with the --help option
or flash a device via the GUI and make a note of which options it's using as part of the flash process
Note the board does need to be booted first before the flash tool will work

 * https://www.lpcware.com/content/faq/lpcxpresso/gui-flash-programming-tool
 * https://www.lpcware.com/content/faq/lpcxpresso/command-line-flash-programming

Example Flash command

  crt_emu_lpc11_13_nxp -flash-load-exec "C:\Users\ric\Documents\LPCXpresso_7.9.0_455\workspace\periph_systick\Debug\periph_systick.axf" -g -2 -vendor=NXP -pLPC1347  -wire=hid -s250  -flash-driver=LPC11_12_13_64K_8K.cfx

Typical meaning of command line options 

  * -flash-load-exec (this means erase then load elf file to target, then start code execution from reset)
  * -g -2 (Progress meter for extended operations)
  * -vendor=NXP (Provide the package's vendor, default is NXP)
  * -pLPC1347 (Set 'package' for the chip and/or board, implies XML file name or entry in XML file for chip/board)
  * -wire=hid (WireType, this just represents the connection on the host which in our case is usb hid)
  * -s250 (Maximum emulator speed in KHz, e.g. -s 1000)
  * -flash-driver (load external flash driver)

The fash driver is just a specification for accessing external or internal flash blocks on the device
I found with the LPC1347 Xpresso board this seems to be **LPC11_12_13_64K_8K.cfx**
The full path doesn't need to be specified, but the flash drivers can be seen under C:\nxp\LPCXpresso_7.9.0_455\lpcxpresso\bin\Flash

 * https://www.lpcware.com/content/faq/lpcxpresso/lpc18-lpc43-external-flash-drivers

### Scripts for Flashing

Within the HelloWorld-LPC Project I've got a script setup called **LPC-Link1-Upload.cmd** in the LPCFlash subdirectory

## TODO

TODO look into better general scripts