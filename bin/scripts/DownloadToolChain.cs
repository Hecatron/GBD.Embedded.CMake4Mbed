using System;
using System.IO;
using System.Linq;
using NLog;

/// <summary> Download ToolChain for ARM Embedded Devices. </summary>
public class DownloadToolChain
{
    #region "Properties"

    /// <summary> Used for the Logging Output. </summary>
    private static readonly Logger Logger = LogManager.GetCurrentClassLogger();

    /// <summary> Tool Chain Settings. </summary>
    private static TCSettings setts;

    #endregion

    #region "Functions"

    /// <summary> Main entry-point for this application. </summary>
    /// <param name="args"> Array of command-line argument strings. </param>
    public static void Main(string[] args) {
        var settingsfile = "TCSettings.xml";
        if (args.Length > 0) settingsfile = args[0];

        Logger.Info("Starting Download / Extraction of ToolChain Libs");

        // Load the Settings from TCSettings.xml or whatever has been specified at the command line
        string tcspath = Path.Combine(GlobalScript.ScriptRunLocation(), settingsfile);
        setts = TCSettings.LoadFile(tcspath);

        // Make sure the Archive Directory exists
        if (Directory.Exists(setts.ArchiveDirectory) == false) Directory.CreateDirectory(setts.ArchiveDirectory);

        GetGNUTools();
        GetMBedSdk();
        GetMriGdb();
        GetAtmelASF();
    }

    /// <summary> Gets the Gnu Tools. </summary>
    public static void GetGNUTools() {

        if (Directory.Exists(setts.GCCRootDir)) {
            Logger.Warn("Gcc Directory Already exists skipping:");
            Logger.Warn(setts.GCCRootDir);
            return;
        }

        Logger.Info("Downloading GNU Tools / GCC for ARM");
        // Download main gcc archive file
        FileDownload.DownloadFIle(setts.GCCUrl, setts.GCCArchiveFilePath);
        // Download the md5 file
        FileDownload.DownloadFIle(setts.GCCUrl + "/+md5", setts.GCCArchiveFilePath + ".md5");

        Logger.Info("Validating md5 signature of GNU Tools / GCC for ARM");
        string tmpstr = File.ReadAllText(setts.GCCArchiveFilePath + ".md5");
        string downmd5 = tmpstr.Split(Convert.ToChar(" "))[0];
        string md5hash = FileDownload.GetMD5Hash(setts.GCCArchiveFilePath);
        if (md5hash != downmd5) {
            Logger.Warn("MD5 Hash does not match for the archive");
            Logger.Warn("Expected Hash: " + downmd5);
            Logger.Warn("Actual Hash:   " + md5hash);
        }

        Logger.Info("Extracting GNU Tools / GCC for ARM");
        if (Directory.Exists(setts.GCCRootDir)) Directory.Delete(setts.GCCRootDir,true);
        Directory.CreateDirectory(setts.GCCRootDir);
        Archive.Extract(setts.GCCArchiveFilePath, setts.GCCRootDir);

        // Cleanup
        File.Delete(setts.GCCArchiveFilePath);
        File.Delete(setts.GCCArchiveFilePath + ".md5");
    }

    /// <summary> Gets the MBed SDK. </summary>
    public static void GetMBedSdk() {

        if (Directory.Exists(setts.MBedRootDir)) {
            Logger.Warn("MBed Directory Already exists skipping:");
            Logger.Warn(setts.MBedRootDir);
            return;
        }

        Logger.Info("Downloading MBed SDK...");
        // Download mbed sdk github archive file
        string downloadurl = setts.MBedUrl + setts.MBedCommit + ".zip";
        FileDownload.DownloadFIle(downloadurl, setts.MBedArchiveFilePath);

        Logger.Info("Extracting MBed SDK...");
        if (Directory.Exists(setts.MBedRootDir)) Directory.Delete(setts.MBedRootDir, true);
        Archive.Extract(setts.MBedArchiveFilePath, setts.ArchiveDirectory);
        string srcdir = Path.Combine(setts.ArchiveDirectory, "mbed-" + setts.MBedCommit);
        Directory.Move(srcdir,setts.MBedRootDir);

        // Cleanup
        File.Delete(setts.MBedArchiveFilePath);
    }


    /// <summary> Gets Mri for gdb over serial. </summary>
    public static void GetMriGdb() {

        if (Directory.Exists(setts.MriRootDir)) {
            Logger.Warn("Mri Directory Already exists skipping:");
            Logger.Warn(setts.MriRootDir);
            return;
        }

        Logger.Info("Downloading Mri Gdb over serial library");
        // Download mri gituhb archive file
        string downloadurl = setts.MriUrl + setts.MriCommit + ".zip";
        FileDownload.DownloadFIle(downloadurl, setts.MriArchiveFilePath);

        Logger.Info("Extracting Mri Gdb over serial library");
        if (Directory.Exists(setts.MriRootDir)) Directory.Delete(setts.MriRootDir, true);
        Archive.Extract(setts.MriArchiveFilePath, setts.ArchiveDirectory);
        string srcdir = Path.Combine(setts.ArchiveDirectory, "mri-" + setts.MriCommit);
        Directory.Move(srcdir, setts.MriRootDir);

        // Cleanup
        File.Delete(setts.MriArchiveFilePath);
    }


    /// <summary> Extracts the Atmel ASF (Atmel Software Framework). </summary>
    public static void GetAtmelASF() {
        var files = Directory.EnumerateFiles(setts.ArchiveDirectory, setts.ASFArchive).ToList();

        if (Directory.Exists(setts.ASFRootDir)) {
            Logger.Warn("Atmel ASF directory already exists:");
            Logger.Warn(setts.ASFRootDir);
            Logger.Warn("Skipping Extract of:");
            Logger.Warn(files.First());
            return;
        }

        if (files.Any()) {
            Logger.Info("Extracting the Atmel ASF Libs");
            string tmpath = Path.Combine(setts.ArchiveDirectory, "ASFTemp");
            if (Directory.Exists(tmpath)) Directory.Delete(tmpath, true);
            if (Directory.Exists(setts.ASFRootDir)) Directory.Delete(setts.ASFRootDir, true);
            Directory.CreateDirectory(tmpath);
            Archive.Extract(files.First(), tmpath);

            Logger.Info("Relocating directory");
            string asfdir = Directory.EnumerateDirectories(tmpath).FirstOrDefault();
            if (asfdir != null) Directory.Move(asfdir,setts.ASFRootDir);

            // Cleanup
            Directory.Delete(tmpath, true);
        }
        else {
            Logger.Warn("There was no Atmel ASF Archive file found");
            Logger.Warn("manually download the file from http://www.atmel.com/tools/avrsoftwareframework.aspx?tab=overview for Atmel Support");
        }

    }

    #endregion

}
