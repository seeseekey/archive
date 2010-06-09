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