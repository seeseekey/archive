/*************************************************************************
 *
 * DO NOT ALTER OR REMOVE COPYRIGHT NOTICES OR THIS FILE HEADER.
 * 
 * Copyright 2008 by Sun Microsystems, Inc.
 *
 * OpenOffice.org - a multi-platform office productivity suite
 *
 * $RCSfile: ParagraphExt.cs,v $
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
using iTextSharp.text;

namespace AODL.ExternalExporter.PDF.Document.iTextExt
{
	/// <summary>
	/// Summary for ParagraphExt.
	/// iText paragraph extension for making it ODF compliant.
	/// </summary>
	public class ParagraphExt : Paragraph
	{
		private bool _pageBreakBefore;
		/// <summary>
		/// Gets a value indicating whether [page break before].
		/// </summary>
		/// <value><c>true</c> if [page break before]; otherwise, <c>false</c>.</value>
		public bool PageBreakBefore
		{
			get { return this._pageBreakBefore; }
			set { this._pageBreakBefore = value; }
		}

		private bool _pageBreakAfter;
		/// <summary>
		/// Gets a value indicating whether [page break after].
		/// </summary>
		/// <value><c>true</c> if [page break after]; otherwise, <c>false</c>.</value>
		public bool PageBreakAfter
		{
			get { return this._pageBreakBefore; }
			set { this._pageBreakAfter = value; }
		}

		public ParagraphExt(string text, Font font) : base(text, font)
		{
		}
	}
}
