/*************************************************************************
 *
 * DO NOT ALTER OR REMOVE COPYRIGHT NOTICES OR THIS FILE HEADER.
 * 
 * Copyright 2008 by Sun Microsystems, Inc.
 *
 * OpenOffice.org - a multi-platform office productivity suite
 *
 * $RCSfile: TextPropertyConverter.cs,v $
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
using AODL.Document.Styles;
using AODL.Document.Styles.Properties;
using iTextSharp.text;

namespace AODL.ExternalExporter.PDF.Document.StyleConverter
{
	/// <summary>
	/// Summary for TextPropertyConverter.
	/// </summary>
	public class TextPropertyConverter
	{
		public TextPropertyConverter()
		{
		}

		/// <summary>
		/// Gets the font object.
		/// </summary>
		/// <param name="textProperties">The text properties.</param>
		/// <returns>The font object</returns>
		public static Font GetFont(TextProperties textProperties)
		{
			try
			{
				Font font = new Font();
				if(textProperties != null)
				{
					string fontName = "";
					if(textProperties.FontName != null)
						fontName = textProperties.FontName;
					else
					{
						fontName = DefaultDocumentStyles.Instance().DefaultTextFont.Familyname;
					}

					if(FontFactory.Contains(fontName))
					{
						string colorStr = "#000000";
						int iTextFontStyle = 0; //normal
						int bold = (textProperties.Bold != null && textProperties.Bold.ToLower() == "bold") ? 1 : 0;
						int italic = (textProperties.Italic != null && textProperties.Bold.ToLower() == "italic") ? 1 : 0;
						int textLineThrough = (textProperties.TextLineThrough != null) ? 1 : 0;
						int underline = (textProperties.Underline != null) ? 1 : 0;
						float size = 12.0f; // up to now, standard todo: do it better
						if(textProperties.FontSize != null)
						{
							if(textProperties.FontSize.ToLower().EndsWith("pt"))
							{
								try
								{
									size = (float) Convert.ToDouble(textProperties.FontSize.ToLower().Replace("pt",""));
								}
								catch(Exception)
								{
									throw;
								}
							}
						}
						if(textProperties.FontColor != null)
						{
							colorStr = textProperties.FontColor;
						}
						if(bold == 1 && italic == 1)
							iTextFontStyle = Font.BOLDITALIC;
						if(bold == 1 && italic == 0)
							iTextFontStyle = Font.BOLD;
						if(bold == 0 && italic == 1)
							iTextFontStyle = Font.ITALIC;
						// TODO: underline strike through
						iTextSharp.text.Color color = RGBColorConverter.GetColorFromHex(colorStr);
						font = FontFactory.GetFont(fontName, size, iTextFontStyle, color);
					}
				}
				return font;
			}
			catch(Exception)
			{
				throw;
			}
		}


		/// <summary>
		/// Fonts the multiplier.
		/// This will rewrite a font which inherited from a parent style.
		/// </summary>
		/// <param name="textProperties">The text properties.</param>
		/// <param name="font">The font.</param>
		/// <returns>The new font.</returns>
		public static Font FontMultiplier(TextProperties textProperties, Font font)
		{
			try
			{
				string fontName = "";
				if(textProperties.FontName != null)
					fontName = textProperties.FontName;
				else
				{
					fontName = font.Familyname;
				}

				string colorStr = "#000000";
				int iTextFontStyle = 0; //normal
				int bold = (textProperties.Bold != null && textProperties.Bold.ToLower() == "bold") ? 1 : 0;
				int italic = (textProperties.Italic != null && textProperties.Bold.ToLower() == "italic") ? 1 : 0;
				float size = font.Size; // up to now, standard todo: do it better
				if(textProperties.FontSize != null)
				{
					if(textProperties.FontSize.ToLower().EndsWith("%"))
					{
						try
						{
							float percent = (float) Convert.ToDouble(textProperties.FontSize.ToLower().Replace("%",""));
							size *= (percent/100.0f);  
						}
						catch(Exception)
						{
							throw;
						}
					}
				}
				if(textProperties.FontColor != null)
				{
					colorStr = textProperties.FontColor;
				}
				if(bold == 1 && italic == 1)
					iTextFontStyle = Font.BOLDITALIC;
				if(bold == 1 && italic == 0)
					iTextFontStyle = Font.BOLD;
				if(bold == 0 && italic == 1)
					iTextFontStyle = Font.ITALIC;
				// TODO: underline strike through
				iTextSharp.text.Color color = RGBColorConverter.GetColorFromHex(colorStr);
				font = FontFactory.GetFont(fontName, size, iTextFontStyle, color);

				return font;
			}
			catch(Exception)
			{
				throw;
			}
		}
	}
}
