/*************************************************************************
 *
 * DO NOT ALTER OR REMOVE COPYRIGHT NOTICES OR THIS FILE HEADER.
 * 
 * Copyright 2008 by Sun Microsystems, Inc.
 *
 * OpenOffice.org - a multi-platform office productivity suite
 *
 * $RCSfile: IContentCollection.cs,v $
 *
 * $Revision: 1.5 $
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
using AODL.Document.Content.Fields;
using AODL.Document.TextDocuments;

namespace AODL.Document.Content
{
	/// <summary>
	/// A typed IContent Collection.
	/// </summary>
	public class IContentCollection : CollectionWithEvents
	{
		/// <summary>
		/// Adds the specified value.
		/// </summary>
		/// <param name="value">The value.</param>
		/// <returns></returns>
		public int Add(AODL.Document.Content.IContent value)
		{
			if (value is Field)
			{
				Field f = value as Field;
				if (f != null)
				{
					if (f.Document is TextDocument)
					{
						TextDocument td = f.Document as TextDocument;
						f._contentCollection = this;
						td.Fields.Add(f);
					}
				}
			}
			return base.List.Add(value as object);
		}

		/// <summary>
		/// Removes the specified value.
		/// </summary>
		/// <param name="value">The value.</param>
		public void Remove(AODL.Document.Content.IContent value)
		{
			if (value is Field)
			{
				Field f = value as Field;
				if (f != null)
				{
					if (f.Document is TextDocument)
					{
						TextDocument td = f.Document as TextDocument;
                        f._contentCollection = null;
						td.Fields.Remove(f);
					}
				}
			}
            base.List.Remove(value as object);
		}

		/// <summary>
		/// Removes an element at the specified position.
		/// </summary>
		/// <param name="pos">position.</param>
		public void RemoveAt(int pos)
		{
			if (this.List[pos] is Field)
			{
				Field f = this.List[pos] as Field;
				if (f != null)
				{
					if (f.Document is TextDocument)
					{
						TextDocument td = f.Document as TextDocument;
						f._contentCollection = null;
						td.Fields.Remove(f);
					}
				}
			}
			base.List.RemoveAt(pos);
		}

		/// <summary>
		/// Removes the specified value.
		/// </summary>
		/// <param name="value">The value.</param>
		internal void RemoveOnlyHere(AODL.Document.Content.IContent value)
		{
			base.List.Remove(value as object);
		}

		/// <summary>
		/// Inserts the specified index.
		/// </summary>
		/// <param name="index">The index.</param>
		/// <param name="value">The value.</param>
		public void Insert(int index, AODL.Document.Content.IContent value)
		{
			if (value is Field)
			{
				Field f = value as Field;
				if (f != null)
				{
					if (f.Document is TextDocument)
					{
						TextDocument td = f.Document as TextDocument;
						f._contentCollection = this;
						td.Fields.Add(f);
					}
				}
			}
			base.List.Insert(index, value as object);
		}

		protected override void OnClear() 
		{ 
			for (int i=0; i< base.Count; i++)
			{
				IContent c = (IContent)base.List[i];
				if (c is Field)
				{
					Field f = c as Field;
					if (f != null)
					{
						if (f.Document is TextDocument)
						{
							TextDocument td = f.Document as TextDocument;
							td.Fields.Remove(f);
						}
					}
				}
			}

			base.OnClear();
		}	

		/// <summary>
		/// Determines whether [contains] [the specified value].
		/// </summary>
		/// <param name="value">The value.</param>
		/// <returns>
		/// 	<c>true</c> if [contains] [the specified value]; otherwise, <c>false</c>.
		/// </returns>
		public bool Contains(AODL.Document.Content.IContent value)
		{
			return base.List.Contains(value as object);
		}

		/// <summary>
		/// Gets the <see cref="IContent"/> at the specified index.
		/// </summary>
		/// <value></value>
		public AODL.Document.Content.IContent this[int index]
		{
			get { return (base.List[index] as AODL.Document.Content.IContent); }
		}
	}
}

/*
 * $Log: IContentCollection.cs,v $
 * Revision 1.5  2008/04/29 15:39:43  mt
 * new copyright header
 *
 * Revision 1.4  2007/07/15 09:29:55  yegorov
 * Issue number:
 * Submitted by:
 * Reviewed by:
 *
 * Revision 1.2  2007/04/08 16:51:22  larsbehr
 * - finished master pages and styles for text documents
 * - several bug fixes
 *
 * Revision 1.1  2007/02/25 08:58:33  larsbehr
 * initial checkin, import from Sourceforge.net to OpenOffice.org
 *
 * Revision 1.1  2006/01/29 11:29:46  larsbm
 * *** empty log message ***
 *
 * Revision 1.3  2005/11/20 17:31:20  larsbm
 * - added suport for XLinks, TabStopStyles
 * - First experimental of loading dcuments
 * - load and save via importer and exporter interfaces
 *
 * Revision 1.2  2005/10/08 08:19:25  larsbm
 * - added cvs tags
 *
 */