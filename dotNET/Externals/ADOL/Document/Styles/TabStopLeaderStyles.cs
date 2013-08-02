/*************************************************************************
 *
 * DO NOT ALTER OR REMOVE COPYRIGHT NOTICES OR THIS FILE HEADER.
 * 
 * Copyright 2008 by Sun Microsystems, Inc.
 *
 * OpenOffice.org - a multi-platform office productivity suite
 *
 * $RCSfile: TabStopLeaderStyles.cs,v $
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
	/// Represent all possible TabStopLeader Styles.
	/// </summary>
	public class TabStopLeaderStyles
	{
		/// <summary>
		/// Initializes a new instance of the <see cref="TabStopLeaderStyles"/> class.
		/// </summary>
		public TabStopLeaderStyles()
		{
		}

		/// <summary>
		/// Dotted style
		/// </summary>
		public static readonly string Dotted		= "dotted";
		/// <summary>
		/// Dotted style
		/// </summary>
		public static readonly string Solid			= "solid";
	}

	/// <summary>
	/// Represent all possible TabStopLeader Styles.
	/// </summary>
	public class TabStopTypes
	{
		/// <summary>
		/// Initializes a new instance of the <see cref="TabStopLeaderStyles"/> class.
		/// </summary>
		public TabStopTypes()
		{
		}

		/// <summary>
		/// Right
		/// </summary>
		public static readonly string Right			= "right";
		/// <summary>
		/// Center
		/// </summary>
		public static readonly string Center		= "center";
	}
}

/*
 * $Log: TabStopLeaderStyles.cs,v $
 * Revision 1.2  2008/04/29 15:39:54  mt
 * new copyright header
 *
 * Revision 1.1  2007/02/25 08:58:50  larsbehr
 * initial checkin, import from Sourceforge.net to OpenOffice.org
 *
 * Revision 1.1  2006/01/29 11:28:23  larsbm
 * - Changes for the new version. 1.2. see next changelog for details
 *
 * Revision 1.1  2005/11/20 17:31:20  larsbm
 * - added suport for XLinks, TabStopStyles
 * - First experimental of loading dcuments
 * - load and save via importer and exporter interfaces
 *
 */
