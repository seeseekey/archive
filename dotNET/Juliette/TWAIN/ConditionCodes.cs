using System;
using System.Collections.Generic;
using System.Text;

namespace Juliette.Graphic.TWAIN
{
	/// <summary>
	/// Conditions the data source can reply to operations
	/// </summary>
	internal enum ConditionCodes : short
	{
		Success = 0x0000,
		Bummer = 0x0001,
		LowMemory = 0x0002,
		NoDataSource = 0x0003,
		MaxConnections = 0x0004,
		OperationError = 0x0005,
		BadCapability = 0x0006,
		BadProtocol = 0x0009,
		BadValue = 0x000a,
		SeqError = 0x000b,
		BadDestination = 0x000c,
		CapabilityUnsupported = 0x000d,
		CapabilityBadOperation = 0x000e,
		CapabilitySeqError = 0x000f,
		Denied = 0x0010,
		FileExists = 0x0011,
		FileNotFound = 0x0012,
		NotEmpty = 0x0013,
		PaperJam = 0x0014,
		PaperDoubleFeed = 0x0015,
		FileWriteError = 0x0016,
		CheckDeviceOnline = 0x0017
	}
}
