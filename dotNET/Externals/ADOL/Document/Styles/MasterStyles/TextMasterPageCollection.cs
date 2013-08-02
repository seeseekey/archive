/*************************************************************************
 *
 * DO NOT ALTER OR REMOVE COPYRIGHT NOTICES OR THIS FILE HEADER.
 * 
 * Copyright 2008 by Sun Microsystems, Inc.
 *
 * OpenOffice.org - a multi-platform office productivity suite
 *
 * $RCSfile: TextMasterPageCollection.cs,v $
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

using System;
using System.Collections;
using AODL.Document.Collections;

namespace AODL.Document.Styles.MasterStyles
{
	/// <summary>
	/// Summary for TextMasterPageCollection.
	/// </summary>
	public class TextMasterPageCollection : CollectionWithEvents
	{
		/// <summary>
		/// Adds the specified value.
		/// </summary>
		/// <param name="value">The value.</param>
		/// <returns></returns>
		public int Add(AODL.Document.Styles.MasterStyles.TextMasterPage value)
		{
			return base.List.Add(value as object);
		}

		/// <summary>
		/// Removes the specified value.
		/// </summary>
		/// <param name="value">The value.</param>
		public void Remove(AODL.Document.Styles.MasterStyles.TextMasterPage value)
		{
			base.List.Remove(value as object);
		}

		/// <summary>
		/// Inserts the specified index.
		/// </summary>
		/// <param name="index">The index.</param>
		/// <param name="value">The value.</param>
		public void Insert(int index, AODL.Document.Styles.MasterStyles.TextMasterPage value)
		{
			base.List.Insert(index, value as object);
		}

		/// <summary>
		/// Determines whether [contains] [the specified value].
		/// </summary>
		/// <param name="value">The value.</param>
		/// <returns>
		/// 	<c>true</c> if [contains] [the specified value]; otherwise, <c>false</c>.
		/// </returns>
		public bool Contains(AODL.Document.Styles.MasterStyles.TextMasterPage value)
		{
			return base.List.Contains(value as object);
		}

		/// <summary>
		/// Gets the <see cref="TextMasterPage"/> at the specified index.
		/// </summary>
		/// <value></value>
		public AODL.Document.Styles.MasterStyles.TextMasterPage this[int index]
		{
			get { return (base.List[index] as AODL.Document.Styles.MasterStyles.TextMasterPage); }
		}

		/// <summary>
		/// Get a text master page by his style name.
		/// </summary>
		/// <returns>The TextMasterPage or null if no master page was found for this name.</returns>
		public AODL.Document.Styles.MasterStyles.TextMasterPage GetByStyleName(string styleName)
		{
			try
			{
				foreach(AODL.Document.Styles.MasterStyles.TextMasterPage txtMP in base.List)
				{
					if(txtMP.StyleName.ToLower().Equals(styleName.ToLower()))
						return txtMP;
				}
				return null;
			}
			catch(Exception)
			{
				throw;
			}
		}

		/// <summary>
		/// Gets the default master page for this text document.
		/// </summary>
		/// <returns>The default master page or null if no one was found.</returns>
		public AODL.Document.Styles.MasterStyles.TextMasterPage GetDefaultMasterPage()
		{
			try
			{
				return this.GetByStyleName("Standard");
			}
			catch(Exception)
			{
				throw;
			}
		}
	}
}
