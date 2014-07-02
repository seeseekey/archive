/*************************************************************************
 *
 * DO NOT ALTER OR REMOVE COPYRIGHT NOTICES OR THIS FILE HEADER.
 * 
 * Copyright 2008 by Sun Microsystems, Inc.
 *
 * OpenOffice.org - a multi-platform office productivity suite
 *
 * $RCSfile: ChartBuilder.cs,v $
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
using AODL.Document .Content .Tables ;
using AODL.Document .Content .EmbedObjects ;

namespace AODL.Document.Content.Charts
{
	/// <summary>
	/// Summary description for ChartBuilder.
	/// </summary>
	public class ChartBuilder
	{
		public ChartBuilder(IDocument Document)
		{
			//this.Document = Document;
		}

		private IDocument _document;
		/// <summary>
		/// Every object (typeof(IContent)) have to know his document.
		/// </summary>
		/// <value></value>
		/*public IDocument Document
		{
			get
			{
				return this._document;
			}
			set
			{
				this._document = value;
			}
		}*/

		public static Chart CreateChart(Table table,ChartTypes type,string CellRange)
		{
			Chart chart        = new Chart (table,"ch1");
			chart.ChartType    = type.ToString ();
			chart.CreateFromCellRange (CellRange);
			return chart;
		}


		public static Chart CreateChartByAxisName(Table table,ChartTypes type,string CellRange,string AxisXName,string AxisYName)
		{
			Chart chart       = CreateChart (table,type,CellRange);
			chart.XAxisName   = AxisXName;
			chart.YAxisName   = AxisYName;
			return chart;
		}

		public static Chart CreateChartByTitle(Table table,string CellRange,ChartTypes type,string title,string xPosition,string yPosition,string xAxisname,string yAxisname)
		{
			Chart chart            = CreateChart(table,type,CellRange);
			chart.ChartTitle .SetTitle (title);
			chart.ChartTitle .SvgX = xPosition;
			chart.ChartTitle .SvgY = yPosition;
			chart.XAxisName =xAxisname;
			chart.YAxisName =yAxisname;
			return chart;
		}

		public static Chart CreateChartByAxises(Table table,string CellRange,ChartTypes type,int dimension)
		{
			Chart chart          = CreateChart(table,type,CellRange);

			if(dimension==1)
			{
				ChartAxis  Yaxis = CreateAxis(chart,"y","primary-y");
				chart.ChartPlotArea .AxisCollection .Add (Yaxis);
				Yaxis.AxesStyle .AxesProperties .DisplayLabel = "true";

			}

			else if (dimension==2)
			{
				ChartAxis  Yaxis = CreateAxis(chart,"y","primary-y");
				chart.ChartPlotArea .AxisCollection .Add (Yaxis);
				ChartAxis  Xaxis = CreateAxis(chart,"x","primary-x");
				chart.ChartPlotArea .AxisCollection .Add (Xaxis);
				Yaxis.AxesStyle .AxesProperties .DisplayLabel = "true";
				Xaxis.AxesStyle .AxesProperties .DisplayLabel = "true";
			}

			else
			{
				ChartAxis  Yaxis = CreateAxis(chart,"y","primary-y");
				chart.ChartPlotArea .AxisCollection .Add (Yaxis);
				ChartAxis  Xaxis = CreateAxis(chart,"x","primary-x");
				chart.ChartPlotArea .AxisCollection .Add (Xaxis);
				ChartAxis  Zaxis = CreateAxis(chart,"z","primary-z");
				chart.ChartPlotArea .AxisCollection .Add (Zaxis);
				Yaxis.AxesStyle .AxesProperties .DisplayLabel = "true";
				Xaxis.AxesStyle .AxesProperties .DisplayLabel = "true";
				Zaxis.AxesStyle .AxesProperties .DisplayLabel = "true";
				chart.ChartPlotArea .PlotAreaStyle.PlotAreaProperties.ThreeDimensional="true";
				
			}

			return chart;

		}

		public static ChartAxis CreateAxis(Chart chart,string Dimention, string name)
		{
			ChartAxis axis   = new ChartAxis (chart,"ch"+Dimention);
			axis.Dimension   = Dimention;
			axis.AxisName    = name;
			return    axis;
		}

		public static Chart  CreateChartByLegend(Table table,string CellRange,ChartTypes type,string legendPos,string Xpos,string Ypos,string XAxisname,string YAxisname)
		{
			Chart chart                       = CreateChart(table,type,CellRange);
			chart.ChartLegend .LegendPosition = legendPos;
			chart.ChartLegend .SvgX           = Xpos;
			chart.ChartLegend .SvgY           = Ypos;
			chart.XAxisName                   = XAxisname;
			chart.YAxisName                   = YAxisname;
			return chart;
		}

		public static Chart CreateChartByCellRange(Table table,string cellRange,ChartTypes type,string xAxisname,string yAxisname,string title,int dimension,string legendPos,string endCellAddress)
		{
			Chart chart;

			if(dimension!=0&&dimension<=3)
			{
				chart = CreateChartByAxises(table,cellRange,type,dimension);
			}
			else
			{
				chart = CreateChart(table,type,cellRange);
			}

			if(xAxisname!=null)
				chart.XAxisName = xAxisname;
			if(yAxisname!=null)
				chart.YAxisName = yAxisname;
			if(title!=null)
				chart.ChartTitle .SetTitle (title);
			if(legendPos!=null)
				chart.ChartLegend .LegendPosition = legendPos;
			else
				chart.ChartLegend .LegendPosition = "left";
            if(endCellAddress!=null)
				chart.EndCellAddress = table.TableName +"."+endCellAddress;

			return chart;
		}
			                                       
}
}