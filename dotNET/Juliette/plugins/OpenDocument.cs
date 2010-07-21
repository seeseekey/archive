using System;
using System.Collections.Generic;
using System.Text;
using CSCL.Graphic;
using System.Data;
using System.IO;
using AODL.Document.TextDocuments;

namespace Juliette.Plugins
{
	public class OpenDocument : IPlugin
	{
		/// <summary>
		/// Gibt die unterstützen Dateitypen zurück
		/// </summary>
		public List<string> SupportedFiletypes
		{
			get
			{
				List<string> ret=new List<string>();
				ret.Add("odt");
				return ret;
			}
		}

		/// <summary>
		/// Gibt das Dokument bloß aus einer Datei bestehen darf
		/// z.B. für odt, pdf etc.
		/// </summary>
		public bool OnlyOneFilePerDocument
		{
			get
			{
				return true;
			}
		}

		/// <summary>
		/// Gibt ein Bitmap zurück
		/// </summary>
		/// <returns></returns>
		public gtImage GetImage(string dmttable, int sitenumber)
		{
			gtImage ret=new gtImage();

			try
			{
				string sqlCommand=String.Format("SELECT DmtSiteNumber, DmtFileType, DmtData FROM \"{0}\"", dmttable);
				DataTable tmpDT=Globals.InstSQLite.ExecuteQuery(sqlCommand);

				string fileType=tmpDT.Rows[0]["DmtFileType"].ToString();

				MemoryStream ms=new MemoryStream((byte[])tmpDT.Rows[0]["DmtData"]);

				switch(fileType)
				{
					case "odt":
						{
							TextDocument odtDocument=new TextDocument();
							//odtDocument.Load
							break;
						}
					default:
						{
							ret=new gtImage(400, 800, gtImage.Format.RGB);
							ret.FillWithMandelbrot();
							break;
						}
				}

				//ret=gtImage.FromStream(ms);
				
				ms.Close();
			}
			catch
			{
				throw new Exception();
			}

			//string file=AARunMeFirstAndOnce.inPutFolder+@"hallo.odt";
			//FileInfo fInfo=new FileInfo(file);
			//Load a text document 
			//TextDocument textDocument=new TextDocument();
			//textDocument.Load
			//textDocument.Load(file);
			////Save it back again
			//textDocument.SaveTo(AARunMeFirstAndOnce.outPutFolder+fInfo.Name+".html");

			//string file=AARunMeFirstAndOnce.inPutFolder+@"hallo.odt";
			//FileInfo fInfo=new FileInfo(file);
			////Load a text document 
			//TextDocument textDocument=new TextDocument();
			//textDocument.Load(file);
			////Save it back again
			//textDocument.SaveTo(AARunMeFirstAndOnce.outPutFolder+fInfo.Name+".html");

			return ret;
		}
	}
}
