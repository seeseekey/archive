/*************************************************************************
 *
 * DO NOT ALTER OR REMOVE COPYRIGHT NOTICES OR THIS FILE HEADER.
 * 
 * Copyright 2008 by Sun Microsystems, Inc.
 *
 * OpenOffice.org - a multi-platform office productivity suite
 *
 * $RCSfile: Footnote.cs,v $
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
using AODL.Document.Styles;
using AODL.Document.TextDocuments;

namespace AODL.Document.Content.Text
{
	/// <summary>
	/// Represent a Footnote which could be 
	/// a Foot- or a Endnote
	/// </summary>
	public class Footnote : IText, IHtml, ITextContainer
	{
		/// <summary>
		/// Gets or sets the id.
		/// </summary>
		/// <value>The id.</value>
		public string Id
		{
			get 
			{
				XmlNode xn = this._node.SelectSingleNode("//@text:note-citation", 
					this.Document.NamespaceManager) ;
				if(xn != null)
					return xn.InnerText;
				return null;
			}
			set 
			{
				XmlNode xn = this._node.SelectSingleNode("//@text:note-citation",
					this.Document.NamespaceManager);
				if(xn != null)
				{
					this._node.SelectSingleNode("//@text:note-citation",
						this.Document.NamespaceManager).InnerText = value;
					this._node.SelectSingleNode("//@text:id",
						this.Document.NamespaceManager).InnerText = "ftn"+value;
				}
			}
		}

		/// <summary>
		/// Initializes a new instance of the <see cref="Footnote"/> class.
		/// </summary>
		/// <param name="document">The text document.</param>
		/// <param name="notetext">The notetext.</param>
		/// <param name="id">The id.</param>
		/// <param name="type">The type.</param>
		public Footnote(IDocument document, string notetext, string id, FootnoteType type)
		{
			this.Document		= document;
			this.NewXmlNode(id, notetext, type);
			this.InitStandards();
		}

		/// <summary>
		/// Initializes a new instance of the <see cref="Footnote"/> class.
		/// </summary>
		/// <param name="document">The text document.</param>
		public Footnote(IDocument document)
		{
			this.Document		= document;
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
		/// News the XML node.
		/// </summary>
		/// <param name="id">The id.</param>
		/// <param name="notetext">The notetext.</param>
		/// <param name="type">The type.</param>
		private void NewXmlNode(string id, string notetext, FootnoteType type)
		{			
			this.Node		= this.Document.CreateNode("note", "text");
			
			XmlAttribute xa = this.Document.CreateAttribute("id", "text");
			xa.Value		= "ftn"+id;
			this.Node.Attributes.Append(xa);

			xa				 = this.Document.CreateAttribute("note-class", "text");
			xa.Value		= type.ToString();
			this.Node.Attributes.Append(xa);

			//Node citation
			XmlNode node	 = this.Document.CreateNode("not-citation", "text");
			node.InnerText	 = id;

			this._node.AppendChild(node);

			//Node Footnode body
			XmlNode nodebody = this.Document.CreateNode("note-body", "text");

			//Node Footnode text
			node			 = this.Document.CreateNode("p", "text");
			node.InnerXml	 = notetext;

			xa				 = this.Document.CreateAttribute("style-name", "text");
			xa.Value		 = (type == FootnoteType.footnode)?"Footnote":"Endnote";
			node.Attributes.Append(xa);

			nodebody.AppendChild(node);

			this._node.AppendChild(nodebody);
		}

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
		/// The text.
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
				this.Node.InnerText	= value;
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

		/// <summary>
		/// Is null no style is available.
		/// </summary>
		/// <value></value>
		public IStyle Style
		{
			get { return null; }
			set { }
		}

		/// <summary>
		/// No style name available
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

		#region IHtml Member

		/// <summary>
		/// Return the content as Html string
		/// </summary>
		/// <returns>The html string</returns>
		public string GetHtml()
		{
			string html			= "<sup>(";
			html				+= this.Id;
			html				+= ". "+this.Text;
			html				+= ")</sup>";

			return html;
		}

		#endregion
		
	}

	/// <summary>
	/// Represent the possible footnodes
	/// </summary>
	public enum FootnoteType
	{
		/// <summary>
		/// A footnode
		/// </summary>
		footnode,
		/// <summary>
		/// A endnote
		/// </summary>
		endnote
	}
}

/*
 * $LoG$
 */