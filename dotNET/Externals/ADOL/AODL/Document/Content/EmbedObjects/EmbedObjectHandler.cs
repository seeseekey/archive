/*************************************************************************
 *
 * DO NOT ALTER OR REMOVE COPYRIGHT NOTICES OR THIS FILE HEADER.
 * 
 * Copyright 2008 by Sun Microsystems, Inc.
 *
 * OpenOffice.org - a multi-platform office productivity suite
 *
 * $RCSfile: EmbedObjectHandler.cs,v $
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
using AODL.Document .Content ;
using AODL.Document ;
using AODL.Document .Content .Charts ;
using AODL.Document .Content .EmbedObjects ;



namespace AODL.Document.Content.EmbedObjects
{
	/// <summary>
	/// Summary description for EmbedObjectHandler.
	/// </summary>
	public class EmbedObjectHandler
	{
		/// <summary>
		/// the document which contains the embed object
		/// </summary>

		private IDocument _document;

		public IDocument Document
		{
			get
			{
				return this._document ;
			}

			set
			{
				this._document =value;
			}
		}

		/// <summary>
		/// the constructor 
		/// </summary>
		/// <param name="document"></param>

		public EmbedObjectHandler(IDocument document)
		{
			this.Document =document;
		}

		/// <summary>
		/// create a embed object
		/// </summary>
		/// <param name="ParentNode"></param>
		/// <param name="MediaType"></param>
		/// <param name="ObjectRealPath"></param>
		/// <returns></returns>

		public EmbedObject CreateEmbedObject(XmlNode ParentNode,string MediaType,string ObjectRealPath,string ObjectName)
		{
			switch(MediaType)
			{
				case "application/vnd.oasis.opendocument.chart":

					return CreateChart(ParentNode,ObjectRealPath,ObjectName);
					break;

				case"application/vnd.oasis.opendocument.text":

					return null;
					break;

				case "application/vnd.oasis.opendocument.formula":
					
					return null;
					break;

				case "application/vnd.oasis.opendocument.presentation":

					return null;
					break;

				default:
					
					return null;
			}
		}

		/// <summary>
		/// create the chart
		/// </summary>
		/// <param name="ParentNode"></param>
		/// <param name="ObjectRealPath"></param>
		/// <returns></returns>

		public  Chart CreateChart(XmlNode ParentNode, string ObjectRealPath,string ObjectName)
		{
			try
			{
				Chart chart                 = new Chart (this._document ,null,ParentNode);

				chart.ObjectType            = "chart";

				chart.ObjectName            = ObjectName;

				chart.ObjectRealPath        = ObjectRealPath;

				ChartImporter chartimporter = new ChartImporter (chart);

				chartimporter.Import ();

				return chart;
			}
			catch(Exception ex)
			{
				throw;
			}
		}

	}
}

