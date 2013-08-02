/*************************************************************************
 *
 * DO NOT ALTER OR REMOVE COPYRIGHT NOTICES OR THIS FILE HEADER.
 * 
 * Copyright 2008 by Sun Microsystems, Inc.
 *
 * OpenOffice.org - a multi-platform office productivity suite
 *
 * $RCSfile: TextPageHeader.cs,v $
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
using AODL.Document.Styles;
using AODL.Document.TextDocuments;
using AODL.Document.Helper;
using System.Collections;
using System.Xml;


namespace AODL.Document.Styles.MasterStyles
{
	/// <summary>
	/// Summary for TextPageHeader.
	/// </summary>
	public class TextPageHeader : TextPageHeaderFooterBase
	{
		/// <summary>
		/// Initializes a new instance of the <see cref="TextPageHeader"/> class.
		/// </summary>
		public TextPageHeader()
		{
		}

		/// <summary>
		/// Create a new TextPageHeader object within the passed text master page.
		/// </summary>
		/// <param name="textMasterPage">The text master page.</param>
		public void New(TextMasterPage textMasterPage)
		{
			try
			{
				base.New(textMasterPage, "header");
			}
			catch(Exception)
			{
				throw;
			}
		}
	}
}
