using System;

namespace Arbiter
{
    public class Keyword
    {
        public string Word { get; private set; }
        public int Weight { get; private set; }

        public Keyword(string word, int weight)
        {
            Word=word;
            Weight=weight;
        }
    }
}

