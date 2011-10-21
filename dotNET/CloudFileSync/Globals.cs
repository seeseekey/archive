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
