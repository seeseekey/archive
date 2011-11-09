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
