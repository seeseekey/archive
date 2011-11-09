using System;
using System.Collections.Generic;
using System.Text;

namespace Juliette.Graphic.TWAIN
{
	/// <summary>
	/// Values that can be passed to the DsEntry/DsmEntry of the twain_32.dll to indicate the data basis on which to perform an operation
	/// </summary>
	[Flags]
	internal enum DataGroups : short
	{
		Control = 0x0001,
		Image = 0x0002,
		Audio = 0x0004
	}
}
