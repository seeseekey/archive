/*************************************************************************
 *
 * DO NOT ALTER OR REMOVE COPYRIGHT NOTICES OR THIS FILE HEADER.
 * 
 * Copyright 2008 by Sun Microsystems, Inc.
 *
 * OpenOffice.org - a multi-platform office productivity suite
 *
 * $RCSfile: List.cs,v $
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
using System.Xml;
using AODL.Document;
using AODL.Document.Styles;
using AODL.Document.Content;

namespace AODL.Document.Content.Text
{
	/// <summary>
	/// Represent a list which could be a numbered or bullet style list.
	/// </summary>
	public class List : IContent, IContentContainer, IHtml
	{
		private ParagraphStyle _paragraphstyle;
		/// <summary>
		/// The ParagraphStyle to which this List belongs.
		/// There is only one ParagraphStyle per List and
		/// its ListItems.
		/// </summary>
		public ParagraphStyle ParagraphStyle
		{
			get { return this._paragraphstyle; }
			set { this._paragraphstyle = value; }
		}

		/// <summary>
		/// Gets or sets the list style.
		/// </summary>
		/// <value>The list style.</value>
		public ListStyle ListStyle
		{
			get { return (ListStyle)this.Style; }
			set { this.Style = (IStyle)value; }
		}

		private IContentCollection _content;
		/// <summary>
		/// The ContentCollection of access
		/// to their list items.
		/// </summary>
		public IContentCollection Content
		{
			get { return this._content; }
			set { this._content = value; }
		}

		private ListStyles _type;
		/// <summary>
		/// Gets the type of the list.
		/// </summary>
		/// <value>The type of the list.</value>
		public ListStyles ListType
		{
			get { return this._type; }
		}

		/// <summary>
		/// Initializes a new instance of the <see cref="List"/> class.
		/// </summary>
		/// <param name="document">The document.</param>
		/// <param name="node">The node.</param>
		public List(IDocument document, XmlNode node)
		{
			this.Document						= document;
			this.Node							= node;
			this.InitStandards();
		}

		/// <summary>
		/// Create a new List object
		/// </summary>
		/// <param name="document">The IDocument</param>
		/// <param name="styleName">The style name</param>
		/// <param name="typ">The list typ bullet, ..</param>
		/// <param name="paragraphStyleName">The style name for the ParagraphStyle.</param>
		public List(IDocument document, string styleName, ListStyles typ, string paragraphStyleName)
		{
			this.Document						= document;
			this.NewXmlNode();
			this.InitStandards();

			this.Style							= (IStyle)new ListStyle(this.Document, styleName);
			this.ParagraphStyle					= new ParagraphStyle(this.Document, paragraphStyleName);
			this.Document.Styles.Add(this.Style);
			this.Document.Styles.Add(this.ParagraphStyle);
			
			this.ParagraphStyle.ListStyleName	= styleName;
			this._type							= typ;

			((ListStyle)this.Style).AutomaticAddListLevelStyles(typ);			
		}

		/// <summary>
		/// Create a new List which is used to represent a inner list.
		/// </summary>
		/// <param name="document">The IDocument</param>
		/// <param name="outerlist">The List to which this List belongs.</param>
		public List(IDocument document, List outerlist)
		{
			this.Document						= document;
			this.ParagraphStyle					= outerlist.ParagraphStyle;			
			this.InitStandards();
			this._type							= outerlist.ListType;
			//Create an inner list node, don't need a style
			//use the parents list style
			this.NewXmlNode();
		}

		/// <summary>
		/// Inits the standards.
		/// </summary>
		private void InitStandards()
		{
			this.Content				= new IContentCollection();

			this.Content.Inserted		+=new AODL.Document.Collections.CollectionWithEvents.CollectionChange(Content_Inserted);
			this.Content.Removed		+=new AODL.Document.Collections.CollectionWithEvents.CollectionChange(Content_Removed);
		}

		/// <summary>
		/// Create a new XmlNode.
		/// </summary>
		private void NewXmlNode()
		{			
			this.Node					= this.Document.CreateNode("list", "text");
		}

		/// <summary>
		/// Create a XmlAttribute for propertie XmlNode.
		/// </summary>
		/// <param name="name">The attribute name.</param>
		/// <param name="text">The attribute value.</param>
		/// <param name="prefix">The namespace prefix.</param>
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
				XmlNode xn = this._node.SelectSingleNode("@text:style-name",
					this.Document.NamespaceManager);
				if(xn != null)
					return xn.InnerText;
				return null;
			}
			set
			{
				XmlNode xn = this._node.SelectSingleNode("@text:style-name",
					this.Document.NamespaceManager);
				if(xn == null)
					this.CreateAttribute("style-name", value, "text");
				this._node.SelectSingleNode("@text:style-name",
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

		#region IHtml Member

		/// <summary>
		/// Return the content as Html string
		/// </summary>
		/// <returns>The html string</returns>
		public string GetHtml()
		{
			string html			= null;

			if(this.ListType == ListStyles.Bullet)
				html			= "<ul>\n";
			else if(this.ListType == ListStyles.Number)
				html			= "<ol>\n";
			
			foreach(IContent content in this.Content)
				if(content is IHtml)
					html		+= ((IHtml)content).GetHtml();

			if(this.ListType == ListStyles.Bullet)
				html			+= "</ul>\n";
			else if(this.ListType == ListStyles.Number)
				html			+= "</ol>\n";
			//html				+= "</ul>\n";

			return html;
		}

		#endregion
	}
}
