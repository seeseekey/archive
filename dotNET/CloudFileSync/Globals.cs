//
//  Globals.cs
//
//  Copyright (c) 2011 by seeseekey <seeseekey@googlemail.com>
//
//  This program is free software: you can redistribute it and/or modify
//  it under the terms of the GNU General Public License as published by
//  the Free Software Foundation, either version 3 of the License, or
//  (at your option) any later version.
//
//  This program is distributed in the hope that it will be useful,
//  but WITHOUT ANY WARRANTY; without even the implied warranty of
//  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
//  GNU General Public License for more details.
//
//  You should have received a copy of the GNU General Public License
//  along with this program.  If not, see <http://www.gnu.org/licenses/>.

using System;
using System.Collections.Generic;
using System.Text;
using CSCL;

namespace CloudFileSync
{
	public class Globals
	{
		public static XmlData Options;
		public static Logger Log;

		public static string OptionsDirectory=FileSystem.ApplicationDataDirectory+".seeseekey.net\\CloudFileSync\\";
		public static string OptionsXmlFilename=OptionsDirectory+"CloudFileSync.xml";
		public static string LogFilename=OptionsDirectory+"CloudFileSync.log";

		public static string ClientID="";
	}
}
