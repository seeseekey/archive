using System;
using System.Collections.Generic;
using System.Text;
using System.Runtime.InteropServices;
using Juliette.API.Win32;

namespace Juliette.Graphic.TWAIN
{
	internal class Event
	{
		#region InteropStruct
		/// <summary>
		/// Data structure which is passed to the twain_32.dll
		/// </summary>
		private EventInterop interopStruct; 
		#endregion

		#region WindowsMessage
		/// <summary>
		/// The windows message that shall be passed to the twain_32.dll
		/// </summary>
		private WindowsMsg windowsMessage; 
		#endregion

		#region DataSourceManager
		/// <summary>
		/// Datasourcemanager controlling the current twain session
		/// </summary>
		private DataSourceManager dataSourceManager; 
		#endregion

		#region DataSource
		/// <summary>
		/// Data source which shall process the window message
		/// </summary>
		private DataSource dataSource; 
		#endregion


		#region Event
		/// <summary>
		/// Constructor taking the datasourcemanager and the datasource which shall process a windows message
		/// </summary>
		/// <param name="dataSourceManager"></param>
		/// <param name="dataSource"></param>
		internal Event (DataSourceManager dataSourceManager, DataSource dataSource)
		{
			interopStruct = new EventInterop ();
			interopStruct.WindowsMessagePointer = Marshal.AllocHGlobal (Marshal.SizeOf (windowsMessage));

			windowsMessage = new WindowsMsg ();

			this.dataSourceManager = dataSourceManager;
			this.dataSource = dataSource;
		} 
		#endregion

		#region ~Event
		/// <summary>
		/// Destructor
		/// </summary>
		~Event ()
		{
			Marshal.FreeHGlobal (interopStruct.WindowsMessagePointer);
		} 
		#endregion

		#region ProcessMessage
		/// <summary>
		/// Processes window message and indicates wether it is a twain event or not
		/// </summary>
		/// <param name="m">Message send to the application</param>
		/// <returns>The translates TwainMessage if suitable</returns>
		internal Messages ProcessMessage (ref System.Windows.Forms.Message m)
		{
			Messages result = Messages.Null;

			if (dataSource.IsOpen)
			{
				int pos = User32.GetMessagePos ();

				windowsMessage.hwnd = m.HWnd;
				windowsMessage.message = m.Msg;
				windowsMessage.wParam = m.WParam;
				windowsMessage.lParam = m.LParam;
				windowsMessage.time = User32.GetMessageTime ();
				windowsMessage.pt_x = (short) pos;
				windowsMessage.pt_y = (short) (pos >> 16);

				Marshal.StructureToPtr (windowsMessage, interopStruct.WindowsMessagePointer, false);
				interopStruct.Message = 0;
				ReturnCodes rc = Twain32.ProcessMessage (dataSourceManager.Identity, dataSource.Identity, ref interopStruct);

				if (rc == ReturnCodes.DataSourceEvent)
				{
					result = (Messages) interopStruct.Message;
				}
			}

			return result;
		}
		#endregion
	}

	[StructLayout (LayoutKind.Sequential, Pack = 2)]
	internal struct EventInterop
	{
		#region WindowsMessagePointer
		/// <summary>
		/// Pointer to a MSG Structure
		/// </summary>
		public IntPtr WindowsMessagePointer;
		#endregion

		#region Message
		/// <summary>
		/// Reply of the twain driver
		/// </summary>
		public short Message;
		#endregion
	}
}
