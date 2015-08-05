"""
Module for dependency targets
"""

import wget

# Target Base Class
class Target(object):
    def __init__(self):
        super(self.__class__, self).__init__()
        self.url = ""

    def download(self):
        print("Download not Implemented")

    def extract(self):
        print("Extraction not Implemented")



# Http Download Class
class HttpTarget(Target):
    def __init__(self, httpurl):
        super(self.__class__, self).__init__()
        self.url = httpurl

    def download(self):
        wget.download(self.url)
        print("Download not Implemented")

    def extract(self):
        print("Extraction not Implemented")


# XML Settings for Download of Depends
class GitHubZipTarget(object):
    def __init__(self):
        """Default Class Constructor"""
        super(self.__class__, self).__init__()