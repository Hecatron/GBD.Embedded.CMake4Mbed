"""
Settings for the LPC-Link Scripts
"""

from os.path import abspath, dirname, join

# XML Settings for Download of Depends
class LPCSettings(object):

    def __init__(self):

        super().__init__()
        # Setup the Defaults

        # Path to the LPCXpresso tools
        self.lpcdir = abspath(join("C:", "nxp", "LPCXpresso_7.9.0_455", "lpcxpresso", "bin"))

        # Command to boot the LPCLink1
        self.bootbin = abspath(join(self.lpcdir, "boot_link1.cmd"))

        # Command to flash the LPCLink1 Device
        self.flashbin = abspath(join(self.lpcdir, "crt_emu_lpc11_13_nxp.exe"))

        # Which vendor to use for flashing
        self.vendor = "NXP"

        # Which LPC Device model to use for flashing
        self.device = "LPC1347"

        # Upload method to use for flashing
        self.uploadmethod = "hid"

        # Maximum Emulator Speed
        self.emulatorspeed = "250"

        # Flash driver to use for accessing flash on the device
        self.flashdriver = "LPC11_12_13_64K_8K.cfx"

        # Elf File to upload / flash
        self.elffile = None

#REM Options for the Flash Tool
#set LPCFlashOpts=-flash-load-exec %ELFFile% -g -2 -vendor=%LPCVendor% -p%LPCDevice% --wire=%LPCWireMode% -s%LPCEmulatorSpeed%
#set LPCFlashOpts=%LPCFlashOpts% -flash-driver=%LPCFlashDriver%

#REM Run the flash tool
#echo Running:
#echo %LPCFlashBin% %LPCFlashOpts%   
#%LPCFlashBin% %LPCFlashOpts%

# TODO Elf File