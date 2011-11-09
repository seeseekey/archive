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
