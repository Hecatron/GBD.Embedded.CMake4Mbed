"""
Represents the Depend settings
"""

# Always try to import cElementTree since it's faster if it exists
try:
    import xml.etree.cElementTree as ET
except ImportError:
    import xml.etree.ElementTree as ET

import os, shutil
from os.path import join, abspath, dirname
from scripts.dep_sources import DepSource
from scripts.script_logs import ScriptLogs

# XML Settings for Download of Depends
class DependSettings(object):

    def __init__(self):
        """Default Class Constructor"""
        super().__init__()
        self.log = ScriptLogs.getlogger()

        # XML Root Tag
        self.xmlroot = None

        # Directory properties
        self.DepsDirectory = ""
        self.ArchiveDirectory = ""
        self.GCCVersion = ""

        # List of Sources
        self.sources = []

    def read_element(self, tag):
        """Read XML Value"""
        nextval = next(self.xmlroot.iter(tag), None)
        if nextval == None : raise ValueError('Element not found: ' + tag)
        return nextval.text

    def loadxml(self, filepath):
        """Load XML"""
        # Load in the xml
        tree = ET.ElementTree(file=filepath)
        self.xmlroot = tree.getroot()
        if self.xmlroot.tag != 'DependSettings':
            raise ValueError('Root Element is not DependSettings')

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

    def download(self):
        """Download Sources"""
        for source in self.sources:
            source.download()
        return

    def extract(self):
        """Extract Sources"""
        for source in self.sources:
            source.extract()

        # Check for ASF Sources
        if not os.path.exists(join(self.DepsDirectory, "atmel-asf")):
            self.log.warn("There was no Atmel ASF Archive file found")
            self.log.warn("asf is not required but you can manually download the file from http://www.atmel.com/tools/avrsoftwareframework.aspx?tab=overview for Atmel Source")
            self.log.warn("So far this is only used for porting mbed to sam based mcu's")
        else:
            self.moveasfdir()
        return

    def moveasfdir(self):
        """Move ASF sub directory"""
        asfdir = os.path.abspath(join(self.DepsDirectory, "atmel-asf"))
        olddir = asfdir + "_old"
        if os.path.exists(olddir):
            shutil.rmtree(olddir)
        os.rename(asfdir, olddir)
        
        # Relocate the inner directory
        innerdir = os.listdir(olddir)[0]
        innerdir = os.path.join(olddir, innerdir)
        shutil.move(innerdir ,asfdir)
        shutil.rmtree(olddir)
        return