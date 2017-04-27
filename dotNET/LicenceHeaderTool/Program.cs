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
using System.Collections.Generic;
using Xevle.IO;
using System.IO;
using Xevle.Core.Helper;

namespace LicenceHeaderTool
{
	class Program
	{
		static void DisplayHelp()
		{
			Console.WriteLine("Licence Header Tool v1.10");
			Console.WriteLine("(c) 2012 - 2017 by the seeseekey (http://seeseekey.net)");
			Console.WriteLine("");
			Console.WriteLine("Nutzung: LicenceHeaderTool -action -parameters");
			Console.WriteLine("  z.B. LicenceHeaderTool -GPLv3 /test seeseekey seeseekey@example.org \"2011, 2012\"");
			Console.WriteLine("");
			Console.WriteLine("  -GPLv3 <-overwrite> <projectPath> <author> <mail> <year>");
		}

		#region Licences
		public static List<string> GetInvertikaLicenceHeaderGPLv3(string filename)
		{
			List<string> ret=new List<string>();

			ret.Add("");
			ret.Add(String.Format("  {0}", Paths.GetFilename(filename)));
			ret.Add("");
			ret.Add("  This file is part of Invertika (http://invertika.org)");
			ret.Add(" ");
			ret.Add("  Based on The Mana Server (http://manasource.org)");
			ret.Add("  Copyright (C) 2004-2012  The Mana World Development Team ");
			ret.Add("");
			ret.Add("  Author:");
			ret.Add("       seeseekey <seeseekey@gmail.com>");
			ret.Add(" ");
			ret.Add("  Copyright (c) 2011, 2012 by Invertika Development Team");
			ret.Add(" ");
			ret.Add("  This program is free software: you can redistribute it and/or modify");
			ret.Add("  it under the terms of the GNU General Public License as published by");
			ret.Add("  the Free Software Foundation, either version 3 of the License, or");
			ret.Add("  (at your option) any later version.");
			ret.Add(" ");
			ret.Add("  This program is distributed in the hope that it will be useful,");
			ret.Add("  but WITHOUT ANY WARRANTY; without even the implied warranty of");
			ret.Add("  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the");
			ret.Add("  GNU General Public License for more details.");
			ret.Add(" ");
			ret.Add("  You should have received a copy of the GNU General Public License");
			ret.Add("  along with this program.  If not, see <http://www.gnu.org/licenses/>.");

			return ret;
		}

		public static List<string> GetGPLv3(string filename, string author, string mail, string year)
		{
			List<string> ret=new List<string>();

			ret.Add("");
			ret.Add(String.Format("  {0}", Paths.GetFilename(filename)));
			ret.Add("");
			ret.Add(String.Format("  Copyright (c) {0} by {1} <{2}>", year, author, mail));
			ret.Add("");
			ret.Add("  This program is free software: you can redistribute it and/or modify");
			ret.Add("  it under the terms of the GNU General Public License as published by");
			ret.Add("  the Free Software Foundation, either version 3 of the License, or");
			ret.Add("  (at your option) any later version.");
			ret.Add("");
			ret.Add("  This program is distributed in the hope that it will be useful,");
			ret.Add("  but WITHOUT ANY WARRANTY; without even the implied warranty of");
			ret.Add("  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the");
			ret.Add("  GNU General Public License for more details.");
			ret.Add("");
			ret.Add("  You should have received a copy of the GNU General Public License");
			ret.Add("  along with this program.  If not, see <http://www.gnu.org/licenses/>.");

			return ret;
		}
		#endregion

		#region Functions
		static void ProcessCSharpFile(string filename, bool overwrite, string author, string mail, string year, License license)
		{
			if(Paths.GetFilename(filename.ToLower())=="assemblyinfo.cs"||
			   Paths.GetFilename(filename.ToLower()).IndexOf(".designer.")!=-1)
			{
				Console.WriteLine("Skip file {0}", Paths.GetFilename(filename));
				return;
			}

			bool hasLicenseHeader=false;

			List<string> lines=new List<string>();
			lines.AddRange(File.ReadAllLines(filename));

			foreach(string line in lines)
			{
				if(line!=""&&!line.StartsWith("using")&&!line.StartsWith("namespace"))
				{
					hasLicenseHeader=true;
					break;
				}

				if(line.StartsWith("using")||line.StartsWith("namespace"))
				{
					break;
				}
			}

			if(overwrite)
			{
				int usingLine=0;
				foreach(string line in lines)
				{
					usingLine++;

					if(line.StartsWith("using")||line.StartsWith("namespace"))
					{
						break;
					}
				}

				lines.RemoveRange(0, usingLine-1);
			}

			//Add licence header
			if(hasLicenseHeader==false||overwrite)
			{
				List<string> licenceText=null;

				switch(license)
				{
					case License.GPLv3:
						{
							licenceText=GetGPLv3(filename, author, mail, year);
							break;
						}
					case License.InvertikaGPLv3:
						{
							licenceText=GetInvertikaLicenceHeaderGPLv3(Paths.GetFilename(filename));
							break;
						}
					default:
						{
							Console.WriteLine("Unknown licence. Skip file. {0}", Paths.GetFilename(filename));
							return;
						}
				}


				//Kommentare hinzufügen
				for(int i=0; i<licenceText.Count; i++)
				{
					licenceText[i]="//"+licenceText[i];
				}

				licenceText.Add(""); //Leerzeile

				//An Datei anfügen
				licenceText.AddRange(lines);

				//Datei speichern
				File.WriteAllLines(filename, licenceText);

				//Ausgabe
				Console.WriteLine("Add licence header to file {0}", Paths.GetFilename(filename));
			}
		}

		static void ProcessFiles(string projectPath, bool overwrite, string author, string mail, string year, License license)
		{
			List<string> files=FileOperations.GetFiles(projectPath, true);

			foreach(string file in files)
			{
				string ext=Paths.GetExtension(file);

				switch(ext.ToLower())
				{
					case "cs":
						{
							ProcessCSharpFile(file, overwrite, author, mail, year, license);
							break;
						}
					default:
						{
							Console.WriteLine("Ignore file {0}", Paths.GetFilename(file));
							break;
						}
				}
			}
		}
		#endregion

		static void Main(string[] args)
		{
			//Parameter auswerten
			Dictionary<string, string> parameters=null;

			try
			{
				parameters=CommandLineHelpers.GetCommandLine(args);
			}
			catch
			{
				Console.WriteLine("Parameters could't regonized!");
				Console.WriteLine("");
				DisplayHelp();
				return;
			}

			//Aktion starten
			List<string> files=CommandLineHelpers.GetFilesFromCommandline(parameters);

			if(files.Count<4)
			{
				Console.WriteLine("Need more parameters!");
				DisplayHelp();
			}
			else
			{
				string projectPath=files[0];
				string author=files[1];
				string mail=files[2];
				string year=files[3];

				License license=License.GPLv3;

				if(parameters.ContainsKey("GPLv3")) license=License.GPLv3;
				else if(parameters.ContainsKey("InvertikaGPLv3")) license=License.InvertikaGPLv3;

				ProcessFiles(projectPath, parameters.ContainsKey("overwrite"), author, mail, year, license);
			}
		}
	}
}
