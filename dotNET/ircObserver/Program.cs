using System;
using System.Collections.Generic;
using System.Text;
using CSCL.Network.IRC;
using System.Collections;
using CSCL.Network;
using CSCL;
using System.Timers;

namespace ircObserver
{
	class Program
	{
		static IrcClient irc=new IrcClient();
		static List<string> Conversion=new List<string>();
		static Timer Timer=new Timer();
		static bool MailSended=false;

		static void OnChannelMessage(object sender, IrcEventArgs e)
		{
			foreach(string i in e.Data.MessageArray)
			{
				string msg=String.Format("[{0:D2}:{1:D2}] {2}: {3}", DateTime.Now.Hour, DateTime.Now.Minute, e.Data.Nick, i);
				Conversion.Add(msg);
				Console.WriteLine(msg);
			}
		}

		static void timer_Tick(object sender, ElapsedEventArgs e)
		{
			try
			{
				DateTime Now=DateTime.Now;
				if(Now.Hour==23&&Now.Minute>55&&MailSended==false)
				{
					MailSended=true;

					string caption=String.Format("IRC Log - Channel {0} - Datum: {1}", channel, DateTime.Now.ToLongDateString());
					string msg=caption+"\n\n";

					foreach(string i in Conversion)
					{
						msg+=i+"\n";
					}

					Conversion.Clear();

					SMTP.SendMailMessageWithAuth(smtpserver, smtpUsername, smtpPassword, senderMail, "ircObserver", recieverMail, recieverMail, caption, msg);
				}
				else
				{
					MailSended=false;
				}
			}
			catch(Exception ex)
			{
				Console.WriteLine(ex.ToString());
			}
		}

		static string recieverMail="";

		static string smtpserver="";
		static string senderMail="";
		static string smtpUsername="";
		static string smtpPassword="";

		static string username="";
		static string realname="";
		static string ident="";
		static string server="";
		static string channel="";

		static void Main(string[] args)
		{
			if(args.Length!=1)
			{
				Console.WriteLine("Please set a config file!");
				return;
			}

			//Config auslesen
			XmlData Options=new XmlData(args[0]);

			recieverMail=Options.GetElementAsString("xml.SMTP.RecieverMail");

			smtpserver=Options.GetElementAsString("xml.SMTP.Server");
			senderMail=Options.GetElementAsString("xml.SMTP.SenderMail");
			smtpUsername=Options.GetElementAsString("xml.SMTP.Username");
			smtpPassword=Options.GetElementAsString("xml.SMTP.Password");

			username=Options.GetElementAsString("xml.IRC.UserName");
			realname=Options.GetElementAsString("xml.IRC.RealName");
			ident=Options.GetElementAsString("xml.IRC.Ident");
			server=Options.GetElementAsString("xml.IRC.Server");
			channel=Options.GetElementAsString("xml.IRC.Channel");

			//Timer verbinden
			Timer.Interval=5000;
			Timer.Elapsed+=new ElapsedEventHandler(timer_Tick);
			Timer.Enabled=true;

			//IRC Setup
			irc.SendDelay=200;
			irc.AutoRetry=true;
			irc.ActiveChannelSyncing=true;
			irc.OnChannelMessage+=new IrcEventHandler(OnChannelMessage);

			string[] serverlist;
			serverlist=new string[] { server };
			int port=6667;

			try
			{
				irc.Connect(serverlist, port);
				irc.Login(username, realname, 0, ident);
				irc.RfcJoin(channel);

				Console.WriteLine("Connected to "+server+" -> "+channel);

				irc.Listen();
				irc.Disconnect();
			}
			catch(ConnectionException e)
			{
				Console.WriteLine("couldn't connect! Reason: "+e.Message);
			}
		}
	}
}
