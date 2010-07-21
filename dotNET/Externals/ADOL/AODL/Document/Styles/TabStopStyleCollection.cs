/*************************************************************************
 *
 * DO NOT ALTER OR REMOVE COPYRIGHT NOTICES OR THIS FILE HEADER.
 * 
 * Copyright 2008 by Sun Microsystems, Inc.
 *
 * OpenOffice.org - a multi-platform office productivity suite
 *
 * $RCSfile: TabStopStyleCollection.cs,v $
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
using AODL.Document;
using AODL.Document.Collections;
using System.Xml;

namespace AODL.Document.Styles
{
	/// <summary>
	/// Represent a TabStopStyle collection which could be
	/// used within a ParagraphStyle object.
	/// Notice: A TabStopStyleCollection will not work
	/// within a Standard Paragraph!
	/// </summary>
	public class TabStopStyleCollection : CollectionWithEvents
	{
		private XmlNode _node;
		/// <summary>
		/// Gets or sets the node.
		/// </summary>
		/// <value>The node.</value>
		public XmlNode Node
		{
			get { return this._node; }
			set { this._node = value; }
		}

		private IDocument _document;
		/// <summary>
		/// Gets or sets the document.
		/// </summary>
		/// <value>The document.</value>
		public IDocument Document
		{
			get { return this._document; }
			set { this._document = value; }
		}

		/// <summary>
		/// Initializes a new instance of the <see cref="TabStopStyleCollection"/> class.
		/// </summary>
		/// <param name="document">The document.</param>
		public TabStopStyleCollection(IDocument document)
		{
			this.Document		= document;
			this.Node			= this.Document.CreateNode("tab-stops", "style");
		}

		/// <summary>
		/// Adds the specified value.
		/// </summary>
		/// <param name="value">The value.</param>
		/// <returns></returns>
		public int Add(AODL.Document.Styles.TabStopStyle value)
		{
			this.Node.AppendChild(((TabStopStyle)value).Node);
			return base.List.Add(value as object);
		}

		/// <summary>
		/// Removes the specified value.
		/// </summary>
		/// <param name="value">The value.</param>
		public void Remove(AODL.Document.Styles.TabStopStyle value)
		{
			this.Node.RemoveChild(((TabStopStyle)value).Node);
			base.List.Remove(value as object);
		}

		/// <summary>
		/// Inserts the specified index.
		/// </summary>
		/// <param name="index">The index.</param>
		/// <param name="value">The value.</param>
		public void Insert(int index, AODL.Document.Styles.TabStopStyle value)
		{
			//It's not necessary to know the postion of the child node
			this.Node.AppendChild(((TabStopStyle)value).Node);
			base.List.Insert(index, value as object);
		}

		/// <summary>
		/// Determines whether [contains] [the specified value].
		/// </summary>
		/// <param name="value">The value.</param>
		/// <returns>
		/// 	<c>true</c> if [contains] [the specified value]; otherwise, <c>false</c>.
		/// </returns>
		public bool Contains(AODL.Document.Styles.TabStopStyle value)
		{
			return base.List.Contains(value as object);
		}

		/// <summary>
		/// Gets the <see cref="TabStopStyle"/> at the specified index.
		/// </summary>
		/// <value></value>
		public AODL.Document.Styles.TabStopStyle this[int index]
		{
			get { return (base.List[index] as AODL.Document.Styles.TabStopStyle); }
		}
	}
}

/*
 * $Log: TabStopStyleCollection.cs,v $
 * Revision 1.2  2008/04/29 15:39:54  mt
 * new copyright header
 *
 * Revision 1.1  2007/02/25 08:58:50  larsbehr
 * initial checkin, import from Sourceforge.net to OpenOffice.org
 *
 * Revision 1.1  2006/01/29 11:28:23  larsbm
 * - Changes for the new version. 1.2. see next changelog for details
 *
 * Revision 1.1  2005/11/20 17:31:20  larsbm
 * - added suport for XLinks, TabStopStyles
 * - First experimental of loading dcuments
 * - load and save via importer and exporter interfaces
 *
 */