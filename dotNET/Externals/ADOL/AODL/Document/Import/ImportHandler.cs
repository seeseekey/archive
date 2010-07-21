/*************************************************************************
 *
 * DO NOT ALTER OR REMOVE COPYRIGHT NOTICES OR THIS FILE HEADER.
 * 
 * Copyright 2008 by Sun Microsystems, Inc.
 *
 * OpenOffice.org - a multi-platform office productivity suite
 *
 * $RCSfile: ImportHandler.cs,v $
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
using System.IO;
using System.Collections;
using System.Diagnostics;
using AODL.Document;
using AODL.Document.Exceptions;
using AODL.Document.Export;
using AODL.Document.Import.OpenDocument;
using AODL.Document.Import.PlainText;

namespace AODL.Document.Import
{
	/// <summary>
	/// ImportHandler class to get the right IImporter implementations
	/// for the document to import.
	/// </summary>
	public class ImportHandler
	{
		/// <summary>
		/// Initializes a new instance of the <see cref="ImportHandler"/> class.
		/// </summary>
		public ImportHandler()
		{
		
		}

		/// <summary>
		/// Gets the first importer that match the parameter criteria.
		/// </summary>
		/// <param name="documentType">Type of the document.</param>
		/// <param name="loadPath">The save path.</param>
		/// <returns></returns>
		public IImporter GetFirstImporter(DocumentTypes documentType, string loadPath)
		{
			string targetExtension			= ExportHandler.GetExtension(loadPath);

			foreach(IImporter iImporter in this.LoadImporter())
			{
				foreach(DocumentSupportInfo documentSupportInfo in iImporter.DocumentSupportInfos)
					if(documentSupportInfo.Extension.ToLower().Equals(targetExtension.ToLower()))
						if(documentSupportInfo.DocumentType == documentType)
							return iImporter;
			}

			AODLException exception		= new AODLException("No importer available for type "+documentType.ToString()+" and extension "+targetExtension);
			exception.InMethod			= AODLException.GetExceptionSourceInfo(new StackFrame(1, true));
			throw exception;
		}

		/// <summary>
		/// Load internal and external importer.
		/// </summary>
		/// <returns></returns>
		private ArrayList LoadImporter()
		{
			try
			{
				ArrayList alImporter			= new ArrayList();				
				alImporter.Add(new OpenDocumentImporter());
				alImporter.Add(new PlainTextImporter());
				alImporter.Add(new CsvImporter());

				return alImporter;
			}
			catch(Exception ex)
			{	
				AODLException exception		= new AODLException("Error while trying to load the importer.");
				exception.InMethod			= AODLException.GetExceptionSourceInfo(new StackFrame(1, true));
				exception.OriginalException	= ex;
				throw exception;			
			}
		}
	}
}

/*
 * $Log: ImportHandler.cs,v $
 * Revision 1.2  2008/04/29 15:39:52  mt
 * new copyright header
 *
 * Revision 1.1  2007/02/25 08:58:44  larsbehr
 * initial checkin, import from Sourceforge.net to OpenOffice.org
 *
 * Revision 1.2  2006/02/02 21:55:59  larsbm
 * - Added Clone object support for many AODL object types
 * - New Importer implementation PlainTextImporter and CsvImporter
 * - New tests
 *
 * Revision 1.1  2006/01/29 11:28:23  larsbm
 * - Changes for the new version. 1.2. see next changelog for details
 *
 */