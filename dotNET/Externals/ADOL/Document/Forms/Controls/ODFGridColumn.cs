/*************************************************************************
 *
 * DO NOT ALTER OR REMOVE COPYRIGHT NOTICES OR THIS FILE HEADER.
 * 
 * Copyright 2008 by Sun Microsystems, Inc.
 *
 * OpenOffice.org - a multi-platform office productivity suite
 *
 * $RCSfile: ODFGridColumn.cs,v $
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
using AODL.Document;
using AODL.Document.Forms;
using System.Xml;
using AODL.Document.Content;

namespace AODL.Document.Forms.Controls
{
	#region ODFGridColumn class
	
	public class ODFGridColumn
	{
		protected XmlNode _node;
		protected IDocument _document;

		public XmlNode Node
		{
			get { return this._node; }
			set { this._node = value; }
		}
		/// <summary>
		/// The document
		/// </summary>
		public IDocument Document
		{
			get
			{
				return this._document;
			}
			set
			{
				this._document = value;
			}
		}
		
		
		/// <summary>
		/// Specifies the name of the column
		/// </summary>
		public string Name
		{
			get
			{
				XmlNode xn = this._node.SelectSingleNode("@form:name", 
					this.Document.NamespaceManager);
				if (xn == null) return null;
				return xn.InnerText;
			}
			set
			{
				XmlNode nd = this._node.SelectSingleNode("@form:name", 
					this.Document.NamespaceManager);
				if (nd == null)
					nd = this.Node.Attributes.Append(this.Document.CreateAttribute("name", "form"));
				nd.InnerText = value;
			}
		}

		/// <summary>
		/// Specifies the label of the column
		/// </summary>
		public string Label
		{
			get
			{
				XmlNode xn = this._node.SelectSingleNode("@form:label", 
					this.Document.NamespaceManager);
				if (xn == null) return null;
				return xn.InnerText;
			}
			set
			{
				XmlNode nd = this._node.SelectSingleNode("@form:label", 
					this.Document.NamespaceManager);
				if (nd == null)
					nd = this.Node.Attributes.Append(this.Document.CreateAttribute("label", "form"));
				nd.InnerText = value;
			}
		}

		/// <summary>
		/// Specifies the style of the column
		/// </summary>
		public string ColumnStyle
		{
			get
			{
				XmlNode xn = this._node.SelectSingleNode("@form:text-style-name", 
					this.Document.NamespaceManager);
				if (xn == null) return null;
				return xn.InnerText;
			}
			set
			{
				XmlNode nd = this._node.SelectSingleNode("@form:text-style-name", 
					this.Document.NamespaceManager);
				if (nd == null)
					nd = this.Node.Attributes.Append(this.Document.CreateAttribute("text-style-name", "form"));
				nd.InnerText = value;
			}
		}

		/// <summary>
		/// Creates an ODFGridColumn
		/// </summary>
		/// <param name="document">Main document</param>
		/// <param name="name">Column name</param>
		/// <param name="label">Column label</param>
		/// <param name="style">Column style</param>
		public ODFGridColumn(IDocument document, string name, string label, string style)
		{
			Document = document;
			Node = document.CreateNode("column", "form");
			Name = name;
			Label = label;
			ColumnStyle = style;
		}

		/// <summary>
		/// Creates an ODFGridColumn
		/// </summary>
		/// <param name="document">Main document</param>
		/// <param name="name">Column name</param>
		/// <param name="label">Column label</param>
		public ODFGridColumn(IDocument document, string name, string label)
		{
			Document = document;
			Node = document.CreateNode("column", "form");
			Name = name;
			Label = label;
		}

		/// <summary>
		/// Creates an ODFGridColumn
		/// </summary>
		/// <param name="document">Main document</param>
		public ODFGridColumn(IDocument document)
		{
			Document = document;
			Node = document.CreateNode("column", "form");
		}

		internal ODFGridColumn(IDocument document, XmlNode node)
		{
			Document = document;
			Node = node;
		}
	}
	#endregion
}
