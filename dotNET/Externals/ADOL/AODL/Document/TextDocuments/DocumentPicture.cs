/*************************************************************************
 *
 * DO NOT ALTER OR REMOVE COPYRIGHT NOTICES OR THIS FILE HEADER.
 * 
 * Copyright 2008 by Sun Microsystems, Inc.
 *
 * OpenOffice.org - a multi-platform office productivity suite
 *
 * $RCSfile: DocumentPicture.cs,v $
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
using System.IO;
using System.Drawing;

namespace AODL.Document.TextDocuments
{
	/// <summary>
	/// DocumentPicture represent a picture resp. graphic which used within
	/// a file in the OpenDocument format.
	/// </summary>
	public class DocumentPicture 
	{
		private Image _image;
		/// <summary>
		/// Gets or sets the image.
		/// </summary>
		/// <value>The image.</value>
		public Image Image
		{
			get { return this._image; }
			set { this._image = value; }
		}

		private string _imageName;
		/// <summary>
		/// Gets or sets the name of the image.
		/// </summary>
		/// <value>The name of the image.</value>
		public string ImageName
		{
			get { return this._imageName; }
			set { this._imageName = value; }
		}

		private string _imagePath;
		/// <summary>
		/// Gets or sets the path of the image.
		/// </summary>
		/// <value>The path of the image.</value>
		public string ImagePath
		{
			get { return this._imagePath; }
			set { this._imagePath = value; }
		}

		/// <summary>
		/// Initializes a new instance of the <see cref="DocumentPicture"/> class.
		/// </summary>
		public DocumentPicture()
		{			
		}

		/// <summary>
		/// Initializes a new instance of the <see cref="DocumentPicture"/> class.
		/// </summary>
		/// <param name="file">The file.</param>
		public DocumentPicture(string file)
		{
			try
			{
//				if(!File.Exists(file))
//					throw new Exception("The imagefile "+file+" doesn't exist!");
//				this.Image		= Image.FromFile(file);
				FileInfo fi		= new FileInfo(file);
				this.ImageName	= fi.Name;
				this.ImagePath	= fi.FullName;
			}
			catch(Exception)
			{
				throw;
			}
		}
	}
}
