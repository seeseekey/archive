/*************************************************************************
 *
 * DO NOT ALTER OR REMOVE COPYRIGHT NOTICES OR THIS FILE HEADER.
 * 
 * Copyright 2008 by Sun Microsystems, Inc.
 *
 * OpenOffice.org - a multi-platform office productivity suite
 *
 * $RCSfile: TableOfContentsIndexTemplateCollection.cs,v $
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
using AODL.Document.Collections;

namespace AODL.Document.Content.Text.Indexes
{
	/// <summary>
	/// TableOfContentsIndexTemplateCollection
	/// </summary>
	public class TableOfContentsIndexTemplateCollection : CollectionWithEvents
	{
		/// <summary>
		/// Adds the specified value.
		/// </summary>
		/// <param name="value">The value.</param>
		/// <returns></returns>
		public int Add(AODL.Document.Content.Text.Indexes.TableOfContentsIndexTemplate value)
		{
			return base.List.Add(value as object);
		}

		/// <summary>
		/// Removes the specified value.
		/// </summary>
		/// <param name="value">The value.</param>
		public void Remove(AODL.Document.Content.Text.Indexes.TableOfContentsIndexTemplate value)
		{
			base.List.Remove(value as object);
		}

		/// <summary>
		/// Inserts the specified index.
		/// </summary>
		/// <param name="index">The index.</param>
		/// <param name="value">The value.</param>
		public void Insert(int index, AODL.Document.Content.Text.Indexes.TableOfContentsIndexTemplate value)
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
		public bool Contains(AODL.Document.Content.Text.Indexes.TableOfContentsIndexTemplate value)
		{
			return base.List.Contains(value as object);
		}

		/// <summary>
		/// Gets the <see cref="TableOfContentsIndexTemplate"/> at the specified index.
		/// </summary>
		/// <value></value>
		public AODL.Document.Content.Text.Indexes.TableOfContentsIndexTemplate this[int index]
		{
			get { return (base.List[index] as AODL.Document.Content.Text.Indexes.TableOfContentsIndexTemplate); }
		}
	}
}

/*
 * $Log: TableOfContentsIndexTemplateCollection.cs,v $
 * Revision 1.2  2008/04/29 15:39:47  mt
 * new copyright header
 *
 * Revision 1.1  2007/02/25 08:58:41  larsbehr
 * initial checkin, import from Sourceforge.net to OpenOffice.org
 *
 * Revision 1.1  2006/01/29 11:28:22  larsbm
 * - Changes for the new version. 1.2. see next changelog for details
 *
 * Revision 1.1  2006/01/05 10:31:10  larsbm
 * - AODL merged cells
 * - AODL toc
 * - AODC batch mode, splash screen
 *
 */