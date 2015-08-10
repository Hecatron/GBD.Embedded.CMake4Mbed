#! /usr/bin/env python2
"""
Script used to build the project via cmake
"""

from os.path import join, abspath, dirname
import sys, os, shutil, subprocess

verbose = True

# Options for build
CMAKE_GENERATOR = "NMake Makefiles"
BUILD_CMD = ["nmake"]
CMAKE_TCFILE = "cmake/ToolChainOptions.cmake"
CMAKE_DEBUG = False

# Script / Source / Build directory
SCRIPTROOT = abspath(dirname(__file__))
SRCROOT = abspath(join(SCRIPTROOT,"../"))
BUILDROOT = abspath(join(SRCROOT,"Build"))

# Remove / Re-Create Build Directory
def clean_build( build_root ):
    print("Cleaning Build Directory")
    shutil.rmtree(build_root, ignore_errors=True)
    if not os.path.exists(build_root):
        os.makedirs(build_root)

# Run a command
def run_cmd( cmdarray, workingdir ):
    proc = subprocess.Popen(cmdarray, cwd=workingdir, stdout=subprocess.PIPE, stderr=subprocess.PIPE)
    proc_out, proc_err = proc.communicate()
    print(proc_out)
    print(proc_err)
    if proc.returncode != 0:
        raise RuntimeError("Failure to run command")
    return

# Main Script
try:
    # Clean Build Directory
    clean_build(BUILDROOT)

    # Run CMake
    print("Running cmake")
    cmake_toolchain_opt = "-DCMAKE_TOOLCHAIN_FILE=" + CMAKE_TCFILE
    cmake_gen_opt = "-G" + CMAKE_GENERATOR
    cmake_debug_opt = ""
    if CMAKE_DEBUG:
        cmake_debug_opt = "--debug-output --trace"
    print(cmake_toolchain_opt + " " + cmake_gen_opt + " " + cmake_debug_opt + " " + SRCROOT + "\n")
    run_cmd(["cmake", cmake_toolchain_opt, cmake_gen_opt, cmake_debug_opt, SRCROOT], BUILDROOT)

    # run nmake / ninja tools etc to build
    print("Building Sources")
    run_cmd(BUILD_CMD, BUILDROOT)

# Output any errors
except Exception as e:
    if verbose:
        import traceback
        traceback.print_exc(file=sys.stdout)
    print (e)
    sys.exit(1)



