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
