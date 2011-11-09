using System;
using System.Collections.Generic;
using System.Drawing;
using System.Text;
using System.Runtime.InteropServices;

namespace Juliette.API.Win32
{
	public class Gdi32
	{
		#region GetDeviceCaps
		/// <summary>
		/// The GetDeviceCaps function retrieves device-specific information for the specified device.
		/// </summary>
		/// <param name="deviceContextPointer">Handle to the DC.</param>
		/// <param name="index">Specifies the item to return. This parameter can be one of the following values.</param>
		/// <returns>Specifies the item to return. This parameter can be one of the following values. When nIndex is BITSPIXEL and the device has 15bpp or 16bpp, the return value is 16.</returns>
		[DllImport("gdi32.dll", ExactSpelling=true)]
		public static extern int GetDeviceCaps(IntPtr deviceContextPointer, int index);
		#endregion

		#region CreateDC
		/// <summary>
		/// The CreateDC function creates a device context (DC) for a device using the specified name.
		/// </summary>
		/// <param name="driverName">Pointer to a null-terminated character string that specifies either DISPLAY or the name of a specific display device or the name of a print provider, which is usually WINSPOOL.</param>
		/// <param name="deviceName">Pointer to a null-terminated character string that specifies the name of the specific output device being used, as shown by the Print Manager (for example, Epson FX-80). It is not the printer model name. The lpszDevice parameter must be used.</param>
		/// <param name="notUsed">This parameter is ignored and should be set to NULL. It is provided only for compatibility with 16-bit Windows.</param>
		/// <param name="optionalPrinterData">Pointer to a DEVMODE structure containing device-specific initialization data for the device driver. The DocumentProperties function retrieves this structure filled in for a specified device. The lpInitData parameter must be NULL if the device driver is to use the default initialization (if any) specified by the user.</param>
		/// <returns>If the function succeeds, the return value is the handle to a DC for the specified device. If the function fails, the return value is NULL. The function will return NULL for a DEVMODE structure other than the current DEVMODE.</returns>
		[DllImport("gdi32.dll", CharSet=CharSet.Auto)]
		public static extern IntPtr CreateDC(string driverName, string deviceName, string notUsed, IntPtr optionalPrinterData);
		#endregion

		#region DeleteDC
		/// <summary>
		/// The DeleteDC function deletes the specified device context (DC).
		/// </summary>
		/// <param name="deviceContextPointer">Handle to the device context.</param>
		/// <returns>If the function succeeds, the return value is nonzero. If the function fails, the return value is zero.</returns>
		[DllImport("gdi32.dll", ExactSpelling=true)]
		public static extern bool DeleteDC(IntPtr deviceContextPointer);
		#endregion

		#region CreateCompatibleDC
		/// <summary>
		/// The CreateCompatibleDC function creates a memory device context (DC) compatible with the specified device.
		/// </summary>
		/// <param name="deviceContextPointer">Handle to an existing DC. If this handle is NULL, the function creates a memory DC compatible with the application's current screen.</param>
		/// <returns>If the function succeeds, the return value is the handle to a memory DC. If the function fails, the return value is NULL.</returns>
		[DllImport("gdi32.dll", ExactSpelling=true)]
		public static extern IntPtr CreateCompatibleDC(IntPtr deviceContextPointer);
		#endregion

		#region CreateCompatibleBitmap
		/// <summary>
		/// The CreateCompatibleBitmap function creates a bitmap compatible with the device that is associated with the specified device context.
		/// </summary>
		/// <param name="deviceContextPointer">Handle to a device context.</param>
		/// <param name="width">Specifies the bitmap width, in pixels.</param>
		/// <param name="height">Specifies the bitmap height, in pixels.</param>
		/// <returns>If the function succeeds, the return value is a handle to the compatible bitmap (DDB). If the function fails, the return value is NULL.</returns>
		[DllImport("gdi32.dll", ExactSpelling=true)]
		public static extern IntPtr CreateCompatibleBitmap(IntPtr deviceContextPointer, int width, int height);
		#endregion

		#region SelectObject
		/// <summary>
		/// The SelectObject function selects an object into the specified device context (DC). The new object replaces the previous object of the same type.
		/// </summary>
		/// <param name="deviceContextPointer">Handle to the DC.</param>
		/// <param name="objectPointer">Handle to the object to be selected. The specified object must have been created by using one of the following functions.</param>
		/// <returns>If the selected object is not a region and the function succeeds, the return value is a handle to the object being replaced. If the selected object is a region and the function succeeds, the return value is one of the following values. If an error occurs and the selected object is not a region, the return value is NULL. Otherwise, it is HGDI_ERROR.</returns>
		[DllImport("gdi32.dll", ExactSpelling=true)]
		public static extern IntPtr SelectObject(IntPtr deviceContextPointer, IntPtr objectPointer);
		#endregion

		#region GetObject
		/// <summary>
		/// 
		/// </summary>
		/// <param name="hgdiObject"></param>
		/// <param name="cbBuffer"></param>
		/// <param name="result"></param>
		/// <returns></returns>
		/// <update author="Tobias Mundt" date="2006-05-10">Created</update>
		[DllImport("gdi32.dll", EntryPoint="GetObjectA")]
		public static extern IntPtr GetObject(
			IntPtr hgdiObject,
			int cbBuffer,
			IntPtr result);
		#endregion

		#region DeleteObject
		/// <summary>
		/// The DeleteObject function deletes a logical pen, brush, font, bitmap, region, or palette, freeing all system resources associated with the object. After the object is deleted, the specified handle is no longer valid.
		/// </summary>
		/// <param name="objectPointer">Handle to a logical pen, brush, font, bitmap, region, or palette.</param>
		/// <returns>If the function succeeds, the return value is nonzero. If the specified handle is not valid or is currently selected into a DC, the return value is zero.</returns>
		[DllImport("gdi32.dll", ExactSpelling=true)]
		public static extern bool DeleteObject(IntPtr objectPointer);
		#endregion

		#region BitBlt
		/// <summary>
		/// The BitBlt function performs a bit-block transfer of the color data corresponding to a rectangle of pixels from the specified source device context into a destination device context.
		/// </summary>
		/// <param name="DeviceContextPointer">Handle to the destination device context.</param>
		/// <param name="DestinationX">Specifies the x-coordinate, in logical units, of the upper-left corner of the destination rectangle.</param>
		/// <param name="DestinationY">Specifies the y-coordinate, in logical units, of the upper-left corner of the destination rectangle.</param>
		/// <param name="DestinationWidth">Specifies the width, in logical units, of the source and destination rectangles.</param>
		/// <param name="DestinationHeight">Specifies the height, in logical units, of the source and the destination rectangles.</param>
		/// <param name="SourceDeviceContextPointer">Specifies the height, in logical units, of the source and the destination rectangles.</param>
		/// <param name="SourceX">Specifies the x-coordinate, in logical units, of the upper-left corner of the source rectangle.</param>
		/// <param name="SourceY">Specifies the x-coordinate, in logical units, of the upper-left corner of the source rectangle.</param>
		/// <param name="RasterOperationCode">Specifies a raster-operation code. These codes define how the color data for the source rectangle is to be combined with the color data for the destination rectangle to achieve the final color.</param>
		/// <returns>If the function succeeds, the return value is nonzero. If the function fails, the return value is zero.</returns>
		[DllImport("gdi32.dll", ExactSpelling=true)]
		public static extern bool BitBlt(
														IntPtr DestinationDeviceContextPointer,
														int DestinationX,
														int DestinationY,
														int DestinationWidth,
														int DestinationHeight,
														IntPtr SourceDeviceContextPointer,
														int SourceX,
														int SourceY,
														int RasterOperationCode
													);
		#endregion

		#region StretchDIBits
		/// <summary>
		/// The StretchDIBits function copies the color data for a rectangle of pixels in a DIB to the specified destination rectangle. If the destination rectangle is larger than the source rectangle, this function stretches the rows and columns of color data to fit the destination rectangle. If the destination rectangle is smaller than the source rectangle, this function compresses the rows and columns by using the specified raster operation.
		/// </summary>
		/// <param name="DeviceContextPointer">Handle to the destination device context.</param>
		/// <param name="DestinationX">Specifies the x-coordinate, in logical units, of the upper-left corner of the destination rectangle.</param>
		/// <param name="DestinationY">Specifies the y-coordinate, in logical units, of the upper-left corner of the destination rectangle.</param>
		/// <param name="DestinationWidth">Specifies the width, in logical units, of the destination rectangle.</param>
		/// <param name="DestinationHeight">Specifies the height, in logical units, of the destination rectangle.</param>
		/// <param name="SourceX">Specifies the x-coordinate, in pixels, of the source rectangle in the DIB.</param>
		/// <param name="SourceY">Specifies the y-coordinate, in pixels, of the source rectangle in the DIB.</param>
		/// <param name="SourceWidth">Specifies the width, in pixels, of the source rectangle in the DIB.</param>
		/// <param name="SourceHeight">Specifies the height, in pixels, of the source rectangle in the DIB.</param>
		/// <param name="BitmapBits">Pointer to the DIB bits, which are stored as an array of bytes. For more information, see the Remarks section.</param>
		/// <param name="BitmapData">Pointer to a BITMAPINFO structure that contains information about the DIB.</param>
		/// <param name="Usage">Specifies whether the bmiColors member of the BITMAPINFO structure was provided and, if so, whether bmiColors contains explicit red, green, blue (RGB) values or indexes. The iUsage parameter must be one of the following values.</param>
		/// <param name="RasterOperationCode">Specifies how the source pixels, the destination device context's current brush, and the destination pixels are to be combined to form the new image. For more information, see the following Remarks section.</param>
		/// <returns>If the function succeeds, the return value is the number of scan lines copied. If the function fails, the return value is GDI_ERROR.</returns>
		[DllImport("gdi32.dll", ExactSpelling=true)]
		public static extern int StretchDIBits(
																IntPtr DeviceContextPointer,
																int DestinationX,
																int DestinationY,
																int DestinationWidth,
																int DestinationHeight,
																int SourceX,
																int SourceY,
																int SourceWidth,
																int SourceHeight,
																IntPtr BitmapBits,
																IntPtr BitmapData,
																int Usage,
																int RasterOperationCode
															);
		#endregion

		#region GetDIBits
		/// <summary>
		/// The GetDIBits function retrieves the bits of the specified compatible bitmap and copies them into a buffer as a DIB using the specified format.
		/// </summary>
		/// <param name="DeviceContext">Handle to the device context.</param>
		/// <param name="BitmapHandle">Handle to the bitmap. This must be a compatible bitmap (DDB).</param>
		/// <param name="StartScanLine">Specifies the first scan line to retrieve.</param>
		/// <param name="ScanLines">Specifies the number of scan lines to retrieve.</param>
		/// <param name="BitmapBits">Pointer to a buffer to receive the bitmap data. If this parameter is NULL, the function passes the dimensions and format of the bitmap to the BITMAPINFO structure pointed to by the lpbi parameter.</param>
		/// <param name="BitmapInfo">Pointer to a BITMAPINFO structure that specifies the desired format for the DIB data.</param>
		/// <param name="Usage">Specifies the format of the bmiColors member of the BITMAPINFO structure. It must be one of the following values.</param>
		/// <returns>If the lpvBits parameter is non-NULL and the function succeeds, the return value is the number of scan lines copied from the bitmap.</returns>
		[DllImport("gdi32.dll")]
		public static extern Int32 GetDIBits(
			IntPtr DeviceContext,
			IntPtr BitmapHandle,
			uint StartScanLine,
			uint ScanLines,
			IntPtr BitmapBits,
			IntPtr BitmapInfo,
			ColorUse Usage);
		#endregion

		#region GetDIBits
		/// <summary>
		/// The GetDIBits function retrieves the bits of the specified compatible bitmap and copies them into a buffer as a DIB using the specified format.
		/// </summary>
		/// <param name="DeviceContext">Handle to the device context.</param>
		/// <param name="BitmapHandle">Handle to the bitmap. This must be a compatible bitmap (DDB).</param>
		/// <param name="StartScanLine">Specifies the first scan line to retrieve.</param>
		/// <param name="ScanLines">Specifies the number of scan lines to retrieve.</param>
		/// <param name="BitmapBits">Pointer to a buffer to receive the bitmap data. If this parameter is NULL, the function passes the dimensions and format of the bitmap to the BITMAPINFO structure pointed to by the lpbi parameter.</param>
		/// <param name="BitmapInfo">Pointer to a BITMAPINFO structure that specifies the desired format for the DIB data.</param>
		/// <param name="Usage">Specifies the format of the bmiColors member of the BITMAPINFO structure. It must be one of the following values.</param>
		/// <returns>If the lpvBits parameter is non-NULL and the function succeeds, the return value is the number of scan lines copied from the bitmap.</returns>
		[DllImport("gdi32.dll")]
		public static extern Int32 GetDIBits(
			IntPtr DeviceContext,
			IntPtr BitmapHandle,
			uint StartScanLine,
			uint ScanLines,
			IntPtr BitmapBits,
			ref BitmapInfo bmi,
			ColorUse Usage);
		#endregion

		#region GetPixelInfo
		/// <summary>
		/// Receives an IntPtr to the pixels of the passed Dib.
		/// </summary>
		/// <param name="dibPointer">The Device Independent Bitmap which pixels shall be received</param>
		/// <param name="BitmapRect">After the operation this object contains the dimensions of the Dib</param>
		/// <returns>Pointer to the pixels of the passed Dib</returns>
		public static IntPtr GetPixelInfo(IntPtr dibPointer, ref Rectangle bitmapRect)
		{
			BitmapInfoHeader bmi=new BitmapInfoHeader();
			Marshal.PtrToStructure(dibPointer, bmi);

			bitmapRect.X=bitmapRect.Y=0;
			bitmapRect.Width=bmi.biWidth;
			bitmapRect.Height=bmi.biHeight;

			if (bmi.biSizeImage==0)
			{
				bmi.biSizeImage=((((bmi.biWidth*bmi.biBitCount)+31)&~31)>>3)*bmi.biHeight;
			}

			int pixel=bmi.biClrUsed;
			if ((pixel==0)&&(bmi.biBitCount<=8))
			{
				pixel=1<<bmi.biBitCount;
			}
			pixel=(pixel*4)+bmi.biSize+(int)dibPointer;
			return (IntPtr)pixel;
		}
		#endregion

		#region SetICMMode
		/// <summary>
		/// The SetICMMode function causes Image Color Management to be enabled, disabled, or queried on a given device context (DC).
		/// </summary>
		/// <param name="DeviceContext">Identifies handle to the device context.</param>
		/// <param name="Mode">Turns on and off image color management. This parameter can take one of the following constant values.</param>
		/// <returns>If this function succeeds, the return value is a nonzero value. If this function fails, the return value is zero. If ICM_QUERY is specified and the function succeeds, the nonzero value returned is ICM_ON or ICM_OFF to indicate the current mode.</returns>
		[DllImport("gdi32.dll")]
		public static extern Int32 SetICMMode(
																IntPtr DeviceContext,
																ICMMode Mode
															);
		#endregion

		#region SetICMProfile
		/// <summary>
		/// The SetICMProfile function sets a specified color profile as the output profile for a specified device context (DC).
		/// </summary>
		/// <param name="DeviceContext">Specifies a device context in which to set the color profile.</param>
		/// <param name="FileName">Specifies the path name of the color profile to be set.</param>
		/// <returns>If this function succeeds, the return value is TRUE. If this function fails, the return value is FALSE.</returns>
		[DllImport("gdi32.dll")]
		public static extern Int32 SetICMProfile(
			IntPtr DeviceContext,
			string FileName);
		#endregion

		#region SetStretchBltMode
		/// <summary>
		/// The SetStretchBltMode function sets the bitmap stretching mode in the specified device context.
		/// </summary>
		/// <param name="DeviceContext">Handle to the device context.</param>
		/// <param name="Mode">Specifies the stretching mode. This parameter can be one of the following values.</param>
		/// <returns>If the function succeeds, the return value is the previous stretching mode. If the function fails, the return value is zero. </returns>
		[DllImport("gdi32.dll")]
		public static extern Int32 SetStretchBltMode(
			[In] IntPtr DeviceContext,
			[In] StretchMode Mode);
		#endregion

		#region ColorMatchToTarget
		/// <summary>
		/// The ColorMatchToTarget function enables you to preview colors as they would appear on the target device.
		/// </summary>
		/// <param name="DeviceContext">Specifies the device context for previewing, generally the screen.</param>
		/// <param name="TargetDeviceContext">Specifies the target device context, generally a printer.</param>
		/// <param name="Mode">A constant that can have one of the following values.</param>
		/// <returns></returns>
		[DllImport("gdi32.dll")]
		public static extern int ColorMatchToTarget(
			IntPtr DeviceContext,
			IntPtr TargetDeviceContext,
			ColorMatchToTargetMode Mode);
		#endregion

		#region DibToBitmap
		/// <summary>
		/// Converts a Device Independent Bitmap (Dib) to a GDI+ Image object
		/// </summary>
		/// <param name="dibPointer">Pointer to a Dib</param>
		/// <returns>Bitmap object</returns>
		public static Image DibToBitmap(IntPtr dibPointer)
		{
			//Lock the Dib in Memory and receive its size and pointers
			IntPtr bitmapPointer=Kernel32.GlobalLock(dibPointer);
			Rectangle bitmapRectangle=new Rectangle(0, 0, 0, 0);
			IntPtr pixelPointer=GetPixelInfo(bitmapPointer, ref bitmapRectangle);

			//Create new bitmap
			System.Drawing.Bitmap newBitmap=new System.Drawing.Bitmap(bitmapRectangle.Width, bitmapRectangle.Height); //Malfläche
			IntPtr newBitmapPointer=newBitmap.GetHbitmap();

			//Prepare the device context
			IntPtr deviceContext=Gdi32.CreateCompatibleDC(IntPtr.Zero);
			IntPtr oldBitmapPointer=Gdi32.SelectObject(deviceContext, newBitmapPointer);

			//Transfer the Dib to the deviceContextPointer and the newBitmapPointer
			Gdi32.StretchDIBits(
											deviceContext,
											0,
											0,
											bitmapRectangle.Width,
											bitmapRectangle.Height,
											0,
											0,
											bitmapRectangle.Width,
											bitmapRectangle.Height,
											pixelPointer,
											bitmapPointer,
											0,
											(int)RasterOperationCode.SourceCopy
										);

			System.Drawing.Bitmap result=System.Drawing.Image.FromHbitmap(newBitmapPointer);

			//Tidy up 
			Gdi32.SelectObject(deviceContext, oldBitmapPointer);
			Gdi32.DeleteObject(oldBitmapPointer);
			Gdi32.DeleteDC(deviceContext);
			Gdi32.DeleteObject(newBitmapPointer);
			Kernel32.GlobalFree(bitmapPointer);
			Kernel32.GlobalFree(pixelPointer);

			return result;
		}
		#endregion

		#region ImageToDib
		/// <summary>
		/// Converts a GDI+ image to a Device Independent Bitmap. 
		/// </summary>
		/// <param name="image">The image that shall be converted</param>
		/// <param name="bitmapInfoPointer">Pointer to the BitmapInfo Structure of the Dib</param>
		/// <param name="bitmapBitsPointer">Pointer to the pixel of the Dib</param>
		public static void ImageToDib(
			Image image,
			ref IntPtr bitmapInfoPointer,
			ref IntPtr bitmapBitsPointer)
		{
			if (image!=null)
			{
				//Get device context and bitmap handle
				IntPtr compatibleDC=CreateCompatibleDC(IntPtr.Zero);
				IntPtr bitmapHandle=new System.Drawing.Bitmap(image).GetHbitmap();

				//Receive BitmapInfo from image
				BitmapInfo bitmapInfo=new BitmapInfo();

				bitmapInfoPointer=Marshal.AllocHGlobal(Marshal.SizeOf(bitmapInfo));

				Marshal.StructureToPtr(
					bitmapInfo,
					bitmapInfoPointer, true);

				Gdi32.GetDIBits(
					compatibleDC,
					bitmapHandle,
					0,
					0,
					IntPtr.Zero,
					bitmapInfoPointer,
					ColorUse.DibRGBColors);

				Marshal.PtrToStructure(
					bitmapInfoPointer,
					bitmapInfo);

				//Allocate memory for the bitmapbits and receive them
				Int32 s=((((bitmapInfo.bmiHeader.biWidth*bitmapInfo.bmiHeader.biBitCount)+31)/32)*4)*
						System.Math.Abs(bitmapInfo.bmiHeader.biHeight);

				bitmapBitsPointer=Marshal.AllocHGlobal(bitmapInfo.bmiHeader.biSizeImage+1024);

				Gdi32.GetDIBits(
					compatibleDC,
					bitmapHandle,
					0,
					(uint)image.Height,
					bitmapBitsPointer,
					bitmapInfoPointer,
					ColorUse.DibRGBColors);

				//Tidy up
				Gdi32.DeleteObject(bitmapHandle);
				Gdi32.DeleteDC(compatibleDC);
			}
		}
		#endregion

		#region PerformColorMatching
		/// <summary>
		/// Transforms the colors of the input image from the color gammut described in the sourceICMProfile to the colors of the targetICMProfile. 
		/// Performing the transformation gives a preview of the target output on the source device.
		/// </summary>
		/// <param name="image">The image that shall be transformed</param>
		/// <param name="sourceICMProfile">The ICC-Profile of the viewing (source) device</param>
		/// <param name="targetICMProfile">The ICC-Profile of the printing (target) device</param>
		/// <returns>A color transformed image</returns>
		/// <update author="Tobias Mundt" date="2006-05-10">Changed the ReleaseDC calls to DeleteDC during tidy up</update>
		public static System.Drawing.Image PerformColorMatching(
			System.Drawing.Image image,
			System.IO.FileInfo sourceICMProfile,
			System.IO.FileInfo targetICMProfile)
		{
			//Get Dib from Image
			IntPtr bitmapInfoPointer=IntPtr.Zero;
			IntPtr pixelPointer=IntPtr.Zero;

			ImageToDib(
				image,
				ref bitmapInfoPointer,
				ref pixelPointer);

			//Create new bitmap
			System.Drawing.Bitmap newBitmap=new System.Drawing.Bitmap(
				image.Size.Width,
				image.Size.Height);

			IntPtr newBitmapPointer=newBitmap.GetHbitmap();

			//Prepare the device context on which to paint the corrected image
			IntPtr sourceDeviceContext=Gdi32.CreateCompatibleDC(IntPtr.Zero);

			Gdi32.SetICMMode(
				sourceDeviceContext,
				ICMMode.On);

			Gdi32.SetICMProfile(
				sourceDeviceContext,
				sourceICMProfile.FullName);

			IntPtr oldBitmapPointer=Gdi32.SelectObject(
				sourceDeviceContext,
				newBitmapPointer);

			//Prepare the device context from which the target color information is taken
			IntPtr targetDeviceContext=Gdi32.CreateCompatibleDC(IntPtr.Zero);

			Gdi32.SetICMMode(
				targetDeviceContext,
				ICMMode.On);

			Gdi32.SetICMProfile(
				targetDeviceContext,
				targetICMProfile.FullName);

			//Transfer the Dib to the deviceContextPointer and the newBitmapPointer with color correction
			Gdi32.ColorMatchToTarget(sourceDeviceContext, targetDeviceContext, ColorMatchToTargetMode.Enable);
			Gdi32.SetStretchBltMode(sourceDeviceContext, StretchMode.ColorOnColor);
			Gdi32.StretchDIBits(
				sourceDeviceContext,
				0,
				0,
				image.Size.Width,
				image.Size.Height,
				0,
				0,
				image.Size.Width,
				image.Size.Height,
				pixelPointer,
				bitmapInfoPointer,
				0,
				(int)RasterOperationCode.SourceCopy);

			Gdi32.ColorMatchToTarget(
				sourceDeviceContext,
				targetDeviceContext,
				ColorMatchToTargetMode.DeleteTransform);

			//The result is the corrected image
			System.Drawing.Bitmap result=System.Drawing.Image.FromHbitmap(newBitmapPointer);

			//Clean source
			Gdi32.SelectObject(
				sourceDeviceContext,
				oldBitmapPointer);

			Gdi32.DeleteObject(oldBitmapPointer);
			Gdi32.DeleteObject(newBitmapPointer);
			Gdi32.DeleteDC(sourceDeviceContext);

			//Clean target
			Gdi32.DeleteDC(targetDeviceContext);

			//Clean result
			Kernel32.GlobalFree(bitmapInfoPointer);
			Kernel32.GlobalFree(pixelPointer);

			GC.Collect();

			return result;
		}
		#endregion
	}
}
