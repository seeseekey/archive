/*************************************************************************
 *
 * DO NOT ALTER OR REMOVE COPYRIGHT NOTICES OR THIS FILE HEADER.
 * 
 * Copyright 2008 by Sun Microsystems, Inc.
 *
 * OpenOffice.org - a multi-platform office productivity suite
 *
 * $RCSfile: ODFFixedText.cs,v $
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
	public class ODFFixedText: ODFFormControl
	{
		public override string Type
		{
			get
			{
				return "fixed-text";
			}
		}


		/// <summary>
		/// Specifies whether or not a control can accept user input
		/// </summary>
		public XmlBoolean Disabled
		{
			get
			{
				XmlNode xn = this._node.SelectSingleNode("@form:disabled", 
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
				XmlNode nd = this._node.SelectSingleNode("@form:disabled", 
					this._document.NamespaceManager);
				if (nd == null)
					nd = this.Node.Attributes.Append(this._document.CreateAttribute("disabled", "form"));
				nd.InnerText = s;
			}
		}

		/// <summary>
		/// Specifies the IDs of the controls with which control element is labeling
		/// </summary>
		public string For
		{
			get
			{
				XmlNode xn = this._node.SelectSingleNode("@form:for", 
					this._document.NamespaceManager);
				if (xn == null) return null;
				return xn.InnerText;
			}
			set
			{
				XmlNode nd = this._node.SelectSingleNode("@form:for", 
					this._document.NamespaceManager);
				if (nd == null)
					nd = this.Node.Attributes.Append(this._document.CreateAttribute("for", "form"));
				nd.InnerText = value;
			}
		}
		
		/// <summary>
		/// Contains additional information about a control.
		/// </summary>
		public string Title
		{
			get
			{
				XmlNode xn = this._node.SelectSingleNode("@form:title", 
					this._document.NamespaceManager);
				if (xn == null) return null;
				return xn.InnerText;
			}
			set
			{
				XmlNode nd = this._node.SelectSingleNode("@form:title", 
					this._document.NamespaceManager);
				if (nd == null)
					nd = this.Node.Attributes.Append(this._document.CreateAttribute("title", "form"));
				nd.InnerText = value;
			}
		}

		/// <summary>
		/// Specifies whether or not a control is printed when a user prints 
		/// the document in which the control is contained
		/// </summary>
		public XmlBoolean Printable
		{
			get
			{
				XmlNode xn = this._node.SelectSingleNode("@form:printable", 
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
				XmlNode nd = this._node.SelectSingleNode("@form:printable", 
					this._document.NamespaceManager);
				if (nd == null)
					nd = this.Node.Attributes.Append(this._document.CreateAttribute("printable", "form"));
				nd.InnerText = s;
			}
		}

		/// <summary>
		/// Specifies whether or not the label is displayed on multiple lines
		/// </summary>
		public XmlBoolean MultiLine
		{
			get
			{
				XmlNode xn = this._node.SelectSingleNode("@form:multi-line", 
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
				XmlNode nd = this._node.SelectSingleNode("@form:multi-line", 
					this._document.NamespaceManager);
				if (nd == null)
					nd = this.Node.Attributes.Append(this._document.CreateAttribute("multi-line", "form"));
				nd.InnerText = s;
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
					this._document.NamespaceManager);
				if (xn == null) return null;
				return xn.InnerText;
			}
			set
			{
				XmlNode nd = this._node.SelectSingleNode("@form:label", 
					this._document.NamespaceManager);
				if (nd == null)
					nd = this.Node.Attributes.Append(this._document.CreateAttribute("label", "form"));
				nd.InnerText = value;
			}
		}

		/// <summary>
		/// Creates an ODFFixedText
		/// </summary>
		/// <param name="ParentForm">Parent form that the control belongs to</param>
		/// <param name="contentCollection">Collection of content where the control will be referenced</param>
		/// <param name="id">Control ID. Please specify a unique ID!</param>
		public ODFFixedText(ODFForm ParentForm, IContentCollection contentCollection, string id): base (ParentForm, contentCollection, id)
		{}

		/// <summary>
		/// Creates an ODFFixedText
		/// </summary>
		/// <param name="ParentForm">Parent form that the control belongs to</param>
		/// <param name="contentCollection">Collection of content where the control will be referenced</param>
		/// <param name="id">Control ID. Please specify a unique ID!</param>
		/// <param name="x">X coordinate of the control in ODF format (eg. "1cm", "15mm", 3.2cm" etc)</param>
		/// <param name="y">Y coordinate of the control in ODF format (eg. "1cm", "15mm", 3.2cm" etc)</param>
		/// <param name="width">Width of the control in ODF format (eg. "1cm", "15mm", 3.2cm" etc)</param>
		/// <param name="height">Height of the control in ODF format (eg. "1cm", "15mm", 3.2cm" etc)</param>
		public ODFFixedText(ODFForm ParentForm, IContentCollection contentCollection, string id, string x, string y, string width, string height): base (ParentForm, contentCollection, id, x, y, width, height)
		{}

		internal ODFFixedText(ODFForm ParentForm, XmlNode node): base(ParentForm, node)
		{}

		protected override void CreateBasicNode()
		{
			XmlNode xe = this._document.CreateNode("fixed-text", "form");
			Node.AppendChild(xe);
			Node = xe;
			this.ControlImplementation = "ooo:com.sun.star.form.component.FixedText";
		}
	}
}
