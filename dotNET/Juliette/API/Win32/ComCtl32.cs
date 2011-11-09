using System;
using System.Collections.Generic;
using System.Text;
using System.Runtime.InteropServices;

namespace Juliette.API.Win32
{
	static class ComCtl32
	{
		#region InitCommonControlsEx
		[DllImport("comctl32.dll")]
		public static extern bool InitCommonControlsEx(InitCommonControlsEx icc);
		#endregion

		#region GetCommonControlDLLVersion
		[DllImport("comctl32.dll", EntryPoint="DllGetVersion")]
		public extern static int GetCommonControlDLLVersion(ref DllVersionInfo dvi);
		#endregion
	}
}
