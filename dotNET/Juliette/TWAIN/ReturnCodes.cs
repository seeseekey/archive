//
//  ReturnCodes.cs
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
