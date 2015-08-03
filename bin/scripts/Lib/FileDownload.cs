using System;
using System.IO;
using System.Net;
using System.Security.Cryptography;
using NLog;

// TODO add download Progress output similar to curl http://stackoverflow.com/questions/4172158/c-sharp-progress-bar-and-webclient

/// <summary> Class used for handling file downloads. </summary>
public class FileDownload
{
    /// <summary> Used for the Logging Output. </summary>
    private static readonly Logger Logger = LogManager.GetCurrentClassLogger();

    /// <summary> Download a file. </summary>
    /// <param name="url">  URL of the file to download. </param>
    /// <param name="path"> destination path. </param>
    public static void DownloadFIle(string url, string path) {
        using (var client = new WebClient()) {
            if (File.Exists(path)) {
                string filename = Path.GetFileName(path);
                Logger.Warn("File already downloaded, skipping: " + filename);
                return;
            }
            Logger.Debug("Downloading " + url + " To " + path);
            client.DownloadFile(url, path);
        }
    }

    /// <summary> Gets a md5 hash of a flie. </summary>
    /// <param name="path"> destination path for the file to read hte md5 hash. </param>
    /// <returns> The md5 hash. </returns>
    public static string GetMD5Hash(string path) {
        string ret;
        using (var md5 = MD5.Create()) {
            using (var stream = File.OpenRead(path)) {
                ret = BitConverter.ToString(md5.ComputeHash(stream)).Replace("-", "").ToLower();
            }
        }
        return ret;
    }

}
