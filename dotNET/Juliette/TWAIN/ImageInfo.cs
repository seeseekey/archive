//
//  ImageInfo.cs
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
	#region ImageInfo
	internal class ImageInfo
	{
		#region DataSourceManager
		/// <summary>
		/// Datasourcemanager controlling the current session
		/// </summary>
		private DataSourceManager dataSourceManager;
		#endregion

		#region DataSource
		/// <summary>
		/// Datasource from which to auqire images
		/// </summary>
		private DataSource dataSource;
		#endregion

		#region InteropStruct
		private ImageInfoInterop interopStruct;
		/// <summary>
		/// Datastructure to communicate with the twain driver
		/// </summary>
		internal ImageInfoInterop InteropStruct
		{
			get
			{
				return interopStruct;
			}
			set
			{
				interopStruct = value;
			}
		}
		#endregion


		#region ImageInfo
		/// <summary>
		/// Constructor taking datasourcemanager of the current session and the datasource from which to auqire
		/// </summary>
		/// <param name="dataSourceManager"></param>
		/// <param name="dataSource"></param>
		internal ImageInfo (DataSourceManager dataSourceManager, DataSource dataSource)
		{
			this.dataSourceManager = dataSourceManager;
			this.dataSource = dataSource;
			this.interopStruct = new ImageInfoInterop ();
		}
		#endregion

		#region Get
		/// <summary>
		/// Received the data of a pending xfer
		/// </summary>
		/// <returns></returns>
		internal ReturnCodes Get ()
		{
			return Twain32.GetImageInfo (dataSourceManager.Identity, dataSource.Identity, ref this.interopStruct);
		}
		#endregion
	}
	#endregion

	/// <summary>
	/// Structure that is used to communicate with a twain driver
	/// </summary>
	[StructLayout (LayoutKind.Sequential, Pack = 2)]
	internal class ImageInfoInterop
	{
		#region XResolution
		/// <summary>
		/// x-Resolutions of the image
		/// </summary>
		public int XResolution; 
		#endregion

		#region YResolution
		/// <summary>
		/// y-Resolution of the image
		/// </summary>
		public int YResolution; 
		#endregion

		#region ImageWidth
		/// <summary>
		/// Width of the image
		/// </summary>
		public int ImageWidth; 
		#endregion

		#region ImageLength
		/// <summary>
		/// Height of the image
		/// </summary>
		public int ImageLength; 
		#endregion

		#region SamplesPerPixel
		/// <summary>
		/// Samples per pixel
		/// </summary>
		public short SamplesPerPixel; 
		#endregion

		#region BitsPerSample
		/// <summary>
		/// Bits per sample
		/// </summary>
		[MarshalAs (UnmanagedType.ByValArray, SizeConst = 8)]
		public short[] BitsPerSample; 
		#endregion

		#region BitsPerPixel
		/// <summary>
		/// Color depth per pixel
		/// </summary>
		public short BitsPerPixel; 
		#endregion

		#region Planar
		/// <summary>
		/// 
		/// </summary>
		public short Planar; 
		#endregion

		#region PixelType
		/// <summary>
		/// 
		/// </summary>
		public short PixelType; 
		#endregion

		#region Compression
		/// <summary>
		/// Type of compression used
		/// </summary>
		public short Compression; 
		#endregion
	}
}
