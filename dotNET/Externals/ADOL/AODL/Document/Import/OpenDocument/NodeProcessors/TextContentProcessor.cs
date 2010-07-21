/*************************************************************************
 *
 * DO NOT ALTER OR REMOVE COPYRIGHT NOTICES OR THIS FILE HEADER.
 * 
 * Copyright 2008 by Sun Microsystems, Inc.
 *
 * OpenOffice.org - a multi-platform office productivity suite
 *
 * $RCSfile: TextContentProcessor.cs,v $
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

using System;
using System.Collections;
using System.Diagnostics;
using System.Xml;
using System.Text.RegularExpressions;
using AODL.Document;
using AODL.Document.Styles;
using AODL.Document.Exceptions;
using AODL.Document.Content;
using AODL.Document.Content.Text;
using AODL.Document.Content.Text.Indexes;
using AODL.Document.Content.Text.TextControl;

namespace AODL.Document.Import.OpenDocument.NodeProcessors
{
	/// <summary>
	/// Represent a Text Content Processor.
	/// </summary>
	public class TextContentProcessor
	{
		/// <summary>
		/// Warning delegate
		/// </summary>
		public delegate void Warning(AODLWarning warning);
		/// <summary>
		/// OnWarning event fired if something unexpected
		/// occour.
		/// </summary>
		public static event Warning OnWarning;

		/// <summary>
		/// Initializes a new instance of the <see cref="TextContentProcessor"/> class.
		/// </summary>
		public TextContentProcessor()
		{
		}

		/// <summary>
		/// Creates the text object.
		/// </summary>
		/// <param name="document">The document.</param>
		/// <param name="aTextNode">A text node.</param>
		/// <returns></returns>
		public IText CreateTextObject(IDocument document, XmlNode aTextNode)
		{
			//aTextNode.InnerText				= this.ReplaceSpecialCharacter(aTextNode.InnerText);
			int i=0;				
			if(aTextNode.OuterXml.IndexOf("Contains state ") > -1)
				i++;

			switch(aTextNode.Name)
			{
				case "#text":
					return new SimpleText(document, aTextNode.InnerText);
				case "text:span":
					return CreateFormatedText(document, aTextNode);
				case "text:bookmark":
					return CreateBookmark(document, aTextNode , BookmarkType.Standard);
				case "text:bookmark-start":
					return CreateBookmark(document, aTextNode , BookmarkType.Start);
				case "text:bookmark-end":
					return CreateBookmark(document, aTextNode , BookmarkType.End);
				case "text:a":
					return CreateXLink(document, aTextNode);
				case "text:note":
					return CreateFootnote(document, aTextNode);
				case "text:line-break":
					return new LineBreak(document);
				case "text:s":
					return new WhiteSpace(document, aTextNode.CloneNode(true));
				case "text:tab":
					return new TabStop(document);
				default:
					return null;
			}					
		}
		
		/// <summary>
		/// Creates the formated text.
		/// </summary>
		/// <param name="document">The document.</param>
		/// <param name="node">The node.</param>
		/// <returns></returns>
		public FormatedText CreateFormatedText(IDocument document, XmlNode node)
		{
			try
			{
				//Create a new FormatedText object
				FormatedText formatedText		= new FormatedText(document, node);
				ITextCollection iTextColl		= new ITextCollection();
				formatedText.Document			= document;
				formatedText.Node				= node;
				//Recieve a TextStyle
				
				IStyle textStyle				= document.Styles.GetStyleByName(formatedText.StyleName);

				if(textStyle != null)
					formatedText.Style			= textStyle;
				else
				{
					IStyle iStyle				= document.CommonStyles.GetStyleByName(formatedText.StyleName);
					if(iStyle == null)
					{
						if(OnWarning != null)
						{
							AODLWarning warning			= new AODLWarning("A TextStyle for the FormatedText object wasn't found.");
							warning.InMethod			= AODLException.GetExceptionSourceInfo(new StackFrame(1, true));
							warning.Node				= node;
							OnWarning(warning);
						}
					}
				}
				
				//Ceck for more IText object
				foreach(XmlNode iTextNode in node.ChildNodes)
				{
					IText iText						= this.CreateTextObject(document, iTextNode.CloneNode(true));
					if(iText != null)
					{
						iTextColl.Add(iText);
					}
					else
						iTextColl.Add(new UnknownTextContent(document, iTextNode) as IText);
				}

				formatedText.Node.InnerText			= "";

				foreach(IText iText in iTextColl)
					formatedText.TextContent.Add(iText);

				return formatedText;
			}
			catch(Exception ex)
			{
				throw;
			}
		}
		
		/// <summary>
		/// Creates the bookmark.
		/// </summary>
		/// <param name="document">The document.</param>
		/// <param name="node">The node.</param>
		/// <param name="type">The type.</param>
		/// <returns></returns>
		public Bookmark CreateBookmark(IDocument document,XmlNode node, BookmarkType type)
		{
			try
			{
				Bookmark bookmark		= null;
				if(type == BookmarkType.Standard)
					bookmark			= new Bookmark(document, BookmarkType.Standard, "noname");
				else if(type == BookmarkType.Start)
					bookmark			= new Bookmark(document, BookmarkType.Start, "noname");
				else
					bookmark			= new Bookmark(document, BookmarkType.End, "noname");

				bookmark.Node			= node.CloneNode(true);

				return bookmark;
			}
			catch(Exception ex)
			{
				AODLException exception		= new AODLException("Exception while trying to create a Bookmark.");
				exception.InMethod			= AODLException.GetExceptionSourceInfo(new StackFrame(1, true));
				exception.Node				= node;
				exception.OriginalException	= ex;

				throw exception;
			}
		}

		/// <summary>
		/// Creates the X link.
		/// </summary>
		/// <param name="document">The document.</param>
		/// <param name="node">The node.</param>
		/// <returns></returns>
		public XLink CreateXLink(IDocument document, XmlNode node)
		{
			try
			{
				XLink xlink				= new XLink(document);
				xlink.Node				= node.CloneNode(true);
				ITextCollection iTxtCol	= new ITextCollection();

				foreach(XmlNode nodeText in xlink.Node.ChildNodes)
				{
					IText iText			= this.CreateTextObject(xlink.Document, nodeText);
					if(iText != null)
						iTxtCol.Add(iText);
				}

				xlink.Node.InnerXml		= "";

				foreach(IText iText in iTxtCol)
					xlink.TextContent.Add(iText);

				return xlink;
			}
			catch(Exception ex)
			{
				AODLException exception		= new AODLException("Exception while trying to create a XLink.");
				exception.InMethod			= AODLException.GetExceptionSourceInfo(new StackFrame(1, true));
				exception.Node				= node;
				exception.OriginalException	= ex;

				throw exception;
			}
		}

		/// <summary>
		/// Creates the footnote.
		/// </summary>
		/// <param name="document">The document.</param>
		/// <param name="node">The node.</param>
		/// <returns></returns>
		public Footnote CreateFootnote(IDocument document,XmlNode node)
		{
			try
			{
				Footnote fnote			= new Footnote(document);
				fnote.Node				= node.CloneNode(true);

				return fnote;
			}
			catch(Exception ex)
			{
				AODLException exception		= new AODLException("Exception while trying to create a Footnote.");
				exception.InMethod			= AODLException.GetExceptionSourceInfo(new StackFrame(1, true));
				exception.Node				= node;
				exception.OriginalException	= ex;

				throw exception;
			}
		}

		/// <summary>
		/// Creates the text sequence.
		/// </summary>
		/// <param name="document">The document.</param>
		/// <param name="node">The node.</param>
		/// <returns></returns>
		public TextSequence CreateTextSequence(IDocument document, XmlNode node)
		{
			try
			{
				TextSequence textSequence	= new TextSequence(document, node);

				return textSequence;
			}
			catch(Exception ex)
			{
				AODLException exception		= new AODLException("Exception while trying to create a TextSequence.");
				exception.InMethod			= AODLException.GetExceptionSourceInfo(new StackFrame(1, true));
				exception.Node				= node;
				exception.OriginalException	= ex;

				throw exception;
			}
		}

		/// <summary>
		/// Replaces the special character.
		/// </summary>
		/// <param name="nodeInnerText">The node inner text.</param>
		/// <returns></returns>
		private string ReplaceSpecialCharacter(string nodeInnerText)
		{
			nodeInnerText					= nodeInnerText.Replace("<", "&lt;");
			nodeInnerText					= nodeInnerText.Replace(">", "&gt;");

			return nodeInnerText;
		}
	}
}
