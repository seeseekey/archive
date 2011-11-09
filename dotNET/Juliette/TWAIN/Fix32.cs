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
