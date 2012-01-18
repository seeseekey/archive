//
//  DataAttributeTypes.cs
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
	/// Operation codes which are passed to the DsEntry/DsmEntry of the twain_32 dll to perform an operation
	/// </summary>
	internal enum DataAttributeTypes : short
	{
		Null = 0x0000,
		Capability = 0x0001,
		Event = 0x0002,
		Identity = 0x0003,
		Parent = 0x0004,
		PendingXfers = 0x0005,
		SetupMemXfer = 0x0006,
		SetupFileXfer = 0x0007,
		Status = 0x0008,
		UserInterface = 0x0009,
		XferGroup = 0x000a,
		TwunkIdentity = 0x000b,
		CustomDSData = 0x000c,
		DeviceEvent = 0x000d,
		FileSystem = 0x000e,
		PassThru = 0x000f,
		ImageInfo = 0x0101,
		ImageLayout = 0x0102,
		ImageMemXfer = 0x0103,
		ImageNativeXfer = 0x0104,
		ImageFileXfer = 0x0105,
		CieColor = 0x0106,
		GrayResponse = 0x0107,
		RGBResponse = 0x0108,
		JpegCompression = 0x0109,
		Palette8 = 0x010a,
		ExtImageInfo = 0x010b,
		SetupFileXfer2 = 0x0301
	}

}
