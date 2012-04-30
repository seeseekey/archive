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
			string pathInput=args[0];
			string pathOutput=args[1];

			FileSystem.CreateDirectory(pathOutput);

			List<string> files=FileSystem.GetFiles(pathInput, true);

			foreach(string file in files)
			{
				DateTime dt=FileSystem.GetFileDateTime(file);

				string year=dt.Year.ToString();
				string month=dt.Month.ToString("00");

				string copyPath=String.Format("{0}{1}\\{2}\\", pathOutput, year, month);
				FileSystem.CreateDirectory(copyPath, true);

				string copyFile=copyPath+FileSystem.GetFilename(file);

				FileSystem.CopyFile(file, copyFile);
			}
			#endregion
		}
	}
}
