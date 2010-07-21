/*************************************************************************
 *
 * DO NOT ALTER OR REMOVE COPYRIGHT NOTICES OR THIS FILE HEADER.
 * 
 * Copyright 2008 by Sun Microsystems, Inc.
 *
 * OpenOffice.org - a multi-platform office productivity suite
 *
 * $RCSfile: IContent.cs,v $
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
using System.Xml;
using AODL.Document.Styles;
using AODL.Document;

namespace AODL.Document.Content
{
	/// <summary>
	/// All classes that will act as content document
	/// must implement this interface.
	/// </summary>
	public interface IContent
	{
		/// <summary>
		/// Every object (typeof(IContent)) have to know his document.
		/// </summary>
		IDocument Document {get; set;}
		/// <summary>
		/// Represents the XmlNode within the content.xml from the odt file.
		/// </summary>
		XmlNode Node {get; set;}
		/// <summary>
		/// The stylename wihich is referenced with the content object.
		/// If no style is available this is null.
		/// </summary>
		string StyleName {get; set;}
		/// <summary>
		/// A Style class wich is referenced with the content object.
		/// If no style is available this is null.
		/// </summary>
		IStyle Style {get; set;}
	}
}

/*
 * $Log: IContent.cs,v $
 * Revision 1.2  2008/04/29 15:39:43  mt
 * new copyright header
 *
 * Revision 1.1  2007/02/25 08:58:33  larsbehr
 * initial checkin, import from Sourceforge.net to OpenOffice.org
 *
 * Revision 1.1  2006/01/29 11:29:46  larsbm
 * *** empty log message ***
 *
 * Revision 1.2  2005/10/08 08:19:25  larsbm
 * - added cvs tags
 *
 */