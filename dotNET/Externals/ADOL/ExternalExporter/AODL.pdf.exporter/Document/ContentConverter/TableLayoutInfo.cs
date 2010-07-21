/*************************************************************************
 *
 * DO NOT ALTER OR REMOVE COPYRIGHT NOTICES OR THIS FILE HEADER.
 * 
 * Copyright 2008 by Sun Microsystems, Inc.
 *
 * OpenOffice.org - a multi-platform office productivity suite
 *
 * $RCSfile: TableLayoutInfo.cs,v $
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
using System.Collections;
using AODL.Document.Content.Tables;
using AODL.Document.Styles;
using AODL.Document.Styles.Properties;

namespace AODL.ExternalExporter.PDF.Document.ContentConverter
{
	/// <summary>
	/// Summar for TableLayoutInfo.
	/// </summary>
	public class TableLayoutInfo
	{
		private int _maxCells = 0;
		/// <summary>
		/// Gets the max cells.
		/// </summary>
		/// <value>The max cells.</value>
		public int MaxCells
		{
			get { return this._maxCells; }
		}

		private float[] _cellWidths;
		/// <summary>
		/// Gets the cell widths.
		/// </summary>
		/// <value>The cell widths.</value>
		public float[] CellWidths
		{
			get { return this._cellWidths; }
		}

		private double _tableWidth;
		/// <summary>
		/// Gets the width of the table.
		/// </summary>
		/// <value>The width of the table.</value>
		public double TableWidth
		{
			get { return this._tableWidth; }
		}
		
		/// <summary>
		/// Initializes a new instance of the <see cref="TableLayoutInfo"/> class.
		/// </summary>
		public TableLayoutInfo()
		{
		}

		/// <summary>
		/// Analyzes the table layout.
		/// </summary>
		/// <param name="table">The table.</param>
		public void AnalyzeTableLayout(Table table)
		{
			try
			{
				this.GetTableWidth(table);
				this._maxCells = 1;
				foreach(Row r in table.RowCollection)
				{
					if(r.CellCollection.Count > this._maxCells)
					{
						this._maxCells = r.CellCollection.Count;
					}
				}
				this.CalulateCellWidths(table.ColumnCollection);
			}
			catch(Exception)
			{
				throw;
			}
		}

		/// <summary>
		/// Calulates the cell widths.
		/// </summary>
		/// <param name="colColl">The Column collection.</param>
		private void CalulateCellWidths(ColumnCollection colColl)
		{
			try
			{
				ArrayList colWidths = new ArrayList();
				
				foreach(Column col in colColl)
				{
					if(col.Style != null
						&& col.Style is ColumnStyle
						&& ((ColumnStyle)col.Style).ColumnProperties != null)
					{
						string strColWidth = ((ColumnStyle)col.Style).ColumnProperties.Width;
						if(strColWidth != null)
						{
							double dColWidth = AODL.Document.Helper.SizeConverter.GetDoubleFromAnOfficeSizeValue(strColWidth);
							colWidths.Add(dColWidth);
							if(col.NumberColumnsRepeated != null)
							{
								int coloumsRepeated = Int32.Parse(col.NumberColumnsRepeated);
								for(int i=1; i < coloumsRepeated; i++)
								{
									colWidths.Add(dColWidth);
								}
							}
						}
					}
				}

				if(colWidths.Count == this._maxCells)
				{
					this._cellWidths = new float[this._maxCells];
					for(int ii = 0; ii < this._maxCells; ii++)
					{
						this._cellWidths[ii] = (float) ((double)colWidths[ii] / this._tableWidth);
					}
				}
			}
			catch(Exception)
			{
				throw;
			}
		}

		/// <summary>
		/// Gets the width of the table.
		/// </summary>
		/// <param name="table">The table.</param>
		private void GetTableWidth(Table table)
		{
			try
			{
				if(table.Style != null 
					&& table.Style is TableStyle
					&& ((TableStyle)table.Style).TableProperties != null)
				{
					string strWidth = ((TableStyle)table.Style).TableProperties.Width;
					if(strWidth != null)
					{
						this._tableWidth = AODL.Document.Helper.SizeConverter.GetDoubleFromAnOfficeSizeValue(strWidth);
					}
				}
			}
			catch(Exception)
			{
				throw;
			}
		}
	}
}
