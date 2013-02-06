//
//  Program.cs
//
//  Copyright (c) 2012 by seeseekey <seeseekey@gmail.com>
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
using CSCL.Network.IRC;
using System.Collections;
using CSCL.Network;
using CSCL;
using System.Timers;
using System.Xml;
using Arbiter.Quiz;

namespace Arbiter
{
    class Program
    {
        static void Main(string[] args)
        {
            if(args.Length!=1)
            {
                Console.WriteLine("Please set a config file!");
                return;
            }

            //CancelEvent verdrahten
            Console.CancelKeyPress+=new ConsoleCancelEventHandler(Console_CancelKeyPress);

            //Highscore Pfad bauen
            string highscorePath=FileSystem.GetPath(args[0])+"highscore.xml";

            //Config auslesen
            XmlData Options=new XmlData(args[0]);

            string username=Options.GetElementAsString("xml.IRC.UserName");
            string realname=Options.GetElementAsString("xml.IRC.RealName");
            string ident=Options.GetElementAsString("xml.IRC.Ident");
            string server=Options.GetElementAsString("xml.IRC.Server");
            string channel=Options.GetElementAsString("xml.IRC.Channel");
            string userpassword=Options.GetElementAsString("xml.IRC.Password");

            //Bot anlegen
            Arbiter arbiter=new Arbiter(server, username, realname, ident, channel, highscorePath);

            //Jokes einlesen
            List<XmlNode> jokeNodes=Options.GetElements("xml.Jokes.Joke");
            
            foreach(XmlNode jokeNode in jokeNodes)
            {
                string category=jokeNode.Attributes["category"]!=null?jokeNode.Attributes["category"].Value:"";
                string jokeText=jokeNode.InnerText;
                arbiter.Jokes.Add(new Joke(category, jokeText));
            }

            //Quizfragen einlesen
            List<XmlNode> questionsNodes=Options.GetElements("xml.Quiz.Question");

            foreach(XmlNode questionNode in questionsNodes)
            {
                string category=questionNode.Attributes["category"].Value;
                string question=questionNode.Attributes["question"].Value;
                string success=questionNode.Attributes["success"]!=null?questionNode.Attributes["success"].Value:"";
                int points=Convert.ToInt32(questionNode.Attributes["points"].Value);
                List<string> hints=new List<string>();

                int keywordWeight=1;
                if(questionNode.Attributes.GetNamedItem("keywordWeight")!=null)
                {
                    keywordWeight=Convert.ToInt32(questionNode.Attributes["keywordWeight"].Value);
                }

                List<Keyword> keywords=new List<Keyword>();

                foreach(XmlNode child in questionNode.ChildNodes)
                {
                    if(child.Name=="Keyword")
                    {
                        int weight=1;

                        if(child.Attributes.GetNamedItem("keywordWeight")!=null)
                        {
                            string weightValue=child.Attributes["keywordWeight"].Value;

                            if(weightValue=="MAX")
                                weight=Int32.MaxValue;
                            else
                                weight=Convert.ToInt32(weightValue);
                        }

                        Keyword keyword=new Keyword(child.InnerText, weight);
                        keywords.Add(keyword);
                    }
                    else if(child.Name=="Hint")
                    {
                        hints.Add(child.InnerText);
                    }
                }

                //Frage zum Bot hinzufügen
                arbiter.Quiz.Questions.Add(new Question(category, question, hints, success, points, keywordWeight, keywords));
            }

            //Quotes einlesen
            List<XmlNode> quodeNodes=Options.GetElements("xml.Quotes.Quote");
            
            foreach(XmlNode quodeNode in quodeNodes)
            {
                string author=quodeNode.Attributes["author"].Value;
                string quoteText=quodeNode.InnerText;
                arbiter.Quotes.Add(new Quote(author, quoteText));
            }
          
            //Bot starten
            arbiter.Start(userpassword);
        }

        static void Console_CancelKeyPress(object sender, ConsoleCancelEventArgs e)
        {
            Console.WriteLine("Arbiter wird beendet...");
        }
    }
}
