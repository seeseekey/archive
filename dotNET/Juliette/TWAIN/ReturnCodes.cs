using System;
using System.Collections.Generic;
using System.Text;

namespace Juliette.Graphic.TWAIN
{
	/// <summary>
	/// Codes that can be returned by the twain driver
	/// </summary>
	internal enum ReturnCodes : short
	{
		Success = 0x0000,
		Failure = 0x0001,
		CheckStatus = 0x0002,
		Cancel = 0x0003,
		DataSourceEvent = 0x0004,
		NotDataSourceEvent = 0x0005,
		XferDone = 0x0006,
		EndOfList = 0x0007,
		InfoNotSupported = 0x0008,
		DataNotAvailable = 0x0009
	}
}
