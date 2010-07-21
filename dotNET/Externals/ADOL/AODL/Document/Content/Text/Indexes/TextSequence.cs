/*************************************************************************
 *
 * DO NOT ALTER OR REMOVE COPYRIGHT NOTICES OR THIS FILE HEADER.
 * 
 * Copyright 2008 by Sun Microsystems, Inc.
 *
 * OpenOffice.org - a multi-platform office productivity suite
 *
 * $RCSfile: TextSequence.cs,v $
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
using AODL.Document.Content.Text;
using AODL.Document.Import.OpenDocument.NodeProcessors;
using AODL.Document.Styles;

namespace AODL.Document.Content.Text.Indexes
{
	/// <summary>
	/// Zusammenfassung für TextSequence.
	/// </summary>
	public class TextSequence : IText, ICloneable
	{
		/// <summary>
		/// Gets or sets the ref name.
		/// e.g. for a Illustration refIllustration0
		/// </summary>
		/// <value>The name of the ref.</value>
		public string RefName
		{
			get 
			{ 
				XmlNode xn = this._node.SelectSingleNode("@text:ref-name", 
					this.Document.NamespaceManager) ;
				if(xn != null)
					return xn.InnerText;
				return null;
			}
			set 
			{ 
				XmlNode xn = this._node.SelectSingleNode("@text:ref-name",
					this.Document.NamespaceManager);
				if(xn == null)
					this.CreateAttribute("ref-name", value, "text");
				this._node.SelectSingleNode("@text:ref-name",
					this.Document.NamespaceManager).InnerText = value;
			}
		}

		/// <summary>
		/// Gets or sets the name of the TextSequence.
		/// </summary>
		/// <value>The name.</value>
		public string Name
		{
			get 
			{ 
				XmlNode xn = this._node.SelectSingleNode("@text:name", 
					this.Document.NamespaceManager) ;
				if(xn != null)
					return xn.InnerText;
				return null;
			}
			set 
			{ 
				XmlNode xn = this._node.SelectSingleNode("@text:name",
					this.Document.NamespaceManager);
				if(xn == null)
					this.CreateAttribute("name", value, "text");
				this._node.SelectSingleNode("@text:name",
					this.Document.NamespaceManager).InnerText = value;
			}
		}

		/// <summary>
		/// Gets or sets the num format.
		/// e.g. 1, I, A ..
		/// </summary>
		/// <value>The num format.</value>
		public string NumFormat
		{
			get 
			{ 
				XmlNode xn = this._node.SelectSingleNode("@style:num-format", 
					this.Document.NamespaceManager) ;
				if(xn != null)
					return xn.InnerText;
				return null;
			}
			set 
			{ 
				XmlNode xn = this._node.SelectSingleNode("@style:num-format",
					this.Document.NamespaceManager);
				if(xn == null)
					this.CreateAttribute("num-format", value, "style");
				this._node.SelectSingleNode("@style:num-format",
					this.Document.NamespaceManager).InnerText = value;
			}
		}

		/// <summary>
		/// Gets or sets the formula.
		/// </summary>
		/// <value>The formula.</value>
		public string Formula
		{
			get 
			{ 
				XmlNode xn = this._node.SelectSingleNode("@text:formula", 
					this.Document.NamespaceManager) ;
				if(xn != null)
					return xn.InnerText;
				return null;
			}
			set 
			{ 
				XmlNode xn = this._node.SelectSingleNode("@text:formula",
					this.Document.NamespaceManager);
				if(xn == null)
					this.CreateAttribute("formula", value, "text");
				this._node.SelectSingleNode("@text:formula",
					this.Document.NamespaceManager).InnerText = value;
			}
		}

		/// <summary>
		/// Initializes a new instance of the <see cref="TextSequence"/> class.
		/// </summary>
		public TextSequence()
		{
		}

		/// <summary>
		/// Initializes a new instance of the <see cref="TextSequence"/> class.
		/// </summary>
		/// <param name="document">The document.</param>
		/// <param name="node">The node.</param>
		public TextSequence(IDocument document, XmlNode node)
		{
			this.Document				= document;
			this.Node					= node;
			this.InitStandards();
		}

		/// <summary>
		/// Initializes a new instance of the <see cref="TextSequence"/> class.
		/// </summary>
		/// <param name="document">The document.</param>
		public TextSequence(IDocument document)
		{
			this.Document				= document;
			this.NewXmlNode();
			this.InitStandards();
		}

		/// <summary>
		/// Inits the standards.
		/// </summary>
		private void InitStandards()
		{
			this.TextContent			= new ITextCollection();
			this.TextContent.Inserted	+=new AODL.Document.Collections.CollectionWithEvents.CollectionChange(TextContent_Inserted);
			this.TextContent.Removed	+=new AODL.Document.Collections.CollectionWithEvents.CollectionChange(TextContent_Removed);
		}

		/// <summary>
		/// Create a new XmlNode.
		/// </summary>
		private void NewXmlNode()
		{			
			this.Node		= this.Document.CreateNode("sequence", "text");
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

		#region IText Member

		private XmlNode _node;
		/// <summary>
		/// The node that represent the text content.
		/// </summary>
		/// <value></value>
		public XmlNode Node
		{
			get
			{
				return this._node;
			}
			set
			{
				this._node = value;
			}
		}

		/// <summary>
		/// Use this if use text without control character,
		/// otherwise use the the TextColllection TextContent. 
		/// </summary>
		/// <value></value>
		public string Text
		{
			get
			{
				return this.Node.InnerText;
			}
			set
			{
				this.Node.InnerText = value;
			}
		}

		private IDocument _document;
		/// <summary>
		/// The document to which this text content belongs to.
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
		/// Not supported. A TextSequence doesn't has a style
		/// </summary>
		/// <value></value>
		public IStyle Style
		{
			get
			{
				return null;
			}
			set
			{
			}
		}

		/// <summary>
		/// Not supported. A TextSequence doesn't has a style
		/// </summary>
		/// <value></value>
		public string StyleName
		{
			get 
			{ 
				return null;
			}
			set
			{
			}
		}

		#endregion

		#region ITextContainer Member

		private ITextCollection _textContent;
		/// <summary>
		/// All Content objects have a Text container. Which represents
		/// his Text this could be SimpleText, FormatedText or mixed.
		/// </summary>
		/// <value></value>
		public ITextCollection TextContent
		{
			get
			{
				return this._textContent;
			}
			set
			{
				if(this._textContent != null)
					foreach(IText text in this._textContent)
						this.Node.RemoveChild(text.Node);

				this._textContent = value;
				
				if(this._textContent != null)
					foreach(IText text in this._textContent)
						this.Node.AppendChild(text.Node);
			}
		}

		#endregion

		/// <summary>
		/// Texts the content_ inserted.
		/// </summary>
		/// <param name="index">The index.</param>
		/// <param name="value">The value.</param>
		private void TextContent_Inserted(int index, object value)
		{
			this.Node.AppendChild(((IText)value).Node);
		}

		/// <summary>
		/// Texts the content_ removed.
		/// </summary>
		/// <param name="index">The index.</param>
		/// <param name="value">The value.</param>
		private void TextContent_Removed(int index, object value)
		{
			this.Node.RemoveChild(((IText)value).Node);
		}

		#region ICloneable Member
		/// <summary>
		/// Create a deep clone of this FormatedText object.
		/// </summary>
		/// <remarks>A possible Attached Style wouldn't be cloned!</remarks>
		/// <returns>
		/// A clone of this object.
		/// </returns>
		public object Clone()
		{
			FormatedText formatedTextClone		= null;

			if(this.Document != null && this.Node != null)
			{
				TextContentProcessor tcp		= new TextContentProcessor();
				formatedTextClone				= tcp.CreateFormatedText(
					this.Document, this.Node.CloneNode(true));
			}

			return formatedTextClone;
		}

		#endregion
	}
}
