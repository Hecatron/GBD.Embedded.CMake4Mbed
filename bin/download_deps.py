#! /usr/bin/env python2
"""
This script can be used to download depends required for cmake mbed
"""

from scripts.dep_settings import DependSettings
from os.path import join, abspath, dirname
import wget, sys

verbose = True

try:
    ROOT = abspath(dirname(__file__))
    SETTINGS_PATH = abspath('DependSettings.xml')

    # Load in the Settings from an xml file
    Setts = DependSettings.loadxml(SETTINGS_PATH)

    wget.download('https://raw.githubusercontent.com/grbd/GBD.Embedded.DotMbed/master/License.md', out=ROOT)

# Output any errors
except Exception, e:
    if verbose:
        import traceback
        traceback.print_exc(file=sys.stdout)
    print (e)
    sys.exit(1)
