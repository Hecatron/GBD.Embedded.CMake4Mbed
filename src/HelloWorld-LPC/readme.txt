This is my basic test app for debugging against a LPC1347 Xpresso Board
which has LPC-Link1 (V1.3)

Note we have to use pins numbers of the form P0_7
this is because the pin numbers are mapped in correctly in the LPC13XX target in mbed
it assumes we're using a different board which means the LED pins map to a different pin
so P7 / P21 etc should be avoided, and P0_7 should be used instead

basic scripts just to get things working
I will need to redo most of this, this is just a demo / test
next step is to test this with VS2015 GDB

to download the deps required run bin/download_deps.py

to compile the sources:

1. run "makepath.cmd" to add make to the path
2. run "make" to build the source / "make clean" to clean the source
3. edit the source in visual studio via the Samples.sln

to upload to the LPC:

1. plug in the board via usb, make sure it's the LPCLink side you plug in
this should show a DFU device under Control Panel -> Device and Printers

2. run "LPCFlash/bootlpclink.cmd" this will just call C:\nxp\LPCXpresso_7.9.0_455\lpcxpresso\bin\boot_link1.cmd
to load in the firmware to the LPC-Link side of the board
the device name will change to "LPC-Link Probe v1.3"

3. run "LPCFlash/LPC-Link1-Upload.cmd" to upload the HelloWorld.elf file to the board and run
4. run "LPCFlash/LPC-Link1-GDB-Server.cmd" in a seperate window to start the LPC gdb server
5. run "LPCFlash/LPC-Link1-GDB-Client.cmd" to connect to the server via gdb
use "continue" and Ctrl-C to start and stop the device
use detach to break from the session


Hard Coded paths:

TODO
There are some hard coded paths within the visual studio project properties
for the include paths
this shouldn't yet influence the build system
