"""
Represents tool chain settings
"""

# TODO copy of LPC13XX renamed for testing
class TCSettings(object):
    def __init__(self):
        super(self.__class__, self).__init__()
        self.ArchiveDirectory = ""
        self.ASFArchive = ""
        self.ASFRootDir = ""
