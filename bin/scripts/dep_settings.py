"""
Represents the Depend settings
"""

# Always try to import cElementTree since it's faster if it exists
try:
    import xml.etree.cElementTree as ET
except ImportError:
    import xml.etree.ElementTree as ET

from os.path import join, abspath, dirname

# XML Settings for Download of Depends
class DependSettings(object):
    def __init__(self):
        """Default Class Constructor"""
        super(self.__class__, self).__init__()
        
        # Directory properties
        self.DepsDirectory = ""
        self.ArchiveDirectory = ""

        # ASF Properties
        self.ASFDirectory = ""
        self.ASFFile = ""

        # GCC Properties
        self.GCCVersion = ""
        self.GCCFileName = ""
        self.GCCUrl = ""
        self.GCCRootDir = ""

    @staticmethod
    def loadxml(filepath):
        ret = DependSettings()
        """Load Xml File into Settings class"""
        tree = ET.ElementTree(file=filepath)
        root = tree.getroot()
        if root.tag != 'DependSettings':
            raise ValueError('Root Element is not DependSettings')

        # Directory Settings
        ret.DepsDirectory = DependSettings.read_element(root, 'DepsDirectory')
        ret.DepsDirectory = abspath(ret.DepsDirectory)
        ret.ArchiveDirectory = DependSettings.read_element(root, 'ArchiveDirectory')
        ret.ArchiveDirectory = join(ret.DepsDirectory, ret.ArchiveDirectory)
        
        # ASF Settings
        ret.ASFDirectory = DependSettings.read_element(root, 'ASFDirectory')
        ret.ASFDirectory = join(ret.DepsDirectory, ret.ASFDirectory)
        ret.ASFFile = DependSettings.read_element(root, 'ASFFile')

        # GCC Settings
        ret.GCCVersion = DependSettings.read_element(root, 'GCCVersion')
        ret.GCCFileName = DependSettings.read_element(root, 'GCCFileName')
        ret.GCCUrl = DependSettings.read_element(root, 'GCCUrl')
        ret.GCCRootDir = DependSettings.read_element(root, 'GCCRootDir')
        ret.GCCRootDir = abspath(ret.GCCRootDir)




        #ret.DepsDirectory = next(root.iter('DepsDirectory'), None)
        #if not ret.DepsDirectory 
        return ret

    @staticmethod
    def read_element(root, tag):
        nextval = next(root.iter(tag), None)
        if nextval == None : raise ValueError('Element not found: ' + tag)
        return nextval.text
