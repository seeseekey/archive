//
//  UserInterface.cs
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
