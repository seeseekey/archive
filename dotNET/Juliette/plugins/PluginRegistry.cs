//
//  PluginRegistry.cs
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

namespace Juliette.Plugins
{
	public class PluginRegistry
	{
		static List<IPlugin> m_plugins;

		/// <summary>
		/// Gibt den DateiFilter zurück
		/// </summary>
		public string Filter
		{
			get
			{
				string ret="";

				foreach(IPlugin i in m_plugins)
				{
					foreach(string j in i.SupportedFiletypes)
					{
						if(j=="img:png") continue; //Für Kompatibilität mit altem Format
						ret+=String.Format("{0} Dateien (.{0})|*.{0}|", j);
					}
				}

				ret=ret.TrimEnd('|');
				return ret;
			}
		}

		/// <summary>
		/// Registriert die Plugins
		/// </summary>
		public PluginRegistry()
		{
			m_plugins=new List<IPlugin>();
			m_plugins.Add(new Image()); //Image Plugin
			m_plugins.Add(new OpenDocument()); //OpenDocument Plugin
		}

		/// <summary>
		/// Gibt ein Bild der Dokumentseite zurück
		/// </summary>
		/// <param name="dmttable"></param>
		/// <param name="sitenumber"></param>
		/// <returns></returns>
		public CSCL.Imaging.Graphic GetImage(string dmttable, int sitenumber)
		{
			//Filetype ermitteln
			string sqlCommand=String.Format("SELECT DmtSiteNumber, DmtFileType, DmtData FROM \"{0}\" WHERE DmtSiteNumber={1};", dmttable, sitenumber);
			DataTable tmpDT=Globals.InstSQLite.ExecuteQuery(sqlCommand);
			string filetype=tmpDT.Rows[0]["DmtFileType"].ToString();


			foreach(IPlugin i in m_plugins)
			{
				if(i.SupportedFiletypes.IndexOf(filetype)!=-1)
				{
					return i.GetImage(dmttable, sitenumber);
				}
			}

			throw new Exception("Unknown Filetype!");
		}

		/// <summary>
		/// Gibt zurück ob der Dateityp erlaubt ist
		/// </summary>
		/// <param name="type"></param>
		/// <returns></returns>
		public bool IsDocumentTypeAllowed(string type)
		{
			foreach(IPlugin i in m_plugins)
			{
				if(i.SupportedFiletypes.IndexOf(type.ToLower())!=-1)
				{
					return true;
				}
			}

			return false;
		}

		/// <summary>
		/// Gibt das Dokument bloß aus einer Datei bestehen darf
		/// z.B. für odt, pdf etc.
		/// </summary>
		/// <param name="type"></param>
		/// <returns></returns>
		public bool OnlyOneFilePerDocument(string type)
		{
			foreach(IPlugin i in m_plugins)
			{
				if(i.SupportedFiletypes.IndexOf(type.ToLower())!=-1)
				{
					return i.OnlyOneFilePerDocument;
				}
			}

			throw new Exception("Dokumenttyp existiert nicht.");
		}
	}
}
