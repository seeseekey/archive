/*************************************************************************
 *
 * DO NOT ALTER OR REMOVE COPYRIGHT NOTICES OR THIS FILE HEADER.
 * 
 * Copyright 2008 by Sun Microsystems, Inc.
 *
 * OpenOffice.org - a multi-platform office productivity suite
 *
 * $RCSfile: TableBuilder.cs,v $
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
using AODL.Document.Styles;

namespace AODL.Document.Content.Tables
{
	/// <summary>
	/// TableBuilder offer static methode to build table for different
	/// document types.
	/// </summary>
	public class TableBuilder
	{
		/// <summary>
		/// Create a spreadsheet table.
		/// </summary>
		/// <param name="document">The document.</param>
		/// <param name="tableName">Name of the table.</param>
		/// <param name="styleName">Name of the style.</param>
		/// <returns></returns>
		public static Table CreateSpreadsheetTable(AODL.Document.SpreadsheetDocuments.SpreadsheetDocument document, string tableName, string styleName)
		{
			return new Table(document, tableName, styleName);
		}
		
		/// <summary>
		/// Creates the text document table.
		/// </summary>
		/// <param name="document">The document.</param>
		/// <param name="tableName">Name of the table.</param>
		/// <param name="styleName">Name of the style.</param>
		/// <param name="rows">The rows.</param>
		/// <param name="columns">The columns.</param>
		/// <param name="width">The width.</param>
		/// <param name="useTableRowHeader">if set to <c>true</c> [use table row header].</param>
		/// <param name="useBorder">The useBorder.</param>
		/// <returns></returns>
		public static Table CreateTextDocumentTable(
			AODL.Document.TextDocuments.TextDocument document, 
			string tableName, 
			string styleName, 
			int rows, 
			int columns, 
			double width, 
			bool useTableRowHeader, 
			bool useBorder)
		{
			string tableCnt							= document.DocumentMetadata.TableCount.ToString();
			Table table								= new Table(document, tableName, styleName);
			table.TableStyle.TableProperties.Width	= width.ToString().Replace(",",".")+"cm";

			for(int i=0; i<columns; i++)
			{
				Column column						= new Column(table, "co"+tableCnt+i.ToString());
				column.ColumnStyle.ColumnProperties.Width = GetColumnCellWidth(columns, width);
				table.ColumnCollection.Add(column);
			}

			if(useTableRowHeader)
			{
				rows--;
				RowHeader rowHeader					= new RowHeader(table);
				Row row								= new Row(table, "roh1"+tableCnt);
				for(int i=0; i<columns; i++)
				{
					Cell cell						= new Cell(table, "rohce"+tableCnt+i.ToString());
					if(useBorder)
						cell.CellStyle.CellProperties.Border = Border.NormalSolid;
					row.CellCollection.Add(cell);
				}
				rowHeader.RowCollection.Add(row);
				table.RowHeader						= rowHeader;
			}

			for(int ir=0; ir<rows; ir++)
			{
				Row row								= new Row(table, "ro"+tableCnt+ir.ToString());
				
				for(int ic=0; ic<columns; ic++)
				{
					Cell cell						= new Cell(table, "ce"+tableCnt+ir.ToString()+ic.ToString());
					if(useBorder)
						cell.CellStyle.CellProperties.Border = Border.NormalSolid;
					row.CellCollection.Add(cell);
				}

				table.RowCollection.Add(row);
			}

			return table;
		}

		/// <summary>
		/// Gets the width of the column cell.
		/// </summary>
		/// <param name="columns">The columns.</param>
		/// <param name="tableWith">The table with.</param>
		/// <returns></returns>
		private static string GetColumnCellWidth(int columns, double tableWith)
		{
			double ccWidth							= (double)((tableWith/(double)columns));
			return ccWidth.ToString("F2").Replace(",",".");
		}
	}
}
