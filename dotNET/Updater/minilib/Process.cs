//
//  Process.cs
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
using System.Text;

namespace Updater.minilib
{
    public static class Process
    {
        /// <summary>
        /// Startet den angegebenen Process mit den angegebenen Argumenten.
        /// </summary>
        /// <param name="fileName"></param>
        /// <returns></returns>
        public static bool StartProcess(string fileName)
        {
            return StartProcess(fileName, "", false);
        }

        /// <summary>
        /// Startet den angegebenen Process mit den angegebenen Argumenten.
        /// </summary>
        /// <param name="fileName"></param>
        /// <param name="argument"></param>
        /// <returns></returns>
        public static bool StartProcess(string fileName, string argument)
        {
            return StartProcess(fileName, argument, false);
        }

        /// <summary>
        /// Startet den angegebenen Process mit den angegebenen Argumenten.
        /// </summary>
        /// <param name="fileName"></param>
        /// <param name="argument"></param>
        public static bool StartProcess(string fileName, string argument, bool WaitForExit)
        {
            try
            {
                System.Diagnostics.Process proc=new System.Diagnostics.Process();
                proc.EnableRaisingEvents=false;
                proc.StartInfo.FileName=fileName;
                proc.StartInfo.Arguments=argument;
                proc.Start();
                if(WaitForExit) proc.WaitForExit();
            }
            catch
            {
                return false;
            }

            return true;
        }
    }
}
