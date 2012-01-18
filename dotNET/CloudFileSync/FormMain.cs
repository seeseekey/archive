//
//  FormMain.cs
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
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Text;
using System.Windows.Forms;
using CSCL;
using System.Reflection;
using System.Threading;
using CSCL.Network.FTP.Client;
using System.Net;
using System.Security.Cryptography.X509Certificates;
using System.Net.Security;
using CSCL.Crypto;
using CSCL.Network.FTP.Common;
using System.IO;

namespace CloudFileSync
{
	public partial class FormMain : Form
	{
		List<string> filesChanged=new List<string>();
		List<string> filesCreated=new List<string>();
		List<string> filesDeleted=new List<string>();
		List<Pair<string>> filesRenamed=new List<Pair<string>>();

		public FormMain()
		{
			InitializeComponent();

			notifyIcon.ContextMenuStrip=contextMenuStrip;
			ShowInTaskbar=false;
			WindowState=FormWindowState.Minimized;
			notifyIcon.Visible=true;
		}

		private void exitToolStripMenuItem_Click(object sender, EventArgs e)
		{
			Close();
		}

		private void preferencesToolStripMenuItem_Click(object sender, EventArgs e)
		{
			FormPreferences InstFormPreferences=new FormPreferences();
			InstFormPreferences.ShowDialog();
		}

		private void FormMain_FormClosing(object sender, FormClosingEventArgs e)
		{
			Globals.Options.Save();
		}

		private void FormMain_Load(object sender, EventArgs e)
		{
			if(FileSystem.ExistsDirectory(Globals.OptionsDirectory)==false)
			{
				FileSystem.CreateDirectory(Globals.OptionsDirectory, true);
			}

			//Log
			Globals.Log=new Logger(Globals.LogFilename);
			Globals.Log.Add(LogLevel.Information, "Starte CloudFileSync.");

			//Optionen
			bool ExitsConfig=FileSystem.ExistsFile(Globals.OptionsXmlFilename);

			Globals.Options=new XmlData(Globals.OptionsXmlFilename);
			if(!ExitsConfig) Globals.Options.AddRoot("xml");

			// Setzt die Versionsnummer anhand der Assembly Version
			Assembly MainAssembly=Assembly.GetExecutingAssembly();
			Text+=" "+MainAssembly.GetName().Version.ToString();

			//Eindeutige ID generieren
			string clientid=Globals.Options.GetElementAsString("xml.Options.Misc.ClientID");

			if(clientid=="")
			{
				string uniqueID=Various.GetUniqueID();
				string uniqueIDSHA1=Hash.SHA1.HashStringToSHA1(uniqueID);

				clientid=uniqueIDSHA1;
				Globals.Options.WriteElement("xml.Options.Misc.ClientID", uniqueIDSHA1);
			}

			Globals.ClientID=clientid;
			Globals.Options.Save();

			//Hintergrundthread aktivieren
			backgroundWorker.RunWorkerAsync();
		}

		private bool ValidateServerCertificate(object sender, X509Certificate certificate, X509Chain chain, SslPolicyErrors sslPolicyErrors)
		{
			return true;
			bool certOk=false;

			if(sslPolicyErrors==SslPolicyErrors.None)
				certOk=true;
			else
			{
				Console.Error.WriteLine();

				if((sslPolicyErrors&SslPolicyErrors.RemoteCertificateChainErrors)>0)
					Console.Error.WriteLine("WARNING: SSL/TLS remote certificate chain errors");

				if((sslPolicyErrors&SslPolicyErrors.RemoteCertificateNameMismatch)>0)
					Console.Error.WriteLine("WARNING: SSL/TLS remote certificate name mismatch");

				if((sslPolicyErrors&SslPolicyErrors.RemoteCertificateNotAvailable)>0)
					Console.Error.WriteLine("WARNING: SSL/TLS remote certificate not available");

				//if(options.sslInvalidServerCertHandling==EInvalidSslCertificateHandling.Accept)
				//    certOk=true;
			}

			//if(!certOk||options.verbose)
			//{
			//    Console.WriteLine();
			//    Console.WriteLine("SSL/TLS Server certificate details:");
			//    Console.WriteLine();
			//    Console.WriteLine(Utility.GetCertificateInfo(certificate));
			//}

			//if(!certOk&&options.sslInvalidServerCertHandling==EInvalidSslCertificateHandling.Prompt)
			//{
			//    certOk=Utility.ConsoleConfirm("Accept invalid server certificate? (Y/N)");
			//}

			return certOk;
		}

		private void backgroundWorker_DoWork(object sender, DoWorkEventArgs e)
		{
			//ServicePointManager.ServerCertificateValidationCallback=delegate 
			//{ 
			//    return true; 
			//};

			RemoteCertificateValidationCallback certificateCallback=new RemoteCertificateValidationCallback(ValidateServerCertificate);

			string syncFolder=Globals.Options.GetElementAsString("xml.Options.Paths.SyncFolder");

			string ftpServer=Globals.Options.GetElementAsString("xml.Options.FTP.Server");
			string ftpUser=Globals.Options.GetElementAsString("xml.Options.FTP.User");
			string ftpPassword=Globals.Options.GetElementAsString("xml.Options.FTP.Password");
			string ftpProtocol=Globals.Options.GetElementAsString("xml.Options.FTP.Protocol");

			if(FileSystem.ExistsDirectory(syncFolder))
			{
				if(ftpServer!=""&&ftpUser!=""&ftpPassword!=""&ftpProtocol!="")
				{
					//Connect
					FTPSClient client=new FTPSClient();

					//NetworkCredital
					NetworkCredential credential=new NetworkCredential(ftpUser, ftpPassword);

					//client.Connect(ftpServer, credential, ESSLSupportMode.ControlAndDataChannelsRequired);

					client.Connect(ftpServer, credential, ESSLSupportMode.ControlAndDataChannelsRequired, certificateCallback);

					#region Verzeichnisstruktur überprüfen und nach Bedarf anlegen
					//Test auf leeres Verzeichnis
					IList<DirectoryListItem> files=client.GetDirectoryList();

					bool existXData=false;
					bool existHData=false;
					bool existLData=false;

					bool existCData=false;
					bool existMData=false;
					bool existRData=false;

					bool existCfsInfo=false;

					foreach(DirectoryListItem file in files)
					{
						if(file.IsDirectory)
						{
							switch(file.Name)
							{
								case "x-data":
									{
										existXData=true;
										break;
									}
								case "h-data":
									{
										existHData=true;
										break;
									}
								case "l-data":
									{
										existLData=true;
										break;
									}
								case "c-data":
									{
										existCData=true;
										break;
									}
								case "m-data":
									{
										existMData=true;
										break;
									}
								case "r-data":
									{
										existRData=true;
										break;
									}
								
							}
						}
						else //File
						{
							switch(file.Name)
							{
								case "cfsinfo":
									{
										existCfsInfo=true;
										break;
									}
							}
						}
					}

					//CfsInfo anlegen
					if(existCfsInfo==false)
					{
						List<string> version=new List<string>();
						version.Add("1"); //Repository Version

						string versionFilenameLocal=FileSystem.TempPath+"cfsinfo-"+Various.GetTimeID();
						File.WriteAllLines(versionFilenameLocal, version.ToArray());
						client.PutFile(versionFilenameLocal, "cfsinfo");
					}
					else //Version überprüfen
					{
						string versionFilenameLocal=FileSystem.TempPath+"cfsinfo-"+Various.GetTimeID();
						client.GetFile("cfsinfo", versionFilenameLocal);

						string[] cfsinfo=File.ReadAllLines(versionFilenameLocal);
						int version=Convert.ToInt32(cfsinfo[0]);

						if(version!=1)
						{
							MessageBox.Show("CloudFileSync ist nicht mit der Version des Repositories kompatibel!", "Hinweis", MessageBoxButtons.OK, MessageBoxIcon.Information);
							return;
						}
					}

					if(existXData==false) client.MakeDir("x-data"); //Datenordner
					if(existHData==false) client.MakeDir("h-data"); //Hashdaten
					if(existLData==false) client.MakeDir("l-data"); //Lockdaten

					if(existCData==false) client.MakeDir("c-data"); //Createdaten
					if(existMData==false) client.MakeDir("m-data"); //Modifieddaten
					if(existRData==false) client.MakeDir("r-data"); //Removedaten			
					
					//Überprüfen ob meine Clientverzeichnisse existieren
					CheckAndCreateClientFolder(client, "c-data");
					CheckAndCreateClientFolder(client, "m-data");
					CheckAndCreateClientFolder(client, "r-data");
					#endregion

					//Init Datenbestand (Sync)
					UpdateFromRemote(client, syncFolder);

					//Neu erzeugte oder geänderte Dateien ermitteln
					List<string> syncFolderFiles=FileSystem.GetFiles(syncFolder, true); //Neue Lokale Dateien hochladen

					foreach(string file in syncFolderFiles)
					{
						string relFilename=FileSystem.GetRelativePath(file, syncFolder, true);
						string hashRemote=GetHistoryHash(client, relFilename);
						string hashLocal=Hash.SHA1.HashFileToSHA1(file);

						if(hashRemote!=hashLocal)
						{
							filesCreated.Add(file);
						}
					}

					//gelöschte Dateien ermitteln
					List<string> hashFiles=GetHashFiles(client);

					foreach(string hashFile in hashFiles)
					{
						string filenameToTest=FileSystem.GetPathWithPathDelimiter(syncFolder)+hashFile.Replace('\\', FileSystem.PathDelimiter);
						syncFolderFiles.Remove(filenameToTest);
					}

					foreach(string file in syncFolderFiles)
					{
						if(filesCreated.IndexOf(file)==-1) //Datei soll nicht hochgeladen werden, sondern wurde wirklich auf einem anderen Client gelöscht
						{
							string relFilename=FileSystem.GetRelativePath(file, syncFolder, true);
							FileSystem.RemoveFile(file);
							Globals.Log.Add(LogLevel.Information, "Lokal: Datei {0} wurde gelöscht.", relFilename);
						}
					}

					//FilesystemWatcher aktivieren
					fileSystemWatcher.Path=syncFolder;
					fileSystemWatcher.EnableRaisingEvents=true;

					#region Endlosschleife für Syncronisation
					while(true)
					{
						if(e.Cancel==true) return;

						List<string> fileToRemoveFromList=new List<string>();

						//Dateien hochladen
						#region Created files
						lock(filesCreated)
						{
							foreach(string fileCreated in filesCreated)
							{
								string relFilename=FileSystem.GetRelativePath(fileCreated, syncFolder, true);
								relFilename=relFilename.Replace("\\", "/");

								bool locked=GetFileLock(client, relFilename);

								if(locked)
								{
									if(FileSystem.IsDirectory(fileCreated)) //Directory
									{
										client.CreateDirectory("x-data/"+relFilename);
										fileToRemoveFromList.Add(fileCreated);
										Globals.Log.Add(LogLevel.Information, "Remote: Verzeichnis {0} wurde erstellt (x-data).", relFilename);

										//In Created Verzeichnisse legen
										AddFileToUpdateFolder(client, "c-data", relFilename, EFileType.Directory);
										//Globals.Log.Add(LogLevel.Information, "Updatedatei {0} wurde hochgeladen (c-data).", relFilename);
									}
									else //File
									{
										//Hashdatei ändern
										AddHistoryHash(client, fileCreated, relFilename);
										Globals.Log.Add(LogLevel.Information, "Remote: Hash für {0} wurde geändert (x-data).", relFilename);

										//Datei hochladen
										CreateFTPDirectories(client, "x-data/"+relFilename);
										client.PutFile(fileCreated, "x-data/"+relFilename);
										fileToRemoveFromList.Add(fileCreated);
										Globals.Log.Add(LogLevel.Information, "Remote: Datei {0} wurde hochgeladen (x-data).", relFilename);

										//In Created Verzeichnisse legen
										AddFileToUpdateFolder(client, "c-data", relFilename, EFileType.File);
										//Globals.Log.Add(LogLevel.Information, "Updatedatei {0} wurde hochgeladen (c-data).", relFilename);
									}
								}

								RemoveFileLock(client, relFilename);
							}

							foreach(string rFile in fileToRemoveFromList)
							{
								filesCreated.Remove(rFile);
							}
						}

						fileToRemoveFromList.Clear();
						#endregion

						#region Changed Files
						lock(filesChanged)
						{
							foreach(string fileChanged in filesChanged)
							{
								string relFilename=FileSystem.GetRelativePath(fileChanged, syncFolder, true);
								relFilename=relFilename.Replace("\\", "/");

								bool locked=GetFileLock(client, relFilename);

								if(locked)
								{
									if(FileSystem.IsDirectory(fileChanged)) //Directory
									{
										//Sollte bei Verzeichnissen ignoriert werden
									}
									else //File
									{
										//Hashdatei ändern
										AddHistoryHash(client, fileChanged, relFilename);
										Globals.Log.Add(LogLevel.Information, "Remote: Hash für {0} wurde geändert (x-data).", relFilename);

										//Datei hochladen
										client.PutFile(fileChanged, "x-data/"+relFilename);
										fileToRemoveFromList.Add(fileChanged);
										Globals.Log.Add(LogLevel.Information, "Remote: Datei {0} wurde modifiziert (x-data).", relFilename);

										//In Created Verzeichnisse legen
										AddFileToUpdateFolder(client, "m-data", relFilename, EFileType.File);
									}
								}

								RemoveFileLock(client, relFilename);
							}

							foreach(string rFile in fileToRemoveFromList)
							{
								filesChanged.Remove(rFile);
							}
						}

						fileToRemoveFromList.Clear();
						#endregion

						#region Deleted Files
						lock(filesDeleted)
						{
							foreach(string fileDeleted in filesDeleted)
							{
								string relFilename=FileSystem.GetRelativePath(fileDeleted, syncFolder, true);
								relFilename=relFilename.Replace("\\", "/");

								bool locked=GetFileLock(client, relFilename);

								if(locked)
								{
									if(FileSystem.IsDirectory(fileDeleted)) //Directory
									{
										client.RemoveDir(fileDeleted);
										//client.PutFile(fileChanged, "x-data/"+relFilename);
										fileToRemoveFromList.Add(fileDeleted);
										Globals.Log.Add(LogLevel.Information, "Remote: Verzeichnis {0} wurde gelöscht (x-data).", relFilename);

										//In Created Verzeichnisse legen
										AddFileToUpdateFolder(client, "r-data", relFilename, EFileType.File);
									}
									else //File
									{
										//Hashdatei löchen
										RemoveHistoryHash(client, relFilename);
										Globals.Log.Add(LogLevel.Information, "Remote: Hash für {0} wurde gelöscht (x-data).", relFilename);

										//Datei löschen
										client.DeleteFile("x-data/"+relFilename);
										fileToRemoveFromList.Add(fileDeleted);
										Globals.Log.Add(LogLevel.Information, "Remote: Datei {0} wurde gelöscht (x-data).", relFilename);

										//In Created Verzeichnisse legen
										AddFileToUpdateFolder(client, "r-data", relFilename, EFileType.File);
									}
								}

								RemoveFileLock(client, relFilename);
							}

							foreach(string rFile in fileToRemoveFromList)
							{
								filesDeleted.Remove(rFile);
							}
						}

						fileToRemoveFromList.Clear();
						#endregion

						//Neue Dateien herunterladen bzw. gelöscht Dateien löschen
						UpdateFromRemote(client, syncFolder);

						//Halbe Sekunde warten
						Thread.Sleep(500);
					}
					#endregion

					//string fileInfo=Globals.Options.GetElementAsString("xml.Sync.Filesystem.Test.txt");
					//client.PutFile("D:\\AlexFTPS_bin_1.0.2.zip", "xxx.xxx");
				}
			}
		}

		public void CreateFTPDirectories(FTPSClient client, string filename)
		{
			string path=FileSystem.GetPath(filename, true, false);
			string[] parts=path.Split(new char[] { '/' }, StringSplitOptions.RemoveEmptyEntries);

			string newPath="";

			foreach(string part in parts)
			{
				newPath+=part;
				//client.GetDirectoryList
				if(client.Exists(newPath)==false)
				{
					client.EnsureDirectory(newPath);
				}
				newPath+="/";
			}
		}

		public void UpdateFromRemote(FTPSClient client, string syncFolder)
		{
			#region Removed
			List<FileReturn> filesToUpdate=GetFilesFromUpdateFolder(client, "r-data");

			if(filesToUpdate.Count>0)
			{
				foreach(FileReturn fileReturn in filesToUpdate)
				{
					if(fileReturn.FileType==EFileType.File)
					{
						string localFilename=syncFolder+"/"+fileReturn.Filename;
						FileSystem.RemoveFile(localFilename);
						Globals.Log.Add(LogLevel.Information, "Lokal: Datei {0} wurde gelöscht (x-data).", fileReturn.Filename);
					}
					else if(fileReturn.FileType==EFileType.Directory)
					{
						throw new NotImplementedException();
					}
				}
			}
			#endregion

			#region Created
			filesToUpdate=GetFilesFromUpdateFolder(client, "c-data");

			if(filesToUpdate.Count>0)
			{
				foreach(FileReturn fileReturn in filesToUpdate)
				{
					if(fileReturn.FileType==EFileType.File)
					{
						string localFilename=syncFolder+"/"+fileReturn.Filename;
						client.GetFile("x-data/"+fileReturn.Filename, localFilename);
						Globals.Log.Add(LogLevel.Information, "Lokal: Datei {0} wurde erzeugt (x-data).", fileReturn.Filename);
					}
					else if(fileReturn.FileType==EFileType.Directory)
					{
						string localFilename=syncFolder+"/"+fileReturn.Filename;
						client.GetFile("x-data/"+fileReturn.Filename, localFilename);
						Globals.Log.Add(LogLevel.Information, "Lokal: Verzeichnis {0} wurde erzeugt (x-data).", fileReturn.Filename);
					}
				}
			}
			#endregion

			#region Modified
			filesToUpdate=GetFilesFromUpdateFolder(client, "m-data");

			if(filesToUpdate.Count>0)
			{
				foreach(FileReturn fileReturn in filesToUpdate)
				{
					if(fileReturn.FileType==EFileType.File)
					{
						string localFilename=syncFolder+"/"+fileReturn.Filename;
						client.GetFile("x-data/"+fileReturn.Filename, localFilename);
						Globals.Log.Add(LogLevel.Information, "Lokal: Datei {0} wurde modifiziert (x-data).", fileReturn.Filename);
					}
					else if(fileReturn.FileType==EFileType.Directory)
					{
						throw new NotImplementedException();
					}
				}
			}
			#endregion
		}

		/// <summary>
		/// Fügt eine entsprechende Datendatei in den entsprechenden Order:
		/// c-data
		/// r-data
		/// m-data
		/// </summary>
		/// <param name="client"></param>
		/// <param name="?"></param>
		public void AddFileToUpdateFolder(FTPSClient client, string folder, string relFilename, EFileType fileType)
		{
			//In Update Verzeichniss legen
			IList<DirectoryListItem> hashDirs=client.GetDirectoryList(folder+"/");

			//Updatedatei anlegen
			string uniqueID=Various.GetUniqueID();
			string uniqueIDSHA1=Hash.SHA1.HashStringToSHA1(uniqueID);

			string filenameLocal=FileSystem.TempPath+uniqueIDSHA1;

			List<string> lines=new List<string>();
			lines.Add(relFilename);
			lines.Add(fileType.ToString());
			File.WriteAllLines(filenameLocal, lines.ToArray());

			//Updatedatei hochladen
			foreach(DirectoryListItem dli in hashDirs)
			{
				if(Globals.ClientID==dli.Name) continue;
				client.PutFile(filenameLocal, folder+"/"+dli.Name+"/"+uniqueIDSHA1);
			}

			//Log
			Globals.Log.Add(LogLevel.Information, "Updatedatei {0} wurde hochgeladen ({1}).", relFilename, folder);
		}

		public EFileType GetFileType(string fileType)
		{
			switch(fileType)
			{
				case "File":
					{
						return EFileType.File;
					}
				case "Directory":
					{
						return EFileType.Directory;
					}
				default:
					{
						throw new Exception("Unknown filetype!");
					}
			}
		}

		/// <summary>
		/// Gibt die Updatedateien eines Verzeichnisses zurück
		/// </summary>
		/// <param name="client"></param>
		/// <param name="folder"></param>
		/// <returns></returns>
		public List<FileReturn> GetFilesFromUpdateFolder(FTPSClient client, string folder)
		{
			List<FileReturn> ret=new List<FileReturn>();

			//In Update Verzeichniss legen
			string updateFolder=folder+"/"+Globals.ClientID+"/";
			IList<DirectoryListItem> updateFiles=client.GetDirectoryList(updateFolder); //TODO evt FTPException abfangen

			//Sicherheitspause falls gerade noch eine Datei angelegt wurde
			Thread.Sleep(500);

			//Updatedatei herunterladen und auswerten
			foreach(DirectoryListItem dli in updateFiles)
			{
				string filenameLocal=FileSystem.TempPath+dli.Name;
				client.GetFile(updateFolder+dli.Name, filenameLocal);

				string[] lines=File.ReadAllLines(filenameLocal);
				string filename=lines[0]; //Datei hinzufügen
				EFileType fileType=GetFileType(lines[1]);

				//Updatedatei löschen
				client.DeleteFile(updateFolder+dli.Name);
			}

			return ret;
		}

		/// <summary>
		/// Schaut ob die Client Folder da sind bzw erstellt sie
		/// </summary>
		/// <param name="client"></param>
		/// <param name="dir"></param>
		public void CheckAndCreateClientFolder(FTPSClient client, string dir)
		{
			client.PushCurrentDirectory();
			client.SetCurrentDirectory(dir);

			IList<DirectoryListItem> files=client.GetDirectoryList();
			bool existClientDirectory=false;

			foreach(DirectoryListItem file in files)
			{
				if(file.IsDirectory)
				{
					if(file.Name==Globals.ClientID)
					{
						existClientDirectory=true;
					}
				}
			}

			if(existClientDirectory==false)
			{
				client.MakeDir(Globals.ClientID);
			}

			//client.SetCurrentDirectory("..");
			client.PopCurrentDirectory();
		}

		#region Locking
		/// <summary>
		/// Entfernt den Dateilock
		/// </summary>
		/// <param name="client"></param>
		/// <param name="file"></param>
		/// <returns></returns>
		public bool RemoveFileLock(FTPSClient client, string file)
		{
			file=file.Replace("/", "\\");
			file="l-data/"+file;

			try
			{
				client.DeleteFile(file);
				return true;
			}
			catch
			{
				return false;
			}
		}

		/// <summary>
		/// Holt einen Dateilock
		/// </summary>
		/// <param name="client"></param>
		/// <param name="file"></param>
		/// <returns></returns>
		public bool GetFileLock(FTPSClient client, string file)
		{
			file=file.Replace("/", "\\");
			file="l-data/"+file;

			if(client.Exists(file)) //Auf Lock überprüfen
			{
				Thread.Sleep(500);

				if(client.Exists(file)) //Nochmal Auf Lock überprüfen
				{
					return false; //Lock konnte nicht geholt werden
				}
			}

			//Lock erzeugen
			string lockFilenameLocal=FileSystem.TempPath+FileSystem.GetFilename(file);
			string lockFilenameLocalCheck=FileSystem.TempPath+FileSystem.GetFilename(file)+".check";

			List<string> lines=new List<string>();
			lines.Add(Globals.ClientID);
			File.WriteAllLines(lockFilenameLocal, lines.ToArray());

			client.PutFile(lockFilenameLocal, file);

			//Lock überprüfen
			client.GetFile(file, lockFilenameLocalCheck);

			string[] linesLockFile=File.ReadAllLines(lockFilenameLocalCheck);
			string lockID=linesLockFile[0];

			if(Globals.ClientID==lockID) //Überprüfen ob das Lock ein Client Lock ist
			{
				return true;
			}
			else //Kein Client eigenes Lock
			{
				return false;
			}
		}
		#endregion

		#region Hash
		public List<string> GetHashFiles(FTPSClient client)
		{
			List<string> ret=new List<string>();

			string hashFolder="h-data/";
			IList<DirectoryListItem> hashFiles=client.GetDirectoryList(hashFolder); //TODO evt FTPException abfangen

			//Updatedatei herunterladen und auswerten
			foreach(DirectoryListItem dli in hashFiles)
			{
				ret.Add(dli.Name);
			}

			return ret;
		}

		public bool RemoveHistoryHash(FTPSClient client, string file)
		{
			file=file.Replace("/", "\\");
			file="h-data/"+file;

			try
			{
				client.DeleteFile(file);
				return true;
			}
			catch
			{
				return false;
			}
		}

		/// <summary>
		/// Holt einen Dateilock
		/// </summary>
		/// <param name="client"></param>
		/// <param name="file"></param>
		/// <returns>true = New hash / </returns>
		public bool AddHistoryHash(FTPSClient client, string file, string relFilename)
		{
			string fileNameFTP=relFilename.Replace("/", "\\");
			fileNameFTP="h-data/"+fileNameFTP;

			string fileHash=Hash.SHA1.HashFileToSHA1(file);

			if(client.Exists(fileNameFTP)) //Neuen Hash hinzufügen
			{
				string hashFilenameLocal=FileSystem.TempPath+FileSystem.GetFilename(fileNameFTP);
				client.GetFile(fileNameFTP, hashFilenameLocal);

				List<string> hashInfo=new List<string>();
				hashInfo.AddRange(File.ReadAllLines(hashFilenameLocal));

				if(hashInfo[0]==fileHash)
				{
					return false;
				}
				else
				{
					hashInfo.Add(fileHash);
					File.WriteAllLines(hashFilenameLocal, hashInfo.ToArray());
					client.PutFile(hashFilenameLocal, fileNameFTP);

					return true;
				}
			}
			else //Hash Datei erzeugen
			{
				List<string> hashFile=new List<string>();
				hashFile.Add(fileHash); //Repository Version

				string hashFilenameLocal=FileSystem.TempPath+"hash-"+Various.GetTimeID();
				File.WriteAllLines(hashFilenameLocal, hashFile.ToArray());
				client.PutFile(hashFilenameLocal, fileNameFTP);

				return true;
			}
		}

		public string GetHistoryHash(FTPSClient client, string relFilename)
		{
			string fileNameFTP=relFilename.Replace("/", "\\");
			fileNameFTP="h-data/"+fileNameFTP;

			if(client.Exists(fileNameFTP)) //Neuen Hash hinzufügen
			{
				string hashFilenameLocal=FileSystem.TempPath+FileSystem.GetFilename(fileNameFTP);
				client.GetFile(fileNameFTP, hashFilenameLocal);

				List<string> hashInfo=new List<string>();
				hashInfo.AddRange(File.ReadAllLines(hashFilenameLocal));

				return hashInfo[0];
			}
			else //keine Hashdatei vorhanden
			{
				return "";
			}
		}
		#endregion

		#region Filesystem Watcher
		private void fileSystemWatcher_Changed(object sender, System.IO.FileSystemEventArgs e)
		{
			lock(filesCreated)
			{
				lock(filesChanged)
				{
					if(filesCreated.IndexOf(e.FullPath)==-1&&filesChanged.IndexOf(e.FullPath)==-1)
					{
						Globals.Log.Add(LogLevel.Debug, "Lokal: Geänderte Datei {0} wurde erkannt. ChangeType ist {1}.", e.FullPath, e.ChangeType.ToString());
						filesChanged.Add(e.FullPath);
					}
				}
			}
		}

		private void fileSystemWatcher_Created(object sender, System.IO.FileSystemEventArgs e)
		{
			lock(filesCreated)
			{
				lock(filesChanged)
				{
					if(filesCreated.IndexOf(e.FullPath)==-1&&filesChanged.IndexOf(e.FullPath)==-1)
					{
						Globals.Log.Add(LogLevel.Debug, "Lokal: Erzeugte Datei {0} wurde erkannt. ChangeType ist {1}.", e.FullPath, e.ChangeType.ToString());
						filesCreated.Add(e.FullPath);
					}
				}
			}
		}

		private void fileSystemWatcher_Deleted(object sender, System.IO.FileSystemEventArgs e)
		{
			lock(filesDeleted)
			{
				if(filesDeleted.IndexOf(e.FullPath)==-1)
				{
					Globals.Log.Add(LogLevel.Debug, "Lokal: Gelöschte Datei {0} wurde erkannt. ChangeType ist {1}.", e.FullPath, e.ChangeType.ToString());
					filesDeleted.Add(e.FullPath);
				}
			}
		}

		private void fileSystemWatcher_Renamed(object sender, System.IO.RenamedEventArgs e)
		{
			filesDeleted.Add(e.FullPath); //TODO noch nicht implementiert
		}
		#endregion
	}
}
