/*************************************************************************
 *
 * DO NOT ALTER OR REMOVE COPYRIGHT NOTICES OR THIS FILE HEADER.
 * 
 * Copyright 2008 by Sun Microsystems, Inc.
 *
 * OpenOffice.org - a multi-platform office productivity suite
 *
 * $RCSfile: ChartTitle.cs,v $
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
using AODL.Document .Content .Text ;

namespace AODL.Document.Content.Charts
{
	/// <summary>
	/// Summary description for ChartTitle.
	/// </summary>
	public class ChartTitle:IContent, IContentContainer
	{
        /// <summary>
        /// the chart which include the charttitle
        /// </summary>
		private Chart _chart;

		public Chart Chart
		{
			get { return this._chart; }
			set { this._chart = value; }
		}

		/// <summary>
		/// Gets or sets the title style.
		/// </summary>
		/// <value>The title style.</value>
		public TitleStyle TitleStyle
		{
			get
			{
				return (TitleStyle)this.Style;
			}
			set
			{
				this.StyleName	= ((TitleStyle)value).StyleName;
				this.Style = value;
			}
		}
		/// <summary>
		/// Gets or sets the horizontal position where
		/// the title should be
		/// anchored. 
		/// </summary>

		public string SvgX
		{
			get 
			{ 
				XmlNode xn = this._node.SelectSingleNode("@svg:x",
					this.Document.NamespaceManager);
				if(xn != null)
					return xn.InnerText;
				return null;
			}
			set
			{
				XmlNode xn = this._node.SelectSingleNode("@svg:x",
					this.Document.NamespaceManager);
				if(xn == null)
					this.CreateAttribute("x", value, "svg");
				this._node.SelectSingleNode("@svg:x",
					this.Document.NamespaceManager).InnerText = value;
			}
		}

		/// <summary>
		/// Gets or sets the vertical position where
		/// the title should be
		/// anchored. 
		/// </summary>

		public string SvgY
		{
			get 
			{ 
				XmlNode xn = this._node.SelectSingleNode("@svg:y",
					this.Document.NamespaceManager);
				if(xn != null)
					return xn.InnerText;
				return null;
			}
			set
			{
				XmlNode xn = this._node.SelectSingleNode("@svg:y",
					this.Document.NamespaceManager);
				if(xn == null)
					this.CreateAttribute("y", value, "svg");
				this._node.SelectSingleNode("@svg:y",
					this.Document.NamespaceManager).InnerText = value;
			}
		}


		/// <summary>
		/// Initializes a new instance of the charttitle class.
		/// </summary>
		/// <param name="document">The document.</param>
		/// <param name="node">The node.</param>
		
		public ChartTitle(IDocument document, XmlNode node)
		{
			this.Document			= document;
			this.Node				= node;
			this.InitStandards();
		}

		/// <summary>
		/// Initializes a new instance of the charttitle class.
		/// </summary>
		/// <param name="table">The table.</param>
		public ChartTitle(Chart chart)
		{
			this.Chart				= chart;
			this.Document			= chart.Document;
			this.NewXmlNode(null);
			this.InitStandards();
			this.TitleStyle = new TitleStyle (chart.Document ,null);
			this.Chart .Styles .Add (this.TitleStyle );
			//chart.Content .Add (this);
		}

		/// <summary>
		/// Initializes a new instance of the charttitle class.
		/// </summary>
		/// <param name="table">The table.</param>
		/// <param name="styleName">The style name.</param>
		public ChartTitle(Chart chart, string styleName)
		{
			this.Chart				= chart;
			this.Document			= chart.Document;
			this.NewXmlNode(styleName);
			this.InitStandards();

			if(styleName != null)
			{
				this.StyleName		= styleName;
				this.TitleStyle		= new TitleStyle(this.Document, styleName);
				this.Chart.Styles.Add(this.TitleStyle);
			}

			//chart.Content .Add (this);
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
		/// Init the title's default text
		/// </summary>

		public void InitTitle()
		{
			Paragraph para = new Paragraph (this.Chart.Document );
			para.TextContent .Add (new SimpleText (this.Document ,"Ö÷±êÌâ"));
			this.Content .Add (para);
		}

		/// <summary>
		/// set the title
		/// </summary>
		/// <param name="styleName"></param>
        
		public void SetTitle(string Title)
		{
			if(this.Content .Count!=0)			  
			{
				 for(int i=0 ;i<this.Content .Count;i++)
				    this.Content .RemoveAt(i);
			}
			Paragraph para = new Paragraph (this.Chart.Document );
			para.TextContent .Add (new SimpleText (this.Document ,Title));
			
			if(this.Chart .Document.IsLoadedFile&&!this.Chart .IsNewed)
			{
				XmlNode node = this.Chart .ChartDoc .ImportNode (para.Node,true );
				this.Node .AppendChild (node);
			}

			else
			{
				this.Content .Add (para);
			}
			
			
		}


		private void NewXmlNode(string styleName)
		{
			this.Node		= this.Document .CreateNode("title", "chart");

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




	}
}

