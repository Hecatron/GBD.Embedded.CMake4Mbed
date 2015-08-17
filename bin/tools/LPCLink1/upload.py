#!python3
"""
Script Wrapper for uploading firmware to LPC Expresso boards via LPCLink-1
"""

import sys, logging, argparse
from lpc_settings import LPCSettings
from pylib.logwrapper import LogWrapper
from pylib.process import Process
from os.path import abspath, dirname, join

try:

    # Setup logging
    LogWrapper.LogLevel = logging.DEBUG
    LogWrapper.setup()
    log = LogWrapper.getlogger()


    # Function to Boot the LPC Board
    def bootlpc():
        log.info("Booting the LPC Board")
        proc = Process()
        proc.ExePath = Setts.bootbin
        proc.Start()





    ROOT = abspath(dirname(__file__))

    # Load in the Settings
    Setts = LPCSettings()

    parser = argparse.ArgumentParser()
    parser.add_argument("--bootdevice", action='store_true', default=False, help="Boot the LPCLink1 Device before upload")
    args = parser.parse_args()

    # Boot the LPC Link1 device if needed
    if args.bootdevice == True:
        bootlpc()








# Output any errors
except Exception as e:
    log.critical (e)
    if LogWrapper.LogLevel == logging.DEBUG:
        import traceback
        traceback.print_exc(file=sys.stdout)
    sys.exit(1)
