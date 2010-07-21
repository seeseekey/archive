/*************************************************************************
 *
 * DO NOT ALTER OR REMOVE COPYRIGHT NOTICES OR THIS FILE HEADER.
 * 
 * Copyright 2008 by Sun Microsystems, Inc.
 *
 * OpenOffice.org - a multi-platform office productivity suite
 *
 * $RCSfile: FormatedTextConverter.cs,v $
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
using System.Collections;
using AODL.Document.Styles;
using AODL.Document.Content.Text;
using AODL.ExternalExporter.PDF.Document.StyleConverter;

namespace AODL.ExternalExporter.PDF.Document.ContentConverter
{
	/// <summary>
	/// Summary for FormatedTextConverter.
	/// </summary>
	public class FormatedTextConverter
	{
		/// <summary>
		/// Initializes a new instance of the <see cref="FormatedTextConverter"/> class.
		/// </summary>
		public FormatedTextConverter()
		{
		}

		/// <summary>
		/// Converts the specified formated text.
		/// </summary>
		/// <param name="formatedText">The formated text.</param>
		/// <returns>The chunck object representing this formated text.</returns>
		public static iTextSharp.text.Phrase Convert(AODL.Document.Content.Text.FormatedText formatedText)
		{
			try
			{
				iTextSharp.text.Font font;
				if((TextStyle)formatedText.Style != null 
					&& ((TextStyle)formatedText.Style).TextProperties != null)
					font = TextPropertyConverter.GetFont(
						((TextStyle)formatedText.Style).TextProperties);
				else
					font = DefaultDocumentStyles.Instance().DefaultTextFont;

				iTextSharp.text.Phrase phrase = new iTextSharp.text.Phrase("", font); // default ctor protected - why ??
				phrase.AddRange(FormatedTextConverter.GetTextContents(formatedText.TextContent, font));

				return phrase;
			}
			catch(Exception)
			{
				throw;
			}
		}

		/// <summary>
		/// Gets the text contents.
		/// </summary>
		/// <param name="textCollection">The text collection.</param>
		/// <returns>The content. ArrayList of chunks and phrases.</returns>
		public static ICollection GetTextContents(ITextCollection textCollection, iTextSharp.text.Font font)
		{
			try
			{
				ArrayList contents = new ArrayList();
				foreach(object obj in textCollection)
				{
					if(obj is AODL.Document.Content.Text.FormatedText)
					{
						contents.Add(FormatedTextConverter.Convert(
							obj as AODL.Document.Content.Text.FormatedText));
					}
					else if(obj is AODL.Document.Content.Text.SimpleText)
					{
						contents.Add(SimpleTextConverter.Convert(
							obj as AODL.Document.Content.Text.SimpleText, font));
					}
					else if(obj is AODL.Document.Content.Text.TextControl.TabStop)
					{
						contents.Add(SimpleTextConverter.ConvertTabs(
							obj as AODL.Document.Content.Text.TextControl.TabStop, font));
					}
					else if(obj is AODL.Document.Content.Text.TextControl.WhiteSpace)
					{
						contents.Add(SimpleTextConverter.ConvertWhiteSpaces(
							obj as AODL.Document.Content.Text.TextControl.WhiteSpace, font));
					}
				}
				return contents;
			}
			catch(Exception ex)
			{
				throw;
			}
		}
	}
}
