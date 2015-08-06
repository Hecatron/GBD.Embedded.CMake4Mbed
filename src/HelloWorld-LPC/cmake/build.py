#! /usr/bin/env python2
"""
Script used to build the project via cmake
"""

from os.path import join, abspath, dirname
import sys, os, shutil, subprocess

verbose = True

try:
    # Script / Source / Build directory
    SCRIPTROOT = abspath(dirname(__file__))
    SRCROOT = abspath(join(SCRIPTROOT,"../"))
    BUILDROOT = abspath(join(SRCROOT,"Build"))

    # Remove  / Re-Create Build Directory
    print("Cleaning Build Directory")
    shutil.rmtree(BUILDROOT, ignore_errors=True)
    if not os.path.exists(BUILDROOT):
        os.makedirs(BUILDROOT)

    # Run CMake
    print("Calling cmake")
    cmake_opts = "-D CMAKE_TOOLCHAIN_FILE=cmake/ToolChainOptions.cmake"
    #cmake_opts = "--help"
    print(cmake_opts)

    cmake_proc = subprocess.Popen(["cmake", cmake_opts, SRCROOT], cwd=BUILDROOT, stdout=subprocess.PIPE, stderr=subprocess.PIPE)
    cmake_out, cmake_err = cmake_proc.communicate()
    print(cmake_out)
    print(cmake_err)
    if cmake_proc.returncode != 0:
        raise RuntimeError("Failure to run cmake")

    # TODO run make / ninja tools etc to build
    print("TODO Building Sources")
    # TODO

# Output any errors
except Exception, e:
    if verbose:
        import traceback
        traceback.print_exc(file=sys.stdout)
    print (e)
    sys.exit(1)
