/*************************************************************************
 *
 * DO NOT ALTER OR REMOVE COPYRIGHT NOTICES OR THIS FILE HEADER.
 * 
 * Copyright 2008 by Sun Microsystems, Inc.
 *
 * OpenOffice.org - a multi-platform office productivity suite
 *
 * $RCSfile: ODFOption.cs,v $
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
	#region ODFOption class
	
	public class ODFOption
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
		/// Specifies if the option is currently selected
		/// </summary>
		public XmlBoolean CurrentSelected
		{
			get
			{
				XmlNode xn = this._node.SelectSingleNode("@form:current-selected", 
					this._document.NamespaceManager);
				if (xn == null) return XmlBoolean.NotSet;

				string s = xn.InnerText;	
				XmlBoolean at;
				switch (s)
				{
					case "true": at = XmlBoolean.True; break;
					case "false": at = XmlBoolean.False; break;
					default: at = XmlBoolean.NotSet; break;
				}
				return at;
			}
			set
			{
				string s;
				switch (value)
				{
					case XmlBoolean.True: s = "true"; break;
					case XmlBoolean.False: s = "false"; break;
					default: return;
				}
				XmlNode nd = this._node.SelectSingleNode("@form:current-selected", 
					this._document.NamespaceManager);
				if (nd == null)
					nd = this.Node.Attributes.Append(this._document.CreateAttribute("current-selected", "form"));
				nd.InnerText = s;
			}
		}

		/// <summary>
		/// Specifies the default state of a radio button or option
		/// </summary>
		public XmlBoolean Selected
		{
			get
			{
				XmlNode xn = this._node.SelectSingleNode("@form:selected", 
					this._document.NamespaceManager);
				if (xn == null) return XmlBoolean.NotSet;

				string s = xn.InnerText;	
				XmlBoolean at;
				switch (s)
				{
					case "true": at = XmlBoolean.True; break;
					case "false": at = XmlBoolean.False; break;
					default: at = XmlBoolean.NotSet; break;
				}
				return at;
			}
			set
			{
				string s;
				switch (value)
				{
					case XmlBoolean.True: s = "true"; break;
					case XmlBoolean.False: s = "false"; break;
					default: return;
				}
				XmlNode nd = this._node.SelectSingleNode("@form:selected", 
					this._document.NamespaceManager);
				if (nd == null)
					nd = this.Node.Attributes.Append(this._document.CreateAttribute("selected", "form"));
				nd.InnerText = s;
			}
		}

		/// <summary>
		/// Specifies the default value of the control
		/// </summary>
		public string Value
		{
			get
			{
				XmlNode xn = this._node.SelectSingleNode("@form:value", 
					this.Document.NamespaceManager);
				if (xn == null) return null;
				return xn.InnerText;
			}
			set
			{
				XmlNode nd = this._node.SelectSingleNode("@form:value", 
					this.Document.NamespaceManager);
				if (nd == null)
					nd = this.Node.Attributes.Append(this.Document.CreateAttribute("value", "form"));
				nd.InnerText = value;
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
		/// Creates an ODFOption
		/// </summary>
		/// <param name="document">Main document</param>
		/// <param name="label">Option label</param>
		public ODFOption(IDocument document, string label)
		{
			Document = document;
			Node = document.CreateNode("option", "form");
			Label = label;
		}

		/// <summary>
		/// Creates an ODFOption
		/// </summary>
		/// <param name="document">Main document</param>
		/// <param name="label">Option label</param>
		/// <param name="val">Option value</param>
		public ODFOption(IDocument document, string label, string val)
		{
			Document = document;
			Node = document.CreateNode("option", "form");
			Value = val;
			Label = label;
		}

		/// <summary>
		/// Creates an ODFOption
		/// </summary>
		/// <param name="document">Main document</param>
		/// <param name="label">Option label</param>
		/// <param name="val">Option value</param>
		/// <param name="currentSelected">Is it currently selected?</param>
		public ODFOption(IDocument document, string label, string val, XmlBoolean currentSelected)
		{
			Document = document;
			Node = document.CreateNode("option", "form");
			CurrentSelected = currentSelected;
			Value = val;
			Label = label;
			CurrentSelected = currentSelected;
		}

		/// <summary>
		/// Creates an ODFOption
		/// </summary>
		/// <param name="document">Main document</param>
		public ODFOption(IDocument document)
		{
			Document = document;
			Node = document.CreateNode("option", "form");
		}

		internal ODFOption(IDocument document, XmlNode node)
		{
			Document = document;
			Node = node;
		}
	}
	#endregion
}
