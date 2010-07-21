/*************************************************************************
 *
 * DO NOT ALTER OR REMOVE COPYRIGHT NOTICES OR THIS FILE HEADER.
 * 
 * Copyright 2008 by Sun Microsystems, Inc.
 *
 * OpenOffice.org - a multi-platform office productivity suite
 *
 * $RCSfile: MasterPageFactory.cs,v $
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
using AODL.Document.Styles;
using AODL.Document.TextDocuments;
using AODL.Document.Import.OpenDocument.NodeProcessors;
using System.Collections;
using System.Xml;

namespace AODL.Document.Styles.MasterStyles
{
	/// <summary>
	/// Summary for MasterPageFactory.
	/// </summary>
	public class MasterPageFactory
	{

		/// <summary>
		/// Rename master styles.
		/// </summary>
		/// <param name="styleDocument">The style document.</param>
		/// <param name="contentDocument">The content document.</param>
		/// <param name="namespaceMng">The namespace MNG.</param>
		public static void RenameMasterStyles(XmlDocument styleDocument, XmlDocument contentDocument, XmlNamespaceManager namespaceMng)
		{
			try
			{
				// Rename style names used in inside the master page
				// contents. This is necessary since OpenOffice create
				// duplicate style names.
				XmlNode automaticStyles = styleDocument.SelectSingleNode(
					"//office:automatic-styles", namespaceMng);
				XmlNode masterStyles = styleDocument.SelectSingleNode(
					"//office:master-styles", namespaceMng);
				if(automaticStyles != null && masterStyles != null && automaticStyles.HasChildNodes)
				{
					foreach(XmlNode styleNode in automaticStyles.ChildNodes)
					{
						if(styleNode.Attributes["style:name"] != null)
						{
							// Look for associated content inside header and footer
							string styleName = styleNode.Attributes["style:name"].Value;
							string family = "text"; // default text
							XmlNode contentNode = null;
							if(styleNode.Attributes["style:family"] != null && styleNode.Attributes["style:family"].Value.StartsWith("table"))
							{
								contentNode = masterStyles.SelectSingleNode(
									"//*[@table:style-name = '" + styleName + "']", namespaceMng);
								family = "table";
							} 
							else
							{
								string xpath = "//*[@text:style-name = '" + styleName + "']";
								contentNode = masterStyles.SelectSingleNode(
									xpath, namespaceMng);
							}
							if(contentNode != null)
							{
								// This style name has to be changed
								string master = "master";
								styleNode.Attributes["style:name"].Value = master + styleName;
								contentNode.Attributes[family + ":style-name"].Value = master + styleName;
							}
						}
					}
					// Now, we move this nodes to avoid xml owner document errors
					MasterPageFactory.MoveMasterStyles(contentDocument, automaticStyles, masterStyles, namespaceMng);
				}
			}
			catch(Exception)
			{
				throw;
			}
		}

		/// <summary>
		/// Moves the master styles.
		/// </summary>
		/// <param name="contentDocument">The content document.</param>
		/// <param name="nodeAutomaticStyles">The node automatic styles.</param>
		/// <param name="nodeMasterPages">The node master pages.</param>
		/// <param name="namespaceMng">The namespace MNG.</param>
		/// <remarks>
		/// We will move the whole master style and master pages stuff
		/// from the style document to the text document. This is
		/// necessary for avoiding xml document owner errors.
		/// Notice: When the document will be saved this nodes have
		/// to move back to the styles document. Otherwise they wont
		/// work resp. diplayed not correct within OpenOffice.
		/// </remarks>
		public static void MoveMasterStyles(XmlDocument contentDocument,XmlNode nodeAutomaticStyles, XmlNode nodeMasterPages, XmlNamespaceManager namespaceMng)
		{
			// First import all automatic styles
			XmlNode contentAutomaticStyles = contentDocument.SelectSingleNode(
				"//office:automatic-styles", namespaceMng);
			if(contentAutomaticStyles != null && nodeAutomaticStyles.HasChildNodes)
			{
				foreach(XmlNode childNode in nodeAutomaticStyles.ChildNodes)
				{
					XmlNode importNode = contentDocument.ImportNode(childNode, true);
					contentAutomaticStyles.AppendChild(importNode);
				}
			}
			// Second import master pages
			XmlNode importedMasterPages = contentDocument.ImportNode(nodeMasterPages, true);
			contentDocument.LastChild.AppendChild(importedMasterPages);

			// clear nodes in style.xml
			nodeAutomaticStyles.RemoveAll();
			// clear master pages in style.xml
			nodeMasterPages.RemoveAll();
		}


		/// <summary>
		/// Fill/read the existing master page styles.
		/// </summary>
		/// <param name="textDocument">The owner text document.</param>
		public static void FillFromXMLDocument(TextDocument textDocument)
		{
			try
			{
				TextMasterPageCollection txtMPCollection = new TextMasterPageCollection();
				XmlNodeList masterPageNodes = textDocument.XmlDoc.SelectNodes(
					"//style:master-page", textDocument.NamespaceManager);
				if(masterPageNodes != null)
				{
					foreach(XmlNode mpNode in masterPageNodes)
					{
						// Build the master page
						TextMasterPage txtMasterPage = new TextMasterPage(textDocument, mpNode);
						// Even if there is no usage of header within the master page style,
						// but of course there exists the header:style node, so we create
						// the TextPageHeader.
						txtMasterPage.TextPageHeader = new TextPageHeader();
						txtMasterPage.TextPageHeader.TextDocument = textDocument;
						txtMasterPage.TextPageHeader.TextMasterPage = txtMasterPage;
						// see comment above its the same procedure
						txtMasterPage.TextPageFooter = new TextPageFooter();
						txtMasterPage.TextPageFooter.TextDocument = textDocument;
						txtMasterPage.TextPageFooter.TextMasterPage = txtMasterPage;
						
						// Build header content
						XmlNode headerNode = mpNode.SelectSingleNode("//style:header", textDocument.NamespaceManager);
						if(headerNode != null)
						{
							txtMasterPage.TextPageHeader.ContentNode = headerNode;
							IContentCollection contents = MasterPageFactory.GetContentHeaderFooter(headerNode, textDocument);
							if(contents != null) 
							{
								headerNode.RemoveAll();
								foreach(IContent iContent in contents) 
								{
									txtMasterPage.TextPageHeader.ContentCollection.Add(iContent);
								}
							}
						}

						// Build footer content
						XmlNode footerNode = mpNode.SelectSingleNode("//style:footer", textDocument.NamespaceManager);
						if(footerNode != null)
						{
							txtMasterPage.TextPageFooter.ContentNode = footerNode;
							IContentCollection contents = MasterPageFactory.GetContentHeaderFooter(footerNode, textDocument);
							if(contents != null) 
							{
								footerNode.RemoveAll();
								foreach(IContent iContent in contents) 
								{
									txtMasterPage.TextPageFooter.ContentCollection.Add(iContent);
								}
							}
						}

						// Build master page layout
						XmlNode txtPageLayoutNode = textDocument.XmlDoc.SelectSingleNode(
							"//style:page-layout[@style:name='"+txtMasterPage.PageLayoutName+"']",
							textDocument.NamespaceManager);
						if(txtPageLayoutNode != null)
						{
							// Build master page layout properties
							XmlNode txtPageLayoutPropNode = txtPageLayoutNode.SelectSingleNode(
								"//style:page-layout-properties", textDocument.NamespaceManager);
							if(txtPageLayoutPropNode != null)
							{
								TextPageLayout txtPageLayout = new TextPageLayout(
									textDocument, txtPageLayoutNode, txtPageLayoutPropNode);
								txtMasterPage.TextPageLayout = txtPageLayout;
							}
							// Build master page header layout
							XmlNode txtHeaderStyleNode = txtPageLayoutNode.SelectSingleNode(
								"//style:header-style", textDocument.NamespaceManager);
							if(txtHeaderStyleNode != null)
							{
								txtMasterPage.TextPageHeader.StyleNode = txtHeaderStyleNode;
								if(txtHeaderStyleNode.FirstChild != null
									&& txtHeaderStyleNode.FirstChild.Name == "style:header-footer-properties")
									txtMasterPage.TextPageHeader.PropertyNode = txtHeaderStyleNode.FirstChild;
							}
							// Build master page footer layout
							XmlNode txtFooterStyleNode = txtPageLayoutNode.SelectSingleNode(
								"//style:footer-style", textDocument.NamespaceManager);
							if(txtFooterStyleNode != null)
							{
								txtMasterPage.TextPageFooter.StyleNode = txtFooterStyleNode;
								if(txtFooterStyleNode.FirstChild != null
									&& txtFooterStyleNode.FirstChild.Name == "style:header-footer-properties")
									txtMasterPage.TextPageFooter.PropertyNode = txtFooterStyleNode.FirstChild;
							}
						}
						
						txtMPCollection.Add(txtMasterPage);
					}
				}
				textDocument.TextMasterPageCollection = txtMPCollection;
			}
			catch(Exception)
			{
				throw;
			}
		}

		/// <summary>
		/// Gets the content for headers and footers.
		/// </summary>
		/// <param name="contentNode">The content node.</param>
		/// <param name="textDocument">The text document.</param>
		/// <returns>The contents as IContentCollection.</returns>
		public static IContentCollection GetContentHeaderFooter(XmlNode contentNode, TextDocument textDocument) 
		{
			IContentCollection contents = new IContentCollection();
			if(contentNode != null && contentNode.HasChildNodes)
			{
				XmlNode node = null;
				if(textDocument.XmlDoc != contentNode.OwnerDocument) 
				{
					node = textDocument.XmlDoc.ImportNode(contentNode, true);
				} 
				else 
				{
					node = contentNode;
				}
				MainContentProcessor mcp = new MainContentProcessor(textDocument);				
				foreach(XmlNode nodeChild in node.ChildNodes)
				{
					IContent iContent = mcp.CreateContent(nodeChild);
					if(iContent != null) 
					{
						if(iContent is AODL.Document.Content.Tables.Table)
							((AODL.Document.Content.Tables.Table)iContent).BuildNode();
						contents.Add(iContent);
					}
				}
			}
			return contents;
		}
	}
}
