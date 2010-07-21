/*************************************************************************
 *
 * DO NOT ALTER OR REMOVE COPYRIGHT NOTICES OR THIS FILE HEADER.
 * 
 * Copyright 2008 by Sun Microsystems, Inc.
 *
 * OpenOffice.org - a multi-platform office productivity suite
 *
 * $RCSfile: Dr3dLight.cs,v $
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
using AODL.Document .Styles ;

namespace AODL.Document.Content.Charts
{
	/// <summary>
	/// Summary description for Dr3dLight.
	/// </summary>
	public class Dr3dLight : IContent
	{
		/// <summary>
		/// the chart which contains the dr3dlight
		/// </summary>
		private Chart _chart;

		public Chart Chart
		{
			get { return this._chart; }
			set { this._chart = value; }
		}

		/// <summary>
		/// the plotarea which contains the dr3dlight
		/// </summary>

		private ChartPlotArea _plotarea;

		public ChartPlotArea PlotArea
		{
			get { return this._plotarea; }
			set { this._plotarea = value; }
		}

		/// <summary>
		/// gets and sets the diffusecolor
		/// </summary>

		public string DiffuseColor
		{
			get 
			{ 
				XmlNode xn = this._node.SelectSingleNode("@dr3d:diffuse-color",
					this.Document.NamespaceManager);
				if(xn != null)
					return xn.InnerText;
				return null;
			}
			set
			{
				XmlNode xn = this._node.SelectSingleNode("@dr3d:diffuse-color",
					this.Document.NamespaceManager);
				if(xn == null)
					this.CreateAttribute("diffuse-color", value, "dr3d");
				this._node.SelectSingleNode("@dr3d:diffuse-color",
					this.Document.NamespaceManager).InnerText = value;
			}
		}

		/// <summary>
		/// gets and sets the direction
		/// </summary>

		public string Direction
		{
			get 
			{ 
				XmlNode xn = this._node.SelectSingleNode("@dr3d:direction",
					this.Document.NamespaceManager);
				if(xn != null)
					return xn.InnerText;
				return null;
			}
			set
			{
				XmlNode xn = this._node.SelectSingleNode("@dr3d:direction",
					this.Document.NamespaceManager);
				if(xn == null)
					this.CreateAttribute("direction", value, "dr3d");
				this._node.SelectSingleNode("@dr3d:direction",
					this.Document.NamespaceManager).InnerText = value;
			}
		}

		/// <summary>
		/// gets and sets the enabled
		/// </summary>

		public string Enabled
		{
			get 
			{ 
				XmlNode xn = this._node.SelectSingleNode("@dr3d:enabled",
					this.Document.NamespaceManager);
				if(xn != null)
					return xn.InnerText;
				return null;
			}
			set
			{
				XmlNode xn = this._node.SelectSingleNode("@dr3d:enabled",
					this.Document.NamespaceManager);
				if(xn == null)
					this.CreateAttribute("enabled", value, "dr3d");
				this._node.SelectSingleNode("@dr3d:enabled",
					this.Document.NamespaceManager).InnerText = value;
			}
		}

		/// <summary>
		/// gets and sets the specular
		/// </summary>

		public string Specular
		{
			get 
			{ 
				XmlNode xn = this._node.SelectSingleNode("@dr3d:specular",
					this.Document.NamespaceManager);
				if(xn != null)
					return xn.InnerText;
				return null;
			}
			set
			{
				XmlNode xn = this._node.SelectSingleNode("@dr3d:specular",
					this.Document.NamespaceManager);
				if(xn == null)
					this.CreateAttribute("specular", value, "dr3d");
				this._node.SelectSingleNode("@dr3d:specular",
					this.Document.NamespaceManager).InnerText = value;
			}
		}

		/// <summary>
		/// gets and sets the name of the style
		/// </summary>

		public string StyleName
		{
			get 
			{ 
				XmlNode xn = this._node.SelectSingleNode("@chart:style-name",
					this.Document.NamespaceManager);
				if(xn != null)
					return xn.InnerText;
				return null;
			}
			set
			{
				XmlNode xn = this._node.SelectSingleNode("@chart:style-name",
					this.Document.NamespaceManager);
				if(xn == null)
					this.CreateAttribute("style-name", value, "chart");
				this._node.SelectSingleNode("@chart:style-name",
					this.Document.NamespaceManager).InnerText = value;
			}
		}

		private IStyle _style;
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



		private XmlNode _node;

		public XmlNode Node
		{
			get { return  this._node;}
			set { this._node=value; }
		}

		private IDocument _document;

		public IDocument  Document
		{
			get { return  this._document;}
			set { this._document=value; }
		}


		private void NewXmlNode()
		{
			this.Node =this.Document .CreateNode ("light","dr3d");

		}

		/// <summary>
		/// the constructor of the dr3dlight
		/// </summary>
		/// <param name="chart"></param>

		public Dr3dLight(Chart chart)
		{
			this.Chart =chart;
			this.NewXmlNode ();
		}

		public Dr3dLight(IDocument document,XmlNode node)
		{
			this.Document =document;
			this.Node =node;
		}

		private void CreateAttribute(string name, string text, string prefix)
		{
			XmlAttribute xa = this.Document.CreateAttribute(name, prefix);
			xa.Value		= text;
			this.Node.Attributes.Append(xa);
		}


	}
}

