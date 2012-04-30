using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using CSCL;

namespace SortFilesPerDate
{
	class Program
	{
		static void Main(string[] args)
		{
			#region Upload Sorting
			bool move=args[0]=="move";
			string pathInput=args[1];
			string pathOutput=args[2];

			FileSystem.CreateDirectory(pathOutput);

			List<string> files=FileSystem.GetFiles(pathInput, true);

			foreach(string file in files)
			{
				DateTime dt=FileSystem.GetFileDateTime(file);

				string year=dt.Year.ToString();
				string month=dt.Month.ToString("00");

				string targetPath=String.Format("{0}{3}{1}{3}{2}{3}", pathOutput, year, month, FileSystem.PathDelimiter);
				FileSystem.CreateDirectory(targetPath, true);

				string targetFile=targetPath+FileSystem.GetFilename(file);
				
				if(move)
				{
					FileSystem.MoveFile(file, targetFile);
				}
				else
				{
					FileSystem.CopyFile(file, targetFile);
				}
			}
			#endregion
		}
	}
}
