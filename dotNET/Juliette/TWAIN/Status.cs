using System;
using System.Collections.Generic;
using System.Text;
using System.Runtime.InteropServices;

namespace Juliette.Graphic.TWAIN
{
	/// <summary>
	/// Structure to ask the twain driver for the statusReply of the datasourcemanager or a datasource
	/// </summary>
	[StructLayout (LayoutKind.Sequential, Pack = 2)]
	internal class Status
	{
		#region ConditionCode
		/// <summary>
		/// Reply containing the statusReply of the dataourcemanager/datasource
		/// </summary>
		public short ConditionCode; 
		#endregion

		#region Reserved
		/// <summary>
		/// Reserved
		/// </summary>
		public short Reserved; 
		#endregion
	}
}
