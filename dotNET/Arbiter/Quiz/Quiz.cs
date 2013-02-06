using System;
using System.Collections.Generic;
using System.Text;

namespace Arbiter.Quiz
{
    public class Quiz
    {
        public List<Question> Questions { get; set; }

        Random rnd=new Random();

        QuizMode quizMode=QuizMode.Idle;
        List<Question> currentQuestions;
        int currentQuestion;

        public Question CurrentQuestion
        {
            get
            {
                return currentQuestions[currentQuestion];
            }
        }

        public DateTime LastRequestForCurrentQuestion { get; private set; }

        public Quiz()
        {
            Questions=new List<Question>();
        }

        public bool Start(int numberOfQuestions, string category)
        {
            if(quizMode==QuizMode.Idle)
            {
                currentQuestions=new List<Question>(); 
                currentQuestion=0;

                //Fragen zusammenwürfeln
                List<Question> tmpQuestions=new List<Question>();
                tmpQuestions.AddRange(Questions);

                for(int i=0;i<numberOfQuestions;i++)
                {
                    int questionIndex=rnd.Next(tmpQuestions.Count);
                    currentQuestions.Add(tmpQuestions[questionIndex]);
                    tmpQuestions.RemoveAt(questionIndex);
                }

                LastRequestForCurrentQuestion=DateTime.MinValue;
                quizMode=QuizMode.QuizInAction;

                return true;
            }
            else
            {
                return false; //Quiz ist bereits aktiv
            }
        }

        public string GetCurrentQuestion()
        {
            LastRequestForCurrentQuestion=DateTime.Now;
            return String.Format("[Kategorie: {0}] {1}", CurrentQuestion.Category, CurrentQuestion.QuestionText);
        }

        public string GetCurrentHint()
        {
            string hint;

            if(CurrentQuestion.Hints.Count>0)
            {
                hint=CurrentQuestion.Hints[rnd.Next(CurrentQuestion.Hints.Count)];
            }
            else
            {
                hint=MultiRandomStrings.NoHint;
            }

            return String.Format("[Hinweis] {0}", hint);
        }

        public string GetCurrentSuccess()
        {
            string success=CurrentQuestion.Success!=""?CurrentQuestion.Success:MultiRandomStrings.NoSuccess;
            return String.Format("[Antwort] {0}", success);
        }

        public bool CheckMessageToAnswers(string message)
        {
            int keywordWeight=0;

            foreach(Keyword keyword in CurrentQuestion.Keywords)
            {
                if(message.ToLower().IndexOf(keyword.Word.ToLower())!=-1)
                {
                    keywordWeight+=keyword.Weight;
                }
            }

            if(keywordWeight>=CurrentQuestion.KeywordWeight)
            {
                return true;
            }

            return false;
        }

        public bool SetCurrentQuestionAnswered()
        {
            if(currentQuestion+1>=currentQuestions.Count)
            {
                //Spiel zuende
                quizMode=QuizMode.Idle;

                return true;
            }

            currentQuestion++;
            LastRequestForCurrentQuestion=DateTime.MinValue;
            return false;
        }
    }
}
