# Debugging via GDB

## Overview

In order to debug code via the LPC Link we need 2 parts

 * GDB Server
 * GDB Client

The Server is provided via the LPC Tools, the client can be anything
if using the usual gcc gdb client for command line debugging it's best to use the same exe
that was used to compile the code e.g. deps\gcc-arm-none-eabi\bin\arm-none-eabi-gdb.exe

## Example Debugging Session

### Starting the GDB Server

After flashing the code we can run the gdb server to connect to lpc-link
For a basic example look at the HelloWorld code which just blinks the Led

 * https://www.lpcware.com/content/forum/using-lpc-link-with-eclipse
 * http://www.coocox.org/forum/viewtopic.php?t=741&f=2

For which tool to use

 * For LPC-Link1 Devices we use crt_emu_cm3_nxp.exe
 * For LPC-Link2 Devices we use redlinkserv.exe -commandline

For LPC-Link1 this is handled via the same tool we use for flashing the device with crt_emu_cm3_nxp.exe

An example of command line useage:

  crt_emu_cm3_nxp.exe -g -4 -vendor=NXP -pLPC1347 --wire=hid -s250 -flash-driver=LPC11_12_13_64K_8K.cfx --server=:3333


### Starting the GDB Client

For a GDB Client we can use the following

  * For .elf files compiled with the LPC GUI C:\nxp\LPCXpresso_7.9.0_455\lpcxpresso\tools\bin\arm-none-eabi-gdb.exe
  * For .elf files compiled with mbed deps\gcc-arm-none-eabi\bin\arm-none-eabi-gdb.exe
  * Visual Studio 2015

For the command line gdb it's best to use the one matched against the compiler used to compile the code
Assuming we're debugging code compiled against mbed

  cd deps\gcc-arm-none-eabi\bin\
  arm-none-eabi-gdb.exe

Next we need to run a few commands on gdb to connect to the server

  target extended-remote :3333
  set remotetimeout 60000
  set mem inaccessible-by-default off
  mon ondisconnect cont
  set arm force-mode thumb

Use commands like continue or detach, Cntrl-C to break
I've created a seperate document for debugging on VS 2015

### GDB Scripts

In the HelloWorld-LPC Project I've got a couple of batch files setup for handling this
under the LPCFlash directory

  * bootlpclink.cmd - Boot the LPC-Link1 Device
  * LPC-Link1-Upload.cmd - upload elf file to LPC device
  * LPC-Link1-GDB-Server.cmd - start GDB Server on port 3333
  * LPC-Link1-GDB-Client.cmd - start GDB client on port 3333


### GDB Client Commands

Note exiting the gdb client by hitting ctrl-C multiple times can mess up the gdb server
at which point you'll need to restart the gdb server otherwise the client will think the code is not running
The best way to exit the gdb client is Ctrl-C then **detach**

  * http://www.cs.cmu.edu/~gilpin/tutorial/
  * https://sourceware.org/gdb/current/onlinedocs/gdb/

typical GDB Commands include

  * continue - continue running of the program
  * ctrl-C once to stop
  * detach - detach from the gdb server
