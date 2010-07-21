/*************************************************************************
 *
 * DO NOT ALTER OR REMOVE COPYRIGHT NOTICES OR THIS FILE HEADER.
 * 
 * Copyright 2008 by Sun Microsystems, Inc.
 *
 * OpenOffice.org - a multi-platform office productivity suite
 *
 * $RCSfile: SpreadsheetBaseTest.cs,v $
 *
 * $Revision: 1.5 $
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
using System.IO;
using NUnit.Framework;
using AODL.Document.SpreadsheetDocuments;
using AODL.Document.Content.Tables;
using AODL.Document.TextDocuments;
using AODL.Document.Styles;
using AODL.Document.Content.Text;

namespace AODLTest
{
	/// <summary>
	/// SpreadsheetBase tests
	/// </summary>
	[TestFixture]
	public class SpreadsheetBaseTest
	{

		private SpreadsheetDocument _spreadsheetDocument1;
		private SpreadsheetDocument _spreadsheetDocument2;
		private SpreadsheetDocument _spreadsheetDocument3;
		private SpreadsheetDocument _spreadsheetDocument4;

		[SetUp] public void Init()
		{ 	
		}

		[TearDown] public void Dispose()
		{ 	
		}

		[Test]
		public void CreateNewSpreadsheet()
		{
			_spreadsheetDocument1		= new SpreadsheetDocument();
			_spreadsheetDocument1.New();
			Assert.IsNotNull(_spreadsheetDocument1.DocumentConfigurations2);
			Assert.IsNotNull(_spreadsheetDocument1.DocumentManifest);
			Assert.IsNotNull(_spreadsheetDocument1.DocumentPictures);
			Assert.IsNotNull(_spreadsheetDocument1.DocumentThumbnails);
			Assert.IsNotNull(_spreadsheetDocument1.DocumentSetting);
			Assert.IsNotNull(_spreadsheetDocument1.DocumentStyles);
			Assert.IsNotNull(_spreadsheetDocument1.TableCollection);
			//_spreadsheetDocument1.SaveTo(AARunMeFirstAndOnce.outPutFolder+"blank.ods");
			//Assert.IsTrue(File.Exists(AARunMeFirstAndOnce.outPutFolder+"blank.ods"));
		}

		[Test]
		public void CreateSimpleTable()
		{
			//Create new spreadsheet document
			_spreadsheetDocument2		= new SpreadsheetDocument();
			_spreadsheetDocument2.Load(AARunMeFirstAndOnce.inPutFolder+@"blank.ods");
			//Create a new table
			Table table					= new Table(_spreadsheetDocument2, "First", "tablefirst");
			table.RowCollection.Add(new Row(table));
			//Create a new cell, without any extra styles 
			Cell cell								= table.CreateCell("cell001");
			cell.OfficeValueType					= "string";
			//Set full border
			cell.CellStyle.CellProperties.Border	= Border.NormalSolid;			
			//Add a paragraph to this cell
			Paragraph paragraph						= ParagraphBuilder.CreateSpreadsheetParagraph(
				_spreadsheetDocument2);
			//Add some text content
			String cellText = "Some text";
			paragraph.TextContent.Add(new SimpleText(_spreadsheetDocument2, cellText));
			//Add paragraph to the cell
			cell.Content.Add(paragraph);
			//Insert the cell at row index 2 and column index 3
			//All need rows, columns and cells below the given
			//indexes will be build automatically.
			table.InsertCellAt(1, 1, cell);
			//Insert table into the spreadsheet document
			_spreadsheetDocument2.TableCollection.Add(table);
			// Test inserted content
			Assert.AreEqual(_spreadsheetDocument2.TableCollection[0], table);
			String text = _spreadsheetDocument2.TableCollection[0].RowCollection[1].CellCollection[1].Node.InnerText;
			Assert.AreEqual(text, cellText);
		}

		[Test]
		public void CreateTableFormatedText()
		{
			//Create new spreadsheet document
			_spreadsheetDocument3		= new SpreadsheetDocument();
			_spreadsheetDocument3.Load(AARunMeFirstAndOnce.inPutFolder+@"blank.ods");
			//Create a new table
			Table table					= new Table(_spreadsheetDocument3, "First", "tablefirst");
			table.RowCollection.Add(new Row(table));
			//Create a new cell, without any extra styles 
			Cell cell								= table.CreateCell();
			//cell.OfficeValueType					= "string";
			//Set full border
			//cell.CellStyle.CellProperties.Border	= Border.NormalSolid;			
			//Add a paragraph to this cell
			Paragraph paragraph						= ParagraphBuilder.CreateSpreadsheetParagraph(
				_spreadsheetDocument3);
			//Create some Formated text
			FormatedText fText						= new FormatedText(_spreadsheetDocument3, "T1", "Some Text");
			//fText.TextStyle.TextProperties.Bold		 = "bold";
			fText.TextStyle.TextProperties.Underline = LineStyles.dotted;
			//Add formated text
			paragraph.TextContent.Add(fText);
			//Add paragraph to the cell
			cell.Content.Add(paragraph);
			//Insert the cell at row index 2 and column index 3
			//All need rows, columns and cells below the given
			//indexes will be build automatically.
			table.InsertCellAt(2, 3, cell);
			//Insert table into the spreadsheet document
			_spreadsheetDocument3.TableCollection.Add(table);
			// Test inserted content
			Object insertedText = ((Paragraph)_spreadsheetDocument3.TableCollection[0].RowCollection[2].CellCollection[3].Content[0]).TextContent[0];
			Assert.AreEqual(fText, insertedText as FormatedText);
		}

		[Test]
		public void RowAndCellIterate() 
		{
			string file = AARunMeFirstAndOnce.inPutFolder+@"simpleCalc.ods";
			_spreadsheetDocument4 = new SpreadsheetDocument();
			_spreadsheetDocument4.Load(file);
			Assert.IsNotNull(_spreadsheetDocument4.TableCollection, "Table collection must exits.");
			Assert.IsTrue(_spreadsheetDocument4.TableCollection.Count == 3, "There must be 3 tables available.");
			int i = 0; // current row index
			int ii = 0; // current cell index
			string innerText = ""; // current inner text 
			try
			{
				Assert.IsTrue(_spreadsheetDocument4.TableCollection[0].RowCollection.Count == 6, "There must be 6 rows available.");
				for(i = 0; i < _spreadsheetDocument4.TableCollection[0].RowCollection.Count; i++) 
				{
					string contents = "Row " + i + ": ";
					Assert.IsTrue(_spreadsheetDocument4.TableCollection[0].RowCollection[i].CellCollection.Count == 3, "There must be 3 cells available.");
					for(ii = 0; ii < _spreadsheetDocument4.TableCollection[0].RowCollection[i].CellCollection.Count; ii++)
					{
						innerText = _spreadsheetDocument4.TableCollection[0].RowCollection[i].CellCollection[ii].Node.InnerText;
						if(_spreadsheetDocument4.TableCollection[0].RowCollection[i].CellCollection[ii].OfficeValue != null)
						{
							contents += _spreadsheetDocument4.TableCollection[0].RowCollection[i].CellCollection[ii].OfficeValue.ToString() + " ";
						} 
						else 
						{
							contents += innerText + " ";
						}
					}
					Console.WriteLine(contents);
				}
			}
			catch(Exception ex) 
			{
				string where = "occours in Row " + i.ToString() + " and cell " + ii.ToString() + " last cell content " + innerText + "\n\n";
				Console.WriteLine(where + ex.Message + "\n\n" + ex.StackTrace);
			}
		}
	}
}

/*
 * $Log: SpreadsheetBaseTest.cs,v $
 * Revision 1.5  2008/05/07 17:19:28  larsbehr
 * - Optimized Exporter Save procedure
 * - Optimized Tests behaviour
 * - Added ODF Package Layer
 * - SharpZipLib updated to current version
 *
 * Revision 1.4  2008/04/29 15:39:59  mt
 * new copyright header
 *
 * Revision 1.3  2007/07/15 09:29:45  yegorov
 * Issue number:
 * Submitted by:
 * Reviewed by:
 *
 * Revision 1.2  2007/04/08 16:51:09  larsbehr
 * - finished master pages and styles for text documents
 * - several bug fixes
 *
 * Revision 1.1  2007/02/25 09:01:28  larsbehr
 * initial checkin, import from Sourceforge.net to OpenOffice.org
 *
 * Revision 1.1  2006/01/29 11:26:02  larsbm
 * - Changes for the new version. 1.2. see next changelog for details
 *
 */