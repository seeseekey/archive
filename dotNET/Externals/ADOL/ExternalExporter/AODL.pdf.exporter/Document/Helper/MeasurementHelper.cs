/*************************************************************************
 *
 * DO NOT ALTER OR REMOVE COPYRIGHT NOTICES OR THIS FILE HEADER.
 * 
 * Copyright 2008 by Sun Microsystems, Inc.
 *
 * OpenOffice.org - a multi-platform office productivity suite
 *
 * $RCSfile: MeasurementHelper.cs,v $
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

namespace AODL.ExternalExporter.PDF.Document.Helper
{
	/// <summary>
	/// Summary for MeasurementHelper.
	/// </summary>
	public class MeasurementHelper
	{
		/// <summary>
		/// The conversation DPI target with 96 DPI as standard.
		/// </summary>
		public static double TARGET_DPI = 96.0;
		/// <summary>
		/// The standard factor for inch to cm.
		/// </summary>
		public static double INCH_IN_CM = 2.54;
		/// <summary>
		/// DTP point in cm
		/// </summary>
		public static double DTP_POINT_CM = 0.0352;
		/// <summary>
		/// DTP point in inch
		/// </summary>
		public static double DTP_POINT_IN = 0.0139;
		/// <summary>
		/// iText points to cm factor 72points = 2.54cm
		/// </summary>
		public static double ITEXT_POINT_CM = 28.346;
		/// <summary>
		/// iText points to cm factor 72points = 1in
		/// </summary>
		public static double ITEXT_POINT_IN = 72;

		/// <summary>
		/// Initializes a new instance of the <see cref="MeasurementHelper"/> class.
		/// </summary>
		public MeasurementHelper()
		{
		}

		/// <summary>
		/// Inches to points converting.
		/// </summary>
		/// <param name="inch">The inch.</param>
		/// <returns>The points.</returns>
		public static int InchToPoints(double inch)
		{
			try
			{
				return (int)(inch * ITEXT_POINT_IN);
			}
			catch(Exception)
			{
				throw;
			}
		}

		/// <summary>
		/// Cm to points converting
		/// </summary>
		/// <param name="cm">The cm.</param>
		/// <returns>The points.</returns>
		public static int CmToPoints(double cm)
		{
			try
			{
				return (int)(cm * ITEXT_POINT_CM);
			}
			catch(Exception)
			{
				throw;
			}
		}
	}
}
