using System;
using System.Collections.Generic;
using System.Text;
using CSCL.Graphic;
using System.Data;
using System.IO;

namespace Juliette.Plugins
{
    public class Image : IPlugin
    {
        /// <summary>
        /// Gibt die unterstützen Dateitypen zurück
        /// </summary>
		public List<string> SupportedFiletypes 
        {
            get
            {
                List<string> ret=new List<string>();
                ret.Add("img:png"); //Für Kompatibilität mit altem Format
                ret.Add("png");
				ret.Add("jpg");
				ret.Add("bmp");
                return ret;
            }
        }

		/// <summary>
		/// Gibt das Dokument bloß aus einer Datei bestehen darf
		/// z.B. für odt, pdf etc.
		/// </summary>
		public bool OnlyOneFilePerDocument
		{
			get
			{
				return false;
			}
		}

        /// <summary>
        /// Gibt ein Bitmap zurück
        /// </summary>
        /// <returns></returns>
		public gtImage GetImage(string dmttable, int sitenumber)
        {
            gtImage ret=new gtImage();

            try
            {
                string sqlCommand=String.Format("SELECT DmtSiteNumber, DmtFileType, DmtData FROM \"{0}\" WHERE DmtSiteNumber={1};", dmttable, sitenumber);
                DataTable tmpDT=Globals.InstSQLite.ExecuteQuery(sqlCommand);

                MemoryStream ms=new MemoryStream((byte[])tmpDT.Rows[0]["DmtData"]);
                ret=gtImage.FromStream(ms);
                ms.Close();
            }
            catch
            {
				ret=new gtImage(1000, 800, gtImage.Format.RGB);
				ret.FillWithMandelbrot();
            }

            return ret;
        }
    }
}
