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
using CSCL;
using CSCL.Database;
using System.Reflection;
using System.IO;
using CSCL.Graphic;
using PdfSharp.Drawing;
using PdfSharp.Pdf;
using PdfSharp.Pdf.IO;
using CSCL.Helpers;
using CSCL.Database.SQLite;

namespace Juliette
{
	public partial class FormMain:Form
	{
		//TODO: Nur Kontextmenüeinträge einblenden welche erlaubt sind
		//TODO: Fortschritt für längere Operationen
		//TODO: Suche
		//TODO: Scannen

		public FormMain()
		{
			InitializeComponent();
		}

		private void beendenToolStripMenuItem_Click(object sender, EventArgs e)
		{
			Close();
		}

		/// <summary>
		/// Erstellt eine neue Datenbank
		/// </summary>
		/// <param name="sender"></param>
		/// <param name="e"></param>
		private void neueDatenbankerstellenToolStripMenuItem_Click(object sender, EventArgs e)
		{
			saveFileDialog.Filter="Juliette Dateien (*.jdf)|*.jdf";
			saveFileDialog.DefaultExt="jdf";
			saveFileDialog.FileName="";

			if(saveFileDialog.ShowDialog()==DialogResult.OK)
			{
				#region Datenbank erzeugen
				SQLite InstSQLiteNewDB=new SQLite(saveFileDialog.FileName);
				#endregion

				#region Tabellen anlegen
				#region gtjlteMain
				DataTable InstDataTable=new DataTable("gtjlteMain");

				//Primärschlüssel
				InstDataTable.Columns.Add("IndexID", Type.GetType("System.UInt32"));
				InstDataTable.Columns["IndexID"].AllowDBNull=false;
				InstDataTable.Columns["IndexID"].Unique=true;
				InstDataTable.Columns["IndexID"].AutoIncrement=true;

				InstDataTable.Columns.Add("DmtLabel", Type.GetType("System.String")); //Bezeichnung
				InstDataTable.Columns.Add("DmtDescription", Type.GetType("System.String")); //Beschreibung
				InstDataTable.Columns.Add("DmtCategory", Type.GetType("System.UInt64")); //Kategorie
				InstDataTable.Columns.Add("DmtDate", Type.GetType("System.UInt64"));
				InstDataTable.Columns.Add("DmtSiteCount", Type.GetType("System.UInt64"));
				InstDataTable.Columns.Add("DmtTable", Type.GetType("System.String"));

				InstSQLiteNewDB.CreateTable(InstDataTable);
				#endregion

				#region gtjlteCategoryTree
				InstDataTable=new DataTable("gtjlteCategoryTree");

				//Primärschlüssel
				InstDataTable.Columns.Add("IndexID", Type.GetType("System.UInt32"));
				InstDataTable.Columns["IndexID"].AllowDBNull=false;
				InstDataTable.Columns["IndexID"].Unique=true;
				InstDataTable.Columns["IndexID"].AutoIncrement=true;

				InstDataTable.Columns.Add("ParentID", Type.GetType("System.UInt64")); //Kategorie
				InstDataTable.Columns.Add("ElementName", Type.GetType("System.String")); //Bezeichnung
				InstDataTable.Columns.Add("ElementDescription", Type.GetType("System.String")); //Beschreibung

				InstSQLiteNewDB.CreateTable(InstDataTable);
				#endregion
				#endregion

				#region Tabellen mit Defaults füllen
				#region xReflection
				Assembly MainAssembly=Assembly.GetExecutingAssembly();
				string ver=MainAssembly.GetName().Version.ToString();

				InstDataTable=SpecialTables.GetXReflection("Juliette Database Format (jdf)", "1.00", "1.00", "Juliette v"+ver);

				InstSQLiteNewDB.CreateTable(InstDataTable);
				InstSQLiteNewDB.InsertData(InstDataTable);
				#endregion
				#endregion
			}
		}

		/// <summary>
		/// Öffnet eine bestehende Datenbank
		/// </summary>
		/// <param name="sender"></param>
		/// <param name="e"></param>
		private void datenbankÖffnenToolStripMenuItem_Click(object sender, EventArgs e)
		{
			openFileDialog.Filter="Juliette Dateien (*.jdf)|*.jdf";
			openFileDialog.DefaultExt="jdf";
			openFileDialog.FileName="";

			if(openFileDialog.ShowDialog()==DialogResult.OK)
			{
				Text=String.Format("Juliette - [{0}]", openFileDialog.FileName);

				Globals.InstSQLite=new SQLite(openFileDialog.FileName);

				if(Globals.InstSQLite.CheckXReflection("Juliette Database Format (jdf)"))
				{
					BuildTreeview();
				}
				else
				{
					MessageBox.Show("Bei der ausgewählten Datei handelt es sich um keine gültige Juliette Datei.", "Hinweis");
				}
			}
		}

		/// <summary>
		/// Erzeugt den Treeview
		/// </summary>
		private void BuildTreeview()
		{
			//Treeview Bauen
			tvMain.Nodes.Clear();
			tvMain.BeginUpdate();

			//Datenbank Connection
			if(Globals.InstSQLite==null) return; //Wenn keine Datenbank dann return
			DataTable InstDatatable=Globals.InstSQLite.ExecuteQuery("SELECT * FROM gtjlteCategoryTree ORDER BY ParentID;");

			TreeNode tnRoot=new TreeNode("Juliette");
			tnRoot.Tag=new CustomTreeNodeData(CustomTreeNodeData.enFunction.Root);
			tnRoot.ImageIndex=0;
			tnRoot.SelectedImageIndex=0;
			tvMain.Nodes.Add(tnRoot);

			//Knoten finden
			FindAllNodesTV(InstDatatable, tnRoot, -1);

			//-1 Root Dokumente hinzufügen
			AddDocumentsToNodes(tnRoot);

			//Sortieren und Expanden
			tvMain.Sort();
			tvMain.Nodes[0].Expand();

			tvMain.EndUpdate();
		}

		/// <summary>
		/// Gibt die Anzahl der Kinderknoten zurück
		/// </summary>
		/// <param name="tnSelected"></param>
		/// <returns></returns>
		private int GetDocumentChildNodesCount(TreeNode tnSelected)
		{
			if(tnSelected==null) return -1;

			int count=0;

			foreach(TreeNode i in tnSelected.Nodes)
			{
				CustomTreeNodeData ctnData=(CustomTreeNodeData)i.Tag;
				if(ctnData.Function==CustomTreeNodeData.enFunction.Document) count++;
			}

			return count;
		}

		private void AddDocumentsToNodes(TreeNode tnSelected)
		{
			if(tnSelected==null) return;
			if(tnSelected.Tag==null) return;
			CustomTreeNodeData ctnData=(CustomTreeNodeData)tnSelected.Tag;

			if(ctnData.Function==CustomTreeNodeData.enFunction.Category||ctnData.Function==CustomTreeNodeData.enFunction.Root)
			{
				if(!ctnData.DocumentsExplored)
				{
					ctnData.DocumentsExplored=true;

					//Node
					DataTable InstDatatableDocuments=Globals.InstSQLite.ExecuteQuery("SELECT * FROM gtjlteMain WHERE DmtCategory="+ctnData.ID+";");
					foreach(DataRow j in InstDatatableDocuments.Rows)
					{
						string DocElementName=j["DmtLabel"].ToString();
						string DocElementDescription=j["DmtDescription"].ToString();

						int docID=(int)(long)j["IndexID"];

						TreeNode tmpNode=tnSelected.Nodes.Add(j["DmtLabel"].ToString());
						tmpNode.Tag=new CustomTreeNodeData(CustomTreeNodeData.enFunction.Document, docID, DocElementName, DocElementDescription, (int)(long)j["DmtSiteCount"]);
						tmpNode.ImageIndex=2;
						tmpNode.SelectedImageIndex=2;
					}
				}

				//ChildNodes
				foreach(TreeNode i in tnSelected.Nodes)
				{
					CustomTreeNodeData ctnDataDocument=(CustomTreeNodeData)i.Tag;

					if(ctnDataDocument.Function==CustomTreeNodeData.enFunction.Category)
					{
						if(ctnDataDocument.DocumentsExplored) return;
						ctnDataDocument.DocumentsExplored=true;

						DataTable InstDatatableDocuments=Globals.InstSQLite.ExecuteQuery("SELECT * FROM gtjlteMain WHERE DmtCategory="+ctnDataDocument.ID+";");
						foreach(DataRow j in InstDatatableDocuments.Rows)
						{
							string DocElementName=j["DmtLabel"].ToString();
							string DocElementDescription=j["DmtDescription"].ToString();

							int docID=(int)(long)j["IndexID"];

							TreeNode tmpNode=i.Nodes.Add(j["DmtLabel"].ToString());
							tmpNode.Tag=new CustomTreeNodeData(CustomTreeNodeData.enFunction.Document, docID, DocElementName, DocElementDescription, (int)(long)j["DmtSiteCount"]);
							tmpNode.ImageIndex=2;
							tmpNode.SelectedImageIndex=2;
						}
					}
				}
			}
		}

		private void FindAllNodesTV(DataTable Table, TreeNode node, int id)
		{
			foreach(DataRow i in Table.Rows)
			{
				int ParentID=(int)(long)i["ParentID"];
				int IndexID=(int)(long)i["IndexID"];

				if(ParentID==id)
				{
					string ElementName=i["ElementName"].ToString();
					string ElementDescription=i["ElementDescription"].ToString();

					TreeNode tnLeave=new TreeNode(ElementName);
					tnLeave.Tag=new CustomTreeNodeData(CustomTreeNodeData.enFunction.Category, IndexID, ElementName, ElementDescription);
					tnLeave.ImageIndex=1;
					tnLeave.SelectedImageIndex=1;
					node.Nodes.Add(tnLeave);

					//Rekursiv weiter
					FindAllNodesTV(Table, tnLeave, IndexID);
				}
			}
		}

		private void tvMain_AfterSelect(object sender, TreeViewEventArgs e)
		{
			if(Globals.AcceptAfterSelectEvent==false) return;
			if(sender==null) return;
			TreeNode tnNode=e.Node;
			if(tnNode.Tag==null) return;

			CustomTreeNodeData ctnData=(CustomTreeNodeData)tnNode.Tag;

			if(Globals.vcDmtID==ctnData.ID) return;

			//Bild ermitteln und anzeigen
			switch(ctnData.Function)
			{
				case CustomTreeNodeData.enFunction.None:
					{
						break;
					}
				case CustomTreeNodeData.enFunction.Root:
					{
						break;
					}
				case CustomTreeNodeData.enFunction.Category:
					{
						break;
					}
				case CustomTreeNodeData.enFunction.Document:
					{
						//Seitenpointer füllen
						int siteCount=Globals.GetSiteCount(ctnData.ID);

						cbSiteNumberView.Items.Clear();

						for(int i=0;i<siteCount;i++)
						{
							string SitePointer=String.Format("{0} von {1}", i+1, siteCount);
							cbSiteNumberView.Items.Add(SitePointer);
						}

						//Globale Seiten Variablen setzen
						Globals.vcSiteCount=siteCount;
						Globals.vcDmtID=ctnData.ID;

						//Bild anzeigen
						GetImageAndViewIt(ctnData.ID, 1);

						break;
					}
			}
		}

		private void GetImageAndViewIt(int id, int site)
		{
			try
			{
				if(site==-1) return;
				if(!Globals.AcceptGetImageAndViewIt) return;
				Globals.AcceptGetImageAndViewIt=false;

				string dTable=Globals.GetDocumentDataTable(id);
				Globals.ViewImage=Globals.GetDocumentSiteAsImage(dTable, site);

				pbView.Image=Globals.ViewImage.ResizeByWidth(pnlView.Width-Globals.scToleranz).ToBitmap();
				pbView.Width=pbView.Image.Width;
				pbView.Height=pbView.Image.Height;

				cbSiteNumberView.SelectedIndex=site-1;
				Globals.vcCurrentSite=site;
				Globals.AcceptGetImageAndViewIt=true;
			}
			catch
			{
				MessageBox.Show("Es trat ein Fehler beim Öffnen des Dokumentes auf!");
			}
		}

		private void pnlView_Resize(object sender, EventArgs e)
		{
			if(Globals.ViewImage==null) return;

			pbView.Image=Globals.ViewImage.ResizeByWidth(pnlView.Width-Globals.scToleranz).ToBitmap();
			pbView.Width=pbView.Image.Width;
			pbView.Height=pbView.Image.Height;
		}

		private void btnPrevSite_Click(object sender, EventArgs e)
		{
			if(Globals.vcCurrentSite<=1) return;

			GetImageAndViewIt(Globals.vcDmtID, Globals.vcCurrentSite-1); //Bild anzeigen
		}

		private void btnNextSite_Click(object sender, EventArgs e)
		{
			if(Globals.vcCurrentSite>=Globals.vcSiteCount) return;

			GetImageAndViewIt(Globals.vcDmtID, Globals.vcCurrentSite+1); //Bild anzeigen
		}

		private void cbSiteNumberView_SelectedIndexChanged(object sender, EventArgs e)
		{
			GetImageAndViewIt(Globals.vcDmtID, cbSiteNumberView.SelectedIndex+1); //Bild anzeigen
		}

		private TreeNode FindTreeNodeFromID(TreeNode startNode, int id)
		{
			//Start Node überprüfen
			CustomTreeNodeData ctnData=(CustomTreeNodeData)startNode.Tag;
			if(ctnData.Function!=CustomTreeNodeData.enFunction.Category&&ctnData.Function!=CustomTreeNodeData.enFunction.Root)
			{
				return null;
			}

			if(ctnData.ID==id) return startNode;

			//Childs überprüfen
			foreach(TreeNode i in startNode.Nodes)
			{
				CustomTreeNodeData ctnDataChild=(CustomTreeNodeData)i.Tag;

				if(ctnDataChild.Function!=CustomTreeNodeData.enFunction.Category&&ctnDataChild.Function!=CustomTreeNodeData.enFunction.Root)
				{
					return null;
				}

				if(ctnDataChild.ID==id) return i;

				if(i.Nodes.Count>0)
				{
					TreeNode tmp=FindTreeNodeFromID(i, id);
					if(tmp!=null) return tmp;
				}
			}

			return null;
		}

		/// <summary>
		/// Umbennen der Kategorie oder des Dokumentes
		/// </summary>
		/// <param name="sender"></param>
		/// <param name="e"></param>
		private void umbennenToolStripMenuItem_Click(object sender, EventArgs e)
		{
			TreeNode tnNode=tvMain.SelectedNode;
			if(tnNode.Tag==null) return;

			CustomTreeNodeData ctnData=(CustomTreeNodeData)tnNode.Tag;

			//Bild ermitteln und anzeigen
			switch(ctnData.Function)
			{
				case CustomTreeNodeData.enFunction.None:
					{
						break;
					}
				case CustomTreeNodeData.enFunction.Root:
					{
						MessageBox.Show("Die Wurzel kann nicht umbenannt werden!");
						break;
					}
				case CustomTreeNodeData.enFunction.Category:
					{
						TextInputbox InstTextInputbox=new TextInputbox();
						InstTextInputbox.FormCaption="Kategorie umbennen...";
						InstTextInputbox.FormPrompt="Bitte geben Sie den neuen Namen der Kategorie ein:";
						InstTextInputbox.DefaultValue=ctnData.ElementName;

						if(InstTextInputbox.ShowDialog()==DialogResult.OK)
						{
							Globals.RenameCategory(ctnData.ID, InstTextInputbox.InputResponse);
							ctnData.ElementName=InstTextInputbox.InputResponse;
							tnNode.Text=InstTextInputbox.InputResponse;
						}

						break;
					}
				case CustomTreeNodeData.enFunction.Document:
					{
						TextInputbox InstTextInputbox=new TextInputbox();
						InstTextInputbox.FormCaption="Dokument umbennen...";
						InstTextInputbox.FormPrompt="Bitte geben Sie den neuen Namen des Dokumentes ein:";
						InstTextInputbox.DefaultValue=ctnData.ElementName;

						if(InstTextInputbox.ShowDialog()==DialogResult.OK)
						{
							Globals.RenameDocument(ctnData.ID, InstTextInputbox.InputResponse);
							ctnData.ElementName=InstTextInputbox.InputResponse;
							tnNode.Text=InstTextInputbox.InputResponse;
						}

						break;
					}
			}
		}

		private void neueKategorieErstellenToolStripMenuItem_Click(object sender, EventArgs e)
		{
			if(tvMain.SelectedNode==null) return;
			TreeNode tnNode=tvMain.SelectedNode;
			if(tnNode.Tag==null) return;

			CustomTreeNodeData ctnData=(CustomTreeNodeData)tnNode.Tag;

			//Bild ermitteln und anzeigen
			switch(ctnData.Function)
			{
				case CustomTreeNodeData.enFunction.None:
					{
						break;
					}
				case CustomTreeNodeData.enFunction.Root:
				case CustomTreeNodeData.enFunction.Category:
					{
						TextInputbox InstTextInputbox=new TextInputbox();
						InstTextInputbox.FormCaption="Kategorie erstellen...";
						InstTextInputbox.FormPrompt="Bitte geben Sie den Namen der Kategorie ein:";
						InstTextInputbox.DefaultValue="Neue Kategorie";

						if(InstTextInputbox.ShowDialog()==DialogResult.OK)
						{
							DataTable InstDataTable=Globals.AddCategory(ctnData.ID, InstTextInputbox.InputResponse, "");
							FindAllNodesTV(InstDataTable, tnNode, ctnData.ID);
						}

						break;
					}
				case CustomTreeNodeData.enFunction.Document:
					{
						MessageBox.Show("Nur einer Kategorie kann eine Unterkategorie hinzugefügt werden!");
						break;
					}
			}
		}

		/// <summary>
		/// Erstellt ein neues Dokument
		/// </summary>
		/// <param name="sender"></param>
		/// <param name="e"></param>
		private void neuesDokumentToolStripMenuItem_Click(object sender, EventArgs e)
		{
			if(tvMain.SelectedNode==null) return;
			TreeNode tnNode=tvMain.SelectedNode;
			if(tnNode.Tag==null) return;

			CustomTreeNodeData ctnData=(CustomTreeNodeData)tnNode.Tag;

			//Bild ermitteln und anzeigen
			switch(ctnData.Function)
			{
				case CustomTreeNodeData.enFunction.None:
					{
						break;
					}
				case CustomTreeNodeData.enFunction.Root:
				case CustomTreeNodeData.enFunction.Category:
					{

						FormDocument InstFormDocument=new FormDocument();
						InstFormDocument.CategoryID=ctnData.ID;

						if(InstFormDocument.ShowDialog(DialogCreateMode.New)==DialogResult.OK)
						{
							RefreshDocumentChilds(tnNode);
						}

						break;
					}
				case CustomTreeNodeData.enFunction.Document:
					{
						MessageBox.Show("Nur einer Kategorie kann ein Dokument hinzugefügt werden!");
						break;
					}
			}
		}

		private void überToolStripMenuItem_Click(object sender, EventArgs e)
		{
			FormAbout InstFormAbout=new FormAbout();
			InstFormAbout.ShowDialog();
		}

		private void tvMain_BeforeExpand(object sender, TreeViewCancelEventArgs e)
		{
			AddDocumentsToNodes(e.Node);
		}

		private void iDAnzeigenToolStripMenuItem_Click(object sender, EventArgs e)
		{
			if(tvMain.SelectedNode==null) return;
			TreeNode tnNode=tvMain.SelectedNode;
			if(tnNode.Tag==null) return;

			CustomTreeNodeData ctnData=(CustomTreeNodeData)tnNode.Tag;
			MessageBox.Show("ID: "+ctnData.ID.ToString());
		}

		private void tvMainExpandAllToolStripMenuItem_Click(object sender, EventArgs e)
		{
			tvMain.ExpandAll();
		}

		private void RefreshDocumentChilds(TreeNode node)
		{
			Globals.AcceptAfterSelectEvent=false;

			CustomTreeNodeData ctnData=(CustomTreeNodeData)node.Tag;

			tvMain.SelectedNode=node;

			//RemoveList
			List<TreeNode> NodeRemoveList=new List<TreeNode>();

			//Document Nodes zum entfernen suchen
			for(int i=0;i<node.Nodes.Count;i++)
			{
				CustomTreeNodeData ctnDataChild=(CustomTreeNodeData)node.Nodes[i].Tag;

				if(ctnDataChild.Function==CustomTreeNodeData.enFunction.Document)
				{
					NodeRemoveList.Add(node.Nodes[i]);
				}
			}

			//Document Nodes entfernen
			foreach(TreeNode i in NodeRemoveList)
			{
				i.Remove();
			}

			//Document Nodes erneut hinzufügen
			ctnData.DocumentsExplored=true;

			//Node
			DataTable InstDatatableDocuments=Globals.InstSQLite.ExecuteQuery("SELECT * FROM gtjlteMain WHERE DmtCategory="+ctnData.ID+";");
			foreach(DataRow j in InstDatatableDocuments.Rows)
			{
				string DocElementName=j["DmtLabel"].ToString();
				string DocElementDescription=j["DmtDescription"].ToString();

				int docID=(int)(long)j["IndexID"];

				TreeNode tmpNode=node.Nodes.Add(j["DmtLabel"].ToString());
				tmpNode.Tag=new CustomTreeNodeData(CustomTreeNodeData.enFunction.Document, docID, DocElementName, DocElementDescription, (int)(long)j["DmtSiteCount"]);
				tmpNode.ImageIndex=2;
				tmpNode.SelectedImageIndex=2;
			}

			Globals.AcceptAfterSelectEvent=true;
		}

		private void dokumentInAndereKategorieVerschiebenToolStripMenuItem_Click(object sender, EventArgs e)
		{
			if(tvMain.SelectedNode==null) return;
			TreeNode tnNode=tvMain.SelectedNode;
			if(tnNode.Tag==null) return;

			CustomTreeNodeData ctnData=(CustomTreeNodeData)tnNode.Tag;

			if(ctnData.Function==CustomTreeNodeData.enFunction.Document)
			{
				FormCategoryMover InstFormCategoryMover=new FormCategoryMover();
				InstFormCategoryMover.DocumentID=ctnData.ID;

				if(InstFormCategoryMover.ShowDialog(FormCategoryMover.MoveMode.enDocument)==DialogResult.OK)
				{
					TreeNode ParentCategory=tnNode.Parent;
					RefreshDocumentChilds(ParentCategory); //Alte Sache

					TreeNode newCatTreenode=FindTreeNodeFromID(tvMain.Nodes[0], InstFormCategoryMover.CategoryID);//Neue Sache
					RefreshDocumentChilds(newCatTreenode);
				}
			}
			else
			{
				MessageBox.Show("Sie haben kein Dokument selektiert!");
			}
		}

		private void tvMainSearchIDToolStripMenuItem_Click(object sender, EventArgs e)
		{
			TreeNode tmp=FindTreeNodeFromID(tvMain.Nodes[0], 71);
			MessageBox.Show(tmp.Text);
		}

		private void kategorieLöschenToolStripMenuItem1_Click(object sender, EventArgs e)
		{
			if(tvMain.SelectedNode==null) return;
			TreeNode tnNode=tvMain.SelectedNode;
			if(tnNode.Tag==null) return;

			CustomTreeNodeData ctnData=(CustomTreeNodeData)tnNode.Tag;

			switch(ctnData.Function)
			{
				case CustomTreeNodeData.enFunction.Root:
					{
						MessageBox.Show("Der Wurzelknoten kann nicht gelöscht werden!");
						break;
					}
				case CustomTreeNodeData.enFunction.Category:
					{
						if(GetDocumentChildNodesCount(tnNode)>0)
						{
							MessageBox.Show("Nur leere Kategorien können gelöscht werden!");
							break;
						}

						if(MessageBox.Show("Möchten Sie diese Kategorie wirklich löschen?", "Kategorie löschen", MessageBoxButtons.YesNo)==DialogResult.Yes)
						{
							Globals.RemoveCategory(ctnData.ID);
							tnNode.Remove();
						}
						break;
					}
				default:
					{
						MessageBox.Show("Dies ist keine Kategorie!");
						break;
					}
			}
		}

		private void dokumentBearbeitenToolStripMenuItem_Click(object sender, EventArgs e)
		{
			if(tvMain.SelectedNode==null) return;
			TreeNode tnNode=tvMain.SelectedNode;
			if(tnNode.Tag==null) return;

			CustomTreeNodeData ctnData=(CustomTreeNodeData)tnNode.Tag;

			//Bild ermitteln und anzeigen
			switch(ctnData.Function)
			{
				case CustomTreeNodeData.enFunction.None:
					{
						break;
					}
				case CustomTreeNodeData.enFunction.Root:
				case CustomTreeNodeData.enFunction.Category:
					{
						MessageBox.Show("Dies ist kein Dokument!");

						break;
					}
				case CustomTreeNodeData.enFunction.Document:
					{
						FormDocument InstFormDocument=new FormDocument();
						InstFormDocument.DocumentID=ctnData.ID;

						if(InstFormDocument.ShowDialog(DialogCreateMode.Edit)==DialogResult.OK)
						{
							RefreshDocumentChilds(tnNode.Parent);
						}

						break;
					}
			}
		}

		private void pDFToolStripMenuItem_Click(object sender, EventArgs e)
		{
			if(tvMain.SelectedNode==null) return;
			TreeNode tnNode=tvMain.SelectedNode;
			if(tnNode.Tag==null) return;

			CustomTreeNodeData ctnData=(CustomTreeNodeData)tnNode.Tag;

			//Bild ermitteln und anzeigen
			switch(ctnData.Function)
			{
				case CustomTreeNodeData.enFunction.None:
					{
						break;
					}
				case CustomTreeNodeData.enFunction.Root:
				case CustomTreeNodeData.enFunction.Category:
					{
						MessageBox.Show("Dies ist kein Dokument!");
						break;
					}
				case CustomTreeNodeData.enFunction.Document:
					{
						saveFileDialog.Filter="PDF Datei (*.pdf)|*.pdf";
						saveFileDialog.DefaultExt="pdf";
						saveFileDialog.FileName="";

						if(saveFileDialog.ShowDialog()==DialogResult.OK)
						{
							string pdfFilename=saveFileDialog.FileName;

							PdfDocument Document=new PdfDocument();

							Document.Info.Title=ctnData.ElementName;
							Document.Info.Creator="Juliette";
							Document.Info.CreationDate=DateTime.Now;
							Document.Info.Subject=ctnData.ElementDescription;
							Document.Info.Keywords="";

							//Dokument zeichenn
							for(int i=0;i<ctnData.SiteCount;i++)
							{
								//Bild aus Datenbank holen
								string dTable=Globals.GetDocumentDataTable(ctnData.ID);
								Image PdfImage=Globals.GetDocumentSiteAsImage(dTable, i+1).ToBitmap();

								//Neue Seite
								PdfPage tmpPdfPage=Document.AddPage();

								double WidthInPt=PdfImage.Width*72/PdfImage.HorizontalResolution;
								double HeightInPt=PdfImage.Height*72/PdfImage.HorizontalResolution;

								tmpPdfPage.Width=WidthInPt;
								tmpPdfPage.Height=HeightInPt;

								XGraphics gfx=XGraphics.FromPdfPage(tmpPdfPage);

								//Bild reinmalen
								XImage image=XImage.FromGdiPlusImage(PdfImage);
								gfx.DrawImage(image, 0, 0);
							}

							//Dokument speichern
							Document.Save(pdfFilename);
						}

						break;
					}
			}
		}

		private void tbSearchTreeview_KeyDown(object sender, KeyEventArgs e)
		{
			if(e.KeyCode==Keys.Return)
			{
				List<Globals.SearchInfo> si=Globals.SearchDocuments(tbSearchTreeview.Text);

				if(si.Count==0)
				{
					MessageBox.Show("Es konnte kein Dokument mit diesem Namen gefunden werden.", "Hinweis");
					return;
				}
				else if(si.Count>1)
				{
					FormSearchResults InstFormSearchResults=new FormSearchResults();
					if(InstFormSearchResults.ShowDialog(si)==DialogResult.OK)
					{
						//FEHLER TODO 
					}
				}
			}
		}

		private void FormMain_Load(object sender, EventArgs e)
		{
			if(FileSystem.ExistsDirectory(Globals.OptionsDirectory)==false)
			{
				FileSystem.CreateDirectory(Globals.OptionsDirectory, true);
			}

			FileSystem.RemoveDirectory(Globals.OptionsTempDirectory, true);
			FileSystem.CreateDirectory(Globals.OptionsTempDirectory, true);

			Globals.Options=new XmlData(Globals.OptionsXmlFilename);

			if(!FileSystem.ExistsFile(Globals.OptionsXmlFilename))
			{
				Globals.Options.WriteElement("xml.Application.StandardDB", "");
			}

			//Einstellungen ausführen
			string StandardDBPath=Globals.Options.GetElementAsString("xml.Application.StandardDB");
			if(StandardDBPath!="")
			{
				Text=String.Format("Juliette - [{0}]", StandardDBPath);
				Globals.InstSQLite=new SQLite(StandardDBPath);
				BuildTreeview();
			}
		}

		private void optionenToolStripMenuItem_Click(object sender, EventArgs e)
		{
			FormOptions InstFormOptions=new FormOptions();
			InstFormOptions.ShowDialog();
		}

		private void tvMain_MouseClick(object sender, MouseEventArgs e)
		{
			if(e.Button==MouseButtons.Right)
			{
				if(tvMain.SelectedNode==null) return;
				TreeNode tnNode=tvMain.SelectedNode;
				if(tnNode.Tag==null) return;

				CustomTreeNodeData ctnData=(CustomTreeNodeData)tnNode.Tag;

				switch(ctnData.Function)
				{
					case CustomTreeNodeData.enFunction.None:
						{
							break;
						}
					case CustomTreeNodeData.enFunction.Root:
					case CustomTreeNodeData.enFunction.Category:
						{
							tvMain.ContextMenuStrip=cmsTreeviewCategory;
							break;
						}
					case CustomTreeNodeData.enFunction.Document:
						{
							tvMain.ContextMenuStrip=cmsTreeviewDocument;
							break;
						}
				}
			}
		}

		private void dokumentLöschenToolStripMenuItem1_Click(object sender, EventArgs e)
		{
			if(tvMain.SelectedNode==null) return;
			TreeNode tnNode=tvMain.SelectedNode;
			if(tnNode.Tag==null) return;

			CustomTreeNodeData ctnData=(CustomTreeNodeData)tnNode.Tag;

			//Bild ermitteln und anzeigen
			switch(ctnData.Function)
			{
				case CustomTreeNodeData.enFunction.None:
					{
						break;
					}
				case CustomTreeNodeData.enFunction.Root:
				case CustomTreeNodeData.enFunction.Category:
					{
						MessageBox.Show("Dies ist kein Dokument!");
						break;
					}
				case CustomTreeNodeData.enFunction.Document:
					{
						if(MessageBox.Show("Möchten Sie dieses Dokument wirklich löschen?", "Frage", MessageBoxButtons.YesNo)==DialogResult.Yes)
						{
							string sqlCommand=String.Format("SELECT * FROM gtjlteMain WHERE IndexID={0};", ctnData.ID);
							DataTable dt=Globals.InstSQLite.ExecuteQuery(sqlCommand);

							string cTable=dt.Rows[0]["DmtTable"].ToString();
							Globals.InstSQLite.RemoveEntry("gtjlteMain", "IndexID", ctnData.ID.ToString());
							Globals.InstSQLite.RemoveTable(cTable);

							RefreshDocumentChilds(tnNode.Parent);
						}

						break;
					}
			}
		}

		private void druckenToolStripMenuItem_Click(object sender, EventArgs e)
		{
			if(tvMain.SelectedNode==null)
			{
				MessageBox.Show("Es wurde kein Dokument ausgewählt!", "Hinweis");
				return;
			}

			TreeNode tnNode=tvMain.SelectedNode;
			if(tnNode.Tag==null) return;

			CustomTreeNodeData ctnData=(CustomTreeNodeData)tnNode.Tag;

			//Bild ermitteln und anzeigen
			switch(ctnData.Function)
			{
				case CustomTreeNodeData.enFunction.None:
					{
						break;
					}
				case CustomTreeNodeData.enFunction.Root:
				case CustomTreeNodeData.enFunction.Category:
					{
						MessageBox.Show("Dies ist kein Dokument!");
						break;
					}
				case CustomTreeNodeData.enFunction.Document:
					{
						if(printDialog.ShowDialog()==DialogResult.OK)
						{
							Globals.vcCurrentSitePrinter=1;
							printDocument.Print();
						}

						break;
					}
			}
		}

		private void printDocument_PrintPage(object sender, System.Drawing.Printing.PrintPageEventArgs e)
		{
			string dTable=Globals.GetDocumentDataTable(Globals.vcDmtID);
			gtImage PrintImage=Globals.GetDocumentSiteAsImage(dTable, Globals.vcCurrentSitePrinter);

			Graphics g=e.Graphics;
			g.PageUnit=GraphicsUnit.Pixel;

			PrintImage=PrintImage.ResizeByWidth(e.PageBounds.Width-Globals.scToleranz-e.MarginBounds.Left);
			g.DrawImage(PrintImage.ToBitmap(), e.MarginBounds.Left, e.MarginBounds.Top);

			if(Globals.vcCurrentSitePrinter<Globals.vcSiteCount)
			{
				Globals.vcCurrentSitePrinter++;
				e.HasMorePages=true;
			}
		}

		/// <summary>
		/// Exportiert das Dokument in das PNG Format
		/// </summary>
		/// <param name="sender"></param>
		/// <param name="e"></param>
		private void pNGToolStripMenuItem_Click(object sender, EventArgs e)
		{
			if(tvMain.SelectedNode==null) return;
			TreeNode tnNode=tvMain.SelectedNode;
			if(tnNode.Tag==null) return;

			CustomTreeNodeData ctnData=(CustomTreeNodeData)tnNode.Tag;

			//Bild ermitteln und anzeigen
			switch(ctnData.Function)
			{
				case CustomTreeNodeData.enFunction.None:
					{
						break;
					}
				case CustomTreeNodeData.enFunction.Root:
				case CustomTreeNodeData.enFunction.Category:
					{
						MessageBox.Show("Dies ist kein Dokument!");
						break;
					}
				case CustomTreeNodeData.enFunction.Document:
					{
						if(folderBrowserDialog.ShowDialog()==DialogResult.OK)
						{
							//Dokument zeichenn
							for(int i=0;i<ctnData.SiteCount;i++)
							{
								//Bild aus Datenbank holen
								string dTable=Globals.GetDocumentDataTable(ctnData.ID);
								gtImage PngImage=Globals.GetDocumentSiteAsImage(dTable, i+1);

								string savepath=folderBrowserDialog.SelectedPath+"\\"+
												  FileSystem.GetValidFilename(ctnData.ElementName)+"-"+
												  (i+1).ToString().PadLeft(4, '0')+".png";

								PngImage.SaveToFile(savepath);
							}
						}

						break;
					}
			}
		}

		private void kategorieVerschiebenToolStripMenuItem_Click(object sender, EventArgs e)
		{
			if(tvMain.SelectedNode==null) return;
			TreeNode tnNode=tvMain.SelectedNode;
			if(tnNode.Tag==null) return;

			CustomTreeNodeData ctnData=(CustomTreeNodeData)tnNode.Tag;

			if(ctnData.Function==CustomTreeNodeData.enFunction.Category)
			{
				FormCategoryMover InstFormCategoryMover=new FormCategoryMover();
				InstFormCategoryMover.DocumentID=ctnData.ID;

				if(InstFormCategoryMover.ShowDialog(FormCategoryMover.MoveMode.enCategory)==DialogResult.OK)
				{
					BuildTreeview();
				}
			}
			else
			{
				MessageBox.Show("Sie haben keine Kategorie selektiert!");
			}
		}

		private void tsbNewDatabase_Click(object sender, EventArgs e)
		{
			neueDatenbankerstellenToolStripMenuItem_Click(null, null);
		}

		private void tsbOpenDatabase_Click(object sender, EventArgs e)
		{
			datenbankÖffnenToolStripMenuItem_Click(null, null);
		}

		private void tsbPrint_Click(object sender, EventArgs e)
		{
			druckenToolStripMenuItem_Click(null, null);
		}

		private void exceptionToolStripMenuItem_Click(object sender, EventArgs e)
		{
			throw new NotImplementedException();
		}

		private void kontaktAufnehmenToolStripMenuItem_Click(object sender, EventArgs e)
		{
			System.Diagnostics.Process.Start(Globals.StandardContactURL);
		}

		private void mitStandardanwendungÖffnenToolStripMenuItem_Click(object sender, EventArgs e)
		{
			if(tvMain.SelectedNode==null) return;
			TreeNode tnNode=tvMain.SelectedNode;
			if(tnNode.Tag==null) return;

			CustomTreeNodeData ctnData=(CustomTreeNodeData)tnNode.Tag;

			//Bild ermitteln und anzeigen
			switch(ctnData.Function)
			{
				case CustomTreeNodeData.enFunction.None:
					{
						break;
					}
				case CustomTreeNodeData.enFunction.Root:
				case CustomTreeNodeData.enFunction.Category:
					{
						MessageBox.Show("Dies ist kein Dokument!");
						break;
					}
				case CustomTreeNodeData.enFunction.Document:
					{
						int SiteNumber=cbSiteNumberView.SelectedIndex+1;
						string dTable=Globals.GetDocumentDataTable(ctnData.ID);
						gtImage SaveImage=Globals.GetDocumentSiteAsImage(dTable, SiteNumber);
						string savename=String.Format("{0}{1}{2}.png", Globals.OptionsTempDirectory, CSCL.Helpers.StringHelpers.GetRandomASCIIString(8), SiteNumber);
						SaveImage.SaveToFile(savename);

						ProcessHelpers.StartProcess(savename);

						break;
					}
			}
		}

		private void öffnenMitToolStripMenuItem_Click(object sender, EventArgs e)
		{
			if(tvMain.SelectedNode==null) return;
			TreeNode tnNode=tvMain.SelectedNode;
			if(tnNode.Tag==null) return;

			CustomTreeNodeData ctnData=(CustomTreeNodeData)tnNode.Tag;

			//Bild ermitteln und anzeigen
			switch(ctnData.Function)
			{
				case CustomTreeNodeData.enFunction.None:
					{
						break;
					}
				case CustomTreeNodeData.enFunction.Root:
				case CustomTreeNodeData.enFunction.Category:
					{
						MessageBox.Show("Dies ist kein Dokument!");
						break;
					}
				case CustomTreeNodeData.enFunction.Document:
					{
						int SiteNumber=cbSiteNumberView.SelectedIndex+1;
						string dTable=Globals.GetDocumentDataTable(ctnData.ID);
						gtImage SaveImage=Globals.GetDocumentSiteAsImage(dTable, SiteNumber);
						string savename=String.Format("{0}{1}{2}.png", Globals.OptionsTempDirectory, CSCL.Helpers.StringHelpers.GetRandomASCIIString(8), SiteNumber);
						SaveImage.SaveToFile(savename);

						ProcessHelpers.StartProcess("rundll32.exe", "shell32.dll, OpenAs_RunDLL "+savename);

						break;
					}
			}
		}

		private void inDieZwischennablageKopierenToolStripMenuItem_Click(object sender, EventArgs e)
		{
			if(tvMain.SelectedNode==null) return;
			TreeNode tnNode=tvMain.SelectedNode;
			if(tnNode.Tag==null) return;

			CustomTreeNodeData ctnData=(CustomTreeNodeData)tnNode.Tag;

			//Bild ermitteln und anzeigen
			switch(ctnData.Function)
			{
				case CustomTreeNodeData.enFunction.None:
					{
						break;
					}
				case CustomTreeNodeData.enFunction.Root:
				case CustomTreeNodeData.enFunction.Category:
					{
						MessageBox.Show("Dies ist kein Dokument!");
						break;
					}
				case CustomTreeNodeData.enFunction.Document:
					{
						Clipboard.SetImage(pbView.Image);

						break;
					}
			}
		}

		private void alsPDFToolStripMenuItem_Click(object sender, EventArgs e)
		{
			if(folderBrowserDialog.ShowDialog()==DialogResult.OK)
			{
				//Alle IDs holen
				string sqlCommand=String.Format("SELECT * FROM gtjlteMain");

				DataTable InstDataTable=Globals.InstSQLite.ExecuteQuery(sqlCommand);

				foreach(DataRow row in InstDataTable.Rows)
				{
					string DmtLabel=row["DmtLabel"].ToString();
					DmtLabel=DmtLabel.Trim();
					DmtLabel=DmtLabel.Replace('/', '-');
					DmtLabel=DmtLabel.Replace('\\', '-');

					string DmtDescription=row["DmtDescription"].ToString();
					int DmtIndex=(int)(long)(row["IndexID"]);
					int DmtCategory=(int)(long)(row["DmtCategory"]);
					int DmtSiteCount=(int)(long)(row["DmtSiteCount"]);

					//PDF speichern
					string pdfFilename=FileSystem.GetPathWithPathDelimiter(folderBrowserDialog.SelectedPath)+FileSystem.GetValidFilename(DmtLabel+"_("+DmtIndex+").pdf");
					if(FileSystem.ExistsFile(pdfFilename)) continue;

					PdfDocument Document=new PdfDocument();

					Document.Info.Title=DmtLabel;
					Document.Info.Creator="Juliette";
					Document.Info.CreationDate=DateTime.Now;
					Document.Info.Subject=DmtDescription;
					Document.Info.Keywords="";

					//Dokument zeichenn
					for(int i=0;i<DmtSiteCount;i++)
					{
						//Bild aus Datenbank holen
						string dTable=Globals.GetDocumentDataTable(DmtIndex);
						Image PdfImage=Globals.GetDocumentSiteAsImage(dTable, i+1).ToBitmap();

						//Neue Seite
						PdfPage tmpPdfPage=Document.AddPage();

						double WidthInPt=PdfImage.Width*72/PdfImage.HorizontalResolution;
						double HeightInPt=PdfImage.Height*72/PdfImage.HorizontalResolution;

						tmpPdfPage.Width=WidthInPt;
						tmpPdfPage.Height=HeightInPt;

						XGraphics gfx=XGraphics.FromPdfPage(tmpPdfPage);

						//Bild reinmalen
						XImage image=XImage.FromGdiPlusImage(PdfImage);
						gfx.DrawImage(image, 0, 0);

						GC.Collect(3);
					}

					//Dokument speichern
					Document.Save(pdfFilename);
					GC.Collect(3);
				}
			}
		}

		private void alsPDFDownsizingToolStripMenuItem_Click(object sender, EventArgs e)
		{
			if(folderBrowserDialog.ShowDialog()==DialogResult.OK)
			{
				//Alle IDs holen
				string sqlCommand=String.Format("SELECT * FROM gtjlteMain");

				DataTable InstDataTable=Globals.InstSQLite.ExecuteQuery(sqlCommand);

				foreach(DataRow row in InstDataTable.Rows)
				{
					string DmtLabel=row["DmtLabel"].ToString();
					DmtLabel=DmtLabel.Trim();
					DmtLabel=DmtLabel.Replace('/', '-');
					DmtLabel=DmtLabel.Replace('\\', '-');

					string DmtDescription=row["DmtDescription"].ToString();
					int DmtIndex=(int)(long)(row["IndexID"]);
					int DmtCategory=(int)(long)(row["DmtCategory"]);
					int DmtSiteCount=(int)(long)(row["DmtSiteCount"]);

					//PDF speichern
					string pdfFilename=FileSystem.GetPathWithPathDelimiter(folderBrowserDialog.SelectedPath)+FileSystem.GetValidFilename(DmtLabel+"_("+DmtIndex+").pdf");
					if(FileSystem.ExistsFile(pdfFilename)) continue;

					PdfDocument Document=new PdfDocument();

					Document.Info.Title=DmtLabel;
					Document.Info.Creator="Juliette";
					Document.Info.CreationDate=DateTime.Now;
					Document.Info.Subject=DmtDescription;
					Document.Info.Keywords="";

					//Dokument zeichenn
					for(int i=0;i<DmtSiteCount;i++)
					{
						//Bild aus Datenbank holen
						string dTable=Globals.GetDocumentDataTable(DmtIndex);
						gtImage tmp=Globals.GetDocumentSiteAsImage(dTable, i+1);

						uint SideSize=2000;

						if(tmp.Width>SideSize||tmp.Height>SideSize)
						{
							uint newWidth=0, newHeight=0;

							double Verhaeltniss=((double)tmp.Height)/tmp.Width;

							if(tmp.Width==tmp.Height)
							{
								newWidth=SideSize;
								newHeight=SideSize;
							}
							else if(tmp.Width<tmp.Height) //Breite ist schmalste Seite
							{
								newWidth=SideSize;
								newHeight=(uint)(newWidth*Verhaeltniss);
							}
							else //Höhe ist schmalste Seite
							{
								newHeight=SideSize;
								newWidth=(uint)(newHeight/Verhaeltniss);
							}

							tmp=tmp.Resize(newWidth, newHeight);

							GC.Collect(3);
						}

						Image PdfImage=tmp.ToBitmap();

						//Neue Seite
						PdfPage tmpPdfPage=Document.AddPage();

						double WidthInPt=PdfImage.Width*72/PdfImage.HorizontalResolution;
						double HeightInPt=PdfImage.Height*72/PdfImage.HorizontalResolution;

						tmpPdfPage.Width=WidthInPt;
						tmpPdfPage.Height=HeightInPt;

						XGraphics gfx=XGraphics.FromPdfPage(tmpPdfPage);

						//Bild reinmalen
						XImage image=XImage.FromGdiPlusImage(PdfImage);
						gfx.DrawImage(image, 0, 0);

						GC.Collect(3);
					}

					//Dokument speichern
					Document.Save(pdfFilename);
					GC.Collect(3);
				}
			}
		}
	}
}
