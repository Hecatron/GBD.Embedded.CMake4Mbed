#
# CMake4Mbed
# https://github.com/grbd/GBD.Embedded.CMake4Mbed

# TODO this file needs to be auto generated via an export_targets.py script
# which will read the mbed targets in and output to this file

# This macro defines the per device C Flags
macro (mbed_defines targarg devarg)
    
    # Alow the user to set the CFlags needed 
    if(devarg STREQUAL "empty")

    # LPC1347 mbed device target
    elseif(devarg STREQUAL "LPC1347")

        set (MBED_DEVICE_TARGET "LPC1347")
        set (MBED_BUILD_DIR "NXP_LPC1347")
        set (MBED_COMPILER_TARGETS "TARGET_LPC1347" "TARGET_M3" "TARGET_NXP" "TARGET_LPC13XX" "TARGET_CORTEX_M")
        set (MBED_COMPILER_DEFLIST ${MBED_CPP_TARGETS "__CORTEX_M3" "ARM_MATH_CM3")

	# Add the above defines in
	set (MBED_COMPILER_DEF "")
	foreach(DEFINE MBED_COMPILER_DEFINES)
            set (MBED_COMPILER_DEFS ${MBED_COMPILER_DEFS} " -D" DEFINE)
	endforeach()

        message(STATUS "Setting per mbed device defnitions")
        message(STATUS "Exe: ${targarg}")
        message(STATUS "Mbed Target: ${devarg}")
        message(STATUS "MBed Target Definitions: ${MBED_COMPILER_DEF}")
	#target_compile_definitions(targarg PUBLIC ${MBED_COMPILER_DEF})

        # TODO
	
	#target_compile_options(mylib PUBLIC -DUSEXX)  # Bad

        #target_compile_definitions(mylib PUBLIC -DUSEXX)  # OK
	#set_target_properties(mylib PROPERTIES LINK_FLAGS "")

        #GCC_DEFINES := $(patsubst %,-D%,$(TARGETS_FOR_DEVICE))

        #C_FLAGS   := -mcpu=cortex-m3 -mthumb -mthumb-interwork
        #ASM_FLAGS := -mcpu=cortex-m3 -mthumb
        #LD_FLAGS  := -mcpu=cortex-m3 -mthumb

        # Linker script to be used.  Indicates what code should be placed where in memory.
        #LSCRIPT=$(GCC4MBED_DIR)/deps/mbed/libraries/mbed/targets/cmsis/TARGET_NXP/TARGET_LPC13XX/TOOLCHAIN_GCC_ARM/LPC1347.ld

    endif()
endmacro()


