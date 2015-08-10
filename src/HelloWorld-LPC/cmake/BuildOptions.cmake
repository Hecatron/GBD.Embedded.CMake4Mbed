#
# CMake4Mbed
# https://github.com/grbd/GBD.Embedded.CMake4Mbed

# TODO mbed options for which parts of the lib to include

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
set(MBED_USER_VERBOSE 0)