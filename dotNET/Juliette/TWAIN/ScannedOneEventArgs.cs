//
//  ScannedOneEventArgs.cs
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
	public class ScannedOneEventArgs : EventArgs
	{
		#region image
		/// <summary>
		/// The scanned image
		/// </summary>
		private System.Drawing.Image image;
		#endregion

		#region Image
		/// <summary>
		/// The scanned image
		/// </summary>
		public System.Drawing.Image Image
		{
			get
			{ 
				return image;
			}
		}
		#endregion

		#region ScannedOneEventArgs
		/// <summary>
		/// Constructor
		/// </summary>
		/// <param name="image">The scanned image</param>
		internal ScannedOneEventArgs (System.Drawing.Image image)
		{
			this.image = image;
		}
		#endregion
	}

	public delegate void ScannedOneEventHandler (object sender, ScannedOneEventArgs e);
}
