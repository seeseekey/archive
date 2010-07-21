/*************************************************************************
 *
 * DO NOT ALTER OR REMOVE COPYRIGHT NOTICES OR THIS FILE HEADER.
 * 
 * Copyright 2008 by Sun Microsystems, Inc.
 *
 * OpenOffice.org - a multi-platform office productivity suite
 *
 * $RCSfile: ODFPackage.cs,v $
 *
 * $Revision: 1.1 $
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
using ICSharpCode.SharpZipLib.Zip;
using ICSharpCode.SharpZipLib.Zip.Compression;
using ICSharpCode.SharpZipLib.Zip.Compression.Streams;

namespace AODL.Package
{
	/// <summary>
	/// Summary for ODFPackage.
	/// </summary>
	/// <example>
	/// ODFPackage odfPackage = new ODFPackage(testFile1);
	/// XmlDocument content = new XmlDocument();
	/// content.Load(odfPackage.GetStreamByName(ODFPackage.ODFContentXML));
	/// // doing some changes .. content.DocumentElement.AppendChild( content.CreateTextNode("lalalal") );
	/// MemoryStream saveStream = new MemoryStream();
	/// content.Save(saveStream);
	/// odfPackage.AddEntryFromMemoryStream(saveStream, ODFPackage.ODFContentXML);
	/// odfPackage.Close();
	/// </example>
	public class ODFPackage
	{
		public static string ODFContentXML = "content.xml";
		public static string ODFStylesXML = "styles.xml";
		public static string ODFMetaXML = "meta.xml";
		public static string ODFSettingsXML = "settings.xml";
		public static string ODFManifestXML = "META-INF/manifest.xml";

		private bool _hasChanges = false;
		private bool _inUpdateMode = false;

		private string _currentFile;
		/// <summary>
		/// Gets the current file.
		/// </summary>
		/// <value>The current file.</value>
		public string CurrentFile
		{
			get { return this._currentFile; }
		}

		private ZipFile _package;
		/// <summary>
		/// Gets or sets the package.
		/// </summary>
		/// <value>The package.</value>
		public ZipFile Package
		{
			get { return this._package; }
			set { this._package = value; }
		}

		/// <summary>
		/// Initializes a new instance of the <see cref="ODFPackage"/> class.
		/// </summary>
		public ODFPackage()
		{
		}

		/// <summary>
		/// Initializes a new instance of the <see cref="ODFPackage"/> class.
		/// </summary>
		/// <param name="odfFile">The odf file.</param>
		public ODFPackage(string odfFile)
		{
			this.Load(odfFile);
		}

		/// <summary>
		/// Loads the specified odf file.
		/// </summary>
		/// <param name="odfFile">The odf file.</param>
		public void Load(string odfFile)
		{
			this._currentFile = odfFile;
			this._package = new ZipFile(File.Open(odfFile, FileMode.Open, FileAccess.ReadWrite, FileShare.ReadWrite));
            //this._package.BeginUpdate();
		}

		/// <summary>
		/// Gets the name of the stream by.
		/// </summary>
		/// <param name="entryName">Name of the entry.</param>
		/// <returns></returns>
		public MemoryStream GetStreamByName(string entryName)
		{
			ZipEntry zipEntry = this.GetEntryByName(entryName);
			if (zipEntry != null)
			{
				long entrySize = zipEntry.Size;
				Byte[] b = new Byte[entrySize];			
				Stream zipStream = this._package.GetInputStream((ZipEntry)zipEntry.Clone());
				if (zipStream != null)
				{
					zipStream.Read(b, 0, b.Length);
					return new System.IO.MemoryStream(b, true);
				}
			}
			return null;
		}

		/// <summary>
		/// Gets the name of the entry by.
		/// </summary>
		/// <param name="entryName">Name of the entry.</param>
		/// <returns></returns>
		private ZipEntry GetEntryByName(string entryName)
		{
			return this._package.GetEntry(entryName);
		}

		/// <summary>
		/// Begins the update.
		/// </summary>
		public void BeginUpdate()
		{
			if(!this._inUpdateMode)
			{
				this._package.BeginUpdate();
				this._inUpdateMode = true;
			}
		}

		/// <summary>
		/// Adds the entry from memory stream.
		/// </summary>
		/// <param name="memoryStream">The memory stream.</param>
		/// <param name="entryName">Name of the entry.</param>
		public void AddEntryFromMemoryStream(MemoryStream memoryStream, string entryName)
		{
			if(memoryStream != null)
			{
                this._package.BeginUpdate();
                memoryStream.Flush();
                memoryStream.Position = 0;
                ZipEntry zipEntry = this.GetEntryByName(entryName);
                if (zipEntry != null)
                {
                    this._package.Delete(zipEntry);
                }
                ODFMemoryStream odfMemStream = new ODFMemoryStream(memoryStream);                
				this._package.Add(odfMemStream, "/"+entryName);
				this._hasChanges = true;
			}
		}

		/// <summary>
		/// Aborts the package update.
		/// </summary>
		public void AbortPackageUpdate()
		{
			if(this._inUpdateMode && this._hasChanges)
			{
				this._package.AbortUpdate();
				this._inUpdateMode = false;
				this._hasChanges = false;
			}
		}

		/// <summary>
		/// Commits the changes.
		/// </summary>
		public void CommitChanges()
		{
			if(this._inUpdateMode && this._hasChanges)
			{
				this._package.CommitUpdate();
				this._hasChanges = false;
			}
		}

		/// <summary>
		/// Closes this ODFPackage.
		/// If this package has changes they will be commited and saved.
		/// If you have done changes to the package and won't save them
		/// use the AbortPackageUpdate() method before calling Close().
		/// </summary>
		public void Close()
		{
            //return;
			//this.CommitChanges();
            if (this._package.IsUpdating)
            {
                this._package.CommitUpdate();    
            }            
			this._package.Close();
		}
	}
}

/*
 * $Log: ODFPackage.cs,v $
 * Revision 1.1  2008/05/07 17:20:08  larsbehr
 * - Optimized Exporter Save procedure
 * - Optimized Tests behaviour
 * - Added ODF Package Layer
 * - SharpZipLib updated to current version
 *
 */