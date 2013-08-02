/*************************************************************************
 *
 * DO NOT ALTER OR REMOVE COPYRIGHT NOTICES OR THIS FILE HEADER.
 * 
 * Copyright 2008 by Sun Microsystems, Inc.
 *
 * OpenOffice.org - a multi-platform office productivity suite
 *
 * $RCSfile: TextBuilder.cs,v $
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
using System.Xml;
using AODL.Document;
using AODL.Document.Content.Text.TextControl;

namespace AODL.Document.Content.Text
{
	/// <summary>
	/// TextBuilder use this class to build TextCollection from
	/// text that contains text control character like whitespaces,
	/// tab stops and line breaks.
	/// </summary>
	public class TextBuilder
	{
		/// <summary>
		/// Builds the text collection.
		/// </summary>
		/// <param name="document">The document.</param>
		/// <param name="text">The text.</param>
		/// <returns></returns>
		public static ITextCollection BuildTextCollection(IDocument document, string text)
		{
			string xmlStartTag				= "<?xml version=\"1.0\" encoding=\"UTF-8\" ?>";
			ITextCollection txtCollection	= new ITextCollection();
			text							= WhiteSpaceHelper.GetWhiteSpaceXml(text);
			text							= text.Replace("\t", "<t/>");
			text							= text.Replace("\n", "<n/>");
			xmlStartTag						+= "<txt>"+text+"</txt>";

			XmlDocument xmlDoc				= new XmlDocument();
			xmlDoc.LoadXml(xmlStartTag);

			XmlNode nodeStart				= xmlDoc.DocumentElement;
			if(nodeStart != null)
				if(nodeStart.HasChildNodes)
				{
					foreach(XmlNode childNode in nodeStart.ChildNodes)
					{
						if(childNode.NodeType == XmlNodeType.Text)
							txtCollection.Add(new SimpleText(document, childNode.InnerText));
						else if(childNode.Name == "ws")
						{
							if(childNode.Attributes.Count == 1)
							{
								XmlNode nodeCnt = childNode.Attributes.GetNamedItem("id");
								if(nodeCnt != null)
									txtCollection.Add(new WhiteSpace(document, Convert.ToInt32(nodeCnt.InnerText)));
							}
						}
						else if(childNode.Name == "t")
						{
							txtCollection.Add(new TabStop(document));
						}
						else if(childNode.Name == "n")
						{
							txtCollection.Add(new LineBreak(document));
						}
					}
				}
				else
				{
					txtCollection.Add(new SimpleText(document, text));
				}
			return txtCollection;
		}
	}
}
