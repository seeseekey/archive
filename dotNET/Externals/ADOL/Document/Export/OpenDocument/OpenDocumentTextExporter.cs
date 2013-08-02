/*************************************************************************
 *
 * DO NOT ALTER OR REMOVE COPYRIGHT NOTICES OR THIS FILE HEADER.
 * 
 * Copyright 2008 by Sun Microsystems, Inc.
 *
 * OpenOffice.org - a multi-platform office productivity suite
 *
 * $RCSfile: OpenDocumentTextExporter.cs,v $
 *
 * $Revision: 1.6 $
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
using System.Drawing.Imaging;
using System.Collections;
using System.Diagnostics;
using System.Reflection;
using System.IO;
using ICSharpCode.SharpZipLib.Checksums;
using ICSharpCode.SharpZipLib.Zip;
using ICSharpCode.SharpZipLib.GZip;
using AODL.Document.TextDocuments;
using AODL.Document;
using AODL.Document.Content;
using AODL.Document.Content.Draw;
using AODL.Document.Import.OpenDocument;
using AODL.Document.Exceptions;
using AODL.Document .Content .EmbedObjects ;
using AODL.Document .Content .Charts ;

namespace AODL.Document.Export.OpenDocument
{
	/// <summary>
	/// OpenDocumentTextExporter is the standard exporter of AODL for the export
	/// of documents in the OpenDocument format.
	/// </summary>
	public class OpenDocumentTextExporter : IExporter, IPublisherInfo
	{
		internal static Guid folderGuid			= Guid.NewGuid();
		private static readonly string dir		= Environment.CurrentDirectory+@"\"+folderGuid.ToString()+@"\";
		private string[] _directories			= {"Configurations2", "META-INF", "Pictures", "Thumbnails"};
		private IDocument _document				= null;

		/// <summary>
		/// Initializes a new instance of the <see cref="OpenDocumentTextExporter"/> class.
		/// </summary>
		public OpenDocumentTextExporter()
		{
			this._exportError					= new ArrayList();
			
			this._supportedExtensions			= new ArrayList();
			this._supportedExtensions.Add(new DocumentSupportInfo(".odt", DocumentTypes.TextDocument));
			this._supportedExtensions.Add(new DocumentSupportInfo(".ods", DocumentTypes.SpreadsheetDocument));

			this._author						= "Lars Behrmann, lb@OpenDocument4all.com";
			this._infoUrl						= "http://AODL.OpenDocument4all.com";
			this._description					= "This the standard OpenDocument format exporter of the OpenDocument library AODL.";
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

		private System.Collections.ArrayList _exportError;
		/// <summary>
		/// Gets the export error.
		/// </summary>
		/// <value>The export error.</value>
		public System.Collections.ArrayList ExportError
		{
			get
			{
				return this._exportError;
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
				this._document			= document;
				String exportDir		= Environment.CurrentDirectory+@"\"+folderGuid.ToString()+@"\";
				PrepareDirectory(exportDir);
				//Write content
				if(document is TextDocument)
				{
					this.WriteSingleFiles(((TextDocument)document).DocumentManifest.Manifest, exportDir+DocumentManifest.FolderName+"\\"+DocumentManifest.FileName);
					this.WriteSingleFiles(((TextDocument)document).DocumentMetadata.Meta, exportDir+DocumentMetadata.FileName);
					this.WriteSingleFiles(((TextDocument)document).DocumentSetting.Settings, exportDir+DocumentSetting.FileName);
					this.WriteSingleFiles(((TextDocument)document).DocumentStyles.Styles, exportDir+DocumentStyles.FileName);
					this.WriteSingleFiles(((TextDocument)document).XmlDoc, exportDir+"content.xml");
					//Save graphics, which were build during creating a new document
					this.CopyGraphics(((TextDocument)document), exportDir);
				}
				else if(document is AODL.Document.SpreadsheetDocuments.SpreadsheetDocument)
				{
					this.WriteSingleFiles(((AODL.Document.SpreadsheetDocuments.SpreadsheetDocument)document).DocumentManifest.Manifest, exportDir+DocumentManifest.FolderName+"\\"+DocumentManifest.FileName);
					this.WriteSingleFiles(((AODL.Document.SpreadsheetDocuments.SpreadsheetDocument)document).DocumentMetadata.Meta, exportDir+DocumentMetadata.FileName);
					this.WriteSingleFiles(((AODL.Document.SpreadsheetDocuments.SpreadsheetDocument)document).DocumentSetting.Settings, exportDir+DocumentSetting.FileName);
					this.WriteSingleFiles(((AODL.Document.SpreadsheetDocuments.SpreadsheetDocument)document).DocumentStyles.Styles, exportDir+DocumentStyles.FileName);
					this.WriteSingleFiles(((AODL.Document.SpreadsheetDocuments.SpreadsheetDocument)document).XmlDoc, exportDir+"content.xml");
					
					if(document.EmbedObjects .Count !=0)
					{
						foreach ( EmbedObject eo in document.EmbedObjects)
						{
							if(eo.ObjectType.Equals("chart"))
							{
								((Chart)eo).SaveTo (exportDir);
							}
						}
					}
				
					this.WriteSingleFiles(((AODL.Document.SpreadsheetDocuments.SpreadsheetDocument)document).DocumentManifest.Manifest, exportDir+DocumentManifest.FolderName+"\\"+DocumentManifest.FileName);			
				}
				else
					throw new Exception("Unsupported document type!");
				//Write Pictures and Thumbnails
//				this.SaveExistingGraphics(document.DocumentPictures, dir+"Pictures\\");
//				this.SaveExistingGraphics(document.DocumentThumbnails, dir+"Thumbnails\\");
				//Don't know why VS couldn't read a textfile resource without file prefix
				WriteMimetypeFile(exportDir+@"\mimetyp");				
				//Now create the document
				CreateOpenDocument(filename, exportDir);
				//Clean up resources
				//this.CleanUpDirectory(exportDir);
			}
			catch(Exception)
			{
				throw; 
			}
		}

		/// <summary>
		/// Writes the single files.
		/// </summary>
		/// <param name="document">The document.</param>
		/// <param name="filename">The filename.</param>
		private void WriteSingleFiles(System.Xml.XmlDocument document, string filename)
		{
			try
			{
				//document.Save(filename);
				XmlTextWriter writer = new XmlTextWriter(filename, System.Text.Encoding.UTF8);
				writer.Formatting = Formatting.None;
				document.WriteContentTo( writer );
				writer.Flush();
				writer.Close();
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
		/// Create a zip archive with .odt.
		/// </summary>
		/// <param name="filename">The filename.</param>
		/// <param name="directory">The directory to zip.</param>
		private static void CreateOpenDocument(string filename, string directory)
		{
			try
			{
				FastZip fz = new FastZip();
				fz.CreateEmptyDirectories = true;
				fz.CreateZip(filename, directory, true, "");
				fz			= null;
				// Clean up export
				DirectoryInfo di = new DirectoryInfo(directory);
				di.Delete(true);
			}
			catch(Exception)
			{
				throw;
			}
		}

		/// <summary>
		/// Create an output directory with all necessary subfolders.
		/// </summary>
		/// <param name="directory">The directory.</param>
		private void PrepareDirectory(string directory)
		{
			try
			{
				if(Directory.Exists(directory))
					Directory.Delete(directory, true);

				foreach(string d in this._directories)
					Directory.CreateDirectory(directory+@"\"+d);
			}
			catch(Exception ex)
			{
				throw;
			}	
		}

		/// <summary>
		/// Helper Method: Don't know why, but it seems to be impossible
		/// to embbed a textfile as resource
		/// </summary>
		/// <param name="file">The filename.</param>
		private void WriteMimetypeFile(string file)
		{
			//Don't know why, but it seems to be impossible
			//to embbed a textfile as resource
			try
			{
				if(File.Exists(file))
					File.Delete(file);
				StreamWriter sw = File.CreateText(file);
				if(this._document is AODL.Document.TextDocuments.TextDocument)
				{
					sw.WriteLine("application/vnd.oasis.opendocument.text");
				}
				else if(this._document is AODL.Document.SpreadsheetDocuments.SpreadsheetDocument)
				{
					sw.WriteLine("application/vnd.oasis.opendocument.spreadsheet");
				}
				sw.Close();
			}
			catch(Exception ex)
			{
				throw;
			}
		}

		#region old code Todo: Delete
//		/// <summary>
//		/// Cleans the up directory.
//		/// </summary>
//		/// <param name="directory">The directory.</param>
//		private void CleanUpDirectory(string directory)
//		{
//			string dirpics	= Environment.CurrentDirectory+@"\PicturesRead\";
//
//			try
//			{
//				foreach(string d in this._directories)
//					Directory.Delete(directory+@"\"+d, true);
//
////				if(Directory.Exists(OpenDocumentTextImporter.dirpics))
////					Directory.Delete(OpenDocumentTextImporter.dirpics, true);
//				if(Directory.Exists(dirpics))
//					Directory.Delete(dirpics, true);
//
//				File.Delete(directory+DocumentMetadata.FileName);
//				File.Delete(directory+DocumentSetting.FileName);
//				File.Delete(directory+DocumentStyles.FileName);
//				File.Delete(directory+"content.xml");
//			}
//			catch(Exception ex)
//			{
//				throw;
//			}
//		}
		#endregion

		/// <summary>
		/// Cleans the up read and write directories.
		/// </summary>
		internal static void CleanUpReadAndWriteDirectories()
		{
			try
			{
				if(Directory.Exists(OpenDocumentImporter.dir))
					Directory.Delete(OpenDocumentImporter.dir, true);
				if(Directory.Exists(OpenDocumentImporter.dir))
					Directory.Delete(OpenDocumentImporter.dir, true);
//				if(Directory.Exists(OpenDocumentTextExporter.dir))
//					Directory.Delete(OpenDocumentTextExporter.dir, true);
			}
			catch(Exception ex)
			{
				AODLWarning aodlWarning				= new AODLWarning("An exception ouccours while trying to remove the temp read directories.");
				aodlWarning.InMethod				= AODLException.GetExceptionSourceInfo(new StackFrame(1, true));
				aodlWarning.OriginalException		= ex;

				throw ex;
			}
		}

		/// <summary>
		/// Saves all graphics used within the textdocument.
		/// </summary>
		/// <param name="document">The document.</param>
		/// <param name="directory">The directory.</param>
//		private void SaveGraphic(IDocument document, string directory)
//		{
//			CopyGraphics(document, directory);
//		}
		
		/// <summary>
		/// Copies the graphics.
		/// </summary>
		/// <param name="document">The document.</param>
		/// <param name="directory">The directory.</param>
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
								//this.BinaryFileCopy(graphic.GraphicRealPath, picturedir+fInfo.Name);
						}
						else
							File.Copy(graphic.GraphicRealPath, picturedir+graphic.GraphicFileName);
							//this.BinaryFileCopy(graphic.GraphicRealPath, picturedir+graphic.GraphicFileName);
					}					
				}
				//MovePicturesIfLoaded(document, picturedir);
			}
			catch(Exception ex)
			{
				Console.WriteLine("CopyGraphics: {0}", ex.Message);
				throw;
			}
		}

		private void BinaryFileCopy(String source, String target) 
		{
			if(!File.Exists(target)) 
			{
				using(BinaryWriter targetWriter = new BinaryWriter(new FileStream(target, FileMode.Create)))
				{
					using(BinaryReader srcReader = new BinaryReader(new FileStream(target, FileMode.Open)))
					{
						byte[] buffer = new byte[1024];
						while(srcReader.BaseStream.Position < srcReader.BaseStream.Length)
						{
							int count = srcReader.Read(buffer, 0, buffer.Length);
							targetWriter.Write(buffer, 0, count);
						};
					};
				};
			}
		}

		/// <summary>
		/// Moves the pictures if loaded.
		/// </summary>
		/// <param name="document">The document.</param>
		/// <param name="targetDir">The target dir.</param>
//		private static void MovePicturesIfLoaded(IDocument document,string targetDir)
//		{
////			if(document.DocumentPictures.Count > 0)
////			{
////				foreach(DocumentPicture docPic in document.DocumentPictures)
////				{
////					if(File.Exists(docPic.ImagePath))
////					{
////						FileInfo fInfo			= new FileInfo(docPic.ImagePath);
////						File.Copy(docPic.ImagePath, targetDir+fInfo.Name, true);
////					}
////					
////				}
////			}
//		}
		
	}
}

/*
 * $Log: OpenDocumentTextExporter.cs,v $
 * Revision 1.6  2008/05/07 17:19:45  larsbehr
 * - Optimized Exporter Save procedure
 * - Optimized Tests behaviour
 * - Added ODF Package Layer
 * - SharpZipLib updated to current version
 *
 * Revision 1.5  2008/04/29 15:39:48  mt
 * new copyright header
 *
 * Revision 1.4  2008/02/08 07:12:20  larsbehr
 * - added initial chart support
 * - several bug fixes
 *
 * Revision 1.2  2007/04/08 16:51:31  larsbehr
 * - finished master pages and styles for text documents
 * - several bug fixes
 *
 * Revision 1.1  2007/02/25 08:58:43  larsbehr
 * initial checkin, import from Sourceforge.net to OpenOffice.org
 *
 * Revision 1.6  2006/05/02 17:37:16  larsbm
 * - Flag added graphics with guid
 * - Set guid based read and write directories
 *
 * Revision 1.5  2006/02/21 19:34:55  larsbm
 * - Fixed Bug text that contains a xml tag will be imported  as UnknowText and not correct displayed if document is exported  as HTML.
 * - Fixed Bug [ 1436080 ] Common styles
 *
 * Revision 1.4  2006/02/16 18:35:41  larsbm
 * - Add FrameBuilder class
 * - TextSequence implementation (Todo loading!)
 * - Free draing postioning via x and y coordinates
 * - Graphic will give access to it's full qualified path
 *   via the GraphicRealPath property
 * - Fixed Bug with CellSpan in Spreadsheetdocuments
 * - Fixed bug graphic of loaded files won't be deleted if they
 *   are removed from the content.
 * - Break-Before property for Paragraph properties for Page Break
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
 * Revision 1.5  2006/01/05 10:28:06  larsbm
 * - AODL merged cells
 * - AODL toc
 * - AODC batch mode, splash screen
 *
 * Revision 1.4  2005/12/18 18:29:46  larsbm
 * - AODC Gui redesign
 * - AODC HTML exporter refecatored
 * - Full Meta Data Support
 * - Increase textprocessing performance
 *
 * Revision 1.3  2005/12/12 19:39:17  larsbm
 * - Added Paragraph Header
 * - Added Table Row Header
 * - Fixed some bugs
 * - better whitespace handling
 * - Implmemenation of HTML Exporter
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