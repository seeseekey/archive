/*************************************************************************
 *
 * DO NOT ALTER OR REMOVE COPYRIGHT NOTICES OR THIS FILE HEADER.
 * 
 * Copyright 2008 by Sun Microsystems, Inc.
 *
 * OpenOffice.org - a multi-platform office productivity suite
 *
 * $RCSfile: VariableDecl.cs,v $
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
using System.Xml;

namespace AODL.Document.Content.Fields
{

    public enum VariableValueType {Float, Percentage, Currency, Date, Time, Boolean, String, NotSet };

    public class VariableDecl
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
        /// The name of the variable
        /// </summary>
        public string Name
        {
            get
            {
                XmlNode xn = this._node.SelectSingleNode("@text:name",
                    this.Document.NamespaceManager);
                if (xn == null) return null;
                return xn.InnerText;
            }
            set
            {
                XmlNode nd = this._node.SelectSingleNode("@text:name",
                    this.Document.NamespaceManager);
                if (nd == null)
                    nd = this.Node.Attributes.Append(this.Document.CreateAttribute("name", "text"));
                nd.InnerText = value;
            }
        }

        /// <summary>
        /// Defines the type of the variable
        /// </summary>
        public VariableValueType VariableValueType
        {

            get
            {
                XmlNode xn = this._node.SelectSingleNode("@office:value-type",
                    this._document.NamespaceManager);
                if (xn == null) return VariableValueType.NotSet;

                string s = xn.InnerText;

                VariableValueType vt;
                switch (s)
                {
                    case "float": vt = VariableValueType.Float; break;
                    case "percentage": vt = VariableValueType.Percentage; break;
                    case "currency": vt = VariableValueType.Currency; break;
                    case "date": vt = VariableValueType.Date; break;
                    case "time": vt = VariableValueType.Time; break;
                    case "boolean": vt = VariableValueType.Boolean; break;
                    case "string": vt = VariableValueType.String; break;
                    default: vt = VariableValueType.String; break;
                }
                return vt;
            }
            set
            {
                string s = "";
                switch (value)
                {
                    case VariableValueType.Float: s = "float"; break;
                    case VariableValueType.Percentage: s = "percentage"; break;
                    case VariableValueType.Currency: s = "currency"; break;
                    case VariableValueType.Date: s = "date"; break;
                    case VariableValueType.Time: s = "time"; break;
                    case VariableValueType.Boolean: s = "boolean"; break;
                    case VariableValueType.String: s = "string"; break;
                }

                XmlNode nd = this._node.SelectSingleNode("@office:value-type",
                    this._document.NamespaceManager);
                if (nd == null)
                    nd = this.Node.Attributes.Append(this._document.CreateAttribute("value-type", "office"));
                nd.InnerText = s;
            }
        }

        /// <summary>
        /// Creates an VariableDecl instance
        /// </summary>
        /// <param name="document">The document it belogs to</param>
        /// <param name="valueType">Variable value type</param>
        public VariableDecl(IDocument document, VariableValueType valueType)
        {
            Document = document;
            Node = document.CreateNode("variable-decl", "text");
            VariableValueType = valueType;
        }

        /// <summary>
        /// Creates an VariableDecl instance
        /// </summary>
        /// <param name="document">The document it belogs to</param>
        /// <param name="valueType">Variable value type</param>
        /// <param name="name">Variable name</param>
        public VariableDecl(IDocument document, VariableValueType valueType, string name)
        {
            Document = document;
            Node = document.CreateNode("variable-decl", "text");
            VariableValueType = valueType;
            Name = name;
        }

        internal VariableDecl(IDocument document, XmlNode node)
        {
            Document = document;
            Node = node;
        }
    }
}
