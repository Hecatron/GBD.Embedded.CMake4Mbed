#! /usr/bin/env python3
"""
This script can be used to download depends required for cmake mbed
"""

from scripts.dep_settings import DependSettings
from os.path import join, abspath, dirname
from scripts.script_logs import ScriptLogs
import wget, sys, platform, logging

verbose = True

try:

    # Setup logging
    ScriptLogs.LogLevel = logging.DEBUG
    ScriptLogs.setup()
    log = ScriptLogs.getlogger()

    ROOT = abspath(dirname(__file__))
    osplatform = platform.system()

    if osplatform == "Windows":
        SETTINGS_PATH = abspath('DependSettings_win32.xml')
    elif osplatform == "Linux":
        SETTINGS_PATH = abspath('DependSettings_linux.xml')
    else:
        log.critical("Unsupported platform")
        sys.exit(1)
    log.info("Platform identified as: " + osplatform)

    # Load in the Settings from an xml file
    Setts = DependSettings()
    Setts.loadxml(SETTINGS_PATH)

    # Download all sources
    Setts.download()
    
    # Extract Sources
    Setts.extract()

    # Depends Setup Complete
    log.info("Download of Depends Complete")

# Output any errors
except Exception as e:
    log.critical (e)
    if verbose:
        import traceback
        traceback.print_exc(file=sys.stdout)
    sys.exit(1)
