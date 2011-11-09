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
