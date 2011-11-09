using System;
using System.Collections.Generic;
using System.Text;

namespace Juliette.Graphic.TWAIN
{
	internal class DataSource
	{
		#region DataSourceManager
		/// <summary>
		/// Data source manager controlling the current twain session
		/// </summary>
		private DataSourceManager dataSourceManager; 
		#endregion
		
		#region Identity
		/// <summary>
		/// Identity of the represented data source
		/// </summary>
		public Identity Identity; 
		#endregion

		#region IsOpen
		private bool isOpen;
		/// <summary>
		/// Indicates wether the connection to the data source is open or not
		/// </summary>
		public bool IsOpen
		{
			get
			{
				return isOpen;
			}
		} 
		#endregion

		#region IsClosed
		/// <summary>
		/// Indicates wether the connection to the data source is closed or not
		/// </summary>
		public bool IsClosed
		{
			get
			{
				bool result = false;

				if (isOpen == false)
				{
					result = true;
				}

				return result;
			}
		}
		#endregion

		#region DataSource
		/// <summary>
		/// Constructor taking a valid data source manager instance
		/// </summary>
		/// <param name="dataSourceManager"></param>
		internal DataSource (DataSourceManager dataSourceManager)
		{
			this.dataSourceManager = dataSourceManager;
			this.Identity = new Identity ();
			this.Identity.Id = IntPtr.Zero;
			GetDefault ();
		} 
		#endregion

		#region GetDefault
		/// <summary>
		/// Receives the default twain data source
		/// </summary>
		/// <returns></returns>
		internal ReturnCodes GetDefault ()
		{
			return Twain32.GetDefaultDataSource (dataSourceManager.Identity, this.Identity);
		} 
		#endregion

		#region Open
		/// <summary>
		/// Opens the data source represented by an object of this class
		/// </summary>
		/// <returns>Response of the twain driver</returns>
		internal ReturnCodes Open ()
		{
			Close ();

			ReturnCodes openResult = Twain32.OpenDataSource (dataSourceManager.Identity, this.Identity);

			Capability capability = new Capability (dataSourceManager, this, Capabilities.XferCount, -1);
			ReturnCodes xferCountResult = capability.Set ();

			ReturnCodes result = ReturnCodes.Failure;

			if (
					openResult == ReturnCodes.Success &&
					xferCountResult == ReturnCodes.Success &&
					this.Identity.Id != IntPtr.Zero
				)
			{
				result = ReturnCodes.Success;
				isOpen = true;
			}

			return result;
		} 
		#endregion

		#region Close
		/// <summary>
		/// Closes the data source that is represeted by an instance of this class
		/// </summary>
		/// <returns>Response of the twain driver</returns>
		internal ReturnCodes Close ()
		{
			ReturnCodes result = ReturnCodes.Success;

			if (isOpen)
			{
				result = Twain32.DisableDataSource (dataSourceManager.Identity, this.Identity, new UserInterface ());
				result = Twain32.CloseDataSource (dataSourceManager.Identity, this.Identity);
				isOpen = false;
			}

			return result;
		} 
		#endregion

		#region Select
		/// <summary>
		/// Shows an userinterface from which one can choose a suitable twain data source
		/// </summary>
		/// <returns>Resonse of the twain driver</returns>
		internal ReturnCodes Select ()
		{
			ReturnCodes result = ReturnCodes.Failure;
			Close ();

			if (IsClosed)
			{
				result = Twain32.UserSelectDataSource (dataSourceManager.Identity, this.Identity);
			}

			return result;
		} 
		#endregion

		#region Enable
		/// <summary>
		/// Starts the scanning process
		/// </summary>
		/// <param name="parentWindowHandle">Parent window of the twain driver's userinterface</param>
		/// <returns>Resonse of the twain driver</returns>
		internal ReturnCodes Enable (IntPtr parentWindowHandle)
		{
			ReturnCodes result = ReturnCodes.Failure;

			if (IsOpen)
			{
				UserInterface guif = new UserInterface ();
				guif.ShowUserInterface = 1;
				guif.ModalUserInterface = 1;
				guif.ParentHandle = parentWindowHandle;

				result = Twain32.EnableDataSource (dataSourceManager.Identity, this.Identity, guif);
			}

			return result;
		} 
		#endregion
	}
}
