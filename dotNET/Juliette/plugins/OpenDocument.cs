//
//  OpenDocument.cs
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
using System.Data;
using System.IO;
using CSCL.Imaging;

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
		public CSCL.Imaging.Graphic GetImage(string dmttable, int sitenumber)
		{
			CSCL.Imaging.Graphic ret=new CSCL.Imaging.Graphic();

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
							//TextDocument odtDocument=new TextDocument();
							//odtDocument.Load
							break;
						}
					default:
						{
							ret=new CSCL.Imaging.Graphic(400, 800, Format.RGB);
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

			return ret;
		}
	}
}
