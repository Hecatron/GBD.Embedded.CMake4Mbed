#
# CMake4Mbed
# https://github.com/grbd/GBD.Embedded.CMake4Mbed

# TODO list of mbed Targets
# TODO mbed options for which parts of the lib to include

# CMAKE4MBED_DIR should resolve to the root directory of Cmake4Mbed
# CMAKE_CURRENT_LIST_DIR is the directory if this script
set (CMAKE4MBED_DIR "${CMAKE_CURRENT_LIST_DIR}/../../..")

# Set the required toolchain
set(TOOLCHAIN "armgcc")
