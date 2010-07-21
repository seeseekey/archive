/*************************************************************************
 *
 * DO NOT ALTER OR REMOVE COPYRIGHT NOTICES OR THIS FILE HEADER.
 * 
 * Copyright 2008 by Sun Microsystems, Inc.
 *
 * OpenOffice.org - a multi-platform office productivity suite
 *
 * $RCSfile: EventListener.cs,v $
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
//using System.Collections.Generic;
using System.Xml;
using AODL.Document.Styles;
using AODL.Document.Content.Text;
using AODL.Document.Import.OpenDocument.NodeProcessors;
using AODL.Document.Content;
using AODL.Document;

namespace AODL.Document.Content.OfficeEvents
{
	/// <summary>
	/// Summary for EventListener.
	/// </summary>
	public class EventListener: IContent, ICloneable
	{
		/// <summary>
		/// Gets or sets the href. e.g http://www.sourceforge.net
		/// </summary>
		/// <value>The href.</value>
		public string Href
		{
			get
			{
				XmlNode xn = this._node.SelectSingleNode("@xlink:href",
					this.Document.NamespaceManager);
				if (xn != null)
					return xn.InnerText;
				return null;
			}
			set
			{
				XmlNode xn = this._node.SelectSingleNode("@xlink:href",
					this.Document.NamespaceManager);
				if (xn == null)
					this.CreateAttribute("href", value, "xlink");
				this._node.SelectSingleNode("@xlink:href",
					this.Document.NamespaceManager).InnerText = value;
			}
		}

		/// <summary>
		/// Gets or sets the type of the X link.
		/// </summary>
		/// <value>The type of the X link.</value>
		public string XLinkType
		{
			get
			{
				XmlNode xn = this._node.SelectSingleNode("@xlink:type",
					this.Document.NamespaceManager);
				if (xn != null)
					return xn.InnerText;
				return null;
			}
			set
			{
				XmlNode xn = this._node.SelectSingleNode("@xlink:type",
					this.Document.NamespaceManager);
				if (xn == null)
					this.CreateAttribute("type", value, "xlink");
				this._node.SelectSingleNode("@xlink:type",
					this.Document.NamespaceManager).InnerText = value;
			}
		}

		/// <summary>
		/// Gets or sets the event name ("dom:onclick").
		/// </summary>
		/// <value>The event name of the event listener.</value>
		public string EventName
		{
			get
			{
				XmlNode xn = this._node.SelectSingleNode("@script:event-name",
					this.Document.NamespaceManager);
				if (xn != null)
					return xn.InnerText;
				return null;
			}
			set
			{
				XmlNode xn = this._node.SelectSingleNode("@script:event-name",
					this.Document.NamespaceManager);
				if (xn == null)
					this.CreateAttribute("event-name", value, "script");
				this._node.SelectSingleNode("@script:event-name",
					this.Document.NamespaceManager).InnerText = value;
			}
		}
		
		/// <summary>
		/// Gets or sets the description.
		/// </summary>
		/// <value>The language of the event listener.</value>
		public string Language
		{
			get
			{
				XmlNode xn = this._node.SelectSingleNode("@script:language",
					this.Document.NamespaceManager);
				if (xn != null)
					return xn.InnerText;
				return null;
			}
			set
			{
				XmlNode xn = this._node.SelectSingleNode("@script:language",
					this.Document.NamespaceManager);
				if (xn == null)
					this.CreateAttribute("language", value, "script");
				this._node.SelectSingleNode("@script:language",
					this.Document.NamespaceManager).InnerText = value;
			}
		}

		/// <summary>
		/// Create a XmlAttribute for propertie XmlNode.
		/// </summary>
		/// <param name="name">The attribute name.</param>
		/// <param name="text">The attribute value.</param>
		/// <param name="prefix">The namespace prefix.</param>
		protected void CreateAttribute(string name, string text, string prefix)
		{
			XmlAttribute xa = this.Document.CreateAttribute(name, prefix);
			xa.Value = text;
			this.Node.Attributes.Append(xa);
		}

		/// <summary>
		/// Initializes a new instance of the <see cref="EventListener"/> class.
		/// </summary>
		/// <param name="document">The document.</param>
		/// <param name="eventname">The eventname.</param>
		/// <param name="language">The language.</param>
		/// <param name="href">The href.</param>
		public EventListener(IDocument document, 
			string eventname,
			string language,
			string href)
		{
			this.Document			= document;
			this.NewXmlNode();

			this.EventName			= eventname;
			this.Language			= language;
			this.Href				= href;
		}

		/// <summary>
		/// Initializes a new instance of the <see cref="EventListener"/> class.
		/// </summary>
		/// <param name="document">The document.</param>
		/// <param name="node">The node.</param>
		public EventListener(IDocument document, XmlNode node)
		{
			this.Document			= document;
			this.Node				= node;
		}

		/// <summary>
		/// News the XML node.
		/// </summary>
		private void NewXmlNode()
		{
			this.Node = this.Document.CreateNode("event-listener", "script");
		}

		#region IContent Member		

		private IDocument _document;
		/// <summary>
		/// Every object (typeof(IContent)) have to know his document.
		/// </summary>
		/// <value></value>
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
		/// A draw:area-rectangle doesn't have a style-name.
		/// </summary>
		/// <value>The name</value>
		public string StyleName
		{
			get
			{
				return null;
			}
			set
			{
			}
		}

		/// <summary>
		/// A draw:area-rectangle doesn't have a style.
		/// </summary>
		public IStyle Style
		{
			get
			{
				return null;
			}
			set
			{
			}
		}

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

		#endregion

//		/// <summary>
//		/// Contents the collection_ inserted.
//		/// </summary>
//		/// <param name="index">The index.</param>
//		/// <param name="value">The value.</param>
//		protected void ContentCollection_Inserted(int index, object value)
//		{
//			this.Node.AppendChild(((IContent)value).Node);
//		}

		#region IContent Member old

//		private TextDocument _document;
//		/// <summary>
//		/// The TextDocument to which this draw-area is bound.
//		/// </summary>
//		public TextDocument Document
//		{
//			get
//			{
//				return this._document;
//			}
//			set
//			{
//				this._document = value;
//			}
//		}
//
//		private XmlNode _node;
//		/// <summary>
//		/// The XmlNode.
//		/// </summary>
//		public XmlNode Node
//		{
//			get
//			{
//				return this._node;
//			}
//			set
//			{
//				this._node = value;
//			}
//		}
//
//		/// <summary>
//		/// A draw:area-rectangle doesn't have a style-name.
//		/// </summary>
//		/// <value>The name</value>
//		public string Stylename
//		{
//			get
//			{
//				return null;
//			}
//			set
//			{
//			}
//		}
//
//		/// <summary>
//		/// A draw:area-rectangle doesn't have a style.
//		/// </summary>
//		public IStyle Style
//		{
//			get
//			{
//				return null;
//			}
//			set
//			{
//			}
//		}
//
//		/// <summary>
//		/// A draw:area-rectangle doesn't contain text.
//		/// </summary>
//		public ITextCollection TextContent
//		{
//			get
//			{
//				return null;
//			}
//			set
//			{
//			}
//		}

		#endregion	

		#region ICloneable Member
		/// <summary>
		/// Create a deep clone of this EventListener object.
		/// </summary>
		/// <remarks>A possible Attached Style wouldn't be cloned!</remarks>
		/// <returns>
		/// A clone of this object.
		/// </returns>
		public object Clone()
		{
			EventListener eventListenerClone	= null;

			if(this.Document != null && this.Node != null)
			{
				MainContentProcessor mcp		= new MainContentProcessor(this.Document);
				eventListenerClone				= mcp.CreateEventListener(this.Node.CloneNode(true));
			}

			return eventListenerClone;
		}

		#endregion
	}
}
