using System;
using System.Collections.Generic;
using System.Text;

namespace CloudFileSync
{
	public class FileReturn
	{
		public EFileType FileType { get; private set; }
		public string Filename { get; private set; }

		public FileReturn(EFileType fileType, string fileName)
		{
			FileType=fileType;
			Filename=fileName;
		}
	}
}
