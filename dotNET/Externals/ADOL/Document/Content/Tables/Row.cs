/*************************************************************************
 *
 * DO NOT ALTER OR REMOVE COPYRIGHT NOTICES OR THIS FILE HEADER.
 * 
 * Copyright 2008 by Sun Microsystems, Inc.
 *
 * OpenOffice.org - a multi-platform office productivity suite
 *
 * $RCSfile: Row.cs,v $
 *
 * $Revision: 1.4 $
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
using AODL.Document.Content;
using AODL.Document.SpreadsheetDocuments;

namespace AODL.Document.Content.Tables
{
	/// <summary>
	/// Row represent a row within a table. If the row is part of a table which is
	/// used in a text document, then Cell merging is possible.
	/// </summary>
	public class Row : IContent, IHtml
	{
		/// <summary>
		/// RowChanged delegate
		/// </summary>
		public delegate void RowChanged(int rowNumber, int cellCount);
		/// <summary>
		/// Fired if the the row cellcollection was changed
		/// </summary>
		public static event RowChanged OnRowChanged;

		private Table _table;
		/// <summary>
		/// Gets or sets the node.
		/// </summary>
		/// <value>The node.</value>
		public Table Table
		{
			get { return this._table; }
			set { this._table = value; }
		}

		/// <summary>
		/// Gets or sets the row style.
		/// </summary>
		/// <value>The row style.</value>
		public RowStyle RowStyle
		{
			get { return (RowStyle)this.Style; }
			set 
			{ 
				this.StyleName	= ((RowStyle)value).StyleName;
				this.Style		= value; 
			}
		}

		private CellCollection _cellCollection;
		/// <summary>
		/// Gets or sets the cell collection.
		/// </summary>
		/// <value>The cell collection.</value>
		public CellCollection CellCollection
		{
			get { return this._cellCollection; }
			set { this._cellCollection = value; }
		}

		private CellSpanCollection _cellSpanCollection;
		/// <summary>
		/// Gets or sets the cell collection.
		/// </summary>
		/// <value>The cell collection.</value>
		public CellSpanCollection CellSpanCollection
		{
			get { return this._cellSpanCollection; }
			set { this._cellSpanCollection = value; }
		}

		/// <summary>
		/// Initializes a new instance of the <see cref="Row"/> class.
		/// </summary>
		/// <param name="document">The document.</param>
		/// <param name="node">The node.</param>
		public Row(IDocument document, XmlNode node)
		{
			this.Document					= document;
			this.Node						= node;

			this.InitStandards();
		}

		/// <summary>
		/// Initializes a new instance of the <see cref="Row"/> class.
		/// </summary>
		/// <param name="table">The table.</param>
		public Row(Table table)
		{
			this.Table						= table;
			this.Document					= table.Document;
			this.NewXmlNode(null);
			this.InitStandards();
		}

		/// <summary>
		/// Initializes a new instance of the <see cref="Row"/> class.
		/// </summary>
		/// <param name="table">The table.</param>
		/// <param name="styleName">Name of the style.</param>
		public Row(Table table, string styleName)
		{
			this.Table						= table;
			this.Document					= table.Document;
			this.NewXmlNode(styleName);
			this.RowStyle					= new RowStyle(this.Document, styleName);
			this.Document.Styles.Add(this.RowStyle);
			this.InitStandards();
		}

		/// <summary>
		/// Inits the standards.
		/// </summary>
		private void InitStandards()
		{
			this.CellCollection				= new CellCollection();
			this.CellCollection.Removed		+=new AODL.Document.Collections.CollectionWithEvents.CollectionChange(CellCollection_Removed);
			this.CellCollection.Inserted	+=new AODL.Document.Collections.CollectionWithEvents.CollectionChange(CellCollection_Inserted);

//is possible!!!! 
//			if(this.Document is AODL.Document.TextDocuments.TextDocument)
//			{
				this.CellSpanCollection				= new CellSpanCollection();
				this.CellSpanCollection.Inserted	+=new AODL.Document.Collections.CollectionWithEvents.CollectionChange(CellSpanCollection_Inserted);
				this.CellSpanCollection.Removed		+=new AODL.Document.Collections.CollectionWithEvents.CollectionChange(CellSpanCollection_Removed);
//			}
		}

		/// <summary>
		/// Inserts the cell at the given zero based position.
		/// </summary>
		/// <param name="position">The position.</param>
		/// <param name="cell">The cell.</param>
		public void InsertCellAt(int position, Cell cell)
		{
          // Phil Jollans 16-Feb-2008: Largely rewritten
          if ( _cellCollection.Count > position )
          {
            // We need to ask Lars how he intended this list to work.
            // Note that Table.Row_OnRowChanged() adds cells to all rows when 
            // we add a cell to a single row.
            _cellCollection.RemoveAt ( position ) ;
            _cellCollection.Insert ( position, cell ) ;
          }
          else
          {          
            while ( _cellCollection.Count < position  )
            {
              _cellCollection.Add ( new Cell ( this.Table ) ) ;
            }
          
            _cellCollection.Add(cell);
          }  
		}

		/// <summary>
		/// Merge cells. This is only possible if the rows table is part
		/// of a text document.
		/// </summary>
		/// <param name="document">The TextDocument this row belongs to.</param>
		/// <param name="cellStartIndex">Start index of the cell.</param>
		/// <param name="mergeCells">The count of cells to merge incl. the starting cell.</param>
		/// <param name="mergeContent">if set to <c>true</c> [merge content].</param>
		public void MergeCells(AODL.Document.TextDocuments.TextDocument document,int cellStartIndex, int mergeCells, bool mergeContent)
		{
			try
			{
				this.CellCollection[cellStartIndex].ColumnRepeating		= mergeCells.ToString();
				
				if(mergeContent)
				{
					for(int i=cellStartIndex+1; i<cellStartIndex+mergeCells; i++)
					{
						foreach(IContent content in this.CellCollection[i].Content)
							this.CellCollection[cellStartIndex].Content.Add(content);
					}
				}

				for(int i=cellStartIndex+mergeCells-1; i>cellStartIndex; i--)
				{
					this.CellCollection.RemoveAt(i);
					this.CellSpanCollection.Add(new CellSpan(this, (AODL.Document.TextDocuments.TextDocument)this.Document));
				}
			}
			catch(Exception)
			{
				throw;
			}
		}

		/// <summary>
		/// Gets the index of the cell.
		/// </summary>
		/// <param name="cell">The cell.</param>
		/// <returns>The index of the cell wthin the cell collection. If the
		/// cell isn't part of the collection -1 will be returned.</returns>
		public int GetCellIndex(Cell cell)
		{
			if(cell != null && this.CellCollection != null)
			{
				for(int i=0; i<this.CellCollection.Count; i++)
					if(this.CellCollection[i].Equals(cell))
						return i;
			}

			return -1;
		}

		/// <summary>
		/// Create a new Xml node.
		/// </summary>
		/// <param name="styleName">Name of the style.</param>
		private void NewXmlNode(string styleName)
		{
			this.Node		= this.Document.CreateNode("table-row", "table");

			if(styleName != null)
			{
				XmlAttribute xa = this.Document.CreateAttribute("style-name", "table");
				xa.Value		= styleName;
				this.Node.Attributes.Append(xa);
			}
		}

		/// <summary>
		/// Create a XmlAttribute for propertie XmlNode.
		/// </summary>
		/// <param name="name">The attribute name.</param>
		/// <param name="text">The attribute value.</param>
		/// <param name="prefix">The namespace prefix.</param>
		private void CreateAttribute(string name, string text, string prefix)
		{
			XmlAttribute xa = this.Document.CreateAttribute(name, prefix);
			xa.Value		= text;
			this.Node.Attributes.Append(xa);
		}

		/// <summary>
		/// Cells the collection_ removed.
		/// </summary>
		/// <param name="index">The index.</param>
		/// <param name="value">The value.</param>
		private void CellCollection_Removed(int index, object value)
		{
			this.Node.RemoveChild(((Cell)value).Node);
		}

		/// <summary>
		/// Cells the collection_ inserted.
		/// </summary>
		/// <param name="index">The index.</param>
		/// <param name="value">The value.</param>
		private void CellCollection_Inserted(int index, object value)
		{
			//Only Spreadsheet documents are automaticaly resized
			//not needed if the file is loaded (right order!);
			if(this.Document is SpreadsheetDocument
				&& !this.Document.IsLoadedFile)
			{
				if(this.Node.ChildNodes.Count == index)
					this.Node.AppendChild(((Cell)value).Node);
				else
				{
					XmlNode childNode		= this.Node.ChildNodes[index];
					this.Node.InsertAfter(((Cell)value).Node, childNode);
				}
				if(OnRowChanged != null)
					OnRowChanged(this.GetRowIndex(), this.CellCollection.Count);
			}
			else
				this.Node.AppendChild(((Cell)value).Node);
		}

		/// <summary>
		/// Cells the span collection_ inserted.
		/// </summary>
		/// <param name="index">The index.</param>
		/// <param name="value">The value.</param>
		private void CellSpanCollection_Inserted(int index, object value)
		{
			this.Node.AppendChild(((CellSpan)value).Node);
		}

		/// <summary>
		/// Cells the span collection_ removed.
		/// </summary>
		/// <param name="index">The index.</param>
		/// <param name="value">The value.</param>
		private void CellSpanCollection_Removed(int index, object value)
		{
			this.Node.RemoveChild(((CellSpan)value).Node);
		}

		/// <summary>
		/// Gets the index of the row.
		/// </summary>
		/// <returns>The index within the table rowcollection of this row.</returns>
		private int GetRowIndex()
		{
			for(int i=0; i < this.Table.RowCollection.Count; i++)
			{
				if(this.Table.RowCollection[i] == this)
					return i;
			}
			//Maybe this row isn't already added.
			//e.g. this is a new row which will be added
			//to the end of the collection
			return this.Table.RowCollection.Count;
		}

		#region IContent Member

		/// <summary>
		/// Gets or sets the name of the style.
		/// </summary>
		/// <value>The name of the style.</value>
		public string StyleName
		{
			get 
			{ 
				XmlNode xn = this._node.SelectSingleNode("@table:style-name",
					this.Document.NamespaceManager);
				if(xn != null)
					return xn.InnerText;
				return null;
			}
			set
			{
				XmlNode xn = this._node.SelectSingleNode("@table:style-name",
					this.Document.NamespaceManager);
				if(xn == null)
					this.CreateAttribute("style-name", value, "table");
				this._node.SelectSingleNode("@table:style-name",
					this.Document.NamespaceManager).InnerText = value;
			}
		}

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

		#region IHtml Member

		/// <summary>
		/// Return the content as Html string
		/// </summary>
		/// <returns>The html string</returns>
		public string GetHtml()
		{
			string html		= "<tr ";

			if(((RowStyle)this.Style).RowProperties != null)
				html		+= ((RowStyle)this.Style).RowProperties.GetHtmlStyle();

			html			+= ">\n";

			foreach(Cell cell in this.CellCollection)
				if(cell is IHtml)
					html	+= cell.GetHtml()+"\n";

			html			+= "</tr>";

			return html;
		}

		#endregion
	}
}

/*
 * $Log: Row.cs,v $
 * Revision 1.4  2008/04/29 15:39:46  mt
 * new copyright header
 *
 * Revision 1.3  2008/04/10 17:33:15  larsbehr
 * - Added several bug fixes mainly for the table handling which are submitted by Phil  Jollans
 *
 * Revision 1.2  2007/04/08 16:51:23  larsbehr
 * - finished master pages and styles for text documents
 * - several bug fixes
 *
 * Revision 1.1  2007/02/25 08:58:36  larsbehr
 * initial checkin, import from Sourceforge.net to OpenOffice.org
 *
 * Revision 1.3  2006/02/16 18:35:41  larsbm
 * - Add FrameBuilder class
 * - TextSequence implementation (Todo loading!)
 * - Free draing postioning via x and y coordinates
 * - Graphic will give access to it's full qualified path
 *   via the GraphicRealPath property
 * - Fixed Bug with CellSpan in Spreadsheetdocuments
 * - Fixed bug graphic of loaded files won't be deleted if they
 *   are removed from the content.
 * - Break-Before property for Paragraph properties for Page Break
 *
 * Revision 1.2  2006/01/29 18:52:14  larsbm
 * - Added support for common styles (style templates in OpenOffice)
 * - Draw TextBox import and export
 * - DrawTextBox html export
 *
 * Revision 1.1  2006/01/29 11:28:22  larsbm
 * - Changes for the new version. 1.2. see next changelog for details
 *
 */
