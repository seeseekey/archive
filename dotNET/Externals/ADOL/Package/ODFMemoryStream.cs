/*************************************************************************
 *
 * DO NOT ALTER OR REMOVE COPYRIGHT NOTICES OR THIS FILE HEADER.
 * 
 * Copyright 2008 by Sun Microsystems, Inc.
 *
 * OpenOffice.org - a multi-platform office productivity suite
 *
 * $RCSfile: ODFMemoryStream.cs,v $
 *
 * $Revision: 1.1 $
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
using System.IO;
using ICSharpCode.SharpZipLib.Zip;

namespace AODL.Package
{
	/// <summary>
	/// Zusammenfassung für ODFMemoryStream.
	/// </summary>
	class ODFMemoryStream : IStaticDataSource
	{
		private MemoryStream _ms;

		#region IStaticDataSource Member

		/// <summary>
		/// Gets the source.
		/// </summary>
		/// <returns></returns>
		public Stream GetSource()
		{
			return _ms;
		}

		#endregion

		/// <summary>
		/// Initializes a new instance of the <see cref="ODFMemoryStream"/> class.
		/// </summary>
		/// <param name="ms">The ms.</param>
		public ODFMemoryStream(MemoryStream ms)
		{
			this._ms = ms;
		}
	}
}

/*
 * $Log: ODFMemoryStream.cs,v $
 * Revision 1.1  2008/05/07 17:20:08  larsbehr
 * - Optimized Exporter Save procedure
 * - Optimized Tests behaviour
 * - Added ODF Package Layer
 * - SharpZipLib updated to current version
 *
 */