﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using CSCL;

namespace OrganizeFilesPerDate
{
    class Program
    {
        static void Main(string[] args)
        {
            //Parameter <move/copy> <sort/rename> <input> <output>
            //Parameter <mode> <move/copy> <sort/rename> <input> <output>

            #region Upload Sorting
            bool date = args[0] == "date";
            bool move = args [1] == "move";
            bool sort = args [2] == "sort";
            string pathInput = args [3].Trim(new char[] {'"'});
            string pathOutput = args [4].Trim(new char[] {'"'});

            FileSystem.CreateDirectory(pathOutput);

            List<string> files = FileSystem.GetFiles(pathInput, true);

            foreach (string file in files)
            {
                DateTime dt = FileSystem.GetFileDateTime(file);

                string year = dt.Year.ToString();
                string month = dt.Month.ToString("00");
                string day = dt.Day.ToString("00");
				
                string targetFile = "";
				
                if (sort)
                {
                    string targetPath = String.Format("{0}{3}{1}{3}{2}{3}", pathOutput, year, month, FileSystem.PathDelimiter);
                    FileSystem.CreateDirectory(targetPath, true);
                    targetFile = targetPath + FileSystem.GetFilename(file);
                } else
                {
                    targetFile = String.Format("{0}{4}{1}-{2}-{3} - {5}", pathOutput, year, month, day, FileSystem.PathDelimiter, FileSystem.GetFilename(file));
                }
				
                if (move)
                {
                    FileSystem.MoveFile(file, targetFile);
                } else
                {
                    FileSystem.CopyFile(file, targetFile);
                }
            }
            #endregion
        }
    }
}
