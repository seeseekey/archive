/*************************************************************************
 *
 * DO NOT ALTER OR REMOVE COPYRIGHT NOTICES OR THIS FILE HEADER.
 * 
 * Copyright 2008 by Sun Microsystems, Inc.
 *
 * OpenOffice.org - a multi-platform office productivity suite
 *
 * $RCSfile: Connector.cs,v $
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

namespace OpenOfficeLib.Connection
{
	/// <summary>
	/// All connection relevant methods
	/// </summary>
	public class Connector
	{
		/// <summary>
		/// Initializes a new instance of the <see cref="Connector"/> class.
		/// </summary>
		public Connector()
		{
		}

		/// <summary>
		/// Get a the Component Context using default bootstrap
		/// </summary>
		/// <returns>ComponentContext object</returns>
		public static unoidl.com.sun.star.uno.XComponentContext GetComponentContext()
		{
			try
			{
				return uno.util.Bootstrap.bootstrap();
			}
			catch(System.Exception ex)
			{
				throw;
			}
		}

		/// <summary>
		/// Get the MultiServiceFactory
		/// </summary>
		/// <param name="componentcontext">A component context</param>
		/// <returns>MultiServiceFactory object</returns>
		public static unoidl.com.sun.star.lang.XMultiServiceFactory GetMultiServiceFactory(
			unoidl.com.sun.star.uno.XComponentContext componentcontext)
		{
			try
			{
				return (unoidl.com.sun.star.lang.XMultiServiceFactory)componentcontext.getServiceManager();
			}
			catch(System.Exception ex)
			{
				throw;
			}
		}

		/// <summary>
		/// Get the Desktop
		/// </summary>
		/// <param name="multiservicefactory">A multi service factory</param>
		/// <returns>Desktop object</returns>
		public static unoidl.com.sun.star.frame.XDesktop GetDesktop(
			unoidl.com.sun.star.lang.XMultiServiceFactory multiservicefactory)
		{
			try
			{
				return (unoidl.com.sun.star.frame.XDesktop)multiservicefactory.createInstance("com.sun.star.frame.Desktop");
			}
			catch(System.Exception ex)
			{
				throw;
			}
		}
	}
}

/*
 * $Log: Connector.cs,v $
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