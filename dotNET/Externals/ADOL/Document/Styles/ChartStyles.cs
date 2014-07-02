/*************************************************************************
 *
 * DO NOT ALTER OR REMOVE COPYRIGHT NOTICES OR THIS FILE HEADER.
 * 
 * Copyright 2008 by Sun Microsystems, Inc.
 *
 * OpenOffice.org - a multi-platform office productivity suite
 *
 * $RCSfile: ChartStyles.cs,v $
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
using AODL.Document .Styles .Properties ;
using AODL.Document .Collections ;
using AODL.Document .Content .Charts ;

namespace AODL.Document.Styles
{
	/// <summary>
	/// Summary description for ChartStyles.
	/// </summary>
	public class ChartStyles
	{
		public ChartStyles(Chart chart)
		{
			this.Chart     = chart;
			this.Styles    = new XmlDocument ();

		}

		public static readonly string FileName		= "styles.xml";
		/// <summary>
		/// XPath to the document office styles
		/// </summary>
		private static readonly string OfficeStyles	= "/office:document-style/office:styles";

		private XmlDocument _styles;
		/// <summary>
		/// Gets or sets the chart styles from the styles.xml file.
		/// </summary>
		/// <value>The styles.</value>
		public XmlDocument Styles
		{
			get { return this._styles; }
			set { this._styles = value; }
		}

		private Chart _chart;

		public Chart Chart
		{
			get    
			{ 
				return this._chart;
			}
			set    
			{
				this._chart=value;
			}
		}
	}
}