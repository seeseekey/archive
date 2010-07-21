/*************************************************************************
 *
 * DO NOT ALTER OR REMOVE COPYRIGHT NOTICES OR THIS FILE HEADER.
 * 
 * Copyright 2008 by Sun Microsystems, Inc.
 *
 * OpenOffice.org - a multi-platform office productivity suite
 *
 * $RCSfile: OpenDocumentHtmlExporter.cs,v $
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
using System.IO;
using System.Reflection;
using System.Collections;
using AODL.Document.Content.Draw;
using AODL.Document.Content;
using AODL.Document;
using AODL.Document.Export.OpenDocument;

namespace AODL.Document.Export.Html
{
	/// <summary>
	/// Export the OpenDocument content as Html
	/// </summary>
	public class OpenDocumentHtmlExporter : IExporter, IPublisherInfo
	{
		private readonly string _imgFolder	= "tempHtmlImg";

		private IDocument _document;

		/// <summary>
		/// Initializes a new instance of the <see cref="OpenDocumentHtmlExporter"/> class.
		/// </summary>
		public OpenDocumentHtmlExporter()
		{
			this._exporterror				= new ArrayList();

			this._supportedExtensions		= new ArrayList();
			this._supportedExtensions.Add(new DocumentSupportInfo(".html", DocumentTypes.TextDocument));
			this._supportedExtensions.Add(new DocumentSupportInfo(".html", DocumentTypes.SpreadsheetDocument));
			this._supportedExtensions.Add(new DocumentSupportInfo(".htm", DocumentTypes.TextDocument));
			this._supportedExtensions.Add(new DocumentSupportInfo(".htm", DocumentTypes.SpreadsheetDocument));

			this._author						= "Lars Behrmann, lb@OpenDocument4all.com";
			this._infoUrl						= "http://AODL.OpenDocument4all.com";
			this._description					= "This the standard HTML exporter of the OpenDocument library AODL.";
		}

		#region IExporter Member

		private ArrayList _supportedExtensions;
		/// <summary>
		/// ArrayList of DocumentSupportInfo objects
		/// </summary>
		/// <value>ArrayList of DocumentSupportInfo objects.</value>
		public ArrayList DocumentSupportInfos		
		{
			get { return this._supportedExtensions; }
		}

		private ArrayList _exporterror;
		/// <summary>
		/// Gets the export error.
		/// </summary>
		/// <value>The export error.</value>
		public System.Collections.ArrayList ExportError
		{
			get
			{
				return this._exporterror;
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
				this._document		= document;
				string targDir		= Environment.CurrentDirectory;
				int index			= filename.LastIndexOf(@"\");
				if(index != -1)
					targDir			= filename.Substring(0, index);
				string pictures		= "\\Pictures";
				string imgfolder	= targDir+"\\"+this._imgFolder;
				if(!Directory.Exists(imgfolder+pictures))
					Directory.CreateDirectory(imgfolder+pictures);
				this.CopyGraphics(this._document, imgfolder);
				string htmlsite		= this.AppendHtml(this._document.Content, this.GetTemplate());
				this.WriteHtmlFile(filename, htmlsite);
			}
			catch(Exception)
			{
				throw;
			}
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
		/// Gets the template.
		/// </summary>
		/// <returns>The template as sring</returns>
		private string GetTemplate()
		{
			try
			{
				Assembly ass		= Assembly.GetExecutingAssembly();
				Stream str			= ass.GetManifestResourceStream("AODL.Resources.OD.htmltemplate.html");

				string text			= null;
				using (StreamReader sr = new StreamReader(str)) 
				{
					String line		= null;
					while ((line = sr.ReadLine()) != null) 
					{
						text		+= line+"\n";
					}
					sr.Close();
				}
				str.Close();

				return text;
			}
			catch(Exception)
			{
				throw;
			}
		}

		private void CopyGraphics(IDocument document, string directory)
		{
			try
			{
				string picturedir		= directory+@"\Pictures\";

				foreach(Graphic graphic in document.Graphics)
				{
					if(graphic.GraphicRealPath != null)
					{
						//Loaded or added
						if(graphic.GraphicFileName == null)
						{
							FileInfo fInfo	= new FileInfo(graphic.GraphicRealPath);
							if(!File.Exists(picturedir+fInfo.Name))
								File.Copy(graphic.GraphicRealPath, picturedir+fInfo.Name);
						}
						else
							File.Copy(graphic.GraphicRealPath, picturedir+graphic.GraphicFileName);
					}					
				}
			}
			catch(Exception ex)
			{
				Console.WriteLine("CopyGraphics: {0}", ex.Message);
				throw;
			}
		}

		/// <summary>
		/// Appends the HTML.
		/// </summary>
		/// <param name="contentlist">The contentlist.</param>
		/// <param name="template">The template.</param>
		/// <returns>The filled template string</returns>
		private string AppendHtml(IContentCollection contentlist, string template)
		{
			try
			{
				HTMLContentBuilder htmlContentBuilder	= new HTMLContentBuilder();
				htmlContentBuilder.GraphicTargetFolder	= this._imgFolder;
				string htmlBody							= htmlContentBuilder.GetIContentCollectionAsHtml(this._document.Content);
				template								+= htmlBody;

				template		+= "</body>\n</html>";

				template		= this.SetMetaContent(template);
				
				return template;
			}
			catch(Exception)
			{
				throw;
			}
		}

		/// <summary>
		/// Writes the HTML file.
		/// </summary>
		/// <param name="filename">The filename.</param>
		/// <param name="html">The HTML.</param>
		private void WriteHtmlFile(string filename, string html)
		{
			try
			{
				FileStream fstream		= File.Create(filename);
				StreamWriter swriter	= new StreamWriter(fstream, System.Text.Encoding.UTF8);
				swriter.WriteLine(html);
				swriter.Close();
				fstream.Close();
			}
			catch(Exception)
			{
				throw;
			}
		}

		/// <summary>
		/// Sets the content of the meta.
		/// </summary>
		/// <param name="text">The text.</param>
		/// <returns></returns>
		private string SetMetaContent(string text)
		{
			try
			{
				string metaContent	= ((IHtml)this._document.DocumentMetadata).GetHtml();

				if(metaContent != String.Empty)
					text			= text.Replace("<!--meta-->", metaContent);
			}
			catch(Exception)
			{
				//unhandled only meta content wouldn't be displayed
			}

			return text;
		}
		
	}
}

/*
 * $Log: OpenDocumentHtmlExporter.cs,v $
 * Revision 1.4  2008/05/07 17:19:45  larsbehr
 * - Optimized Exporter Save procedure
 * - Optimized Tests behaviour
 * - Added ODF Package Layer
 * - SharpZipLib updated to current version
 *
 * Revision 1.3  2008/04/29 15:39:48  mt
 * new copyright header
 *
 * Revision 1.2  2007/04/08 16:51:31  larsbehr
 * - finished master pages and styles for text documents
 * - several bug fixes
 *
 * Revision 1.1  2007/02/25 08:58:43  larsbehr
 * initial checkin, import from Sourceforge.net to OpenOffice.org
 *
 * Revision 1.2  2006/02/05 20:03:32  larsbm
 * - Fixed several bugs
 * - clean up some messy code
 *
 * Revision 1.1  2006/01/29 11:28:23  larsbm
 * - Changes for the new version. 1.2. see next changelog for details
 *
 * Revision 1.2  2005/12/18 18:29:46  larsbm
 * - AODC Gui redesign
 * - AODC HTML exporter refecatored
 * - Full Meta Data Support
 * - Increase textprocessing performance
 *
 * Revision 1.1  2005/12/12 19:39:17  larsbm
 * - Added Paragraph Header
 * - Added Table Row Header
 * - Fixed some bugs
 * - better whitespace handling
 * - Implmemenation of HTML Exporter
 *
 */