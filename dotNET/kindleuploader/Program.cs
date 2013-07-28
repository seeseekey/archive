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

namespace kindleuploader
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
			Parameters commandLine=Parameters.InterpretCommandLine(args);
			List<string> files = new List<string>();

			bool convert = commandLine.GetBool("convert", false);

			List<string> clFiles=commandLine.GetFilesFromParameters();

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

			//Send Files
			foreach(string file in files)
			{
				string subject = "";
				if(convert)
				{
					subject = "convert";
				}

				Console.WriteLine("Send file {0}...", FileSystem.GetFilename(file));
				SMTP.SendMailMessageWithAuthAndAttachment(smtpserver, smtpUsername, smtpPassword, senderMail, "kindleuploader", recieverMail, recieverMail, subject, "", file);
			}
		}
	}
}
