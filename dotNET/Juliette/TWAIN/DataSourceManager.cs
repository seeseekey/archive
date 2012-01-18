//
//  DataSourceManager.cs
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

namespace Juliette.Graphic.TWAIN
{
	internal class DataSourceManager
	{
		#region Identity
		/// <summary>
		/// Identity of the data source manager normally a description of the application instance
		/// </summary>
		internal Identity Identity; 
		#endregion

		#region CountryUsa
		/// <summary>
		/// Countrycode for the USA
		/// </summary>
		private const short countryUsa = 1; 
		#endregion
		
		#region LanguageUsa
		/// <summary>
		/// LanguageCode for the USA
		/// </summary>
		private const short languageUsa = 13; 
		#endregion
		
		#region ParentWindowHandle
		/// <summary>
		/// Handle to the parent window of the twain data source user interfaces
		/// </summary>
		private IntPtr parentWindowHandle; 
		#endregion

		#region IsOpen
		private bool isOpen;
		/// <summary>
		/// Indicates wehter the data source manager is open or not
		/// </summary>
		public bool IsOpen
		{
			get
			{
				return isOpen;
			}
		} 
		#endregion


		#region DataSourceManager
		/// <summary>
		/// Constructor
		/// </summary>
		internal DataSourceManager ()
		{
			this.Identity = new Identity ();

			Identity = new Identity ();
			Identity.Id = IntPtr.Zero;
			Identity.Version.MajorNum = 1;
			Identity.Version.MinorNum = 1;
			Identity.Version.Language = languageUsa;
			Identity.Version.Country = countryUsa;
			Identity.Version.Info = "everyday Solutions";
			Identity.ProtocolMajor = Protocols.Major;
			Identity.ProtocolMinor = Protocols.Minor;
			Identity.SupportedGroups = (int) (DataGroups.Image | DataGroups.Control);
			Identity.Manufacturer = "everyday Solutions";
			Identity.ProductFamily = "everyday Solutions";
			Identity.ProductName = "everyday Solutions";
		} 
		#endregion

		#region Open
		/// <summary>
		/// Opens the data source manager for the current application
		/// </summary>
		/// <param name="parentWindowHandle"></param>
		/// <returns></returns>
		internal ReturnCodes Open (ref IntPtr parentWindowHandle)
		{
			ReturnCodes result = Twain32.OpenDataSourceManager (this.Identity, ref parentWindowHandle);

			if (
					result == ReturnCodes.Success &&
					this.Identity.Id != IntPtr.Zero
				)
			{
				this.parentWindowHandle = parentWindowHandle;
				this.isOpen = true;
			}

			return result;
		} 
		#endregion

		#region Close
		/// <summary>
		/// Closes the datasourcemanager for the current application
		/// </summary>
		/// <returns></returns>
		internal ReturnCodes Close ()
		{
			ReturnCodes result = ReturnCodes.Success;

			if (IsOpen)
			{
				result = Twain32.CloseDataSourceManager (this.Identity, ref this.parentWindowHandle);
			}

			this.Identity.Id = IntPtr.Zero;

			return result;
		} 
		#endregion
	}
}
