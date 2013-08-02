/*************************************************************************
 *
 * DO NOT ALTER OR REMOVE COPYRIGHT NOTICES OR THIS FILE HEADER.
 * 
 * Copyright 2008 by Sun Microsystems, Inc.
 *
 * OpenOffice.org - a multi-platform office productivity suite
 *
 * $RCSfile: ListFormPropertyElemCollection.cs,v $
 *
 * $Revision: 1.3 $
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
using AODL.Document.Collections;
using System.Xml;

namespace AODL.Document.Forms
{
	/// <summary>
	/// A typed IContent Collection.
	/// </summary>
	public class ListFormPropertyElemCollection : CollectionWithEvents
	{
		/// <summary>
		/// Adds the ListFormPropertyElem.
		/// </summary>
		/// <param name="value">The ListFormPropertyElem to be added</param>
		/// <returns></returns>
		public int Add(ListFormPropertyElement value)
		{
			return base.List.Add(value as object);
		}

		/// <summary>
		/// Removes the specified ListFormPropertyElem.
		/// </summary>
		/// <param name="value">The ListFormPropertyElem to be deleted</param>
		public void Remove(ListFormPropertyElement value)
		{
			base.List.Remove(value as object);
		}

		/// <summary>
		/// Inserts the ListFormPropertyElem at the specified index.
		/// </summary>
		/// <param name="index">The index</param>
		/// <param name="value">The ListFormPropertyElem to be inserted.</param>
		public void Insert(int index, ListFormPropertyElement value)
		{
			base.List.Insert(index, value as object);
		}

		/// <summary>
		/// Determines whether the collection contains the specified value
		/// </summary>
		public bool Contains(ListFormPropertyElement value)
		{
			return base.List.Contains(value as object);
		}

		/// <summary>
		/// Gets the ListFormPropertyElem at the specified index.
		/// </summary>
		/// <value>Index</value>
		public ListFormPropertyElement this[int index]
		{
			get { return (base.List[index] as ListFormPropertyElement); }
		}
	}
}


