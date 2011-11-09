using System;
using System.Collections.Generic;
using System.Text;

namespace Juliette.Graphic.TWAIN
{
	/// <summary>
	/// Possible capabilites of twain sources
	/// </summary>
	internal enum Capabilities : short
	{
		XferCount = 0x0001,
		ICompression = 0x0100,
		IPixelType = 0x0101,
		IUnits = 0x0102,
		IXferMech = 0x0103
	}
}
