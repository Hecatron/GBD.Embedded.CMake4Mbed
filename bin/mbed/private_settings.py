"""
Override settings within settings.py
"""

# This file is picked up as if it was located within the mbed/workspace_tools directory
# via import trickery within patch_buildimports.py

# We can't use optionparser to load in our custom settings since it only parses options it recognises
# and some of the options are defined within the original build.py
# so we use argparse instead which can be used with parse_known_args

import argparse, os

# Parse the extra command line options
parser = argparse.ArgumentParser()
parser.add_argument("--builddir", required=False, default=None)
args, extra = parser.parse_known_args()

# Setup Build Directory if specified
if args.builddir != None:
    BUILD_DIR = os.path.abspath(args.builddir)

# Specfy the path to the gcc executables
GCC_ARM_PATH = os.path.abspath("../../deps/gcc-arm-none-eabi/bin")

print("done")