/*************************************************************************
 *
 * DO NOT ALTER OR REMOVE COPYRIGHT NOTICES OR THIS FILE HEADER.
 * 
 * Copyright 2008 by Sun Microsystems, Inc.
 *
 * OpenOffice.org - a multi-platform office productivity suite
 *
 * $RCSfile: FamiliyStyles.cs,v $
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

namespace AODL.Document.Styles
{	
	/// <summary>
	/// Class that represents th possible values. For a style emlement and his family-style attribute.
	/// </summary>
	public class FamiliyStyles
	{
		/// <summary>
		/// table
		/// </summary>
		public static readonly string Table			= "table";
		/// <summary>
		/// column
		/// </summary>
		public static readonly string TableColumn	= "table-column";
		/// <summary>
		/// cell
		/// </summary>
		public static readonly string TableCell		= "table-cell";
		/// <summary>
		/// row
		/// </summary>
		public static readonly string TableRow		= "table-row";
		/// <summary>
		/// paragraph
		/// </summary>
		public static readonly string Paragraph		= "paragraph";
		/// <summary>
		/// text
		/// </summary>
		public static readonly string Text			= "text";
		/// <summary>
		/// graphic
		/// </summary>
		public static readonly string Graphic		= "graphic";
	}
}

/*
 * $Log: FamiliyStyles.cs,v $
 * Revision 1.2  2008/04/29 15:39:54  mt
 * new copyright header
 *
 * Revision 1.1  2007/02/25 08:58:47  larsbehr
 * initial checkin, import from Sourceforge.net to OpenOffice.org
 *
 * Revision 1.1  2006/01/29 11:28:23  larsbm
 * - Changes for the new version. 1.2. see next changelog for details
 *
 * Revision 1.3  2005/10/22 15:52:10  larsbm
 * - Changed some styles from Enum to Class with statics
 * - Add full support for available OpenOffice fonts
 *
 * Revision 1.2  2005/10/08 07:50:15  larsbm
 * - added cvs tags
 *
 */