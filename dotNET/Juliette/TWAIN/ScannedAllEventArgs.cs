//
//  ScannedAllEventArgs.cs
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
	public class ScannedAllEventArgs : EventArgs
	{
		#region images
		/// <summary>
		/// List of the scanned images.
		/// </summary>
		private List<System.Drawing.Image> images;
		#endregion

		#region Images
		/// <summary>
		/// List of the scanned images
		/// </summary>
		public List<System.Drawing.Image> Images
		{
			get
			{
				return images;
			}
		}
		#endregion

		#region ScannedAllEventArgs
		/// <summary>
		/// Constructor
		/// </summary>
		/// <param name="iamges">The scanned images</param>
		internal ScannedAllEventArgs	(List<System.Drawing.Image> images)
		{
			this.images = images;
		}
		#endregion
	}

	public delegate void ScannedAllEventHandler (object sender, ScannedAllEventArgs e);
}
