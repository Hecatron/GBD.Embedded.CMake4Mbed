#
# CMake4Mbed
# https://github.com/grbd/GBD.Embedded.CMake4Mbed
# sourced from https://developer.mbed.org/users/rgrover1/notebook/cmakegcc-based-offline-build-system-with-mbed-sour/

# Root Project cmake include file

# Declare minimum version of cmake required
cmake_minimum_required (VERSION 2.8)

# Include all other files required
include (CMake4Mbed_mbed)
include (CMake4Mbed_util)

# Location of the mbed source code root
set (MBED_ROOT_SRC_DIR "${CMAKE4MBED_DIR}/deps/mbed/")

# Allow the use of Assembler files
enable_language(ASM)





############################################################################
# Build type should be clear from here so we
# can continue with selecting include directors, defines
# and other compiler/linker flags ...
############################################################################
# include directories
#include_directories(
#    ${BLE_HEART_RATE_SOURCE_DIR}
#    ${MBED_SRC_PATH}/
#    ${MBED_SRC_PATH}/api
#    ${MBED_SRC_PATH}/common
#    ${MBED_SRC_PATH}/hal
#    ${MBED_SRC_PATH}/targets
#    ${MBED_SRC_PATH}/targets/cmsis
#    ${MBED_SRC_PATH}/targets/cmsis/TARGET_NORDIC
#    ${MBED_SRC_PATH}/targets/cmsis/TARGET_NORDIC/TARGET_MCU_NRF51822
#    ${MBED_SRC_PATH}/targets/hal
#    ${MBED_SRC_PATH}/targets/hal/TARGET_NORDIC
#    ${MBED_SRC_PATH}/targets/hal/TARGET_NORDIC/TARGET_MCU_NRF51822
#    ${MBED_SRC_PATH}/targets/hal/TARGET_NORDIC/TARGET_MCU_NRF51822/Lib
#    ${MBED_SRC_PATH}/targets/hal/TARGET_NORDIC/TARGET_MCU_NRF51822/TARGET_NRF51822_MKIT
#    ${BLE_API_SRC_PATH}
#    ${BLE_API_SRC_PATH}/public
#    ${BLE_API_SRC_PATH}/common
#    ${BLE_API_SRC_PATH}/services
#    ${NRF51822_SRC_PATH}
#    ${NRF51822_SRC_PATH}/btle
#    ${NRF51822_SRC_PATH}/btle/custom
#    ${NRF51822_SRC_PATH}/common
#    ${NRF51822_SRC_PATH}/nordic
#    ${NRF51822_SRC_PATH}/nordic/nrf-sdk
#    ${NRF51822_SRC_PATH}/nordic/nrf-sdk/app_common
#    ${NRF51822_SRC_PATH}/nordic/nrf-sdk/ble
#    ${NRF51822_SRC_PATH}/nordic/nrf-sdk/ble/ble_services
#    ${NRF51822_SRC_PATH}/nordic/nrf-sdk/ble/rpc
#    ${NRF51822_SRC_PATH}/nordic/nrf-sdk/s110
#    ${NRF51822_SRC_PATH}/nordic/nrf-sdk/sd_common
#    ${NRF51822_SRC_PATH}/nordic/nrf-sdk/bootloader_dfu
#)
#if (TOOLCHAIN STREQUAL "armcc")
#    include_directories(${MBED_SRC_PATH}/targets/cmsis/TARGET_NORDIC/TARGET_MCU_NRF51822/TOOLCHAIN_ARM_STD)
#elseif(TOOLCHAIN STREQUAL "armgcc")
#    include_directories(${MBED_SRC_PATH}/targets/cmsis/TARGET_NORDIC/TARGET_MCU_NRF51822/TOOLCHAIN_GCC_ARM)
#endif()


# TODO Look into different targets

# Generic compiler flags
#add_definitions(
#    -O2
#    -DTARGET_NRF51822
#    -DTARGET_M0
#    -DTARGET_NORDIC
#    -D__CORTEX_M0
#    -DARM_MATH_CM0
#    -D__MBED__=1
#    -DMBED_BUILD_TIMESTAMP=1399904910.34
#    -DMBED_USERNAME=rohgro01
#)




# TODO move some of this into the toolchain module

# Generic compiler flags
#add_definitions(
#    -O2
#    -DTARGET_NRF51822
#    -DTARGET_M0
#    -DTARGET_NORDIC
#    -D__CORTEX_M0
#    -DARM_MATH_CM0
#    -D__MBED__=1
#    -DMBED_BUILD_TIMESTAMP=1399904910.34
#    -DMBED_USERNAME=rohgro01
#)

#if (TOOLCHAIN STREQUAL "armcc")
#    add_definitions(
#        --cpu=Cortex-M0
#        --gnu
#        -Otime
#        --split_sections
#        --apcs=interwork
#        --brief_diagnostics
#        --restrict
#        --md
#        --no_depend_system_headers
#        -DTOOLCHAIN_ARM_STD
#        -DTOOLCHAIN_ARM
#    )
#
#    # Language specifc compiler flags.
#    set(CMAKE_CXX_FLAGS
#        "${CMAKE_CXX_FLAGS} --cpp --no_rtti")
#    set(CMAKE_C_FLAGS
#        "${CMAKE_C_FLAGS} --c99")
#elseif(TOOLCHAIN STREQUAL "armgcc")
#    add_definitions(
#        -mcpu=cortex-m0
#        -mthumb
#        -Wall
#        -Wextra
#        -Wno-unused-parameter
#        -Wno-missing-field-initializers
#        -Wno-error=switch
#        -Wno-switch
#        -Wa,-adhlns=$@.lst
#        -fmessage-length=0
#        -fno-builtin
#        -ffunction-sections
#        -fdata-sections
#        -fno-delete-null-pointer-checks
#        -fomit-frame-pointer
#        -fno-common
#        -funsigned-bitfields
#        -DTOOLCHAIN_GCC_ARM
#        -DTOOLCHAIN_GCC
#        -DTARGET_NRF51822_MKIT
#        -DTARGET_MCU_NRF51822
#        -DTARGET_MCU_NORDIC_16K
#    )
#
#    # Language specifc compiler flags.
#    set(CMAKE_CXX_FLAGS
#        "${CMAKE_CXX_FLAGS} -std=gnu++98 -fno-rtti -fno-exceptions -fno-threadsafe-statics")
#    set(CMAKE_C_FLAGS
#        "${CMAKE_C_FLAGS} -std=gnu99 -Wno-pointer-sign -Wno-pointer-to-int-cast")
#    set(CMAKE_ASM_FLAGS
#        "${COMMON_COMPILE_FLAGS} -x assembler-with-cpp")
#
#    SET(CMAKE_SHARED_LIBRARY_LINK_CXX_FLAGS
#        -T${MBED_SRC_PATH}/targets/cmsis/TARGET_NORDIC/TARGET_MCU_NRF51822/TOOLCHAIN_GCC_ARM/TARGET_MCU_NORDIC_16K/NRF51822.ld)
#    SET(CMAKE_SHARED_LIBRARY_LINK_CXX_FLAGS
#        "${CMAKE_SHARED_LIBRARY_LINK_CXX_FLAGS} -Wl,--gc-sections -Wl,--wrap,main -Wl,-Map=${PROJECT_NAME}.map -mcpu=cortex-m0 -mthumb --specs=nano.specs -lstdc++ -lsupc++ -lm -lc -lgcc -lnosys -lstdc++ -lsupc++ -lm -lc -lgcc -lnosys")
#endif()



# Use file globbing to collect all sources from external repositories. File-
# globbing is discouraged by CMake, except when collecting sources from an
# external source which remains mostly frozen. The risk with globbing is that
# CMake doesn't automatically update the makefiles if new sources are added to
# the globbed location.
#
#file(GLOB MBED_SRC_SOURCES
#          ${MBED_SRC_PATH}/common/*.c
#          ${MBED_SRC_PATH}/common/*.cpp
#          ${MBED_SRC_PATH}/targets/cmsis/TARGET_NORDIC/TARGET_MCU_NRF51822/*.c
#          ${MBED_SRC_PATH}/targets/hal/TARGET_NORDIC/TARGET_MCU_NRF51822/*.c
#          ${MBED_SRC_PATH}/targets/hal/TARGET_NORDIC/TARGET_MCU_NRF51822/Lib/app_common/*.c
#    )
#add_sources(${MBED_SRC_SOURCES})
#if (TOOLCHAIN STREQUAL "armcc")
#    add_sources(${MBED_SRC_PATH}/targets/cmsis/TARGET_NORDIC/TARGET_MCU_NRF51822/TOOLCHAIN_ARM_STD/sys.cpp)
#elseif(TOOLCHAIN STREQUAL "armgcc")
#    #add_sources(${MBED_SRC_PATH}/targets/cmsis/TARGET_NORDIC/TARGET_MCU_NRF51822/TOOLCHAIN_GCC_ARM/sys.cpp)
#endif()



# TODO External Lib not used here

#file(GLOB BLE_API_SOURCES
#          ${BLE_API_SRC_PATH}/common/*.cpp
#          ${BLE_API_SRC_PATH}/services/*.cpp
#    )
#add_sources(${BLE_API_SOURCES})
#file(GLOB NRF51822_SOURCES
#          ${NRF51822_SRC_PATH}/*.cpp
#          ${NRF51822_SRC_PATH}/btle/*.cpp
#          ${NRF51822_SRC_PATH}/btle/custom/*.cpp
#          ${NRF51822_SRC_PATH}/nordic/*.cpp
#          ${NRF51822_SRC_PATH}/nordic/app_common/*.cpp
#          ${NRF51822_SRC_PATH}/nordic/ble/*.cpp
#          ${NRF51822_SRC_PATH}/nordic/ble/ble_services/*.cpp
#          ${NRF51822_SRC_PATH}/nordic/bootloader_dfu/*.c
#    )
#add_sources(${NRF51822_SOURCES})

#if (TOOLCHAIN STREQUAL "armcc")
#    add_sources(${MBED_SRC_PATH}/targets/cmsis/TARGET_NORDIC/TARGET_MCU_NRF51822/TOOLCHAIN_ARM_STD/TARGET_MCU_NORDIC_16K/startup_nRF51822.s)
#elseif(TOOLCHAIN STREQUAL "armgcc")
#    add_sources(${MBED_SRC_PATH}/targets/cmsis/TARGET_NORDIC/TARGET_MCU_NRF51822/TOOLCHAIN_GCC_ARM/startup_NRF51822.s)
#endif()
