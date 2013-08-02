/*************************************************************************
 *
 * DO NOT ALTER OR REMOVE COPYRIGHT NOTICES OR THIS FILE HEADER.
 * 
 * Copyright 2008 by Sun Microsystems, Inc.
 *
 * OpenOffice.org - a multi-platform office productivity suite
 *
 * $RCSfile: TextPageHeaderFooterBase.cs,v $
 *
 * $Revision: 1.4 $
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
using AODL.Document.Content;
using AODL.Document.Content.Text;
using AODL.Document.Content.Tables;
using AODL.Document.Styles;
using AODL.Document.TextDocuments;
using AODL.Document.Helper;
using System.Collections;
using System.Xml;

namespace AODL.Document.Styles.MasterStyles
{
	/// <summary>
	/// Summary for TextPageHeaderFooterBase.
	/// </summary>
	public class TextPageHeaderFooterBase
	{
		private TextMasterPage _textMasterPage;
		/// <summary>
		/// Gets or sets the owner text master page.
		/// </summary>
		/// <value>The text master page.</value>
		public TextMasterPage TextMasterPage
		{
			get { return this._textMasterPage; }
			set { this._textMasterPage = value; }
		}
		
		private TextDocument _textDocument;
		/// <summary>
		/// Gets or sets the text document.
		/// </summary>
		/// <value>The text document.</value>
		public TextDocument TextDocument
		{
			get { return this._textDocument; }
			set { this._textDocument = value; }
		}
		
		private XmlNode _propertyNode;
		/// <summary>
		/// Gets or sets the property node.
		/// </summary>
		/// <value>The property node.</value>
		public System.Xml.XmlNode PropertyNode
		{
			get
			{
				return this._propertyNode;
			}
			set
			{
				this._propertyNode = value;
			}
		}
		
		private XmlNode _contentNode;
		/// <summary>
		/// Gets or sets the content node.
		/// </summary>
		/// <value>The content node.</value>
		public System.Xml.XmlNode ContentNode
		{
			get
			{
				return this._contentNode;
			}
			set
			{
				this._contentNode = value;
			}
		}

		private XmlNode _styleNode;
		/// <summary>
		/// The XmlNode which represent the page layout style element.
		/// </summary>
		/// <value>The node</value>
		public System.Xml.XmlNode StyleNode
		{
			get
			{
				return this._styleNode;
			}
			set
			{
				this._styleNode = value;
			}
		}

		/// <summary>
		/// Gets or sets the min height. e.g. 0cm 
		/// </summary>
		/// <value>The height of the min.</value>
		public string MinHeight
		{
			get 
			{ 
				XmlAttribute xmlAttr = this._propertyNode.Attributes["min-height", "fo"];
				if(xmlAttr != null)
					return xmlAttr.InnerText;
				return null;
			}
			set
			{
				XmlAttribute xmlAttr = this._propertyNode.Attributes["min-height", "fo"];
				if(xmlAttr == null)
					this.CreateAttribute("min-height", value, "fo");
			}
		}

		/// <summary>
		/// Gets or sets the margin right. e.g. 0cm
		/// </summary>
		/// <value>The margin right.</value>
		public string MarginRight
		{
			get 
			{ 
				XmlAttribute xmlAttr = this._propertyNode.Attributes["margin-right", "fo"];
				if(xmlAttr != null)
					return xmlAttr.InnerText;
				return null;
			}
			set
			{
				XmlAttribute xmlAttr = this._propertyNode.Attributes["margin-right", "fo"];
				if(xmlAttr == null)
					this.CreateAttribute("margin-right", value, "fo");
			}
		}

		/// <summary>
		/// Gets or sets the margin bottom. e.g. 0.499cm
		/// </summary>
		/// <value>The margin bottom.</value>
		public string MarginBottom
		{
			get 
			{ 
				XmlAttribute xmlAttr = this._propertyNode.Attributes["margin-bottom", "fo"];
				if(xmlAttr != null)
					return xmlAttr.InnerText;
				return null;
			}
			set
			{
				XmlAttribute xmlAttr = this._propertyNode.Attributes["margin-bottom", "fo"];
				if(xmlAttr == null)
					this.CreateAttribute("margin-bottom", value, "fo");
			}
		}

		/// <summary>
		/// Gets or sets the margin top. e.g. 0.499cm
		/// </summary>
		/// <value>The margin bottom.</value>
		public string MarginTop
		{
			get 
			{ 
				XmlAttribute xmlAttr = this._propertyNode.Attributes["margin-top", "fo"];
				if(xmlAttr != null)
					return xmlAttr.InnerText;
				return null;
			}
			set
			{
				XmlAttribute xmlAttr = this._propertyNode.Attributes["margin-top", "fo"];
				if(xmlAttr == null)
					this.CreateAttribute("margin-top", value, "fo");
			}
		}

		/// <summary>
		/// Gets or sets the margin left. e.g. 0cm
		/// </summary>
		/// <value>The margin left.</value>
		public string MarginLeft
		{
			get 
			{ 
				XmlAttribute xmlAttr = this._propertyNode.Attributes["margin-top", "fo"];
				if(xmlAttr != null)
					return xmlAttr.InnerText;
				return null;
			}
			set
			{
				XmlAttribute xmlAttr = this._propertyNode.Attributes["margin-left", "fo"];
				if(xmlAttr == null)
					this.CreateAttribute("margin-left", value, "fo");
			}
		}

		private IContentCollection _contentCollection;
		/// <summary>
		/// Gets or sets the content collection.
		/// </summary>
		/// <value>The content collection.</value>
		/// <remarks>This is the content which will be displayed within the footer or the header.</remarks>
		public IContentCollection ContentCollection
		{
			get { return this._contentCollection; }
			set { this._contentCollection = value; }
		}

		/// <summary>
		/// Initializes a new instance of the <see cref="TextPageFooter"/> class.
		/// </summary>
		protected TextPageHeaderFooterBase()
		{
			this._contentCollection = new IContentCollection();
			this._contentCollection.Inserted +=new AODL.Document.Collections.CollectionWithEvents.CollectionChange(_contentCollection_Inserted);
			this._contentCollection.Removed +=new AODL.Document.Collections.CollectionWithEvents.CollectionChange(_contentCollection_Removed);
		}

		/// <summary>
		/// Create a new TextPageFooter object.
		/// !!NOTICE: The TextPageLayout of the TextMasterPage object must exist!
		/// </summary>
		/// <param name="textMasterPage">The text master page.</param>
		/// <param name="typeName">Name of the type to create header or footer.</param>
		/// <remarks>The TextPageLayout of the TextMasterPage object must exist!</remarks>
		protected void New(TextMasterPage textMasterPage, string typeName)
		{
			try
			{
				this._textMasterPage = textMasterPage;
				this._textDocument = textMasterPage.TextDocument;
				this._styleNode = this.TextDocument.CreateNode(
					"footer-style", "style");
				this._textMasterPage.TextPageLayout.StyleNode.AppendChild(this._styleNode);
			}
			catch(Exception)
			{
				throw;
			}
		}

		/// <summary>
		/// This method call will activate resp. create the header or footer 
		/// for a master page. There is no need of call it directly so its
		/// internal. Activation for footer and header will be done through
		/// the TextMasterPage object. 
		/// </summary>
		internal void Activate()
		{
			string typeName = (this is TextPageHeader) ? "header" : "footer";

			// only if the content node doesn't exist
			if(this._contentNode == null)
			{
				this._contentNode = this.TextDocument.CreateNode(
					typeName, "style");
				this._textMasterPage.Node.AppendChild(this._contentNode);
			}

			// only if the property node doesn't exist
			if(this._propertyNode == null)
			{
				this._propertyNode = this.TextDocument.CreateNode(
					"header-footer-properties", "style");
				// Set defaults
				this.MarginLeft = "0cm";
				this.MarginRight = "0cm";
				this.MinHeight = "0cm";
				this.MarginBottom = (typeName.Equals("header")) ? "0.499cm" : "0cm";
				this.MarginTop = (typeName.Equals("footer")) ? "0.499cm" : "0cm";
				this._styleNode.AppendChild(this._propertyNode);
			}
		}

		/// <summary>
		/// Create a XmlAttribute for propertie XmlNode.
		/// </summary>
		/// <param name="name">The attribute name.</param>
		/// <param name="text">The attribute value.</param>
		/// <param name="prefix">The namespace prefix.</param>
		private void CreateAttribute(string name, string text, string prefix)
		{
			XmlAttribute xa = this.TextDocument.CreateAttribute(name, prefix);
			xa.Value		= text;
			this.PropertyNode.Attributes.Append(xa);
		}

		/// <summary>
		/// Called after content was added.
		/// </summary>
		/// <param name="index">The index.</param>
		/// <param name="value">The value.</param>
		private void _contentCollection_Inserted(int index, object value)
		{
			this.ContentNode.AppendChild(((IContent)value).Node);
		}

		/// <summary>
		/// Called after content was removed.
		/// </summary>
		/// <param name="index">The index.</param>
		/// <param name="value">The value.</param>
		private void _contentCollection_Removed(int index, object value)
		{
			this.ContentNode.RemoveChild(((IContent)value).Node);
		}
	}
}
