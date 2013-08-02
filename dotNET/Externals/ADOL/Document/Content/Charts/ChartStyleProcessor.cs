/*************************************************************************
 *
 * DO NOT ALTER OR REMOVE COPYRIGHT NOTICES OR THIS FILE HEADER.
 * 
 * Copyright 2008 by Sun Microsystems, Inc.
 *
 * OpenOffice.org - a multi-platform office productivity suite
 *
 * $RCSfile: ChartStyleProcessor.cs,v $
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
using AODL.Document .Styles .Properties ;

namespace AODL.Document.Content.Charts
{
	/// <summary>
	/// Summary description for ChartStyleProcessor.
	/// </summary>
	public class ChartStyleProcessor
	{
		public static string AutomaticStylePath = "/office:document-content/office:automatic-styles";

		/// <summary>
		/// the chart which processor deal with
		/// </summary>
		private Chart _chart;

		public Chart Chart
		{
			get
			{
				return this._chart;
			}

			set
			{
				this._chart =value;

			}
		}
		
		/// <summary>
		/// the constructor of the chartStyleProcesser
		/// </summary>
		/// <param name="chart"></param>

		public ChartStyleProcessor(Chart chart)
		{
			this.Chart =chart;
			
		}

		/// <summary>
		/// read the styles of the chart
		/// </summary>
		/// <param name="node"></param>
		/// <param name="styleType"></param>
		/// <returns></returns>


		public IStyle ReadStyle(XmlNode node,string styleType)
		{
			switch(styleType)
			{
				case "chart":
					return CreateChartStyle(node.CloneNode (true));
					break;

				case "title":
					return CreateChartTitleStyle(node.CloneNode (true));
					break;

				case "legend":
					return CreateChartLegendStyle(node.CloneNode (true));
					break;

				case"plotarea":
					return CreateChartPlotAreaStyle(node.CloneNode (true));
					break;
				
				case"axes":
					return CreateChartAxesStyle(node.CloneNode (true));
					break;
				case"series":
					return CreateChartSeriesStyle(node.CloneNode (true));
					break;
				case"wall":
					return CreateChartWallStyle(node.CloneNode (true));
					break;
				case"floor":
					return CreateChartFloorStyle(node.CloneNode (true));
					break;
				case "dr3d":
					//return CreateChartDr3dLightStyle(node.CloneNode (true));

				default:
					return null;



			}



		}

		/// <summary>
		/// read the style node 
		/// </summary>
		/// <param name="styleName"></param>
		/// <returns></returns>

		public XmlNode ReadStyleNode(string styleName)
		{
			XmlNode automaticStyleNode            = null;

			automaticStyleNode                    = this.Chart.ChartDoc .SelectSingleNode (AutomaticStylePath,this.Chart .Document .NamespaceManager );

			if(automaticStyleNode!=null)
			{

				foreach(XmlNode nodeChild in automaticStyleNode.ChildNodes )
				{
					XmlNode family                = nodeChild.SelectSingleNode ("@style:family",this.Chart .Document .NamespaceManager );
				
					if(family!=null&&family.InnerText =="chart")
					{
						XmlNode stylename         = nodeChild.SelectSingleNode ("@style:name",this.Chart .Document .NamespaceManager);

						if( stylename.InnerText ==styleName)

							return nodeChild;
					}
				}
			}

			return null;
			
		}

		/// <summary>
		/// create chart title style
		/// </summary>
		/// <param name="nodeStyle"></param>
		/// <returns></returns>

		public TitleStyle CreateChartTitleStyle(XmlNode nodeStyle)
		{

			TitleStyle titleStyle              = new TitleStyle (this.Chart .Document);
			titleStyle.Node                    = nodeStyle;

			IPropertyCollection  pCollection=new IPropertyCollection ();

			if(nodeStyle.HasChildNodes)
			{

				foreach(XmlNode nodeChild in nodeStyle.ChildNodes )
				{
					IProperty property         = this.GetProperty (titleStyle,nodeChild);
					if(property!=null)
					
						pCollection.Add (property);
					
				}
			}

			titleStyle.Node.InnerXml="";

			foreach(IProperty property in pCollection)

				titleStyle.PropertyCollection .Add (property);

			return titleStyle;
		}

		/// <summary>
		/// create chart style
		/// </summary>
		/// <param name="nodeStyle"></param>
		/// <returns></returns>

		public ChartStyle CreateChartStyle(XmlNode nodeStyle)
		{
			ChartStyle chartStyle              = new ChartStyle (this.Chart .Document);
			chartStyle.Node                    = nodeStyle;

			IPropertyCollection  pCollection=new IPropertyCollection ();

			if(nodeStyle.HasChildNodes)
			{

				foreach(XmlNode nodeChild in nodeStyle.ChildNodes )
				{
					IProperty property        = this.GetProperty (chartStyle,nodeChild);
					if(property!=null)
					
						pCollection.Add (property);
					
				}
			}

			chartStyle.Node.InnerXml="";

			foreach(IProperty property in pCollection)

				chartStyle.PropertyCollection .Add (property);

			//this.Chart .Styles .Add (chartStyle);

			return chartStyle;


			
		}

		/// <summary>
		/// create chart legend style
		/// </summary>
		/// <param name="nodeStyle"></param>
		/// <returns></returns>

		public LegendStyle CreateChartLegendStyle(XmlNode nodeStyle)
		{
			LegendStyle legendStyle              = new LegendStyle (this.Chart .Document);
			legendStyle.Node                     = nodeStyle;

			IPropertyCollection  pCollection     = new IPropertyCollection ();

			if(nodeStyle.HasChildNodes)
			{

				foreach(XmlNode nodeChild in nodeStyle.ChildNodes )
				{
					IProperty property          = this.GetProperty (legendStyle,nodeChild);
					if(property!=null)
					
						pCollection.Add (property);
					
				}
			}

			legendStyle.Node.InnerXml="";

			foreach(IProperty property in pCollection)

				legendStyle.PropertyCollection .Add (property);

			//this.Chart .Styles .Add (legendStyle);

			return legendStyle;

		}

		/// <summary>
		/// create chart plotarea style
		/// </summary>
		/// <param name="nodeStyle"></param>
		/// <returns></returns>

		public PlotAreaStyle   CreateChartPlotAreaStyle(XmlNode nodeStyle)
		{
			PlotAreaStyle plotareaStyle           = new PlotAreaStyle (this.Chart .Document);
			plotareaStyle.Node                    = nodeStyle;

			IPropertyCollection  pCollection      = new IPropertyCollection ();

			if(nodeStyle.HasChildNodes)
			{

				foreach(XmlNode nodeChild in nodeStyle.ChildNodes )
				{
					IProperty property            = this.GetProperty (plotareaStyle,nodeChild);
					if(property!=null)
					
						pCollection.Add (property);
					
				}
			}

			plotareaStyle.Node.InnerXml="";

			foreach(IProperty property in pCollection)

				plotareaStyle.PropertyCollection .Add (property);

			//this.Chart .Styles .Add (plotareaStyle);

			return plotareaStyle;
		}

		/// <summary>
		/// create chart axes style
		/// </summary>
		/// <param name="nodeStyle"></param>
		/// <returns></returns>

		private AxesStyle CreateChartAxesStyle(XmlNode nodeStyle)
		{
			AxesStyle  axesStyle                  = new AxesStyle (this.Chart .Document);
			axesStyle.Node                        = nodeStyle;
			IPropertyCollection  pCollection      = new IPropertyCollection ();

			if(nodeStyle.HasChildNodes)
			{

				foreach(XmlNode nodeChild in nodeStyle.ChildNodes )
				{
					IProperty property            = this.GetProperty (axesStyle,nodeChild);
					if(property!=null)
					
						pCollection.Add (property);
					
				}
			}

			axesStyle.Node.InnerXml="";

			foreach(IProperty property in pCollection)

				axesStyle.PropertyCollection .Add (property);

			//this.Chart .Styles .Add (axesStyle);

			return axesStyle;
			 
		}

		/// <summary>
		/// create chart series style
		/// </summary>
		/// <param name="nodeStyle"></param>
		/// <returns></returns>

		private SeriesStyle CreateChartSeriesStyle(XmlNode nodeStyle)
		{
			SeriesStyle    seriesStyle          =new SeriesStyle (this.Chart .Document, nodeStyle);
			seriesStyle.Node                    = nodeStyle;

			IPropertyCollection  pCollection    = new IPropertyCollection ();

			if(nodeStyle.HasChildNodes)
			{

				foreach(XmlNode nodeChild in nodeStyle.ChildNodes )
				{
					IProperty property          = this.GetProperty (seriesStyle,nodeChild);
					if(property!=null)
					
						pCollection.Add (property);
					
				}
			}

			seriesStyle.Node.InnerXml="";

			foreach(IProperty property in pCollection)

				seriesStyle.PropertyCollection .Add (property);

			//this.Chart .Styles .Add (seriesStyle);

			return seriesStyle;

		}

		/// <summary>
		/// create chart wall style
		/// </summary>
		/// <param name="nodeStyle"></param>
		/// <returns></returns>

		private WallStyle CreateChartWallStyle(XmlNode nodeStyle)
		{
			WallStyle    wallStyle              =new WallStyle (this.Chart .Document);
			wallStyle.Node                      = nodeStyle;

			IPropertyCollection  pCollection    = new IPropertyCollection ();

			if(nodeStyle.HasChildNodes)
			{

				foreach(XmlNode nodeChild in nodeStyle.ChildNodes )
				{
					IProperty property          = this.GetProperty (wallStyle,nodeChild);
					if(property!=null)
					
						pCollection.Add (property);
					
				}
			}

			wallStyle.Node.InnerXml="";

			foreach(IProperty property in pCollection)

				wallStyle.PropertyCollection .Add (property);

			//this.Chart .Styles .Add (wallStyle);

			return wallStyle;

		}

		/// <summary>
		/// create chart floor style
		/// </summary>
		/// <param name="nodeStyle"></param>
		/// <returns></returns>

		
		private FloorStyle CreateChartFloorStyle(XmlNode nodeStyle)
		{
			FloorStyle    floorStyle              =new FloorStyle (this.Chart .Document);
			floorStyle.Node                      = nodeStyle;

			IPropertyCollection  pCollection    = new IPropertyCollection ();

			if(nodeStyle.HasChildNodes)
			{

				foreach(XmlNode nodeChild in nodeStyle.ChildNodes )
				{
					IProperty property          = this.GetProperty (floorStyle,nodeChild);
					if(property!=null)
					
						pCollection.Add (property);
					
				}
			}

			floorStyle.Node.InnerXml="";

			foreach(IProperty property in pCollection)

				floorStyle.PropertyCollection .Add (property);

			//this.Chart .Styles .Add (floorStyle);

			return floorStyle;

		}

        /// <summary>
        /// get the property of the style
        /// </summary>
        /// <param name="nodeStyle"></param>
        /// <param name="propertyNode"></param>
        /// <returns></returns>

		private IProperty GetProperty(IStyle nodeStyle,XmlNode propertyNode)
		{
			if(propertyNode != null && nodeStyle != null)
			{
				if(propertyNode.Name == "style:graphic-properties")
					return CreateGraphicProperties(nodeStyle,propertyNode);
				if(propertyNode.Name == "style:text-properties")
					return CreateTextProperties(nodeStyle,propertyNode);
				if(propertyNode.Name == "style:chart-properties")
					return CreateChartProperty(nodeStyle,propertyNode);
				else
					return CreateUnknownProperties(nodeStyle, propertyNode);
			}
			else
				return null;

		}

		/// <summary>
		/// create the graphic property
		/// </summary>
		/// <param name="style"></param>
		/// <param name="node"></param>
		/// <returns></returns>

		public ChartGraphicProperties CreateGraphicProperties(IStyle style,XmlNode node)
		{
			ChartGraphicProperties graphicProperty    = new ChartGraphicProperties (style);
			graphicProperty.Node                      = node;

			return graphicProperty;
 
		}

		/// <summary>
		/// create the text property
		/// </summary>
		/// <param name="style"></param>
		/// <param name="propertyNode"></param>
		/// <returns></returns>

		private TextProperties CreateTextProperties(IStyle style, XmlNode propertyNode)
		{
			TextProperties textProperties		     = new TextProperties(style);
			textProperties.Node					     = propertyNode;

			return textProperties;
		}

		/// <summary>
		/// create the chart property
		/// </summary>
		/// <param name="style"></param>
		/// <param name="node"></param>
		/// <returns></returns>

		private IProperty CreateChartProperty(IStyle style,XmlNode node)
		{
			if(style is PlotAreaProperties )
				return CreatePlotAreaProperties(style,node);

			if(style is AxesProperties  )
				return CreateAxesProperties(style,node);
			else
				return CreateChartProperties(style,node);
		}

		/// <summary>
		/// create the plotarea property
		/// </summary>
		/// <param name="style"></param>
		/// <param name="node"></param>
		/// <returns></returns>

		private PlotAreaProperties	CreatePlotAreaProperties(IStyle style,XmlNode node)
		{
			PlotAreaProperties plotareaProperty     = new PlotAreaProperties (style);
			plotareaProperty.Node                   =node;
			return plotareaProperty;
		}

		/// <summary>
		/// create the axes property
		/// </summary>
		/// <param name="style"></param>
		/// <param name="node"></param>
		/// <returns></returns>
		private AxesProperties	CreateAxesProperties(IStyle style,XmlNode node)
		{
			AxesProperties axisProperty     = new AxesProperties (style);
			axisProperty.Node                =node;
			return  axisProperty;
		}

		/// <summary>
		/// create the chart property
		/// </summary>
		/// <param name="style"></param>
		/// <param name="node"></param>
		/// <returns></returns>

		private ChartProperties	CreateChartProperties(IStyle style,XmlNode node)
		{
			ChartProperties chartProperty     = new ChartProperties (style);
			chartProperty.Node                =node;
			return  chartProperty;
		}

		/// <summary>
		/// create unknown property
		/// </summary>
		/// <param name="style"></param>
		/// <param name="node"></param>
		/// <returns></returns>

		private UnknownProperty CreateUnknownProperties(IStyle style, XmlNode node)
		{
			return new UnknownProperty(style, node);
		}



	}
}

