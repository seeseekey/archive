//
//  Filesystem.cs
//
//  Copyright (c) 2011 by seeseekey <seeseekey@googlemail.com>
//
//  This program is free software: you can redistribute it and/or modify
//  it under the terms of the GNU General Public License as published by
//  the Free Software Foundation, either version 3 of the License, or
//  (at your option) any later version.
//
//  This program is distributed in the hope that it will be useful,
//  but WITHOUT ANY WARRANTY; without even the implied warranty of
//  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
//  GNU General Public License for more details.
//
//  You should have received a copy of the GNU General Public License
//  along with this program.  If not, see <http://www.gnu.org/licenses/>.

using System;
using System.IO;
using System.Collections.Generic;

namespace Updater.minilib
{
    /// <summary>
    /// Klasse für Filesystem Operationen
    /// </summary>
    public partial class FileSystem
    {
        #region Statische Variablen
        /// <summary>
        /// Feld nicht erlaubter Zeichen im Dateinamen
        /// </summary>
        static char[] illegalChars=new char[] { '<', '>', ':', '"', '|', '\0', '\x1', '\x2', '\x3', '\x4', '\x5',
			'\x6', '\x7', '\x8', '\x9', '\xA', '\xB', '\xC', '\xD', '\xE', '\xF', '\x10', '\x11', '\x12', '\x13',
			'\x14', '\x15', '\x16', '\x17', '\x18', '\x19', '\x1A', '\x1B', '\x1C', '\x1D', '\x1E', '\x1F' };
        #endregion

        #region Eigenschaften
        /// <summary>
        /// Gibt den Tempfad des Benutzers zurück
        /// </summary>
        public static string TempPath
        {
            get
            {
                return Path.GetTempPath().TrimEnd('\\')+'\\';
            }
        }

        /// <summary>
        /// Ermittelt den Applikationspfad
        /// </summary>
        /// <returns></returns>
        public static string ApplicationPath
        {
            get
            {
                FileInfo fi=new FileInfo(System.Reflection.Assembly.GetEntryAssembly().Location);
                return fi.DirectoryName+"\\";
            }
        }

        /// <summary>
        /// Ermittelt den Applikationspfad mit der Anwendung
        /// </summary>
        /// <returns></returns>
        public static string ApplicationPathWithFilename
        {
            get
            {
                FileInfo fi=new FileInfo(System.Reflection.Assembly.GetEntryAssembly().Location);
                return fi.FullName;
            }
        }

        /// <summary>
        /// Gibt die Position des Ordners Anwendungsdaten zurück
        /// </summary>
        /// <returns></returns>
        public static string ApplicationDataDirectory
        {
            get
            {
                return Environment.GetFolderPath(Environment.SpecialFolder.ApplicationData).TrimEnd('\\')+"\\";
            }
        }
        #endregion

        #region Directories & Files
        /// <summary>
        /// Überprüft ob eine Datei oder ein Verzeichniss existiert
        /// </summary>
        /// <param name="filename"></param>
        /// <returns></returns>
        public static bool Exists(string filename)
        {
            return File.Exists(filename)||Directory.Exists(filename);
        }
        #endregion

        #region Directories
        public static bool ExistsDirectory(string directory)
        {
            return System.IO.Directory.Exists(directory);
        }

        /// <summary>
        /// Überprüft ob der übergebene Dateiname ein Verzeichnis ist
        /// </summary>
        /// <param name="filename"></param>
        /// <returns></returns>
        public static bool IsDirectory(string filename)
        {
            try
            {
                FileAttributes attr=File.GetAttributes(filename);
                return (attr&FileAttributes.Directory)!=0;
            }
            catch(Exception) { }
            return false;
        }

        /// <summary>
        /// Legt ein Verzeichnis an
        /// </summary>
        /// <param name="dir">Path des anzulegenden Verzeichnisses</param>
        /// <returns>True, wenn erfolgreich.</returns>
        public static bool CreateDirectory(string dir)
        {
            try { Directory.CreateDirectory(dir); }
            catch(Exception) { return false; }
            return true;
        }

        /// <summary>
        /// Legt ein Verzeichniss und sämtliche Unterverzeichnisse an
        /// </summary>
        /// <param name="dir">Path des anzulegenden Verzeichnisses</param>
        /// <param name="force">Erzwingt das Anlegen des Verzeichnisses</param>
        /// <returns>True, wenn erfolgreich.</returns>
        public static bool CreateDirectory(string dir, bool force)
        {
            if(force==false) return CreateDirectory(dir);

            bool ret=true;

            char[] sep=new char[] { '/', '\\' };
            string[] pathParts=dir.Split(sep, StringSplitOptions.RemoveEmptyEntries);

            string path="";
            foreach(string i in pathParts)
            {
                path+=i+"\\";
                if(IsRoot(i)) continue;

                if(!Directory.Exists(path))
                {
                    if(!CreateDirectory(path)) ret=false;
                }
            }

            return ret;
        }

        public static bool CopyDirectory(string source, string dest)
        {
            return CopyDirectory(source, dest, true, new List<string>());
        }

        public static bool CopyDirectory(string source, string dest, bool recursiv)
        {
            return CopyDirectory(source, dest, recursiv, new List<string>());
        }

        public static bool CopyDirectory(string source, string dest, bool recursiv, List<string> ExcludeFolders)
        {
            DirectoryInfo SourceDI=new DirectoryInfo(source);

            bool result=true;
            if(!Directory.Exists(dest))
                Directory.CreateDirectory(dest);

            foreach(FileInfo fi in SourceDI.GetFiles())
            {
                string destFile=dest+"\\"+fi.Name;
                result=result&&(fi.CopyTo(destFile, false)!=null);
            }

            if(recursiv)
            {
                foreach(DirectoryInfo subDir in SourceDI.GetDirectories())
                {
                    bool make=true;

                    foreach(string i in ExcludeFolders)
                    {
                        if(subDir.Name==i)
                        {
                            make=false;
                            break;
                        }
                    }

                    if(make)
                    {
                        string destTmp=subDir.FullName.Replace(SourceDI.FullName, dest);
                        result=result&&CopyDirectory(subDir.FullName, destTmp, true, ExcludeFolders);
                    }
                }
            }

            return result;
        }

        /// <summary>
        /// Verschiebt ein Verzeichniss über Volumegrenzen hinaus
        /// </summary>
        /// <param name="source"></param>
        /// <param name="dest"></param>
        /// <returns></returns>
        public static bool MoveDirectory(string source, string dest)
        {
            if(CopyDirectory(source, dest)&&RemoveDirectory(source, true)) return true;
            else return false;
        }

        /// <summary>
        /// Löscht ein !leeres! Verzeichnis 
        /// </summary>
        /// <param name="dir"></param>
        /// <returns></returns>
        public static bool RemoveDirectory(string dir)
        {
            return RemoveDirectory(dir, false);
        }

        /// <summary>
        /// Löscht ein leeres (recursive=false)
        /// oder nicht leeres (recursive=true) Verzeichnis
        /// </summary>
        /// <param name="dir"></param>
        /// <param name="recursive"></param>
        /// <returns></returns>
        public static bool RemoveDirectory(string dir, bool recursive)
        {
            try { Directory.Delete(dir, recursive); }
            catch(Exception) { return false; }
            return true;
        }

        /// <summary>
        /// Gibt das aktuelle Verzeichnis zurück
        /// </summary>
        /// <returns></returns>
        public static string GetCurrentDir()
        {
            return Environment.CurrentDirectory.TrimEnd('\\')+"\\";
        }

        /// <summary>
        /// Setzt das aktuelle Verzeichnis
        /// </summary>
        /// <param name="dir"></param>
        /// <returns></returns>
        public static bool SetCurrentDir(string dir)
        {
            Environment.CurrentDirectory=dir.TrimEnd('\\')+"\\";
            return GetCurrentDir()==dir;
        }

        /// <summary>
        /// Gibt Unterverzeichnisse des Verzeichnisses
        /// </summary>
        /// <param name="directory"></param>
        /// <returns></returns>
        public static List<string> GetDirectories(string directory)
        {
            try
            {
                List<string> ret=new List<string>();
                ret.AddRange(Directory.GetDirectories(directory));
                return ret;
            }
            catch(Exception)
            {
                return new List<string>();
            }
        }

        /// <summary>
        /// Gibt Unterverzeichnisse des Verzeichnisses (gefiltert)
        /// </summary>
        /// <param name="directory"></param>
        /// <param name="filter"></param>
        /// <returns></returns>
        public static List<string> GetDirectories(string directory, string filter)
        {
            try
            {
                List<string> ret=new List<string>();
                ret.AddRange(Directory.GetDirectories(directory, filter));
                return ret;
            }
            catch(Exception)
            {
                return new List<string>();
            }
        }
        #endregion

        #region Files
        public static bool ExistsFile(string filename)
        {
            return System.IO.File.Exists(filename);
        }

        /// <summary>
        /// Überprüft ob der übergebene Dateiname eine Datei ist
        /// </summary>
        /// <param name="filename"></param>
        /// <returns></returns>
        public static bool IsFile(string filename)
        {
            try
            {
                FileAttributes attr=File.GetAttributes(filename);
                return (attr&FileAttributes.Directory)==0;
            }
            catch(Exception) { }
            return false;
        }

        /// <summary>
        /// Kopiert eine Datei
        /// ohne Überschreiben des Ziels, wenn bereits vorhanden
        /// </summary>
        /// <param name="src"></param>
        /// <param name="dst"></param>
        /// <returns></returns>
        public static bool CopyFile(string src, string dst)
        {
            return CopyFile(src, dst, false);
        }

        /// <summary>
        /// Kopiert eine Datei
        /// overwrite = true zum Überschreiben des Ziels, wenn bereits vorhanden
        /// </summary>
        /// <param name="src"></param>
        /// <param name="dst"></param>
        /// <param name="overwrite"></param>
        /// <returns></returns>
        public static bool CopyFile(string src, string dst, bool overwrite)
        {
            try { File.Copy(src, dst, overwrite); }
            catch(Exception) { return false; }
            return true;
        }

        /// <summary>
        /// Kopiert mehrere Dateien anhand Filterkriterien
        /// </summary>
        /// <param name="source"></param>
        /// <param name="target"></param>
        /// <param name="filter"></param>
        /// <returns></returns>
        public static bool CopyFiles(string source, string target, string filter)
        {
            List<string> files=GetFiles(source, false, filter);

            foreach(string i in files)
            {
                string fn=GetFilename(i);

                try
                {
                    File.Copy(i, target+fn);
                }
                catch(Exception)
                {
                    return false;
                }
            }

            return true;
        }

        /// <summary>
        /// Verschiebt eine Datei
        /// </summary>
        /// <param name="src"></param>
        /// <param name="dst"></param>
        /// <returns></returns>
        public static bool MoveFile(string src, string dst)
        {
            try { File.Move(src, dst); }
            catch(Exception) { return false; }
            return true;
        }

        /// <summary>
        /// Benennt eine Datei um
        /// </summary>
        /// <param name="src"></param>
        /// <param name="dst"></param>
        /// <returns></returns>
        public static bool RenameFile(string src, string dst)
        {
            return MoveFile(src, dst);
        }

        public static bool RemoveFile(string filename)
        {
            try
            {
                File.Delete(filename);
                return true;
            }
            catch
            {
                return false;
            }
        }

        public static bool RemoveFiles(List<string> filenames)
        {
            bool ret=true;

            foreach(string i in filenames)
            {
                if(RemoveFile(i)==false) ret=false;
            }

            return ret;
        }

        /// <summary>
        /// Überprüft ob eine Datei ReadOnly ist
        /// </summary>
        /// <param name="filename"></param>
        /// <returns></returns>
        public static bool IsReadOnly(string filename)
        {
            try
            {
                FileAttributes attr=File.GetAttributes(filename);
                return (attr&FileAttributes.ReadOnly)!=0;
            }
            catch(Exception) { }
            return false;
        }

        /// <summary>
        /// Gibt die Dateigröße zurück
        /// </summary>
        /// <param name="filename"></param>
        /// <returns></returns>
        public static long GetFilesize(string filename)
        {
            if(!IsFile(filename)) return -1;
            FileInfo fi=new FileInfo(filename);
            return fi.Length;
        }

        /// <summary>
        /// Überprüft ob der Dateiname nur gültige Zeichenenthält
        /// </summary>
        /// <param name="filename"></param>
        /// <returns></returns>
        public static bool IsFilenameValid(string filename)
        {
            if(filename.IndexOfAny(illegalChars)!=-1) return false;
            return true;
        }

        /// <summary>
        /// Macht aus einem Dateinamen mit ungültigen Zeichen einen Dateinamen
        /// mit gültigen Zeichen
        /// </summary>
        /// <param name="filename"></param>
        /// <returns></returns>
        public static string GetValidFilename(string filename)
        {
            int ind;
            while((ind=filename.IndexOfAny(illegalChars))!=-1) filename=filename.Remove(ind, 1);
            return filename;
        }

        /// <summary>
        /// Creates a list which contains all filenames in a specific folder
        /// </summary>
        /// <param name="Root">Folder which contains files to be listed</param>
        /// <param name="SubFolders">True for scanning subfolders</param>
        /// <returns></returns>
        public static List<string> GetFiles(string Root, bool Recursiv)
        {
            return GetFiles(Root, Recursiv, "*");
        }

        /// <summary>
        /// Creates a list which contains all filenames in a specific folder
        /// </summary>
        /// <param name="Root">Folder which contains files to be listed</param>
        /// <param name="SubFolders">True for scanning subfolders</param>
        /// <returns></returns>
        public static List<string> GetFiles(string Root, bool Recursiv, string Filter)
        {
            List<string> ret=new List<string>();

            try
            {
                string[] Files=System.IO.Directory.GetFiles(Root, Filter);
                string[] Folders=System.IO.Directory.GetDirectories(Root, Filter);

                for(int i=0;i<Files.Length;i++)
                {
                    ret.Add(Files[i].ToString());
                }

                if(Recursiv==true)
                {
                    for(int i=0;i<Folders.Length;i++)
                    {
                        ret.AddRange(GetFiles(Folders[i], Recursiv));
                    }
                }
            }
            catch(Exception Ex)
            {
                throw (Ex);
            }

            return ret;
        }
        #endregion

        #region Paths
        /// <summary>
        /// Ermittelt ob es sich bei dem Pfad um einen Root handelt
        /// </summary>
        /// <param name="path"></param>
        /// <returns></returns>
        public static bool IsRoot(string path)
        {
            path=path.TrimEnd('\\').ToLower();
            if(path.Length==2&&path[0]>='a'&&path[0]<='z'&&path[1]==':') return true;
            return false;
        }

        /// <summary>
        /// Überprüft ob der übergebende Pfad Absolut ist
        /// </summary>
        /// <param name="path"></param>
        /// <returns></returns>
        public static bool IsAbsolute(string path)
        {
            if(path.Length<3) return false;	// kein "c:\" oder ähnliches
            if(!Char.IsLetter(path[0]))
            {	//Test auf UNC Pfad
                if(path[0]!='\\') return false;	// z.B. "\\FOO\myMusic"
                if(path[1]!='\\') return false;
                return true;
            }
            if(path[1]!=':') return false;
            if(path[2]!='\\'&&path[2]!='/') return false;
            return true;
        }

        /// <summary>
        /// Überprüftob es sich bei dem filename um einen Pfad handelt
        /// </summary>
        /// <param name="path"></param>
        /// <returns></returns>
        public static bool IsPath(string filename)
        {
            char[] trimchars=new char[2];
            trimchars[0]='/';
            trimchars[1]='\\';

            filename=filename.TrimEnd(trimchars);

            if(filename.IndexOf('\\')!=-1||filename.IndexOf('/')!=-1) return true;
            else return false;
        }

        /// <summary>
        /// Überprüft ob der Übergebende Pfad ein Netzwerkpfad ist
        /// </summary>
        /// <param name="path"></param>
        /// <returns></returns>
        public static bool IsNetworkPath(string path)
        {
            if(path.Length<3) return false;	// kein "c:\" oder ähnliches
            if(!Char.IsLetter(path[0]))
            {	//Test auf UNC Pfad
                if(path[0]!='\\') return false;	// z.B. "\\FOO\myMusic"
                if(path[1]!='\\') return false;
                return true;
            }
            return false;
        }

        /// <summary>
        /// Überprüft ob der Übergebende Pfad ein lokaler Pfad ist
        /// </summary>
        /// <param name="path"></param>
        /// <returns></returns>
        public static bool IsLocalPath(string path)
        {
            if(IsNetworkPath(path)) return false;
            if(IsAbsolute(path)) return true;

            if(path.Length<1) return false;

            if(path.IndexOfAny(illegalChars)!=-1) return false;
            return true;
        }

        /// <summary>
        /// Gibt den Absoluten Pfad des übergenen Pfades zurück
        /// </summary>
        /// <param name="path"></param>
        /// <returns></returns>
        public static string GetAbsolutePath(string path)
        {
            FileInfo ret=new FileInfo(path);
            return ret.FullName;
        }

        /// <summary>
        /// Gibt den relativen Pfad zurück
        /// </summary>
        /// <param name="completePath"></param>
        /// <param name="basePath"></param>
        /// <returns></returns>
        public static string GetRelativePath(string completePath, string basePath)
        {
            if(!IsAbsolute(completePath)&&!IsNetworkPath(completePath))
                throw new ArgumentException("completePath is not absolute.");

            if(!IsAbsolute(basePath)&&!IsNetworkPath(basePath))
                throw new ArgumentException("basePath is not absolute.");

            completePath=completePath.ToLower();
            basePath=basePath.ToLower();

            completePath=GetAbsolutePath(completePath);
            basePath=GetAbsolutePath(basePath);

            // canonize
            if(basePath[basePath.Length-1]!='\\') basePath+='\\';

            string relativePath="";

            int baseStart=completePath.IndexOf(basePath);

            while(baseStart!=0&&basePath.Length>3)
            {
                basePath=GetPath(basePath.Substring(0, basePath.Length-1));

                if(basePath[basePath.Length-1]!='\\') basePath+='\\';

                relativePath+="..\\";
                baseStart=completePath.IndexOf(basePath);
            }

            if(baseStart==0)
                relativePath+=completePath.Substring(basePath.Length);
            else relativePath=completePath;

            return relativePath;
        }

        public static string GetPath(string filename)
        {
            return GetPath(filename, false);
        }

        /// <summary>
        /// Gibt Verzeichnisanteil des Strings zurück (incl. \)
        /// </summary>
        /// <param name="filename"></param>
        /// <returns></returns>
        public static string GetPath(string filename, bool stringMethod)
        {
            if(stringMethod)
            {
                if(filename[filename.Length-1]=='\\') return filename;

                //filename.IndexOf("", 1, 1, StringComparison.

                int idx=-1;

                for(int i=filename.Length-1;i>=0;i--)
                {
                    if(filename[i]=='\\')
                    {
                        idx=i;
                        break;
                    }
                }

                if(idx==-1) return filename;
                string path=filename.Substring(0, idx);

                return path+'\\';
            }
            else
            {
                FileInfo ret=new FileInfo(filename);
                if(ret.DirectoryName.Length==3) return ret.DirectoryName;
                return ret.DirectoryName+'\\';
            }
        }

        /// <summary>
        /// Gibt Dateinamenanteil des Strings zurück (rechts des letzten \ oder /)
        /// </summary>
        /// <param name="filename"></param>
        /// <returns></returns>
        public static string GetFilename(string filename)
        {
            FileInfo ret=new FileInfo(filename);
            return ret.Name;
        }

        /// <summary>
        /// Gibt Dateinamenendung des Strings zurück (rechts des letzten '.' )
        /// </summary>
        /// <param name="filename"></param>
        /// <returns></returns>
        public static string GetExtension(string filename)
        {
            FileInfo ret=new FileInfo(filename);
            return ret.Extension.TrimStart('.');
        }

        /// <summary>
        /// Gibt einen String mit neuer Dateierweiterung zurück
        /// </summary>
        /// <param name="filename"></param>
        /// <param name="newExt"></param>
        /// <returns></returns>
        public static string ChangeExtension(string filename, string newExt)
        {
            string fnWithoutExt=GetFilenameWithoutExt(filename);
            newExt=newExt.Replace(".", "");
            return fnWithoutExt+"."+newExt;
        }

        /// <summary>
        /// Gibt Dateinamenanteil(ohne letzte Erweiterung) des Strings zurück
        /// </summary>
        /// <param name="filename"></param>
        /// <returns></returns>
        public static string GetFilenameWithoutExt(string filename)
        {
            FileInfo ret=new FileInfo(filename);
            return ret.Name.Substring(0, ret.Name.Length-ret.Extension.Length);
        }

        /// <summary>
        /// Gibt Path und Dateinamenanteil(ohne letzte Erweiterung) des Strings zurück
        /// </summary>
        /// <param name="filename"></param>
        /// <returns></returns>
        public static string GetPathFilenameWithoutExt(string filename)
        {
            return GetPath(filename)+GetFilenameWithoutExt(filename);
        }
        #endregion
    }
}
