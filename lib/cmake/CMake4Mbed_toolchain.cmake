#
# CMake4Mbed
# https://github.com/grbd/GBD.Embedded.CMake4Mbed

# ToolChain Macro's

# This macro sets up the toolchain variables for mbed
macro(SetupToolChain)

    # Bypass the internal checks for a compiler
    include(CMakeForceCompiler)

    # Set the target system processor to arm
    set(CMAKE_SYSTEM_PROCESSOR arm)

    # Generic is used for Embedded systems
    set(CMAKE_SYSTEM_NAME Generic)

    # We can't use CMAKE_EXECUTABLE_SUFFIX since we're cross compiling under Windows in some cases
    # And this variable relates to the target instead of the host
    # But we can use CMAKE_HOST_SYSTEM_NAME to determine if the toolchain files end in .exe

    set(HOST_EXE_SUFFIX "")
    if (CMAKE_HOST_SYSTEM_NAME STREQUAL "Windows")
        set(HOST_EXE_SUFFIX ".exe")
    endif()

    # ToolChain directory
    set(TOOLCHAIN_SYSROOT "${CMAKE4MBED_DIR}/deps/gcc-arm-none-eabi")

    # Override toolchain exe's
    CMAKE_FORCE_C_COMPILER   ("${TOOLCHAIN_SYSROOT}/bin/arm-none-eabi-gcc${HOST_EXE_SUFFIX}" GNU)
    CMAKE_FORCE_CXX_COMPILER ("${TOOLCHAIN_SYSROOT}/bin/arm-none-eabi-g++${HOST_EXE_SUFFIX}" GNU)
    set(SIZE_COMMAND          "${TOOLCHAIN_SYSROOT}/bin/arm-none-eabi-size${HOST_EXE_SUFFIX}")
    set(OBJCOPY_COMMAND       "${TOOLCHAIN_SYSROOT}/bin/arm-none-eabi-objcopy${HOST_EXE_SUFFIX}")

    message(STATUS "ToolChain Variables Set")
    #message(STATUS "HOST_EXE_SUFFIX: ${HOST_EXE_SUFFIX}")
    #message(STATUS "CMAKE_FORCE_C_COMPILER: ${CMAKE_FORCE_C_COMPILER}")
    #message(STATUS "CMAKE_FORCE_CXX_COMPILER: ${CMAKE_FORCE_CXX_COMPILER}")
    #message(STATUS "SIZE_COMMAND: ${SIZE_COMMAND}")
    #message(STATUS "OBJCOPY_COMMAND: ${OBJCOPY_COMMAND}")

endmacro()








# This macro sets up the toolchain variables based on the set options
macro(SetupToolChain2)

    # Custom 
    if (TOOLCHAIN STREQUAL "custom")
        # TODO Check definitions have been set

	if(NOT DEFINED CMAKE_CXX_COMPILER)
            message( FATAL_ERROR "For Custom Toolchain, CMAKE_CXX_COMPILER must be defined" )
        endif()
	if(NOT DEFINED CMAKE_C_COMPILER)
            message( FATAL_ERROR "For Custom Toolchain, CMAKE_C_COMPILER must be defined" )
        endif()
	if(NOT DEFINED SIZE_COMMAND)
            message( FATAL_ERROR "For Custom Toolchain, SIZE_COMMAND must be defined" )
        endif()

    # GCC for Arm
    elseif(TOOLCHAIN STREQUAL "armgcc")
	set(TOOLCHAIN_SYSROOT "${CMAKE4MBED_DIR}/deps/gcc-arm-none-eabi")
        set(CMAKE_CXX_COMPILER "${TOOLCHAIN_SYSROOT}/bin/arm-none-eabi-g++${CMAKE_EXECUTABLE_SUFFIX}")
        set(CMAKE_C_COMPILER   "${TOOLCHAIN_SYSROOT}/bin/arm-none-eabi-gcc${CMAKE_EXECUTABLE_SUFFIX}")
        set(SIZE_COMMAND       "${TOOLCHAIN_SYSROOT}/bin/arm-none-eabi-size${CMAKE_EXECUTABLE_SUFFIX}")
        set(OBJCOPY_COMMAND    "${TOOLCHAIN_SYSROOT}/bin/arm-none-eabi-objcopy${CMAKE_EXECUTABLE_SUFFIX}")

    # ARM CC
    # TODO this is currently hardcoded for one specific device target
    elseif (TOOLCHAIN STREQUAL "armcc")
        set(TOOLCHAIN_SYSROOT "${CMAKE4MBED_DIR}/deps/ARMCompiler")
        set(CMAKE_CXX_COMPILER "${TOOLCHAIN_SYSROOT}/bin/armcc${CMAKE_EXECUTABLE_SUFFIX}")
        set(CMAKE_C_COMPILER   "${TOOLCHAIN_SYSROOT}/bin/armcc${CMAKE_EXECUTABLE_SUFFIX}")
        set(SIZE_COMMAND       "size${CMAKE_EXECUTABLE_SUFFIX}")
        SET(CMAKE_CXX_LINK_FLAGS "--libpath=${TOOLCHAIN_SYSROOT}/lib --info=totals --list=.link_totals.txt ")
	SET(CMAKE_CXX_LINK_FLAGS ${CMAKE_CXX_LINK_FLAGS} "--scatter ${MBED_SRC_PATH}/targets/cmsis/TARGET_NORDIC/TARGET_MCU_NRF51822/TOOLCHAIN_ARM_STD/TARGET_MCU_NORDIC_16K/nRF51822.sct")
	SET(CMAKE_CXX_LINK_EXECUTABLE "${TOOLCHAIN_SYSROOT}/bin/armlink${CMAKE_EXECUTABLE_SUFFIX} <CMAKE_CXX_LINK_FLAGS> <OBJECTS> -o <TARGET>")

    else()
        message(FATAL_ERROR "failed to match against known toolchains")
    
    endif()

    message(STATUS "C++ compiler: ${CMAKE_CXX_COMPILER}")
    message(STATUS "C compiler  : ${CMAKE_C_COMPILER}")
    message(STATUS "Size command: ${SIZE_COMMAND}")
    message(STATUS "Objcopy command: ${OBJCOPY_COMMAND}")
endmacro()

