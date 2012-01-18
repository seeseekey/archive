//
//  CustomTreeNodeData.cs
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

namespace Juliette
{
	public class CustomTreeNodeData: Object
	{
		public CustomTreeNodeData(enFunction upFunction)
		{
			Function=upFunction;
			ID=-1;
		}

		public CustomTreeNodeData(enFunction upFunction, int upID, string upElementName, string upElementDescription)
		{
			Function=upFunction;
			ID=upID;
			ElementName=upElementName;
			ElementDescription=upElementDescription;
		}

		public CustomTreeNodeData(enFunction upFunction, int upID, string upElementName, string upElementDescription, int upSiteCount)
		{
			Function=upFunction;
			ID=upID;
			ElementName=upElementName;
			ElementDescription=upElementDescription;
			SiteCount=upSiteCount;
		}

		public int ID=-1;
		public enFunction Function=enFunction.None;
		public string ElementName="";
		public string ElementDescription="";
		public bool DocumentsExplored=false;
		public int SiteCount;

		public enum enFunction
		{
			None, //Knoten hat keine Bedeutung
			Root, //Knoten ist Root
			Category, //Knoten ist eine Kategorie
			Document
		};
	}
}
