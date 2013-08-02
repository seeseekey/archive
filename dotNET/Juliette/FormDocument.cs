//
//  FormDocument.cs
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
using CSCL;
using Juliette.Graphic.TWAIN;
using System.IO;

namespace Juliette
{
	public partial class FormDocument: Form
	{
		//TODO: Die Listbox auf MultiSelect

		DialogCreateMode InstDialogCreateMode;

		public int CategoryID;
		public int DocumentID;

		private string EditTableName;
		private bool DocumentImagesAreEdited=false;

		public FormDocument()
		{
			InitializeComponent();
		}

		public DialogResult ShowDialog(DialogCreateMode upDialogCreateMode)
		{
			InstDialogCreateMode=upDialogCreateMode;

			switch(InstDialogCreateMode)
			{
				case DialogCreateMode.New:
					{
						Text="Neues Dokument";

						break;
					}
				case DialogCreateMode.Edit:
					{
						Text="Dokument bearbeiten";

						//Tabelle ermitteln
						string sqlCommand=String.Format("SELECT * FROM gtjlteMain WHERE IndexID={0};", DocumentID);
						DataTable dt= Globals.InstSQLite.ExecuteQuery(sqlCommand);
						EditTableName=dt.Rows[0]["DmtTable"].ToString();

						tbLabel.Text=dt.Rows[0]["DmtLabel"].ToString();
						rtbDescription.Text=dt.Rows[0]["DmtDescription"].ToString();
						long ticks=(long)dt.Rows[0]["DmtDate"];
						dtpDate.Value=new DateTime(ticks);

						int SiteCount=(int)(long)dt.Rows[0]["DmtSiteCount"];
						for (int i=0; i<SiteCount; i++)
						{
							lbImageData.Items.Add("Seite "+(i+1));
						}

						break;
					}
			}

			return ShowDialog();
		}

		private void btnRemove_Click(object sender, EventArgs e)
		{
			if (lbImageData.SelectedIndex==-1) return;

			DocumentImagesAreEdited=true;
			lbImageData.Items.RemoveAt(lbImageData.SelectedIndex);
		}

		private void btnImageUp_Click(object sender, EventArgs e)
		{
			if (lbImageData.SelectedIndex==-1) return;
			if(lbImageData.Items.Count==0) return;
			if(lbImageData.SelectedIndex==0) return;

			DocumentImagesAreEdited=true;

			string tmp=lbImageData.Items[lbImageData.SelectedIndex-1].ToString();
			lbImageData.Items[lbImageData.SelectedIndex-1]=lbImageData.Items[lbImageData.SelectedIndex];
			lbImageData.Items[lbImageData.SelectedIndex]=tmp;

			lbImageData.SelectedIndex=lbImageData.SelectedIndex-1;
		}

		private void btnImageDown_Click(object sender, EventArgs e)
		{
			if (lbImageData.SelectedIndex==-1) return;
			if (lbImageData.Items.Count==0) return;
			if (lbImageData.SelectedIndex==lbImageData.Items.Count-1) return;

			DocumentImagesAreEdited=true;

			string tmp=lbImageData.Items[lbImageData.SelectedIndex+1].ToString();
			lbImageData.Items[lbImageData.SelectedIndex+1]=lbImageData.Items[lbImageData.SelectedIndex];
			lbImageData.Items[lbImageData.SelectedIndex]=tmp;

			lbImageData.SelectedIndex=lbImageData.SelectedIndex+1;
		}

		private void btnFile_Click(object sender, EventArgs e)
		{
			foreach(string i in lbImageData.Items)
			{
				string ext=FileSystem.GetExtension(i);

				if(Globals.PluginRegistryMain.OnlyOneFilePerDocument(ext))
				{
					if(lbImageData.Items.Count>=1)
					{
						MessageBox.Show("Es können keine weiteren Dokumente hinzugefügt werden, da der Dokumenttyp nur eine Datei pro Dokument unterstüzt!");
						return;
					}
				}
			}

			openFileDialog.Filter=Globals.PluginRegistryMain.Filter;
			openFileDialog.FileName="";

			if (openFileDialog.ShowDialog()==DialogResult.OK)
			{
				DocumentImagesAreEdited=true;

				foreach(string i in openFileDialog.FileNames)
				{
					string ext=FileSystem.GetExtension(i);
					if(Globals.PluginRegistryMain.IsDocumentTypeAllowed(ext))
					{
						if(Globals.PluginRegistryMain.OnlyOneFilePerDocument(ext))
						{
							if(lbImageData.Items.Count>0)
							{
								MessageBox.Show("Der Dokumenttyp "+ext+" kann nicht verarbeitet werden, da er die einzige Datei im Dokument sein muss!", "Hinweis");
							}
							else
							{
								lbImageData.Items.Add(i);
							}
						}
						else
						{
							lbImageData.Items.Add(i);
						}
					}
					else
					{
						MessageBox.Show("Der Dokumenttyp "+ext+" kann nicht verarbeitet werden!", "Hinweis");
					}
				}
			}
		}

		private void btnScan_Click(object sender, EventArgs e)
		{
			foreach(string i in lbImageData.Items)
			{
				string ext=FileSystem.GetExtension(i);

				if(Globals.PluginRegistryMain.OnlyOneFilePerDocument(ext))
				{
					if(lbImageData.Items.Count>=1)
					{
						MessageBox.Show("Es können keine weiteren Dokumente hinzugefügt werden, da der Dokumenttyp nur eine Datei pro Dokument unterstüzt!");
						return;
					}
				}
			}

			btnScan.Enabled=false;		

			//Scannen
			TwainController controller=new TwainController();
			controller.ScannedAll+=new ScannedAllEventHandler(Controller_ScannedAll);
			controller.BeginAcquire();
			
			DocumentImagesAreEdited=true;
		}

		/// <summary>
		/// Bild (oder Bilder?) fertig gescannt?
		/// </summary>
		/// <param name="sender"></param>
		/// <param name="e"></param>
		private void Controller_ScannedAll(object sender, ScannedAllEventArgs e)
		{
			string savename=String.Format("{0}{1}.png", Globals.OptionsTempDirectory, CSCL.Helpers.StringHelpers.GetRandomASCIIString(8));
			Image scannedPicture = e.Images[0];
			scannedPicture.Save(savename);

			savepathInvoke=savename;
			InvokeCallback RefreshListCallback=new InvokeCallback(RefreshList);
			lbImageData.Invoke(RefreshListCallback);
		}

		private string savepathInvoke="";
		private delegate void InvokeCallback();

		private void RefreshList()
		{
			lbImageData.Items.Add(savepathInvoke);
			btnScan.Enabled=true;
		}

		private void btnOK_Click(object sender, EventArgs e)
		{
			if(lbImageData.Items.Count==0)
			{
				MessageBox.Show("Es sind keine Dokumente vorhanden!\nBitte fügen Sie Dokumente hinzu!");
				return;
			}

			switch(InstDialogCreateMode)
			{
				case DialogCreateMode.New:
					{
						//Dokument anlegen
						string uid=CSCL.Various.GetUniqueID();
						string tblName="gtjlteDmt"+uid;

						//Eintrag in Tabelle Main
						DataTable dt=Globals.InstSQLite.GetTableStructure("gtjlteMain");
						DataRow dr=dt.NewRow();
						dr["DmtLabel"]=tbLabel.Text;
						dr["DmtDescription"]=rtbDescription.Text;
						dr["DmtCategory"]=CategoryID;
						dr["DmtDate"]=dtpDate.Value.Ticks;
						dr["DmtSiteCount"]=lbImageData.Items.Count;
						dr["DmtTable"]=tblName;
						dt.Rows.Add(dr);
						Globals.InstSQLite.InsertData(dt);

						//Neue Datentabelle erstellen und Füllen
						Globals.CreateDocumentDataTable(tblName);
						dt=Globals.InstSQLite.GetTableStructure(tblName);

						for(int i=0; i<lbImageData.Items.Count; i++)
						{
							dr=dt.NewRow();
							dr["DmtSiteNumber"]=i+1;
							dr["DmtFileType"]=FileSystem.GetExtension(lbImageData.Items[i].ToString());
							
							//Datei öffnen und wegspeichern
							FileStream InstFS=new FileStream(lbImageData.Items[i].ToString(), FileMode.Open, FileAccess.Read);
							byte[] FileData=new byte[InstFS.Length];
							InstFS.Read(FileData, 0, (int)InstFS.Length);
							InstFS.Close();
							dr["DmtData"]=FileData;
							dt.Rows.Add(dr);
						}

						Globals.InstSQLite.InsertData(dt);

						break;
					}
				case DialogCreateMode.Edit:
					{
						//Eintrag in Tabelle Main
						string sqlCommand=String.Format("SELECT * FROM gtjlteMain WHERE IndexID={0};", DocumentID);
						DataTable dt=Globals.InstSQLite.ExecuteQuery(sqlCommand);
						dt.Rows[0]["DmtLabel"]=tbLabel.Text;
						dt.Rows[0]["DmtDescription"]=rtbDescription.Text;
						dt.Rows[0]["DmtDate"]=dtpDate.Value.Ticks;
						dt.Rows[0]["DmtSiteCount"]=lbImageData.Items.Count;
						Globals.InstSQLite.UpdateData(dt, "IndexID");

						if(DocumentImagesAreEdited)
						{
							//File Tabelle erstellen
							List<string> Filelist=new List<string>();

							foreach(string i in lbImageData.Items)
							{
								if(i.IndexOf("Seite")==0)
								{
									int site=Convert.ToInt32(i.Split(' ')[1]);

									//Datei in Temp schreiben
									string dTable=Globals.GetDocumentDataTable(Globals.vcDmtID);
									CSCL.Imaging.Graphic SaveImage=Globals.GetDocumentSiteAsImage(dTable, site);
									string fn=Globals.OptionsTempDirectory+CSCL.Helpers.StringHelpers.GetRandomASCIIString(10)+".png";
									SaveImage.SaveToFile(fn);
									Filelist.Add(fn);
								}
								else Filelist.Add(i);
							}

							//Neue Datentabelle erstellen und Füllen
							Globals.InstSQLite.RemoveTable(EditTableName);
							Globals.CreateDocumentDataTable(EditTableName);
							dt=Globals.InstSQLite.GetTableStructure(EditTableName);

							for(int i=0; i<Filelist.Count; i++)
							{
								DataRow dr=dt.NewRow();
								dr["DmtSiteNumber"]=i+1;
								dr["DmtFileType"]=FileSystem.GetExtension(Filelist[i]);

								//Datei öffnen und wegspeichern
								FileStream InstFS=new FileStream(Filelist[i], FileMode.Open, FileAccess.Read);
								byte[] FileData=new byte[InstFS.Length];
								InstFS.Read(FileData, 0, (int)InstFS.Length);
								InstFS.Close();
								dr["DmtData"]=FileData;
								dt.Rows.Add(dr);
							}

							Globals.InstSQLite.InsertData(dt);
						}

						break;
					}
			}

			DialogResult=DialogResult.OK;
			Close();
		}

		/// <summary>
		/// Stellt fest ob eine Seite ind er Listbox exitiert
		/// </summary>
		/// <param name="site"></param>
		/// <returns></returns>
		private bool ExistsSite(int site)
		{
			foreach (string i in lbImageData.Items)
			{
				if (i=="Seite "+site.ToString())
				{
					return true;
				}
			}

			return false;
		}

		private void btnCancel_Click(object sender, EventArgs e)
		{
			Close();
		}

		private void btnScanSource_Click(object sender, EventArgs e)
		{
			//Quelle wählen
			TwainController controller=new TwainController();
			controller.Select();
		}

	}
}
