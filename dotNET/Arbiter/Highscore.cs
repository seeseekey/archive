using System;
using System.Collections.Generic;
using System.Text;
using CSCL;
using System.Xml;

namespace Arbiter
{
    public class Highscore
    {
        Dictionary<string, int> userHighscore=new Dictionary<string, int>();
        string highscorePath;

        public Highscore(string path)
        {
            highscorePath=path;

            if(FileSystem.ExistsFile(highscorePath))
            {
                XmlData scoreFile=new XmlData(highscorePath);
                List<XmlNode> scoreNodes=scoreFile.GetElements("xml.Score");

                foreach(XmlNode scoreNode in scoreNodes)
                {
                    string name=scoreNode.Attributes["name"]!=null?scoreNode.Attributes["name"].Value:"";
                    int value=scoreNode.Attributes["value"]!=null?Convert.ToInt32(scoreNode.Attributes["value"].Value):0;
                    userHighscore.Add(name, value);
                }
            }
        }

        void Save()
        {
            XmlData scoreFile=new XmlData(highscorePath, true);
            XmlNode root=scoreFile.AddRoot("xml");

            foreach(KeyValuePair<string, int> pair in userHighscore)
            {
                XmlNode score=scoreFile.AddElement(root, "Score");
                scoreFile.AddAttribute(score, "name", pair.Key);
                scoreFile.AddAttribute(score, "value", pair.Value);
            }

            scoreFile.Save();
        }

        public int Count
        {
            get
            {
                return userHighscore.Count;
            }
        }

        public void AddPoints(string username, int points)
        {
            if(!userHighscore.ContainsKey(username))
            {
                userHighscore.Add(username, 0);
            }

            userHighscore[username]+=points;

            Save();
        }

        public List<string> GetHighscoreSortedByPoints()
        {
            List<string> ret=new List<string>();

            //Rangordnung bilden
            List<KeyValuePair<string, int>> values=new List<KeyValuePair<string, int>>();

            foreach(KeyValuePair<string, int> pair in userHighscore)
            {
                values.Add(pair);
            }

            values.Sort(CompareKeyValuePairStringInt);

            //Ergebnis ausgeben
            foreach(KeyValuePair<string, int> pair in values)
            {
                ret.Add(String.Format("{0}, {1} Punkte", pair.Key, pair.Value));
            }

            ret.Reverse();
            return ret;
        }

        int CompareKeyValuePairStringInt(KeyValuePair<string, int> a, KeyValuePair<string, int> b)
        {
            return a.Value.CompareTo(b.Value);
        }
    }
}
