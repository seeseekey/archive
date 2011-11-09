using System;
using System.Collections.Generic;
using System.Text;

namespace Juliette.Graphic.TWAIN
{
	/// <summary>
	/// Thrown if an inaceptable state occurs in the twaincontrol
	/// </summary>
	[global::System.Serializable]
	public class TwainException : Exception
	{
		#region TwainException
		public TwainException ()
		{
		}
		#endregion

		#region TwainException
		public TwainException (string message)
			: base (message)
		{
		}
		#endregion

		#region TwainException
		public TwainException (string message, Exception inner)
			: base (message, inner)
		{
		}
		#endregion

		#region TwainException
		protected TwainException (System.Runtime.Serialization.SerializationInfo info, System.Runtime.Serialization.StreamingContext context)
			: base (info, context)
		{
		}
		#endregion
	}
}
