/*************************************************************************
 *
 * DO NOT ALTER OR REMOVE COPYRIGHT NOTICES OR THIS FILE HEADER.
 * 
 * Copyright 2008 by Sun Microsystems, Inc.
 *
 * OpenOffice.org - a multi-platform office productivity suite
 *
 * $RCSfile: FrameTest.cs,v $
 *
 * $Revision: 1.3 $
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

/*
 * initial Author: Kristy Saunders, ksaunders@eduworks.com
 */

using System;
using System.IO;
using System.Text;
using NUnit.Framework;
using AODL.Document.TextDocuments;
using AODL.Document.Content.Text;
using AODL.Document.Content.Draw;
using AODL.Document.Styles;
using AODL.Document.Styles.Properties;
using AODL.Document.Content.OfficeEvents;

namespace AODLTest
{
	[TestFixture]
	public class FrameTest
	{
		private string _imagefile = Path.Combine(AARunMeFirstAndOnce.inPutFolder , "Eclipse_add_new_Class.jpg");
		private readonly string _framefile = AARunMeFirstAndOnce.outPutFolder + @"frame.odt";
		private readonly string _framefileSave = AARunMeFirstAndOnce.outPutFolder + @"frameSave.odt";
		private readonly string _framefile2 = AARunMeFirstAndOnce.outPutFolder + @"frame2.odt";
		private readonly string _framefile3 = AARunMeFirstAndOnce.outPutFolder + @"frame3.odt";

		[TestFixtureSetUp]
		public void Initialize()
		{
			// Used when running this text fixture alone.
//			if (Directory.Exists(AARunMeFirstAndOnce.outPutFolder))
//				Directory.Delete(AARunMeFirstAndOnce.outPutFolder, true);
//			Directory.CreateDirectory(AARunMeFirstAndOnce.outPutFolder);
		}

		[Test(Description="Write an image with image map to a frame")]
		public void FrameWriteTest()
		{
			try
			{
				TextDocument textdocument = new TextDocument();
				textdocument.New();

				// Create a frame incl. graphic file
				Frame frame					= FrameBuilder.BuildStandardGraphicFrame(
					textdocument, "frame1", "graphic1", _imagefile);
				
				// Create some event listeners (using OpenOffice friendly syntax).
				EventListener script1 = new EventListener(textdocument, 
					"dom:mouseover", "javascript", 
					"vnd.sun.star.script:HelloWorld.helloworld.js?language=JavaScript&location=share");
				EventListener script2 = new EventListener(textdocument,
					"dom:mouseout", "javascript",
					"vnd.sun.star.script:HelloWorld.helloworld.js?language=JavaScript&location=share");
				EventListeners listeners = new EventListeners(textdocument, new EventListener[] { script1, script2 });
				
				// Create and add some area rectangles
				DrawAreaRectangle[] rects = new DrawAreaRectangle[2];
				rects[0] = new DrawAreaRectangle(textdocument, "4cm", "4cm", "2cm", "2cm");
				rects[0].Href = @"http://www.eduworks.com";
				rects[1] = new DrawAreaRectangle(textdocument, "1cm", "1cm", "2cm", "2cm", listeners);

				// Create and add an image map, referencing the area rectangles
				ImageMap map = new ImageMap(textdocument, rects);
				frame.Content.Add(map);

				// Add the frame to the text document
				textdocument.Content.Add(frame);

				// Save the document
				textdocument.SaveTo(_framefile3);
				textdocument.Dispose();
			}
			catch (Exception ex)
			{
				//Console.Write(ex.Message);
			}
		}

		[Test(Description="Read back elements written by FrameWriteTest")]
		public void FrameTestRead()
		{
			try
			{
				TextDocument document = new TextDocument();
				document.Load(_framefile);
				Assert.IsTrue(document.Content[2].GetType() == typeof(Frame));
				Frame frame = (Frame)document.Content[2];
				Assert.IsNotNull(frame);
				document.SaveTo(_framefileSave);
			}
			catch (Exception e)
			{
				Console.WriteLine(e.Message + "\n\n" + e.StackTrace);
			}
		}

		[Test(Description="Write an image with image map; reuse event listeners")]
		public void EventListenerTest()
		{
			try
			{
				TextDocument textdocument = new TextDocument();
				textdocument.New();

				// Create a frame (GraphicName == name property of frame)
				Frame frame						= new Frame(textdocument, "frame1", "img1", _imagefile);

				// Create some event listeners (using OpenOffice friendly syntax).
				EventListener script1 = new EventListener(textdocument,
					"dom:mouseover", "javascript",
					"vnd.sun.star.script:HelloWorld.helloworld.js?language=JavaScript&location=share");
				EventListener script2 = new EventListener(textdocument,
					"dom:mouseout", "javascript",
					"vnd.sun.star.script:HelloWorld.helloworld.js?language=JavaScript&location=share");
				EventListeners listeners = new EventListeners(textdocument, new EventListener[] { script1, script2 });

				// Create and add some area rectangles; reuse event listeners
				DrawAreaRectangle[] rects = new DrawAreaRectangle[2];
				rects[0] = new DrawAreaRectangle(textdocument, "4cm", "4cm", "2cm", "2cm", listeners);
				//Reuse a clone of the EventListener
				rects[1] = new DrawAreaRectangle(textdocument, "1cm", "1cm", "2cm", "2cm", (EventListeners)listeners.Clone());

				// Create and add an image map, referencing the area rectangles
				ImageMap map = new ImageMap(textdocument, rects);
				frame.Content.Add(map);

				// Add the frame to the text document
				textdocument.Content.Add(frame);

				// Save the document
				textdocument.SaveTo(_framefile);
				textdocument.Dispose();
			}
			catch (Exception ex)
			{
				//Console.Write(ex.Message);
			}
		}

		[Test]
		public void DrawTextBox()
		{
			//New TextDocument
			TextDocument textdocument = new TextDocument();
			textdocument.New();
			//Standard Paragraph
			Paragraph paragraphOuter = new Paragraph(textdocument, ParentStyles.Standard.ToString());
			//Create Frame for DrawTextBox
			Frame frameOuter = new Frame(textdocument, "frame1");
			//Create DrawTextBox
			DrawTextBox drawTextBox = new DrawTextBox(textdocument);
			//Create a paragraph for the drawing frame
			Paragraph paragraphInner = new Paragraph(textdocument, ParentStyles.Standard.ToString());
			//Create the frame with the Illustration resp. Graphic
			Frame frameIllustration = new Frame(textdocument, "frame2", "graphic1", _imagefile);
			//Add Illustration frame to the inner Paragraph
			paragraphInner.Content.Add(frameIllustration);
			//Add inner Paragraph to the DrawTextBox
			drawTextBox.Content.Add(paragraphInner);
			//Add the DrawTextBox to the outer Frame
			frameOuter.Content.Add(drawTextBox);
			//Add the outer Frame to the outer Paragraph
			paragraphOuter.Content.Add(frameOuter);
			//Add the outer Paragraph to the TextDocument
			textdocument.Content.Add(paragraphOuter);
			//Save the document
			textdocument.SaveTo(_framefile2);
		}
	}
}

/*
 * $Log: FrameTest.cs,v $
 * Revision 1.3  2008/04/29 15:39:59  mt
 * new copyright header
 *
 * Revision 1.2  2007/08/15 11:53:17  larsbehr
 * - Optimized Mono related stuff
 *
 * Revision 1.1  2007/02/25 09:01:27  larsbehr
 * initial checkin, import from Sourceforge.net to OpenOffice.org
 *
 * Revision 1.2  2006/02/21 19:34:54  larsbm
 * - Fixed Bug text that contains a xml tag will be imported  as UnknowText and not correct displayed if document is exported  as HTML.
 * - Fixed Bug [ 1436080 ] Common styles
 *
 * Revision 1.1  2006/02/02 21:55:59  larsbm
 * - Added Clone object support for many AODL object types
 * - New Importer implementation PlainTextImporter and CsvImporter
 * - New tests
 *
 */
