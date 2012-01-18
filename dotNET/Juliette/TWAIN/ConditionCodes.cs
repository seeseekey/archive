//
//  ConditionCodes.cs
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
