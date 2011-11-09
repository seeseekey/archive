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
