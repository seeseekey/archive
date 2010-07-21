/*************************************************************************
 *
 * DO NOT ALTER OR REMOVE COPYRIGHT NOTICES OR THIS FILE HEADER.
 * 
 * Copyright 2008 by Sun Microsystems, Inc.
 *
 * OpenOffice.org - a multi-platform office productivity suite
 *
 * $RCSfile: SizeConverter.cs,v $
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

namespace AODL.Document.Helper
{
	/// <summary>
	/// The SizeConverter class offer different methods for size 
	/// type conversation.
	/// </summary>
	/// <remarks>obsolete - don't start to use it, it will maybe deleted within an upcoming version</remarks>
	public class SizeConverter
	{
		/// <summary>
		/// Pixel to cm factor
		/// </summary>
		public static readonly double pxtocm		= 37.7928;
		/// <summary>
		/// Inch to cm factor
		/// </summary>
		public static readonly double intocm		= 2.54;

		/// <summary>
		/// Initializes a new instance of the <see cref="SizeConverter"/> class.
		/// </summary>
		public SizeConverter()
		{
		}

		/// <summary>
		/// Cms to inch.
		/// </summary>
		/// <param name="cm">The cm.</param>
		/// <returns></returns>
		public static double CmToInch(double cm)
		{
			return intocm*cm;
		}

		/// <summary>
		/// Cms to pixel.
		/// </summary>
		/// <param name="cm">The cm.</param>
		/// <returns></returns>
		public static double CmToPixel(double cm)
		{
			return pxtocm*cm;
		}

		/// <summary>
		/// Cms to pixel.
		/// </summary>
		/// <param name="cm">The cm.</param>
		/// <returns></returns>
		public static double MmToPixel(double mm)
		{
			return pxtocm*mm/10;
		}

		/// <summary>
		/// Inches to cm.
		/// </summary>
		/// <param name="inch">The inch.</param>
		/// <returns></returns>
		public static double InchToCm(double inch)
		{
			return inch/intocm;
		}

		/// <summary>
		/// Inches to pixel.
		/// </summary>
		/// <param name="inch">The inch.</param>
		/// <returns></returns>
		public static double InchToPixel(double inch)
		{
			return inch*pxtocm*intocm;
		}

		/// <summary>
		/// Inches to pixel as string.
		/// </summary>
		/// <param name="inch">The inch.</param>
		/// <returns></returns>
		public static string InchToPixelAsString(double inch)
		{
			return InchToPixel(inch).ToString(System.Globalization.NumberFormatInfo.InvariantInfo)+"px";
		}

		/// <summary>
		/// Inches to cm as string.
		/// </summary>
		/// <param name="inch">The inch.</param>
		/// <returns></returns>
		public static string InchToCmAsString(double inch)
		{
			return InchToCm(inch).ToString(System.Globalization.NumberFormatInfo.InvariantInfo)+"cm";
		}

		/// <summary>
		/// Cms to inch as string.
		/// </summary>
		/// <param name="cm">The cm.</param>
		/// <returns></returns>
		public static string CmToInchAsString(double cm)
		{
			//return CmToInch(cm).ToString(System.Globalization.NumberFormatInfo.InvariantInfo)+"in";
			int inch			= (int)CmToInch(cm);
			return inch.ToString()+"in";
		}

		/// <summary>
		/// Cms to pixel as string.
		/// </summary>
		/// <param name="cm">The cm.</param>
		/// <returns></returns>
		public static string CmToPixelAsString(double cm)
		{
			//return CmToPixel(cm).ToString(System.Globalization.NumberFormatInfo.InvariantInfo)+"px";
			int px			= (int)CmToPixel(cm);
			return px.ToString()+"px";
		}

		/// <summary>
		/// Gets the pixel from an office size value.
		/// e.g pass 1.54cm and get back 58
		/// </summary>
		/// <param name="aSizeValue">A size value.</param>
		/// <returns>If something goes wrong it will return 0.</returns>
		public static int GetPixelFromAnOfficeSizeValue(string aSizeValue)
		{
			if(aSizeValue == null)
				return 0;

			try
			{
				if(aSizeValue.EndsWith("cm"))
				{
					aSizeValue		= aSizeValue.Replace("cm", "");

					return (int)CmToPixel(Convert.ToDouble(aSizeValue, System.Globalization.NumberFormatInfo.InvariantInfo));
				}
				
				if(aSizeValue.EndsWith("mm"))
				{
					aSizeValue		= aSizeValue.Replace("mm", "");

					return (int)MmToPixel(Convert.ToDouble(aSizeValue, System.Globalization.NumberFormatInfo.InvariantInfo));
				}

				else if(aSizeValue.EndsWith("in"))
				{
					aSizeValue		= aSizeValue.Replace("in", "");

					return (int)InchToPixel(Convert.ToDouble(aSizeValue, System.Globalization.NumberFormatInfo.InvariantInfo));
				}

				return 0;
			}
			catch(Exception ex)
			{
				return 0;
			}
		}

		/// <summary>
		/// Gets the double from an office size value.
		/// </summary>
		/// <remarks>
		/// There is no translation between cm or inch. You will just get the
		/// size you posted as double value.
		/// </remarks>
		/// <param name="aSizeValue">A size value.</param>
		/// <returns></returns>
		public static double GetDoubleFromAnOfficeSizeValue(string aSizeValue)
		{
			if(aSizeValue == null)
				return 0;

			try
			{
				if(aSizeValue.EndsWith("cm"))
				{
					aSizeValue		= aSizeValue.Replace("cm", "");

					return Convert.ToDouble(aSizeValue, System.Globalization.NumberFormatInfo.InvariantInfo);
				}
				else if(aSizeValue.EndsWith("in"))
				{
					aSizeValue		= aSizeValue.Replace("in", "");

					return Convert.ToDouble(aSizeValue, System.Globalization.NumberFormatInfo.InvariantInfo);
				}

				return 0;
			}
			catch(Exception ex)
			{
				return 0;
			}
		}

		/// <summary>
		/// Determines whether the specified value is in cm.
		/// </summary>
		/// <param name="value">The value.</param>
		/// <returns>
		/// 	<c>true</c> if the specified value is in cm; otherwise, <c>false</c>.
		/// </returns>
		public static bool IsCm(string value)
		{
			try
			{
				if(value != null)
					return value.ToLower().EndsWith("cm");
				return false;
			}
			catch(Exception)
			{
				throw;
			}
		}

		/// <summary>
		/// Determines whether the specified value is in inch.
		/// </summary>
		/// <param name="value">The value.</param>
		/// <returns>
		/// 	<c>true</c> if the specified value is in inch; otherwise, <c>false</c>.
		/// </returns>
		public static bool IsInch(string value)
		{
			try
			{
				if(value != null)
					return value.ToLower().EndsWith("in");
				return false;
			}
			catch(Exception)
			{
				throw;
			}
		}

		/// <summary>
		/// Cacluates the width in pixel from width in cm or inch by using the horizontal resolution.
		/// </summary>
		/// <param name="width">The width.</param>
		/// <param name="dpiX">The dpi X.</param>
		/// <param name="cm">if set to <c>true</c> in cm otherwise inch.</param>
		/// <returns>The relative width in pixel</returns>
		public static double GetWidthInPixel(int width, int dpiX, bool cm)
		{
			try
			{
				double widthD = 0.0;
				if(cm)
					widthD = width / intocm;
				return ((double)((double)dpiX * widthD));
			}
			catch(Exception)
			{
				throw;
			}
		}

		/// <summary>
		/// Cacluates the relative height in pixel from height in cm or inch by using the vertical resolution.
		/// </summary>
		/// <param name="height">The height.</param>
		/// <param name="dpiY">The dpi vertical.</param>
		/// <param name="cm">if set to <c>true</c> in cm otherwise inch.</param>
		/// <returns>The relative height in pixel</returns>
		public static double GetHeightInPixel(int height, int dpiY, bool cm)
		{
			try
			{
				return GetWidthInPixel(height, dpiY, cm);
			}
			catch(Exception)
			{
				throw;
			}
		}

		/// <summary>
		/// Cacluates the width in cm from width in pixel by using the horizontal resolution.
		/// </summary>
		/// <param name="widthPixel">The width.</param>
		/// <param name="dpiX">The dpi X.</param>
		/// <returns>The real width in cm</returns>
		public static double GetWidthInCm(int widthPixel, int dpiX)
		{
			try
			{
				// px / dpi = inch ( for height and width )
				return ((double)((double)widthPixel / (double)dpiX) * intocm);
			}
			catch(Exception)
			{
				throw;
			}
		}

		/// <summary>
		/// Cacluates the height in cm from height in pixel by using the vertical resolution.
		/// </summary>
		/// <param name="heightPixel">The height.</param>
		/// <param name="dpiY">The dpi Y.</param>
		/// <returns>The real height in cm</returns>
		public static double GetHeightInCm(int heightPixel, int dpiY)
		{
			try
			{
				return GetWidthInCm(heightPixel, dpiY);
			}
			catch(Exception)
			{
				throw;
			}
		}
	}
}

/*
 * $Log: SizeConverter.cs,v $
 * Revision 1.5  2008/04/29 15:39:51  mt
 * new copyright header
 *
 * Revision 1.4  2007/06/20 17:37:19  yegorov
 * Issue number:
 * Submitted by:
 * Reviewed by:
 *
 * Revision 1.1  2007/02/25 08:58:44  larsbehr
 * initial checkin, import from Sourceforge.net to OpenOffice.org
 *
 * Revision 1.3  2007/02/13 17:58:48  larsbm
 * - add first part of implementation of master style pages
 * - pdf exporter conversations for tables and images and added measurement helper
 *
 * Revision 1.2  2006/02/08 16:37:36  larsbm
 * - nested table test
 * - AODC spreadsheet
 *
 * Revision 1.1  2006/01/29 11:28:23  larsbm
 * - Changes for the new version. 1.2. see next changelog for details
 *
 */