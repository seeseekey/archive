/*************************************************************************
 *
 * DO NOT ALTER OR REMOVE COPYRIGHT NOTICES OR THIS FILE HEADER.
 * 
 * Copyright 2008 by Sun Microsystems, Inc.
 *
 * OpenOffice.org - a multi-platform office productivity suite
 *
 * $RCSfile: Component.cs,v $
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
using unoidl.com.sun.star.lang;
using unoidl.com.sun.star.uno;
using unoidl.com.sun.star.bridge;
using unoidl.com.sun.star.frame;

namespace OpenOfficeLib.Document
{
	/// <summary>
	/// Methods for Component handling.
	/// </summary>
	public class Component
	{
		/// <summary>
		/// string for new writer instance
		/// </summary>
		public static string Writer		= "private:factory/swriter";
		/// <summary>
		/// string for new calc instance
		/// </summary>
		public static string Calc		= "private:factory/scalc";
		/// <summary>
		/// string for new Draw instance
		/// </summary>
		public static string Draw		= "private:factory/sdraw";
		/// <summary>
		/// string for new Impress instance
		/// </summary>
		public static string Impress	= "private:factory/simpress";

		/// <summary>
		/// Initializes a new instance of the <see cref="Component"/> class.
		/// </summary>
		public Component()
		{
		}

		/// <summary>
		/// Load a given file or create a new blank file
		/// </summary>
		/// <param name="aLoader">A ComponentLoader</param>
		/// <param name="file">The file</param>
		/// <param name="target">The target frame name</param>
		/// <returns>The Component object</returns>
		public static unoidl.com.sun.star.lang.XComponent LoadDocument(
			unoidl.com.sun.star.frame.XComponentLoader aLoader, string file, string target
			)
		{
			try
			{
				XComponent xComponent = aLoader.loadComponentFromURL(
					file, target, 0,
					new unoidl.com.sun.star.beans.PropertyValue[0] );

				return xComponent;
			}
			catch(System.Exception ex)
			{
				throw;
			}
		}

		/// <summary>
		/// Store the document to a given url
		/// </summary>
		/// <param name="storablecomponent">The storable component</param>
		/// <param name="url">The url</param>
		public static void StoreToUrl(
			unoidl.com.sun.star.frame.XStorable storablecomponent, string url)
		{
			try
			{
				storablecomponent.storeToURL(
					PathConverter(url),
					new unoidl.com.sun.star.beans.PropertyValue[] {});
			}
			catch(System.Exception ex)
			{
				throw;
			}
		}

		/// <summary>
		/// Store the document to a given url
		/// </summary>
		/// <param name="storablecomponent">The storable component</param>
		/// <param name="url">The url</param>
		public static void StoreAsUrl(
			unoidl.com.sun.star.frame.XStorable storablecomponent, string url)
		{
			try
			{
				storablecomponent.storeAsURL(
					PathConverter(url),
					new unoidl.com.sun.star.beans.PropertyValue[] {});
			}
			catch(System.Exception ex)
			{
				throw;
			}
		}

		/// <summary>
		/// Store the document
		/// </summary>
		/// <param name="storablecomponent">The storable component</param>
		/// <param name="url">The url</param>
		public static void Store(
			unoidl.com.sun.star.frame.XStorable storablecomponent, string url)
		{
			try
			{
				storablecomponent.store();
			}
			catch(System.Exception ex)
			{
				throw;
			}
		}

		/// <summary>
		/// Convert a windows path in a OpenOffice url
		/// </summary>
		/// <param name="file">The windows path</param>
		/// <returns>The converted url</returns>
		public static string PathConverter(string file)
		{
			try
			{
				file = file.Replace(@"\", "/");

				return "file:///"+file;
			}
			catch(System.Exception ex)
			{
				throw ex;
			}
		}
	}
}

/*
 * $Log: Component.cs,v $
 * Revision 1.2  2008/04/29 15:40:04  mt
 * new copyright header
 *
 * Revision 1.1  2007/02/25 09:08:39  larsbehr
 * initial checkin, import from Sourceforge.net to OpenOffice.org
 *
 * Revision 1.1  2006/02/06 19:27:23  larsbm
 * - fixed bug in spreadsheet document
 * - added smal OpenOfficeLib for document printing
 *
 */