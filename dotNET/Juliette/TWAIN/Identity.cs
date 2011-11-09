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
