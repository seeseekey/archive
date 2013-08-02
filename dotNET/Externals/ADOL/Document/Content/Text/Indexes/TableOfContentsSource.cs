/*************************************************************************
 *
 * DO NOT ALTER OR REMOVE COPYRIGHT NOTICES OR THIS FILE HEADER.
 * 
 * Copyright 2008 by Sun Microsystems, Inc.
 *
 * OpenOffice.org - a multi-platform office productivity suite
 *
 * $RCSfile: TableOfContentsSource.cs,v $
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

namespace AODL.Document.Content.Text.Indexes
{
	/// <summary>
	/// TableOfContentSource.
	/// </summary>
	public class TableOfContentsSource
	{
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

		private TableOfContents _tableOfContents;
		/// <summary>
		/// Gets or sets the content of the table of.
		/// </summary>
		/// <value>The content of the table of.</value>
		public TableOfContents TableOfContents
		{
			get { return this._tableOfContents; }
			set { this._tableOfContents = value; }
		}

		private TableOfContentsIndexTemplateCollection _tableOfContensIndexTemplateCollection;
		/// <summary>
		/// Gets or sets the table of content index template collection.
		/// </summary>
		/// <value>The table of content index template collection.</value>
		public TableOfContentsIndexTemplateCollection TableOfContentsIndexTemplateCollection
		{
			get { return this._tableOfContensIndexTemplateCollection; }
			set { this._tableOfContensIndexTemplateCollection = value; }
		}

		/// <summary>
		/// Initializes a new instance of the <see cref="TableOfContentsSource"/> class.
		/// </summary>
		/// <param name="tableOfContents">Content of the table of.</param>
		public TableOfContentsSource(TableOfContents tableOfContents)
		{
			this._tableOfContents			= tableOfContents;
			this.TableOfContentsIndexTemplateCollection = new TableOfContentsIndexTemplateCollection();
			this.NewXmlNode();
		}

		/// <summary>
		/// Init the standard style source template styles.
		/// </summary>
		public void InitStandardTableOfContentStyle()
		{
			for(int i=1; i<=10; i++)
			{
				TableOfContentsIndexTemplate tableOfContentsIndexTemplate =
					new TableOfContentsIndexTemplate(
						this.TableOfContents, 
						i, 
						"Contents_20_"+i.ToString());
				
				tableOfContentsIndexTemplate.InitStandardTemplate();
				this.Node.AppendChild(tableOfContentsIndexTemplate.Node);
				this.TableOfContentsIndexTemplateCollection.Add(
					tableOfContentsIndexTemplate);
			}
		}

		/// <summary>
		/// Create the XmlNode which represent this object.
		/// </summary>
		private void NewXmlNode()
		{			
			this.Node						= this.TableOfContents.Document.CreateNode(
				"table-of-content-source", "text");

			//the only supported table of content style, will be
			//based on the header and their outline levels,
			//but loading other styles should be possible, but won't
			//be modifiable.
			XmlAttribute xa					= this.TableOfContents.Document.CreateAttribute(
				"outline-level", "text");
			xa.Value						= "10";
			this.Node.Attributes.Append(xa);

			//Create the index-title-template node
			//this is always the title of the TableOfContent
			//of the referenced TableOfContent oject
			XmlNode indexTitleTemplateNode	= this.TableOfContents.Document.CreateNode(
				"index-title-template", "text");

			indexTitleTemplateNode.InnerText= this.TableOfContents.Title;

			//Fixed style for the title template
			xa								= this.TableOfContents.Document.CreateAttribute(
				"style-name", "text");
			xa.Value						= "Contents_20_Heading";
			indexTitleTemplateNode.Attributes.Append(xa);

			this.Node.AppendChild(indexTitleTemplateNode);
		}
	}
}

/*
 * $Log: TableOfContentsSource.cs,v $
 * Revision 1.3  2008/04/29 15:39:47  mt
 * new copyright header
 *
 * Revision 1.2  2007/04/08 16:51:24  larsbehr
 * - finished master pages and styles for text documents
 * - several bug fixes
 *
 * Revision 1.1  2007/02/25 08:58:41  larsbehr
 * initial checkin, import from Sourceforge.net to OpenOffice.org
 *
 * Revision 1.1  2006/01/29 11:28:22  larsbm
 * - Changes for the new version. 1.2. see next changelog for details
 *
 * Revision 1.1  2006/01/05 10:31:10  larsbm
 * - AODL merged cells
 * - AODL toc
 * - AODC batch mode, splash screen
 *
 */ 