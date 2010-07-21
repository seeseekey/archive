/*************************************************************************
 *
 * DO NOT ALTER OR REMOVE COPYRIGHT NOTICES OR THIS FILE HEADER.
 * 
 * Copyright 2008 by Sun Microsystems, Inc.
 *
 * OpenOffice.org - a multi-platform office productivity suite
 *
 * $RCSfile: ChartAxis.cs,v $
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
using AODL.Document .Collections ;


namespace AODL.Document.Content.Charts
{
	/// <summary>
	/// Summary description for ChartAxis.
	/// </summary>
	public class ChartAxis : IContent, IContentContainer
	{
		/// <summary>
		/// the chart which include the chartaxis
		/// </summary>
		private Chart _chart;

		public Chart Chart
		{
			get { return this._chart; }
			set { this._chart = value; }
		}

		public AxesStyle AxesStyle
		{
			get { return (AxesStyle)this.Style; }
			set { this.Style = value; }
		}

		private ChartPlotArea _plotarea;

		public ChartPlotArea PlotArea
		{
			get { return this._plotarea; }
			set { this._plotarea = value; }
		}

		private bool _ismodified;

		public bool IsModified
		{
			get
			{
				return this._ismodified ;
			}
			set
			{
				this._ismodified =value;
			}
		}

		/// <summary>
		/// Gets or sets the axis dimension
		/// </summary>

		public string Dimension
		{
			get 
			{ 
				XmlNode xn = this._node.SelectSingleNode("@chart:dimension",
					this.Document.NamespaceManager);
				if(xn != null)
					return xn.InnerText;
				return null;
			}
			set
			{
				XmlNode xn = this._node.SelectSingleNode("@chart:dimension",
					this.Document.NamespaceManager);
				if(xn == null)
					this.CreateAttribute("dimension", value, "chart");
				this._node.SelectSingleNode("@chart:dimension",
					this.Document.NamespaceManager).InnerText = value;
			}
		}

		/// <summary>
		/// Gets or sets the axis name
		/// </summary>

		public string AxisName
		{
			get 
			{ 
				XmlNode xn = this._node.SelectSingleNode("@chart:name",
					this.Document.NamespaceManager);
				if(xn != null)
					return xn.InnerText;
				return null;
			}
			set
			{
				XmlNode xn = this._node.SelectSingleNode("@chart:name",
					this.Document.NamespaceManager);
				if(xn == null)
					this.CreateAttribute("name", value, "chart");
				this._node.SelectSingleNode("@chart:name",
					this.Document.NamespaceManager).InnerText = value;
			}
		}

		/// <summary>
		/// Inits the standards.
		/// </summary>

		private void InitStandards()
		{					    
			this.Content			= new IContentCollection();
			this.Content.Inserted	+=new CollectionWithEvents.CollectionChange(Content_Inserted);
			this.Content.Removed	+=new CollectionWithEvents.CollectionChange(Content_Removed);
		}

        /// <summary>
        /// the constructor of the chart axes
        /// </summary>
        /// <param name="document"></param>
        /// <param name="node"></param>
		public ChartAxis(IDocument document, XmlNode node)
		{
			this.Document			= document;
			this.Node				= node;
			this.InitStandards();
		}

		/// <summary>
		/// Initializes a new instance of the chartaxis class.
		/// </summary>
		/// <param name="chart">The chart.</param>
		public ChartAxis(Chart chart)
		{
			this.Chart				= chart;
			this.Document			= chart.Document;
			this.NewXmlNode(null);
			this.AxesStyle = new AxesStyle (chart.Document);
			this.Chart .Styles .Add (this.AxesStyle);
			this.InitStandards();

			if(this.AxesStyle .AxesProperties.DisplayLabel==null)
			     this.AxesStyle .AxesProperties.DisplayLabel ="true";

		}

		/// <summary>
		/// Initializes a new instance of the ChartAxis class.
		/// </summary>
		/// <param name="table">The table.</param>
		/// <param name="styleName">The style name.</param>
		public ChartAxis(Chart chart, string styleName)
		{
			this.Chart				= chart;
			this.Document			= chart.Document;
			this.NewXmlNode(styleName);
			
			

			if(styleName != null)
			{
				this.StyleName		= styleName;
				this.AxesStyle		= new AxesStyle(this.Document, styleName);
				this.Chart.Styles.Add(this.AxesStyle);
			}

			this.InitStandards();
		}

		private void NewXmlNode(string styleName) 
		{
			this.Node		= this.Document.CreateNode("axis", "chart");

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

		#region IContentContainer Member

		private IContentCollection _content;
		/// <summary>
		/// Gets or sets the content.
		/// </summary>
		/// <value>The content.</value>
		public IContentCollection Content
		{
			get
			{
				return this._content;
			}
			set
			{
				this._content = value;
			}
		}

		#endregion

		/// <summary>
		/// Content_s the inserted.
		/// </summary>
		/// <param name="index">The index.</param>
		/// <param name="value">The value.</param>
		private void Content_Inserted(int index, object value)
		{
			this.Node.AppendChild(((IContent)value).Node);
		}

		/// <summary>
		/// Content_s the removed.
		/// </summary>
		/// <param name="index">The index.</param>
		/// <param name="value">The value.</param>
		private void Content_Removed(int index, object value)
		{
			this.Node.RemoveChild(((IContent)value).Node);
		}

		private void CreateAttribute(string name, string text, string prefix)
		{
			XmlAttribute xa = this.Document.CreateAttribute(name, prefix);
			xa.Value		= text;
			this.Node.Attributes.Append(xa);
		}

		public void Setgrid()
		{
			ChartGrid grid  =  new ChartGrid (this.Chart );
			grid.GridClass  = "major";
			this.Content .Add (grid);

		}
		
	}
}

