/*************************************************************************
 *
 * DO NOT ALTER OR REMOVE COPYRIGHT NOTICES OR THIS FILE HEADER.
 * 
 * Copyright 2008 by Sun Microsystems, Inc.
 *
 * OpenOffice.org - a multi-platform office productivity suite
 *
 * $RCSfile: PlotAreaProperties.cs,v $
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

namespace AODL.Document.Styles.Properties
{
	/// <summary>
	/// Summary description for PlotAreaProperties.
	/// </summary>
	public class PlotAreaProperties :ChartProperties
	{
		/// <summary>
		/// gets and sets series source
		/// </summary>
		public string SeriesSource
		{
			get 
			{ 
				XmlNode xn = this.Node .SelectSingleNode("@chart:series-source",
					this.Style.Document.NamespaceManager);
				if(xn != null)
					return xn.InnerText;
				return null;
			}
			set
			{
				XmlNode xn = this.Node .SelectSingleNode("@chart:series-source",
					this.Style.Document.NamespaceManager);
				if(xn == null)
					this.CreateAttribute("series-source", value, "chart");
				this.Node .SelectSingleNode("@chart:series-source",
					this.Style.Document.NamespaceManager).InnerText = value;
			}
		}

		/// <summary>
		/// gets and sets regression type
		/// </summary>

		public string RegressionType
		{
			get 
			{ 
				XmlNode xn = this.Node .SelectSingleNode("@chart:regression-type",
					this.Style.Document.NamespaceManager);
				if(xn != null)
					return xn.InnerText;
				return null;
			}
			set
			{
				XmlNode xn = this.Node .SelectSingleNode("@chart:regression-type",
					this.Style.Document.NamespaceManager);
				if(xn == null)
					this.CreateAttribute("regression-type", value, "chart");
				this.Node .SelectSingleNode("@chart:regression-type",
					this.Style.Document.NamespaceManager).InnerText = value;
			}
		}

		/// <summary>
		/// the constructor of plotarea property
		/// </summary>
		/// <param name="style"></param>

		public PlotAreaProperties(IStyle style):base(style)
		{


		}
	}
}

