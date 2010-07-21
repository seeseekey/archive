using System;
using System.Collections.Generic;
using System.Windows.Forms;
using System.Threading;

namespace Juliette
{
	static class Program
	{
		public static FormMain InstFormMain;

		/// <summary>
		/// The main entry point for the application.
		/// </summary>
		[STAThread]
		static void Main()
		{
			Application.EnableVisualStyles();
			Application.SetCompatibleTextRenderingDefault(false);
			InstFormMain=new FormMain();
			Application.ThreadException+=new ThreadExceptionEventHandler(Globals.GlobalExceptionHandler);
			Application.Run(InstFormMain);
		}
	}
}