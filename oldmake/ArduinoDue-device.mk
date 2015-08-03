# Custom scripts for LPCExpresso LPC1347
# See https://github.com/adamgreen/gcc4mbed/blob/master/notes/new_devices.creole

# Vendor/device for which the library should be built.

# Name - custom name for gcc4mbed scripts
MBED_DEVICE        := ArduinoDue

# Target - destination build directory I think
MBED_TARGET        := Atmel_ArduinoDue

# TODO Copy from build.py
# Compiler flags which are specifc to this device.
TARGETS_FOR_DEVICE := TARGET_LPC1347 TARGET_M3 TARGET_NXP TARGET_LPC13XX TARGET_CORTEX_M

# TODO Copy from build.py
# Arm Device type 
GCC_DEFINES := $(patsubst %,-D%,$(TARGETS_FOR_DEVICE))
GCC_DEFINES += -D__CORTEX_M3 -DARM_MATH_CM3
C_FLAGS   := -mcpu=cortex-m3 -mthumb -mthumb-interwork
ASM_FLAGS := -mcpu=cortex-m3 -mthumb
LD_FLAGS  := -mcpu=cortex-m3 -mthumb

# Extra platform specific object files to link into file binary.
DEVICE_OBJECTS :=

# Version of MRI library to use for this device.
# DEVICE_MRI_LIB := $(GCC4MBED_DIR)/mri/libmri_mbed1768.a
DEVICE_MRI_LIB :=

# Linker script to be used.  Indicates what code should be placed where in memory.
LSCRIPT=$(GCC4MBED_DIR)/lib/mbed/extra_targets/cmsis/TARGET_Atmel/TARGET_ARDUINODUE/TOOLCHAIN_GCC_ARM/ARDUINODUE.ld

# Common Defines
MBED_CLEAN         := $(MBED_DEVICE)-MBED-clean
include $(GCC4MBED_DIR)/oldmake/device-common.mk
