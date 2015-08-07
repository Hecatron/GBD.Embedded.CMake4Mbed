#
# CMake4Mbed
# https://github.com/grbd/GBD.Embedded.CMake4Mbed

# Declare minimum version of cmake required
cmake_minimum_required (VERSION 2.8)

# Output the path to the toolchain file
# The toolchain file is read in and processed before this script
message(STATUS "CMAKE_TOOLCHAIN_FILE='${CMAKE_TOOLCHAIN_FILE}'")
message(STATUS "")

# Set options for CMake4Mbed
include("${CMAKE_CURRENT_LIST_DIR}/cmake/BuildOptions.cmake")

# Include Cmake4Mbed into the cmake module path
set(CMAKE_MODULE_PATH "${CMAKE4MBED_DIR}/lib/cmake/" ${CMAKE_MODULE_PATH})

# Include CMake4Mbed libs
include(CMake4Mbed)

# Include Project Files
include("${CMAKE_CURRENT_LIST_DIR}/cmake/ProjectFiles.cmake")
