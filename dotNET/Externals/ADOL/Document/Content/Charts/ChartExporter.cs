/*************************************************************************
 *
 * DO NOT ALTER OR REMOVE COPYRIGHT NOTICES OR THIS FILE HEADER.
 * 
 * Copyright 2008 by Sun Microsystems, Inc.
 *
 * OpenOffice.org - a multi-platform office productivity suite
 *
 * $RCSfile: ChartExporter.cs,v $
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
using System.Xml ;
using System.Diagnostics ;
using System.Collections ;
using System.IO ;
using ICSharpCode.SharpZipLib ;
using ICSharpCode.SharpZipLib .GZip;
using ICSharpCode.SharpZipLib .Checksums;
using ICSharpCode.SharpZipLib .Zip;
using ICSharpCode.SharpZipLib .BZip2 ;
using AODL.Document .Content.EmbedObjects; 
using AODL.Document .SpreadsheetDocuments ;
using AODL.Document .Styles ;

namespace AODL.Document.Content.Charts
{
	/// <summary>
	/// Summary description for OpenDocumentTextExporter.
	/// </summary>
	public class ChartExporter 
	{
		//internal static Guid folderGuid			= Guid.NewGuid();
		//private static readonly string dir		= Environment.CurrentDirectory+@"\"+folderGuid.ToString()+@"\";
		private string[] _directories			= {"ObjectReplacements"};
		private IDocument _document				= null;

		/// <summary>
		/// Initializes a new instance of the <see cref="OpenDocumentTextExporter"/> class.
		/// </summary>
		public ChartExporter()
		{

		}

		#region IExporter Member

		/// <summary>
		/// Exports the specified document.
		/// </summary>
		/// <param name="document">The document.</param>
		/// <param name="filename">The filename.</param>
		public void Export(IDocument document,string dir)
		{
			try
			{
				this._document			= document;
				PrepareDirectory(dir);
				
				foreach ( EmbedObject eo in document.EmbedObjects)
				{
					if(eo.ObjectType.Equals("chart"))
					{
						this.WriteSingleFiles(((Chart)eo).ChartStyles.Styles,dir+eo.ObjectName+"\\"+ChartStyles.FileName);
						this.WriteSingleFiles(((Chart)eo).ChartDoc,dir+eo.ObjectName+"\\"+"content.xml");
						this.WriteFileEntry( ((Chart)eo).ObjectName );

					}
				}
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

		/// <summary>
		/// Create an output directory with all necessary subfolders.
		/// </summary>
		/// <param name="directory">The directory.</param>
		private void PrepareDirectory(string directory)
		{
			try
			{

				foreach(EmbedObject eo in this._document.EmbedObjects)
					if(eo.ObjectType.Equals("chart"))
						Directory.CreateDirectory(directory+@"\"+eo.ObjectName);

				foreach(string d in this._directories)
					Directory.CreateDirectory(directory+@"\"+d);
			}
			catch(Exception ex)
			{
				throw;
			}	
		}

		private void WriteFileEntry(string objectName)
		{
			XmlNode  manifest = ((SpreadsheetDocument)this._document).DocumentManifest .Manifest .SelectSingleNode ("manifest:manifest",this._document.NamespaceManager );
		    
            XmlNode  node =((SpreadsheetDocument)this._document).CreateNode("file-entry","manifest");
			XmlAttribute xa = this._document.CreateAttribute ("media-type","manifest");
			xa.Value ="text/xml";
			node.Attributes .Append (xa);

			xa = this._document.CreateAttribute ("full-path","manifest");
			xa.Value =objectName+@"/"+"content.xml";
			node.Attributes .Append (xa);
            
		    node  = ((SpreadsheetDocument)this._document).DocumentManifest .Manifest.ImportNode (node,true);
			manifest.AppendChild (node);

			node = this._document .CreateNode ("file-entry","manifest");
		    
			xa = this._document.CreateAttribute ("media-type","manifest");
			xa.Value ="text/xml";
			node.Attributes .Append (xa);

			xa = this._document.CreateAttribute ("full-path","manifest");
			xa.Value =objectName+@"/"+"styles.xml";
			node.Attributes .Append (xa);

			node  = ((SpreadsheetDocument)this._document).DocumentManifest .Manifest.ImportNode (node,true);
			manifest.AppendChild (node);

			node = this._document .CreateNode ("file-entry","manifest");
		    
			xa = this._document.CreateAttribute ("media-type","manifest");
			xa.Value ="application/vnd.oasis.opendocument.chart";
			node.Attributes .Append (xa);

			xa = this._document.CreateAttribute ("full-path","manifest");
			xa.Value =objectName+@"/";
			node.Attributes .Append (xa);

			node  = ((SpreadsheetDocument)this._document).DocumentManifest .Manifest.ImportNode (node,true);
			manifest.AppendChild (node);
		}
	}
	
}

