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
