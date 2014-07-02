/*************************************************************************
 *
 * DO NOT ALTER OR REMOVE COPYRIGHT NOTICES OR THIS FILE HEADER.
 * 
 * Copyright 2008 by Sun Microsystems, Inc.
 *
 * OpenOffice.org - a multi-platform office productivity suite
 *
 * $RCSfile: ChartCategories.cs,v $
 *
 * $Revision: 1.2 $
 *
 * This file is part of OpenOffice.org.
 *
 * OpenOffice.org is free software: you can redistribute it and/or modify
 * it under the terms of the GNU Lesser General Public License version 3
 * only, as published by the Free Software Foundation.
 *
 * OpenOffice.org is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU Lesser General Public License version 3 for more details
 * (a copy is included in the LICENSE file that accompanied this code).
 *
 * You should have received a copy of the GNU Lesser General Public License
 * version 3 along with OpenOffice.org.  If not, see
 * <http://www.openoffice.org/license.html>
 * for a copy of the LGPLv3 License.
 *
 ************************************************************************/

using System;
using System.Xml ;
using AODL.Document .Content ;
using AODL.Document.Styles;
using AODL.Document.Styles.Properties;
using AODL.Document;

namespace AODL.Document.Content.Charts
{
	/// <summary>
	/// Summary description for ChartCategories.
	/// </summary>
	public class ChartCategories :IContent
	{

		/// <summary>
		/// the chart which include the ChartCategories
		/// </summary>
		private Chart _chart;

		public Chart Chart
		{
			get { return this._chart; }
			set { this._chart = value; }
		}

		/// <summary>
		/// gets and sets the table cell address of the categories
		/// </summary>


		public string  TableCellRange
		{
			get 
			{ 
				XmlNode xn = this._node.SelectSingleNode("@table:cell-range-address",
					this.Document.NamespaceManager);
				if(xn != null)
					return xn.InnerText;
				return null;
			}
			set
			{
				XmlNode xn = this._node.SelectSingleNode("@table:cell-range-address",
					this.Document.NamespaceManager);
				if(xn == null)
					this.CreateAttribute("cell-range-address", value, "table");
				this._node.SelectSingleNode("@table:cell-range-address",
					this.Document.NamespaceManager).InnerText = value;
			}
		}

		/// <summary>
		/// the constructor of the chart category
		/// </summary>
		/// <param name="document"></param>
		/// <param name="node"></param>

		public ChartCategories(IDocument document,XmlNode node)
		{
			this.Document =document;
			this.Node =node;
		}

		public ChartCategories(Chart chart)
		{
			this.Chart =chart;
			this.Document =chart.Document;
			this.NewXmlNode (null);
		}

		
		public ChartCategories(Chart chart, string styleName)
		{
			this.Chart =chart;
			this.Document =chart.Document;
			this.NewXmlNode (styleName);
		}



		public void NewXmlNode(string styleName)
		{
			this.Node = this.Document .CreateNode ("categories","chart");

			XmlAttribute xa=this.Document .CreateAttribute ("style-name","chart");
			xa.Value  =styleName;
			Node.Attributes .Append (xa);
		}

		private void CreateAttribute(string name, string text, string prefix)
		{
			XmlAttribute xa = this.Document.CreateAttribute(name, prefix);
			xa.Value		= text;
			this.Node.Attributes.Append(xa);
		}

		#region IContent Member

		/// <summary>
		/// Gets or sets the name of the style.
		/// </summary>
		/// <value>The name of the style.</value>
		public string StyleName
		{
			get 
			{ 
				XmlNode xn = this._node.SelectSingleNode("@table:style-name",
					this.Document.NamespaceManager);
				if(xn != null)
					return xn.InnerText;
				return null;
			}
			set
			{
				XmlNode xn = this._node.SelectSingleNode("@table:style-name",
					this.Document.NamespaceManager);
				if(xn == null)
					this.CreateAttribute("style-name", value, "table");
				this._node.SelectSingleNode("@table:style-name",
					this.Document.NamespaceManager).InnerText = value;
			}
		}

		private IDocument _document;
		/// <summary>
		/// Every object (typeof(IContent)) have to know his document.
		/// </summary>
		/// <value></value>
		public IDocument Document
		{
			get
			{
				return this._document;
			}
			set
			{
				this._document = value;
			}
		}

		private IStyle _style;
		/// <summary>
		/// A Style class wich is referenced with the content object.
		/// If no style is available this is null.
		/// </summary>
		/// <value></value>
		public IStyle Style
		{
			get
			{
				return this._style;
			}
			set
			{
				this.StyleName	= value.StyleName;
				this._style = value;
			}
		}

		private XmlNode _node;
		/// <summary>
		/// Gets or sets the node.
		/// </summary>
		/// <value>The node.</value>
		public XmlNode Node
		{
			get { return this._node; }
			set { this._node = value; }
		}

		#endregion


		
	}
}