using System;
using System.Collections.Generic;
using System.Text;
using System.Timers;
using CSCL.Network.IRC;
using System.Threading;

namespace Arbiter
{
    /// <summary>
    /// Hauptklasse des Bots
    /// 
    /// Befehle:
    /// !quiz
    /// !highscore
    /// </summary>
    public class Arbiter
    {
        static int version=3;

        IrcClient irc=new IrcClient();
        System.Timers.Timer Timer=new System.Timers.Timer();

        BotMode botMode=BotMode.Idle;

        public string Server { get; private set; }
        public string Channel { get; private set; }
        public string Username { get; private set; }
        public string Realname { get; private set; }
        public string Ident { get; private set; }

        Highscore highscore;
        public Quiz.Quiz Quiz { get; private set; }

        Random rnd=new Random();
        public List<Quote> Quotes { get; private set; }
        public List<Joke> Jokes { get; private set; }

        void SendMessage(string message, params object[] parameter)
        {
            irc.SendMessage(SendType.Message, Channel, String.Format(message, parameter));
        }

        void OnChannelMessage(object sender, IrcEventArgs e)
        {
            try
            {
                //Message zusammenbauen
                string cbMessage="";

                foreach(string i in e.Data.MessageArray)
                {
                    cbMessage+=i+" ";
                }

                cbMessage=cbMessage.Trim();

                //Message auswerten
                if(cbMessage=="!highscore")
                {
                    if(highscore.Count==0)
                    {
                        SendMessage("Die Highscore ist zur Zeit leer.");
                    }
                    else
                    {
                        SendMessage("Die aktuelle Highscore sieht wie folgt aus:");

                        List<string> highscoreAsList=highscore.GetHighscoreSortedByPoints();
                        foreach(string entry in highscoreAsList)
                        {
                            SendMessage(entry);
                        }
                    }
                }
                else if(cbMessage=="!info")
                {
                    SendMessage("Ich bin Arbiter und wurde 2013 am Lambert Institute von seeseekey entwickelt. Meine Versionskennung lautet {0}.", version);
                }
                else if(cbMessage=="!help")
                {
                    SendMessage("Ich kann folgendes:");
                    SendMessage("!info");
                    SendMessage("!help");
                    SendMessage("!highscore");
                    SendMessage("!hint");
                    SendMessage("!joke");
                    SendMessage("!quiz");
                    SendMessage("!quote");
                }
                else if(cbMessage=="!quote")
                {
                    Quote quote=Quotes[rnd.Next(Quotes.Count)];
                    SendMessage("\"{0}\" von {1}", quote.QuoteText, quote.Author);
                }
                else if(cbMessage=="!joke")
                {
                    Joke joke=Jokes[rnd.Next(Jokes.Count)];
                    SendMessage(joke.JokeText);
                }

                switch(botMode)
                {
                    case BotMode.Idle:
                        {
                            if(cbMessage=="!quiz")
                            {
                                SendMessage(MultiRandomStrings.QuizStarts);
                                botMode=BotMode.Quiz;

                                Quiz.Start(10, "");
                            }

                            break;
                        }
                    case BotMode.Quiz:
                        {
                            if(cbMessage=="!hint")
                            {
                                SendMessage(Quiz.GetCurrentHint());
                            }

                            bool answerIsCorrect=Quiz.CheckMessageToAnswers(cbMessage);

                            if(answerIsCorrect)
                            {
                                highscore.AddPoints(e.Data.Nick, Quiz.CurrentQuestion.Points);
                                SendMessage(Quiz.GetCurrentSuccess());
                                SendMessage("{0} hat die Frage richtig beantwortet und erhält {1} Punkt(e).", e.Data.Nick, Quiz.CurrentQuestion.Points);

                                Thread.Sleep(800);

                                if(Quiz.SetCurrentQuestionAnswered())
                                {
                                    //Spiel zuende
                                    botMode=BotMode.Idle;

                                    SendMessage(MultiRandomStrings.QuizEnds);
                                }
                            }

                            break;
                        }
                }

            }
            catch(Exception ex)
            {
                string msg=String.Format("[{0:D2}:{1:D2}] {2}: {3}", DateTime.Now.Hour, DateTime.Now.Minute, e.Data.Nick, ex.Message.ToString());
                Console.WriteLine(msg);
            }
        }

        bool goodMorning=false;
        bool goodEvening=false;

        void timer_Tick(object sender, ElapsedEventArgs e)
        {
            try
            {
                //Zeiterkennung
                DateTime Now=DateTime.Now;

                if((Now.Hour==8&&Now.Minute>0)&&(Now.Hour<10&&Now.Minute>30))//Morgen
                {
                    int number=rnd.Next(100);

                    if(number==50)
                    {
                        if(goodMorning==false)
                        {
                            SendMessage(MultiRandomStrings.GoodMorning);
                            goodMorning=true;
                        }
                    }
                }
                else if((Now.Hour==21&&Now.Minute>0)&&(Now.Hour<23&&Now.Minute>30))//Abend
                {
                    int number=rnd.Next(100);
                    
                    if(number==50)
                    {
                        if(goodEvening==false)
                        {
                            SendMessage(MultiRandomStrings.GoodEvening);
                            goodEvening=true;
                        }
                    }
                }
                else
                {
                    goodMorning=false;
                    goodEvening=false;
                }

                //Normale Behandlung
                switch(botMode)
                {
                    case BotMode.Idle:
                        {
                            break;
                        }
                    case BotMode.Quiz:
                        {
                            TimeSpan span=DateTime.Now-Quiz.LastRequestForCurrentQuestion;
                            if(span.TotalMinutes>5)
                                SendMessage(Quiz.GetCurrentQuestion());

                            break;
                        }
                }
            }
            catch(Exception ex)
            {
                Console.WriteLine(ex.ToString());
            }
        }

        public Arbiter(string server, string username, string realname, string ident, string channel, string highscorePath)
        {
            Server=server;
            Username=username;
            Realname=realname;
            Ident=ident;
            Channel=channel;

            highscore=new Highscore(highscorePath);

            Quiz=new Quiz.Quiz();
            Quotes=new List<Quote>();
            Jokes=new List<Joke>();
        }

        public void Start(string userpassword)
        {
            //Timer verbinden
            Timer.Interval=500;
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
            serverlist=new string[] { Server };
            int port=6667;

            while(true)
            {
                try
                {
                    irc.Connect(serverlist, port);
                    irc.Login(Username, Realname, 0, Ident);
                    irc.RfcJoin(Channel);

                    Console.WriteLine("Connected to "+Server+" -> "+Channel);

                    if(userpassword!=null&&userpassword!="")
                    {
                        irc.SendMessage(SendType.Message, "", String.Format("/msg nickserv identify {0}", userpassword));
                    }
                                    
                    irc.Listen();
                    irc.Disconnect();
                }
                catch(ConnectionException ex)
                {
                    string msg="Couldn't connect! Reason: "+ex.Message;
                    Console.WriteLine(msg);
                }
                catch(Exception ex)
                {
                    string msg="Another exception: "+ex.Message;
                    Console.WriteLine(msg);
                }

				Thread.Sleep(75000);
            }
        }
    }
}
