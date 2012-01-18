//
//  FormMain.cs
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
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Text;
using System.Windows.Forms;
using Updater.minilib;
using ICSharpCode.SharpZipLib.Zip;
using System.Threading;
using System.IO;

namespace Updater
{
    public partial class FormMain:Form
    {
        Parameters InstParameters;

        string FilenameZip;
        string PathApplication;
        string FilenameApplication;

        public FormMain(string[] args)
        {
            InitializeComponent();

            InstParameters=Parameters.InterpretCommandLine(args);

            bool bFilenameZip=InstParameters.Contains("FilenameZip");
            bool bPathApplication=InstParameters.Contains("PathApplication");
            bool bFilenameApplication=InstParameters.Contains("FilenameApplication");

            if(bFilenameZip=false||bPathApplication==false||bFilenameApplication==false)
            {
                string output="Unvollständige Parameter!\n\n";
                output+="Parameterliste:\n";
                foreach(string i in args)
                {
                    output+=i+'\n';
                }

                output+="\n";
                output+="FilenameZip: "+bFilenameZip.ToString()+"\n";
                output+="PathApplication: "+bPathApplication.ToString()+"\n";
                output+="FilenameApplication: "+bFilenameApplication.ToString()+"\n";

                output+="\n";
                output+="Sollte dieser Fehler bei einem Updateprozess aufgetreten sein,\n";
                output+="so laden Sie bitte eine neue Version unter http://www.seeseekey.net herunter.";

                MessageBox.Show(output, "Hinweis");
                Environment.Exit(0);
            }

            FilenameZip=InstParameters.GetString("FilenameZip");
            PathApplication=InstParameters.GetString("PathApplication");
            FilenameApplication=InstParameters.GetString("FilenameApplication");

            PathApplication=PathApplication.TrimEnd('\\')+'\\';
        }

        private void FormMain_Load(object sender, EventArgs e)
        {
            Hide();

            Thread.Sleep(200); //Warten das sich die Wirtsanwendung beendet

            List<string> FilesToRemove=FileSystem.GetFiles(PathApplication, true);

            //Alte Dateien löschen
            foreach(string i in FilesToRemove)
            {
                if(FileSystem.GetFilename(i)=="updater.exe") continue;
                string ext=FileSystem.GetExtension(i);

                switch(ext)
                {
                    case "pdb":
                    case "def":
                    case "dll":
                    case "exe":
                    {
                        FileSystem.RemoveFile(i);
                        break;
                    }
                }
            }

            //Neue Dateien entpacken
            FastZip fz=new FastZip();
            fz.ExtractZip(FilenameZip, PathApplication, "");

            MessageBox.Show("Update komplett! Die Applikation wird nun wieder gestartet!");

            //Starte geupdatete Applikation
            Process.StartProcess(FilenameApplication);

            Close();
        }
    }
}
