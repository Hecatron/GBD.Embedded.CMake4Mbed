#! /usr/bin/env python2
"""
This file acts as an overlay over the top of the original make.py script
"""

import sys, os

# Modify the paths to include the original mbed deps directories
sys.path.append(os.path.abspath("../"))
sys.path.append(os.path.abspath("../../deps/mbed"))
sys.path.append(os.path.abspath("../../deps/mbed/workspace_tools"))

# Monkey Patch the sources
import mbed.patch_buildimports
import mbed.patch_buildopts

# Include the original build.py script
# nothing else will run after calling this, this needs to be the last line
execfile("../../deps/mbed/workspace_tools/make.py")
