//
//  Messages.cs
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
	/// Messages that can be send to the twaindriver
	/// </summary>
	internal enum Messages : short
	{
		Null = 0x0000,
		Get = 0x0001,
		GetCurrent = 0x0002,
		GetDefault = 0x0003,
		GetFirst = 0x0004,
		GetNext = 0x0005,
		Set = 0x0006,
		Reset = 0x0007,
		QuerySupport = 0x0008,
		XferReady = 0x0101,
		CloseDataSourceRequired = 0x0102,
		CloseDataSourceOk = 0x0103,
		DeviceEvent = 0x0104,
		CheckStatus = 0x0201,
		OpenDataSourceManager = 0x0301,
		CloseDataSourceManager = 0x0302,
		OpenDataSource = 0x0401,
		CloseDataSource = 0x0402,
		UserSelect = 0x0403,
		DisableDataSource = 0x0501,
		EnableDataSource = 0x0502,
		EnableDataSourceUserInterfaceOnly = 0x0503,
		ProcessEvent = 0x0601,
		EndXfer = 0x0701,
		StopFeeder = 0x0702,
		ChangeDirectory = 0x0801,
		CreateDirectory = 0x0802,
		Delete = 0x0803,
		FormatMedia = 0x0804,
		GetClose = 0x0805,
		GetFirstFile = 0x0806,
		GetInfo = 0x0807,
		GetNextFile = 0x0808,
		Rename = 0x0809,
		Copy = 0x080A,
		AutoCaptureDir = 0x080B,
		PassThru = 0x0901
	}
}
