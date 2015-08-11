"""
Wrapper script to modify the paths when needed
"""

from os.path import join, abspath, dirname
import argparse

#Include the original file
execfile("../../deps/mbed/workspace_tools/paths.py")

# Addtional content below

# Get our root directory
OVERRIDE_ROOT = abspath(join(dirname(__file__), ".."))

# Get the Specified target
parser = argparse.ArgumentParser()
parser.add_argument('-m', "--mcu", dest='mcu')
args, unknown = parser.parse_known_args()
specifiedtarget = args.mcu

# If the target is an overriden one in our directory
# then we need to change the value of MBED_TARGETS_PATH within paths.py
# This is used within build_api.py / build_mbed_libs()
DOTBMED_TARGETS = ['TESTTARGET','ARDUINODUE']

# TODO Check if Target includes 'EXTRA_TARGET' in it's lables, this is currently not the best way

if specifiedtarget in DOTBMED_TARGETS:
    MBED_TARGETS_PATH = join(OVERRIDE_ROOT, "..\lib\mbed\extra_targets")
