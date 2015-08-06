"""
Module for dependency targets
"""

import wget

# Target Base Class
class Target(object):
    def __init__(self, destdir):
        super(self.__class__, self).__init__()
        self.destdir = destdir

    def download(self):
        print("Download not Implemented")

    def extract(self):
        print("Extraction not Implemented")

# Http Download Class
class HttpTarget(Target):
    def __init__(self, destdir, httpurl):
        super(self.__class__, self).__init__(destdir)
        self.url = httpurl

    def download(self):
        print("Downloading :" + self.url)
        wget.download(self.url, out=self.destdir)
        
    def extract(self):
        print("Extraction not Implemented")


# XML Settings for Download of Depends
class GitHubZipTarget(object):
    def __init__(self):
        """Default Class Constructor"""
        super(self.__class__, self).__init__()