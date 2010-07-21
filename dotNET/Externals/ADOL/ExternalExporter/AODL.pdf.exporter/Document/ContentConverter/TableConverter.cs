/*************************************************************************
 *
 * DO NOT ALTER OR REMOVE COPYRIGHT NOTICES OR THIS FILE HEADER.
 * 
 * Copyright 2008 by Sun Microsystems, Inc.
 *
 * OpenOffice.org - a multi-platform office productivity suite
 *
 * $RCSfile: TableConverter.cs,v $
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
using AODL.Document.Content.Tables;
using AODL.Document.Styles;
using AODL.Document.Styles.Properties;

namespace AODL.ExternalExporter.PDF.Document.ContentConverter
{
	/// <summary>
	/// Summary for TableConverter.
	/// </summary>
	public class TableConverter
	{
		/// <summary>
		/// Initializes a new instance of the <see cref="TableConverter"/> class.
		/// </summary>
		public TableConverter()
		{
		}

		/// <summary>
		/// Converts the specified table.
		/// </summary>
		/// <param name="table">The table.</param>
		/// <returns>The PDF table.</returns>
		public iTextSharp.text.pdf.PdfPTable Convert(Table table)
		{
			try
			{
				iTextSharp.text.pdf.PdfPTable pdfTable;
				TableLayoutInfo tableLayout = new TableLayoutInfo();
				tableLayout.AnalyzeTableLayout(table);

				if(tableLayout.CellWidths != null)
				{
					pdfTable = new iTextSharp.text.pdf.PdfPTable(tableLayout.CellWidths);
				}
				else
				{
					pdfTable = new iTextSharp.text.pdf.PdfPTable(tableLayout.MaxCells);
				}

				if(table.Style != null 
					&& table.Style is TableStyle 
					&& ((TableStyle)table.Style).TableProperties != null)
				{
					//((TableStyle)table.Style).TableProperties.Width
				}

				foreach(Row row in table.RowCollection)
				{
					foreach(Cell cell in row.CellCollection)
					{
						iTextSharp.text.pdf.PdfPCell pdfCell = new iTextSharp.text.pdf.PdfPCell();
						
						if(cell.ColumnRepeating != null && Int32.Parse(cell.ColumnRepeating) > 0)
						{
							pdfCell.Colspan = Int32.Parse(cell.ColumnRepeating);							
						}

						foreach(iTextSharp.text.IElement pdfElement in MixedContentConverter.GetMixedPdfContent(cell.Content))
						{
							pdfCell.AddElement(pdfElement);
						}
						pdfTable.AddCell(pdfCell);		
					}
				}
				
				//pdfTable = this.SetProperties(table, pdfTable, maxCells);

				return pdfTable;
			}
			catch(Exception)
			{
				throw;
			}
		}

		/// <summary>
		/// Converts the specified table.
		/// </summary>
		/// <param name="table">The table.</param>
		/// <param name="table">The table.</param>
		/// <returns>The PDF table with converted table properties.</returns>
		private iTextSharp.text.pdf.PdfPTable SetProperties(Table table, iTextSharp.text.pdf.PdfPTable pdfTable, int maxCells)
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
						double dWidth = AODL.Document.Helper.SizeConverter.GetDoubleFromAnOfficeSizeValue(strWidth);
						if(dWidth != 0)
						{
							if(AODL.Document.Helper.SizeConverter.IsCm(strWidth))
							{
								dWidth = AODL.ExternalExporter.PDF.Document.Helper.MeasurementHelper.CmToPoints(dWidth);
								pdfTable.LockedWidth = true;
								pdfTable.TotalWidth = (float)dWidth;
							}
							else if(AODL.Document.Helper.SizeConverter.IsInch(strWidth))
							{
								dWidth = AODL.ExternalExporter.PDF.Document.Helper.MeasurementHelper.CmToPoints(dWidth);
								pdfTable.LockedWidth = true;
								pdfTable.TotalWidth = (float)dWidth;
							}
						}
					}
					else
					{
						// assume that's a 100% table
					}
				}

				return pdfTable;
			}
			catch(Exception)
			{
				throw;
			}
		}

		/// <summary>
		/// Sets the cell properties.
		/// </summary>
		/// <param name="cell">The cell.</param>
		/// <param name="pdfCell">The PDF cell.</param>
		/// <returns>The PDF cell with converted odf cell properties.</returns>
		private iTextSharp.text.pdf.PdfPCell SetCellProperties(Cell cell, iTextSharp.text.pdf.PdfPCell pdfCell)
		{
			try
			{
				return null;

			}
			catch(Exception)
			{
				throw;
			}
		}
	}
}
