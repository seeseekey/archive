using System;
using System.Collections.Generic;
using System.Text;
using System.Runtime.InteropServices;

namespace Juliette.Graphic.TWAIN
{
	internal class Twain32
	{
		#region DataSourceManagerParent
		/// <summary>
		/// Used to set the parent of the datasourcemanger
		/// </summary>
		/// <param name="origin">Source of the operation</param>
		/// <param name="zeroPointer">IntPtr.Zero</param>
		/// <param name="dataGroup">Datagroup that is target of the operation</param>
		/// <param name="dataAttributeType">DataAttributeType that is target of the operation</param>
		/// <param name="message">Operation that shall be processed</param>
		/// <param name="handle">Handle to the parent window</param>
		/// <returns>Reply of the twaindriver</returns>
		[DllImport ("twain_32.dll", EntryPoint = "#1")]
		private static extern ReturnCodes DataSourceManagerParent (
			[In, Out] Identity origin, 
			IntPtr zeroPointer, 
			DataGroups dataGroup, 
			DataAttributeTypes dataAttributeType, 
			Messages message, 
			ref IntPtr handle);
		#endregion

		#region DataSourceManagerIdentity
		/// <summary>
		/// performs an operation on an identity
		/// </summary>
		/// <param name="origin">Source of the operation</param>
		/// <param name="zeroPointer">IntPtr.Zero</param>
		/// <param name="dataGroup">Datagroup that is target of the operation</param>
		/// <param name="dataAttributeType">DataAttributeType that is target of the operation</param>
		/// <param name="message">Operation that shall be processed</param>
		/// <param name="handle">Identity to perform the operation on</param>
		/// <returns>Reply of the twaindriver</returns>
		[DllImport ("twain_32.dll", EntryPoint = "#1")]
		private static extern ReturnCodes DataSourceManagerIdentity (
			[In, Out] Identity origin, 
			IntPtr zeroPointer, 
			DataGroups dataGroup, 
			DataAttributeTypes dataAttributeType, 
			Messages message, 
			[In, Out] Identity identity);
		#endregion

		#region DataSourceManagerStatus
		/// <summary>
		/// Aquires the status of the datasourcemanager
		/// </summary>
		/// <param name="origin">Source of the operation</param>
		/// <param name="zeroPointer">IntPtr.Zero</param>
		/// <param name="dataGroup">Datagroup that is target of the operation</param>
		/// <param name="dataAttributeType">DataAttributeType that is target of the operation</param>
		/// <param name="message">Operation that shall be processed</param>
		/// <param name="statusReply">Status</param>
		/// <returns>Reply of the twaindriver</returns>
		[DllImport ("twain_32.dll", EntryPoint = "#1")]
		private static extern ReturnCodes DataSourceManagerStatus (
			[In, Out] Identity origin, 
			IntPtr zeroPointer, 
			DataGroups dataGroup, 
			DataAttributeTypes dataAttributeType, 
			Messages message, 
			[In, Out] Status statusReply);
		#endregion

		#region DataSourceUserInterface
		/// <summary>
		/// Performs userinterface operations on the twaindriver
		/// </summary>
		/// <param name="origin">Source of the operation</param>
		/// <param name="destination">IntPtr.Zero</param>
		/// <param name="dataGroup">Datagroup that is target of the operation</param>
		/// <param name="dataAttributeType">DataAttributeType that is target of the operation</param>
		/// <param name="message">Operation that shall be processed</param>
		/// <param name="userInterface">UserInterface</param>
		/// <returns>Reply of the twaindriver</returns>
		[DllImport ("twain_32.dll", EntryPoint = "#1")]
		private static extern ReturnCodes DataSourceUserInterface (
			[In, Out] Identity origin, 
			[In, Out] Identity destination, 
			DataGroups dataGroup, 
			DataAttributeTypes dataAttributeType, 
			Messages message, 
			UserInterface userInterface);
		#endregion

		#region DataSourceEvent
		/// <summary>
		/// Perform event operations on the twaindriver
		/// </summary>
		/// <param name="origin">Source of the operation</param>
		/// <param name="destination">IntPtr.Zero</param>
		/// <param name="dataGroup">Datagroup that is target of the operation</param>
		/// <param name="dataAttributeType">DataAttributeType that is target of the operation</param>
		/// <param name="message">Operation that shall be processed</param>
		/// <param name="eventReply">TwainMessage related to the input message</param>
		/// <returns>Reply of the twaindriver</returns>
		[DllImport ("twain_32.dll", EntryPoint = "#1")]
		private static extern ReturnCodes DataSourceEvent (
			[In, Out] Identity origin, 
			[In, Out] Identity destination, 
			DataGroups dataGroup, 
			DataAttributeTypes dataAttributeType, 
			Messages message, 
			ref EventInterop eventReply);
		#endregion

		#region DataSourceStatus
		/// <summary>
		/// Aquires the status of the datasource
		/// </summary>
		/// <param name="origin">Source of the operation</param>
		/// <param name="destination">IntPtr.Zero</param>
		/// <param name="dataGroup">Datagroup that is target of the operation</param>
		/// <param name="dataAttributeType">DataAttributeType that is target of the operation</param>
		/// <param name="message">Operation that shall be processed</param>
		/// <param name="status">Status of the datasource</param>
		/// <returns>Reply of the twaindriver</returns>
		[DllImport ("twain_32.dll", EntryPoint = "#1")]
		private static extern ReturnCodes DataSourceStatus (
			[In, Out] Identity origin, 
			[In] Identity destination, 
			DataGroups dataGroup, 
			DataAttributeTypes dataAttributeType, 
			Messages message, 
			[In, Out] Status status);
		#endregion

		#region DataSourceCapability
		/// <summary>
		/// Performs operations on the capabilities of the datasource
		/// </summary>
		/// <param name="origin">Source of the operation</param>
		/// <param name="destination">IntPtr.Zero</param>
		/// <param name="dataGroup">Datagroup that is target of the operation</param>
		/// <param name="dataAttributeType">DataAttributeType that is target of the operation</param>
		/// <param name="message">Operation that shall be processed</param>
		/// <param name="capability">Capability data get or to be set</param>
		/// <returns>Reply of the twaindriver</returns>
		[DllImport ("twain_32.dll", EntryPoint = "#1")]
		private static extern ReturnCodes DataSourceCapability (
			[In, Out] Identity origin, 
			[In] Identity destination, 
			DataGroups dataGroup, 
			DataAttributeTypes dataAttributeType, 
			Messages message, 
			[In, Out] Capability capability);
		#endregion

		#region DataSourceImageInfo
		/// <summary>
		/// Receives infos about the image that is ready to be transferd from the twain driver to the application
		/// </summary>
		/// <param name="origin">Source of the operation</param>
		/// <param name="destination">IntPtr.Zero</param>
		/// <param name="dataGroup">Datagroup that is target of the operation</param>
		/// <param name="dataAttributeType">DataAttributeType that is target of the operation</param>
		/// <param name="message">Operation that shall be processed</param>
		/// <param name="imageInfo">Imageinfo on the waiting image</param>
		/// <returns>Reply of the twaindriver</returns>
		[DllImport ("twain_32.dll", EntryPoint = "#1")]
		private static extern ReturnCodes DataSourceImageInfo (
			[In, Out] Identity origin, 
			[In] Identity destination, 
			DataGroups dataGroup, 
			DataAttributeTypes dataAttributeType, 
			Messages message, 
			[In, Out] ImageInfoInterop imageInfo);
		#endregion

		#region DataSourceImageNativeXfer
		/// <summary>
		/// Used to transfer the aquired image from the twain driver to the application
		/// </summary>
		/// <param name="origin">Source of the operation</param>
		/// <param name="destination">IntPtr.Zero</param>
		/// <param name="dataGroup">Datagroup that is target of the operation</param>
		/// <param name="dataAttributeType">DataAttributeType that is target of the operation</param>
		/// <param name="message">Operation that shall be processed</param>
		/// <param name="dibPointer">Pointer on a device idependend bitmap received from the twain driver</param>
		/// <returns>Reply of the twaindriver</returns>
		[DllImport ("twain_32.dll", EntryPoint = "#1")]
		private static extern ReturnCodes DataSourceImageNativeXfer (
			[In, Out] Identity origin, 
			[In] Identity destination, 
			DataGroups dataGroup, 
			DataAttributeTypes dataAttributeType, 
			Messages message, 
			ref IntPtr dibPointer);
		#endregion

		#region DataSourcePendingXfer
		/// <summary>
		/// Performs operations regarding pending xfers
		/// </summary>
		/// <param name="origin">Source of the operation</param>
		/// <param name="destination">IntPtr.Zero</param>
		/// <param name="dataGroup">Datagroup that is target of the operation</param>
		/// <param name="dataAttributeType">DataAttributeType that is target of the operation</param>
		/// <param name="message">Operation that shall be processed</param>
		/// <param name="pendingXfer">Waiting transfers</param>
		/// <returns>Reply of the twaindriver</returns>
		[DllImport ("twain_32.dll", EntryPoint = "#1")]
		private static extern ReturnCodes DataSourcePendingXfer (
			[In, Out] Identity origin, 
			[In] Identity destination, 
			DataGroups dataGroup, 
			DataAttributeTypes dataAttributeType, 
			Messages message, 
			[In, Out] PendingXfersInterop pendingXfer);
		#endregion

		#region OpenDataSourceManager
		/// <summary>
		/// Opens a datasourcemanager
		/// </summary>
		/// <param name="applicationIdentity">Identity of the application</param>
		/// <param name="parentWindowHandle">Parent window handle</param>
		/// <returns>Reply of the twaindriver</returns>
		internal static ReturnCodes OpenDataSourceManager (
			Identity applicationIdentity,
			ref IntPtr parentWindowHandle)
		{
			return Twain32.DataSourceManagerParent (
				applicationIdentity,
				IntPtr.Zero,
				DataGroups.Control,
				DataAttributeTypes.Parent,
				Messages.OpenDataSourceManager,
				ref parentWindowHandle);
		} 
		#endregion

		#region CloseDataSourceManager
		/// <summary>
		/// Closes the datasourcemanager
		/// </summary>
		/// <param name="applicationIdentity">Identity of the application</param>
		/// <param name="parentWindowHandle">Handle of the parentwindow</param>
		/// <returns>Reply of the twaindriver</returns>
		internal static ReturnCodes CloseDataSourceManager (
			Identity applicationIdentity, 
			ref IntPtr parentWindowHandle)
		{
			return Twain32.DataSourceManagerParent (
				applicationIdentity,
				IntPtr.Zero,
				DataGroups.Control,
				DataAttributeTypes.Parent,
				Messages.CloseDataSourceManager,
				ref parentWindowHandle);
		} 
		#endregion

		#region GetDefaultDataSource
		/// <summary>
		/// Receives the default twain datasource
		/// </summary>
		/// <param name="applicationIdentity">Identity of the application</param>
		/// <param name="dataSourceIdentity">Identity of the datasource</param>
		/// <returns>Reply of the twaindriver</returns>
		internal static ReturnCodes GetDefaultDataSource (
			Identity applicationIdentity, 
			Identity dataSourceIdentity)
		{
			return Twain32.DataSourceManagerIdentity (
				applicationIdentity,
				IntPtr.Zero,
				DataGroups.Control,
				DataAttributeTypes.Identity,
				Messages.GetDefault,
				dataSourceIdentity);
		} 
		#endregion

		#region UserSelectDataSource
		/// <summary>
		/// Shows a dialog from which the user can choose a suitable datasource
		/// </summary>
		/// <param name="applicationIdentity">Identity of the application</param>
		/// <param name="dataSourceIdentity">Identity of the datasource</param>
		/// <returns>Reply of the twaindriver</returns>
		internal static ReturnCodes UserSelectDataSource (
			Identity applicationIdentity, 
			Identity dataSourceIdentity)
		{
			return DataSourceManagerIdentity (
				applicationIdentity,
				IntPtr.Zero,
				DataGroups.Control,
				DataAttributeTypes.Identity,
				Messages.UserSelect,
				dataSourceIdentity);
		} 
		#endregion

		#region OpenDataSource
		/// <summary>
		/// Opens a datasource
		/// </summary>
		/// <param name="applicationIdentity">Identity of the application</param>
		/// <param name="dataSourceIdentity">Identity of the datasource</param>
		/// <returns>Reply of the twaindriver</returns>
		internal static ReturnCodes OpenDataSource (
			Identity applicationIdentity, 
			Identity dataSourceIdentity)
		{
			return DataSourceManagerIdentity (
				applicationIdentity,
				IntPtr.Zero,
				DataGroups.Control,
				DataAttributeTypes.Identity,
				Messages.OpenDataSource,
				dataSourceIdentity);
		} 
		#endregion

		#region CloseDataSource
		/// <summary>
		/// Closes a datasource
		/// </summary>
		/// <param name="applicationIdentity">Identity of the application</param>
		/// <param name="dataSourceIdentity">Identity of the datasource</param>
		/// <returns>Reply of the twaindriver</returns>
		internal static ReturnCodes CloseDataSource (
			Identity applicationIdentity, 
			Identity dataSourceIdentity)
		{
			return DataSourceManagerIdentity (
				applicationIdentity,
				IntPtr.Zero,
				DataGroups.Control,
				DataAttributeTypes.Identity,
				Messages.CloseDataSource,
				dataSourceIdentity);
		} 
		#endregion

		#region SetCapability
		/// <summary>
		/// Set a capability of a datasource
		/// </summary>
		/// <param name="applicationIdentity">Identity of the application</param>
		/// <param name="dataSourceIdentity">Identity of the datasource</param>
		/// <param name="capability"></param>
		/// <returns>Reply of the twaindriver</returns>
		internal static ReturnCodes SetCapability (
			Identity applicationIdentity, 
			Identity dataSourceIdentity, 
			Capability capability)
		{
			return DataSourceCapability (
				applicationIdentity,
				dataSourceIdentity,
				DataGroups.Control,
				DataAttributeTypes.Capability,
				Messages.Set,
				capability);
		} 
		#endregion

		#region EnableDataSource
		/// <summary>
		/// Enables a datasource which starts the scanning process
		/// </summary>
		/// <param name="applicationIdentity">Identity of the application</param>
		/// <param name="dataSourceIdentity">Identity of the datasource</param>
		/// <param name="userInterface"></param>
		/// <returns>Reply of the twaindriver</returns>
		internal static ReturnCodes EnableDataSource (
			Identity applicationIdentity, 
			Identity dataSourceIdentity, 
			UserInterface userInterface)
		{
			return DataSourceUserInterface (
				applicationIdentity,
				dataSourceIdentity,
				DataGroups.Control,
				DataAttributeTypes.UserInterface,
				Messages.EnableDataSource,
				userInterface);
		} 
		#endregion

		#region DisableDataSource
		/// <summary>
		/// Stops the scanning process of a datasource
		/// </summary>
		/// <param name="applicationIdentity">Identity of the application</param>
		/// <param name="dataSourceIdentity">Identity of the datasource</param>
		/// <param name="userInterface"></param>
		/// <returns>Reply of the twaindriver</returns>
		internal static ReturnCodes DisableDataSource (
			Identity applicationIdentity, 
			Identity dataSourceIdentity, 
			UserInterface userInterface)
		{
			return DataSourceUserInterface (
				applicationIdentity,
				dataSourceIdentity,
				DataGroups.Control,
				DataAttributeTypes.UserInterface,
				Messages.DisableDataSource,
				userInterface);
		} 
		#endregion

		#region GetImageInfo
		/// <summary>
		/// Receives infos about images ready for transferation
		/// </summary>
		/// <param name="applicationIdentity">Identity of the application</param>
		/// <param name="dataSourceIdentity">Identity of the datasource</param>
		/// <param name="imageInfo"></param>
		/// <returns>Reply of the twaindriver</returns>
		internal static ReturnCodes GetImageInfo (
			Identity applicationIdentity, 
			Identity dataSourceIdentity, 
			ref ImageInfoInterop imageInfo)
		{
			return DataSourceImageInfo (
				applicationIdentity,
				dataSourceIdentity,
				DataGroups.Image,
				DataAttributeTypes.ImageInfo,
				Messages.Get,
				imageInfo);
		} 
		#endregion

		#region GetImageNativeXfer
		/// <summary>
		/// Transfers the bitmap bits from the twaindriver to the application
		/// </summary>
		/// <param name="applicationIdentity">Identity of the application</param>
		/// <param name="dataSourceIdentity">Identity of the datasource</param>
		/// <param name="bitmapHandle"></param>
		/// <returns>Reply of the twaindriver</returns>
		internal static ReturnCodes GetImageNativeXfer (
			Identity applicationIdentity, 
			Identity dataSourceIdentity, 
			ref IntPtr bitmapHandle)
		{
			return DataSourceImageNativeXfer (
				applicationIdentity,
				dataSourceIdentity,
				DataGroups.Image,
				DataAttributeTypes.ImageNativeXfer,
				Messages.Get,
				ref bitmapHandle);
		} 
		#endregion

		#region EndPendingXfer
		/// <summary>
		/// Terminates the current transfer
		/// </summary>
		/// <param name="applicationIdentity">Identity of the application</param>
		/// <param name="dataSourceIdentity">Identity of the datasource</param>
		/// <param name="pendingXfer"></param>
		/// <returns>Reply of the twaindriver</returns>
		internal static ReturnCodes EndPendingXfer (
			Identity applicationIdentity, 
			Identity dataSourceIdentity, 
			PendingXfersInterop pendingXfer)
		{
			return DataSourcePendingXfer (
				applicationIdentity,
				dataSourceIdentity,
				DataGroups.Control,
				DataAttributeTypes.PendingXfers,
				Messages.EndXfer,
				pendingXfer);
		} 
		#endregion

		#region ResetPendingXfer
		/// <summary>
		/// Resets all pending transfers
		/// </summary>
		/// <param name="applicationIdentity">Identity of the application</param>
		/// <param name="dataSourceIdentity">Identity of the datasource</param>
		/// <param name="pendingXfer"></param>
		/// <returns>Reply of the twaindriver</returns>
		internal static ReturnCodes ResetPendingXfer (
			Identity applicationIdentity, 
			Identity dataSourceIdentity, 
			PendingXfersInterop pendingXfer)
		{
			return DataSourcePendingXfer (
				applicationIdentity,
				dataSourceIdentity,
				DataGroups.Control,
				DataAttributeTypes.PendingXfers,
				Messages.Reset,
				pendingXfer);
		} 
		#endregion

		#region ProcessMessage
		/// <summary>
		/// Routes a windowsmessage to the twaindriver which translate into a twainmessage
		/// </summary>
		/// <param name="applicationIdentity">Identity of the application</param>
		/// <param name="dataSourceIdentity">Identity of the datasource</param>
		/// <param name="eventMessage"></param>
		/// <returns>Reply of the twaindriver</returns>
		internal static ReturnCodes ProcessMessage (
			Identity applicationIdentity, 
			Identity dataSourceIdentity, 
			ref EventInterop eventMessage)
		{
			return DataSourceEvent (
				applicationIdentity,
				dataSourceIdentity,
				DataGroups.Control,
				DataAttributeTypes.Event,
				Messages.ProcessEvent,
				ref eventMessage);
		} 
		#endregion
	}
}
