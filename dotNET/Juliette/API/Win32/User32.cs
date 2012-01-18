//
//  User32.cs
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

namespace Juliette.API.Win32
{
	public class User32
	{
		#region HookProc
		public delegate IntPtr HookProc(int nCode, IntPtr wParam, IntPtr lParam);
		#endregion

		#region GetMessagePos
		/// <summary>
		/// 
		/// </summary>
		/// <returns></returns>
		[DllImport("user32.dll", ExactSpelling=true)]
		public static extern int GetMessagePos();
		#endregion

		#region GetMessageTime
		[DllImport("user32.dll", ExactSpelling=true)]
		public static extern int GetMessageTime();
		#endregion

		#region GetWindowDC
		[DllImport("User32.dll")]
		public extern static System.IntPtr GetWindowDC(IntPtr hWnd);
		#endregion

		#region GetDC
		[DllImport("User32.dll")]
		public extern static System.IntPtr GetDC(System.IntPtr hWnd);
		#endregion

		#region ReleaseDC
		[DllImport("User32.dll")]
		public extern static int ReleaseDC(System.IntPtr hDC);
		#endregion

		#region ReleaseDC
		[DllImport("user32.dll", CharSet=CharSet.Auto)]
		static public extern int ReleaseDC(IntPtr hWnd, IntPtr hDC);
		#endregion

		#region GetDesktopWindow
		[DllImport("user32.dll", CharSet=CharSet.Auto)]
		static public extern IntPtr GetDesktopWindow();
		#endregion

		#region ShowWindow
		[DllImport("user32.dll", CharSet=CharSet.Auto)]
		static public extern bool ShowWindow(IntPtr hWnd, short State);
		#endregion

		#region UpdateWindow
		[DllImport("user32.dll", CharSet=CharSet.Auto)]
		static public extern bool UpdateWindow(IntPtr hWnd);
		#endregion

		#region SetForegroundWindow
		[DllImport("user32.dll", CharSet=CharSet.Auto)]
		static public extern bool SetForegroundWindow(IntPtr hWnd);
		#endregion

		#region SetWindowPos
		[DllImport("user32.dll", CharSet=CharSet.Auto)]
		static public extern bool SetWindowPos(IntPtr hWnd, IntPtr hWndInsertAfter, int x, int y, int Width, int Height, uint flags);
		#endregion

		#region OpenClipboard
		[DllImport("user32.dll", CharSet=CharSet.Auto)]
		static public extern bool OpenClipboard(IntPtr hWndNewOwner);
		#endregion

		#region CloseClipboard
		[DllImport("user32.dll", CharSet=CharSet.Auto)]
		static public extern bool CloseClipboard();
		#endregion

		#region EmptyClipboard
		[DllImport("user32.dll", CharSet=CharSet.Auto)]
		static public extern bool EmptyClipboard();
		#endregion

		#region SetClipboardData
		[DllImport("user32.dll", CharSet=CharSet.Auto)]
		static public extern IntPtr SetClipboardData(uint Format, IntPtr hData);
		#endregion

		#region GetMenuItemRect
		[DllImport("user32.dll", CharSet=CharSet.Auto)]
		static public extern bool GetMenuItemRect(IntPtr hWnd, IntPtr hMenu, uint Item, ref Rect rc);
		#endregion

		#region GetParent
		[DllImport("user32.dll", ExactSpelling=true, CharSet=CharSet.Auto)]
		public static extern IntPtr GetParent(IntPtr hWnd);
		#endregion

		#region SendMessage
		[DllImport("user32.dll", CharSet=CharSet.Auto)]
		public static extern int SendMessage(IntPtr hWnd, int msg, int wParam, int lParam);
		#endregion

		#region SendMessage
		[DllImport("user32.dll", CharSet=CharSet.Auto)]
		public static extern IntPtr SendMessage(IntPtr hWnd, int msg, int wParam, IntPtr lParam);
		#endregion

		#region SendMessage
		[DllImport("user32.dll", CharSet=CharSet.Auto)]
		public static extern void SendMessage(IntPtr hWnd, int msg, int wParam, ref Rect lParam);
		#endregion

		#region SendMessage
		[DllImport("user32.dll", CharSet=CharSet.Auto)]
		public static extern int SendMessage(IntPtr hWnd, int msg, int wParam, ref Point lParam);
		#endregion

		#region SendMessage
		[DllImport("user32.dll", CharSet=CharSet.Auto)]
		public static extern void SendMessage(IntPtr hWnd, int msg, int wParam, ref ToolBarButton lParam);
		#endregion

		#region SendMessage
		[DllImport("user32.dll", CharSet=CharSet.Auto)]
		public static extern void SendMessage(IntPtr hWnd, int msg, int wParam, ref ToolbarButtonInfo lParam);
		#endregion

		#region SendMessage
		[DllImport("user32.dll", CharSet=CharSet.Auto)]
		public static extern void SendMessage(IntPtr hWnd, int msg, int wParam, ref RebarBandInfo lParam);
		#endregion

		#region SendMessage
		[DllImport("user32.dll", CharSet=CharSet.Auto)]
		public static extern void SendMessage(IntPtr hWnd, int msg, int wParam, ref TreeViewItem lParam);
		#endregion

		#region SendMessage
		[DllImport("user32.dll", CharSet=CharSet.Auto)]
		public static extern void SendMessage(IntPtr hWnd, int msg, int wParam, ref ListViewItem lParam);
		#endregion

		#region SendMessage
		[DllImport("user32.dll", CharSet=CharSet.Auto)]
		public static extern void SendMessage(IntPtr hWnd, int msg, int wParam, ref HeaderItem lParam);
		#endregion

		#region SendMessage
		[DllImport("user32.dll", CharSet=CharSet.Auto)]
		public static extern void SendMessage(IntPtr hWnd, int msg, int wParam, ref HeaderHitTestInfo hti);
		#endregion

		#region PostMessage
		[DllImport("user32.dll", CharSet=CharSet.Auto)]
		public static extern IntPtr PostMessage(IntPtr hWnd, int msg, int wParam, int lParam);
		#endregion

		#region SetWindowsHookEx
		[DllImport("user32.dll", CharSet=CharSet.Auto)]
		public static extern IntPtr SetWindowsHookEx(int hookid, HookProc pfnhook, IntPtr hinst, int threadid);
		#endregion

		#region UnhookWindowsHookEx
		[DllImport("user32.dll", CharSet=CharSet.Auto, ExactSpelling=true)]
		public static extern bool UnhookWindowsHookEx(IntPtr hhook);
		#endregion

		#region CallNextHookEx
		[DllImport("user32.dll", CharSet=CharSet.Auto, ExactSpelling=true)]
		public static extern IntPtr CallNextHookEx(IntPtr hhook, int code, IntPtr wparam, IntPtr lparam);
		#endregion

		#region SetFocus
		[DllImport("user32.dll", CharSet=CharSet.Auto)]
		public static extern IntPtr SetFocus(IntPtr hWnd);
		#endregion

		#region DrawText
		[DllImport("user32.dll", CharSet=CharSet.Auto)]
		public extern static int DrawText(IntPtr hdc, string lpString, int nCount, ref Rect lpRect, int uFormat);
		#endregion

		#region SetParent
		[DllImport("user32.dll", CharSet=CharSet.Auto)]
		public extern static IntPtr SetParent(IntPtr hChild, IntPtr hParent);
		#endregion

		#region GetDlgItem
		[DllImport("user32.dll", CharSet=CharSet.Auto)]
		public extern static IntPtr GetDlgItem(IntPtr hDlg, int nControlID);
		#endregion

		#region GetClientRect
		[DllImport("user32.dll", CharSet=CharSet.Auto)]
		public extern static int GetClientRect(IntPtr hWnd, ref Rect rc);
		#endregion

		#region InvalidateRect
		[DllImport("user32.dll", CharSet=CharSet.Auto)]
		public extern static int InvalidateRect(IntPtr hWnd, IntPtr rect, int bErase);
		#endregion

		#region WaitMessage
		[DllImport("User32.dll", CharSet=CharSet.Auto)]
		public static extern bool WaitMessage();
		#endregion

		#region PeekMessage
		[DllImport("User32.dll", CharSet=CharSet.Auto)]
		public static extern bool PeekMessage(ref WindowsMsg msg, int hWnd, uint wFilterMin, uint wFilterMax, uint wFlag);
		#endregion

		#region GetMessage
		[DllImport("User32.dll", CharSet=CharSet.Auto)]
		public static extern bool GetMessage(ref WindowsMsg msg, int hWnd, uint wFilterMin, uint wFilterMax);
		#endregion

		#region TranslateMessage
		[DllImport("User32.dll", CharSet=CharSet.Auto)]
		public static extern bool TranslateMessage(ref WindowsMsg msg);
		#endregion

		#region DispatchMessage
		[DllImport("User32.dll", CharSet=CharSet.Auto)]
		public static extern bool DispatchMessage(ref WindowsMsg msg);
		#endregion

		#region LoadCursor
		[DllImport("User32.dll", CharSet=CharSet.Auto)]
		public static extern IntPtr LoadCursor(IntPtr hInstance, uint cursor);
		#endregion

		#region SetCursor
		[DllImport("User32.dll", CharSet=CharSet.Auto)]
		public static extern IntPtr SetCursor(IntPtr hCursor);
		#endregion

		#region GetFocus
		[DllImport("User32.dll", CharSet=CharSet.Auto)]
		public static extern IntPtr GetFocus();
		#endregion

		#region ReleaseCapture
		[DllImport("User32.dll", CharSet=CharSet.Auto)]
		public static extern bool ReleaseCapture();
		#endregion

		#region BeginPaint
		[DllImport("User32.dll", CharSet=CharSet.Auto)]
		public static extern IntPtr BeginPaint(IntPtr hWnd, ref PaintStruct ps);
		#endregion

		#region BeginPaint
		/// <update author="Tobias Mundt" date="2006-05-09">Added signature</update>
		[DllImport("User32.dll", CharSet=CharSet.Auto)]
		public static extern IntPtr BeginPaint(IntPtr hWnd, IntPtr ps);
		#endregion

		#region EndPaint
		[DllImport("User32.dll", CharSet=CharSet.Auto)]
		public static extern bool EndPaint(IntPtr hWnd, ref PaintStruct ps);
		#endregion

		#region EndPaint
		/// <update author="Tobias Mundt" date="2006-05-09">Added signature</update>
		[DllImport("User32.dll", CharSet=CharSet.Auto)]
		public static extern bool EndPaint(IntPtr hWnd, IntPtr ps);
		#endregion

		#region UpdateLayerdWindow
		[DllImport("User32.dll", CharSet=CharSet.Auto)]
		public static extern bool UpdateLayeredWindow(IntPtr hwnd, IntPtr hdcDst, ref Point pptDst, ref Size psize, IntPtr hdcSrc, ref Point pprSrc, Int32 crKey, ref BlendFunction pblend, Int32 dwFlags);
		#endregion

		#region GetWindowRect
		[DllImport("User32.dll", CharSet=CharSet.Auto)]
		public static extern bool GetWindowRect(IntPtr hWnd, ref Rect rect);
		#endregion

		#region ClientToScreen
		[DllImport("User32.dll", CharSet=CharSet.Auto)]
		public static extern bool ClientToScreen(IntPtr hWnd, ref Point pt);
		#endregion

		#region TrackMouseEvent
		[DllImport("User32.dll", CharSet=CharSet.Auto)]
		public static extern bool TrackMouseEvent(ref TrackMouseEvents tme);
		#endregion

		#region SetWindowRegion
		[DllImport("User32.dll", CharSet=CharSet.Auto)]
		public static extern bool SetWindowRgn(IntPtr hWnd, IntPtr hRgn, bool redraw);
		#endregion

		#region GetKeyState
		[DllImport("User32.dll", CharSet=CharSet.Auto)]
		public static extern ushort GetKeyState(int virtKey);
		#endregion

		#region MoveWindow
		[DllImport("User32.dll", CharSet=CharSet.Auto)]
		public static extern bool MoveWindow(IntPtr hWnd, int x, int y, int width, int height, bool repaint);
		#endregion

		#region GetClassName
		[DllImport("User32.dll", CharSet=CharSet.Auto)]
		public static extern int GetClassName(IntPtr hWnd, out StringBuffer ClassName, int nMaxCount);
		#endregion

		#region SetWindowLong
		[DllImport("User32.dll", CharSet=CharSet.Auto)]
		public static extern int SetWindowLong(IntPtr hWnd, int nIndex, int dwNewLong);
		#endregion

		#region GetDCEx
		[DllImport("User32.dll", CharSet=CharSet.Auto)]
		public static extern IntPtr GetDCEx(IntPtr hWnd, IntPtr hRegion, uint flags);
		#endregion
	}
}
