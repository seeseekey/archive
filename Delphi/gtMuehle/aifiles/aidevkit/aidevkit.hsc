HelpScribble project file.
12
Pynhqr _ranhq-1N5662N9
0
2
GT Mühle AI Development Kit


© 2005 by Global Technology
FALSE


1
BrowseButtons()
0
FALSE

FALSE
TRUE
16777215
0
16711680
8388736
255
TRUE
TRUE
FALSE
6
10
Scribble10
AI Development Kit



:000010
Writing



FALSE
5
{\rtf1\ansi\ansicpg1252\deff0\deflang1031{\fonttbl{\f0\fswiss\fcharset0 Arial;}{\f1\fswiss Arial;}}
{\colortbl ;\red0\green0\blue255;\red128\green0\blue0;}
\viewkind4\uc1\pard\cf1\b\f0\fs32 AI Development Kit\{keepn\}\cf2\f1 
\par \cf0\b0\f0\fs20 Mit Hilfe des AI Development Kit's ist es Ihnen m\'f6gliche eigende AI's f\'fcr GT M\'fchle zu schreiben.\f1 
\par }
15
Scribble15
Aufbau des Mühlefeldes




Writing



FALSE
7
{\rtf1\ansi\ansicpg1252\deff0\deflang1031{\fonttbl{\f0\fnil\fcharset0 Arial;}{\f1\fswiss Arial;}{\f2\fswiss\fcharset0 Arial;}{\f3\fnil Arial;}}
{\colortbl ;\red0\green0\blue255;\red128\green0\blue0;}
\viewkind4\uc1\pard\cf1\b\fs32 Aufbau des M\'fchlefeldes\f1\{keepn\}\cf2 
\par \cf0\b0\f2\fs20 Das M\'fchlefeld wird der DLL durch ein Array von 24 Integer Werten \'fcbergeben. Diese Integerwerte haben entweder den Wert 0, 1 oder 2. Das M\'fchlefeld ist wie folgt aufgebaut.\f3 
\par 
\par 
\par }
17
Scribble17
Strategie der Standard AI




Writing



FALSE
7
{\rtf1\ansi\ansicpg1252\deff0\deflang1031{\fonttbl{\f0\fnil\fcharset0 Arial;}{\f1\fswiss Arial;}{\f2\fswiss\fcharset0 Arial;}{\f3\fnil Arial;}}
{\colortbl ;\red0\green0\blue255;\red128\green0\blue0;}
\viewkind4\uc1\pard\cf1\b\fs32 Strategie der Standard AI\f1\{keepn\}\cf2 
\par \cf0\b0\f2\fs20 Die Standard AI verfolgt eine sehr einfache und grundlegende Strategie.\f3 
\par 
\par 
\par }
20
Scribble20
Strukturaufbau der AI



:000020
Writing



FALSE
6
{\rtf1\ansi\ansicpg1252\deff0\deflang1031{\fonttbl{\f0\fswiss Arial;}{\f1\fswiss\fcharset0 Arial;}}
{\colortbl ;\red0\green0\blue255;\red128\green0\blue0;}
\viewkind4\uc1\pard\cf1\b\f0\fs32 Strukturaufbau der AI\{keepn\}\cf2 
\par \pard\tx200\cf0\b0\f1\fs20 Jede AI von GT M\'fchle befindet sich im aifiles Verzeichnis. Es handelt sich bei den AI's um DLL Dateien. Diese DLL's exportieren 2 Funktionen nach aussen. Bei diesen Funktionen handelt es sich um GetAIInfo sowie um GetMove. GetAIInfo gibt allgeine Informationen w\'e4hrend GetMove den n\'e4chsten Zug berechnet.\f0 
\par \pard 
\par }
30
Scribble30
Funktionsbeschreibung




Writing



FALSE
39
{\rtf1\ansi\ansicpg1252\deff0\deflang1031{\fonttbl{\f0\fnil\fcharset0 Arial;}{\f1\fswiss Arial;}{\f2\fnil Arial;}{\f3\fswiss\fcharset0 Arial;}}
{\colortbl ;\red0\green0\blue255;\red128\green0\blue0;}
\viewkind4\uc1\pard\cf1\b\fs32 Funktionsbeschreibung\f1\{keepn\}\cf2 
\par \cf0\f2\fs20 function GetAIInfo(mode: Integer) : PChar;\b0\f1 
\par 
\par \f3 Diese Funktion gibt Informationen aus der AI zur\'fcck. \f1 
\par 
\par \f3 GetAIInfo Funktion aus der standard.dll:\f1 
\par 
\par \f2 function GetAIInfo(mode: Integer) : PChar;
\par begin
\par  Result:='\f0 none\f2 ';
\par  if mode = 1 then Result:='Standard AI' // AI Name
\par  else if mode = 2 then Result:='1.00.05' // AI Version
\par  else if mode = 3 then Result:='Global Technology' // AI Autor
\par  else if mode = 4 then Result:='\f0 Sehr leicht\f2 ' // AI Level -\f0  Sehr leicht, Leicht, Medium, Schwer, Extrem Schwer, Unbesiegbar\f2 
\par  else if mode = 5 then Result:='\f0\'a9 2005 by Global Technology' // AI Copyright
\par  else if mode = 6 then Result:='1.05' // Gibt ab welcher GT M\'fchle Version die AI funktioniert
\par  else if mode = 7 then Result:='GT Muehle' // Der Name des Host Anwendung der AI
\par  else if mode = 8 then Result:='GTSI' // AI ID wird zum korekten Laden der AI aus Spielst\'e4nden ben\'f6tigt
\par  else if mode = 9 then Result:='standard.ini'; // Name der AI Ini Datei zur speicherung von Bewertungen etc.
\par end;\f2 
\par 
\par \b function GetMove(fieldstatus: feldstatus; mpr: Integer; playergamephase: Integer;\f0  \f2 removemode: Boolean) : PChar;
\par 
\par \b0\f0 Diese Funktion gibt den n\'e4chsten Zug zur\'fcck. 
\par 
\par \b Eingabedaten:\b0 
\par fieldstatus: feldstatus - Der Status des Spielfeldes.
\par mpr: Integer - Gibt an welcher Spieler am Zug ist. (1 = Wei\'df, 2 = Schwarz)
\par playergamephase: Integer - Gibt an in welcher Spielphase sich der Spieler befindet. (0 = Er\'f6ffnung, 1 = Hauptspiel, 2 = Endspiel)
\par removemode: boolean - Gibt an ob ein Stein vom Brett genommen muss. (True = Stein muss vom Brett genommen werden) (False = Kein Stein muss vom Brett genommen werden
\par 
\par \b Ausgabedaten:\b0 
\par Result: string;
\par (z.B. '01' '02' '03'...)
\par (z.B. '0102', '0304', '0124'...)\f2 
\par 
\par }
80
Scribble80
History
History;


:000100
Writing



FALSE
8
{\rtf1\ansi\ansicpg1252\deff0\deflang1031{\fonttbl{\f0\fswiss Arial;}}
{\colortbl ;\red0\green0\blue255;}
\viewkind4\uc1\pard\cf1\b\f0\fs32 History\{keepn\}\cf0\b0\fs20 
\par \b Version 1.00\b0 
\par -
\par 
\par \pard\tx200 
\par }
0
0
0
6
1 GT Mühle AI Development Kit
2 AI Development Kit=Scribble10
2 Aufbau des Mühlefeldes=Scribble15
2 Strukturaufbau der AI=Scribble20
2 Funktionsbeschreibung=Scribble30
2 History=Scribble80
6
*InternetLink
16711680
Courier New
0
10
1
....
0
0
0
0
0
0
*ParagraphTitle
-16777208
Arial
0
11
1
B...
0
0
0
0
0
0
*PopupLink
-16777208
Arial
0
8
1
....
0
0
0
0
0
0
*PopupTopicTitle
16711680
Arial
0
10
1
B...
0
0
0
0
0
0
*TopicText
-16777208
Arial
0
10
1
....
0
0
0
0
0
0
*TopicTitle
16711680
Arial
0
16
1
B...
0
0
0
0
0
0
