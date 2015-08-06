@echo off

REM Script for Calling cmake
REM first change directory to where we want the build output
cd Build

REM Next run cmake referencing the CMakeLists.txt file in the project
cmake -D CMAKE_TOOLCHAIN_FILE=cmake/ToolChainOptions.cmake ..\

REM TODO look into make / ninja tools next
REM make

REM return to source dir
cd ..
