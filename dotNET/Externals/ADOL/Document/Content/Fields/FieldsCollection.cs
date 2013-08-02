/*************************************************************************
 *
 * DO NOT ALTER OR REMOVE COPYRIGHT NOTICES OR THIS FILE HEADER.
 * 
 * Copyright 2008 by Sun Microsystems, Inc.
 *
 * OpenOffice.org - a multi-platform office productivity suite
 *
 * $RCSfile: FieldsCollection.cs,v $
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

namespace AODL.Document.Content.Fields
{
	/// <summary>
	/// A typed IContent Collection.
	/// </summary>
	public class FieldsCollection : CollectionWithEvents
	{
		/// <summary>
		/// Adds the specified value.
		/// </summary>
		/// <param name="value">The value.</param>
		/// <returns></returns>
		public int Add(Field value)
		{
			if (value._contentCollection == null)
				throw new Exceptions.AODLException("Could not add a field directly to TextDocument.Fields." +
					"\r\nAdd the field to the content collection instead!");
			return base.List.Add(value as object);
		}

		/// <summary>
		/// Removes the specified value.
		/// </summary>
		/// <param name="value">The value.</param>
		public void Remove(Field value)
		{
			if (value != null)
			{
				if (value._contentCollection !=null)
				{
					value._contentCollection.RemoveOnlyHere(value);
					value._contentCollection = null;
				}
			}
			base.List.Remove(value as object);
		}

		/// <summary>
		/// Removes a field at the specified position.
		/// </summary>
		/// <param name="pos">position.</param>
		public void RemoveAt(int pos)
		{
			if ((base.List[pos] as Field) != null)
			{
				Field f = base.List[pos] as Field;
				if (f._contentCollection !=null)
				{
					f._contentCollection.RemoveOnlyHere(f);
					f._contentCollection = null;
				}
			}
			base.List.RemoveAt(pos);
		}

		/// <summary>
		/// Inserts the specified index.
		/// </summary>
		/// <param name="index">The index.</param>
		/// <param name="value">The value.</param>
		public void Insert(int index, Field value)
		{
			if (value._contentCollection == null)
				throw new Exceptions.AODLException("Could not add a field directly to TextDocument.Fields." +
					"\r\nAdd the field to the content collection instead!");
			base.List.Insert(index, value as object);
		}

		/// <summary>
		/// Determines whether [contains] [the specified value].
		/// </summary>
		/// <param name="value">The value.</param>
		/// <returns>
		/// 	<c>true</c> if [contains] [the specified value]; otherwise, <c>false</c>.
		/// </returns>
		public bool Contains(Field value)
		{
			return base.List.Contains(value as object);
		}

		/// <summary>
		/// Gets the <see cref="IContent"/> at the specified index.
		/// </summary>
		/// <value></value>
		public Field this[int index]
		{
			get { return (base.List[index] as Field); }
		}

		/// <summary>
		/// Looks for a specific field by its internal value
		/// </summary>
		/// <param name="val">Internal value of the field</param>
		/// <returns>The specific field if found, null otherwise</returns>
		public Field FindFieldByValue (string val)
		{
			foreach (Field f in base.List)
			{
				if (f.Value == val)
				{
					return f;
				}
			}
			return null;
		}

		protected override void OnClear() 
		{ 
			for (int i=0; i<= Count-1; i++)
			{
				Field f = base.List[i] as Field;
				if (f !=null)
				{
					if (f._contentCollection != null)
					{
						f._contentCollection.Remove(f);
					}
				}
			}
			base.OnClear();
		}		
	}
}


