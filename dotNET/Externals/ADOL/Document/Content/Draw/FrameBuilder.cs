/*************************************************************************
 *
 * DO NOT ALTER OR REMOVE COPYRIGHT NOTICES OR THIS FILE HEADER.
 * 
 * Copyright 2008 by Sun Microsystems, Inc.
 *
 * OpenOffice.org - a multi-platform office productivity suite
 *
 * $RCSfile: FrameBuilder.cs,v $
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
using System.IO;
using System.Drawing;
using System.Xml;
using AODL.Document.Styles;
using AODL.Document.Content.Text;
using AODL.Document.Content.Text.Indexes;
using AODL.Document.Content;
using AODL.Document;

namespace AODL.Document.Content.Draw
{
	/// <summary>
	/// Use the FrameBuilder class to create several types of Frame implementations
	/// like illustration frame, a standard graphic frame, ...
	/// </summary>
	public class FrameBuilder
	{
		/// <summary>
		/// Initializes a new instance of the <see cref="FrameBuilder"/> class.
		/// </summary>
		public FrameBuilder()
		{
		}

		/// <summary>
		/// Builds the standard graphic frame.
		/// </summary>
		/// <param name="document">The document.</param>
		/// <param name="frameStyleName">Name of the frame style.</param>
		/// <param name="graphicName">Name of the graphic.</param>
		/// <param name="pathToGraphic">The path to graphic.</param>
		/// <returns>
		/// A new Frame object containing the Graphic object.
		/// </returns>
		public static Frame BuildStandardGraphicFrame(IDocument document, string frameStyleName, 
			string graphicName, string pathToGraphic)
		{
			return new Frame(document, frameStyleName, graphicName, pathToGraphic);
		}

		/// <summary>
		/// Builds the illustration frame.
		/// </summary>
		/// <param name="document">The document.</param>
		/// <param name="frameStyleName">Name of the frame style.</param>
		/// <param name="graphicName">Name of the graphic.</param>
		/// <param name="pathToGraphic">The path to graphic.</param>
		/// <param name="illustrationText">The illustration text.</param>
		/// <param name="illustrationNumber">The illustration number.</param>
		/// <returns>
		/// A new Frame object containing a DrawTextBox which contains the
		/// illustration Graphic object and a text sequence representing
		/// the displayed illustration text.
		/// </returns>
		public static Frame BuildIllustrationFrame(IDocument document, string frameStyleName, string graphicName, 
			string pathToGraphic, string illustrationText, int illustrationNumber)
		{
			DrawTextBox drawTextBox			= new DrawTextBox(document);
			Frame frameTextBox				= new Frame(document, frameStyleName);
			frameTextBox.DrawName			= frameStyleName+"_"+graphicName;
			frameTextBox.ZIndex				= "0"; 

			Paragraph pIllustration			= ParagraphBuilder.CreateStandardTextParagraph(document);
			pIllustration.StyleName			= "Illustration";
			Frame frame						= new Frame(document, "InnerFrame_"+frameStyleName, 
				graphicName, pathToGraphic);
			frame.ZIndex					= "1";

			pIllustration.Content.Add(frame);
			//add Illustration as text
			pIllustration.TextContent.Add(new SimpleText(document, "Illustration"));			
			//add TextSequence
			TextSequence textSequence		= new TextSequence(document);
			textSequence.Name				= "Illustration";
			textSequence.NumFormat			= "1";
			textSequence.RefName			= "refIllustration"+illustrationNumber.ToString();
			textSequence.Formula			= "ooow:Illustration+1";
			textSequence.TextContent.Add(new SimpleText(document, illustrationNumber.ToString()));
			pIllustration.TextContent.Add(textSequence);
			//add the ilustration text
			pIllustration.TextContent.Add(new SimpleText(document, illustrationText));
			//add the Paragraph to the DrawTextBox
			drawTextBox.Content.Add(pIllustration);
			
			frameTextBox.SvgWidth			= frame.SvgWidth;
			drawTextBox.MinWidth			= frame.SvgWidth;
			drawTextBox.MinHeight			= frame.SvgHeight;
			frameTextBox.Content.Add(drawTextBox);

			return frameTextBox;
		}
	}
}

/*
 * $Log: FrameBuilder.cs,v $
 * Revision 1.2  2008/04/29 15:39:44  mt
 * new copyright header
 *
 * Revision 1.1  2007/02/25 08:58:33  larsbehr
 * initial checkin, import from Sourceforge.net to OpenOffice.org
 *
 * Revision 1.1  2006/02/16 18:35:41  larsbm
 * - Add FrameBuilder class
 * - TextSequence implementation (Todo loading!)
 * - Free draing postioning via x and y coordinates
 * - Graphic will give access to it's full qualified path
 *   via the GraphicRealPath property
 * - Fixed Bug with CellSpan in Spreadsheetdocuments
 * - Fixed bug graphic of loaded files won't be deleted if they
 *   are removed from the content.
 * - Break-Before property for Paragraph properties for Page Break
 *
 */