using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Text;
using System.Windows.Forms;

namespace CloudFileSync
{
	//TODO Reconect after settings change
	public partial class FormPreferences : Form
	{
		public FormPreferences()
		{
			InitializeComponent();
		}

		private void btnOK_Click(object sender, EventArgs e)
		{
			//Optionen schreiben
			Globals.Options.WriteElement("xml.Options.Paths.SyncFolder", tbFolderToSync.Text);

			Globals.Options.WriteElement("xml.Options.FTP.Folder", "/");
			Globals.Options.WriteElement("xml.Options.FTP.Server", tbFTPServer.Text);
			Globals.Options.WriteElement("xml.Options.FTP.User", tbFTPUser.Text);
			Globals.Options.WriteElement("xml.Options.FTP.Password", tbFTPPassword.Text);
			Globals.Options.WriteElement("xml.Options.FTP.Protocol", cbFTPProtocol.Text);

			//Formular schließen
			Close();
		}

		private void FormPreferences_Load(object sender, EventArgs e)
		{
			cbFTPProtocol.SelectedIndex=0;

			//Optionen laden
			tbFolderToSync.Text=Globals.Options.GetElementAsString("xml.Options.Paths.SyncFolder");

			tbFTPServer.Text=Globals.Options.GetElementAsString("xml.Options.FTP.Server");
			tbFTPUser.Text=Globals.Options.GetElementAsString("xml.Options.FTP.User");
			tbFTPPassword.Text=Globals.Options.GetElementAsString("xml.Options.FTP.Password");
			cbFTPProtocol.Text=Globals.Options.GetElementAsString("xml.Options.FTP.Protocol");
		}

		private void btnBrowseSyncFolder_Click(object sender, EventArgs e)
		{
			folderBrowserDialog.SelectedPath=tbFolderToSync.Text;

			if(folderBrowserDialog.ShowDialog()==DialogResult.OK)
			{
				tbFolderToSync.Text=folderBrowserDialog.SelectedPath;
			}
		}
	}
}