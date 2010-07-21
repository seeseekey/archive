/*************************************************************************
 *
 * DO NOT ALTER OR REMOVE COPYRIGHT NOTICES OR THIS FILE HEADER.
 * 
 * Copyright 2008 by Sun Microsystems, Inc.
 *
 * OpenOffice.org - a multi-platform office productivity suite
 *
 * $RCSfile: ODFItem.cs,v $
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
using AODL.Document;
using AODL.Document.Forms;
using System.Xml;
using AODL.Document.Content;

namespace AODL.Document.Forms.Controls
{
	#region ODFItem class
	
	public class ODFItem
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
		/// Contains a label for the control
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
		/// Creates an ODFItem instance
		/// </summary>
		/// <param name="document">The document it belogs to</param>
		/// <param name="label">Item label</param>
		public ODFItem(IDocument document, string label)
		{
			Document = document;
			Node = document.CreateNode("item", "form");
			Label = label;
		}
	
		/// <summary>
		/// Creates an ODFItem instance
		/// </summary>
		/// <param name="document">The document it belogs to</param>
		public ODFItem(IDocument document)
		{
			Document = document;
			Node = document.CreateNode("item", "form");
		}

		internal ODFItem(IDocument document, XmlNode node)
		{
			Document = document;
			Node = node;
		}
	}
	#endregion
}
