/*************************************************************************
 *
 * DO NOT ALTER OR REMOVE COPYRIGHT NOTICES OR THIS FILE HEADER.
 * 
 * Copyright 2008 by Sun Microsystems, Inc.
 *
 * OpenOffice.org - a multi-platform office productivity suite
 *
 * $RCSfile: ParagraphPropertyConverter.cs,v $
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
using AODL.Document.Styles;
using AODL.Document.Styles.Properties;
using iTextSharp.text;

namespace AODL.ExternalExporter.PDF.Document.StyleConverter
{
	/// <summary>
	/// Zusammenfassung für ParagraphPropertyConverter.
	/// </summary>
	public class ParagraphPropertyConverter
	{
		public ParagraphPropertyConverter()
		{
		}

		/// <summary>
		/// Gets the align ment.
		/// </summary>
		/// <param name="paragraphProperties">The ODF align ment.</param>
		/// <returns>The align ment</returns>
		public static int GetAlignMent(string odfAlignMent)
		{
			try
			{
				switch(odfAlignMent)
				{
					case "right":
						return Element.ALIGN_RIGHT;
					case "justify":
						return Element.ALIGN_JUSTIFIED;
					case "start":
						return Element.ALIGN_LEFT;
					case "end":
						return Element.ALIGN_RIGHT;
					default:
						return Element.ALIGN_LEFT;
				}
			}
			catch(Exception)
			{
				throw;
			}
		}
	}
}
