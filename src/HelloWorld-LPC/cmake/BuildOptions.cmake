#
# CMake4Mbed
# https://github.com/grbd/GBD.Embedded.CMake4Mbed

# TODO mbed options for which parts of the lib to include

# TODO mbed is too complex to build via cmake alone for all targets
# setup an external call module to run mbed's python script to build the lib
# then just link against it
# need to use this http://www.cmake.org/cmake/help/v3.0/command/add_custom_command.html#command:add_custom_command


# CMAKE4MBED_DIR should resolve to the root directory of Cmake4Mbed
# CMAKE_CURRENT_LIST_DIR is the directory if this script
set (CMAKE4MBED_DIR "${CMAKE_CURRENT_LIST_DIR}/../../..")

# Set the required toolchain
set(TOOLCHAIN "armgcc")

# Set the required build type
# TODO - look into this one for the C Flags scripts
#set(CMAKE_BUILD_TYPE Release)
set(CMAKE_BUILD_TYPE Debug)

# Set the list of mbed targets we want to generate
set(MBED_USER_TARGETS "LPC1347" "NUCLEO_F103RB")

# Set mbed feature options
set(MBED_USER_RTOS 0)
set(MBED_USER_ETHERNET 0)
set(MBED_USER_USBHOST 0)
set(MBED_USER_USB 0)
set(MBED_USER_DSP 0)
set(MBED_USER_FAT 0)
set(MBED_USER_UBLOX 0)

# If to give verbose output during mbed compile
set(MBED_USER_VERBOSE 1)