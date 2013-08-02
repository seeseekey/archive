/*************************************************************************
 *
 * DO NOT ALTER OR REMOVE COPYRIGHT NOTICES OR THIS FILE HEADER.
 * 
 * Copyright 2008 by Sun Microsystems, Inc.
 *
 * OpenOffice.org - a multi-platform office productivity suite
 *
 * $RCSfile: FormProperties.cs,v $
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
using AODL.Document.Collections;
using AODL.Document.TextDocuments;
using AODL.Document.Forms.Controls;
using AODL.Document.Content;
using System.Xml;
using System.Collections;

namespace AODL.Document.Forms
{
	

	#region FormProperty abstract class
	public abstract class FormProperty
	{
		protected XmlNode _node;
		protected IDocument _document;

		/// <summary>
		/// The XML node representing the property
		/// </summary>
		public XmlNode Node
		{
			get { return this._node; }
			set { this._node = value; }
		}
		
		/// <summary>
		/// The document that contains the form
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
		/// Property name
		/// </summary>
		public abstract string Name
		{
			get;set;
		}

		internal abstract PropertyValueType PropertyValueType
		{
			get; set;
		}
	}
	#endregion

	#region SingleFormProperty class
	public class SingleFormProperty: FormProperty
	{
		protected object _value;

		internal override PropertyValueType PropertyValueType
		{

			get
			{
				XmlNode xn = this._node.SelectSingleNode("@office:value-type", 
					this._document.NamespaceManager);
				
				if (xn == null) return PropertyValueType.NotSet;

				string s = xn.InnerText;
				PropertyValueType vt;
				switch (s)
				{
					case "float": vt = PropertyValueType.Float; break;
					case "percentage": vt = PropertyValueType.Percentage; break;
					case "currency": vt = PropertyValueType.Currency; break;
					case "date": vt = PropertyValueType.Date; break;
					case "time": vt = PropertyValueType.Time; break;
					case "boolean": vt = PropertyValueType.Boolean; break;
					case "string": vt = PropertyValueType.String; break;
					default: vt = PropertyValueType.String; break;
				}
				return vt;
			}
			set
			{
				string s="";
				switch (value)
				{
					case PropertyValueType.Float: s = "float"; break;
					case PropertyValueType.Percentage: s = "percentage"; break;
					case PropertyValueType.Currency: s = "currency"; break;
					case PropertyValueType.Date: s = "date"; break;
					case PropertyValueType.Time: s = "time"; break;
					case PropertyValueType.Boolean: s = "boolean"; break;
					case PropertyValueType.String: s = "string"; break;
				}
				
				XmlNode nd = this._node.SelectSingleNode("@office:value-type", 
				this._document.NamespaceManager);
				if (nd == null)
					nd = this.Node.Attributes.Append(this._document.CreateAttribute("value-type", "office"));
				nd.InnerText = s;
			}
		}

		/// <summary>
		/// Property value
		/// </summary>
		public string Value
		{
			get
			{
				string s="";
				switch (PropertyValueType)
				{
					case PropertyValueType.Float: s = "value"; break;
					case PropertyValueType.Percentage: s = "value"; break;
					case PropertyValueType.Currency: s = "value"; break;
					case PropertyValueType.Date: s = "date-value"; break;
					case PropertyValueType.Time: s = "time-value"; break;
					case PropertyValueType.Boolean: s = "boolean-value"; break;
					case PropertyValueType.String: s = "string-value"; break;
				}
				XmlNode xn = this._node.SelectSingleNode("@office:"+s, 
					this._document.NamespaceManager);
				if (xn == null) return null;
				return xn.InnerText;

			}
			set
			{
				string s="";
				switch (PropertyValueType)
				{
					case PropertyValueType.Float: s = "value"; break;
					case PropertyValueType.Percentage: s = "value"; break;
					case PropertyValueType.Currency: s = "value"; break;
					case PropertyValueType.Date: s = "date-value"; break;
					case PropertyValueType.Time: s = "time-value"; break;
					case PropertyValueType.Boolean: s = "boolean-value"; break;
					case PropertyValueType.String: s = "string-value"; break;
				}

				XmlNode nd = this._node.SelectSingleNode("@office:"+s, 
				this._document.NamespaceManager);
				if (nd == null)
					nd = this.Node.Attributes.Append(this._document.CreateAttribute(s, "office"));

				nd.InnerText = value;
			}
		}

		/// <summary>
		/// Property name
		/// </summary>
		public override string Name
		{
			get
			{
				XmlNode xn = this._node.SelectSingleNode("@form:property-name", 
					this.Document.NamespaceManager);
				if (xn == null) return null;
				return xn.InnerText;
			}
			set
			{
				XmlNode nd = this._node.SelectSingleNode("@form:property-name", 
					this.Document.NamespaceManager);
				if (nd == null)
					nd = this.Node.Attributes.Append(this.Document.CreateAttribute("property-name", "form"));
				nd.InnerText = value;
			}
		}

		/// <summary>
		/// Creates the SingleFormProperty
		/// </summary>
		/// <param name="document">Document containing the form</param>
		/// <param name="PropValueType">Type of the property value</param>
		/// <param name="PropName">Property name</param>
		/// <param name="PropValue">Property value</param>
		public SingleFormProperty(IDocument document, PropertyValueType PropValueType, string PropName, string PropValue)
		{
			Document = document;
			Node = document.CreateNode("property", "form");
			PropertyValueType = PropValueType;
			Name = PropName;
			Value = PropValue;
		}

		/// <summary>
		/// Creates the SingleFormProperty
		/// </summary>
		/// <param name="document">Document containing the form</param>
		/// <param name="PropValueType">Type of the property value</param>
		public SingleFormProperty(IDocument document, PropertyValueType PropValueType)
		{
			Document = document;
			Node = document.CreateNode("property", "form");
			PropertyValueType = PropValueType;
		}

		internal SingleFormProperty(IDocument document, XmlNode node)
		{
			Document = document;
			Node = node;
		}
	}
	#endregion


	#region ListFormPropertyElem class
	public class ListFormPropertyElement
	{
		protected object _value;
		protected PropertyValueType _propertyValueType;
		
		protected XmlNode _node;
		protected IDocument _document;

		/// <summary>
		/// XML node representing the ListFormProperty element
		/// </summary>
		public XmlNode Node
		{
			get { return this._node; }
			set { this._node = value; }
		}
		
		/// <summary>
		/// Main document
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
		/// Element value
		/// </summary>
		public string Value
		{
			get
			{
				string s="";
				switch (_propertyValueType)
				{
					case PropertyValueType.Float: s = "value"; break;
					case PropertyValueType.Percentage: s = "value"; break;
					case PropertyValueType.Currency: s = "value"; break;
					case PropertyValueType.Date: s = "date-value"; break;
					case PropertyValueType.Time: s = "time-value"; break;
					case PropertyValueType.Boolean: s = "boolean-value"; break;
					case PropertyValueType.String: s = "string-value"; break;
				}
				XmlNode xn = this._node.SelectSingleNode("@office:"+s, 
					this._document.NamespaceManager);
				if (xn == null) return null;
				return xn.InnerText;

			}
			set
			{
				string s="";
				switch (_propertyValueType)
				{
					case PropertyValueType.Float: s = "value"; break;
					case PropertyValueType.Percentage: s = "value"; break;
					case PropertyValueType.Currency: s = "value"; break;
					case PropertyValueType.Date: s = "date-value"; break;
					case PropertyValueType.Time: s = "time-value"; break;
					case PropertyValueType.Boolean: s = "boolean-value"; break;
					case PropertyValueType.String: s = "string-value"; break;
				}

				XmlNode nd = this._node.SelectSingleNode("@office:"+s, 
					this._document.NamespaceManager);
				if (nd == null)
					nd = this.Node.Attributes.Append(this._document.CreateAttribute(s, "office"));

				nd.InnerText = value;
			}
		}

		/// <summary>
		/// Creates the ListFormPropertyElement
		/// </summary>
		/// <param name="property">Property containing this element</param>
		/// <param name="PropValue">Element value</param>
		public ListFormPropertyElement(ListFormProperty property, string PropValue)
		{
			Document = property.Document;
			Node = Document.CreateNode("list-value", "form");
    		_propertyValueType = property.PropertyValueType;
			Value = PropValue;
		}

		internal ListFormPropertyElement(IDocument document, XmlNode node)
		{
			Document = document;
			Node = node;
		}

		/// <summary>
		/// Creates the ListFormPropertyElement
		/// </summary>
		/// <param name="property">Property containing this element</param>
		public ListFormPropertyElement(ListFormProperty property)
		{
			Document = property.Document;
			Node = Document.CreateNode("list-value", "form");
			_propertyValueType = property.PropertyValueType;
		}
	}
	#endregion

		#region ListFormProperty class
		public class ListFormProperty: FormProperty
		{
			protected ListFormPropertyElemCollection _propertyValues;

			/// <summary>
			/// Get the list of property elements
			/// </summary>
			public ListFormPropertyElemCollection PropertyValues
			{
				get
				{
					return _propertyValues;
				}
				set
				{
					_propertyValues = value;
				}
			}
			
			internal override PropertyValueType PropertyValueType
			{

				get
				{
					XmlNode xn = this._node.SelectSingleNode("@office:value-type", 
						this._document.NamespaceManager);
					if (xn  == null) return PropertyValueType.NotSet;

					string s = xn.InnerText;
				
					PropertyValueType vt;
					switch (s)
					{
						case "float": vt = PropertyValueType.Float; break;
						case "percentage": vt = PropertyValueType.Percentage; break;
						case "currency": vt = PropertyValueType.Currency; break;
						case "date": vt = PropertyValueType.Date; break;
						case "time": vt = PropertyValueType.Time; break;
						case "boolean": vt = PropertyValueType.Boolean; break;
						case "string": vt = PropertyValueType.String; break;
						default: vt = PropertyValueType.String; break;
					}
					return vt;
				}
				set
				{
					string s="";
					switch (value)
					{
						case PropertyValueType.Float: s = "float"; break;
						case PropertyValueType.Percentage: s = "percentage"; break;
						case PropertyValueType.Currency: s = "currency"; break;
						case PropertyValueType.Date: s = "date"; break;
						case PropertyValueType.Time: s = "time"; break;
						case PropertyValueType.Boolean: s = "boolean"; break;
						case PropertyValueType.String: s = "string"; break;
					}
				
					XmlNode nd = this._node.SelectSingleNode("@office:value-type", 
						this._document.NamespaceManager);
					if (nd == null)
						nd = this.Node.Attributes.Append(this._document.CreateAttribute("value-type", "office"));
					nd.InnerText = s;
				}
			}

			/// <summary>
			/// Propert name
			/// </summary>
			public override string Name
			{
				get
				{
					XmlNode xn = this._node.SelectSingleNode("@form:property-name", 
						this.Document.NamespaceManager);
					if (xn==null) return null;
					return xn.InnerText;
				}
				set
				{
					XmlNode nd = this._node.SelectSingleNode("@form:property-name", 
						this.Document.NamespaceManager);
					if (nd == null)
						nd = this.Node.Attributes.Append(this.Document.CreateAttribute("property-name", "form"));
					nd.InnerText = value;
				}
			}


			/// <summary>
			/// Creates the ListFormProperty
			/// </summary>
			/// <param name="document">Main document</param>
			/// <param name="PropValueType">Property value type</param>
			public ListFormProperty(IDocument document, PropertyValueType PropValueType)
			{
				Document = document;
				Node = document.CreateNode("list-property", "form");
				PropertyValueType = PropValueType;

				_propertyValues = new ListFormPropertyElemCollection();
				_propertyValues.Inserted +=new ListFormPropertyElemCollection.CollectionChange(PropertyValuesCollection_Inserted);
				_propertyValues.Removed +=new ListFormPropertyElemCollection.CollectionChange(PropertyValuesCollection_Removed);
			}

			
			internal ListFormProperty(IDocument document, XmlNode node)
			{
				Document = document;
				Node = node;
				
				_propertyValues = new ListFormPropertyElemCollection();
				
				foreach (XmlNode nodeChild in node.ChildNodes)
				{
					if (nodeChild.Name == "form:list-value")
					{
						_propertyValues.Add(new ListFormPropertyElement(document, nodeChild));
					}
				}

				_propertyValues.Inserted +=new ListFormPropertyElemCollection.CollectionChange(PropertyValuesCollection_Inserted);
				_propertyValues.Removed +=new ListFormPropertyElemCollection.CollectionChange(PropertyValuesCollection_Removed);
			}

			private void PropertyValuesCollection_Inserted(int index, object value)
			{
				this.Node.AppendChild((value as ListFormPropertyElement).Node);
			}

			private void PropertyValuesCollection_Removed(int index, object value)
			{
				this.Node.RemoveChild((value as ListFormPropertyElement).Node);
			}
		}
		#endregion
}
