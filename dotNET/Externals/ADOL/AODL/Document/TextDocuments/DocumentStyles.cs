/*************************************************************************
 *
 * DO NOT ALTER OR REMOVE COPYRIGHT NOTICES OR THIS FILE HEADER.
 * 
 * Copyright 2008 by Sun Microsystems, Inc.
 *
 * OpenOffice.org - a multi-platform office productivity suite
 *
 * $RCSfile: DocumentStyles.cs,v $
 *
 * $Revision: 1.3 $
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
using System.Reflection;
using System.IO;
using AODL.Document.Content.Text;
using AODL.Document.Styles;
using AODL.Document.Styles.MasterStyles;
using AODL.Document;
using AODL.Document.TextDocuments;

namespace AODL.Document.TextDocuments
{
	/// <summary>
	/// DocumentStyles global Document Style
	/// </summary>
	public class DocumentStyles
	{
		/// <summary>
		/// The file name.
		/// </summary>
		public static readonly string FileName		= "styles.xml";
		/// <summary>
		/// XPath to the document office styles
		/// </summary>
		private static readonly string OfficeStyles	= "/office:document-style/office:styles";

		private XmlDocument _styles;
		/// <summary>
		/// Gets or sets the styles.
		/// </summary>
		/// <value>The styles.</value>
		public XmlDocument Styles
		{
			get { return this._styles; }
			set { this._styles = value; }
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

		/// <summary>
		/// Initializes a new instance of the <see cref="DocumentStyles"/> class.
		/// </summary>
		public DocumentStyles()
		{
		}

		/// <summary>
		/// Load the style from assmebly resource.
		/// </summary>
		public virtual void New()
		{
			try
			{
				Assembly ass		= Assembly.GetExecutingAssembly();
				Stream str			= ass.GetManifestResourceStream("AODL.Resources.OD.styles.xml");
				this.Styles			= new XmlDocument();
				this.Styles.Load(str);				
			}
			catch(Exception ex)
			{
				throw;
			}
		}

		/// <summary>
		/// Create new document styles document and set the owner text document.
		/// </summary>
		/// <param name="ownerTextDocument">The owner text document.</param>
		public virtual void New(TextDocument ownerTextDocument)
		{
			try
			{
				this._textDocument = ownerTextDocument;
				this.New();
			}
			catch(Exception ex)
			{
				throw;
			}
		}

		/// <summary>
		/// Loads from file.
		/// </summary>
		/// <param name="file">The file.</param>
		public void LoadFromFile(string file)
		{
			try
			{
				this.Styles		= new XmlDocument();
				this.Styles.Load(file);
			}
			catch(Exception ex)
			{
				throw;
			}
		}

		/// <summary>
		/// Inserts a office styles node.
		/// </summary>
		/// <param name="aStyleNode">A style node.</param>
		/// <param name="document">The AODL document.</param>
		public virtual void InsertOfficeStylesNode(XmlNode aStyleNode, IDocument document)
		{
			this.Styles.SelectSingleNode("//office:styles",
				document.NamespaceManager).AppendChild(aStyleNode);
		}

		/// <summary>
		/// Inserts the office styles node into this XML style document.
		/// </summary>
		/// <param name="aStyleNode">A style node.</param>
		/// <param name="xmlNamespaceMng">The XML namespace MNG.</param>
		public virtual void InsertOfficeStylesNode(XmlNode aStyleNode, XmlNamespaceManager xmlNamespaceMng)
		{
			this.Styles.SelectSingleNode("//office:styles",
				xmlNamespaceMng).AppendChild(aStyleNode);
		}

		/// <summary>
		/// Inserts the office automatic styles node into this XML style document.
		/// </summary>
		/// <param name="aOfficeAutomaticStyleNode">A office automatic style node.</param>
		/// <param name="xmlNamespaceMng">The XML namespace MNG.</param>
		public virtual void InsertOfficeAutomaticStylesNode(XmlNode aOfficeAutomaticStyleNode, XmlNamespaceManager xmlNamespaceMng)
		{
			this.Styles.SelectSingleNode("//office:automatic-styles",
				xmlNamespaceMng).AppendChild(aOfficeAutomaticStyleNode);
		}

		/// <summary>
		/// Inserts the office master styles node into this XML style document.
		/// </summary>
		/// <param name="aOfficeMasterStyleNode">A office master style node.</param>
		/// <param name="xmlNamespaceMng">The XML namespace MNG.</param>
		public virtual void InsertOfficeMasterStylesNode(XmlNode aOfficeMasterStyleNode, XmlNamespaceManager xmlNamespaceMng)
		{
			this.Styles.SelectSingleNode("//office:master-styles",
				xmlNamespaceMng).AppendChild(aOfficeMasterStyleNode);
		}

		/// <summary>
		/// Sets the outline style.
		/// </summary>
		/// <param name="outlineLevel">The outline level.</param>
		/// <param name="numFormat">The num format.</param>
		/// <param name="document">The text document.</param>
		public void SetOutlineStyle(int outlineLevel, string numFormat, TextDocument document)
		{
			try
			{
				XmlNode outlineStyleNode		= null;
				foreach(IStyle iStyle in document.CommonStyles)
					if(iStyle.Node.Name == "text:outline-style")
						outlineStyleNode = iStyle.Node;
//				XmlNode outlineStyleNode		= this.Styles.SelectSingleNode(
//					"//text:outline-style",
//					document.NamespaceManager);

				XmlNode outlineLevelNode		= null;
				if(outlineStyleNode != null)
					outlineLevelNode			= outlineStyleNode.SelectSingleNode(
						"text:outline-level-style[@text:level='"+outlineLevel.ToString()+"']",
						document.NamespaceManager);

				if(outlineLevelNode != null)
				{
					XmlNode numberFormatNode	= outlineLevelNode.SelectSingleNode(
						"@style:num-format", document.NamespaceManager);
					if(numberFormatNode != null)
						numberFormatNode.InnerText	= numFormat;

					XmlAttribute xa				= document.CreateAttribute(
						"num-suffix", "style");
					xa.InnerText				= ".";
					outlineLevelNode.Attributes.Append(xa);

					if(outlineLevel > 1)
					{
						xa						= document.CreateAttribute(
							"display-levels", "text");
						xa.InnerText				= outlineLevel.ToString();
						outlineLevelNode.Attributes.Append(xa);
					}
				}
			}
			catch(Exception ex)
			{
				throw;
			}
		}

		/// <summary>
		/// Inserts the footer.
		/// </summary>
		/// <param name="content">The content.</param>
		/// <param name="document">The document.</param>
		internal void InsertFooter(Paragraph content, TextDocument document)
		{
			try
			{
				bool exist			= true;
				XmlNode node		= this._styles.SelectSingleNode("//office:master-styles/style:master-page/style:footer", document.NamespaceManager);//
				if(node != null)
					node.InnerXml	= "";
				else
				{
					node			= this.CreateNode("footer", "style", document);
					exist			= false;
				}

				XmlNode	impnode		= this.Styles.ImportNode(content.Node, true);
				node.AppendChild(impnode);

				if(!exist)
					this._styles.SelectSingleNode("//office:master-styles/style:master-page", 
						document.NamespaceManager).AppendChild(node);

				this.InsertParagraphStyle(content, document);
			}
			catch(Exception ex)
			{
				throw;
			}
		}

		/// <summary>
		/// Inserts the header.
		/// </summary>
		/// <param name="content">The content.</param>
		/// <param name="document">The document.</param>
		internal void InsertHeader(Paragraph content, TextDocument document)
		{
			try
			{
				bool exist			= true;
				XmlNode node		= this._styles.SelectSingleNode("//office:master-styles/style:master-page/style:header", document.NamespaceManager);//
				if(node != null)
					node.InnerXml	= "";
				else
				{
					node			= this.CreateNode("header", "style", document);
					exist			= false;
				}

				XmlNode	impnode		= this.Styles.ImportNode(content.Node, true);
				node.AppendChild(impnode);

				if(!exist)
					this._styles.SelectSingleNode("//office:master-styles/style:master-page", 
						document.NamespaceManager).AppendChild(node);

				this.InsertParagraphStyle(content, document);
			}
			catch(Exception ex)
			{
				throw;
			}
		}

		/// <summary>
		/// Inserts the paragraph style.
		/// </summary>
		/// <param name="content">The content.</param>
		/// <param name="document">The document.</param>
		private void InsertParagraphStyle(Paragraph content, TextDocument document)
		{
			try
			{
				if(content.Style != null)
				{
					XmlNode node		= this.Styles.ImportNode(content.Style.Node, true);
					this.Styles.SelectSingleNode("//office:styles",
						document.NamespaceManager).AppendChild(node);
				}

				if(content.TextContent != null)
					foreach(IText it in content.TextContent)
						if(it is FormatedText)
						{
							XmlNode node		= this.Styles.ImportNode(it.Style.Node, true);
							this.Styles.SelectSingleNode("//office:styles",
								document.NamespaceManager).AppendChild(node);
						}
			}
			catch(Exception ex)
			{
				throw;
			}
		}

		/// <summary>
		/// Gets the HTML header.
		/// </summary>
		/// <param name="document">The document.</param>
		/// <returns>The html string which represent the document header.</returns>
		internal string GetHtmlHeader(TextDocument document)
		{
			string html				= "";
			try
			{
				XmlNode node		= this.Styles.SelectSingleNode(
					"//office:master-styles/style:master-page/style:header", 
					document.NamespaceManager);
				
				if(node != null)
				{
				}
			}
			catch(Exception ex)
			{
			}
			return html;
		}

		/// <summary>
		/// Gets the HTML footer.
		/// </summary>
		/// <param name="document">The document.</param>
		/// <returns>The html string which represent the document footer.</returns>
		internal string GetHtmlFooter(TextDocument document)
		{
			string html				= "";
			try
			{
				XmlNode node		= this.Styles.SelectSingleNode(
					"//office:master-styles/style:master-page/style:footer", 
					document.NamespaceManager);
				
				if(node != null)
				{
				}
			}
			catch(Exception ex)
			{
			}
			return html;
		}

		/// <summary>
		/// Creates the node.
		/// </summary>
		/// <param name="name">The name.</param>
		/// <param name="prefix">The prefix.</param>
		/// <param name="document">The prefix.</param>
		/// <returns>The XmlNode</returns>
		public XmlNode CreateNode(string name, string prefix, TextDocument document)
		{
			try
			{
				string nuri = document.GetNamespaceUri(prefix);
				return this.Styles.CreateElement(prefix, name, nuri);
			}
			catch(Exception ex)
			{
				throw;
			}
		}
	}
}

/*
 * $Log: DocumentStyles.cs,v $
 * Revision 1.3  2008/04/29 15:39:57  mt
 * new copyright header
 *
 * Revision 1.2  2007/04/08 16:51:24  larsbehr
 * - finished master pages and styles for text documents
 * - several bug fixes
 *
 * Revision 1.1  2007/02/25 08:58:59  larsbehr
 * initial checkin, import from Sourceforge.net to OpenOffice.org
 *
 * Revision 1.3  2007/02/13 17:58:49  larsbm
 * - add first part of implementation of master style pages
 * - pdf exporter conversations for tables and images and added measurement helper
 *
 * Revision 1.2  2006/02/21 19:34:56  larsbm
 * - Fixed Bug text that contains a xml tag will be imported  as UnknowText and not correct displayed if document is exported  as HTML.
 * - Fixed Bug [ 1436080 ] Common styles
 *
 * Revision 1.1  2006/01/29 11:28:30  larsbm
 * - Changes for the new version. 1.2. see next changelog for details
 *
 * Revision 1.5  2006/01/05 10:31:10  larsbm
 * - AODL merged cells
 * - AODL toc
 * - AODC batch mode, splash screen
 *
 * Revision 1.4  2005/12/12 19:39:17  larsbm
 * - Added Paragraph Header
 * - Added Table Row Header
 * - Fixed some bugs
 * - better whitespace handling
 * - Implmemenation of HTML Exporter
 *
 * Revision 1.3  2005/11/22 21:09:19  larsbm
 * - Add simple header and footer support
 *
 * Revision 1.2  2005/11/20 17:31:20  larsbm
 * - added suport for XLinks, TabStopStyles
 * - First experimental of loading dcuments
 * - load and save via importer and exporter interfaces
 *
 * Revision 1.1  2005/11/06 14:55:25  larsbm
 * - Interfaces for Import and Export
 * - First implementation of IExport OpenDocumentTextExporter
 *
 */