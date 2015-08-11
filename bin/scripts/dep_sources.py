"""
Module for dependency source downloads
"""

import wget, os, sys, glob, shutil
import zipfile, hashlib
from scripts.script_logs import ScriptLogs

PY3K = sys.version_info >= (3, 0)
if PY3K:
  import urllib.request as urllib2
  import urllib.parse as urlparse
else:
  import urllib2
  import urlparse

# Source Base Class
class DepSource(object):

    ArchiveDir = "."
    RootExtractDir = "."

    def __init__(self):
        self.url = ""
        self.destsubdir = ""
        self.md5hash = ""
        self.arch_filename = ""
        self.arch_filepath = ""
        self.log = ScriptLogs.getlogger()

    def download(self):
        return

    def extract(self):
        if self.arch_filepath == None:
            return

        # Create the extraction directory
        self.log.info("Extracting: " + self.arch_filename + " To: " + self.destsubdir)
        extractdir = os.path.abspath(os.path.join(DepSource.RootExtractDir, self.destsubdir))
        if os.path.exists(extractdir):
            shutil.rmtree(extractdir)
        os.makedirs(extractdir)

        # Get the file extension
        extension = os.path.splitext(self.arch_filename)[1]

        # Extract the file
        if extension == ".zip":
            with zipfile.ZipFile(self.arch_filepath, "r") as z:
                z.extractall(extractdir)
        else:
            raise ValueError("File Extension: " + extension + " Not supported")
        return

    @staticmethod
    def parsexml(root):
        ret = []

        for source in root.findall('FileExtract'):
            newsource = FileExtract(
                source.find('SrcFile').text,
                source.find('DestSubDir').text)
            if source.find('Md5Hash') != None:
                newsource.md5hash = source.find('Md5Hash').text
            ret.append(newsource)

        for source in root.findall('HttpSource'):
            newsource = HttpSource(
                source.find('Url').text,
                source.find('DestSubDir').text)
            if source.find('Md5Hash') != None:
                newsource.md5hash = source.find('Md5Hash').text
            ret.append(newsource)

        for source in root.findall('GitHubZipSource'):
            newsource = GitHubZipSource(
                source.find('Url').text,
                source.find('DestSubDir').text,
                source.find('CommitId').text)
            if source.find('Md5Hash') != None:
                newsource.md5hash = source.find('Md5Hash').text
            ret.append(newsource)

        return ret

# Http Download Source
class HttpSource(DepSource):

    def __init__(self, httpurl, destsubdir):
        super().__init__()
        self.url = httpurl
        self.destsubdir = destsubdir
        return

    @staticmethod
    def getfilename_fromurl(url):
        """Get Destination filename for a downloaded file"""
        # Try to get destination Filename from Content Disposition
        tmprequest = urllib2.urlopen(url)
        filename = wget.filename_from_headers(tmprequest.info())
        # Get filename from url
        if filename == None:
            filename = wget.filename_from_url(url)
        return filename

    def download(self):
        # Create destination directory if it doesn't exist
        destdir = DepSource.ArchiveDir
        if not os.path.exists(destdir):
            os.makedirs(destdir)
        
        # Set paths
        self.arch_filename = HttpSource.getfilename_fromurl(self.url)
        self.arch_filepath = os.path.join(destdir,self.arch_filename)

        # Download file if it doesn't exist
        self.log.info("Downloading :" + self.arch_filename)
        if os.path.exists(self.arch_filepath):
            self.log.warn("File already downloaded / Skipping: " + self.arch_filename)
        else:
            wget.download(self.url, out=destdir)
            self.log.info('\n' + "File Downloaded")

        # Check the MD5 Hash
        if self.md5hash:
            self.log.info("Calculating downloaded file hash")
            src_md5sum = hashlib.md5(open(self.arch_filepath,'rb').read()).hexdigest()
            self.log.info("File MD5 Hash is: " + src_md5sum)
            if self.md5hash == src_md5sum:
                self.log.info("MD5 Hash matches Okay: " + self.md5hash)
            else:
                self.log.error("MD5 Hash does not match: " + self.md5hash)
        return

    def extract(self):
        # Call base class extraction
        super().extract()
        # Remove the downloaded zip
        #os.remove(self.arch_filepath)
        return

# GitHub Download Source as zip
class GitHubZipSource(HttpSource):
    
    def __init__(self, giturl, destsubdir, commitid):
        self.commitid = commitid
        self.giturl = giturl

        # commit id can ether be set to "master" for the latest version
        # or a specific commit id for a specific point n time / version
        self.url = giturl + "/archive/" + commitid + ".zip"

        # Base Constructor
        super().__init__(self.url, destsubdir)
        return

    def extract(self):
        # Call base class extraction
        DepSource.extract(self)

        # Juggle the directories around
        extractdir = os.path.abspath(os.path.join(DepSource.RootExtractDir, self.destsubdir))
        olddir = extractdir + "_old"
        if os.path.exists(olddir):
            shutil.rmtree(olddir)
        os.rename(extractdir, olddir)
        
        # Relocate the inner directory
        tmp1 = os.path.splitext(self.arch_filename)[0]
        tmp1 = os.path.join(olddir, tmp1)
        shutil.move(tmp1 ,extractdir)
        shutil.rmtree(olddir)

        # Remove the downloaded zip
        #os.remove(self.arch_filepath)
        return
     
# File Extract Source for file that has to be manually downloaded into the Archive directory
class FileExtract(DepSource):

    def __init__(self, arcfile, destsubdir):
        super().__init__()
        self.url = arcfile
        self.destsubdir = destsubdir

        #If path is not absolute, assume it's relative to the Archive directory
        if not os.path.isabs(self.url):
            self.url = os.path.join(DepSource.ArchiveDir, self.url)
        self.url = os.path.abspath(self.url)

        #Assume glob is needed
        globlist = glob.glob(self.url)
        self.arch_filepath = None if not globlist else globlist[0]
        if self.arch_filepath:
            self.arch_filename = os.path.basename(self.arch_filepath)
        return
