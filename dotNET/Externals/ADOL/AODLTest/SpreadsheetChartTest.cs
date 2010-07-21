/*************************************************************************
 *
 * DO NOT ALTER OR REMOVE COPYRIGHT NOTICES OR THIS FILE HEADER.
 * 
 * Copyright 2008 by Sun Microsystems, Inc.
 *
 * OpenOffice.org - a multi-platform office productivity suite
 *
 * $RCSfile: SpreadsheetChartTest.cs,v $
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
using System.Xml;
using System.IO;
using NUnit.Framework;
using AODL.Document.SpreadsheetDocuments;
using AODL.Document.Content.Tables;
using AODL.Document.TextDocuments;
using AODL.Document.Styles;
using AODL.Document.Content.Text;
using AODL.Document .Content .Charts ;
using AODL.Document .Content ;
using AODL.Document .Content .EmbedObjects ;

namespace AODLTest
{
	/// <summary>
	/// Summary description for SpreadsheetChartTest.
	/// </summary> 
	  
	// This test fixture should run in explicit since there are still some
	// buggy parts.
	[TestFixture, Explicit]
	public class SpreadsheetChartTest
	
	{
		[Test (Description="Simple test of create a chart in a spreadsheet document")]
     
		public  void CreateNewChart()
		
		{
			SpreadsheetDocument doc = new SpreadsheetDocument ();
			doc.New ();
			Table       table       = new Table (doc,"tab1","tab1");
			for(int i=1; i<=4; i++)
			{
				for(int j=1; j<=5;j++)
				{
					//string styleName = "cl"+j.ToString ();
					Cell   cell = table.CreateCell ();
					cell.OfficeValueType ="float";
					Paragraph  paragraph = new Paragraph (doc);
					int sum= j+i-1;
					string text= sum.ToString ();
					paragraph.TextContent .Add (new SimpleText ( doc,text));
					cell.Content.Add (paragraph);
					//cell.OfficeValueType ="string";
					cell.OfficeValue =text; 
					table.InsertCellAt (i,j,cell); 
				}
			}

			Chart chart=ChartBuilder.CreateChartByAxisName 
				(table,ChartTypes.bar ,"A1:E4","years","dollars");

			/*Chart chart = new Chart (table,"ch1");			
			chart.ChartType=ChartTypes.bar .ToString () ;
			chart.XAxisName ="yeer";
			chart.YAxisName ="dollar";
			chart.CreateFromCellRange ("A1:E4");
			chart.EndCellAddress ="tab1.K17";*/
			table.InsertChartAt ("G2",chart);
			doc.Content .Add (table); 
			doc.SaveTo(Path.Combine(AARunMeFirstAndOnce.outPutFolder, @"NewChartOne.ods"));
		}

		[Test]

		public void NewChartWithTitle()
		{
			SpreadsheetDocument doc = new SpreadsheetDocument ();
            doc.Load(Path.Combine(AARunMeFirstAndOnce.inPutFolder,@"testsheet.ods"));
			Table table = doc.TableCollection[0]; 
            Chart chart = ChartBuilder.CreateChartByTitle (table,"A3:E7",ChartTypes.stock,"北京红旗中文两千公司九月工资报表","0.5cm","0.5cm",null,null);
			chart.ChartTitle .TitleStyle.TextProperties .FontSize="3pt";
			chart.EndCellAddress =table.TableName +".P17";
			table.InsertChartAt ("I2",chart);
			doc.Content.Add (table);
			doc.SaveTo (Path.Combine(AARunMeFirstAndOnce.outPutFolder,"NewChartWithTitle.ods"));

		}
		[Test]

		public void NewChartWithAxises()
		{
			SpreadsheetDocument doc = new SpreadsheetDocument ();
			doc.Load(Path.Combine(AARunMeFirstAndOnce.inPutFolder,@"testsheet.ods"));
			Table table = doc.TableCollection[0];
			Chart chart = ChartBuilder.CreateChartByAxises (table,"A1:B2",ChartTypes.line ,2);
			table.InsertChartAt ("I2",chart);
			doc.Content.Add (table);
			doc.SaveTo (Path.Combine(AARunMeFirstAndOnce.outPutFolder,"NewChartWithAxis.ods"));
		}

		[Test]

		public void NewChartWithLegend()
		{
			SpreadsheetDocument doc = new SpreadsheetDocument ();
			doc.Load(Path.Combine(AARunMeFirstAndOnce.inPutFolder,@"testsheet.ods"));
			Table table = doc.TableCollection[0];
			Chart chart = ChartBuilder.CreateChartByLegend (table,"A3:F8",ChartTypes.surface ,"left","0.5","5","year","dollars");
			table.InsertChartAt ("M2",chart);
			doc.Content.Add (table);
			doc.SaveTo (Path.Combine(AARunMeFirstAndOnce.outPutFolder,"NewChartWithLegend.ods"));
		}

		[Test]

		public void NewChartWithCellRange()
		{
			SpreadsheetDocument doc = new SpreadsheetDocument ();
			doc.Load(Path.Combine(AARunMeFirstAndOnce.inPutFolder,@"testsheet.ods"));
			Table table = doc.TableCollection[0];
			Chart chart = ChartBuilder.CreateChartByCellRange (table,"A4:F8",ChartTypes.bar ,null,null,"刘玉花的测试",3,"bottom","P14");
			table.InsertChartAt ("H2",chart);
			doc.Content.Add (table);
			doc.SaveTo (Path.Combine(AARunMeFirstAndOnce.outPutFolder,"NewChartWithCellRange.ods"));

		}

		[Test]
		[Ignore("Ignore still buggy!")]
		public void LoadChart()
		{
			SpreadsheetDocument doc= new SpreadsheetDocument ();
			doc.Load(Path.Combine(AARunMeFirstAndOnce.inPutFolder,@"TestChartOne.ods"));
			IContent iContent = (EmbedObject)doc.EmbedObjects [0];
			((Chart)iContent).ChartType =ChartTypes.bar.ToString ();
			((Chart)iContent).XAxisName ="XAxis";
			((Chart)iContent).YAxisName ="YAxis";
			((Chart)iContent).SvgWidth ="20cm";
			((Chart)iContent).SvgHeight ="20cm";
			doc.SaveTo (Path.Combine(AARunMeFirstAndOnce.outPutFolder,"LoadChart.ods"));
		}

		[Test]
		[Ignore("Ignore still buggy!")]
		public void LoadChartModifyTitle()
		{
			SpreadsheetDocument doc= new SpreadsheetDocument ();
			doc.Load(Path.Combine(AARunMeFirstAndOnce.inPutFolder,@"TestChartOne.ods"));
			IContent iContent = (EmbedObject)doc.EmbedObjects [0];
            ((Chart)iContent).ChartTitle.SetTitle ("A New Title");
			((Chart)iContent).ChartTitle.SvgX ="2cm";
			((Chart)iContent).ChartTitle.SvgY ="0.5cm";
			doc.SaveTo (Path.Combine(AARunMeFirstAndOnce.outPutFolder,"TestTitle.ods"));

		}

		[Test]
		[Ignore("Ignore still buggy!")]
		public void TestLengend()
		{
			SpreadsheetDocument doc = new SpreadsheetDocument ();
			doc.Load(Path.Combine(AARunMeFirstAndOnce.inPutFolder,@"TestChartOne.ods"));
			Chart chart = (Chart)doc.EmbedObjects [0];
            chart.ChartLegend .LegendPosition ="left";
			chart.ChartLegend .SvgX ="5cm";
			chart.ChartLegend .SvgY ="2cm";
            doc.SaveTo (Path.Combine(AARunMeFirstAndOnce.outPutFolder,"TestLegend.ods"));

		}

		[Test]
		[Ignore("Ignore still buggy!")]
		public void TestPlotArea()
		{
			SpreadsheetDocument doc = new SpreadsheetDocument ();
			doc.Load(Path.Combine(AARunMeFirstAndOnce.inPutFolder,@"TestChartOne.ods"));
			Chart chart =(Chart)doc.EmbedObjects [0];
			chart.ChartPlotArea .SvgX ="1.2cm";
			chart.ChartPlotArea .SvgY ="2.5cm";
			chart.ChartPlotArea .Width ="5cm";
			chart.ChartPlotArea .Height ="5cm";
			doc.SaveTo (Path.Combine(AARunMeFirstAndOnce.outPutFolder,"TestPlotArea.ods"));
		}
	}

		
}
