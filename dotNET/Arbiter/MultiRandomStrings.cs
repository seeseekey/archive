using System;
using System.Collections.Generic;
using System.Text;

namespace Arbiter
{
    public static class MultiRandomStrings
    {
        static Random rnd=new Random();

        static string RandomString(params string[] strings)
        {
            return strings[rnd.Next(strings.Length)];
        }

        //Strings
        public static string QuizStarts
        {
            get
            {
                return RandomString("Quiz wird gestartet.", 
                                    "Starte Quiz.", 
                                    "Quiz, na das wird spaßig :)", 
                                    "Quizmodus. Yeah.",
                                    "Lade Ratemodusfragenbeantwortungsskripte. Ja ja geht ja los ;)",
                                    "Oh oh oh moment ich suche die Fragen... So kann losgehen.");
            }
        }

        public static string QuizEnds
        {
            get
            {
                return RandomString("Das Quiz ist beendet!", 
                                    "Und wieder ist ein spaßiges Quiz zuende.", 
                                    "Das wars mit diesem Quiz. Bis zum nächsten.",
                                    "Ich freue mich auf das nächste Quiz.");
            }
        }

        public static string NoHint
        {
            get
            {
                return RandomString("Für diese Frage gibt es leider keinen Hinweis.", 
                                    "Nix da, kein Hinweis.",
                                    "Ich kann dir leider nicht weiterhelfen.",
                                    "Ich würde gerne, aber zu dieser Frage darf ich nichts sagen.");
            }
        }

        public static string NoSuccess
        {
            get
            {
                return RandomString("Wieder eine richtige Antwort.", 
                                    "Das hat der Ratemeister zugeschlagen.", 
                                    "Auch diese Antwort ist wieder richtig.",
                                    "Wenn das so weiter geht haben wir bald einen Gewinner.",
                                    "Gratulation, die Antwort ist korrekt.",
                                    "100 % korrekt.",
                                    "Richtige Antwort :)");
            }
        }

        public static string GoodMorning
        {
            get
            {
                return RandomString("Guten Morgen.", 
                                    "Und wieder ein neuer Tag.", 
                                    "Guten Morgen, Mitglieder dieses Channels."
                );
            }
        }

        public static string GoodEvening
        {
            get
            {
                return RandomString("Guten Abend.", 
                                    "Arbiter legt sich nun schlafen.", 
                                    "Zeit zum schlafen."
                );
            }
        }
    }
}
