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
			//Parameter <move/copy> <sort/rename> <input> <output>
			
			#region Upload Sorting
			bool move=args[0]=="move";
			bool sort=args[0]=="sort";
			string pathInput=args[1];
			string pathOutput=args[2];

			FileSystem.CreateDirectory(pathOutput);

			List<string> files=FileSystem.GetFiles(pathInput, true);

			foreach(string file in files)
			{
				DateTime dt=FileSystem.GetFileDateTime(file);

				string year=dt.Year.ToString();
				string month=dt.Month.ToString("00");
				string day=dt.Day.ToString("00");
				
				string targetFile="";
				
				if(sort)
				{
					string targetPath=String.Format("{0}{3}{1}{3}{2}{3}", pathOutput, year, month, FileSystem.PathDelimiter);
					FileSystem.CreateDirectory(targetPath, true);
					targetFile=targetPath+FileSystem.GetFilename(file);
				}
				else
				{
					targetFile=String.Format("{0}{4}{1}-{2}-{3} - {5}", pathOutput, year, month, day, FileSystem.PathDelimiter, FileSystem.GetFilename(file));
				}
				
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
