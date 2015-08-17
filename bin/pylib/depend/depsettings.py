﻿"""
Represents the Depend settings
"""

# Always try to import cElementTree since it's faster if it exists
try:
    import xml.etree.cElementTree as ET
except ImportError:
    import xml.etree.ElementTree as ET

import platform
from os.path import join, abspath, exists
from pylib.logwrapper import LogWrapper
from pylib.depend.depsource import DepSource

# XML Settings for Download of Depends
class DependSettings(object):

    def __init__(self):
        """Dependency Settings"""
        super().__init__()
        self.log = LogWrapper.getlogger()

        # Path to the config file
        self.ConfigPath = None
        self.platform = None

        # XML Root Tag
        self.xmlroot = None

        # Directory properties
        self.DepsDirectory = ""
        self.ArchiveDirectory = ""
        self.GCCVersion = ""

        # List of Sources
        self.sources = []

    def read_element(self, tag):
        """Read XML Value Element"""
        nextval = next(self.xmlroot.iter(tag), None)
        if nextval == None : raise ValueError('Element not found: ' + tag)
        return nextval.text

    def loadxml(self):
        """Load XML"""
        # Load in the xml
        tree = ET.ElementTree(file=self.ConfigPath)
        self.xmlroot = tree.getroot()
        if self.xmlroot.tag != 'Settings':
            raise ValueError('Root Element is not Settings')

        # Directory Settings
        self.DepsDirectory = self.read_element('DepsDirectory')
        self.DepsDirectory = abspath(self.DepsDirectory)
        self.ArchiveDirectory = self.read_element('ArchiveDirectory')
        self.ArchiveDirectory = join(self.DepsDirectory, self.ArchiveDirectory)
        self.GCCVersion = self.read_element('GCCVersion')

        # Set the Archive directory for downloaded sources
        DepSource.ArchiveDir = self.ArchiveDirectory
        # Set the root Extract directory for extracting sources
        DepSource.RootExtractDir = self.DepsDirectory

        # Load in the list of download sources
        self.sources = DepSource.parsexml(self.xmlroot)
        return

    def getdeps(self):
        """Download and Extract Sources"""
        for source in self.sources:
            self.log.info("")
            self.log.info("#####################################################")

            # Skip anything already extracted
            extractdir = abspath(join(DepSource.RootExtractDir, source.destsubdir))
            if exists(extractdir):
                self.log.warn("Deps Subdir: " + source.destsubdir + " already exists, skipping")
                continue

            extracted = False
            downloaded = source.download()
            if downloaded == False:
                self.log.error("Download Failed")
            else:
                extracted = source.extract()

            # Remove the archive file
            if source.destsubdir != "atmel-asf":
                source.remove_archivefile()

        # Re-jig the directories for those that need it
        for source in self.sources:
            source.movetoparent_multiple()
        return

        # Check for ASF Sources
        if not exists(join(self.DepsDirectory, "atmel-asf")):
            self.log.warn("There was no Atmel ASF Archive file found")
            self.log.warn("asf is not required but you can manually download the below file for the Atmel Source")
            self.log.warn("http://www.atmel.com/tools/avrsoftwareframework.aspx?tab=overview")
            self.log.warn("So far this is only used for porting mbed to sam based mcu's")
        return

    def get_configpath(self):
        log = LogWrapper.getlogger()
        """Determine which config filename / path to use"""
        self.platform = platform.system()
        settingsfile = ""
        if self.platform == "Windows":
           settingsfile = "Settings_win32.xml"
        elif self.platform == "Linux":
            settingsfile = "Settings_linux.xml"
        else:
            log.critical("Unsupported platform")
            self.ConfigPath = None
        self.log.info("Platform identified as: " + self.platform)
        self.log.info("Settings file: " + settingsfile)
        self.ConfigPath = abspath(settingsfile)
        return self.ConfigPath
