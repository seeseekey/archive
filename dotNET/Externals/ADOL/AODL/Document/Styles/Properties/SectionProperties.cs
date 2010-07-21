/*************************************************************************
 *
 * DO NOT ALTER OR REMOVE COPYRIGHT NOTICES OR THIS FILE HEADER.
 * 
 * Copyright 2008 by Sun Microsystems, Inc.
 *
 * OpenOffice.org - a multi-platform office productivity suite
 *
 * $RCSfile: SectionProperties.cs,v $
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
using System.Xml;
using AODL.Document.Styles;

namespace AODL.Document.Styles.Properties
{
	/// <summary>
	/// SectionProperties represent the section properties which is e.g used
	/// within a table of contents.
	/// </summary>
	public class SectionProperties : IProperty
	{
		/// <summary>
		/// Gets or sets a value indicating whether this <see cref="SectionProperties"/> is editable.
		/// </summary>
		/// <value><c>true</c> if editable; otherwise, <c>false</c>.</value>
		public bool Editable
		{
			get 
			{ 
				XmlNode xn = this._node.SelectSingleNode("@style:editable",
					this.Style.Document.NamespaceManager);
				if(xn != null)
					return Convert.ToBoolean(xn.InnerText);
				return false;
			}
			set
			{
				XmlNode xn = this._node.SelectSingleNode("@style:editable",
					this.Style.Document.NamespaceManager);
				if(xn == null)
					this.CreateAttribute("editable", value.ToString(), "style");
				this._node.SelectSingleNode("@style:editable",
					this.Style.Document.NamespaceManager).InnerText = value.ToString();
			}
		}

		/// <summary>
		/// Initializes a new instance of the <see cref="SectionProperties"/> class.
		/// </summary>
		/// <param name="style">The style.</param>
		public SectionProperties(IStyle style)
		{
			this.Style					= style;
			this.NewXmlNode();
		}

		/// <summary>
		/// Adds the standard column style.
		/// While creating new TableOfContent objects
		/// AODL will only support a TableOfContent
		/// which use the Header styles with outlining
		/// without table columns
		/// </summary>
		public void AddStandardColumnStyle()
		{
			XmlNode standardColStyle	= this.Style.Document.CreateNode("columns", "style");

			XmlAttribute xa				= this.Style.Document.CreateAttribute("column-count", "fo");
			xa.Value					= "0";
			standardColStyle.Attributes.Append(xa);

			xa							= this.Style.Document.CreateAttribute("column-gap", "fo");
			xa.Value					= "0cm";
			standardColStyle.Attributes.Append(xa);

			this.Node.AppendChild(standardColStyle);
		}

		/// <summary>
		/// Create a new XmlNode.
		/// </summary>
		private void NewXmlNode()
		{			
			this.Node		= this.Style.Document.CreateNode("section-properties", "style");

			XmlAttribute xa = this.Style.Document.CreateAttribute("editable", "style");
			xa.Value		= "false";
			this.Node.Attributes.Append(xa);
		}

		/// <summary>
		/// Create a XmlAttribute for propertie XmlNode.
		/// </summary>
		/// <param name="name">The attribute name.</param>
		/// <param name="text">The attribute value.</param>
		/// <param name="prefix">The namespace prefix.</param>
		private void CreateAttribute(string name, string text, string prefix)
		{
			XmlAttribute xa = this.Style.Document.CreateAttribute(name, prefix);
			xa.Value		= text;
			this.Node.Attributes.Append(xa);
		}

		#region IProperty Member
		private XmlNode _node;
		/// <summary>
		/// The XmlNode which represent the property element.
		/// </summary>
		/// <value>The node</value>
		public System.Xml.XmlNode Node
		{
			get
			{
				return this._node;
			}
			set
			{
				this._node = value;
			}
		}

		private IStyle _style;
		/// <summary>
		/// The style object to which this property object belongs
		/// </summary>
		/// <value></value>
		public IStyle Style
		{
			get { return this._style; }
			set { this._style = value; }
		}
		#endregion
	}
}

/*
 * $Log: SectionProperties.cs,v $
 * Revision 1.2  2008/04/29 15:39:56  mt
 * new copyright header
 *
 * Revision 1.1  2007/02/25 08:58:55  larsbehr
 * initial checkin, import from Sourceforge.net to OpenOffice.org
 *
 * Revision 1.2  2006/02/05 20:03:32  larsbm
 * - Fixed several bugs
 * - clean up some messy code
 *
 * Revision 1.1  2006/01/29 11:28:23  larsbm
 * - Changes for the new version. 1.2. see next changelog for details
 *
 * Revision 1.1  2006/01/05 10:31:10  larsbm
 * - AODL merged cells
 * - AODL toc
 * - AODC batch mode, splash screen
 *
 */