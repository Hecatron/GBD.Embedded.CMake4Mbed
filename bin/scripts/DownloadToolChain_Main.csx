#load "Lib\Archive.cs"
#load "Lib\FileDownload.cs"
#load "Lib\GlobalScript.cs"
#load "Lib\TCSettings.cs"
#load "DownloadToolChain.cs"

#r "..\..\deps\dotnet\SharpZipLib.0.86.0\lib\20\ICSharpCode.SharpZipLib.dll"
#r "..\..\deps\dotnet\NLog.4.0.1\lib\net45\NLog.dll"
#r "..\..\deps\dotnet\SevenZipSharp.0.64\lib\SevenZipSharp.dll"

// Set path to Nlog Configuration
string logFilePath = GlobalScript.AbsPath("NLog.config");
NLog.LogManager.Configuration = new NLog.Config.XmlLoggingConfiguration(logFilePath, true);

// Set path to the 7Zip dll
Archive.SevenZipDllPath = Path.Combine(GlobalScript.ScriptRunLocation(), @"..\..\deps\dotnet\SevenZipSharp.Interop.9.38\build\net451\");

// Make Call to Main App
DownloadToolChain.Main(Env.ScriptArgs.ToArray());
