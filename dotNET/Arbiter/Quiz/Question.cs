using System;
using System.Collections.Generic;
using System.Text;

namespace Arbiter.Quiz
{
    public class Question
    {
        public string Category { get; private set; }
        public string QuestionText { get; private set; }
        public List<string> Hints { get; private set; }
        public string Success { get; private set; }
        public int Points { get; private set; }
        public int KeywordWeight { get; private set; }
        public List<Keyword> Keywords { get; private set; }

        public Question(string category, string question, List<string> hints, string success, int points, int keywordWeight, List<Keyword> keywords)
        {
            Category=category;
            QuestionText=question;
            Points=points;

            Hints=new List<string>();
            Hints.AddRange(hints);
            Success=success;
  
            KeywordWeight=keywordWeight;

            Keywords=new List<Keyword>();
            Keywords.AddRange(keywords);
        }
    }
}
