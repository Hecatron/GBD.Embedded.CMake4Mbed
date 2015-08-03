using System;
using System.IO;
using System.Xml.Linq;
using NLog;
using NLog.LayoutRenderers;

//TODO add different config file for Linux

/// <summary>Settings for the ToolChain</summary>
[Serializable]
public class TCSettings
{
    #region "Properties - Static"

    /// <summary> Used for the Logging Output. </summary>
    private static readonly Logger Logger = LogManager.GetCurrentClassLogger();

    #endregion

    #region "Properties"

    /// <summary> Directory for downloaded Archive files. </summary>
    /// <value> Directory for downloaded Archive files. </value>
    public string ArchiveDirectory { get; set; }

    /// <summary> Wildcard path to the Atmel ASF archive file. </summary>
    /// <value> Wildcard path to the Atmel ASF archive file. </value>
    public string ASFArchive { get; set; }

    /// <summary> Root directory to extract ASF to. </summary>
    /// <value> Root directory to extract ASF to. </value>
    public string ASFRootDir { get; set; }

    /// <summary> Version of GCC In use. </summary>
    /// <value> Version of GCC In use. </value>
    public string GCCVersion { get; set; }

    /// <summary> Filename of the gcc Archive file. </summary>
    /// <value> Filename of the gcc Archive file. </value>
    public string GCCFileName { get; set; }

    /// <summary> Path to the downloaded GCC Archive File. </summary>
    /// <value> Path to the downloaded GCC Archive File. </value>
    public string GCCArchiveFilePath {
        get { return Path.Combine(ArchiveDirectory, GCCFileName); }
    }

    /// <summary> Url path to download gcc. </summary>
    /// <value> Url path to download gcc. </value>
    public string GCCUrl { get; set; }

    /// <summary> Extract Path for the GCC Archive. </summary>
    /// <value> Extract Path for the GCC Archive. </value>
    public string GCCRootDir { get; set; }

    /// <summary> Url for downloading the MBed SDK. </summary>
    /// <value> Url for downloading the MBed SDK. </value>
    public string MBedUrl { get; set; }

    /// <summary> Commit ID used within Git for the MBed SDK. </summary>
    /// <value> Commit ID used within Git for the MBed SDK. </value>
    public string MBedCommit { get; set; }

    /// <summary> Root Directory for extracting mbed. </summary>
    /// <value> Root Directory for extracting mbed. </value>
    public string MBedRootDir { get; set; }

    /// <summary> Path to the downloaded MBed Archive File. </summary>
    /// <value> Path to the downloaded MBed Archive File. </value>
    public string MBedArchiveFilePath {
        get { return Path.Combine(ArchiveDirectory, "MBed.zip"); }
    }

    /// <summary> Url for downloading the Mri gdb code. </summary>
    /// <value> Url for downloading the Mri gdb code. </value>
    public string MriUrl { get; set; }

    /// <summary> Commit ID used within Git for Mri. </summary>
    /// <value> Commit ID used within Git for Mri. </value>
    public string MriCommit { get; set; }

    /// <summary> Root Directory for extracting Mri. </summary>
    /// <value> Root Directory for extracting Mri. </value>
    public string MriRootDir { get; set; }

    /// <summary> Path to the downloaded Mri Archive File. </summary>
    /// <value> Path to the downloaded Mri Archive File. </value>
    public string MriArchiveFilePath {
        get { return Path.Combine(ArchiveDirectory, "Mri.zip"); }
    }

    #endregion

    #region "Functions"

    /// <summary> Deserialize XML File into class. </summary>
    public static TCSettings Deserialize(XElement xelement) {
        Logger.Debug("Deserialize ToolChainSettings");
        TCSettings ret = new TCSettings();
        if (xelement == null) throw new Exception("unable to find TCSettings element");
        if (xelement.Name != "TCSettings") throw new Exception("unable to find TCSettings element");

        ret.ArchiveDirectory = XMLField(xelement, "ArchiveDirectory", ret.ArchiveDirectory);
        ret.ArchiveDirectory = GlobalScript.AbsPath(ret.ArchiveDirectory);
        ret.ASFArchive = XMLField(xelement, "ASFArchive", ret.ASFArchive);
        ret.ASFRootDir = XMLField(xelement, "ASFRootDir", ret.ASFRootDir);
        ret.ASFRootDir = GlobalScript.AbsPath(ret.ASFRootDir);

        ret.GCCVersion = XMLField(xelement, "GCCVersion", ret.GCCVersion);
        ret.GCCFileName = XMLField(xelement, "GCCFileName", ret.GCCFileName);
        ret.GCCUrl = XMLField(xelement, "GCCUrl", ret.GCCUrl);
        ret.GCCUrl = ret.GCCUrl.Replace("%GCCFileName%", ret.GCCFileName);
        ret.GCCRootDir = XMLField(xelement, "GCCRootDir", ret.GCCRootDir);
        ret.GCCRootDir = GlobalScript.AbsPath(ret.GCCRootDir);

        ret.MBedUrl = XMLField(xelement, "MBedUrl", ret.MBedUrl);
        ret.MBedCommit = XMLField(xelement, "MBedCommit", ret.MBedCommit);
        ret.MBedRootDir = XMLField(xelement, "MBedRootDir", ret.MBedRootDir);
        ret.MBedRootDir = GlobalScript.AbsPath(ret.MBedRootDir);

        ret.MriUrl = XMLField(xelement, "MriUrl", ret.MriUrl);
        ret.MriCommit = XMLField(xelement, "MriCommit", ret.MriCommit);
        ret.MriRootDir = XMLField(xelement, "MriRootDir", ret.MriRootDir);
        ret.MriRootDir = GlobalScript.AbsPath(ret.MriRootDir);

        return ret;
    }

    /// <summary> Extract value from XML FIle. </summary>
    /// <param name="xelement">      The xelement. </param>
    /// <param name="elementname">   The element name. </param>
    /// <param name="originalvalue"> The original value. </param>
    /// <returns> A string which is ether the original value, or the value in the xml file if specified. </returns>
    private static string XMLField(XElement xelement, string elementname, string originalvalue) {
        string ret = originalvalue;
        var xele = xelement.Element(elementname);
        if (xele != null) ret = xele.Value;
        return ret;
    }

    /// <summary> Get Tool Chain Settings. </summary>
    public static TCSettings LoadFile(string path) {
        Logger.Debug("Loading TCSettings xml file: " + path);
        XElement xelement = XElement.Load(path);
        TCSettings ret = Deserialize(xelement);
        return ret;
    }

    #endregion
}
