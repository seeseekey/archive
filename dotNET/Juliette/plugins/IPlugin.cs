//
//  IPlugin.cs
//
//  Copyright (c) 2011 by seeseekey <seeseekey@googlemail.com>
//
//  This program is free software: you can redistribute it and/or modify
//  it under the terms of the GNU General Public License as published by
//  the Free Software Foundation, either version 3 of the License, or
//  (at your option) any later version.
//
//  This program is distributed in the hope that it will be useful,
//  but WITHOUT ANY WARRANTY; without even the implied warranty of
//  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
//  GNU General Public License for more details.
//
//  You should have received a copy of the GNU General Public License
//  along with this program.  If not, see <http://www.gnu.org/licenses/>.

using System;
using System.Collections.Generic;
using System.Text;
using System.Drawing;
using CSCL.Imaging;

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
		CSCL.Imaging.Graphic GetImage(string dmttable, int sitenumber);
    }
}
