//
//  Program.cs
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
using CSCL;
using CSCL.Network;
using System.Collections.Generic;
using CSCL.Helpers;
using System.IO;

namespace evernoteuploader
{
	class MainClass
	{
		static string recieverMail="";

		static string smtpserver="";
		static string senderMail="";
		static string smtpUsername="";
		static string smtpPassword="";
	
		public static void Main(string[] args)
		{
			//Options
			if(!FileSystem.ExistsFile("config.xml"))
			{
				Console.WriteLine("No config.xml file found.");
				return;
			}

			XmlData Options=new XmlData("config.xml");

			recieverMail=Options.GetElementAsString("xml.SMTP.RecieverMail");

			smtpserver=Options.GetElementAsString("xml.SMTP.Server");
			senderMail=Options.GetElementAsString("xml.SMTP.SenderMail");
			smtpUsername=Options.GetElementAsString("xml.SMTP.Username");
			smtpPassword=Options.GetElementAsString("xml.SMTP.Password");

			//Files
			Dictionary<string, string> commandLine=CommandLineHelpers.GetCommandLine(args);
			List<string> files=new List<string>();

			bool book=commandLine.ContainsKey("book");
			string bookname = "";
			if(book) bookname = commandLine["book"];

			List<string> clFiles=CommandLineHelpers.GetFilesFromCommandline(commandLine);

			foreach(string clFile in clFiles)
			{
				if(FileSystem.IsFile(clFile))
				{
					files.Add(clFile);
				}
				else
				{
					files.AddRange(FileSystem.GetFiles(clFile, true));
				}
			}

			if(files.Count==0)
			{
				Console.WriteLine("No files specified.");
				return;
			}

			//Send Files
			foreach(string file in files)
			{
				string fileSend=file;

				//CSCL.
				//Sending
				string subject=FileSystem.GetFilenameWithoutExt(file);
				if(book)
				{
					subject = String.Format("{0} @{1}", subject, bookname);
				}

				Console.WriteLine("Send file {0}...", FileSystem.GetFilename(file));
				SMTP.SendMailMessageWithAuthAndAttachment(smtpserver, smtpUsername, smtpPassword, senderMail, "everloaduploader", recieverMail, recieverMail, subject, "", fileSend);
			}
		}
	}
}
