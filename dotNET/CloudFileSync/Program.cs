using System;
using System.Collections.Generic;
using System.Windows.Forms;
using System.Threading;

namespace CloudFileSync
{
	static class Program
	{
		/// <summary>
		/// The main entry point for the application.
		/// </summary>
		[STAThread]
		static void Main()
		{
			bool mutexCreated;

			///Einen neuen Mutex erzeugen, damit die Anwendung nur einmal gestartet werden kann.
			Mutex appMutex=new Mutex(true, Application.ProductName, out mutexCreated);
			
			///Wenn die Erzeugung erfolgreich war
			if(mutexCreated)
			{
				Application.EnableVisualStyles();
				Application.SetCompatibleTextRenderingDefault(false);
				Application.Run(new FormMain());

				// den Mutex wieder frei geben
				appMutex.ReleaseMutex();
			}
			else
			{
				///Wenn die Anwendung schon ausgeführt wird -> Hinweis-Dialog
				string msg=String.Format("Das Programm \"{0}\" wurde bereits gestartet!", Application.ProductName);
				MessageBox.Show(msg, Application.ProductName, MessageBoxButtons.OK, MessageBoxIcon.Information);
			}
		}
	}
}
