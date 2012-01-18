//
//  Protocols.cs
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
	/// Contains constans to indicate the versions of twain that are supported at least and at max
	/// </summary>
	internal class Protocols
	{
		#region Major
		/// <summary>
		/// Version supported at max
		/// </summary>
		public const short Major = 1; 
		#endregion

		#region Minor
		/// <summary>
		/// Versions supported at least
		/// </summary>
		public const short Minor = 9; 
		#endregion
	}
}
