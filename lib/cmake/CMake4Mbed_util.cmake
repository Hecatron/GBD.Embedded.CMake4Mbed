#
# CMake4Mbed
# https://github.com/grbd/GBD.Embedded.CMake4Mbed

# TODO macro for outputing .bin / .hex files

# Add a post-build dependency like printing size of the
# resulting binary and copying to the target.
#if (TOOLCHAIN STREQUAL "armcc")
#    add_custom_command(
#        TARGET ${MAIN_TARGET}
#        COMMAND ${SIZE_COMMAND} ${MAIN_TARGET}
#        COMMAND ${TOOLCHAIN_SYSROOT}/bin/fromelf --i32combined -o ${PROJECT_NAME}.hex ${MAIN_TARGET} # convert .elf to .hex (redundancy: only one of either .hex or .bin is needed)
#        COMMAND ${TOOLCHAIN_SYSROOT}/bin/fromelf --bin -o ${PROJECT_NAME}.bin ${MAIN_TARGET} # convert .elf to .bin
#        COMMAND srec_cat ${MBED_SRC_PATH}/targets/hal/TARGET_NORDIC/TARGET_MCU_NRF51822/Lib/s110_nrf51822_7_1_0/s110_nrf51822_7.1.0_softdevice.hex -intel ${PROJECT_NAME}.bin -binary -offset 0x16000 -o combined.hex -intel
#        # follow this by copying the resulting combined.hex onto the target (possibly over USB)
#    )
#elseif(TOOLCHAIN STREQUAL "armgcc")
#    if(${CMAKE_SYSTEM_NAME} MATCHES "Darwin")
#        set(CMAKE_CXX_LINK_FLAGS "")
#    endif()
#    add_custom_command(
#        TARGET ${MAIN_TARGET}
#        COMMAND ${SIZE_COMMAND} ${MAIN_TARGET}
#        COMMAND arm-none-eabi-objcopy -O ihex ${MAIN_TARGET} ${PROJECT_NAME}.hex # convert .elf to .hex (redundancy: only one of either .hex or .bin is needed)
#        COMMAND arm-none-eabi-objcopy -O binary ${MAIN_TARGET} ${PROJECT_NAME}.bin # convert .elf to .hex
#        COMMAND srec_cat ${MBED_SRC_PATH}/targets/hal/TARGET_NORDIC/TARGET_MCU_NRF51822/Lib/s110_nrf51822_7_1_0/s110_nrf51822_7.1.0_softdevice.hex -intel ${PROJECT_NAME}.bin -binary -offset 0x16000 -o combined.hex -intel
#        # follow this by copying the resulting combined.hex onto the target (possibly over USB)
#    )
#endif()
