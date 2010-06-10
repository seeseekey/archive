unit Clxu3;

interface

uses Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, Menus, Registry;

var
slrd: string; //Datei �bergabestring
augs: string; //Archiv �bergabe String

function Search(ugw00: TStrings; suchtext: string) : Longint;

implementation

function Search(ugw00: TStrings; suchtext: string) : Longint;
var
 searchlist: TStringList; //Stringliste in welcher gesucht wird
 vstring: string; //String mit welchem verglichen wird
 stringindexcounter: Cardinal; //Momentane Position innerhalb der Strings
 listindexcounter: Cardinal; //Index zum z�hlen des momentanen Indizes
 prioty: Cardinal; //Gibt die momentane Suchpririt�t an
 listjumper: Boolean; //Status f�r Sprung aus Listendurchlaufsschleife
 stringjumper: Boolean; //Status f�r Sprung aus der Stringschleife
begin
 result := -1;
 listjumper := false;
 stringjumper := false;
 listindexcounter := 0;
 stringindexcounter := 1;
 prioty := 1;
 suchtext := lowercase(suchtext);

 if suchtext = '' then listjumper := true;
  searchlist := TStringList.Create; //Erstellen der Stringliste
 try
  searchlist.AddStrings(ugw00); //F�llen der Stringliste

  while listjumper = false do //While Schleife f�r Durchlauf der Stringliste
  begin
   vstring := searchlist.strings[listindexcounter]; //VString den einen Wert aus der Stringliste zuweisen
   vstring := lowercase(vstring);

   while stringjumper = false do
   begin
    if vstring[stringindexcounter] = suchtext[stringindexcounter] then
     begin
      inc(prioty);
      inc(stringindexcounter);
      if stringindexcounter = prioty then result := searchlist.IndexOf(vstring);
      if stringindexcounter > Length(suchtext) then begin listjumper := true; prioty:=1;stringjumper := true; stringindexcounter := 1; end
     end
    else
     begin
      stringindexcounter := 1;
      prioty := 1;
      stringjumper := true;
     end;
   end;

   stringjumper := false;

   inc(listindexcounter);
   if searchlist.count = listindexcounter then listjumper := true;
  end;

 finally
  searchlist.Free; //Freigeben der Stringliste
 end;
end;

end.
 