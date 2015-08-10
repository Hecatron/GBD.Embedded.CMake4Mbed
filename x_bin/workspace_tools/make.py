#! /usr/bin/env python2
"""
This file acts as an overlay over the top of the original make.py script
"""

# Setup the common overlay code
execfile("./common.py")

# Include the original make.py script
# nothing else will run after calling this, this needs to be the last line
execfile("../../deps/mbed/workspace_tools/make.py")
