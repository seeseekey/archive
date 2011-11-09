using System;
using System.Drawing;
using System.Collections.Generic;
using System.Text;
using System.Threading;
using Juliette.API.Win32;

namespace Juliette.Graphic.TWAIN
{
	/// <summary>
	/// The twain controller can be used to acquire data from a twain compatible source. The source can be selected via the
	/// select method while the Acquire method is used the receive the data from the chosen source.
	/// </summary>
	internal class InternalTwainController : System.Windows.Forms.IMessageFilter
	{
		#region ScannedAll
		/// <summary>
		/// The event is fired after scanning all images from the source.
		/// </summary>
		public event ScannedAllEventHandler ScannedAll;
		#endregion

		#region ScannedOne
		/// <summary>
		/// This event is fired each time a new image is transfer from the twain data souce to the application.
		/// </summary>
		public event ScannedOneEventHandler ScannedOne;
		#endregion

		#region ScanningFinished
		/// <summary>
		/// This event is fired after the data source has been closed
		/// </summary>
		public event EventHandler ScanningFinished;
		#endregion

		#region dataSource
		/// <summary>
		/// Representation of the twain data source (e.g. a scanner).
		/// </summary>
		private DataSource dataSource;
		#endregion

		#region dataSourceManager
		/// <summary>
		/// Object managing all twain data sources an the corrent station.
		/// </summary>
		private DataSourceManager dataSourceManager;
		#endregion

		#region eventMessage
		/// <summary>
		/// A message the can be send be the data source via callback.
		/// </summary>
		private Event eventMessage;
		#endregion

		#region isFiltering
		/// <summary>
		/// Indicates wether the message filter is use or not
		/// </summary>
		private bool isFiltering;
		#endregion

		#region isInitializes
		/// <summary>
		/// Returns a bool inidcating if the InternalTwainController is initialized and usable or not.
		/// </summary>
		private bool isInitialized
		{
			get
			{
				return dataSourceManager.IsOpen;
			}
		}
		#endregion

		#region parentWindowHandle
		/// <summary>
		/// Parent control for the twain data source manager.
		/// </summary>
		private System.Windows.Forms.Form parentForm;
		#endregion


		#region InternalTwainController
		public InternalTwainController (System.Windows.Forms.Form parentForm)
		{
			this.parentForm = parentForm;
			Initialize ();
		}
		#endregion

		#region Acquire
		/// <summary>
		/// Starts the acquiring process.
		/// </summary>
		public void Acquire ()
		{
			if (isInitialized == false)
			{
				throw new TwainException (TwainExceptions.NotInitialized);
			}

			AddMessageFilter ();

			if (dataSource.Open () == ReturnCodes.Success)
			{
				if (dataSource.Enable(this.parentForm.Handle) == ReturnCodes.Failure)
				{
					this.parentForm.Close();
				}
			}
			else
			{
				dataSource.Close ();
			}
		}
		#endregion

		#region ~InternalTwainController
		~InternalTwainController ()
		{
			Finish ();
		}
		#endregion

		#region Finish
		private void Finish ()
		{
			dataSource.Close ();
			dataSourceManager.Close ();
		}
		#endregion

		#region Inititalize
		private void Initialize ()
		{
			this.dataSourceManager = new DataSourceManager ();

			IntPtr parentHandle = this.parentForm.Handle;

			if (this.dataSourceManager.Open (ref parentHandle) == ReturnCodes.Success)
			{
				this.dataSource = new DataSource (this.dataSourceManager);
				this.dataSource.GetDefault ();

				this.eventMessage = new Event (
					this.dataSourceManager,
					this.dataSource);
			}
			else
			{
				this.dataSourceManager.Close ();
			}
		}
		#endregion

		#region OnCloseDataSourceOk
		/// <summary>
		/// Called when the DataSource has been closed by the twain data source manager.
		/// </summary>
		private void OnCloseDataSourceOk ()
		{
			RemoveMessageFilter ();
			this.dataSource.Close ();
		}
		#endregion

		#region OnCloseDataSourceRequired
		private void OnCloseDataSourceRequired ()
		{
			RemoveMessageFilter ();
			this.dataSource.Close ();
		}
		#endregion

		#region OnScannedAll
		/// <summary>
		/// Fires the ScannedAll event.
		/// </summary>
		/// <param name="images">The scanned images</param>
		private void OnScannedAll (List<System.Drawing.Image> images)
		{
			if (ScannedAll != null)
			{
				ScannedAll (
					this,
					new ScannedAllEventArgs (images));
			}
		}
		#endregion

		#region OnScannedOne
		/// <summary>
		/// Fires the ScannedOne event
		/// </summary>
		/// <param name="image">The scanned image</param>
		private void OnScannedOne (System.Drawing.Image image)
		{
			if (ScannedOne != null)
			{
				ScannedOne (
					this,
					new ScannedOneEventArgs (image));
			}
		}
		#endregion

		#region OnScanningFinished
		/// <summary>
		/// Fires the ScannedOne event
		/// </summary>
		/// <param name="image">The scanned image</param>
		private void OnScanningFinished ()
		{
			if (ScanningFinished != null)
			{
				ScanningFinished (
					this,
					new EventArgs ());
			}
		}
		#endregion

		#region OnXferReady
		private void OnXferReady ()
		{
			TransferPictures ();
			RemoveMessageFilter ();
			dataSource.Close ();
		}
		#endregion

		#region Select
		/// <summary>
		/// Shows a dialog from which a user can choose the desired twain data source to acquire images from.
		/// </summary>
		public void Select ()
		{
			if (isInitialized == false)
			{
				throw new TwainException (TwainExceptions.NotInitialized);
			}

			this.dataSource.Select ();
		}
		#endregion

		#region PreFilterMessage
		bool System.Windows.Forms.IMessageFilter.PreFilterMessage (ref System.Windows.Forms.Message m)
		{
			bool result = false;

			Messages message = this.eventMessage.ProcessMessage (ref m);

			switch (message)
			{
				case Messages.CloseDataSourceRequired:
				{
					OnCloseDataSourceRequired ();
					result = true;
					break;
				}

				case Messages.CloseDataSourceOk:
				{
					OnCloseDataSourceOk ();
					OnScanningFinished ();
					result = true;
					break;
				}

				case Messages.XferReady:
				{
					OnXferReady ();
					OnScanningFinished ();
					result = true;
					break;
				}
			}

			return result;
		}
		#endregion

		#region RemoveMessageFilter
		private void RemoveMessageFilter ()
		{
			if (isFiltering)
			{
				System.Windows.Forms.Application.RemoveMessageFilter (this);
				isFiltering = false;
			}
		}
		#endregion

		#region AddMessageFilter
		/// <summary>
		/// Adds this object to the MessageFilter of the application to receive twain event message.
		/// </summary>
		private void AddMessageFilter ()
		{
			if (isFiltering == false)
			{
				isFiltering = true;
				System.Windows.Forms.Application.AddMessageFilter (this);
			}
		}
		#endregion

		#region TransferPictures
		private void TransferPictures ()
		{
			if (isInitialized == false)
			{
				throw new TwainException (TwainExceptions.NotInitialized);
			}

			List<System.Drawing.Image> images = new List<System.Drawing.Image> ();
			IntPtr dibPointer = IntPtr.Zero;
			Xfer xfer = new Xfer (
				this.dataSourceManager,
				this.dataSource);

			do
			{
				xfer.ResetCount ();

				ImageInfo newImageInfo = new ImageInfo (
					this.dataSourceManager,
					this.dataSource);

				ReturnCodes rc;
				if ((rc = newImageInfo.Get ()) == ReturnCodes.Success)
				{
					rc = xfer.GetImage (ref dibPointer);
					rc = xfer.End ();

					System.Drawing.Image image = Gdi32.DibToBitmap (dibPointer);
					
					images.Add (image);
					OnScannedOne (image);
				}
			}
			while (xfer.Availiable);
			
			this.OnScannedAll (images);
		}
		#endregion
	}
}
