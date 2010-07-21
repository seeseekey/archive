/*************************************************************************
 *
 * DO NOT ALTER OR REMOVE COPYRIGHT NOTICES OR THIS FILE HEADER.
 * 
 * Copyright 2008 by Sun Microsystems, Inc.
 *
 * OpenOffice.org - a multi-platform office productivity suite
 *
 * $RCSfile: IDocument.cs,v $
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
using System.Collections;
using System.Xml;
using AODL.Document.TextDocuments;
using AODL.Document.Content;
using AODL.Document.Styles;

namespace AODL.Document
{
	/// <summary>
	/// IDocument.
	/// </summary>
	public interface IDocument
	{
		/// <summary>
		/// Every document must have a XmlNamespaceManager
		/// </summary>
		XmlNamespaceManager NamespaceManager {get; set;}
		/// <summary>
		/// Every document must have a XmlDocument that
		/// represent the content.
		/// </summary>
		XmlDocument XmlDoc {get; set;}
		/// <summary>
		/// Every document must give access to his meta data
		/// </summary>
		DocumentMetadata DocumentMetadata {get; set;}
		/// <summary>
		/// Every document must give access to his document configurations
		/// </summary>
		DocumentConfiguration2 DocumentConfigurations2 {get; set; }
		/// <summary>
		/// Every document must give access to his pictures
		/// </summary>
		DocumentPictureCollection DocumentPictures {get; set;}
		/// <summary>
		/// Every document must give access to his thumbnails
		/// </summary>
		DocumentPictureCollection DocumentThumbnails {get; set;}
		/// <summary>
		/// The font list
		/// </summary>
		ArrayList FontList {get; set;}
		/// <summary>
		/// Graphics used within the document.
		/// </summary>
		ArrayList Graphics {get;}
		/// <summary>
		/// EmbedObject used within the document.
		/// </summary>
		ArrayList EmbedObjects {get;}

		/// <summary>
		/// Collection of local styles used with this document.
		/// </summary>
		IStyleCollection Styles {get; set;}
		/// <summary>
		/// Collection of common styles used with this document.
		/// </summary>
		IStyleCollection CommonStyles {get; set;}
		/// <summary>
		/// Collection of contents used by this document.
		/// </summary>
		IContentCollection Content {get; set;}
		/// <summary>
		/// Every document must offer CreateNode for creating
		/// new nodes
		/// </summary>
		/// <param name="name">The name of the node</param>
		/// <param name="prefix">The prefix of the node</param>
		/// <returns>The created node</returns>
		XmlNode CreateNode(string name, string prefix);
		/// <summary>
		/// Every document must offer CreateAttribute for creating
		/// new attributes
		/// </summary>
		/// <param name="name">The name of the attribute</param>
		/// <param name="prefix">The prefix of the attribute</param>
		/// <returns>The created attribute</returns>
		XmlAttribute CreateAttribute(string name, string prefix);
		/// <summary>
		/// If this file was loaded
		/// </summary>
		bool IsLoadedFile {get;}
		/// <summary>
		/// Load the given file.
		/// </summary>
		/// <param name="file"></param>
		void Load(string file);
		/// <summary>
		/// Save the document at the given file position.
		/// </summary>
		/// <param name="filename">Path and file name.</param>
		void SaveTo(string filename);
		/// <summary>
		/// Save the document by using the passed IExporter
		/// with the passed file name.
		/// </summary>
		/// <param name="filename">The name of the new file.</param>
		void SaveTo(string filename, AODL.Document.Export.IExporter iExporter);
	}

	public enum DocumentTypes
	{
		/// <summary>
		/// OpenDocument Text document
		/// </summary>
		TextDocument,
		/// <summary>
		/// OpenDocument Spreadsheet document
		/// </summary>
		SpreadsheetDocument
	}
}

/*
 * $Log: IDocument.cs,v $
 * Revision 1.3  2008/04/29 15:39:42  mt
 * new copyright header
 *
 * Revision 1.2  2008/02/08 07:12:20  larsbehr
 * - added initial chart support
 * - several bug fixes
 *
 * Revision 1.1  2007/02/25 08:58:44  larsbehr
 * initial checkin, import from Sourceforge.net to OpenOffice.org
 *
 * Revision 1.4  2007/02/04 22:52:57  larsbm
 * - fixed bug in resize algorithm for rows and cells
 * - extending IDocument, overload SaveTo to accept external exporter impl.
 * - initial version of AODL PDF exporter add on
 *
 * Revision 1.3  2006/02/05 20:03:32  larsbm
 * - Fixed several bugs
 * - clean up some messy code
 *
 * Revision 1.2  2006/01/29 18:52:14  larsbm
 * - Added support for common styles (style templates in OpenOffice)
 * - Draw TextBox import and export
 * - DrawTextBox html export
 *
 * Revision 1.1  2006/01/29 11:28:23  larsbm
 * - Changes for the new version. 1.2. see next changelog for details
 *
 */