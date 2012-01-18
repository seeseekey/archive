//
//  Version.cs
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

namespace Juliette.Graphic.TWAIN
{
	/// <summary>
	/// Represents the version of a twain driver
	/// </summary>
	[StructLayout (LayoutKind.Sequential, Pack = 2, CharSet = CharSet.Ansi)]
	internal struct Version
	{
		#region MajorNum
		/// <summary>
		/// The version of twain that is supported at max
		/// </summary>
		public short MajorNum; 
		#endregion

		#region MinorNum
		/// <summary>
		/// The version of twain that is supported at least
		/// </summary>
		public short MinorNum; 
		#endregion

		#region Language
		/// <summary>
		/// Current language of the driver
		/// </summary>
		public short Language; 
		#endregion

		#region Country
		/// <summary>
		/// Current country of the driver
		/// </summary>
		public short Country; 
		#endregion

		#region Info
		/// <summary>
		/// General info regarding the driver
		/// </summary>
		[MarshalAs (UnmanagedType.ByValTStr, SizeConst = 34)]
		public string Info; 
		#endregion
	}
}
