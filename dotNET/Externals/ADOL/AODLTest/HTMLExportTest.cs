/*************************************************************************
 *
 * DO NOT ALTER OR REMOVE COPYRIGHT NOTICES OR THIS FILE HEADER.
 * 
 * Copyright 2008 by Sun Microsystems, Inc.
 *
 * OpenOffice.org - a multi-platform office productivity suite
 *
 * $RCSfile: HTMLExportTest.cs,v $
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
using NUnit.Framework;
using AODL.Document.TextDocuments;
using AODL.Document.SpreadsheetDocuments;

namespace AODLTest
{
	[TestFixture]
	public class HTMLExportTest
	{
		[Test]
		public void HTMLExportTest1()
		{
			string file							= AARunMeFirstAndOnce.inPutFolder+@"hallo.odt";
			FileInfo fInfo						= new FileInfo(file);
			//Load a text document 
			TextDocument textDocument			= new TextDocument();
			textDocument.Load(file);
			//Save it back again
			textDocument.SaveTo(AARunMeFirstAndOnce.outPutFolder+fInfo.Name+".html");
		}

		[Test]
		public void HTMLExportTest2()
		{	
			string file							= AARunMeFirstAndOnce.inPutFolder+@"OpenOffice.net.odt";
			FileInfo fInfo						= new FileInfo(file);
			//Load a text document 
			TextDocument textDocument			= new TextDocument();
			textDocument.Load(file);
			//Save it back again
			textDocument.SaveTo(AARunMeFirstAndOnce.outPutFolder+fInfo.Name+".html");
		}

		[Test]
		public void HTMLExportTest3()
		{	
			string file							= AARunMeFirstAndOnce.inPutFolder+@"simpleCalc.ods";
			FileInfo fInfo						= new FileInfo(file);
			//Load a spreadsheet document 
			SpreadsheetDocument document		= new SpreadsheetDocument();
			document.Load(file);
			//Save it back again
			document.SaveTo(AARunMeFirstAndOnce.outPutFolder+fInfo.Name+".html");
		}

		[Test]
		public void HTMLExportTestImageMap()
		{	
			string file							= AARunMeFirstAndOnce.inPutFolder+@"imgmap.odt";
			FileInfo fInfo						= new FileInfo(file);
			//Load a text document 
			TextDocument textDocument			= new TextDocument();
			textDocument.Load(file);
			//Save it back again
			textDocument.SaveTo(AARunMeFirstAndOnce.outPutFolder+fInfo.Name+".html");
		}

		[Test]
		public void HTMLExportTestDocumentConvertedFromOpenOfficeXmlToOpenDocumentXml()
		{	
			string file							= AARunMeFirstAndOnce.inPutFolder+@"ProgrammaticControlOfMenuAndToolbarItems.odt";
			FileInfo fInfo						= new FileInfo(file);
			//Load a text document 
			TextDocument textDocument			= new TextDocument();
			textDocument.Load(file);
			//Save it back again
			textDocument.SaveTo(AARunMeFirstAndOnce.outPutFolder+fInfo.Name+".html");
		}
	}
}

/*
 * $Log: HTMLExportTest.cs,v $
 * Revision 1.2  2008/04/29 15:39:59  mt
 * new copyright header
 *
 * Revision 1.1  2007/02/25 09:01:27  larsbehr
 * initial checkin, import from Sourceforge.net to OpenOffice.org
 *
 * Revision 1.3  2006/02/05 20:02:24  larsbm
 * - Fixed several bugs
 * - clean up some messy code
 *
 * Revision 1.2  2006/01/29 19:30:24  larsbm
 * - Added app config support for NUnit tests
 *
 * Revision 1.1  2006/01/29 11:26:02  larsbm
 * - Changes for the new version. 1.2. see next changelog for details
 *
 */