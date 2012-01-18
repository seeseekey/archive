//
//  Structs.cs
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
using System.Drawing;
using System.Runtime.InteropServices;

namespace Juliette.API.Win32
{
	#region Size
	[StructLayout(LayoutKind.Sequential)]
	public struct Size
	{
		public int cx;
		public int cy;
	}
	#endregion

	#region Rect
	[StructLayout(LayoutKind.Sequential)]
	public struct Rect
	{
		public int left;
		public int top;
		public int right;
		public int bottom;
	}
	#endregion

	#region InitCommonControlsEx
	[StructLayout(LayoutKind.Sequential, Pack=1)]
	public class InitCommonControlsEx
	{
		public int dwSize;
		public int dwICC;
	}
	#endregion

	#region ToolBarButton
	[StructLayout(LayoutKind.Sequential, Pack=1)]
	public struct ToolBarButton
	{
		public int iBitmap;
		public int idCommand;
		public byte fsState;
		public byte fsStyle;
		public byte bReserved0;
		public byte bReserved1;
		public int dwData;
		public int iString;
	}
	#endregion

	#region Point
	[StructLayout(LayoutKind.Sequential)]
	public struct Point
	{
		public int x;
		public int y;
	}
	#endregion

	#region NotificationMessageHeader
	[StructLayout(LayoutKind.Sequential)]
	public struct NotificationMessageHeader
	{
		public IntPtr hwndFrom;
		public int idFrom;
		public int code;
	}
	#endregion

	#region ToolTipExtra
	[StructLayout(LayoutKind.Sequential, CharSet=CharSet.Ansi)]
	public struct ToolTipExtra
	{
		public NotificationMessageHeader hdr;
		public IntPtr lpszText;
		[MarshalAs(UnmanagedType.ByValTStr, SizeConst=80)]
		public string szText;
		public IntPtr hinst;
		public int uFlags;
	}
	#endregion

	#region ToolTipText
	[StructLayout(LayoutKind.Sequential, CharSet=CharSet.Auto)]
	public struct ToolTipText
	{
		public NotificationMessageHeader hdr;
		public IntPtr lpszText;
		[MarshalAs(UnmanagedType.ByValTStr, SizeConst=80)]
		public string szText;
		public IntPtr hinst;
		public int uFlags;
	}
	#endregion

	#region NotificationMessageCustomDraw
	[StructLayout(LayoutKind.Sequential)]
	public struct NotificationMessageCustomDraw
	{
		public NotificationMessageHeader hdr;
		public int dwDrawStage;
		public IntPtr hdc;
		public Rect rc;
		public int dwItemSpec;
		public int uItemState;
		public int lItemlParam;
	}
	#endregion

	#region NotificationMessageToolbarCustomDraw
	[StructLayout(LayoutKind.Sequential)]
	public struct NotificationMessageToolbarCustomDraw
	{
		public NotificationMessageCustomDraw nmcd;
		public IntPtr hbrMonoDither;
		public IntPtr hbrLines;
		public IntPtr hpenLines;
		public int clrText;
		public int clrMark;
		public int clrTextHighlight;
		public int clrBtnFace;
		public int clrBtnHighlight;
		public int clrHighlightHotTrack;
		public Rect rcText;
		public int nStringBkMode;
		public int nHLStringBkMode;
	}
	#endregion

	#region NotificationMessageListViewCustomDraw
	[StructLayout(LayoutKind.Sequential)]
	public struct NotificationMessageListViewCustomDraw
	{
		public NotificationMessageCustomDraw nmcd;
		public uint clrText;
		public uint clrTextBk;
		public int iSubItem;
	}
	#endregion

	#region ToolbarButtonInfo
	[StructLayout(LayoutKind.Sequential, CharSet=CharSet.Auto)]
	public struct ToolbarButtonInfo
	{
		public int cbSize;
		public int dwMask;
		public int idCommand;
		public int iImage;
		public byte fsState;
		public byte fsStyle;
		public short cx;
		public IntPtr lParam;
		public IntPtr pszText;
		public int cchText;
	}
	#endregion

	#region RebarBandInfo
	[StructLayout(LayoutKind.Sequential)]
	public struct RebarBandInfo
	{
		public int cbSize;
		public int fMask;
		public int fStyle;
		public int clrFore;
		public int clrBack;
		public IntPtr lpText;
		public int cch;
		public int iImage;
		public IntPtr hwndChild;
		public int cxMinChild;
		public int cyMinChild;
		public int cx;
		public IntPtr hbmBack;
		public int wID;
		public int cyChild;
		public int cyMaxChild;
		public int cyIntegral;
		public int cxIdeal;
		public int lParam;
		public int cxHeader;
	}
	#endregion

	#region MouseHookStruct
	[StructLayout(LayoutKind.Sequential)]
	public struct MouseHookStruct
	{
		public Point pt;
		public IntPtr hwnd;
		public int wHitTestCode;
		public IntPtr dwExtraInfo;
	}
	#endregion

	#region NotificationMessageToolbar
	[StructLayout(LayoutKind.Sequential)]
	public struct NotificationMessageToolbar
	{
		public NotificationMessageHeader hdr;
		public int iItem;
		public ToolBarButton tbButton;
		public int cchText;
		public IntPtr pszText;
		public Rect rcButton;
	}
	#endregion

	#region NotificationMessageRebarChevron
	[StructLayout(LayoutKind.Sequential)]
	public struct NotificationMessageRebarChevron
	{
		public NotificationMessageHeader hdr;
		public int uBand;
		public int wID;
		public int lParam;
		public Rect rc;
		public int lParamNM;
	}
	#endregion

	#region Bitmap
	[StructLayout(LayoutKind.Sequential)]
	public class Bitmap
	{
		public int bmType;
		public int bmWidth;
		public int bmHeight;
		public int bmWidthBytes;
		public short bmPlanes;
		public short bmBitsPixel;
		public IntPtr bmBits;
	}
	#endregion

	#region BitmapInfoFlat
	[StructLayout(LayoutKind.Sequential)]
	public struct BitmapInfoFlat
	{
		public int bmiHeader_biSize;
		public int bmiHeader_biWidth;
		public int bmiHeader_biHeight;
		public short bmiHeader_biPlanes;
		public short bmiHeader_biBitCount;
		public int bmiHeader_biCompression;
		public int bmiHeader_biSizeImage;
		public int bmiHeader_biXPelsPerMeter;
		public int bmiHeader_biYPelsPerMeter;
		public int bmiHeader_biClrUsed;
		public int bmiHeader_biClrImportant;
		[MarshalAs(System.Runtime.InteropServices.UnmanagedType.ByValArray, SizeConst=1024)]
		public byte[] bmiColors;
	}
	#endregion

	#region RgbQuad
	public struct RgbQuad
	{
		public byte rgbBlue;
		public byte rgbGreen;
		public byte rgbRed;
		public byte rgbReserved;
	}
	#endregion

	#region BitmapInfoHeader
	[StructLayout(LayoutKind.Sequential, Pack=2)]
	public class BitmapInfoHeader
	{
		public int biSize=Marshal.SizeOf(typeof(BitmapInfoHeader));
		public int biWidth;
		public int biHeight;
		public short biPlanes;
		public short biBitCount;
		public int biCompression;
		public int biSizeImage;
		public int biXPelsPerMeter;
		public int biYPelsPerMeter;
		public int biClrUsed;
		public int biClrImportant;
	}
	#endregion

	#region BitmapInfo
	[StructLayout(LayoutKind.Sequential)]
	public class BitmapInfo
	{
		public BitmapInfoHeader bmiHeader=new BitmapInfoHeader();
		[MarshalAs(System.Runtime.InteropServices.UnmanagedType.ByValArray, SizeConst=256)]
		public RgbQuad[] bmiColors;
	}
	#endregion

	#region PaletteEntry
	[StructLayout(LayoutKind.Sequential)]
	public struct PaletteEntry
	{
		public byte peRed;
		public byte peGreen;
		public byte peBlue;
		public byte peFlags;
	}
	#endregion

	#region WindowsMsg
	[StructLayout(LayoutKind.Sequential)]
	public struct WindowsMsg
	{
		public IntPtr hwnd;
		public int message;
		public IntPtr wParam;
		public IntPtr lParam;
		public int time;
		public int pt_x;
		public int pt_y;
	}
	#endregion

	#region HeaderHitTestInfo
	[StructLayout(LayoutKind.Sequential)]
	public struct HeaderHitTestInfo
	{
		public Point pt;
		public uint flags;
		public int iItem;
	}
	#endregion

	#region DllVersionInfo
	[StructLayout(LayoutKind.Sequential)]
	public struct DllVersionInfo
	{
		public int cbSize;
		public int dwMajorVersion;
		public int dwMinorVersion;
		public int dwBuildNumber;
		public int dwPlatformID;
	}
	#endregion

	#region PaintStruct
	[StructLayout(LayoutKind.Sequential)]
	public struct PaintStruct
	{
		public IntPtr hdc;
		public int fErase;
		public Rectangle rcPaint;
		public int fRestore;
		public int fIncUpdate;
		public int Reserved1;
		public int Reserved2;
		public int Reserved3;
		public int Reserved4;
		public int Reserved5;
		public int Reserved6;
		public int Reserved7;
		public int Reserved8;
	}
	#endregion

	#region BlendFunction
	[StructLayout(LayoutKind.Sequential, Pack=1)]
	public struct BlendFunction
	{
		public byte BlendOp;
		public byte BlendFlags;
		public byte SourceConstantAlpha;
		public byte AlphaFormat;
	}

	#endregion

	#region TrackMouseEvents
	[StructLayout(LayoutKind.Sequential)]
	public struct TrackMouseEvents
	{
		public uint cbSize;
		public uint dwFlags;
		public IntPtr hWnd;
		public uint dwHoverTime;
	}
	#endregion

	#region StringBuffer
	[StructLayout(LayoutKind.Sequential, CharSet=CharSet.Auto)]
	public struct StringBuffer
	{
		[MarshalAs(UnmanagedType.ByValTStr, SizeConst=80)]
		public string szText;
	}
	#endregion

	#region NotificationMessageTreeViewCustomDraw
	[StructLayout(LayoutKind.Sequential)]
	public struct NotificationMessageTreeViewCustomDraw
	{
		public NotificationMessageCustomDraw nmcd;
		public uint clrText;
		public uint clrTextBk;
		public int iLevel;
	}
	#endregion

	#region TreeViewItem
	[StructLayout(LayoutKind.Sequential, CharSet=CharSet.Auto)]
	public struct TreeViewItem
	{
		public uint mask;
		public IntPtr hItem;
		public uint state;
		public uint stateMask;
		public IntPtr pszText;
		public int cchTextMax;
		public int iImage;
		public int iSelectedImage;
		public int cChildren;
		public int lParam;
	}
	#endregion

	#region ListViewItem
	[StructLayout(LayoutKind.Sequential, CharSet=CharSet.Auto)]
	public struct ListViewItem
	{
		public uint mask;
		public int iItem;
		public int iSubItem;
		public uint state;
		public uint stateMask;
		public IntPtr pszText;
		public int cchTextMax;
		public int iImage;
		public int lParam;
		public int iIndent;
	}
	#endregion

	#region HeaderItem
	[StructLayout(LayoutKind.Sequential, CharSet=CharSet.Auto)]
	public struct HeaderItem
	{
		public uint mask;
		public int cxy;
		public IntPtr pszText;
		public IntPtr hbm;
		public int cchTextMax;
		public int fmt;
		public int lParam;
		public int iImage;
		public int iOrder;
	}
	#endregion
}
