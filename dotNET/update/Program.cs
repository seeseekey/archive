//
//  Program.cs
//
//  Copyright (c) 2012 by seeseekey <seeseekey@gmail.com>
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
using System.Text;
using System.Collections;
using System.Timers;
using CSCL;
using CSCL.Network.FTP.Client;
using System.Net;
using System.IO;
using CSCL.Crypto;
using System.Threading;

namespace update
{
	class Program
	{
		/// <summary>
		/// update.exe <source> <ftpServer> <username> <password>
		/// </summary>
		/// <param name="args"></param>
		static void Main(string[] args)
		{
			if(args.Length!=4)
			{
				Console.WriteLine("update.exe <sourceFolder> <ftpServer> <username> <password>");
				return;
			}

			string sourceFolder=args[0];
			string ftpServer=args[1];
			string username=args[2];
			string password=args[3];

			//Dateien zum upload ermitteln
			List<string> filesToUpload=new List<string>();
			filesToUpload.AddRange(FileSystem.GetFiles(sourceFolder, true, "*.*"));

			//FTP Verbindung aufbauen
			FTPSClient Client=new FTPSClient();

			NetworkCredential networkCredential=new NetworkCredential();
			networkCredential.Domain=ftpServer;
			networkCredential.UserName=username;
			networkCredential.Password=password;

			try
			{
				Client.Connect(networkCredential.Domain, networkCredential, ESSLSupportMode.ClearText);
			}
			catch(Exception exception)
			{
				Console.WriteLine("Fehler: {0}", exception.Message);
				return;
			}

			//Hashtabelle laden
			Dictionary<string, string> file2Hash=new Dictionary<string, string>();
			string filenameHashTable=FileSystem.ApplicationPath+"update.hash";

			if(FileSystem.ExistsFile(filenameHashTable))
			{
				string[] lines=File.ReadAllLines(filenameHashTable);

				foreach(string line in lines)
				{
					string[] parts=line.Split(new char[] { '\t' }, StringSplitOptions.RemoveEmptyEntries);
					file2Hash.Add(parts[0], parts[1]); //Filename, SHA1 Hash
				}
			}

			//Dateien hochladen
			int saveCounter=0;
			int ftpRefreshCounter=0;

			for(int fileCounter=0; fileCounter<filesToUpload.Count; fileCounter++)
			{
				string file=filesToUpload[fileCounter];

				//Überprüfung ob Datei hochgeladen werden muss
				bool fileMustBeUploaded=true;

				if(file2Hash.ContainsKey(file))
				{
					string hashFile=Hash.SHA1.HashFile(file);

					if(file2Hash[file]==hashFile)
					{
						fileMustBeUploaded=false;
					}
				}

				//Datei hochloaden
				if(fileMustBeUploaded)
				{
					try
					{
						if(file2Hash.ContainsKey(file))
						{
							//Bestehenden Key/Value modifizieren
							file2Hash[file]=Hash.SHA1.HashFile(file);
						}
						else
						{
							//Neuen Key anlegen
							file2Hash.Add(file, Hash.SHA1.HashFile(file));
						}

						Console.WriteLine("({0}/{1}) - Lade Datei {2} hoch...", fileCounter+1, filesToUpload.Count, FileSystem.GetFilename(file));
						string uploadf=FileSystem.GetRelativePath(file, sourceFolder);
						uploadf=uploadf.Replace('\\', '/');

						string directory=FileSystem.GetPath(uploadf, true).Replace('\\', '/');
						string[] dirParts=directory.Split(new char[] { '/' }, StringSplitOptions.RemoveEmptyEntries);

						if(directory!="")
						{
							string buildDirectory="";

							for(int i=0; i<dirParts.Length; i++)
							{
								buildDirectory+=dirParts[i]+"/";
								Client.EnsureDirectory(buildDirectory);
							}
						}

						saveCounter++;
						Client.PutFile(file, uploadf);
					}
					catch (Exception ex)
					{
						Console.WriteLine("({0}/{1}) - Fehler beim Upload von Datei {2}.", fileCounter+1, filesToUpload.Count, FileSystem.GetFilename(file));
						Console.WriteLine("({0}/{1}) - Meldung {2}.", fileCounter+1, filesToUpload.Count, ex.ToString());
						Client.Close();
						return;
					}
				}
				else
				{
					Console.WriteLine("({0}/{1}) - Überspringe Datei {2}...", fileCounter+1, filesToUpload.Count, FileSystem.GetFilename(file));
				}
				
				if(saveCounter>100)
				{
					saveCounter=0;
					SaveHashFile(filenameHashTable, file2Hash);
				}

				//KeepAlive Pakete senden
				ftpRefreshCounter++;
				if(ftpRefreshCounter>10000)
				{
					ftpRefreshCounter=0;
					Client.KeepAlive();
				}
			}

			Client.Close();

			//Save hash file
			SaveHashFile(filenameHashTable, file2Hash);
		}

		static void SaveHashFile(string filename, Dictionary<string, string> file2Hash)
		{
			List<string> lines=new List<string>();

			foreach(KeyValuePair<string, string> pair in file2Hash)
			{
				lines.Add(String.Format("{0}\t{1}", pair.Key, pair.Value));
			}

			File.WriteAllLines(filename, lines.ToArray());
		}
	}
}
