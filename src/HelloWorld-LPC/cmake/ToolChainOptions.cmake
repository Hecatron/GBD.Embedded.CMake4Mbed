#
# CMake4Mbed
# https://github.com/grbd/GBD.Embedded.CMake4Mbed

# Cross Platform ARM Toolchain script
# Pass the path to this file into cmake via cmake -D CMAKE_TOOLCHAIN_FILE=<file>
# This script is special in that it overrides the toolchain compiler settings for cmake
# before any other scripts including the main one are run
# See http://www.cmake.org/Wiki/CMake_Cross_Compiling

# Bypass the internal checks for a compiler
include(CMakeForceCompiler)

# Set the systm processor to arm
set(CMAKE_SYSTEM_PROCESSOR arm)

# Generic is used for Embedded systems
set(CMAKE_SYSTEM_NAME Generic)

# Set options for CMake4Mbed
include("${CMAKE_CURRENT_LIST_DIR}/BuildOptions.cmake")

# Path to the toolchain exes TODO
set(CMAKE_FIND_ROOT_PATH "${CMAKE4MBED_DIR}/deps/gcc-arm-none-eabi")




# Include the toolschain macros file
#include("${CMAKE4MBED_DIR}/lib/cmake/CMake4Mbed_toolchain.cmake")

# Setup the ToolChain variables
#SetupToolChain()

