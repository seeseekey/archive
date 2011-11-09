using System;
using System.Collections.Generic;
using System.Text;
using System.Runtime.InteropServices;

namespace Juliette.API.Win32
{
	public class Kernel32
	{
		#region GlobalAlloc
		[DllImport("kernel32.dll", ExactSpelling=true)]
		public static extern IntPtr GlobalAlloc(int flags, int size);
		#endregion

		#region GlobalLock
		[DllImport("kernel32.dll", ExactSpelling=true)]
		public static extern IntPtr GlobalLock(IntPtr handle);
		#endregion

		#region GlobalUnlock
		[DllImport("kernel32.dll", ExactSpelling=true)]
		public static extern bool GlobalUnlock(IntPtr handle);
		#endregion

		#region GlobalFree
		[DllImport("kernel32.dll", ExactSpelling=true)]
		public static extern IntPtr GlobalFree(IntPtr handle);
		#endregion

		#region GetCurrentThreadId
		[DllImport("kernel32.dll", ExactSpelling=true)]
		public static extern int GetCurrentThreadId();
		#endregion

		#region GetLastError
		[DllImport("kernel32.dll", ExactSpelling=true)]
		public static extern int GetLastError();
		#endregion
	}
}
