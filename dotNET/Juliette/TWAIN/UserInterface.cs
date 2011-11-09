using System;
using System.Collections.Generic;
using System.Text;
using System.Runtime.InteropServices;

namespace Juliette.Graphic.TWAIN
{
	/// <summary>
	/// Structure used to manipulate the userinterface behaviour
	/// </summary>
	[StructLayout (LayoutKind.Sequential, Pack = 2)]
	internal class UserInterface
	{
		#region ShowUserInterface
		/// <summary>
		/// Indicates wehter the userinterface is visible of not. bool is strictly 32 bit, so use short. 
		/// </summary>
		public short ShowUserInterface; 
		#endregion

		#region ModalUserInterface
		/// <summary>
		/// Indicates wehter the userinterface is modal or not
		/// </summary>
		public short ModalUserInterface; 
		#endregion

		#region ParentHandle
		/// <summary>
		/// Handle to the parent window
		/// </summary>
		public IntPtr ParentHandle; 
		#endregion
	}
}
