using System;

namespace Arbiter
{
    public class Quote
    {
        public string Author { get; private set; }
        public string QuoteText { get; private set; }

        public Quote(string author, string quote)
        {
            Author=author;
            QuoteText=quote;
        }
    }
}

