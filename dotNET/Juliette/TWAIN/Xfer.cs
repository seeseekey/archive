using System;
using System.Collections.Generic;
using System.Text;

namespace Juliette.Graphic.TWAIN
{
	internal class Xfer
	{
		#region dataSource
		private DataSource dataSource; 
		#endregion
		
		#region dataSourceManager
		private DataSourceManager dataSourceManager; 
		#endregion
		
		#region pendingXferInteropStruct
		private PendingXfersInterop pendingXfersInteropStruct; 
		#endregion

		#region Availiable
		/// <summary>
		/// Indicates wether xfers are availiable from the datasource or not.
		/// </summary>
		internal bool Availiable
		{
			get
			{
				bool result = false;

				if (pendingXfersInteropStruct != null && pendingXfersInteropStruct.Count > 0)
				{
					result = true;
				}

				return result;
			}
		} 
		#endregion

		#region Xfer
		/// <summary>
		/// Constructor
		/// </summary>
		/// <param name="dataSourceManager">Datasourcemanager for the xfers</param>
		/// <param name="dataSource">Datasource for the xfers</param>
		internal Xfer (
			DataSourceManager dataSourceManager,
			DataSource dataSource)
		{
			this.dataSourceManager = dataSourceManager;
			this.dataSource = dataSource;
			this.pendingXfersInteropStruct = new PendingXfersInterop ();
		}
		#endregion

		#region End
		/// <summary>
		/// Ends a pending xfer.
		/// </summary>
		/// <returns></returns>
		internal ReturnCodes End ()
		{
			return Twain32.EndPendingXfer (
				dataSourceManager.Identity,
				dataSource.Identity,
				pendingXfersInteropStruct);
		} 
		#endregion

		#region GetImage
		/// <summary>
		/// Transfers the dib from the 
		/// </summary>
		/// <param name="dibPointer"></param>
		/// <returns></returns>
		internal ReturnCodes GetImage (ref IntPtr dibPointer)
		{
			return Twain32.GetImageNativeXfer (
				dataSourceManager.Identity,
				dataSource.Identity,
				ref dibPointer);
		} 
		#endregion

		#region Reset
		/// <summary>
		/// Resets all pending xfers.
		/// </summary>
		/// <returns></returns>
		internal ReturnCodes Reset ()
		{
			return Twain32.ResetPendingXfer (
				dataSourceManager.Identity,
				dataSource.Identity,
				pendingXfersInteropStruct);
		} 
		#endregion

		#region ResetCount
		/// <summary>
		/// Resets all pending xfers. After calling this mehthod there are no open xfers left.
		/// </summary>
		internal void ResetCount ()
		{
			if (pendingXfersInteropStruct != null)
			{
				this.pendingXfersInteropStruct.Count = 0;
			}
		} 
		#endregion
	}
}
