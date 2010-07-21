/*************************************************************************
 *
 * DO NOT ALTER OR REMOVE COPYRIGHT NOTICES OR THIS FILE HEADER.
 * 
 * Copyright 2008 by Sun Microsystems, Inc.
 *
 * OpenOffice.org - a multi-platform office productivity suite
 *
 * $RCSfile: Placeholder.cs,v $
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
using System.Text;
using AODL.Document.Content;
using AODL.Document;
using System.Xml;
using AODL.Document.Forms;
using AODL.Document.Styles;
using AODL.Document.Helper;

namespace AODL.Document.Content.Fields
{
    public enum PlaceholderType { Text, Table, TextBox, Image, Object, NotSet };

    public class Placeholder : Field
    {
        public Placeholder(IDocument document, PlaceholderType placeholderType)
        {
            _document = document;
            _node = document.CreateNode("placeholder", "text");
            PlaceholderType = placeholderType;
        }

        public Placeholder(IDocument document, PlaceholderType placeholderType, string description)
        {
            _document = document;
            _node = document.CreateNode("placeholder", "text");
            PlaceholderType = placeholderType;
            Description = description;
        }

        internal Placeholder(IDocument document, XmlNode node)
        {
            _document = document;
            _node = node;
        }

        /// <summary>
        /// This attribute is mandatory and it indicates which type of text content the placeholder represents
        /// </summary>
        public PlaceholderType PlaceholderType
        {
            get
            {
                XmlNode xn = this._node.SelectSingleNode("@text:placeholder-type",
                    this._document.NamespaceManager);
                if (xn == null) return PlaceholderType.NotSet;
                string s = xn.InnerText;
                PlaceholderType at;
                switch (s)
                {
                    case "text": at = PlaceholderType.Text; break;
                    case "table": at = PlaceholderType.Table; break;
                    case "text-box": at = PlaceholderType.TextBox; break;
                    case "image": at = PlaceholderType.Image; break;
                    case "object": at = PlaceholderType.Object; break;
                    default: at = PlaceholderType.NotSet; break;
                }
                return at;
            }
            set
            {
                string s;
                switch (value)
                {
                    case PlaceholderType.Text: s = "text"; break;
                    case PlaceholderType.Table: s = "table"; break;
                    case PlaceholderType.TextBox: s = "text-box"; break;
                    case PlaceholderType.Image: s = "image"; break;
                    case PlaceholderType.Object: s = "object"; break;
                    default: return; break;
                }
                XmlNode nd = this._node.SelectSingleNode("@text:placeholder-type",
                    this._document.NamespaceManager);
                if (nd == null)
                    nd = this._node.Attributes.Append(this._document.CreateAttribute("placeholder-type", "text"));
                nd.InnerText = s;
            }
        }

        /// <summary>
        /// Provides additional description for the placeholder
        /// </summary>
        public string Description
        {
            get
            {
                XmlNode xn = this._node.SelectSingleNode("@text:description",
                    this._document.NamespaceManager);
                if (xn == null) return null;
                return xn.InnerText;
            }
            set
            {
                XmlNode nd = this._node.SelectSingleNode("@text:description",
                    this._document.NamespaceManager);
                if (nd == null)
                    nd = this.Node.Attributes.Append(this._document.CreateAttribute("description", "text"));
                nd.InnerText = value;
            }
        }

    }
}
