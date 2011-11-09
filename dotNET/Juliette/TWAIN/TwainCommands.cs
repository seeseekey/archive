using System;
using System.Collections.Generic;
using System.Text;

namespace Juliette.Graphic.TWAIN
{
	/// <summary>
	/// Commands that can be performed on the twaindriver
	/// </summary>
	internal enum TwainCommands
	{
		Not = -1,
		Null = 0,
		TransferReady = 1,
		CloseRequest = 2,
		CloseOk = 3,
		DeviceEvent = 4
	}
}
