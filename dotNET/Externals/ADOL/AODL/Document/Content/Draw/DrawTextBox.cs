/*************************************************************************
 *
 * DO NOT ALTER OR REMOVE COPYRIGHT NOTICES OR THIS FILE HEADER.
 * 
 * Copyright 2008 by Sun Microsystems, Inc.
 *
 * OpenOffice.org - a multi-platform office productivity suite
 *
 * $RCSfile: DrawTextBox.cs,v $
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
using System.IO;
using System.Drawing;
using System.Xml;
using AODL.Document.Styles;
using AODL.Document.Content.Text;
using AODL.Document.Content;
using AODL.Document;

namespace AODL.Document.Content.Draw
{
	/// <summary>
	/// DrawTextBox represent a draw text box which could be e.g. used
	/// to host graphic frame
	/// </summary>
	public class DrawTextBox : IContent, IContentContainer
	{
		/// <summary>
		/// If the context of the text box exceedes it's capacity,
		/// the content flows into the next text box in the chain
		/// and get or set the name of the next text box within this property.
		/// [optional]
		/// </summary>
		/// <value>The chain.</value>
		public string Chain
		{
			get 
			{ 
				XmlNode xn = this._node.SelectSingleNode("@draw:chain-next-name",
					this.Document.NamespaceManager);
				if(xn != null)
					return xn.InnerText;
				return null;
			}
			set
			{
				XmlNode xn = this._node.SelectSingleNode("@draw:chain-next-name",
					this.Document.NamespaceManager);
				if(xn == null)
					this.CreateAttribute("chain-next-name", value, "draw");
				this._node.SelectSingleNode("@draw:chain-next-name",
					this.Document.NamespaceManager).InnerText = value;
			}
		}

		/// <summary>
		/// Gets or sets the corner radius.
		/// [optional]
		/// </summary>
		/// <value>The corner radius.</value>
		public string CornerRadius
		{
			get 
			{ 
				XmlNode xn = this._node.SelectSingleNode("@draw:corner-radius",
					this.Document.NamespaceManager);
				if(xn != null)
					return xn.InnerText;
				return null;
			}
			set
			{
				XmlNode xn = this._node.SelectSingleNode("@draw:corner-radius",
					this.Document.NamespaceManager);
				if(xn == null)
					this.CreateAttribute("corner-radius", value, "draw");
				this._node.SelectSingleNode("@draw:corner-radius",
					this.Document.NamespaceManager).InnerText = value;
			}
		}

		/// <summary>
		/// Gets or sets the minimum height of the text box.
		/// [optional]
		/// </summary>
		/// <value>The height of the min.</value>
		public string MinHeight
		{
			get 
			{ 
				XmlNode xn = this._node.SelectSingleNode("@fo:min-height",
					this.Document.NamespaceManager);
				if(xn != null)
					return xn.InnerText;
				return null;
			}
			set
			{
				XmlNode xn = this._node.SelectSingleNode("@fo:min-height",
					this.Document.NamespaceManager);
				if(xn == null)
					this.CreateAttribute("min-height", value, "fo");
				this._node.SelectSingleNode("@fo:min-height",
					this.Document.NamespaceManager).InnerText = value;
			}
		}

		/// <summary>
		/// Gets or sets the minimum height of the text box.
		/// [optional]
		/// </summary>
		/// <value>The height of the min.</value>
		public string MinWidth
		{
			get 
			{ 
				XmlNode xn = this._node.SelectSingleNode("@fo:min-width",
					this.Document.NamespaceManager);
				if(xn != null)
					return xn.InnerText;
				return null;
			}
			set
			{
				XmlNode xn = this._node.SelectSingleNode("@fo:min-width",
					this.Document.NamespaceManager);
				if(xn == null)
					this.CreateAttribute("min-width", value, "fo");
				this._node.SelectSingleNode("@fo:min-width",
					this.Document.NamespaceManager).InnerText = value;
			}
		}

		/// <summary>
		/// Gets or sets the maximum width of the text box.
		/// [optional]
		/// </summary>
		/// <value>The height of the min.</value>
		public string MaxHeight
		{
			get 
			{ 
				XmlNode xn = this._node.SelectSingleNode("@fo:max-height",
					this.Document.NamespaceManager);
				if(xn != null)
					return xn.InnerText;
				return null;
			}
			set
			{
				XmlNode xn = this._node.SelectSingleNode("@fo:max-height",
					this.Document.NamespaceManager);
				if(xn == null)
					this.CreateAttribute("max-height", value, "fo");
				this._node.SelectSingleNode("@fo:max-height",
					this.Document.NamespaceManager).InnerText = value;
			}
		}

		/// <summary>
		/// Gets or sets the maximum width of the text box.
		/// [optional]
		/// </summary>
		/// <value>The height of the min.</value>
		public string MaxWidth
		{
			get 
			{ 
				XmlNode xn = this._node.SelectSingleNode("@fo:max-width",
					this.Document.NamespaceManager);
				if(xn != null)
					return xn.InnerText;
				return null;
			}
			set
			{
				XmlNode xn = this._node.SelectSingleNode("@fo:max-width",
					this.Document.NamespaceManager);
				if(xn == null)
					this.CreateAttribute("max-width", value, "fo");
				this._node.SelectSingleNode("@fo:max-width",
					this.Document.NamespaceManager).InnerText = value;
			}
		}

		/// <summary>
		/// Initializes a new instance of the <see cref="DrawTextBox"/> class.
		/// </summary>
		/// <param name="document">The document.</param>
		/// <param name="node">The node.</param>
		public DrawTextBox(IDocument document, XmlNode node)
		{
			this.Document				= document;
			this.InitStandards();
			this.Node					= node;
		}

		/// <summary>
		/// Initializes a new instance of the <see cref="DrawTextBox"/> class.
		/// </summary>
		/// <param name="document">The document.</param>
		public DrawTextBox(IDocument document)
		{
			this.Document				= document;
			this.InitStandards();
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
			this.Node		= this.Document.CreateNode("text-box", "draw");
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
				XmlNode xn = this._node.SelectSingleNode("@draw:style-name",
					this.Document.NamespaceManager);
				if(xn != null)
					return xn.InnerText;
				return null;
			}
			set
			{
				XmlNode xn = this._node.SelectSingleNode("@draw:style-name",
					this.Document.NamespaceManager);
				if(xn == null)
					this.CreateAttribute("style-name", value, "draw");
				this._node.SelectSingleNode("@draw:style-name",
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
	}
}

/*
 * $Log: DrawTextBox.cs,v $
 * Revision 1.2  2008/04/29 15:39:44  mt
 * new copyright header
 *
 * Revision 1.1  2007/02/25 08:58:32  larsbehr
 * initial checkin, import from Sourceforge.net to OpenOffice.org
 *
 * Revision 1.1  2006/01/29 11:29:46  larsbm
 * *** empty log message ***
 *
 */