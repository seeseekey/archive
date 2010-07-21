/*************************************************************************
 *
 * DO NOT ALTER OR REMOVE COPYRIGHT NOTICES OR THIS FILE HEADER.
 * 
 * Copyright 2008 by Sun Microsystems, Inc.
 *
 * OpenOffice.org - a multi-platform office productivity suite
 *
 * $RCSfile: LineStyles.cs,v $
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
	/// Represents the possible line styles used in OpenDocument.
	/// e.g for the FormatedText.Underline
	/// </summary>
	public class LineStyles
	{
		/// <summary>
		/// long-dash
		/// </summary>
		public static readonly string longdash	= "long-dash";
		/// <summary>
		/// dot-dash
		/// </summary>
		public static readonly string dotdash	= "dot-dash";
		/// <summary>
		/// dot-dot-dash
		/// </summary>
		public static readonly string dotdotdash	= "dot-dot-dash";
		/// <summary>
		/// No style
		/// </summary>
		public static readonly string none	= "none";
		/// <summary>
		/// solid
		/// </summary>
		public static readonly string solid	= "solid";
		/// <summary>
		/// dotted
		/// </summary>
		public static readonly string dotted	= "dotted";
		/// <summary>
		/// dash
		/// </summary>
		public static readonly string dash	= "dash";
		/// <summary>
		/// wave
		/// </summary>
		public static readonly string wave	= "wave";
	}

	/// <summary>
	/// Border helper class
	/// </summary>
	public class Border
	{
		/// <summary>
		/// Normal solid
		/// </summary>
		public static readonly string NormalSolid	= "0.002cm solid #000000";
		/// <summary>
		/// Middlle solid
		/// </summary>
		public static readonly string MiddleSolid	= "0.004cm solid #000000";
		/// <summary>
		/// Heavy solid
		/// </summary>
		public static readonly string HeavySolid	= "0.008cm solid #000000";
	}
}

/*
 * $Log: LineStyles.cs,v $
 * Revision 1.2  2008/04/29 15:39:54  mt
 * new copyright header
 *
 * Revision 1.1  2007/02/25 08:58:48  larsbehr
 * initial checkin, import from Sourceforge.net to OpenOffice.org
 *
 * Revision 1.1  2006/01/29 11:28:23  larsbm
 * - Changes for the new version. 1.2. see next changelog for details
 *
 * Revision 1.4  2005/11/23 19:18:17  larsbm
 * - New Textproperties
 * - New Paragraphproperties
 * - New Border Helper
 * - Textproprtie helper
 *
 * Revision 1.3  2005/10/22 15:52:10  larsbm
 * - Changed some styles from Enum to Class with statics
 * - Add full support for available OpenOffice fonts
 *
 * Revision 1.2  2005/10/08 07:55:35  larsbm
 * - added cvs tags
 *
 */