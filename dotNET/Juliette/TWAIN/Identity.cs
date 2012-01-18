//
//  Identity.cs
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
	/// Represents the identity of a data source or an application
	/// </summary>
	[StructLayout (LayoutKind.Sequential, Pack = 2, CharSet = CharSet.Ansi)]
	internal class Identity
	{
		#region Id
		/// <summary>
		/// Unique id for the datasource/application. If IntPtr.Zero the identity does not exist
		/// </summary>
		public IntPtr Id; 
		#endregion

		#region Version
		/// <summary>
		/// Version
		/// </summary>
		public Version Version; 
		#endregion

		#region ProtocolMajor
		/// <summary>
		/// Protocolversion that is supported maximal
		/// </summary>
		public short ProtocolMajor; 
		#endregion

		#region ProtocolMinor
		/// <summary>
		/// Protocolversion that is supported at least
		/// </summary>
		public short ProtocolMinor; 
		#endregion

		#region SupportedGroups
		/// <summary>
		/// Datagroups supported by the datasource/application.
		/// </summary>
		public int SupportedGroups; 
		#endregion

		#region Manufacturer
		/// <summary>
		/// Manufacturer of the datasource/application
		/// </summary>
		[MarshalAs (UnmanagedType.ByValTStr, SizeConst = 34)]
		public string Manufacturer; 
		#endregion

		#region ProductFamily
		/// <summary>
		/// Productfamily
		/// </summary>
		[MarshalAs (UnmanagedType.ByValTStr, SizeConst = 34)]
		public string ProductFamily; 
		#endregion

		#region ProductName
		/// <summary>
		/// Priductname
		/// </summary>
		[MarshalAs (UnmanagedType.ByValTStr, SizeConst = 34)]
		public string ProductName; 
		#endregion
	}
}
