/*************************************************************************
 *
 * DO NOT ALTER OR REMOVE COPYRIGHT NOTICES OR THIS FILE HEADER.
 * 
 * Copyright 2008 by Sun Microsystems, Inc.
 *
 * OpenOffice.org - a multi-platform office productivity suite
 *
 * $RCSfile: MastPageStylesTests.cs,v $
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
using NUnit.Framework;
using System.Xml;
using AODL.Document.Content;
using AODL.Document.Content.Tables;
using AODL.Document.TextDocuments;
using AODL.Document.Styles;
using AODL.Document.Content.Text;
using AODL.Document.Styles.MasterStyles;
using AODL.Document.Styles.Properties;
using AODL.Document.Exceptions;

namespace AODLTest
{
	/// <summary>
	/// Summary for MastPageStylesTests.
	/// </summary>
	[TestFixture]
	public class MastPageStylesTests
	{
		/// <summary>
		/// Simple check if the documents default mast page has loaded correctly.
		/// </summary>
		[Test]
		public void ImportTest1 () 
		{
			string file = AARunMeFirstAndOnce.inPutFolder+"pagestyles.odt";
			TextDocument textDocument = new TextDocument();
			textDocument.Load(file);
			TextMasterPage txtMP = textDocument.TextMasterPageCollection.GetDefaultMasterPage();
			Assert.IsNotNull(txtMP, "The default text mast page style must exists.");
		}

		/// <summary>
		/// Simple check if the documents page header has loaded correctly
		/// with associated contents.
		/// </summary>
		[Test]
		public void HeaderContentsTest()
		{
			try
			{
				string file = AARunMeFirstAndOnce.inPutFolder+"pagestyles.odt";
				TextDocument textDocument = new TextDocument();
				textDocument.Load(file);
				TextMasterPage txtMP = textDocument.TextMasterPageCollection.GetDefaultMasterPage();
				Assert.IsNotNull(txtMP.TextPageHeader, "The page header must exist.");
				Assert.IsNotNull(txtMP.TextPageHeader.ContentCollection, "Content collection must exist.");
				Assert.IsTrue(txtMP.TextPageHeader.ContentCollection.Count == 1, "There must be content in the page headers content collection.");
				Console.WriteLine("End reached ... ");
			}
			catch(Exception ex) 
			{
					if(ex is AODLException) 
				{
					Console.WriteLine(((AODLException)ex).Node.InnerText);
					Console.WriteLine(((AODLException)ex).InMethod);
				}
				Console.WriteLine(ex.Message + "\n\n" + ex.StackTrace);
			}
		}

		/// <summary>
		/// Simple check if the documents page footer has loaded correctly
		/// with associated contents.
		/// </summary>
		[Test]
		public void FooterContentsTest()
		{
			try
			{
				string file = AARunMeFirstAndOnce.inPutFolder+"pagestyles.odt";
				TextDocument textDocument = new TextDocument();
				textDocument.Load(file);
				TextMasterPage txtMP = textDocument.TextMasterPageCollection.GetDefaultMasterPage();
				Assert.IsNotNull(txtMP.TextPageFooter, "The page header must exist.");
				Assert.IsNotNull(txtMP.TextPageFooter.ContentCollection, "Content collection must exist.");
				Assert.IsTrue(txtMP.TextPageFooter.ContentCollection.Count > 0, "There must be content in the page footers content collection.");
			}
			catch(Exception ex) 
			{
				if(ex is AODLException) 
				{
					Console.WriteLine(((AODLException)ex).Node.InnerText);
					Console.WriteLine(((AODLException)ex).InMethod);
				}
				Console.WriteLine(ex.Message + "\n\n" + ex.StackTrace);
			}
		}

		/// <summary>
		/// Simple check if the documents page footer has loaded correctly
		/// and contents is accessible.
		/// </summary>
		[Test]
		public void HeaderContentsTest1() 
		{
			string file = AARunMeFirstAndOnce.inPutFolder+"pagestyles.odt";
			TextDocument textDocument = new TextDocument();
			textDocument.Load(file);
			TextMasterPage txtMP = textDocument.TextMasterPageCollection.GetDefaultMasterPage();
			txtMP.ActivatePageHeaderAndFooter();
			txtMP.TextPageHeader.MarginLeft = "4cm";
			foreach(IContent iContent in txtMP.TextPageHeader.ContentCollection)
			{
				if(iContent is Paragraph) 
				{
					Assert.IsNotNull(((Paragraph)iContent).MixedContent, "Must be mixed content available.");
					Assert.IsTrue(((Paragraph)iContent).MixedContent.Count > 0, "Must be mixed contents object inside.");
					Assert.IsTrue(((Paragraph)iContent).MixedContent[0] is SimpleText, "First IContent has to be type of SimpleText.");
					Assert.IsTrue(((Paragraph)iContent).MixedContent[1] is FormatedText, "Second IContent has to be type of FormatedText.");					
					// Change the simple text
					string changeText = "Has changed ";
					SimpleText simpleText = ((Paragraph)iContent).MixedContent[0] as SimpleText;
					simpleText.Text = changeText;
				} 
				else 
				{
					Console.WriteLine(iContent.GetType().FullName);
				}
			}

			Paragraph paragraph = ParagraphBuilder.CreateStandardTextParagraph(textDocument);
			// add one extra Paragraph
			SimpleText extraText =  new SimpleText(textDocument, "Some extra text...");
			paragraph.TextContent.Add(extraText);
			txtMP.TextPageHeader.ContentCollection.Add(paragraph);

			textDocument.DocumentStyles.Styles.Save(AARunMeFirstAndOnce.outPutFolder + "pagestyles_changed.xml");

			textDocument.SaveTo(AARunMeFirstAndOnce.outPutFolder + "pagestyles_changed.odt");
		}

		[Test]
		public void RelocateLoadedStyleTest() 
		{
			string file = AARunMeFirstAndOnce.inPutFolder+"pagestyles.odt";
			TextDocument textDocument = new TextDocument();
			textDocument.Load(file);
			TextMasterPage txtMP = textDocument.TextMasterPageCollection.GetDefaultMasterPage();
			txtMP.ActivatePageHeaderAndFooter();
			foreach(IContent iContent in txtMP.TextPageHeader.ContentCollection)
			{
				if(iContent is Paragraph) 
				{
					Assert.IsTrue(((Paragraph)iContent).MixedContent[1] is FormatedText, "Second IContent has to be type of FormatedText.");
					Assert.IsTrue(((FormatedText)((Paragraph)iContent).MixedContent[1]).Style != null, "Style must be relocated and build");
					Assert.IsTrue(((TextStyle)((FormatedText)((Paragraph)iContent).MixedContent[1]).Style).TextProperties != null, "TextPropertied must be relocated and build");
					((TextStyle)((FormatedText)((Paragraph)iContent).MixedContent[1]).Style).TextProperties.Italic = "italic";
				}
			}
			textDocument.SaveTo(AARunMeFirstAndOnce.outPutFolder+"pagestyles_changed-italic.odt");
		}

		[Test]
		public void HeaderAndFooterCreateTest()
		{
			TextDocument document = new TextDocument();
			document.New();
			// get default mast page layout
			TextMasterPage txtMP = document.TextMasterPageCollection.GetDefaultMasterPage();
			// IMPORTANT: activating header and footer usage
			// has to be called before setting there layout properties!
			txtMP.ActivatePageHeaderAndFooter();
			Console.WriteLine(txtMP.TextPageHeader.MarginLeft);
			// set page header layout
//			txtMP.TextPageHeader.MarginLeft = "4cm";
//			// set text page layout
//			txtMP.TextPageLayout.MarginLeft = "6cm";
//			// create a paragraph for the header
			Paragraph paragraph = ParagraphBuilder.CreateStandardTextParagraph(document);
			// add some formated text
			// TODO: FIXME there is a bug with the text styles for header and footer!
			FormatedText formText =  new FormatedText(document, "T1", "Some formated text in the page header ...");
			formText.TextStyle.TextProperties.Bold = "bold";
			paragraph.TextContent.Add(formText);
			// add this paragraph to the page header
			txtMP.TextPageHeader.ContentCollection.Add(paragraph);
			// create a paragraph collection with some text for the document
//			ParagraphCollection pColl = AODL.Document.Content.Text.ParagraphBuilder.CreateParagraphCollection(
//				document, 
//				"Some text in here ... \n\n... with a modified master page :)", 
//				true, 
//				ParagraphBuilder.ParagraphSeperator);
//			// add the paragraphs
//			foreach(AODL.Document.Content.Text.Paragraph p in pColl)
//				document.Content.Add(p);
			// save the document
			document.SaveTo(AARunMeFirstAndOnce.outPutFolder+"text_master_page_1.odt");
		}
	}
}
