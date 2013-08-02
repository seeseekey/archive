/*************************************************************************
 *
 * DO NOT ALTER OR REMOVE COPYRIGHT NOTICES OR THIS FILE HEADER.
 * 
 * Copyright 2008 by Sun Microsystems, Inc.
 *
 * OpenOffice.org - a multi-platform office productivity suite
 *
 * $RCSfile: ODFGridColumnCollection.cs,v $
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

using System.Collections;
using System.Collections;
using AODL.Document.Collections;
using System.Xml;

namespace AODL.Document.Forms.Controls
{
	/// <summary>
	/// A typed IContent Collection.
	/// </summary>
	public class ODFGridColumnCollection : CollectionWithEvents
	{
		/// <summary>
		/// Adds the specified ODFGridColumn.
		/// </summary>
		/// <param name="value">The option.</param>
		/// <returns></returns>
		public int Add(ODFGridColumn value)
		{
			return base.List.Add(value as object);
		}

		/// <summary>
		/// Removes the specified ODFGridColumn.
		/// </summary>
		/// <param name="value">The option.</param>
		public void Remove(ODFGridColumn value)
		{
			base.List.Remove(value as object);
		}

		/// <summary>
		/// Inserts the specified ODFGridColumn at the specified index.
		/// </summary>
		/// <param name="index">The index.</param>
		/// <param name="value">The option.</param>
		public void Insert(int index, ODFGridColumn value)
		{
			base.List.Insert(index, value as object);
		}

		/// <summary>
		/// Determines whether the collection contains the specifies ODFGridColumn
		/// </summary>
		/// <param name="value">The option.</param>
		public bool Contains(ODFGridColumn value)
		{
			return base.List.Contains(value as object);
		}

		/// <summary>
		/// Gets the ODFGridColumn at the specified index.
		/// </summary>
		/// <value>Index</value>
		public ODFGridColumn this[int index]
		{
			get { return (base.List[index] as ODFGridColumn); }
		}
	}
}


