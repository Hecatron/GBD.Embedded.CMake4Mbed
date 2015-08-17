#! /usr/bin/env python2
"""
Script to export gcc flags / include directories for all mbed targets for cmake
"""

import sys, os

# Modify the paths to include the original mbed deps directories
sys.path.append(os.path.abspath("../"))
sys.path.append(os.path.abspath("../../deps/mbed"))
sys.path.append(os.path.abspath("../../deps/mbed/workspace_tools"))

# Monkey Patch the sources
import mbed.patch_buildimports
import mbed.patch_buildopts


# TODO
# https://developer.mbed.org/cookbook/mbed-cmake
