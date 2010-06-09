library Melinda;

{ Wichtiger Hinweis zur DLL-Speicherverwaltung: ShareMem muß sich in der
  ersten Unit der unit-Klausel der Bibliothek und des Projekts befinden (Projekt-
  Quelltext anzeigen), falls die DLL Prozeduren oder Funktionen exportiert, die
  Strings als Parameter oder Funktionsergebnisse weitergibt. Dies trifft auf alle
  Strings zu, die von oder zur DLL weitergegeben werden -- auch diejenigen, die
  sich in Records oder Klassen befinden. ShareMem ist die Schnittstellen-Unit
  zu BORLNDMM.DLL, der gemeinsamen Speicherverwaltung, die zusammen mit
  der DLL weitergegeben werden muß. Um die Verwendung von BORLNDMM.DLL
  zu vermeiden, sollten String-Informationen als PChar oder ShortString übergeben werden. }

uses
  SysUtils,
  Classes,
  Dialogs;

// Der Record feldstatus gibt an wie das Spielfeld besetzt ist.
// 0 = Feld ist leer
// 1 = Feld durch schwarzen Stein besetzt
// 2 = Feld durch weißen Stein besetzt
type feldstatus = array [1..24] of Integer;

// Lines ist ein Array mit einer Liste aller Linien auf denen Mühlen gebaut werden können

var  lines: array[1..16, 1..3] of Integer = (
     (1, 2, 3), (3, 4, 5), (5, 6, 7), (7, 8, 1), (9, 10, 11), (11, 12, 13),
     (13, 14, 15), (15, 16, 9), (17, 18, 19), (19, 20, 21), (21, 22, 23),
     (23, 24, 1), (2, 10, 18), (4, 12, 20), (6, 14, 22), (8, 10, 24));

for i := 1 to 16 do
begin
 for k := 1 to 3 do
 begin
  if fieldstatus[lines[i, k]] = mpr then
  begin
   
  end;
 end;
end;


// Eingabedaten
// fieldstatus: feldstatus - Der Status des Spielfeldes.
// mpr: Integer - Gibt an welcher Spieler am Zug ist.
// (1 = Weiß, 2 = Schwarz)
// playergamephase: Integer - Gibt an in welcher Spielphase sich der Spieler befindet.
// (0 = Eröffnung, 1 = Hauptspiel, 2 = Endspiel)
// removemode: boolean - Gibt an ob ein Stein vom Brett genommen muss.
// (True = Stein muss vom Brett genommen werden)
// (False = Kein Stein muss vom Brett genommen werden

// Ausgabedaten
// Result: string;
// (z.B. '01' '02' '03'...)
// (z.B. '0102', '0304', '0124'...)

{$R *.RES}

// Hilfsfuntionen

// Diese Funktion gibt als Ergebnis den invertierten mpr zurück
function invmpr(mpr: Integer) : Integer;
begin
 if mpr = 1 then Result := 2
 else Result := 1;
end;

// Wandelt einen Integer Wert (z.B. 4 in 04)
function GetCorrectResultString(input: string): string;
begin
 if Length(input) = 1 then input := '0' + input;
 Result := input;
end;

// Diese Funktion überprüft ob sich ein Stein bzw. ein Punkt auf dem Feld
// in einer Mühle befindet
function ismuehle (point_to_check: string; fieldstatus: feldstatus; mpr: Integer) : Boolean;
var
   a,b,c,d : Integer;
begin
 point_to_check := LowerCase(point_to_check); // Umwandeln des Strings in Kleinbuchstaben
 a:=0;b:=0;c:=0;d:=0;

 // 01
 if point_to_check = '01' then begin a := fieldstatus[2];
 b := fieldstatus[3]; c := fieldstatus[8]; d := fieldstatus[7]; end
 // 02
 else if point_to_check = '02' then begin a := fieldstatus[1];
 b := fieldstatus[3]; c := fieldstatus[10]; d := fieldstatus[18]; end
 // 03
 else if point_to_check = '03' then begin a := fieldstatus[1];
 b := fieldstatus[2]; c := fieldstatus[4]; d := fieldstatus[5]; end
 // 04
 else if point_to_check = '04' then begin a := fieldstatus[3];
 b := fieldstatus[5]; c := fieldstatus[12]; d := fieldstatus[20]; end
 // 05
 else if point_to_check = '05' then begin a := fieldstatus[4];
 b := fieldstatus[3]; c := fieldstatus[6]; d := fieldstatus[7]; end
 // 06
 else if point_to_check = '06' then begin a := fieldstatus[5];
 b := fieldstatus[7]; c := fieldstatus[14]; d := fieldstatus[22]; end
 // 07
 else if point_to_check = '07' then begin a := fieldstatus[6];
 b := fieldstatus[5]; c := fieldstatus[8]; d := fieldstatus[1]; end
 // 08
 else if point_to_check = '08' then begin a := fieldstatus[7];
 b := fieldstatus[1]; c := fieldstatus[16]; d := fieldstatus[24]; end
 // 09
 else if point_to_check = '09' then begin a := fieldstatus[10];
 b := fieldstatus[11]; c := fieldstatus[16]; d := fieldstatus[15]; end
 // 10
 else if point_to_check = '10' then begin a := fieldstatus[9];
 b := fieldstatus[11]; c := fieldstatus[2]; d := fieldstatus[18]; end
 // 11
 else if point_to_check = '11' then begin a := fieldstatus[9];
 b := fieldstatus[10]; c := fieldstatus[12]; d := fieldstatus[13]; end
 // 12
 else if point_to_check = '12' then begin a := fieldstatus[11];
 b := fieldstatus[13]; c := fieldstatus[4]; d := fieldstatus[20]; end
 // 13
 else if point_to_check = '13' then begin a := fieldstatus[11];
 b := fieldstatus[12]; c := fieldstatus[14]; d := fieldstatus[15]; end
 // 14
 else if point_to_check = '14' then begin a := fieldstatus[13];
 b := fieldstatus[15]; c := fieldstatus[6]; d := fieldstatus[22]; end
 // 15
 else if point_to_check = '15' then begin a := fieldstatus[14];
 b := fieldstatus[13]; c := fieldstatus[16]; d := fieldstatus[9]; end
 // 16
 else if point_to_check = '16' then begin a := fieldstatus[15];
 b := fieldstatus[9]; c := fieldstatus[8]; d := fieldstatus[24]; end
 // 17
 else if point_to_check = '17' then begin a := fieldstatus[18];
 b := fieldstatus[19]; c := fieldstatus[24]; d := fieldstatus[23]; end
 // 18
 else if point_to_check = '18' then begin a := fieldstatus[17];
 b := fieldstatus[19]; c := fieldstatus[2]; d := fieldstatus[10]; end
 // 19
 else if point_to_check = '19' then begin a := fieldstatus[17];
 b := fieldstatus[18]; c := fieldstatus[20]; d := fieldstatus[21]; end
 // 20
 else if point_to_check = '20' then begin a := fieldstatus[19];
 b := fieldstatus[21]; c := fieldstatus[4]; d := fieldstatus[12]; end
 // 21
 else if point_to_check = '21' then begin a := fieldstatus[19];
 b := fieldstatus[20]; c := fieldstatus[22]; d := fieldstatus[23]; end
 // 22
 else if point_to_check = '22' then begin a := fieldstatus[21];
 b := fieldstatus[23]; c := fieldstatus[6]; d := fieldstatus[14]; end
 // 23
 else if point_to_check = '23' then begin a := fieldstatus[22];
 b := fieldstatus[21]; c := fieldstatus[24]; d := fieldstatus[17]; end
 // 24
 else if point_to_check = '24' then begin a := fieldstatus[23];
 b := fieldstatus[17]; c := fieldstatus[8]; d := fieldstatus[16]; end;

 // Mühlecheck
 if (a and b) = mpr then begin ismuehle := true; exit; end
 else if (c and d) = mpr then begin ismuehle := true; exit; end;

 ismuehle := false;
end;

// Diese Funktion überorüft ob nur blockierte Steine auf dem Feld sind.
// Solche Steine sind z.B. Steine innerhalb einer Mühle.
// Solche Steine können z.B. bei einer Mühle nicht gezogen werden.
function onlylockedstonesonfield(fieldstatus: feldstatus; mpr: Integer) : Boolean;
var i: Integer;
begin
 for i := 1 to 24 do
 begin
  if fieldstatus[i] = mpr then
  begin
   if ismuehle(GetCorrectResultString(IntToStr(i)), fieldstatus, mpr) = false then
   begin
    onlylockedstonesonfield := false;
    exit;
   end;
  end;
 end;

 onlylockedstonesonfield:=true;
end;

// Diese Funktion überprüft ob ein Zug laut den Regeln möglich ist.
function validmove (von, nach: string; fieldstatus: feldstatus; mpr: Integer; playergamephase: Integer) : Boolean;
var
 phase1: Boolean;
 i: integer;
begin
 von := LowerCase(von); nach := LowerCase(nach);
 phase1 := false;

 if (playergamephase = 0) or (playergamephase = 2) then
 begin
  for i := 1 to 24 do
  begin
   if nach = GetCorrectResultString(IntToStr(i)) then
   begin
    if fieldstatus[i] = 0 then
    begin
     validmove := true;
     exit;
    end;
   end;
  end;
 end
 else phase1 := true;

 if phase1 = true then
 begin

    // 01
    if von = '01' then begin
     if nach = '02' then begin if fieldstatus[2] = 0 then begin validmove := true; exit; end; end;
     if nach = '08' then begin if fieldstatus[8] = 0 then begin validmove := true; exit; end; end;
    end
    // 02
    else if von = '02' then begin
     if nach = '01' then begin if fieldstatus[1] = 0 then begin validmove := true; exit; end; end;
     if nach = '03' then begin if fieldstatus[3] = 0 then begin validmove := true; exit; end; end;
     if nach = '10' then begin if fieldstatus[10] = 0 then begin validmove := true; exit; end; end;
    end
    // 03
    else if von = '03' then begin
     if nach = '02' then begin if fieldstatus[2] = 0 then begin validmove := true; exit; end; end;
     if nach = '04' then begin if fieldstatus[4] = 0 then begin validmove := true; exit; end; end;
    end
    // 04
    else if von = '04' then begin
     if nach = '03' then begin if fieldstatus[3] = 0 then begin validmove := true; exit; end; end;
     if nach = '05' then begin if fieldstatus[5] = 0 then begin validmove := true; exit; end; end;
     if nach = '12' then begin if fieldstatus[12] = 0 then begin validmove := true; exit; end; end;
    end
    // 05
    else if von = '05' then begin
     if nach = '04' then begin if fieldstatus[4] = 0 then begin validmove := true; exit; end; end;
     if nach = '06' then begin if fieldstatus[6] = 0 then begin validmove := true; exit; end; end;
    end
    // 06
    else if von = '06' then begin
     if nach = '05' then begin if fieldstatus[5] = 0 then begin validmove := true; exit; end; end;
     if nach = '07' then begin if fieldstatus[7] = 0 then begin validmove := true; exit; end; end;
     if nach = '14' then begin if fieldstatus[14] = 0 then begin validmove := true; exit; end; end;
    end
    // 07
    else if von = '07' then begin
     if nach = '06' then begin if fieldstatus[6] = 0 then begin validmove := true; exit; end; end;
     if nach = '08' then begin if fieldstatus[8] = 0 then begin validmove := true; exit; end; end;
    end
    // 08
    else if von = '08' then begin
     if nach = '07' then begin if fieldstatus[7] = 0 then begin validmove := true; exit; end; end;
     if nach = '01' then begin if fieldstatus[1] = 0 then begin validmove := true; exit; end; end;
     if nach = '16' then begin if fieldstatus[16] = 0 then begin validmove := true; exit; end; end;
    end
    // 09
    else if von = '09' then begin
     if nach = '10' then begin if fieldstatus[10] = 0 then begin validmove := true; exit; end; end;
     if nach = '16' then begin if fieldstatus[16] = 0 then begin validmove := true; exit; end; end;
    end
    // 10
    else if von = '10' then begin
     if nach = '09' then begin if fieldstatus[9] = 0 then begin validmove := true; exit; end; end;
     if nach = '11' then begin if fieldstatus[11] = 0 then begin validmove := true; exit; end; end;
     if nach = '02' then begin if fieldstatus[2] = 0 then begin validmove := true; exit; end; end;
     if nach = '18' then begin if fieldstatus[18] = 0 then begin validmove := true; exit; end; end;
    end
    // 11
    else if von = '11' then begin
     if nach = '10' then begin if fieldstatus[10] = 0 then begin validmove := true; exit; end; end;
     if nach = '12' then begin if fieldstatus[12] = 0 then begin validmove := true; exit; end; end;
    end
    // 12
    else if von = '12' then begin
     if nach = '11' then begin if fieldstatus[11] = 0 then begin validmove := true; exit; end; end;
     if nach = '13' then begin if fieldstatus[13] = 0 then begin validmove := true; exit; end; end;
     if nach = '04' then begin if fieldstatus[4] = 0 then begin validmove := true; exit; end; end;
     if nach = '20' then begin if fieldstatus[20] = 0 then begin validmove := true; exit; end; end;
    end
    // 13
    else if von = '13' then begin
     if nach = '12' then begin if fieldstatus[12] = 0 then begin validmove := true; exit; end; end;
     if nach = '14' then begin if fieldstatus[14] = 0 then begin validmove := true; exit; end; end;
    end
    // 14
    else if von = '14' then begin
     if nach = '13' then begin if fieldstatus[13] = 0 then begin validmove := true; exit; end; end;
     if nach = '15' then begin if fieldstatus[15] = 0 then begin validmove := true; exit; end; end;
     if nach = '06' then begin if fieldstatus[6] = 0 then begin validmove := true; exit; end; end;
     if nach = '22' then begin if fieldstatus[22] = 0 then begin validmove := true; exit; end; end;
    end
    // 15
    else if von = '15' then begin
     if nach = '14' then begin if fieldstatus[14] = 0 then begin validmove := true; exit; end; end;
     if nach = '16' then begin if fieldstatus[16] = 0 then begin validmove := true; exit; end; end;
    end
    // 16
    else if von = '16' then begin
     if nach = '15' then begin if fieldstatus[15] = 0 then begin validmove := true; exit; end; end;
     if nach = '09' then begin if fieldstatus[9] = 0 then begin validmove := true; exit; end; end;
     if nach = '08' then begin if fieldstatus[8] = 0 then begin validmove := true; exit; end; end;
     if nach = '24' then begin if fieldstatus[24] = 0 then begin validmove := true; exit; end; end;
    end
    // 17
    else if von = '17' then begin
     if nach = '18' then begin if fieldstatus[18] = 0 then begin validmove := true; exit; end; end;
     if nach = '24' then begin if fieldstatus[24] = 0 then begin validmove := true; exit; end; end;
    end
    // 18
    else if von = '18' then begin
     if nach = '17' then begin if fieldstatus[17] = 0 then begin validmove := true; exit; end; end;
     if nach = '19' then begin if fieldstatus[19] = 0 then begin validmove := true; exit; end; end;
     if nach = '10' then begin if fieldstatus[10] = 0 then begin validmove := true; exit; end; end;
   end
    // 19
    else if von = '19' then begin
     if nach = '18' then begin if fieldstatus[18] = 0 then begin validmove := true; exit; end; end;
     if nach = '20' then begin if fieldstatus[20] = 0 then begin validmove := true; exit; end; end;
   end
    // 20
    else if von = '20' then begin
     if nach = '19' then begin if fieldstatus[19] = 0 then begin validmove := true; exit; end; end;
     if nach = '21' then begin if fieldstatus[21] = 0 then begin validmove := true; exit; end; end;
     if nach = '12' then begin if fieldstatus[12] = 0 then begin validmove := true; exit; end; end;
   end
    // 21
    else if von = '21' then begin
     if nach = '20' then begin if fieldstatus[20] = 0 then begin validmove := true; exit; end; end;
     if nach = '22' then begin if fieldstatus[22] = 0 then begin validmove := true; exit; end; end;
   end
    // 22
    else if von = '22' then begin
     if nach = '21' then begin if fieldstatus[21] = 0 then begin validmove := true; exit; end; end;
     if nach = '23' then begin if fieldstatus[23] = 0 then begin validmove := true; exit; end; end;
     if nach = '14' then begin if fieldstatus[14] = 0 then begin validmove := true; exit; end; end;
    end
    // 23
    else if von = '23' then begin
     if nach = '22' then begin if fieldstatus[22] = 0 then begin validmove := true; exit; end; end;
     if nach = '24' then begin if fieldstatus[24] = 0 then begin validmove := true; exit; end; end;
   end
    // 24
    else if von = '24' then begin
     if nach = '23' then begin if fieldstatus[23] = 0 then begin validmove := true; exit; end; end;
     if nach = '17' then begin if fieldstatus[17] = 0 then begin validmove := true; exit; end; end;
     if nach = '16' then begin if fieldstatus[16] = 0 then begin validmove := true; exit; end; end;
       end
   end;

validmove := false;
end;

// Gibt einen Zug in der Spielphase 2 zurück
function givevalidmovep2(ausgangspunkt: string; fieldstatus: feldstatus;
                         mpr: integer; playergamephase: integer) : string;
var i: integer;
begin

for i := 1 to 24 do
begin
   if validmove(ausgangspunkt, GetCorrectResultString(IntToStr(i)), fieldstatus, mpr, playergamephase) = true then
   begin
    Result := ausgangspunkt + GetCorrectResultString(IntToStr(i));
    Exit;
   end;
end;

Result := 'none';
end;

// Setzt einen Stein
function setfield(fieldstatus: feldstatus; field: string; value: integer) : Boolean;
var i: Integer;
begin
 for i := 1 to 24 do
 begin
  if field = GetCorrectResultString(IntToStr(i)) then fieldstatus[i] := value;
 end;

 Result := true;
end;


// Gibt einen Zug zurück.
function GetMove(fieldstatus: feldstatus; mpr: Integer; playergamephase: Integer;
                 removemode: Boolean) : PChar;
var rnr: Byte; //Random Number
    removelist: TStrings;
    p3mprfields: TStrings;
    p3blankfields: TStrings;
    stones: integer;
    p3string: string;
    i, j, k, l, m, n, o, p, q: Integer; // Schleifenvariablen
begin
Randomize;
rnr := 0;

if removemode = true then //stein wegnehmen
begin
removelist := TStringlist.Create;


 for k := 1 to 24 do
 begin
  if fieldstatus[k] = invmpr(mpr) then removelist.add(GetCorrectResultString(IntToStr(k)));
 end;

// alle removebaren steine in liste setzen

while rnr <> removelist.Count+2 do //endlosschleife
begin
 rnr := random(removelist.Count);

 if (ismuehle(removelist.Strings[rnr], fieldstatus, invmpr(mpr)) = false) or
    (onlylockedstonesonfield(fieldstatus, invmpr(mpr)) = true) then
  begin

   for l := 1 to 24 do
   begin
    if removelist.Strings[rnr] = GetCorrectResultString(IntToStr(l)) then Result := PChar(GetCorrectResultString(IntToStr(l)));
   end;

   removelist.free;
   Exit;
  end;
end;
end;

if playergamephase = 0 then // Eröffnung
begin
 // Überprüfung ob Feld leer ist
 // Danach überprüfung ob sich eine Mühle ergibt
 // Wenn sich Mühle ergibt dann gib Zug zurück
 //Wenn keine mühle gefunden wird dann wird versucht eine gegnerische mühle zu blokieren.
  //01
 if fieldstatus[1] = 0 then begin fieldstatus[1] := mpr;
  if ismuehle('01', fieldstatus, mpr) = true then begin fieldstatus[1] := 0; Result := '01';  Exit; end;
  fieldstatus[1] := 0;
 end;
 //02
 if fieldstatus[2] = 0 then begin fieldstatus[2] := mpr;
  if ismuehle('02', fieldstatus, mpr) = true then begin fieldstatus[2] := 0; Result := '02';  Exit; end;
  fieldstatus[2] := 0;
 end;
 //03
 if fieldstatus[3] = 0 then begin fieldstatus[3] := mpr;
  if ismuehle('03', fieldstatus, mpr) = true then begin fieldstatus[3] := 0; Result := '03';  Exit; end;
  fieldstatus[3] := 0;
 end;
 //04
 if fieldstatus[4] = 0 then begin fieldstatus[4] := mpr;
  if ismuehle('04', fieldstatus, mpr) = true then begin fieldstatus[4] := 0; Result := '04';  Exit; end;
  fieldstatus[4] := 0;
 end;
 //05
 if fieldstatus[5] = 0 then begin fieldstatus[5] := mpr;
  if ismuehle('05', fieldstatus, mpr) = true then begin fieldstatus[5] := 0; Result := '05';  Exit; end;
  fieldstatus[5] := 0;
 end;
 //06
 if fieldstatus[6] = 0 then begin fieldstatus[6] := mpr;
  if ismuehle('06', fieldstatus, mpr) = true then begin fieldstatus[6] := 0; Result := '06';  Exit; end;
  fieldstatus[6] := 0;
 end;
 //07
 if fieldstatus[7] = 0 then begin fieldstatus[7] := mpr;
  if ismuehle('07', fieldstatus, mpr) = true then begin fieldstatus[7] := 0; Result := '07';  Exit; end;
  fieldstatus[7] := 0;
 end;
 //08
 if fieldstatus[8] = 0 then begin fieldstatus[8] := mpr;
  if ismuehle('08', fieldstatus, mpr) = true then begin fieldstatus[8] := 0; Result := '08';  Exit; end;
  fieldstatus[8] := 0;
 end;
 //09
 if fieldstatus[9] = 0 then begin fieldstatus[9] := mpr;
  if ismuehle('09', fieldstatus, mpr) = true then begin fieldstatus[9] := 0; Result := '09';  Exit; end;
  fieldstatus[9] := 0;
 end;
 //10
 if fieldstatus[10] = 0 then begin fieldstatus[10] := mpr;
  if ismuehle('10', fieldstatus, mpr) = true then begin fieldstatus[10] := 0; Result := '10';  Exit; end;
  fieldstatus[10] := 0;
 end;
 //11
 if fieldstatus[11] = 0 then begin fieldstatus[11] := mpr;
  if ismuehle('11', fieldstatus, mpr) = true then begin fieldstatus[11] := 0; Result := '11';  Exit; end;
  fieldstatus[11] := 0;
 end;
 //12
 if fieldstatus[12] = 0 then begin fieldstatus[12] := mpr;
  if ismuehle('12', fieldstatus, mpr) = true then begin fieldstatus[12] := 0; Result := '12';  Exit; end;
  fieldstatus[12] := 0;
 end;
 //13
 if fieldstatus[13] = 0 then begin fieldstatus[13] := mpr;
  if ismuehle('13', fieldstatus, mpr) = true then begin fieldstatus[13] := 0; Result := '13';  Exit; end;
  fieldstatus[13] := 0;
 end;
 //14
 if fieldstatus[14] = 0 then begin fieldstatus[14] := mpr;
  if ismuehle('14', fieldstatus, mpr) = true then begin fieldstatus[14] := 0; Result := '14';  Exit; end;
  fieldstatus[14] := 0;
 end;
 //15
 if fieldstatus[15] = 0 then begin fieldstatus[15] := mpr;
  if ismuehle('15', fieldstatus, mpr) = true then begin fieldstatus[15] := 0; Result := '15';  Exit; end;
  fieldstatus[15] := 0;
 end;
 //16
 if fieldstatus[16] = 0 then begin fieldstatus[16] := mpr;
  if ismuehle('16', fieldstatus, mpr) = true then begin fieldstatus[16] := 0; Result := '16';  Exit; end;
  fieldstatus[16] := 0;
 end;
//17
 if fieldstatus[17] = 0 then begin fieldstatus[17] := mpr;
  if ismuehle('17', fieldstatus, mpr) = true then begin fieldstatus[17] := 0; Result := '17';  Exit; end;
  fieldstatus[17] := 0;
 end;
 //18
 if fieldstatus[18] = 0 then begin fieldstatus[18] := mpr;
  if ismuehle('18', fieldstatus, mpr) = true then begin fieldstatus[18] := 0; Result := '18';  Exit; end;
  fieldstatus[18] := 0;
 end;
 //19
 if fieldstatus[19] = 0 then begin fieldstatus[19] := mpr;
  if ismuehle('19', fieldstatus, mpr) = true then begin fieldstatus[19] := 0; Result := '19';  Exit; end;
  fieldstatus[19] := 0;
 end;
 //20
 if fieldstatus[20] = 0 then begin fieldstatus[20] := mpr;
  if ismuehle('20', fieldstatus, mpr) = true then begin fieldstatus[20] := 0; Result := '20';  Exit; end;
  fieldstatus[20] := 0;
 end;
 //21
 if fieldstatus[21] = 0 then begin fieldstatus[21] := mpr;
  if ismuehle('21', fieldstatus, mpr) = true then begin fieldstatus[21] := 0; Result := '21';  Exit; end;
  fieldstatus[21] := 0;
 end;
 //22
 if fieldstatus[22] = 0 then begin fieldstatus[22] := mpr;
  if ismuehle('22', fieldstatus, mpr) = true then begin fieldstatus[22] := 0; Result := '22';  Exit; end;
  fieldstatus[22] := 0;
 end;
 //23
 if fieldstatus[23] = 0 then begin fieldstatus[23] := mpr;
  if ismuehle('23', fieldstatus, mpr) = true then begin fieldstatus[23] := 0; Result := '23';  Exit; end;
  fieldstatus[23] := 0;
 end;
 //24
 if fieldstatus[24] = 0 then begin fieldstatus[24] := mpr;
  if ismuehle('24', fieldstatus, mpr) = true then begin fieldstatus[24] := 0; Result := '24';  Exit; end;
  fieldstatus[24] := 0;
 end;

 //Wenn keine mühle gefunden wird dann wird versucht eine gegnerische mühle zu blokieren.
  //01
 if fieldstatus[1] = 0 then begin fieldstatus[1] := invmpr(mpr);
  if ismuehle('01', fieldstatus, invmpr(mpr)) = true then begin fieldstatus[1] := 0; Result := '01';  Exit; end;
  fieldstatus[1] := 0;
 end;
 //02
 if fieldstatus[2] = 0 then begin fieldstatus[2] := invmpr(mpr);
  if ismuehle('02', fieldstatus, invmpr(mpr)) = true then begin fieldstatus[2] := 0; Result := '02';  Exit; end;
  fieldstatus[2] := 0;
 end;
 //03
 if fieldstatus[3] = 0 then begin fieldstatus[3] := invmpr(mpr);
  if ismuehle('03', fieldstatus, invmpr(mpr)) = true then begin fieldstatus[3] := 0; Result := '03';  Exit; end;
  fieldstatus[3] := 0;
 end;
 //04
 if fieldstatus[4] = 0 then begin fieldstatus[4] := invmpr(mpr);
  if ismuehle('04', fieldstatus, invmpr(mpr)) = true then begin fieldstatus[4] := 0; Result := '04';  Exit; end;
  fieldstatus[4] := 0;
 end;
 //05
 if fieldstatus[5] = 0 then begin fieldstatus[5] := invmpr(mpr);
  if ismuehle('05', fieldstatus, invmpr(mpr)) = true then begin fieldstatus[5] := 0; Result := '05';  Exit; end;
  fieldstatus[5] := 0;
 end;
 //06
 if fieldstatus[6] = 0 then begin fieldstatus[6] := invmpr(mpr);
  if ismuehle('06', fieldstatus, invmpr(mpr)) = true then begin fieldstatus[6] := 0; Result := '06';  Exit; end;
  fieldstatus[6] := 0;
 end;
 //07
 if fieldstatus[7] = 0 then begin fieldstatus[7] := invmpr(mpr);
  if ismuehle('07', fieldstatus, invmpr(mpr)) = true then begin fieldstatus[7] := 0; Result := '07';  Exit; end;
  fieldstatus[7] := 0;
 end;
 //08
 if fieldstatus[8] = 0 then begin fieldstatus[8] := invmpr(mpr);
  if ismuehle('08', fieldstatus, invmpr(mpr)) = true then begin fieldstatus[8] := 0; Result := '08';  Exit; end;
  fieldstatus[8] := 0;
 end;
 //09
 if fieldstatus[9] = 0 then begin fieldstatus[9] := invmpr(mpr);
  if ismuehle('09', fieldstatus, invmpr(mpr)) = true then begin fieldstatus[9] := 0; Result := '09';  Exit; end;
  fieldstatus[9] := 0;
 end;
 //10
 if fieldstatus[10] = 0 then begin fieldstatus[10] := invmpr(mpr);
  if ismuehle('10', fieldstatus, invmpr(mpr)) = true then begin fieldstatus[10] := 0; Result := '10';  Exit; end;
  fieldstatus[10] := 0;
 end;
 //11
 if fieldstatus[11] = 0 then begin fieldstatus[11] := invmpr(mpr);
  if ismuehle('11', fieldstatus, invmpr(mpr)) = true then begin fieldstatus[11] := 0; Result := '11';  Exit; end;
  fieldstatus[11] := 0;
 end;
 //12
 if fieldstatus[12] = 0 then begin fieldstatus[12] := invmpr(mpr);
  if ismuehle('12', fieldstatus, invmpr(mpr)) = true then begin fieldstatus[12] := 0; Result := '12';  Exit; end;
  fieldstatus[12] := 0;
 end;
 //13
 if fieldstatus[13] = 0 then begin fieldstatus[13] := invmpr(mpr);
  if ismuehle('13', fieldstatus, invmpr(mpr)) = true then begin fieldstatus[13] := 0; Result := '13';  Exit; end;
  fieldstatus[13] := 0;
 end;
 //14
 if fieldstatus[14] = 0 then begin fieldstatus[14] := invmpr(mpr);
  if ismuehle('14', fieldstatus, invmpr(mpr)) = true then begin fieldstatus[14] := 0; Result := '14';  Exit; end;
  fieldstatus[14] := 0;
 end;
 //15
 if fieldstatus[15] = 0 then begin fieldstatus[15] := invmpr(mpr);
  if ismuehle('15', fieldstatus, invmpr(mpr)) = true then begin fieldstatus[15] := 0; Result := '15';  Exit; end;
  fieldstatus[15] := 0;
 end;
 //16
 if fieldstatus[16] = 0 then begin fieldstatus[16] := invmpr(mpr);
  if ismuehle('16', fieldstatus, invmpr(mpr)) = true then begin fieldstatus[16] := 0; Result := '16';  Exit; end;
  fieldstatus[16] := 0;
 end;
//17
 if fieldstatus[17] = 0 then begin fieldstatus[17] := invmpr(mpr);
  if ismuehle('17', fieldstatus, invmpr(mpr)) = true then begin fieldstatus[17] := 0; Result := '17';  Exit; end;
  fieldstatus[17] := 0;
 end;
 //18
 if fieldstatus[18] = 0 then begin fieldstatus[18] := invmpr(mpr);
  if ismuehle('18', fieldstatus, invmpr(mpr)) = true then begin fieldstatus[18] := 0; Result := '18';  Exit; end;
  fieldstatus[18] := 0;
 end;
 //19
 if fieldstatus[19] = 0 then begin fieldstatus[19] := invmpr(mpr);
  if ismuehle('19', fieldstatus, invmpr(mpr)) = true then begin fieldstatus[19] := 0; Result := '19';  Exit; end;
  fieldstatus[19] := 0;
 end;
 //20
 if fieldstatus[20] = 0 then begin fieldstatus[20] := invmpr(mpr);
  if ismuehle('20', fieldstatus, invmpr(mpr)) = true then begin fieldstatus[20] := 0; Result := '20';  Exit; end;
  fieldstatus[20] := 0;
 end;
 //21
 if fieldstatus[21] = 0 then begin fieldstatus[21] := invmpr(mpr);
  if ismuehle('21', fieldstatus, invmpr(mpr)) = true then begin fieldstatus[21] := 0; Result := '21';  Exit; end;
  fieldstatus[21] := 0;
 end;
 //22
 if fieldstatus[22] = 0 then begin fieldstatus[22] := invmpr(mpr);
  if ismuehle('22', fieldstatus, invmpr(mpr)) = true then begin fieldstatus[22] := 0; Result := '22';  Exit; end;
  fieldstatus[22] := 0;
 end;
 //23
 if fieldstatus[23] = 0 then begin fieldstatus[23] := invmpr(mpr);
  if ismuehle('23', fieldstatus, invmpr(mpr)) = true then begin fieldstatus[23] := 0; Result := '23';  Exit; end;
  fieldstatus[23] := 0;
 end;
 //24
 if fieldstatus[24] = 0 then begin fieldstatus[24] := invmpr(mpr);
  if ismuehle('24', fieldstatus, invmpr(mpr)) = true then begin fieldstatus[24] := 0; Result := '24';  Exit; end;
  fieldstatus[24] := 0;
 end;

 // Wenn auch keine gegnerische mühle blockiert wird so wird versucht eine mühle vorzubereiten
 // to do : muss gemacht werden

 // Setze zufällig einen Stein
 while rnr <> 26 do // erzeugt endlosschleife
 begin
  rnr := random(25); //Verhindere das Random 0 zurück gibt

  for m := 1 to 24 do
  begin
   if rnr = m then
   begin
    if fieldstatus[m] = 0 then
    begin
     Result := PChar(GetCorrectResultString(IntToStr(m)));
     Exit;
    end;
   end;
  end;
 end;

end  // Gamephase 0 Ende (Eröffnung)

else if playergamephase = 1 then // Hauptspiel
begin
 //Überprüfen ob durch einen zug auf einen anderen eine mühle entsteht
 //01
 if fieldstatus[1] = mpr then
 begin
  if validmove('01', '02', fieldstatus, mpr, playergamephase) = true then
  begin fieldstatus[1] := 0; fieldstatus[2] := mpr;
   if ismuehle('02', fieldstatus, mpr) = true then
   begin fieldstatus[1] := mpr; fieldstatus[2] := 0; Result := '0102'; Exit; end;
   fieldstatus[1] := mpr;
   fieldstatus[2] := 0;
  end;

  if validmove('01', '08', fieldstatus, mpr, playergamephase) = true then
  begin fieldstatus[1] := 0; fieldstatus[8] := mpr;
   if ismuehle('08', fieldstatus, mpr) = true then
   begin fieldstatus[1] := mpr; fieldstatus[8] := 0; Result := '0108'; Exit; end;
   fieldstatus[1] := mpr; fieldstatus[8] := 0;
  end;
 end;

 //02
 if fieldstatus[2] = mpr then
 begin
  if validmove('02', '01', fieldstatus, mpr, playergamephase) = true then
  begin fieldstatus[2] := 0; fieldstatus[1] := mpr;
   if ismuehle('01', fieldstatus, mpr) = true then
   begin fieldstatus[2] := mpr; fieldstatus[1] := 0; Result := '0201'; Exit; end;
   fieldstatus[2] := mpr;
   fieldstatus[1] := 0;
  end;

  if validmove('02', '03', fieldstatus, mpr, playergamephase) = true then
  begin fieldstatus[2] := 0; fieldstatus[3] := mpr;
   if ismuehle('03', fieldstatus, mpr) = true then
   begin fieldstatus[2] := mpr; fieldstatus[3] := 0; Result := '0203'; Exit; end;
   fieldstatus[2] := mpr; fieldstatus[3] := 0;
  end;

  if validmove('02', '10', fieldstatus, mpr, playergamephase) = true then
  begin fieldstatus[2] := 0; fieldstatus[10] := mpr;
   if ismuehle('10', fieldstatus, mpr) = true then
   begin fieldstatus[2] := mpr; fieldstatus[10] := 0; Result := '0210'; Exit; end;
   fieldstatus[2] := mpr; fieldstatus[10] := 0;
  end;
 end;

 //03
 if fieldstatus[3] = mpr then
 begin
  if validmove('03', '02', fieldstatus, mpr, playergamephase) = true then
  begin fieldstatus[3] := 0; fieldstatus[2] := mpr;
   if ismuehle('02', fieldstatus, mpr) = true then
   begin fieldstatus[3] := mpr; fieldstatus[2] := 0; Result := '0302'; Exit; end;
   fieldstatus[3] := mpr;
   fieldstatus[2] := 0;
  end;

  if validmove('03', '04', fieldstatus, mpr, playergamephase) = true then
  begin fieldstatus[3] := 0; fieldstatus[4] := mpr;
   if ismuehle('04', fieldstatus, mpr) = true then
   begin fieldstatus[3] := mpr; fieldstatus[4] := 0; Result := '0304'; Exit; end;
   fieldstatus[3] := mpr;
   fieldstatus[4] := 0;
  end;
 end;

 //04
 if fieldstatus[4] = mpr then
 begin
  if validmove('04', '03', fieldstatus, mpr, playergamephase) = true then
  begin fieldstatus[4] := 0; fieldstatus[3] := mpr;
   if ismuehle('03', fieldstatus, mpr) = true then
   begin fieldstatus[4] := mpr; fieldstatus[3] := 0; Result := '0403'; Exit; end;
   fieldstatus[4] := mpr;
   fieldstatus[3] := 0;
  end;

  if validmove('04', '05', fieldstatus, mpr, playergamephase) = true then
  begin fieldstatus[4] := 0; fieldstatus[5] := mpr;
   if ismuehle('05', fieldstatus, mpr) = true then
   begin fieldstatus[4] := mpr; fieldstatus[5] := 0; Result := '0405'; Exit; end;
   fieldstatus[4] := mpr;
   fieldstatus[5] := 0;
  end;

  if validmove('04', '12', fieldstatus, mpr, playergamephase) = true then
  begin fieldstatus[4] := 0; fieldstatus[12] := mpr;
   if ismuehle('12', fieldstatus, mpr) = true then
   begin fieldstatus[4] := mpr; fieldstatus[12] := 0; Result := '0412'; Exit; end;
   fieldstatus[4] := mpr;
   fieldstatus[12] := 0;
  end;
 end;

 //05
 if fieldstatus[5] = mpr then
 begin
  if validmove('05', '04', fieldstatus, mpr, playergamephase) = true then
  begin fieldstatus[5] := 0; fieldstatus[4] := mpr;
   if ismuehle('04', fieldstatus, mpr) = true then
   begin fieldstatus[5] := mpr; fieldstatus[4] := 0; Result := '0504'; Exit; end;
   fieldstatus[5] := mpr;
   fieldstatus[4] := 0;
  end;

  if validmove('05', '06', fieldstatus, mpr, playergamephase) = true then
  begin fieldstatus[5] := 0; fieldstatus[6] := mpr;
   if ismuehle('06', fieldstatus, mpr) = true then
   begin fieldstatus[5] := mpr; fieldstatus[6] := 0; Result := '0506'; Exit; end;
   fieldstatus[5] := mpr;
   fieldstatus[6] := 0;
  end;
 end;

 //06
 if fieldstatus[6] = mpr then
 begin
  if validmove('06', '05', fieldstatus, mpr, playergamephase) = true then
  begin fieldstatus[6] := 0; fieldstatus[5] := mpr;
   if ismuehle('05', fieldstatus, mpr) = true then
   begin fieldstatus[6] := mpr; fieldstatus[5] := 0; Result := '0605'; Exit; end;
   fieldstatus[6] := mpr;
   fieldstatus[5] := 0;
  end;

  if validmove('06', '07', fieldstatus, mpr, playergamephase) = true then
  begin fieldstatus[6] := 0; fieldstatus[7] := mpr;
   if ismuehle('07', fieldstatus, mpr) = true then
   begin fieldstatus[6] := mpr; fieldstatus[7] := 0; Result := '0607'; Exit; end;
   fieldstatus[6] := mpr;
   fieldstatus[7] := 0;
  end;

  if validmove('06', '14', fieldstatus, mpr, playergamephase) = true then
  begin fieldstatus[6] := 0; fieldstatus[14] := mpr;
   if ismuehle('14', fieldstatus, mpr) = true then
   begin fieldstatus[6] := mpr; fieldstatus[14] := 0; Result := '0614'; Exit; end;
   fieldstatus[6] := mpr;
   fieldstatus[14] := 0;
  end;
 end;

 //07
 if fieldstatus[7] = mpr then
 begin
  if validmove('07', '06', fieldstatus, mpr, playergamephase) = true then
  begin fieldstatus[7] := 0; fieldstatus[6] := mpr;
   if ismuehle('06', fieldstatus, mpr) = true then
   begin fieldstatus[7] := mpr; fieldstatus[6] := 0; Result := '0706'; Exit; end;
   fieldstatus[7] := mpr;
   fieldstatus[6] := 0;
  end;

  if validmove('07', '08', fieldstatus, mpr, playergamephase) = true then
  begin fieldstatus[7] := 0; fieldstatus[8] := mpr;
   if ismuehle('08', fieldstatus, mpr) = true then
   begin fieldstatus[7] := mpr; fieldstatus[8] := 0; Result := '0708'; Exit; end;
   fieldstatus[7] := mpr;
   fieldstatus[8] := 0;
  end;
 end;

 //08
 if fieldstatus[8] = mpr then
 begin
  if validmove('08', '07', fieldstatus, mpr, playergamephase) = true then
  begin fieldstatus[8] := 0; fieldstatus[7] := mpr;
   if ismuehle('07', fieldstatus, mpr) = true then
   begin fieldstatus[8] := mpr; fieldstatus[7] := 0; Result := '0807'; Exit; end;
   fieldstatus[8] := mpr;
   fieldstatus[7] := 0;
  end;

  if validmove('08', '01', fieldstatus, mpr, playergamephase) = true then
  begin fieldstatus[8] := 0; fieldstatus[1] := mpr;
   if ismuehle('01', fieldstatus, mpr) = true then
   begin fieldstatus[8] := mpr; fieldstatus[1] := 0; Result := '0801'; Exit; end;
   fieldstatus[8] := mpr;
   fieldstatus[1] := 0;
  end;

  if validmove('08', '16', fieldstatus, mpr, playergamephase) = true then
  begin fieldstatus[8] := 0; fieldstatus[16] := mpr;
   if ismuehle('16', fieldstatus, mpr) = true then
   begin fieldstatus[8] := mpr; fieldstatus[16] := 0; Result := '0816'; Exit; end;
   fieldstatus[8] := mpr;
   fieldstatus[16] := 0;
  end;
 end;

 //09
 if fieldstatus[9] = mpr then
 begin
  if validmove('09', '10', fieldstatus, mpr, playergamephase) = true then
  begin fieldstatus[9] := 0; fieldstatus[10] := mpr;
   if ismuehle('10', fieldstatus, mpr) = true then
   begin fieldstatus[9] := mpr; fieldstatus[10] := 0; Result := '0910'; Exit; end;
   fieldstatus[9] := mpr;
   fieldstatus[10] := 0;
  end;

  if validmove('09', '16', fieldstatus, mpr, playergamephase) = true then
  begin fieldstatus[9] := 0; fieldstatus[16] := mpr;
   if ismuehle('16', fieldstatus, mpr) = true then
   begin fieldstatus[9] := mpr; fieldstatus[16] := 0; Result := '0916'; Exit; end;
   fieldstatus[9] := mpr; fieldstatus[16] := 0;
  end;
 end;

 //10
 if fieldstatus[10] = mpr then
 begin
  if validmove('10', '09', fieldstatus, mpr, playergamephase) = true then
  begin fieldstatus[10] := 0; fieldstatus[9] := mpr;
   if ismuehle('09', fieldstatus, mpr) = true then
   begin fieldstatus[10] := mpr; fieldstatus[9] := 0; Result := '1009'; Exit; end;
   fieldstatus[10] := mpr;
   fieldstatus[9] := 0;
  end;

  if validmove('10', '11', fieldstatus, mpr, playergamephase) = true then
  begin fieldstatus[10] := 0; fieldstatus[11] := mpr;
   if ismuehle('11', fieldstatus, mpr) = true then
   begin fieldstatus[10] := mpr; fieldstatus[11] := 0; Result := '1011'; Exit; end;
   fieldstatus[10] := mpr; fieldstatus[11] := 0;
  end;

  if validmove('10', '02', fieldstatus, mpr, playergamephase) = true then
  begin fieldstatus[10] := 0; fieldstatus[2] := mpr;
   if ismuehle('02', fieldstatus, mpr) = true then
   begin fieldstatus[10] := mpr; fieldstatus[2] := 0; Result := '1002'; Exit; end;
   fieldstatus[10] := mpr; fieldstatus[2] := 0;
  end;
  
  if validmove('10', '18', fieldstatus, mpr, playergamephase) = true then
  begin fieldstatus[10] := 0; fieldstatus[18] := mpr;
   if ismuehle('18', fieldstatus, mpr) = true then
   begin fieldstatus[10] := mpr; fieldstatus[18] := 0; Result := '1018'; Exit; end;
   fieldstatus[10] := mpr; fieldstatus[18] := 0;
  end;
 end;

 //11
 if fieldstatus[11] = mpr then
 begin
  if validmove('11', '10', fieldstatus, mpr, playergamephase) = true then
  begin fieldstatus[11] := 0; fieldstatus[10] := mpr;
   if ismuehle('10', fieldstatus, mpr) = true then
   begin fieldstatus[11] := mpr; fieldstatus[10] := 0; Result := '1110'; Exit; end;
   fieldstatus[11] := mpr;
   fieldstatus[10] := 0;
  end;

  if validmove('11', '12', fieldstatus, mpr, playergamephase) = true then
  begin fieldstatus[11] := 0; fieldstatus[12] := mpr;
   if ismuehle('12', fieldstatus, mpr) = true then
   begin fieldstatus[11] := mpr; fieldstatus[12] := 0; Result := '1112'; Exit; end;
   fieldstatus[11] := mpr;
   fieldstatus[12] := 0;
  end;
 end;

 //12
 if fieldstatus[12] = mpr then
 begin
  if validmove('12', '11', fieldstatus, mpr, playergamephase) = true then
  begin fieldstatus[12] := 0; fieldstatus[11] := mpr;
   if ismuehle('11', fieldstatus, mpr) = true then
   begin fieldstatus[12] := mpr; fieldstatus[11] := 0; Result := '1211'; Exit; end;
   fieldstatus[12] := mpr;
   fieldstatus[11] := 0;
  end;

  if validmove('12', '13', fieldstatus, mpr, playergamephase) = true then
  begin fieldstatus[12] := 0; fieldstatus[13] := mpr;
   if ismuehle('13', fieldstatus, mpr) = true then
   begin fieldstatus[12] := mpr; fieldstatus[13] := 0; Result := '1213'; Exit; end;
   fieldstatus[12] := mpr;
   fieldstatus[13] := 0;
  end;

  if validmove('12', '04', fieldstatus, mpr, playergamephase) = true then
  begin fieldstatus[12] := 0; fieldstatus[4] := mpr;
   if ismuehle('04', fieldstatus, mpr) = true then
   begin fieldstatus[12] := mpr; fieldstatus[4] := 0; Result := '1204'; Exit; end;
   fieldstatus[12] := mpr; fieldstatus[4] := 0;
  end;
  
  if validmove('12', '20', fieldstatus, mpr, playergamephase) = true then
  begin fieldstatus[12] := 0; fieldstatus[20] := mpr;
   if ismuehle('20', fieldstatus, mpr) = true then
   begin fieldstatus[12] := mpr; fieldstatus[20] := 0; Result := '1220'; Exit; end;
   fieldstatus[12] := mpr; fieldstatus[20] := 0;
  end;
 end;

 //13
 if fieldstatus[13] = mpr then
 begin
  if validmove('13', '12', fieldstatus, mpr, playergamephase) = true then
  begin fieldstatus[13] := 0; fieldstatus[12] := mpr;
   if ismuehle('12', fieldstatus, mpr) = true then
   begin fieldstatus[13] := mpr; fieldstatus[12] := 0; Result := '1312'; Exit; end;
   fieldstatus[13] := mpr;
   fieldstatus[12] := 0;
  end;

  if validmove('13', '14', fieldstatus, mpr, playergamephase) = true then
  begin fieldstatus[13] := 0; fieldstatus[14] := mpr;
   if ismuehle('14', fieldstatus, mpr) = true then
   begin fieldstatus[13] := mpr; fieldstatus[14] := 0; Result := '1314'; Exit; end;
   fieldstatus[13] := mpr;
   fieldstatus[14] := 0;
  end;
 end;

 //14
 if fieldstatus[14] = mpr then
 begin
  if validmove('14', '13', fieldstatus, mpr, playergamephase) = true then
  begin fieldstatus[14] := 0; fieldstatus[13] := mpr;
   if ismuehle('13', fieldstatus, mpr) = true then
   begin fieldstatus[14] := mpr; fieldstatus[13] := 0; Result := '1413'; Exit; end;
   fieldstatus[14] := mpr;
   fieldstatus[13] := 0;
  end;

  if validmove('14', '15', fieldstatus, mpr, playergamephase) = true then
  begin fieldstatus[14] := 0; fieldstatus[15] := mpr;
   if ismuehle('15', fieldstatus, mpr) = true then
   begin fieldstatus[14] := mpr; fieldstatus[15] := 0; Result := '1415'; Exit; end;
   fieldstatus[14] := mpr;
   fieldstatus[15] := 0;
  end;

  if validmove('14', '06', fieldstatus, mpr, playergamephase) = true then
  begin fieldstatus[14] := 0; fieldstatus[6] := mpr;
   if ismuehle('06', fieldstatus, mpr) = true then
   begin fieldstatus[14] := mpr; fieldstatus[6] := 0; Result := '1406'; Exit; end;
   fieldstatus[14] := mpr; fieldstatus[6] := 0;
  end;
  
  if validmove('14', '22', fieldstatus, mpr, playergamephase) = true then
  begin fieldstatus[14] := 0; fieldstatus[22] := mpr;
   if ismuehle('22', fieldstatus, mpr) = true then
   begin fieldstatus[14] := mpr; fieldstatus[22] := 0; Result := '1422'; Exit; end;
   fieldstatus[14] := mpr; fieldstatus[22] := 0;
  end;
 end;

 //15
 if fieldstatus[15] = mpr then
 begin
  if validmove('15', '14', fieldstatus, mpr, playergamephase) = true then
  begin fieldstatus[15] := 0; fieldstatus[14] := mpr;
   if ismuehle('14', fieldstatus, mpr) = true then
   begin fieldstatus[15] := mpr; fieldstatus[14] := 0; Result := '1514'; Exit; end;
   fieldstatus[15] := mpr;
   fieldstatus[14] := 0;
  end;

  if validmove('15', '16', fieldstatus, mpr, playergamephase) = true then
  begin fieldstatus[15] := 0; fieldstatus[16] := mpr;
   if ismuehle('16', fieldstatus, mpr) = true then
   begin fieldstatus[15] := mpr; fieldstatus[16] := 0; Result := '1516'; Exit; end;
   fieldstatus[15] := mpr;
   fieldstatus[16] := 0;
  end;
 end;

 //16
 if fieldstatus[16] = mpr then
 begin
  if validmove('16', '15', fieldstatus, mpr, playergamephase) = true then
  begin fieldstatus[16] := 0; fieldstatus[15] := mpr;
   if ismuehle('15', fieldstatus, mpr) = true then
   begin fieldstatus[16] := mpr; fieldstatus[15] := 0; Result := '1615'; Exit; end;
   fieldstatus[16] := mpr;
   fieldstatus[15] := 0;
  end;

  if validmove('16', '09', fieldstatus, mpr, playergamephase) = true then
  begin fieldstatus[16] := 0; fieldstatus[9] := mpr;
   if ismuehle('09', fieldstatus, mpr) = true then
   begin fieldstatus[16] := mpr; fieldstatus[9] := 0; Result := '1609'; Exit; end;
   fieldstatus[16] := mpr;
   fieldstatus[9] := 0;
  end;

  if validmove('16', '08', fieldstatus, mpr, playergamephase) = true then
  begin fieldstatus[16] := 0; fieldstatus[8] := mpr;
   if ismuehle('08', fieldstatus, mpr) = true then
   begin fieldstatus[16] := mpr; fieldstatus[8] := 0; Result := '1608'; Exit; end;
   fieldstatus[16] := mpr; fieldstatus[8] := 0;
  end;
  
  if validmove('16', '24', fieldstatus, mpr, playergamephase) = true then
  begin fieldstatus[16] := 0; fieldstatus[24] := mpr;
   if ismuehle('24', fieldstatus, mpr) = true then
   begin fieldstatus[16] := mpr; fieldstatus[24] := 0; Result := '1624'; Exit; end;
   fieldstatus[16] := mpr; fieldstatus[24] := 0;
  end;
 end;

 //17
 if fieldstatus[17] = mpr then
 begin
  if validmove('17', '18', fieldstatus, mpr, playergamephase) = true then
  begin fieldstatus[17] := 0; fieldstatus[18] := mpr;
   if ismuehle('18', fieldstatus, mpr) = true then
   begin fieldstatus[17] := mpr; fieldstatus[18] := 0; Result := '1718'; Exit; end;
   fieldstatus[17] := mpr;
   fieldstatus[18] := 0;
  end;

  if validmove('17', '24', fieldstatus, mpr, playergamephase) = true then
  begin fieldstatus[17] := 0; fieldstatus[24] := mpr;
   if ismuehle('24', fieldstatus, mpr) = true then
   begin fieldstatus[17] := mpr; fieldstatus[24] := 0; Result := '1724'; Exit; end;
   fieldstatus[17] := mpr; fieldstatus[24] := 0;
  end;
 end;

 //18
 if fieldstatus[18] = mpr then
 begin
  if validmove('18', '17', fieldstatus, mpr, playergamephase) = true then
  begin fieldstatus[18] := 0; fieldstatus[17] := mpr;
   if ismuehle('17', fieldstatus, mpr) = true then
   begin fieldstatus[18] := mpr; fieldstatus[17] := 0; Result := '1817'; Exit; end;
   fieldstatus[18] := mpr;
   fieldstatus[17] := 0;
  end;

  if validmove('18', '19', fieldstatus, mpr, playergamephase) = true then
  begin fieldstatus[18] := 0; fieldstatus[19] := mpr;
   if ismuehle('19', fieldstatus, mpr) = true then
   begin fieldstatus[18] := mpr; fieldstatus[19] := 0; Result := '1819'; Exit; end;
   fieldstatus[18] := mpr; fieldstatus[19] := 0;
  end;

  if validmove('18', '10', fieldstatus, mpr, playergamephase) = true then
  begin fieldstatus[18] := 0; fieldstatus[10] := mpr;
   if ismuehle('10', fieldstatus, mpr) = true then
   begin fieldstatus[18] := mpr; fieldstatus[10] := 0; Result := '1810'; Exit; end;
   fieldstatus[18] := mpr; fieldstatus[10] := 0;
  end;
 end;

 //19
 if fieldstatus[19] = mpr then
 begin
  if validmove('19', '18', fieldstatus, mpr, playergamephase) = true then
  begin fieldstatus[19] := 0; fieldstatus[18] := mpr;
   if ismuehle('18', fieldstatus, mpr) = true then
   begin fieldstatus[19] := mpr; fieldstatus[18] := 0; Result := '1918'; Exit; end;
   fieldstatus[19] := mpr;
   fieldstatus[18] := 0;
  end;

  if validmove('19', '20', fieldstatus, mpr, playergamephase) = true then
  begin fieldstatus[19] := 0; fieldstatus[20] := mpr;
   if ismuehle('20', fieldstatus, mpr) = true then
   begin fieldstatus[19] := mpr; fieldstatus[20] := 0; Result := '1920'; Exit; end;
   fieldstatus[19] := mpr;
   fieldstatus[20] := 0;
  end;
 end;

 //20
 if fieldstatus[20] = mpr then
 begin
  if validmove('20', '19', fieldstatus, mpr, playergamephase) = true then
  begin fieldstatus[20] := 0; fieldstatus[19] := mpr;
   if ismuehle('19', fieldstatus, mpr) = true then
   begin fieldstatus[20] := mpr; fieldstatus[19] := 0; Result := '2019'; Exit; end;
   fieldstatus[20] := mpr;
   fieldstatus[19] := 0;
  end;

  if validmove('20', '21', fieldstatus, mpr, playergamephase) = true then
  begin fieldstatus[20] := 0; fieldstatus[21] := mpr;
   if ismuehle('21', fieldstatus, mpr) = true then
   begin fieldstatus[20] := mpr; fieldstatus[21] := 0; Result := '2021'; Exit; end;
   fieldstatus[20] := mpr;
   fieldstatus[21] := 0;
  end;

  if validmove('20', '12', fieldstatus, mpr, playergamephase) = true then
  begin fieldstatus[20] := 0; fieldstatus[12] := mpr;
   if ismuehle('12', fieldstatus, mpr) = true then
   begin fieldstatus[20] := mpr; fieldstatus[12] := 0; Result := '2012'; Exit; end;
   fieldstatus[20] := mpr;
   fieldstatus[12] := 0;
  end;
 end;

 //21
 if fieldstatus[21] = mpr then
 begin
  if validmove('21', '20', fieldstatus, mpr, playergamephase) = true then
  begin fieldstatus[21] := 0; fieldstatus[20] := mpr;
   if ismuehle('20', fieldstatus, mpr) = true then
   begin fieldstatus[21] := mpr; fieldstatus[20] := 0; Result := '2120'; Exit; end;
   fieldstatus[21] := mpr;
   fieldstatus[20] := 0;
  end;

  if validmove('21', '22', fieldstatus, mpr, playergamephase) = true then
  begin fieldstatus[21] := 0; fieldstatus[22] := mpr;
   if ismuehle('22', fieldstatus, mpr) = true then
   begin fieldstatus[21] := mpr; fieldstatus[22] := 0; Result := '2122'; Exit; end;
   fieldstatus[21] := mpr;
   fieldstatus[22] := 0;
  end;
 end;

 //22
 if fieldstatus[22] = mpr then
 begin
  if validmove('22', '21', fieldstatus, mpr, playergamephase) = true then
  begin fieldstatus[22] := 0; fieldstatus[21] := mpr;
   if ismuehle('21', fieldstatus, mpr) = true then
   begin fieldstatus[22] := mpr; fieldstatus[21] := 0; Result := '2221'; Exit; end;
   fieldstatus[22] := mpr;
   fieldstatus[21] := 0;
  end;

  if validmove('22', '23', fieldstatus, mpr, playergamephase) = true then
  begin fieldstatus[22] := 0; fieldstatus[23] := mpr;
   if ismuehle('23', fieldstatus, mpr) = true then
   begin fieldstatus[22] := mpr; fieldstatus[23] := 0; Result := '2223'; Exit; end;
   fieldstatus[22] := mpr;
   fieldstatus[23] := 0;
  end;

  if validmove('22', '14', fieldstatus, mpr, playergamephase) = true then
  begin fieldstatus[22] := 0; fieldstatus[14] := mpr;
   if ismuehle('14', fieldstatus, mpr) = true then
   begin fieldstatus[22] := mpr; fieldstatus[14] := 0; Result := '2214'; Exit; end;
   fieldstatus[22] := mpr;
   fieldstatus[14] := 0;
  end;
 end;

 //23
 if fieldstatus[23] = mpr then
 begin
  if validmove('23', '22', fieldstatus, mpr, playergamephase) = true then
  begin fieldstatus[23] := 0; fieldstatus[22] := mpr;
   if ismuehle('22', fieldstatus, mpr) = true then
   begin fieldstatus[23] := mpr; fieldstatus[22] := 0; Result := '2322'; Exit; end;
   fieldstatus[23] := mpr;
   fieldstatus[22] := 0;
  end;

  if validmove('23', '24', fieldstatus, mpr, playergamephase) = true then
  begin fieldstatus[23] := 0; fieldstatus[24] := mpr;
   if ismuehle('24', fieldstatus, mpr) = true then
   begin fieldstatus[23] := mpr; fieldstatus[24] := 0; Result := '2324'; Exit; end;
   fieldstatus[23] := mpr;
   fieldstatus[24] := 0;
  end;
 end;

 //24
 if fieldstatus[24] = mpr then
 begin
  if validmove('24', '23', fieldstatus, mpr, playergamephase) = true then
  begin fieldstatus[24] := 0; fieldstatus[23] := mpr;
   if ismuehle('23', fieldstatus, mpr) = true then
   begin fieldstatus[24] := mpr; fieldstatus[23] := 0; Result := '2423'; Exit; end;
   fieldstatus[24] := mpr;
   fieldstatus[23] := 0;
  end;

  if validmove('24', '17', fieldstatus, mpr, playergamephase) = true then
  begin fieldstatus[24] := 0; fieldstatus[17] := mpr;
   if ismuehle('17', fieldstatus, mpr) = true then
   begin fieldstatus[24] := mpr; fieldstatus[17] := 0; Result := '2417'; Exit; end;
   fieldstatus[24] := mpr;
   fieldstatus[17] := 0;
  end;

  if validmove('24', '16', fieldstatus, mpr, playergamephase) = true then
  begin fieldstatus[24] := 0; fieldstatus[16] := mpr;
   if ismuehle('16', fieldstatus, mpr) = true then
   begin fieldstatus[24] := mpr; fieldstatus[16] := 0; Result := '2416'; Exit; end;
   fieldstatus[24] := mpr;
   fieldstatus[16] := 0;
  end;
 end;

 //Überprüfen ob durch einen zug auf einen anderen eine mühle blockiert werden kann
 //01
 if fieldstatus[1] = mpr then
 begin
  if validmove('01', '02', fieldstatus, mpr, playergamephase) = true then
  begin fieldstatus[1] := 0; fieldstatus[2] := mpr;
   if ismuehle('02', fieldstatus, invmpr(mpr)) = true then
   begin fieldstatus[1] := mpr; fieldstatus[2] := 0; Result := '0102'; Exit; end;
   fieldstatus[1] := mpr;
   fieldstatus[2] := 0;
  end;

  if validmove('01', '08', fieldstatus, mpr, playergamephase) = true then
  begin fieldstatus[1] := 0; fieldstatus[8] := mpr;
   if ismuehle('08', fieldstatus, invmpr(mpr)) = true then
   begin fieldstatus[1] := mpr; fieldstatus[8] := 0; Result := '0108'; Exit; end;
   fieldstatus[1] := mpr; fieldstatus[8] := 0;
  end;
 end;

 //02
 if fieldstatus[2] = mpr then
 begin
  if validmove('02', '01', fieldstatus, mpr, playergamephase) = true then
  begin fieldstatus[2] := 0; fieldstatus[1] := mpr;
   if ismuehle('01', fieldstatus, invmpr(mpr)) = true then
   begin fieldstatus[2] := mpr; fieldstatus[1] := 0; Result := '0201'; Exit; end;
   fieldstatus[2] := mpr;
   fieldstatus[1] := 0;
  end;

  if validmove('02', '03', fieldstatus, mpr, playergamephase) = true then
  begin fieldstatus[2] := 0; fieldstatus[3] := mpr;
   if ismuehle('03', fieldstatus, invmpr(mpr)) = true then
   begin fieldstatus[2] := mpr; fieldstatus[3] := 0; Result := '0203'; Exit; end;
   fieldstatus[2] := mpr; fieldstatus[3] := 0;
  end;

  if validmove('02', '10', fieldstatus, mpr, playergamephase) = true then
  begin fieldstatus[2] := 0; fieldstatus[10] := mpr;
   if ismuehle('10', fieldstatus, invmpr(mpr)) = true then
   begin fieldstatus[2] := mpr; fieldstatus[10] := 0; Result := '0210'; Exit; end;
   fieldstatus[2] := mpr; fieldstatus[10] := 0;
  end;
 end;

 //03
 if fieldstatus[3] = mpr then
 begin
  if validmove('03', '02', fieldstatus, mpr, playergamephase) = true then
  begin fieldstatus[3] := 0; fieldstatus[2] := mpr;
   if ismuehle('02', fieldstatus, invmpr(mpr)) = true then
   begin fieldstatus[3] := mpr; fieldstatus[2] := 0; Result := '0302'; Exit; end;
   fieldstatus[3] := mpr;
   fieldstatus[2] := 0;
  end;

  if validmove('03', '04', fieldstatus, mpr, playergamephase) = true then
  begin fieldstatus[3] := 0; fieldstatus[4] := mpr;
   if ismuehle('04', fieldstatus, invmpr(mpr)) = true then
   begin fieldstatus[3] := mpr; fieldstatus[4] := 0; Result := '0304'; Exit; end;
   fieldstatus[3] := mpr;
   fieldstatus[4] := 0;
  end;
 end;

 //04
 if fieldstatus[4] = mpr then
 begin
  if validmove('04', '03', fieldstatus, mpr, playergamephase) = true then
  begin fieldstatus[4] := 0; fieldstatus[3] := mpr;
   if ismuehle('03', fieldstatus, invmpr(mpr)) = true then
   begin fieldstatus[4] := mpr; fieldstatus[3] := 0; Result := '0403'; Exit; end;
   fieldstatus[4] := mpr;
   fieldstatus[3] := 0;
  end;

  if validmove('04', '05', fieldstatus, mpr, playergamephase) = true then
  begin fieldstatus[4] := 0; fieldstatus[5] := mpr;
   if ismuehle('05', fieldstatus, invmpr(mpr)) = true then
   begin fieldstatus[4] := mpr; fieldstatus[5] := 0; Result := '0405'; Exit; end;
   fieldstatus[4] := mpr;
   fieldstatus[5] := 0;
  end;

  if validmove('04', '12', fieldstatus, mpr, playergamephase) = true then
  begin fieldstatus[4] := 0; fieldstatus[12] := mpr;
   if ismuehle('12', fieldstatus, invmpr(mpr)) = true then
   begin fieldstatus[4] := mpr; fieldstatus[12] := 0; Result := '0412'; Exit; end;
   fieldstatus[4] := mpr;
   fieldstatus[12] := 0;
  end;
 end;

 //05
 if fieldstatus[5] = mpr then
 begin
  if validmove('05', '04', fieldstatus, mpr, playergamephase) = true then
  begin fieldstatus[5] := 0; fieldstatus[4] := mpr;
   if ismuehle('04', fieldstatus, invmpr(mpr)) = true then
   begin fieldstatus[5] := mpr; fieldstatus[4] := 0; Result := '0504'; Exit; end;
   fieldstatus[5] := mpr;
   fieldstatus[4] := 0;
  end;

  if validmove('05', '06', fieldstatus, mpr, playergamephase) = true then
  begin fieldstatus[5] := 0; fieldstatus[6] := mpr;
   if ismuehle('06', fieldstatus, invmpr(mpr)) = true then
   begin fieldstatus[5] := mpr; fieldstatus[6] := 0; Result := '0506'; Exit; end;
   fieldstatus[5] := mpr;
   fieldstatus[6] := 0;
  end;
 end;

 //06
 if fieldstatus[6] = mpr then
 begin
  if validmove('06', '05', fieldstatus, mpr, playergamephase) = true then
  begin fieldstatus[6] := 0; fieldstatus[5] := mpr;
   if ismuehle('05', fieldstatus, invmpr(mpr)) = true then
   begin fieldstatus[6] := mpr; fieldstatus[5] := 0; Result := '0605'; Exit; end;
   fieldstatus[6] := mpr;
   fieldstatus[5] := 0;
  end;

  if validmove('06', '07', fieldstatus, mpr, playergamephase) = true then
  begin fieldstatus[6] := 0; fieldstatus[7] := mpr;
   if ismuehle('07', fieldstatus, invmpr(mpr)) = true then
   begin fieldstatus[6] := mpr; fieldstatus[7] := 0; Result := '0607'; Exit; end;
   fieldstatus[6] := mpr;
   fieldstatus[7] := 0;
  end;

  if validmove('06', '14', fieldstatus, mpr, playergamephase) = true then
  begin fieldstatus[6] := 0; fieldstatus[14] := mpr;
   if ismuehle('14', fieldstatus, invmpr(mpr)) = true then
   begin fieldstatus[6] := mpr; fieldstatus[14] := 0; Result := '0614'; Exit; end;
   fieldstatus[6] := mpr;
   fieldstatus[14] := 0;
  end;
 end;

 //07
 if fieldstatus[7] = mpr then
 begin
  if validmove('07', '06', fieldstatus, mpr, playergamephase) = true then
  begin fieldstatus[7] := 0; fieldstatus[6] := mpr;
   if ismuehle('06', fieldstatus, invmpr(mpr)) = true then
   begin fieldstatus[7] := mpr; fieldstatus[6] := 0; Result := '0706'; Exit; end;
   fieldstatus[7] := mpr;
   fieldstatus[6] := 0;
  end;

  if validmove('07', '08', fieldstatus, mpr, playergamephase) = true then
  begin fieldstatus[7] := 0; fieldstatus[8] := mpr;
   if ismuehle('08', fieldstatus, invmpr(mpr)) = true then
   begin fieldstatus[7] := mpr; fieldstatus[8] := 0; Result := '0708'; Exit; end;
   fieldstatus[7] := mpr;
   fieldstatus[8] := 0;
  end;
 end;

 //08
 if fieldstatus[8] = mpr then
 begin
  if validmove('08', '07', fieldstatus, mpr, playergamephase) = true then
  begin fieldstatus[8] := 0; fieldstatus[7] := mpr;
   if ismuehle('07', fieldstatus, invmpr(mpr)) = true then
   begin fieldstatus[8] := mpr; fieldstatus[7] := 0; Result := '0807'; Exit; end;
   fieldstatus[8] := mpr;
   fieldstatus[7] := 0;
  end;

  if validmove('08', '01', fieldstatus, mpr, playergamephase) = true then
  begin fieldstatus[8] := 0; fieldstatus[1] := mpr;
   if ismuehle('01', fieldstatus, invmpr(mpr)) = true then
   begin fieldstatus[8] := mpr; fieldstatus[1] := 0; Result := '0801'; Exit; end;
   fieldstatus[8] := mpr;
   fieldstatus[1] := 0;
  end;

  if validmove('08', '16', fieldstatus, mpr, playergamephase) = true then
  begin fieldstatus[8] := 0; fieldstatus[16] := mpr;
   if ismuehle('16', fieldstatus, invmpr(mpr)) = true then
   begin fieldstatus[8] := mpr; fieldstatus[16] := 0; Result := '0816'; Exit; end;
   fieldstatus[8] := mpr;
   fieldstatus[16] := 0;
  end;
 end;

 //09
 if fieldstatus[9] = mpr then
 begin
  if validmove('09', '10', fieldstatus, mpr, playergamephase) = true then
  begin fieldstatus[9] := 0; fieldstatus[10] := mpr;
   if ismuehle('10', fieldstatus, invmpr(mpr)) = true then
   begin fieldstatus[9] := mpr; fieldstatus[10] := 0; Result := '0910'; Exit; end;
   fieldstatus[9] := mpr;
   fieldstatus[10] := 0;
  end;

  if validmove('09', '16', fieldstatus, mpr, playergamephase) = true then
  begin fieldstatus[9] := 0; fieldstatus[16] := mpr;
   if ismuehle('16', fieldstatus, invmpr(mpr)) = true then
   begin fieldstatus[9] := mpr; fieldstatus[16] := 0; Result := '0916'; Exit; end;
   fieldstatus[9] := mpr; fieldstatus[16] := 0;
  end;
 end;

 //10
 if fieldstatus[10] = mpr then
 begin
  if validmove('10', '09', fieldstatus, mpr, playergamephase) = true then
  begin fieldstatus[10] := 0; fieldstatus[9] := mpr;
   if ismuehle('09', fieldstatus, invmpr(mpr)) = true then
   begin fieldstatus[10] := mpr; fieldstatus[9] := 0; Result := '1009'; Exit; end;
   fieldstatus[10] := mpr;
   fieldstatus[9] := 0;
  end;

  if validmove('10', '11', fieldstatus, mpr, playergamephase) = true then
  begin fieldstatus[10] := 0; fieldstatus[11] := mpr;
   if ismuehle('11', fieldstatus, invmpr(mpr)) = true then
   begin fieldstatus[10] := mpr; fieldstatus[11] := 0; Result := '1011'; Exit; end;
   fieldstatus[10] := mpr; fieldstatus[11] := 0;
  end;

  if validmove('10', '02', fieldstatus, mpr, playergamephase) = true then
  begin fieldstatus[10] := 0; fieldstatus[2] := mpr;
   if ismuehle('02', fieldstatus, invmpr(mpr)) = true then
   begin fieldstatus[10] := mpr; fieldstatus[2] := 0; Result := '1002'; Exit; end;
   fieldstatus[10] := mpr; fieldstatus[2] := 0;
  end;
  
  if validmove('10', '18', fieldstatus, mpr, playergamephase) = true then
  begin fieldstatus[10] := 0; fieldstatus[18] := mpr;
   if ismuehle('18', fieldstatus, invmpr(mpr)) = true then
   begin fieldstatus[10] := mpr; fieldstatus[18] := 0; Result := '1018'; Exit; end;
   fieldstatus[10] := mpr; fieldstatus[18] := 0;
  end;
 end;

 //11
 if fieldstatus[11] = mpr then
 begin
  if validmove('11', '10', fieldstatus, mpr, playergamephase) = true then
  begin fieldstatus[11] := 0; fieldstatus[10] := mpr;
   if ismuehle('10', fieldstatus, invmpr(mpr)) = true then
   begin fieldstatus[11] := mpr; fieldstatus[10] := 0; Result := '1110'; Exit; end;
   fieldstatus[11] := mpr;
   fieldstatus[10] := 0;
  end;

  if validmove('11', '12', fieldstatus, mpr, playergamephase) = true then
  begin fieldstatus[11] := 0; fieldstatus[12] := mpr;
   if ismuehle('12', fieldstatus, invmpr(mpr)) = true then
   begin fieldstatus[11] := mpr; fieldstatus[12] := 0; Result := '1112'; Exit; end;
   fieldstatus[11] := mpr;
   fieldstatus[12] := 0;
  end;
 end;

 //12
 if fieldstatus[12] = mpr then
 begin
  if validmove('12', '11', fieldstatus, mpr, playergamephase) = true then
  begin fieldstatus[12] := 0; fieldstatus[11] := mpr;
   if ismuehle('11', fieldstatus, invmpr(mpr)) = true then
   begin fieldstatus[12] := mpr; fieldstatus[11] := 0; Result := '1211'; Exit; end;
   fieldstatus[12] := mpr;
   fieldstatus[11] := 0;
  end;

  if validmove('12', '13', fieldstatus, mpr, playergamephase) = true then
  begin fieldstatus[12] := 0; fieldstatus[13] := mpr;
   if ismuehle('13', fieldstatus, invmpr(mpr)) = true then
   begin fieldstatus[12] := mpr; fieldstatus[13] := 0; Result := '1213'; Exit; end;
   fieldstatus[12] := mpr;
   fieldstatus[13] := 0;
  end;

  if validmove('12', '04', fieldstatus, mpr, playergamephase) = true then
  begin fieldstatus[12] := 0; fieldstatus[4] := mpr;
   if ismuehle('04', fieldstatus, invmpr(mpr)) = true then
   begin fieldstatus[12] := mpr; fieldstatus[4] := 0; Result := '1204'; Exit; end;
   fieldstatus[12] := mpr; fieldstatus[4] := 0;
  end;
  
  if validmove('12', '20', fieldstatus, mpr, playergamephase) = true then
  begin fieldstatus[12] := 0; fieldstatus[20] := mpr;
   if ismuehle('20', fieldstatus, invmpr(mpr)) = true then
   begin fieldstatus[12] := mpr; fieldstatus[20] := 0; Result := '1220'; Exit; end;
   fieldstatus[12] := mpr; fieldstatus[20] := 0;
  end;
 end;

 //13
 if fieldstatus[13] = mpr then
 begin
  if validmove('13', '12', fieldstatus, mpr, playergamephase) = true then
  begin fieldstatus[13] := 0; fieldstatus[12] := mpr;
   if ismuehle('12', fieldstatus, invmpr(mpr)) = true then
   begin fieldstatus[13] := mpr; fieldstatus[12] := 0; Result := '1312'; Exit; end;
   fieldstatus[13] := mpr;
   fieldstatus[12] := 0;
  end;

  if validmove('13', '14', fieldstatus, mpr, playergamephase) = true then
  begin fieldstatus[13] := 0; fieldstatus[14] := mpr;
   if ismuehle('14', fieldstatus, invmpr(mpr)) = true then
   begin fieldstatus[13] := mpr; fieldstatus[14] := 0; Result := '1314'; Exit; end;
   fieldstatus[13] := mpr;
   fieldstatus[14] := 0;
  end;
 end;

 //14
 if fieldstatus[14] = mpr then
 begin
  if validmove('14', '13', fieldstatus, mpr, playergamephase) = true then
  begin fieldstatus[14] := 0; fieldstatus[13] := mpr;
   if ismuehle('13', fieldstatus, invmpr(mpr)) = true then
   begin fieldstatus[14] := mpr; fieldstatus[13] := 0; Result := '1413'; Exit; end;
   fieldstatus[14] := mpr;
   fieldstatus[13] := 0;
  end;

  if validmove('14', '15', fieldstatus, mpr, playergamephase) = true then
  begin fieldstatus[14] := 0; fieldstatus[15] := mpr;
   if ismuehle('15', fieldstatus, invmpr(mpr)) = true then
   begin fieldstatus[14] := mpr; fieldstatus[15] := 0; Result := '1415'; Exit; end;
   fieldstatus[14] := mpr;
   fieldstatus[15] := 0;
  end;

  if validmove('14', '06', fieldstatus, mpr, playergamephase) = true then
  begin fieldstatus[14] := 0; fieldstatus[6] := mpr;
   if ismuehle('06', fieldstatus, invmpr(mpr)) = true then
   begin fieldstatus[14] := mpr; fieldstatus[6] := 0; Result := '1406'; Exit; end;
   fieldstatus[14] := mpr; fieldstatus[6] := 0;
  end;
  
  if validmove('14', '22', fieldstatus, mpr, playergamephase) = true then
  begin fieldstatus[14] := 0; fieldstatus[22] := mpr;
   if ismuehle('22', fieldstatus, invmpr(mpr)) = true then
   begin fieldstatus[14] := mpr; fieldstatus[22] := 0; Result := '1422'; Exit; end;
   fieldstatus[14] := mpr; fieldstatus[22] := 0;
  end;
 end;

 //15
 if fieldstatus[15] = mpr then
 begin
  if validmove('15', '14', fieldstatus, mpr, playergamephase) = true then
  begin fieldstatus[15] := 0; fieldstatus[14] := mpr;
   if ismuehle('14', fieldstatus, invmpr(mpr)) = true then
   begin fieldstatus[15] := mpr; fieldstatus[14] := 0; Result := '1514'; Exit; end;
   fieldstatus[15] := mpr;
   fieldstatus[14] := 0;
  end;

  if validmove('15', '16', fieldstatus, mpr, playergamephase) = true then
  begin fieldstatus[15] := 0; fieldstatus[16] := mpr;
   if ismuehle('16', fieldstatus, invmpr(mpr)) = true then
   begin fieldstatus[15] := mpr; fieldstatus[16] := 0; Result := '1516'; Exit; end;
   fieldstatus[15] := mpr;
   fieldstatus[16] := 0;
  end;
 end;

 //16
 if fieldstatus[16] = mpr then
 begin
  if validmove('16', '15', fieldstatus, mpr, playergamephase) = true then
  begin fieldstatus[16] := 0; fieldstatus[15] := mpr;
   if ismuehle('15', fieldstatus, invmpr(mpr)) = true then
   begin fieldstatus[16] := mpr; fieldstatus[15] := 0; Result := '1615'; Exit; end;
   fieldstatus[16] := mpr;
   fieldstatus[15] := 0;
  end;

  if validmove('16', '09', fieldstatus, mpr, playergamephase) = true then
  begin fieldstatus[16] := 0; fieldstatus[9] := mpr;
   if ismuehle('09', fieldstatus, invmpr(mpr)) = true then
   begin fieldstatus[16] := mpr; fieldstatus[9] := 0; Result := '1609'; Exit; end;
   fieldstatus[16] := mpr;
   fieldstatus[9] := 0;
  end;

  if validmove('16', '08', fieldstatus, mpr, playergamephase) = true then
  begin fieldstatus[16] := 0; fieldstatus[8] := mpr;
   if ismuehle('08', fieldstatus, invmpr(mpr)) = true then
   begin fieldstatus[16] := mpr; fieldstatus[8] := 0; Result := '1608'; Exit; end;
   fieldstatus[16] := mpr; fieldstatus[8] := 0;
  end;

  if validmove('16', '24', fieldstatus, mpr, playergamephase) = true then
  begin fieldstatus[16] := 0; fieldstatus[24] := mpr;
   if ismuehle('24', fieldstatus, invmpr(mpr)) = true then
   begin fieldstatus[16] := mpr; fieldstatus[24] := 0; Result := '1624'; Exit; end;
   fieldstatus[16] := mpr; fieldstatus[24] := 0;
  end;
 end;

 //17
 if fieldstatus[17] = mpr then
 begin
  if validmove('17', '18', fieldstatus, mpr, playergamephase) = true then
  begin fieldstatus[17] := 0; fieldstatus[18] := mpr;
   if ismuehle('18', fieldstatus, invmpr(mpr)) = true then
   begin fieldstatus[17] := mpr; fieldstatus[18] := 0; Result := '1718'; Exit; end;
   fieldstatus[17] := mpr;
   fieldstatus[18] := 0;
  end;

  if validmove('17', '24', fieldstatus, mpr, playergamephase) = true then
  begin fieldstatus[17] := 0; fieldstatus[24] := mpr;
   if ismuehle('24', fieldstatus, invmpr(mpr)) = true then
   begin fieldstatus[17] := mpr; fieldstatus[24] := 0; Result := '1724'; Exit; end;
   fieldstatus[17] := mpr; fieldstatus[24] := 0;
  end;
 end;

 //18
 if fieldstatus[18] = mpr then
 begin
  if validmove('18', '17', fieldstatus, mpr, playergamephase) = true then
  begin fieldstatus[18] := 0; fieldstatus[17] := mpr;
   if ismuehle('17', fieldstatus, invmpr(mpr)) = true then
   begin fieldstatus[18] := mpr; fieldstatus[17] := 0; Result := '1817'; Exit; end;
   fieldstatus[18] := mpr;
   fieldstatus[17] := 0;
  end;

  if validmove('18', '19', fieldstatus, mpr, playergamephase) = true then
  begin fieldstatus[18] := 0; fieldstatus[19] := mpr;
   if ismuehle('19', fieldstatus, invmpr(mpr)) = true then
   begin fieldstatus[18] := mpr; fieldstatus[19] := 0; Result := '1819'; Exit; end;
   fieldstatus[18] := mpr; fieldstatus[19] := 0;
  end;

  if validmove('18', '10', fieldstatus, mpr, playergamephase) = true then
  begin fieldstatus[18] := 0; fieldstatus[10] := mpr;
   if ismuehle('10', fieldstatus, invmpr(mpr)) = true then
   begin fieldstatus[18] := mpr; fieldstatus[10] := 0; Result := '1810'; Exit; end;
   fieldstatus[18] := mpr; fieldstatus[10] := 0;
  end;
 end;

 //19
 if fieldstatus[19] = mpr then
 begin
  if validmove('19', '18', fieldstatus, mpr, playergamephase) = true then
  begin fieldstatus[19] := 0; fieldstatus[18] := mpr;
   if ismuehle('18', fieldstatus, invmpr(mpr)) = true then
   begin fieldstatus[19] := mpr; fieldstatus[18] := 0; Result := '1918'; Exit; end;
   fieldstatus[19] := mpr;
   fieldstatus[18] := 0;
  end;

  if validmove('19', '20', fieldstatus, mpr, playergamephase) = true then
  begin fieldstatus[19] := 0; fieldstatus[20] := mpr;
   if ismuehle('20', fieldstatus, invmpr(mpr)) = true then
   begin fieldstatus[19] := mpr; fieldstatus[20] := 0; Result := '1920'; Exit; end;
   fieldstatus[19] := mpr;
   fieldstatus[20] := 0;
  end;
 end;

 //20
 if fieldstatus[20] = mpr then
 begin
  if validmove('20', '19', fieldstatus, mpr, playergamephase) = true then
  begin fieldstatus[20] := 0; fieldstatus[19] := mpr;
   if ismuehle('19', fieldstatus, invmpr(mpr)) = true then
   begin fieldstatus[20] := mpr; fieldstatus[19] := 0; Result := '2019'; Exit; end;
   fieldstatus[20] := mpr;
   fieldstatus[19] := 0;
  end;

  if validmove('20', '21', fieldstatus, mpr, playergamephase) = true then
  begin fieldstatus[20] := 0; fieldstatus[21] := mpr;
   if ismuehle('21', fieldstatus, invmpr(mpr)) = true then
   begin fieldstatus[20] := mpr; fieldstatus[21] := 0; Result := '2021'; Exit; end;
   fieldstatus[20] := mpr;
   fieldstatus[21] := 0;
  end;

  if validmove('20', '12', fieldstatus, mpr, playergamephase) = true then
  begin fieldstatus[20] := 0; fieldstatus[12] := mpr;
   if ismuehle('12', fieldstatus, invmpr(mpr)) = true then
   begin fieldstatus[20] := mpr; fieldstatus[12] := 0; Result := '2012'; Exit; end;
   fieldstatus[20] := mpr;
   fieldstatus[12] := 0;
  end;
 end;

 //21
 if fieldstatus[21] = mpr then
 begin
  if validmove('21', '20', fieldstatus, mpr, playergamephase) = true then
  begin fieldstatus[21] := 0; fieldstatus[20] := mpr;
   if ismuehle('20', fieldstatus, invmpr(mpr)) = true then
   begin fieldstatus[21] := mpr; fieldstatus[20] := 0; Result := '2120'; Exit; end;
   fieldstatus[21] := mpr;
   fieldstatus[20] := 0;
  end;

  if validmove('21', '22', fieldstatus, mpr, playergamephase) = true then
  begin fieldstatus[21] := 0; fieldstatus[22] := mpr;
   if ismuehle('22', fieldstatus, invmpr(mpr)) = true then
   begin fieldstatus[21] := mpr; fieldstatus[22] := 0; Result := '2122'; Exit; end;
   fieldstatus[21] := mpr;
   fieldstatus[22] := 0;
  end;
 end;

 //22
 if fieldstatus[22] = mpr then
 begin
  if validmove('22', '21', fieldstatus, mpr, playergamephase) = true then
  begin fieldstatus[22] := 0; fieldstatus[21] := mpr;
   if ismuehle('21', fieldstatus, invmpr(mpr)) = true then
   begin fieldstatus[22] := mpr; fieldstatus[21] := 0; Result := '2221'; Exit; end;
   fieldstatus[22] := mpr;
   fieldstatus[21] := 0;
  end;

  if validmove('22', '23', fieldstatus, mpr, playergamephase) = true then
  begin fieldstatus[22] := 0; fieldstatus[23] := mpr;
   if ismuehle('23', fieldstatus, invmpr(mpr)) = true then
   begin fieldstatus[22] := mpr; fieldstatus[23] := 0; Result := '2223'; Exit; end;
   fieldstatus[22] := mpr;
   fieldstatus[23] := 0;
  end;

  if validmove('22', '14', fieldstatus, mpr, playergamephase) = true then
  begin fieldstatus[22] := 0; fieldstatus[14] := mpr;
   if ismuehle('14', fieldstatus, invmpr(mpr)) = true then
   begin fieldstatus[22] := mpr; fieldstatus[14] := 0; Result := '2214'; Exit; end;
   fieldstatus[22] := mpr;
   fieldstatus[14] := 0;
  end;
 end;

 //23
 if fieldstatus[23] = mpr then
 begin
  if validmove('23', '22', fieldstatus, mpr, playergamephase) = true then
  begin fieldstatus[23] := 0; fieldstatus[22] := mpr;
   if ismuehle('22', fieldstatus, invmpr(mpr)) = true then
   begin fieldstatus[23] := mpr; fieldstatus[22] := 0; Result := '2322'; Exit; end;
   fieldstatus[23] := mpr;
   fieldstatus[22] := 0;
  end;

  if validmove('23', '24', fieldstatus, mpr, playergamephase) = true then
  begin fieldstatus[23] := 0; fieldstatus[24] := mpr;
   if ismuehle('24', fieldstatus, invmpr(mpr)) = true then
   begin fieldstatus[23] := mpr; fieldstatus[24] := 0; Result := '2324'; Exit; end;
   fieldstatus[23] := mpr;
   fieldstatus[24] := 0;
  end;
 end;

 //24
 if fieldstatus[24] = mpr then
 begin
  if validmove('24', '23', fieldstatus, mpr, playergamephase) = true then
  begin fieldstatus[24] := 0; fieldstatus[23] := mpr;
   if ismuehle('23', fieldstatus, invmpr(mpr)) = true then
   begin fieldstatus[24] := mpr; fieldstatus[23] := 0; Result := '2423'; Exit; end;
   fieldstatus[24] := mpr;
   fieldstatus[23] := 0;
  end;

  if validmove('24', '17', fieldstatus, mpr, playergamephase) = true then
  begin fieldstatus[24] := 0; fieldstatus[17] := mpr;
   if ismuehle('17', fieldstatus, invmpr(mpr)) = true then
   begin fieldstatus[24] := mpr; fieldstatus[17] := 0; Result := '2417'; Exit; end;
   fieldstatus[24] := mpr;
   fieldstatus[17] := 0;
  end;

  if validmove('24', '16', fieldstatus, mpr, playergamephase) = true then
  begin fieldstatus[24] := 0; fieldstatus[16] := mpr;
   if ismuehle('16', fieldstatus, invmpr(mpr)) = true then
   begin fieldstatus[24] := mpr; fieldstatus[16] := 0; Result := '2416'; Exit; end;
   fieldstatus[24] := mpr;
   fieldstatus[16] := 0;
  end;
 end;

 // Setze zufällig einen Stein
 while rnr <> 26 do // erzeugt endlosschleife
 begin
  rnr := random(25); //Verhindere das Random 0 zurück gibt

  if rnr = 1 then begin if fieldstatus[1] = mpr then
  begin if givevalidmovep2('01', fieldstatus, mpr, playergamephase)  <> 'none' then begin
  Result := PChar(givevalidmovep2('01', fieldstatus, mpr, playergamephase)); exit;  end; end; end

  else if rnr = 2 then begin if fieldstatus[2] = mpr then 
  begin if givevalidmovep2('02', fieldstatus, mpr, playergamephase)  <> 'none' then begin
  Result := PChar(givevalidmovep2('02', fieldstatus, mpr, playergamephase)); exit;  end; end; end

  else if rnr = 3 then begin if fieldstatus[3] = mpr then 
  begin if givevalidmovep2('03', fieldstatus, mpr, playergamephase)  <> 'none' then begin
  Result := PChar(givevalidmovep2('03', fieldstatus, mpr, playergamephase)); exit;  end; end; end
  
  else if rnr = 4 then begin if fieldstatus[4] = mpr then 
  begin if givevalidmovep2('04', fieldstatus, mpr, playergamephase)  <> 'none' then begin
  Result := PChar(givevalidmovep2('04', fieldstatus, mpr, playergamephase)); exit;  end; end; end
  
  else if rnr = 5 then begin if fieldstatus[5] = mpr then 
  begin if givevalidmovep2('05', fieldstatus, mpr, playergamephase)  <> 'none' then begin
  Result := PChar(givevalidmovep2('05', fieldstatus, mpr, playergamephase)); exit;  end; end; end

  else if rnr = 6 then begin if fieldstatus[6] = mpr then
  begin if givevalidmovep2('06', fieldstatus, mpr, playergamephase)  <> 'none' then begin
  Result := PChar(givevalidmovep2('06', fieldstatus, mpr, playergamephase)); exit;  end; end; end

  else if rnr = 7 then begin if fieldstatus[7] = mpr then 
  begin if givevalidmovep2('07', fieldstatus, mpr, playergamephase)  <> 'none' then begin
  Result := PChar(givevalidmovep2('07', fieldstatus, mpr, playergamephase)); exit;  end; end; end
  
  else if rnr = 8 then begin if fieldstatus[8] = mpr then 
  begin if givevalidmovep2('08', fieldstatus, mpr, playergamephase)  <> 'none' then begin
  Result := PChar(givevalidmovep2('08', fieldstatus, mpr, playergamephase)); exit;  end; end; end
  
  else if rnr = 9 then begin if fieldstatus[9] = mpr then
  begin if givevalidmovep2('09', fieldstatus, mpr, playergamephase)  <> 'none' then begin
  Result := PChar(givevalidmovep2('09', fieldstatus, mpr, playergamephase)); exit;  end; end; end

  else if rnr = 10 then begin if fieldstatus[10] = mpr then 
  begin if givevalidmovep2('10', fieldstatus, mpr, playergamephase)  <> 'none' then begin
  Result := PChar(givevalidmovep2('10', fieldstatus, mpr, playergamephase)); exit;  end; end; end

  else if rnr = 11 then begin if fieldstatus[11] = mpr then
  begin if givevalidmovep2('11', fieldstatus, mpr, playergamephase)  <> 'none' then begin
  Result := PChar(givevalidmovep2('11', fieldstatus, mpr, playergamephase)); exit;  end; end; end

  else if rnr = 12 then begin if fieldstatus[12] = mpr then 
  begin if givevalidmovep2('12', fieldstatus, mpr, playergamephase)  <> 'none' then begin
  Result := PChar(givevalidmovep2('12', fieldstatus, mpr, playergamephase)); exit;  end; end; end
  
  else if rnr = 13 then begin if fieldstatus[13] = mpr then 
  begin if givevalidmovep2('13', fieldstatus, mpr, playergamephase)  <> 'none' then begin
  Result := PChar(givevalidmovep2('13', fieldstatus, mpr, playergamephase)); exit;  end; end; end
  
  else if rnr = 14 then begin if fieldstatus[14] = mpr then 
  begin if givevalidmovep2('14', fieldstatus, mpr, playergamephase)  <> 'none' then begin
  Result := PChar(givevalidmovep2('14', fieldstatus, mpr, playergamephase)); exit;  end; end; end
  
  else if rnr = 15 then begin if fieldstatus[15] = mpr then
  begin if givevalidmovep2('15', fieldstatus, mpr, playergamephase)  <> 'none' then begin
  Result := PChar(givevalidmovep2('15', fieldstatus, mpr, playergamephase)); exit;  end; end; end

  else if rnr = 16 then begin if fieldstatus[16] = mpr then 
  begin if givevalidmovep2('16', fieldstatus, mpr, playergamephase)  <> 'none' then begin
  Result := PChar(givevalidmovep2('16', fieldstatus, mpr, playergamephase)); exit;  end; end; end

  else if rnr = 17 then begin if fieldstatus[17] = mpr then
  begin if givevalidmovep2('17', fieldstatus, mpr, playergamephase)  <> 'none' then begin
  Result := PChar(givevalidmovep2('17', fieldstatus, mpr, playergamephase)); exit;  end; end; end
  
  else if rnr = 18 then begin if fieldstatus[18] = mpr then 
  begin if givevalidmovep2('18', fieldstatus, mpr, playergamephase)  <> 'none' then begin
  Result := PChar(givevalidmovep2('18', fieldstatus, mpr, playergamephase)); exit;  end; end; end
  
  else if rnr = 19 then begin if fieldstatus[19] = mpr then 
  begin if givevalidmovep2('19', fieldstatus, mpr, playergamephase)  <> 'none' then begin
  Result := PChar(givevalidmovep2('19', fieldstatus, mpr, playergamephase)); exit;  end; end; end
  
  else if rnr = 20 then begin if fieldstatus[20] = mpr then 
  begin if givevalidmovep2('20', fieldstatus, mpr, playergamephase)  <> 'none' then begin
  Result := PChar(givevalidmovep2('20', fieldstatus, mpr, playergamephase)); exit;  end; end; end
  
  else if rnr = 21 then begin if fieldstatus[21] = mpr then
  begin if givevalidmovep2('21', fieldstatus, mpr, playergamephase)  <> 'none' then begin
  Result := PChar(givevalidmovep2('21', fieldstatus, mpr, playergamephase)); exit;  end; end; end
  
  else if rnr = 22 then begin if fieldstatus[22] = mpr then 
  begin if givevalidmovep2('22', fieldstatus, mpr, playergamephase)  <> 'none' then begin
  Result := PChar(givevalidmovep2('22', fieldstatus, mpr, playergamephase)); exit;  end; end; end
  
  else if rnr = 23 then begin if fieldstatus[23] = mpr then 
  begin if givevalidmovep2('23', fieldstatus, mpr, playergamephase)  <> 'none' then begin
  Result := PChar(givevalidmovep2('23', fieldstatus, mpr, playergamephase)); exit;  end; end; end

  else if rnr = 24 then begin if fieldstatus[24] = mpr then
  begin if givevalidmovep2('24', fieldstatus, mpr, playergamephase)  <> 'none' then begin
  Result := PChar(givevalidmovep2('24', fieldstatus, mpr, playergamephase)); exit;  end; end; end

 end;

end // Gamephase 1 Ende (Hauptspiel)

else if playergamephase = 2 then // Endspiel
begin
 // soll verhindern das ki versucht zu setzen wenn sie nur noch 2 steine hat
 stones := 0;

 for n := 1 to 24 do
 begin
  if fieldstatus[n] = mpr then inc(stones);
 end;

 if stones < 3 then Exit;

 p3mprfields := TStringlist.Create;
 p3blankfields := TStringlist.Create;

  // alle 0 steine in liste setzen
 for o := 1 to 24 do
 begin
  if fieldstatus[o] = 0 then inc(stones);
 end;

 for p := 1 to 24 do
 begin
  if fieldstatus[p] = 0 then p3blankfields.add(GetCorrectResultString(IntToStr(p)));
 end;

 // alle mpr steine in liste setzen
 for q := 1 to 24 do
 begin
  if fieldstatus[q] = mpr then p3mprfields.add(GetCorrectResultString(IntToStr(q)));
 end;

 // Mühlen überprüfen^^

 for i:=0 to p3mprfields.count-1 do
 begin
  // von feld auf 0 setzen
  setfield(fieldstatus, p3mprfields.strings[i], 0);

  for j:=0 to p3blankfields.count-1 do
  begin
   setfield(fieldstatus, p3blankfields.strings[j], mpr);

   if ismuehle(p3blankfields.strings[j], fieldstatus, mpr) = true then
   begin
    p3string := p3mprfields.strings[i] + p3blankfields.strings[j];
    Result := PChar(p3string);
    setfield(fieldstatus, p3blankfields.strings[j], 0);
    Exit;
   end;
   
   setfield(fieldstatus, p3blankfields.strings[j], 0);
  end;

  setfield(fieldstatus, p3mprfields.strings[i], mpr);
 end;

 //Mühle verhindern

  for i:=0 to p3mprfields.count-1 do
 begin
  // von feld auf 0 setzen
  setfield(fieldstatus, p3mprfields.strings[i], 0);

  for j:=0 to p3blankfields.count-1 do
  begin
   setfield(fieldstatus, p3blankfields.strings[j], mpr);

   if ismuehle(p3blankfields.strings[j], fieldstatus, invmpr(mpr)) = true then
   begin
    // Hiermit wird sichergestellt das die ki den stein nicht aus einer möglichen mühle abzieht
    if ismuehle(p3mprfields.strings[i], fieldstatus, invmpr(mpr)) = false then
    begin
     p3string := p3mprfields.strings[i] + p3blankfields.strings[j];
     Result := PChar(p3string);
     setfield(fieldstatus, p3blankfields.strings[j], 0);
     Exit;
    end;
   end;
   
   setfield(fieldstatus, p3blankfields.strings[j], 0);
  end;

  setfield(fieldstatus, p3mprfields.strings[i], mpr);
 end;

 //Zufällig einen Stein setzten
 p3string := p3mprfields.strings[random(i)] + p3blankfields.strings[random(j)];
 Result := PChar(p3string);
 p3mprfields.Free;
 p3blankfields.Free;
 Exit;

end; // Gamephase 2 Ende (Endspiel)

Result := 'nonevalue'; // Um Compilerwarnungen zu verhindern

end;

// Die GetAIInfo Funktionen gibt Informationen zur AI zurück.
function GetAIInfo(mode: Integer) : PChar;
begin
 Result:='none';
 if mode = 1 then Result:='Melinda AI' // AI Name
 else if mode = 2 then Result:='1.00.00' // AI Version
 else if mode = 3 then Result:='Global Technology' // AI Autor
 else if mode = 4 then Result:='Medium' // AI Level - Sehr leicht, Leicht, Medium, Schwer, Extrem Schwer, Unbesiegbar
 else if mode = 5 then Result:='© 2005 by Global Technology' // AI Copyright
 else if mode = 6 then Result:='1.05' // Gibt ab welcher GT Mühle Version die AI funktioniert
 else if mode = 7 then Result:='GT Muehle' // Der Name des Host Anwendung der AI
 else if mode = 8 then Result:='GTMD' // AI ID wird zum korekten Laden der AI aus Spielständen benötigt
 else if mode = 9 then Result:='melinda.ini'; // Name der AI Ini Datei zur speicherung von Bewertungen etc.
end;

// Exportierte Funktionen der DLL
// Diese Funktionen sind die DLL Funktionen welche nach aussen verfügbar sind.
exports
  GetAIInfo, GetMove;

begin
end.
