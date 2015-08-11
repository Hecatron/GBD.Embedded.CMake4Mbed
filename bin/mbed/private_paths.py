"""
Wrapper script to modify the paths when needed
"""

# This file overrides the target directory for custom mbed device targets

import argparse, os

#Include the original file
execfile("../../deps/mbed/workspace_tools/paths.py")

# The current root directory
ROOT = os.path.abspath(os.path.dirname(__file__))

# Get the Specified target
parser = argparse.ArgumentParser()
parser.add_argument('-m', "--mcu", dest='mcu')
args, unknown = parser.parse_known_args()
specifiedtarget = args.mcu

# If the target is an overriden one in our directory
# then we need to change the value of MBED_TARGETS_PATH within paths.py
# This is used within build_api.py / build_mbed_libs()
DOTBMED_TARGETS = ['TESTTARGET','ARDUINODUE']

# TODO Move this into a class property
if specifiedtarget in DOTBMED_TARGETS:
    MBED_TARGETS_PATH = os.path.join(ROOT, "..\..\lib\mbed\extra_targets")
