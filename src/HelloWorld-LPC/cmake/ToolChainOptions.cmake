#
# CMake4Mbed
# https://github.com/grbd/GBD.Embedded.CMake4Mbed

# Cross Platform ARM Toolchain script
# Pass the path to this file into cmake via cmake -DCMAKE_TOOLCHAIN_FILE=<file>
# This script is special in that it overrides the toolchain compiler target settings for cmake
# before any other scripts including the main one are run
# See http://www.cmake.org/Wiki/CMake_Cross_Compiling

# Set options for CMake4Mbed
include("${CMAKE_CURRENT_LIST_DIR}/BuildOptions.cmake")

# Include the toolschain macros file
include("${CMAKE4MBED_DIR}/lib/cmake/CMake4Mbed_toolchain.cmake")

# Setup the ToolChain variables
SetupToolChain()
