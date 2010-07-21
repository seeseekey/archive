/*************************************************************************
 *
 * DO NOT ALTER OR REMOVE COPYRIGHT NOTICES OR THIS FILE HEADER.
 * 
 * Copyright 2008 by Sun Microsystems, Inc.
 *
 * OpenOffice.org - a multi-platform office productivity suite
 *
 * $RCSfile: HeadingConverter.cs,v $
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
using AODL.Document.Content.Text;
using AODL.Document.Styles;
using AODL.ExternalExporter.PDF.Document.StyleConverter;

namespace AODL.ExternalExporter.PDF.Document.ContentConverter
{
	/// <summary>
	/// Summary HeadingConverter.
	/// </summary>
	public class HeadingConverter
	{
		/// <summary>
		/// Initializes a new instance of the <see cref="HeadingConverter"/> class.
		/// </summary>
		public HeadingConverter()
		{
		}

		/// <summary>
		/// Converts the specified heading.
		/// </summary>
		/// <param name="heading">The heading.</param>
		/// <returns>A PDF paragraph representing the ODF heading</returns>
		public static iTextSharp.text.Paragraph Convert(Header heading)
		{
			try
			{
				iTextSharp.text.Font font = DefaultDocumentStyles.Instance().DefaultTextFont;
				IStyle style = heading.Document.CommonStyles.GetStyleByName(heading.StyleName);
				if(style != null && style is ParagraphStyle)
				{
					if((ParagraphStyle)style != null)
					{
						if(((ParagraphStyle)style).ParentStyle != null)
						{
							IStyle parentStyle = heading.Document.CommonStyles.GetStyleByName(
								((ParagraphStyle)style).ParentStyle);
							if(parentStyle != null 
								&& parentStyle is ParagraphStyle
								&& ((ParagraphStyle)parentStyle).TextProperties != null
								&& ((ParagraphStyle)style).TextProperties != null)
							{
								// get parent style first
								font = TextPropertyConverter.GetFont(((ParagraphStyle)parentStyle).TextProperties);
								// now use the orignal style as multiplier
								font = TextPropertyConverter.FontMultiplier(((ParagraphStyle)style).TextProperties, font);
							}
							else
							{
								font = TextPropertyConverter.GetFont(((ParagraphStyle)style).TextProperties);
							}
						}
						else
						{
							font = TextPropertyConverter.GetFont(((ParagraphStyle)style).TextProperties);
						}
					}
				}
				iTextSharp.text.Paragraph paragraph = new iTextSharp.text.Paragraph("", font); // default ctor protected - why ??
				paragraph.AddRange(FormatedTextConverter.GetTextContents(heading.TextContent, font));
				return paragraph;
			}
			catch(Exception ex)
			{
				throw;
			}
		}
	}
}
