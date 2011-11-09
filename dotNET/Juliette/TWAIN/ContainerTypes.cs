using System;
using System.Collections.Generic;
using System.Text;

namespace Juliette.Graphic.TWAIN
{
	/// <summary>
	/// Type of data containers that can be send and received to/from the data source
	/// </summary>
	internal enum ContainerTypes : short
	{
		Array = 0x0003,
		Enum = 0x0004,
		One = 0x0005,
		Range = 0x0006,
		DontCare = -1
	}
}
