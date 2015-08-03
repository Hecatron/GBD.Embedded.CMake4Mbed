
# TODO try running this before calling build.py to see if it overrides the default settings

from os.path import join, abspath, dirname

# Get our root directory
OVERRIDE_ROOT = abspath(join(dirname(__file__), ".."))

# Specfy the path to the gcc executables
GCC_ARM_PATH = abspath("../../deps/gcc-arm-none-eabi/bin")

# Override the output build directory
#BUILD_DIR = abspath(join(OVERRIDE_ROOT, "build"))
BUILD_DIR = abspath(join(OVERRIDE_ROOT, "../build"))

# TODO add additional include directories for Atmel Arduino Due ASF libs
# To BUILD_OPTIONS

IncPath1 = abspath("../../deps/atmel-asf/sam/utils")

BUILD_OPTIONS = ['-I' + IncPath1]
