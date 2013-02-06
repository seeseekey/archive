using System;

namespace Arbiter
{
    public class Joke
    {
        public string Category { get; private set; }
        public string JokeText { get; private set; }
        
        public Joke(string category, string joketext)
        {
            Category=category;
            JokeText=joketext;
        }
    }
}

