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