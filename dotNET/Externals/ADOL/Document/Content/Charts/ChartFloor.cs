/*************************************************************************
 *
 * DO NOT ALTER OR REMOVE COPYRIGHT NOTICES OR THIS FILE HEADER.
 * 
 * Copyright 2008 by Sun Microsystems, Inc.
 *
 * OpenOffice.org - a multi-platform office productivity suite
 *
 * $RCSfile: ChartFloor.cs,v $
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
using AODL.Document .Styles ;

namespace AODL.Document.Content.Charts
{
	/// <summary>
	/// Summary description for ChartFloor.
	/// </summary>
	public class ChartFloor : IContent
	{
		/// <summary>
		/// the chart which contains the floor
		/// </summary>
		private Chart _chart;

		public Chart Chart
		{
			get { return this._chart; }
			set { this._chart = value; }
		}

		/// <summary>
		/// the style of the floor
		/// </summary>
		

		public FloorStyle FloorStyle
		{
			get
			{
				return (FloorStyle)this.Style;
			}
			set
			{
				this.StyleName	= ((FloorStyle)value).StyleName;
				this.Style = value;
			}
		}
		/// <summary>
		/// the width of the floor
		/// </summary>
	
		public string SvgWidth
		{
			get 
			{ 
				XmlNode xn = this._node.SelectSingleNode("@svg:width",
					this.Document.NamespaceManager);
				if(xn != null)
					return xn.InnerText;
				return null;
			}
			set
			{
				XmlNode xn = this._node.SelectSingleNode("@svg:width",
					this.Document.NamespaceManager);
				if(xn == null)
					this.CreateAttribute("width", value, "svg");
				this._node.SelectSingleNode("@svg:width",
					this.Document.NamespaceManager).InnerText = value;
			}
		}

		/// <summary>
		/// the constructor of the chartfloor class
		/// </summary>
		/// <param name="document"></param>
		/// <param name="node"></param>

		public ChartFloor(IDocument document, XmlNode node)
		{
			this.Document			= document;
			this.Node				= node;
			//this.InitStandards();
		}

		/// <summary>
		/// Initializes a new instance of the ChartPlotArea class.
		/// This will create an empty cell that use the default cell style
		/// </summary>
		/// <param name="table">The table.</param>
		public ChartFloor(Chart chart)
		{
			this.Chart				= chart;
			this.Document			= chart.Document;
			this.NewXmlNode(null);
			this.FloorStyle = new FloorStyle (chart.Document);
			this.Chart .Styles .Add (this.FloorStyle );
			//this.InitStandards();
		}

		public ChartFloor(Chart chart, string styleName)
		{
			this.Chart				= chart;
			this.Document			= chart.Document;
			this.NewXmlNode(styleName);
			//this.InitStandards();

			if(styleName != null)
			{
				this.StyleName		= styleName;
				this.FloorStyle		= new FloorStyle(this.Document, styleName);
				this.Chart.Styles.Add(this.FloorStyle);
			}
		}


		private void NewXmlNode(string styleName)
		{
			this.Node		= this.Document.CreateNode("floor", "chart");

			XmlAttribute xa = this.Document.CreateAttribute("style-name", "chart");
			xa.Value		= styleName;
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
				XmlNode xn = this._node.SelectSingleNode("@chart:style-name",
					this.Document.NamespaceManager);
				if(xn != null)
					return xn.InnerText;
				return null;
			}
			set
			{
				XmlNode xn = this._node.SelectSingleNode("@chart:style-name",
					this.Document.NamespaceManager);
				if(xn == null)
					this.CreateAttribute("style-name", value, "chart");
				this._node.SelectSingleNode("@chart:style-name",
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

		private void CreateAttribute(string name, string text, string prefix)
		{
			XmlAttribute xa = this.Document.CreateAttribute(name, prefix);
			xa.Value		= text;
			this.Node.Attributes.Append(xa);
		}

	}
}