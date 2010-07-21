using System;
using System.Collections.Generic;
using System.Text;
using System.Drawing;
using CSCL.Graphic;

namespace Juliette.Plugins
{
    public interface IPlugin
    {
        /// <summary>
        /// Gibt die unterstützen Dateitypen zurück
        /// </summary>
        List<string> SupportedFiletypes { get; }

		/// <summary>
		/// Gibt das Dokument bloß aus einer Datei bestehen darf
		/// z.B. für odt, pdf etc.
		/// </summary>
		bool OnlyOneFilePerDocument { get; }

        /// <summary>
        /// Gibt ein Bitmap zurück
        /// </summary>
        /// <returns></returns>
        gtImage GetImage(string dmttable, int sitenumber);
    }
}
