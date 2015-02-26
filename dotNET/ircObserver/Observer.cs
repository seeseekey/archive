using System;
using System.Collections.Generic;
using CSCL.Network.IRC;
using System.Timers;
using CSCL.Network;
using CSCL;
using System.Threading;
using System.Threading.Tasks;
using System.Net.Mail;

namespace ircObserver
{
    public class Observer
    {
        IrcClient irc=new IrcClient();
        List<string> Conversion=new List<string>();
        System.Timers.Timer Timer=new System.Timers.Timer();
        bool MailSended=false;

        string recieverMail="";

        string smtpserver="";
        string senderMail="";
        string smtpUsername="";
        string smtpPassword="";
        
        string username="";
        string realname="";
        string ident="";
        string server="";
        string channel="";

        void OnChannelMessage(object sender, IrcEventArgs e)
        {
            try
            {
                string cbMessage="";

                foreach(string i in e.Data.MessageArray)
                {
                    cbMessage+=i+" ";
                }

                cbMessage=cbMessage.TrimEnd(' ');
                string msg=String.Format("[{0:D2}:{1:D2}] {2}: {3}", DateTime.Now.Hour, DateTime.Now.Minute, e.Data.Nick, cbMessage);
                Conversion.Add(msg);
                Console.WriteLine(msg);
            }
            catch(Exception ex)
            {
                string msg=String.Format("[{0:D2}:{1:D2}] {2}: {3}", DateTime.Now.Hour, DateTime.Now.Minute, e.Data.Nick, ex.Message.ToString());
                Conversion.Add(msg);
                Console.WriteLine(msg);
            }
        }

        void timer_Tick(object sender, ElapsedEventArgs e)
        {
            try
            {
                DateTime Now=DateTime.Now;
                if(Now.Hour==23&&Now.Minute>55)
                {
                    if(MailSended==false)
                    {
                        MailSended=true;

                        string caption=String.Format("IRC Log - Channel {0} - Datum: {1}", channel, DateTime.Now.ToLongDateString());
                        string msg=caption+"\n\n";

                        foreach(string i in Conversion)
                        {
                            msg+=i+"\n";
                        }

                        bool success=true;

                        try
                        {
                            SMTP.SendMailMessageWithAuth(smtpserver, smtpUsername, smtpPassword, senderMail, "ircObserver", recieverMail, recieverMail, caption, msg);
                        }
                        catch(Exception ex)
                        {
                            Console.WriteLine(ex.ToString());

                            success=false;
                            MailSended=false;
                        }

                        if(success)
                        {
                            Conversion.Clear();
                        }
                    }
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
     
        public Observer(string configFile)
        {
            //Config auslesen
            XmlData Options=new XmlData(configFile);

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

            irc.AutoRejoin=true;
            irc.AutoRejoinOnKick=true;
            irc.AutoRelogin=true;
            irc.AutoRetry=true;

            string[] serverlist;
            serverlist=new string[] { server };
            int port=6667;

            Task.Factory.StartNew( () => {
                while(true)
                {
                    try
                    {
                        irc.Connect(serverlist, port);
                        irc.Login(username, realname, 0, ident);
                        irc.RfcJoin(channel);

                        Console.WriteLine("Connected to "+server+" -> "+channel);

                        irc.Listen();
                        irc.Disconnect();
                    }
                    catch(ConnectionException ex)
                    {
                        string msg="Couldn't connect! Reason: "+ex.Message;
                        Conversion.Add(msg);
                        Console.WriteLine(msg);
                    }
                    catch(Exception ex)
                    {
                        string msg="Another exception: "+ex.Message;
                        Conversion.Add(msg);
                        Console.WriteLine(msg);
                    }

					Thread.Sleep(75000);
                }
            }); 
        }
    }
}

