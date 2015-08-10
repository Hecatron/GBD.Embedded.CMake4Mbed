#
# CMake4Mbed
# https://github.com/grbd/GBD.Embedded.CMake4Mbed

# This macro adds a custom command to the target to compile mbed first
macro (mbed_buildcmd targarg devarg)

    # Set the working directory for the mbed build script
    set (MBED_COMPILE_CMD_WORKDIR "${CMAKE4MBED_DIR}/bin/workspace_tools")
    #set (MBED_COMPILE_CMD_WORKDIR "${CMAKE4MBED_DIR}/deps/mbed/workspace_tools")

    # Make path absolute
    get_filename_component(MBED_COMPILE_CMD_WORKDIR ${MBED_COMPILE_CMD_WORKDIR} REALPATH)

    #Set the bin for the mbed build script
    set (MBED_COMPILE_CMD "${MBED_COMPILE_CMD_WORKDIR}/build.py")

    # Set the mbed options
    set (MBED_COMPILE_OPTS "")

    # Set the mbed device target
    LIST(APPEND MBED_COMPILE_OPTS "--mcu=${devarg}")

    # Set the toolchain in use
    if(TOOLCHAIN STREQUAL "armgcc")
        # GCC
        LIST(APPEND MBED_COMPILE_OPTS "--tool=GCC_ARM")
    elseif (TOOLCHAIN STREQUAL "armcc")
        # ARMCC
        LIST(APPEND MBED_COMPILE_OPTS "--tool=ARM")
    endif()

    # Set optional library components
    if (MBED_USER_RTOS)
        LIST(APPEND MBED_COMPILE_OPTS "--rtos")
    endif()
    if (MBED_USER_ETHERNET)
        LIST(APPEND MBED_COMPILE_OPTS "--eth")
    endif()
    if (MBED_USER_USBHOST)
        LIST(APPEND MBED_COMPILE_OPTS "--usb_host")
    endif()
    if (MBED_USER_USB)
        LIST(APPEND MBED_COMPILE_OPTS "--usb")
    endif()
    if (MBED_USER_DSP)
        LIST(APPEND MBED_COMPILE_OPTS "--dsp")
    endif()
    if (MBED_USER_FAT)
        LIST(APPEND MBED_COMPILE_OPTS "--fat")
    endif()
    if (MBED_USER_UBLOX)
        LIST(APPEND MBED_COMPILE_OPTS "--ublox")
    endif()

    # If to set the verbose flag
    if (MBED_USER_VERBOSE)
        LIST(APPEND MBED_COMPILE_OPTS "--verbose")
    endif()

    # The entire build directory for the target is wiped anyway
    # so we don't need to clean the mbed build directory
    # as long as it's located within the main source build directory

    # TODO set Build directory destination within main source tree
    # TODO other options in the gcc4mbed makefile like Debug / Release
    # Try setting the options in private_settings.py via env variables or additional parameters perhaps (assuming this doesn't interfere with the original script
    # may need to strip the additional params out of the options via the wrapper script
    # look into monkey patching the options parse code

    string(REPLACE ";" " " MBED_COMPILE_OPTS_STR "${MBED_COMPILE_OPTS}")
    message(STATUS "MBED_COMPILE_OPTS: ${MBED_COMPILE_OPTS_STR}")
    #message(STATUS "MBED_COMPILE_CMD_WORKDIR: ${MBED_COMPILE_CMD_WORKDIR}")

    # Add a custom target before the main build target that compiles mbed
    add_custom_target(${targarg}-${devarg}
        COMMAND ${MBED_COMPILE_CMD} ${MBED_COMPILE_OPTS}
        WORKING_DIRECTORY ${MBED_COMPILE_CMD_WORKDIR}
        COMMENT "Compiling mbed for mbed target ${devarg}"
	VERBATIM
    )
    add_dependencies(${targarg} ${targarg}-${devarg})

endmacro()
