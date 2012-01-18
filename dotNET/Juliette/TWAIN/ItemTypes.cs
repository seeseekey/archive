//
//  ItemTypes.cs
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
	/// Supported datatypes
	/// </summary>
	internal enum ItemTypes : short
	{
		Int8 = 0x0000,
		Int16 = 0x0001,
		Int32 = 0x0002,
		UInt8 = 0x0003,
		UInt16 = 0x0004,
		UInt32 = 0x0005,
		Bool = 0x0006,
		Fix32 = 0x0007,
		Frame = 0x0008,
		Str32 = 0x0009,
		Str64 = 0x000a,
		Str128 = 0x000b,
		Str255 = 0x000c,
		Str1024 = 0x000d,
		Str512 = 0x000e
	}
}
