/*************************************************************************
 *
 * DO NOT ALTER OR REMOVE COPYRIGHT NOTICES OR THIS FILE HEADER.
 * 
 * Copyright 2008 by Sun Microsystems, Inc.
 *
 * OpenOffice.org - a multi-platform office productivity suite
 *
 * $RCSfile: Field.cs,v $
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
using System.Collections;
using System.Text;
using AODL.Document.Content;
using AODL.Document;
using System.Xml;
using AODL.Document.Forms;
using AODL.Document.Styles;
using AODL.Document.Helper;
using AODL.Document.Content;

namespace AODL.Document.Content.Fields
{
	/// <summary>
	/// A base abstract class for all the fields
	/// </summary>
	public abstract class Field: IContent
	{
		protected IDocument _document;
		protected XmlNode _node;
		internal IContentCollection _contentCollection;
		#region IContent Members

		public IDocument Document
		{
			get
			{
				return _document;
			}
			set
			{
				_document = value;
			}
		}

		public System.Xml.XmlNode Node
		{
			get
			{
				return _node;
			}
			set
			{
				_node = value;
			}
		}

		/// <summary>
		/// The stylename wihich is referenced with the content object.
		/// If no style is available this is null.
		/// </summary>
		public string StyleName
		{
			get
			{
				XmlNode xn = this._node.SelectSingleNode("@draw:style-name",
					this.Document.NamespaceManager);
				if (xn == null) return null;
				return xn.InnerText;
			}
			set
			{
				XmlNode nd = this._node.SelectSingleNode("@draw:style-name",
					this.Document.NamespaceManager);
				if (nd == null)
					nd = this.Node.Attributes.Append(this.Document.CreateAttribute("style-name", "draw"));
				nd.InnerText = value;
			}
		}

		/// <summary>
		/// A Style class wich is referenced with the content object.
		/// If no style is available this is null.
		/// </summary>
		public IStyle Style
		{
			get
			{
				return this._document.Styles.GetStyleByName(StyleName);
			}
			set
			{
				StyleName = value.StyleName;
			}
		}

		#endregion

		/// <summary>
		/// The inner content of the field
		/// </summary>
		public string Value
		{
			get
			{
				return _node.InnerText;
			}
			set
			{
				_node.InnerText = value;
			}
		}

        public Field()
		{
		}
	}
}
