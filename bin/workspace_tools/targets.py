"""
This file acts as an overlay / adding content to the original targets.py
"""

from os.path import join, abspath, dirname

#Include the original file
execfile("../../deps/mbed/workspace_tools/targets.py")

# Addtional content below

DOTBMED_TARGETS = []

# TODO implement target_directory in the mbed scripts

# TODO copy of LPC13XX renamed for testing
class TESTTARGET(LPCTarget, object):
    def __init__(self):
        super(self.__class__, self).__init__()
        self.core = "Cortex-M3"
        self.extra_labels = ['NXP']
        self.supported_toolchains = ["ARM", "GCC_ARM", "IAR"]

class ARDUINODUE(Target, object):
    def __init__(self):
        super(self.__class__, self).__init__()
        self.core = "Cortex-M3"
        self.extra_labels = ['Atmel', 'SAM']
        self.supported_toolchains = ["GCC_ARM"]
        self.default_toolchain = "GCC_ARM"
        self.macros = ['TARGET_SAM3X8E', '__SAM3X8E__', 'ARDUINO_DUE_X']
        self.target_directory = abspath(join(dirname(__file__), "../../lib/mbed/extra_targets"))

# Add Custom Targets to mbed build system
DOTBMED_TARGETS.append(TESTTARGET())
DOTBMED_TARGETS.append(ARDUINODUE())

# Refresh the Target Map
TARGETS = TARGETS + DOTBMED_TARGETS
TARGET_MAP = {}
for t in TARGETS:
    TARGET_MAP[t.name] = t
TARGET_NAMES = TARGET_MAP.keys()

# Debug list all targets
#from workspace_tools.targets import TARGETS
#from pprint import pprint as p
#p(TARGET_NAMES)
