/*************************************************************************
 *
 * DO NOT ALTER OR REMOVE COPYRIGHT NOTICES OR THIS FILE HEADER.
 * 
 * Copyright 2008 by Sun Microsystems, Inc.
 *
 * OpenOffice.org - a multi-platform office productivity suite
 *
 * $RCSfile: EmbedObject.cs,v $
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
using System.Xml ;
using AODL.Document ;
using AODL.Document .Content ;
using AODL.Document.Content .Draw  ;
using AODL.Document .Styles; 

namespace AODL.Document.Content.EmbedObjects
{
	/// <summary>
	/// Summary description for EmbedObject.
	/// </summary>
	public class EmbedObject : IContent  
	{


		
		/// <summary>
		/// Gets or sets the H ref.
		/// </summary>
		/// <value>The H ref.</value>
		public string HRef
		{
			get 
			{ 
				XmlNode xn = this._parentnode.SelectSingleNode("@xlink:href",
					this.Document.NamespaceManager);
				if(xn != null)
					return xn.InnerText;
				return null;
			}
			set
			{
				XmlNode xn = this._parentnode.SelectSingleNode("@xlink:href",
					this.Document.NamespaceManager);
				if(xn == null)
					this.CreateAttribute("href", value, "xlink");
				this._node.SelectSingleNode("@xlink:href",
					this.Document.NamespaceManager).InnerText = value;
			}
		}

		/// <summary>
		/// Gets or sets the actuate.
		/// e.g. onLoad
		/// </summary>
		/// <value>The actuate.</value>
		public string Actuate
		{
			get 
			{ 
				XmlNode xn = this._parentnode.SelectSingleNode("@xlink:actuate",
					this.Document.NamespaceManager);
				if(xn != null)
					return xn.InnerText;
				return null;
			}
			set
			{
				XmlNode xn = this._parentnode.SelectSingleNode("@xlink:actuate",
					this.Document.NamespaceManager);
				if(xn == null)
					this.CreateAttribute("actuate", value, "xlink");
				this._node.SelectSingleNode("@xlink:actuate",
					this.Document.NamespaceManager).InnerText = value;
			}
		}

		/// <summary>
		/// Gets or sets the type of the Xlink.
		/// e.g. simple, standard, ..
		/// </summary>
		/// <value>The type of the X link.</value>
		public string XLinkType
		{
			get 
			{ 
				XmlNode xn = this._parentnode.SelectSingleNode("@xlink:type",
					this.Document.NamespaceManager);
				if(xn != null)
					return xn.InnerText;
				return null;
			}
			set
			{
				XmlNode xn = this._parentnode.SelectSingleNode("@xlink:type",
					this.Document.NamespaceManager);
				if(xn == null)
					this.CreateAttribute("type", value, "xlink");
				this._node.SelectSingleNode("@xlink:type",
					this.Document.NamespaceManager).InnerText = value;
			}
		}

		/// <summary>
		/// Gets or sets the show.
		/// e.g. embed
		/// </summary>
		/// <value>The show.</value>
		public string Show
		{
			get 
			{ 
				XmlNode xn = this._parentnode.SelectSingleNode("@xlink:show",
					this.Document.NamespaceManager);
				if(xn != null)
					return xn.InnerText;
				return null;
			}
			set
			{
				XmlNode xn = this._parentnode.SelectSingleNode("@xlink:show",
					this.Document.NamespaceManager);
				if(xn == null)
					this.CreateAttribute("show", value, "xlink");
				this._node.SelectSingleNode("@xlink:show",
					this.Document.NamespaceManager).InnerText = value;
			}
		}

		private string _objectrealpath;
		/// <summary>
		/// Gets or sets the embed object real path.
		/// </summary>
		/// <value>The object real path.</value>
		public string ObjectRealPath
		{
			get { return this._objectrealpath; }
			set { this._objectrealpath = value; }
		}

		private string _objectfilename;
		/// <summary>
		/// Gets or sets the name of the object file.
		/// </summary>
		/// <value>The name of the object file.</value>
		public string ObjectFileName
		{
			get { return this._objectfilename; }
			set { this._objectfilename = value; }
		}

		private Frame _frame;
		/// <summary>
		/// Gets or sets the frame.
		/// </summary>
		/// <value>The frame.</value>
		public Frame Frame
		{
			get { return this._frame; }
			set { this._frame = value; }
		}

		/// <summary>
		/// gets and sets the object name
		/// </summary>

		private string _objectname;

		public string ObjectName
		{
			get {return this._objectname ;}

			set {this._objectname =value;}
		}

		/// <summary>
		/// gets and sets the object type
		/// </summary>

		private string objecttype;

		public string ObjectType
		{
			get
			{
				return this.objecttype ;
			}

			set
			{
				this.objecttype =value;
			}
		}


		/// <summary>
		/// gets and sets the parent node 
		/// </summary>

		private XmlNode _parentnode;

		public XmlNode ParentNode
		{
			get
			{
				return this._parentnode ;
			}

			set
			{
				this._parentnode =value;
			}

		}

		#region IContent Member
		/// <summary>
		/// Gets or sets the name of the style.
		/// </summary>
		/// <value>The name of the style.</value>
		public  string StyleName
		{
			get 
			{ 
				return null;
			}
			set
			{
				
			}
		}

		protected IDocument _document;
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

		protected IStyle _style;
		/// <summary>
		/// A Style class wich is referenced with the content object.
		/// If no style is available this is null.
		/// </summary>
		/// <value></value>
		public IStyle Style
		{
			get
			{
				return this._style;
			}
			set
			{
				this.StyleName	= value.StyleName;
				this._style = value;
			}
		}

		protected XmlNode _node;
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
		
		
		protected  virtual void CreateParentNode(string objectlink)
		{

		}

		public EmbedObject(XmlNode ParentNode,IDocument document)
		{
			this.ParentNode    = ParentNode;
			this.Document      = document;
			//this.NewXmlNode ();
			
			//this.Frame         =frame;  
		}

		public EmbedObject(IDocument document)
		{
			this.Document      = document;
			this.NewXmlNode();
		}

		private void NewXmlNode()
		{
			this.ParentNode 		= this.Document.CreateNode("object", "draw");       

			XmlAttribute xa = this.Document.CreateAttribute("href", "xlink");

			xa				= this.Document.CreateAttribute("type", "xlink");
			xa.Value		= "simple"; 

			this.ParentNode.Attributes.Append(xa);

			xa				= this.Document.CreateAttribute("show", "xlink");
			xa.Value		= "embed"; 

			this.ParentNode.Attributes.Append(xa);

			xa				= this.Document.CreateAttribute("actuate", "xlink");
			xa.Value		= "onLoad"; 

			this.ParentNode.Attributes.Append(xa);
		}

		protected  virtual void CreateAttribute(string name, string text, string prefix)
		{
			XmlAttribute xa = this.Document.CreateAttribute(name, prefix);
			xa.Value		= text;
			this.ParentNode .Attributes.Append(xa);
		}


	}

}
