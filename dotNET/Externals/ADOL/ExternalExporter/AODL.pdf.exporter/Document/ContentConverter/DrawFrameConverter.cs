/*************************************************************************
 *
 * DO NOT ALTER OR REMOVE COPYRIGHT NOTICES OR THIS FILE HEADER.
 * 
 * Copyright 2008 by Sun Microsystems, Inc.
 *
 * OpenOffice.org - a multi-platform office productivity suite
 *
 * $RCSfile: DrawFrameConverter.cs,v $
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
using AODL.Document.Content;
using AODL.Document.Content.Draw;
using AODL.Document.Content.Text;
using AODL.Document.Styles;
using AODL.Document.Styles.Properties;

namespace AODL.ExternalExporter.PDF.Document.ContentConverter
{
	/// <summary>
	/// Summary for DrawFrameConverter.
	/// </summary>
	public class DrawFrameConverter
	{
		/// <summary>
		/// Initializes a new instance of the <see cref="DrawFrameConverter"/> class.
		/// </summary>
		public DrawFrameConverter()
		{
		}

		/// <summary>
		/// Converts the specified frame into an PDF paragraph.
		/// </summary>
		/// <param name="frame">The frame.</param>
		/// <returns>The paragraph representing the passed frame.</returns>
		public iTextSharp.text.Paragraph Convert(Frame frame)
		{
			try
			{
				iTextSharp.text.Paragraph paragraph = new iTextSharp.text.Paragraph();
				foreach(iTextSharp.text.IElement pdfElement in MixedContentConverter.GetMixedPdfContent(frame.Content))
				{
					paragraph.Add(pdfElement);
				}
				return paragraph;
			}
			catch(Exception)
			{
				throw;
			}
		}
	}
}
