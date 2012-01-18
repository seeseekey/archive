//
//  Kernel32.cs
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
