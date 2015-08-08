#
# CMake4Mbed
# https://github.com/grbd/GBD.Embedded.CMake4Mbed

# This macro adds a custom command to the target to compile mbed first
macro (mbed_buildcmd targarg devarg)

    # Set the working directory for the mbed build script
    set (MBED_COMPILE_CMD_WORKDIR "${CMAKE4MBED_DIR}/bin/workspace_tools")
    #set (MBED_COMPILE_CMD_WORKDIR "${CMAKE4MBED_DIR}/deps/mbed/workspace_tools")

    #Set the bin for the mbed build script
    set (MBED_COMPILE_CMD "${MBED_COMPILE_CMD_WORKDIR}/build.py")

    # Set the mbed options
    set (MBED_COMPILE_OPTS "")

    # Set the mbed device target
    set (MBED_COMPILE_OPTS "${MBED_COMPILE_OPTS} --mcu=${devarg}")

    # Set the toolchain in use
    if(TOOLCHAIN STREQUAL "armgcc")
        # GCC
        set (MBED_COMPILE_OPTS "${MBED_COMPILE_OPTS} --tool=GCC_ARM")
    elseif (TOOLCHAIN STREQUAL "armcc")
        # ARMCC
        set (MBED_COMPILE_OPTS "${MBED_COMPILE_OPTS} --tool=ARM")
    endif()

    # Set optional library components
    if (MBED_USER_RTOS)
        set (MBED_COMPILE_OPTS "${MBED_COMPILE_OPTS} --rtos")
    endif()
    if (MBED_USER_ETHERNET)
        set (MBED_COMPILE_OPTS "${MBED_COMPILE_OPTS} --eth")
    endif()
    if (MBED_USER_USBHOST)
        set (MBED_COMPILE_OPTS "${MBED_COMPILE_OPTS} --usb_host")
    endif()
    if (MBED_USER_USB)
        set (MBED_COMPILE_OPTS "${MBED_COMPILE_OPTS} --usb")
    endif()
    if (MBED_USER_DSP)
        set (MBED_COMPILE_OPTS "${MBED_COMPILE_OPTS} --dsp")
    endif()
    if (MBED_USER_FAT)
        set (MBED_COMPILE_OPTS "${MBED_COMPILE_OPTS} --fat")
    endif()
    if (MBED_USER_UBLOX)
        set (MBED_COMPILE_OPTS "${MBED_COMPILE_OPTS} --ublox")
    endif()

    # If to set the verbose flag
    if (MBED_USER_VERBOSE)
        set (MBED_COMPILE_OPTS "${MBED_COMPILE_OPTS} --verbose")
    endif()

    # The entire build directory for the target is wiped anyway
    # so we don't need to clean the mbed build directory
    # as long as it's located within the main source build directory

    # TODO set Build directory destination within main source tree
    # TODO gcc path not being picked up for some reason
    # TODO other options in the gcc4mbed makefile like Debug / Release

    message(STATUS "MBED_COMPILE_OPTS: ${MBED_COMPILE_OPTS}")

    # Add a custom target before the main build target that compiles mbed
    add_custom_target(
        ${targarg}-${devarg}
        COMMAND ${MBED_COMPILE_CMD} ${MBED_COMPILE_OPTS}
	WORKING_DIRECTORY ${MBED_COMPILE_CMD_WORKDIR}
    )
    add_dependencies(${targarg} ${targarg}-${devarg})

endmacro()
