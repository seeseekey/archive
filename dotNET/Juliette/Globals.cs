//
//  Globals.cs
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
using CSCL;
using CSCL.Database;
using System.Drawing;
using System.Data;
using System.IO;
using System.Windows.Forms;
using CSCL.Graphic;
using System.Threading;
using System.Diagnostics;
using Juliette.Plugins;
using CSCL.Database.SQLite;

namespace Juliette
{
	public class Globals
	{
		public static string StandardContactURL="http://seeseekey.net/pages/kontakt.php";

		#region ExceptionHandler
		[Conditional("DEBUG")]
		private static void ShowDebugButton(ExceptionHandler exceptionDialog)
		{
			exceptionDialog.ShowDebugButton=true;
		}

		/// <summary>
		/// ThreadExceptionEventHandler
		/// </summary>
		/// <param name="sender"></param>
		/// <param name="e"></param>
		public static void GlobalExceptionHandler(object sender, ThreadExceptionEventArgs e)
		{
			ExceptionInfo exceptionInfo=new ExceptionInfo(e.Exception);

			ExceptionHandler exceptionDialog=new ExceptionHandler(exceptionInfo);
			exceptionDialog.TitleText=string.Format("{0} hat ein Problem festgestellt und muss beendet werden. Klicken Sie auf \"Erweitert\", um sich detaillierte Informationen anzeigen zu lassen!", Application.ProductName);
			exceptionDialog.UnhandledException=true;
			exceptionDialog.ShowAppRestartCheckBox=true;
			exceptionDialog.ShowReportErrorLabel=true;

			exceptionDialog.SMTPServer="smtp.seeseekey.net";
            exceptionDialog.ToAdress="kontakt@seeseekey.net";
			exceptionDialog.ToName="seeseekey";

			ShowDebugButton(exceptionDialog);
			exceptionDialog.ShowDialog();
		}
		#endregion

		#region Variablen und Konstanten
		public static SQLite InstSQLite;
		public static gtImage ViewImage;

		public static int scToleranz=16;
		public static int vcSiteCount;
		public static int vcCurrentSitePrinter;
		public static int vcCurrentSite;
		public static int vcDmtID=-1;

		public static bool AcceptAfterSelectEvent=true;
		public static bool AcceptGetImageAndViewIt=true;

		public static string OptionsDirectory=FileSystem.ApplicationDataDirectory+".seeseekey.net\\juliette\\";
		public static string OptionsTempDirectory=OptionsDirectory+"temp\\";
		public static string OptionsXmlFilename=OptionsDirectory+"juliette.xml";
		public static XmlData Options=new XmlData();

		public static PluginRegistry PluginRegistryMain=new PluginRegistry();
		#endregion

		#region Datenbankfunktionen
		public static int GetSiteCount(int id)
		{
			DataTable tmpDT=Globals.InstSQLite.ExecuteQuery("SELECT * FROM gtjlteMain WHERE IndexID="+id+";");
			return (int)(long)tmpDT.Rows[0]["DmtSiteCount"];
		}

		public static string GetDocumentDataTable(int id)
		{
			DataTable tmpDT=Globals.InstSQLite.ExecuteQuery("SELECT * FROM gtjlteMain WHERE IndexID="+id+";");
			return tmpDT.Rows[0]["DmtTable"].ToString();
		}

		public static gtImage GetDocumentSiteAsImage(string DmtTable, int site)
		{
			return PluginRegistryMain.GetImage(DmtTable, site);
		}

		public class SearchInfo
		{
			public string DmtLabel;
			public int DmtIndex;
			public int DmtCategory;
		}

		public static List<SearchInfo> SearchDocuments(string DmtLabel)
		{
			if (InstSQLite==null) return new List<SearchInfo>();

			List<SearchInfo> ret=new List<SearchInfo>();

			string sqlCommand=String.Format("SELECT * FROM gtjlteMain WHERE DmtLabel LIKE\"%{0}%\";", DmtLabel);

			DataTable InstDataTable=InstSQLite.ExecuteQuery(sqlCommand);

			foreach (DataRow i in InstDataTable.Rows)
			{
				SearchInfo tmp = new SearchInfo();
				tmp.DmtLabel=i["DmtLabel"].ToString();
				tmp.DmtIndex=(int)(long)(i["IndexID"]);
				tmp.DmtCategory=(int)(long)(i["DmtCategory"]);

				ret.Add(tmp);
			}

			return ret;
		}

		public static void RenameCategory(int id, string newName)
		{
			string sqlCommand=String.Format("SELECT * FROM gtjlteCategoryTree WHERE IndexID={0};", id);
			DataTable InstDataTable=InstSQLite.ExecuteQuery(sqlCommand);

			InstDataTable.Rows[0]["ElementName"]=newName;

			InstSQLite.UpdateData(InstDataTable, "IndexID", "gtjlteCategoryTree");
		}

		public static bool RemoveCategory(int id)
		{
			string sqlCommand=String.Format("DELETE FROM gtjlteCategoryTree WHERE IndexID = \"{0}\";", id);
			InstSQLite.ExecuteNonQuery(sqlCommand);
			return true;
		}

		public static void RenameDocument(int id, string newName)
		{
			string sqlCommand=String.Format("SELECT * FROM gtjlteMain WHERE IndexID={0};", id);
			DataTable InstDataTable=InstSQLite.ExecuteQuery(sqlCommand);

			InstDataTable.Rows[0]["DmtLabel"]=newName;

			InstSQLite.UpdateData(InstDataTable, "IndexID", "gtjlteMain");
		}

		/// <summary>
		/// Legt eine neue Kategorie in der Datenbank an
		/// </summary>
		/// <param name="ParentID"></param>
		/// <param name="ElementName"></param>
		/// <param name="ElementDescription"></param>
		/// <returns>ID des neuen Eintrages</returns>
		public static DataTable AddCategory(int ParentID, string ElementName, string ElementDescription)
		{
			DataTable InstDataTable=InstSQLite.GetTableStructure("gtjlteCategoryTree");

			DataRow dr=InstDataTable.NewRow();
			dr["ParentID"]=ParentID;
			dr["ElementName"]=ElementName;
			dr["ElementDescription"]=ElementDescription;
			InstDataTable.Rows.Add(dr);

			InstSQLite.InsertData(InstDataTable);

			return InstDataTable;
		}

		public static void SetCategoryOfDocument(int docID, int catID)
		{
			string sqlCommand=String.Format("SELECT * FROM gtjlteMain WHERE IndexID={0};", docID);
			DataTable InstDataTable=InstSQLite.ExecuteQuery(sqlCommand);

			InstDataTable.Rows[0]["DmtCategory"]=catID;

			InstSQLite.UpdateData(InstDataTable, "IndexID", "gtjlteMain");
		}

		public static DataTable SetCategoryParent(int catID, int parentID)
		{
			string sqlCommand=String.Format("SELECT * FROM gtjlteCategoryTree WHERE IndexID={0};", catID);
			DataTable InstDataTable=InstSQLite.ExecuteQuery(sqlCommand);

			InstDataTable.Rows[0]["ParentID"]=parentID;

			InstSQLite.UpdateData(InstDataTable, "IndexID", "gtjlteCategoryTree");

			return InstDataTable;
		}

		public static void CreateDocumentDataTable(string tblName)
		{
			DataTable InstDataTable=new DataTable(tblName);

			//Primärschlüssel
			InstDataTable.Columns.Add("IndexID", Type.GetType("System.UInt32"));
			InstDataTable.Columns["IndexID"].AllowDBNull=false;
			InstDataTable.Columns["IndexID"].Unique=true;
			InstDataTable.Columns["IndexID"].AutoIncrement=true;

			InstDataTable.Columns.Add("DmtSiteNumber", Type.GetType("System.UInt64")); //Seitennummer
			InstDataTable.Columns.Add("DmtFileType", Type.GetType("System.String")); //Datei Typ
			InstDataTable.Columns.Add("DmtData", Type.GetType("System.Byte[]")); //Daten

			InstSQLite.CreateTable(InstDataTable);
		}

		public static TreeNode FindNodeWithCatID(TreeNodeCollection tncoll, int CatID)
		{
			TreeNode tnFound;
			foreach (TreeNode tnCurr in tncoll)
			{
				CustomTreeNodeData ctnData=(CustomTreeNodeData)tnCurr.Tag;

				if (ctnData.ID==CatID)
				{
					if (ctnData.Function==CustomTreeNodeData.enFunction.Category||
						ctnData.Function==CustomTreeNodeData.enFunction.Root)
					{
						return tnCurr;
					}
				}
				tnFound=FindNodeWithCatID(tnCurr.Nodes, CatID);
				if (tnFound!=null)
				{
					return tnFound;
				}
			}
			return null;
		}
		#endregion
	}
}
