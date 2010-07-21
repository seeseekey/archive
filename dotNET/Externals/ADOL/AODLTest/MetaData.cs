/*************************************************************************
 *
 * DO NOT ALTER OR REMOVE COPYRIGHT NOTICES OR THIS FILE HEADER.
 * 
 * Copyright 2008 by Sun Microsystems, Inc.
 *
 * OpenOffice.org - a multi-platform office productivity suite
 *
 * $RCSfile: MetaData.cs,v $
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
using AODL.Document.Import;
using AODL.Document.TextDocuments;
using AODL.Document.Exceptions;
using AODL.Document.Content;
using AODL.Document.Styles;

namespace AODLTest
{
	[TestFixture]
	public class MetaData
	{
		[Test]
		public void MetaDataDisplay()
		{
			TextDocument document		= null;
			try
			{
				document				= new TextDocument();
				document.Load(AARunMeFirstAndOnce.inPutFolder+"ProgrammaticControlOfMenuAndToolbarItems.odt");
			}
			catch(Exception ex)
			{
				if(ex is AODLException)
				{
					if(((AODLException)ex).OriginalException != null)
						Console.WriteLine("Org ex: {0}", ((AODLException)ex).OriginalException.Message+"\r\n"
							+((AODLException)ex).OriginalException.StackTrace);
					if(((AODLException)ex).Node != null)
						Console.WriteLine("Node: {0}", ((AODLException)ex).Node.OuterXml);
				}
				else throw ex;
			}

			Console.WriteLine(document.DocumentMetadata.InitialCreator);
			Console.WriteLine(document.DocumentMetadata.LastModified);
			Console.WriteLine(document.DocumentMetadata.CreationDate);
			Console.WriteLine(document.DocumentMetadata.CharacterCount);
			Console.WriteLine(document.DocumentMetadata.ImageCount);
			Console.WriteLine(document.DocumentMetadata.Keywords);
			Console.WriteLine(document.DocumentMetadata.Language);
			Console.WriteLine(document.DocumentMetadata.ObjectCount);
			Console.WriteLine(document.DocumentMetadata.PageCount);
			Console.WriteLine(document.DocumentMetadata.ParagraphCount);
			Console.WriteLine(document.DocumentMetadata.Subject);
			Console.WriteLine(document.DocumentMetadata.TableCount);
			Console.WriteLine(document.DocumentMetadata.Title);
			Console.WriteLine(document.DocumentMetadata.WordCount);

			document.DocumentMetadata.SetUserDefinedInfo(UserDefinedInfo.Info1, "Nothing");
			Console.WriteLine(document.DocumentMetadata.GetUserDefinedInfo(UserDefinedInfo.Info1));
		}

		public void DisplyMetaData(TextDocument document)
		{
			Console.WriteLine(document.DocumentMetadata.InitialCreator);
			Console.WriteLine(document.DocumentMetadata.LastModified);
			Console.WriteLine(document.DocumentMetadata.CreationDate);
			Console.WriteLine(document.DocumentMetadata.CharacterCount);
			Console.WriteLine(document.DocumentMetadata.ImageCount);
			Console.WriteLine(document.DocumentMetadata.Keywords);
			Console.WriteLine(document.DocumentMetadata.Language);
			Console.WriteLine(document.DocumentMetadata.ObjectCount);
			Console.WriteLine(document.DocumentMetadata.PageCount);
			Console.WriteLine(document.DocumentMetadata.ParagraphCount);
			Console.WriteLine(document.DocumentMetadata.Subject);
			Console.WriteLine(document.DocumentMetadata.TableCount);
			Console.WriteLine(document.DocumentMetadata.Title);
			Console.WriteLine(document.DocumentMetadata.WordCount);
		}
	}
}

/*
 * $Log: MetaData.cs,v $
 * Revision 1.2  2008/04/29 15:39:59  mt
 * new copyright header
 *
 * Revision 1.1  2007/02/25 09:01:27  larsbehr
 * initial checkin, import from Sourceforge.net to OpenOffice.org
 *
 * Revision 1.3  2006/01/29 19:30:24  larsbm
 * - Added app config support for NUnit tests
 *
 * Revision 1.2  2006/01/29 11:26:02  larsbm
 * - Changes for the new version. 1.2. see next changelog for details
 *
 */