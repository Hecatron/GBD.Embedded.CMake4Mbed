#
# CMake4Mbed
# https://github.com/grbd/GBD.Embedded.CMake4Mbed

# Declare minimum version of cmake required
cmake_minimum_required (VERSION 2.8)

# This adds a custom target to clean out any existing cmake build files / directories
# cmake clean-cmake

add_custom_target(clean-cmake
   COMMAND ${CMAKE_COMMAND} -P clean-all.cmake
)

// clean-all.cmake
set(cmake_generated ${CMAKE_BINARY_DIR}/CMakeCache.txt
                    ${CMAKE_BINARY_DIR}/cmake_install.cmake  
                    ${CMAKE_BINARY_DIR}/Makefile
                    ${CMAKE_BINARY_DIR}/CMakeFiles
)

foreach(file ${cmake_generated})
  if (EXISTS ${file})
     file(REMOVE_RECURSE ${file})
  endif()
endforeach(file)
