//
//  Capability.cs
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
using Juliette.API.Win32;

namespace Juliette.Graphic.TWAIN
{
	/// <summary>
	/// Represents one capabilty of a twain source
	/// </summary>
	[StructLayout (LayoutKind.Sequential, Pack = 2)]
	internal class Capability
	{
		#region CapabilityType
		/// <summary>
		/// Type of capability
		/// </summary>
		public short CapabilityType; 
		#endregion

		#region ItemType
		/// <summary>
		/// Type of the datastructure the handle is pointing at
		/// </summary>
		public short ItemType; 
		#endregion

		#region Handle
		/// <summary>
		/// Handle to a structure that contains the data of the capabilty
		/// </summary>
		public IntPtr Handle; 
		#endregion

		#region DataSourceManager
		/// <summary>
		/// data source manager controlling the twain interface for the current session
		/// </summary>
		private DataSourceManager dataSourceManager; 
		#endregion

		#region DataSource
		/// <summary>
		/// Currently choosen data source
		/// </summary>
		private DataSource dataSource; 
		#endregion

		#region Capability
		/// <summary>
		/// Constructor taking arguments necessary to initialize the capability
		/// </summary>
		/// <param name="dataSourceManager">data source manager controlling the current session</param>
		/// <param name="dataSource">data source from which to aquire</param>
		/// <param name="cap">The capability which shall be represented by the object</param>
		public Capability (DataSourceManager dataSourceManager, DataSource dataSource, Capabilities cap)
		{
			this.CapabilityType = (short) cap;
			this.ItemType = -1;

			this.dataSourceManager = dataSourceManager;
			this.dataSource = dataSource;
		}
		#endregion

		#region Capability
		/// <summary>
		/// Constructor taking arguments necessary to initialize the capability
		/// </summary>
		/// <param name="dataSourceManager">data source manager controlling the current session</param>
		/// <param name="dataSource">data source from which to aquire</param>
		/// <param name="cap">The capability which shall be represented by the object</param>
		/// <param name="sval">Value of the capability</param>
		public Capability (DataSourceManager dataSourceManager, DataSource dataSource, Capabilities cap, short sval)
		{
			CapabilityType = (short) cap;
			ItemType = (short) ContainerTypes.One;
			Handle = Kernel32.GlobalAlloc (0x42, 6);
			IntPtr pv = Kernel32.GlobalLock (Handle);
			Marshal.WriteInt16 (pv, 0, (short) ItemTypes.Int16);
			Marshal.WriteInt32 (pv, 2, (int) sval);
			Kernel32.GlobalUnlock (Handle);

			this.dataSourceManager = dataSourceManager;
			this.dataSource = dataSource;
		} 
		#endregion

		#region ~Capability
		/// <summary>
		/// Destructor
		/// </summary>
		~Capability ()
		{
			if (Handle != IntPtr.Zero)
			{
				Kernel32.GlobalFree (Handle);
			}
		} 
		#endregion

		#region Set
		/// <summary>
		/// Sets the capability represented by the object to the associated data source
		/// </summary>
		/// <returns></returns>
		internal ReturnCodes Set ()
		{
			return Twain32.SetCapability (this.dataSourceManager.Identity, this.dataSource.Identity, this);
		}
		#endregion
	}
}
