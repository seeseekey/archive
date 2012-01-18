//
//  Fix32.cs
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
using System.Runtime.InteropServices;

namespace Juliette.Graphic.TWAIN
{
	/// <summary>
	/// A data structure to communicate with twain_32.dll
	/// </summary>
	[StructLayout (LayoutKind.Sequential, Pack = 2)]
	internal struct Fix32
	{
		#region Whole
		public short Whole; 
		#endregion

		#region Fraction
		public ushort Fraction; 
		#endregion

		#region ToFlat
		public float ToFloat ()
		{
			return (float) Whole + ((float) Fraction / 65536.0f);
		} 
		#endregion

		#region FromFloat
		public void FromFloat (float f)
		{
			int i = (int) ((f * 65536.0f) + 0.5f);
			Whole = (short) (i >> 16);
			Fraction = (ushort) (i & 0x0000ffff);
		} 
		#endregion
	}
}
