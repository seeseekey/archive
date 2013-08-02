/*************************************************************************
 *
 * DO NOT ALTER OR REMOVE COPYRIGHT NOTICES OR THIS FILE HEADER.
 * 
 * Copyright 2008 by Sun Microsystems, Inc.
 *
 * OpenOffice.org - a multi-platform office productivity suite
 *
 * $RCSfile: PlainTextImporter.cs,v $
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
using AODL.Document;
using AODL.Document.Import;
using AODL.Document.Export;
using AODL.Document.Exceptions;
using AODL.Document.Content;
using AODL.Document.Content.Text;

namespace AODL.Document.Import.PlainText
{
	/// <summary>
	/// Plain Text Importer.
	/// </summary>
	public class PlainTextImporter : IImporter, IPublisherInfo
	{
		/// <summary>
		/// The document to fill with content.
		/// </summary>
		internal IDocument _document;

		/// <summary>
		/// Initializes a new instance of the <see cref="PlainTextImporter"/> class.
		/// </summary>
		public PlainTextImporter()
		{
			this._importError					= new ArrayList();
			
			this._supportedExtensions			= new ArrayList();
			this._supportedExtensions.Add(new DocumentSupportInfo(".txt", DocumentTypes.TextDocument));

			this._author						= "Lars Behrmann, lb@OpenDocument4all.com";
			this._infoUrl						= "http://AODL.OpenDocument4all.com";
			this._description					= "This the standard importer for plain text files of the OpenDocument library AODL.";
		}

		#region IExporter Member

		private ArrayList _supportedExtensions;
		/// <summary>
		/// Gets the document support infos.
		/// </summary>
		/// <value>The document support infos.</value>
		public ArrayList DocumentSupportInfos
		{
			get { return this._supportedExtensions; }
		}

		/// <summary>
		/// Imports the specified filename.
		/// </summary>
		/// <param name="document">The TextDocument to fill.</param>
		/// <param name="filename">The filename.</param>		
		/// <returns>The created TextDocument</returns>
		public void Import(IDocument document, string filename)
		{
			try
			{
				this._document			= document;
				string text				= this.ReadContentFromFile(filename);
					
				if(text.Length > 0)
					this.ReadTextToDocument(text);
				else
				{
					AODLWarning warning	= new AODLWarning("Empty file. ["+filename+"]");
					this.ImportError.Add(warning);
				}
			}
			catch(Exception ex)
			{
				throw;
			}
		}

		private ArrayList _importError;
		/// <summary>
		/// Gets the import errors as ArrayList of strings.
		/// </summary>
		/// <value>The import errors.</value>
		public System.Collections.ArrayList ImportError
		{
			get
			{
				return this._importError;
			}
		}

		/// <summary>
		/// If the import file format isn't any OpenDocument
		/// format you have to return true and AODL will
		/// create a new one.
		/// </summary>
		/// <value></value>
		public bool NeedNewOpenDocument
		{
			get { return true; }
		}

		#endregion

		#region IPublisherInfo Member

		private string _author;
		/// <summary>
		/// The name the Author
		/// </summary>
		/// <value></value>
		public string Author
		{
			get
			{
				return this._author;
			}
		}

		private string _infoUrl;
		/// <summary>
		/// Url to a info site
		/// </summary>
		/// <value></value>
		public string InfoUrl
		{
			get
			{
				return this._infoUrl;
			}
		}

		private string _description;
		/// <summary>
		/// Description about the exporter resp. importer
		/// </summary>
		/// <value></value>
		public string Description
		{
			get
			{
				return this._description;
			}
		}

		#endregion

		/// <summary>
		/// Reads the text to document.
		/// </summary>
		/// <param name="text">The text.</param>
		private void ReadTextToDocument(string text)
		{
			ParagraphCollection parCol	= ParagraphBuilder.CreateParagraphCollection(
				this._document, text, false, ParagraphBuilder.ParagraphSeperator);

			if(parCol != null)
				foreach(Paragraph paragraph in parCol)
					this._document.Content.Add(paragraph);
		}

		/// <summary>
		/// Reads the content from file.
		/// </summary>
		/// <param name="fileName">Name of the file.</param>
		/// <returns></returns>
		private string ReadContentFromFile(string fileName)
		{
			string text					= "";

			try
			{
				StreamReader sReader	= File.OpenText(fileName);
				text					= sReader.ReadToEnd();
				sReader.Close();
			}
			catch(Exception ex)
			{
				throw ex;
			}

			return this.SetConformLineBreaks(text);
		}

		/// <summary>
		/// Sets the conform line breaks.
		/// </summary>
		/// <param name="text">The text.</param>
		/// <returns></returns>
		private string SetConformLineBreaks(string text)
		{
			return text.Replace(
				ParagraphBuilder.ParagraphSeperator2, ParagraphBuilder.ParagraphSeperator);
		}
	}
}

/*
 * $Log: PlainTextImporter.cs,v $
 * Revision 1.2  2008/04/29 15:39:53  mt
 * new copyright header
 *
 * Revision 1.1  2007/02/25 08:58:46  larsbehr
 * initial checkin, import from Sourceforge.net to OpenOffice.org
 *
 * Revision 1.1  2006/02/02 21:55:59  larsbm
 * - Added Clone object support for many AODL object types
 * - New Importer implementation PlainTextImporter and CsvImporter
 * - New tests
 *
 */