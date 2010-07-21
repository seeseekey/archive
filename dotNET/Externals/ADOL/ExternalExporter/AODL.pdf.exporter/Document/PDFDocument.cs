/*************************************************************************
 *
 * DO NOT ALTER OR REMOVE COPYRIGHT NOTICES OR THIS FILE HEADER.
 * 
 * Copyright 2008 by Sun Microsystems, Inc.
 *
 * OpenOffice.org - a multi-platform office productivity suite
 *
 * $RCSfile: PDFDocument.cs,v $
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
using System.Collections;
using System.IO;
using iTextSharp.text.pdf;
using AODL.Document;
using AODL.Document.Content;
using AODL.ExternalExporter.PDF.Document.ContentConverter;
using AODL.ExternalExporter.PDF.Document.StyleConverter;

namespace AODL.ExternalExporter.PDF.Document
{
	/// <summary>
	/// Zusammenfassung für PDFDocument.
	/// </summary>
	public class PDFDocument
	{
		/// <summary>
		/// The new pdf document.
		/// </summary>
		private iTextSharp.text.Document _document;
		/// <summary>
		/// Gets the document.
		/// </summary>
		/// <value>The document.</value>
		public iTextSharp.text.Document Document
		{
			get { return this._document; }
		}

		/// <summary>
		/// Initializes a new instance of the <see cref="PDFDocument"/> class.
		/// </summary>
		public PDFDocument()
		{
		}

		/// <summary>
		/// Does the export.
		/// </summary>
		/// <param name="document">The document.</param>
		/// <param name="fileName">Name of the file.</param>
		public void DoExport(IDocument document, string fileName)
		{
			try
			{
				this.LoadDefaultStyles(document);
				this.CreatePDFDocument(fileName);
				ArrayList pdfElements = MixedContentConverter.GetMixedPdfContent(document.Content);
				foreach(object pdfElement in pdfElements)
				{
					if(pdfElement is AODL.ExternalExporter.PDF.Document.iTextExt.ParagraphExt
						&& ((AODL.ExternalExporter.PDF.Document.iTextExt.ParagraphExt)pdfElement).PageBreakBefore)
							this._document.NewPage();
					this._document.Add(pdfElement as iTextSharp.text.IElement);
					if(pdfElement is AODL.ExternalExporter.PDF.Document.iTextExt.ParagraphExt
						&& ((AODL.ExternalExporter.PDF.Document.iTextExt.ParagraphExt)pdfElement).PageBreakAfter)
						this._document.NewPage();
				}

				this._document.Close();
			}
			catch(Exception)
			{
				throw;
			}
		}

		/// <summary>
		/// Loads the default styles.
		/// </summary>
		private void LoadDefaultStyles(IDocument document)
		{
			try
			{
				DefaultDocumentStyles defaultDocumentStyle;
				if(document is AODL.Document.TextDocuments.TextDocument)
					defaultDocumentStyle = DefaultDocumentStyles.Instance(
						((AODL.Document.TextDocuments.TextDocument)document).DocumentStyles, document);
				else if(document is AODL.Document.SpreadsheetDocuments.SpreadsheetDocument)
					defaultDocumentStyle = DefaultDocumentStyles.Instance(
						((AODL.Document.SpreadsheetDocuments.SpreadsheetDocument)document).DocumentStyles, document);
				else 
					throw new Exception("Unknown IDocument implementation.");
				defaultDocumentStyle.Init();
			}
			catch(Exception)
			{
				throw;
			}
		}

		/// <summary>
		/// Creates the PDF document.
		/// </summary>
		/// <param name="filename">The filename.</param>
		private void CreatePDFDocument(string filename)
		{
			try
			{
				this._document = new iTextSharp.text.Document();				
				PdfWriter pdfWriter = PdfWriter.GetInstance(this._document, new FileStream(filename, FileMode.Create));
				this._document.Open();
			}
			catch(Exception)
			{
				throw;
			}
		}
	}
}

