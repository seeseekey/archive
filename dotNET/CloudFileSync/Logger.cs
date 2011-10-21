using System;
using System.Collections.Generic;
using System.Text;
using System.IO;

namespace CloudFileSync
{
	/// <summary>
	/// Der Loglevel
	/// </summary>
	public enum LogLevel
	{
		Error,
		Warning,
		Debug,
		Information
	}

	/// <summary>
	/// Klasse für einen Logeintrag
	/// </summary>
	public class LogEntry
	{
		public DateTime Timecode { get; private set; }
		public LogLevel Mode { get; private set; }
		public string Message { get; private set; }

		public LogEntry(LogLevel mode, string message)
		{
			Timecode=DateTime.Now;
			Mode=mode;
			Message=message;
		}

		public override string ToString()
		{
			return String.Format("[{0:D4}.{1:D2}.{2:D2}] -> [{3:D2}:{4:D2}:{5:D2}:{6:D3}] -> {7} -> {8}", Timecode.Year, Timecode.Month, Timecode.Day, Timecode.Hour, Timecode.Minute, Timecode.Second, Timecode.Millisecond, Mode.ToString().ToUpper(), Message);
		}
	}

	/// <summary>
	/// Generische Logklasse
	/// </summary>
	public class Logger
	{
		public string LogFile { get; private set; }

		//Private
		StreamWriter logFileStream=null;

		public Logger(string logFilename) //TODO Nutzer soll Logpfad bestimmen können
		{
			LogFile=logFilename;
			logFileStream=new StreamWriter(LogFile);
		}

		/// <summary>
		/// Fügt einen neuen Eintrag zum Logsystem dazu
		/// </summary>
		/// <param name="message"></param>
		public void Add(LogLevel logLevel, string message, params object[] arg)
		{
			message=String.Format(message, arg);
			LogEntry entry=new LogEntry(logLevel, message);

			logFileStream.WriteLine(entry.ToString());
			logFileStream.Flush();
		}
	}
}
