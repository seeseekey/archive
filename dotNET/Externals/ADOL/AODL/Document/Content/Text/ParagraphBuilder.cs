/*************************************************************************
 *
 * DO NOT ALTER OR REMOVE COPYRIGHT NOTICES OR THIS FILE HEADER.
 * 
 * Copyright 2008 by Sun Microsystems, Inc.
 *
 * OpenOffice.org - a multi-platform office productivity suite
 *
 * $RCSfile: ParagraphBuilder.cs,v $
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
using AODL.Document;

namespace AODL.Document.Content.Text
{
	/// <summary>
	/// ParagraphBuilder use the methods of this class to create
	/// different kinds of paragraph.
	/// </summary>
	public class ParagraphBuilder
	{
		/// <summary>
		/// Use \n\n as pargraph seperator for building a pargraph collection
		/// with the ParagraphBuilder.
		/// </summary>
		public static readonly string  ParagraphSeperator	= "\n\n";
		/// <summary>
		/// Use \r\n\r\n as pargraph seperator for building a pargraph collection
		/// with the ParagraphBuilder.
		/// </summary>
		public static readonly string  ParagraphSeperator2	= "\r\n\r\n";

		/// <summary>
		/// Initializes a new instance of the <see cref="ParagraphBuilder"/> class.
		/// </summary>
		public ParagraphBuilder()
		{
		}

		/// <summary>
		/// Create a spreadsheet paragraph.
		/// </summary>
		/// <param name="document">The document.</param>
		/// <returns></returns>
		public static Paragraph CreateSpreadsheetParagraph(IDocument document)
		{
			return new Paragraph(document);
		}

		/// <summary>
		/// Create a standard text paragraph.
		/// </summary>
		/// <param name="document">The document.</param>
		/// <returns></returns>
		public static Paragraph CreateStandardTextParagraph(IDocument document)
		{
			return new Paragraph(document, ParentStyles.Standard, null);
		}

		/// <summary>
		/// Create a standard text table paragraph.
		/// </summary>
		/// <param name="document">The document.</param>
		/// <returns></returns>
		public static Paragraph CreateStandardTextTableParagraph(IDocument document)
		{
			return new Paragraph(document, ParentStyles.Table, null);
		}

		/// <summary>
		/// Create a paragraph with custom style.
		/// </summary>
		/// <param name="document">The document.</param>
		/// <param name="styleName">Name of the style.</param>
		/// <returns></returns>
		public static Paragraph CreateParagraphWithCustomStyle(IDocument document, string styleName)
		{
			return new Paragraph(document, styleName);
		}

		/// <summary>
		/// Create a paragraph with existing node.
		/// </summary>
		/// <param name="document">The document.</param>
		/// <param name="paragraphNode">The paragraph node.</param>
		/// <returns></returns>
		public static Paragraph CreateParagraphWithExistingNode(IDocument document, XmlNode paragraphNode)
		{
			return new Paragraph(paragraphNode, document);
		}

		/// <summary>
		/// Creates the paragraph collection.
		/// </summary>
		/// <param name="document">The document.</param>
		/// <param name="text">The text.</param>
		/// <param name="useStandardStyle">if set to <c>true</c> [use standard style].</param>
		/// <param name="paragraphSeperator">The paragraph seperator.</param>
		/// <returns></returns>
		public static ParagraphCollection CreateParagraphCollection(IDocument document, string text, bool useStandardStyle, string paragraphSeperator)
		{
			string xmlStartTag				= "<?xml version=\"1.0\" encoding=\"UTF-8\" ?>";
			ParagraphCollection pCollection	= new ParagraphCollection();
			text							= text.Replace(paragraphSeperator, "<p/>");
			xmlStartTag						+= "<pg>"+text+"</pg>";

			XmlDocument xmlDoc				= new XmlDocument();
			xmlDoc.LoadXml(xmlStartTag);

			XmlNode nodeStart				= xmlDoc.DocumentElement;
			if(nodeStart != null)
				if(nodeStart.HasChildNodes)
				{
					foreach(XmlNode childNode in nodeStart.ChildNodes)
					{
						if(childNode.NodeType == XmlNodeType.Text)
						{
							Paragraph paragraph		= null;
							
							if(useStandardStyle)
								paragraph			= ParagraphBuilder.CreateStandardTextParagraph(document);
							else
								paragraph			= ParagraphBuilder.CreateParagraphWithCustomStyle(
									document, "P"+Convert.ToString(document.DocumentMetadata.ParagraphCount+nodeStart.ChildNodes.Count+1));
							
							paragraph.TextContent	= TextBuilder.BuildTextCollection(document, childNode.InnerText);
							pCollection.Add(paragraph);
						}
						else
						{
							Paragraph paragraph		= null;
							
							if(useStandardStyle)
								paragraph			= ParagraphBuilder.CreateStandardTextParagraph(document);
							else
								paragraph			= ParagraphBuilder.CreateParagraphWithCustomStyle(
									document, "P"+Convert.ToString(document.DocumentMetadata.ParagraphCount+nodeStart.ChildNodes.Count+1));

							pCollection.Add(paragraph);
						}
					}
				}
				else
				{
					Paragraph paragraph		= null;
							
					if(useStandardStyle)
						paragraph			= ParagraphBuilder.CreateStandardTextParagraph(document);
					else
						paragraph			= ParagraphBuilder.CreateParagraphWithCustomStyle(
							document, "P"+Convert.ToString(document.DocumentMetadata.ParagraphCount+1));
					
					paragraph.TextContent	 = TextBuilder.BuildTextCollection(document, nodeStart.InnerText);
					pCollection.Add(paragraph);
				}
			return pCollection;
		}
	}
}

/*
 * $Log: ParagraphBuilder.cs,v $
 * Revision 1.2  2008/04/29 15:39:46  mt
 * new copyright header
 *
 * Revision 1.1  2007/02/25 08:58:39  larsbehr
 * initial checkin, import from Sourceforge.net to OpenOffice.org
 *
 * Revision 1.2  2006/02/02 21:55:59  larsbm
 * - Added Clone object support for many AODL object types
 * - New Importer implementation PlainTextImporter and CsvImporter
 * - New tests
 *
 * Revision 1.1  2006/01/29 11:28:22  larsbm
 * - Changes for the new version. 1.2. see next changelog for details
 *
 */
