/*************************************************************************
 *
 * DO NOT ALTER OR REMOVE COPYRIGHT NOTICES OR THIS FILE HEADER.
 * 
 * Copyright 2008 by Sun Microsystems, Inc.
 *
 * OpenOffice.org - a multi-platform office productivity suite
 *
 * $RCSfile: PDFExporter.cs,v $
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
using AODL.Document.Export;
using AODL.ExternalExporter.PDF.Document;

namespace AODL.ExternalExporter.PDF
{
	/// <summary>
	/// Summary for PDFExporter
	/// </summary>
	public class PDFExporter : IExporter
	{
		/// <summary>
		/// Invoked when the document has been exported.
		/// </summary>
		public delegate void ExportFinished();
		/// <summary>
		/// Invoked when the document has been exported.
		/// </summary>
		public event ExportFinished OnExportFinished;

		/// <summary>
		/// Initializes a new instance of the <see cref="PDFExporter"/> class.
		/// </summary>
		public PDFExporter()
		{
		}

		#region IExporter Member

		public System.Collections.ArrayList DocumentSupportInfos
		{
			get
			{
				// TODO:  Getter-Implementierung für PDFExporter.DocumentSupportInfos hinzufügen
				return null;
			}
		}

		public System.Collections.ArrayList ExportError
		{
			get
			{
				// TODO:  Getter-Implementierung für PDFExporter.ExportError hinzufügen
				return null;
			}
		}

		/// <summary>
		/// Exports the specified document.
		/// </summary>
		/// <param name="document">The document.</param>
		/// <param name="filename">The filename.</param>
		public void Export(AODL.Document.IDocument document, string filename)
		{
			try
			{
				PDFDocument pdfDocument = new PDFDocument();
				pdfDocument.DoExport(document, filename);
				if(this.OnExportFinished != null)
				{
					this.OnExportFinished();
				}
			}
			catch(Exception)
			{
				throw;
			}
		}

		#endregion
	}
}
