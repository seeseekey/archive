//
//  FormPreferences.cs
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
