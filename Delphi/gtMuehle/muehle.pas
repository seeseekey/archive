unit muehle;
interface

uses SysUtils, IdSocketHandle;

type
    gitterstatus = record
    a1, a2, a3, a4, a5, a6, a7, a8,
    b1, b2, b3, b4, b5, b6, b7, b8,
    c1, c2, c3, c4, c5, c6, c7, c8: Integer;
end;

type cbc = record //
     cbc01, cbc02: String;
end;

type
  TBytes = array of Byte;

type netzwerk = record
      player: byte;
      AnotherIP: string;
end;

type
    playerstatus = record
    gamephase: Integer;
    stones: Integer;
    setstones: Integer;
end;

type
    gamestatus = record
    gamemodus: Integer;
end;

type
    feldstatus = array [1..24] of Integer;

var
  playerstatus_white: playerstatus;
  playerstatus_black: playerstatus;
  fieldstatus: gitterstatus;
  global_gamestatus: gamestatus;

  net: netzwerk;

  mms: string;
  mpr: Integer;

  function canplayermove() : Boolean;
  function setfieldstatuszero (field: string) : Boolean;
  function ismuehle (point_to_check: string) : Boolean;
  function validmove (von, nach: string) : Boolean;
  function switchplayer() : Boolean;
  function playergamephase () : Integer;
  function checkplayergamephase () : Boolean;
  function incplayergamephase () : Boolean;
  function setfieldstatus_on_mpr (field: string) : Boolean;
  function getplayersetstones () : Integer;
  function removestone(field:string) : Boolean;
  function isfieldzero(field: string) : boolean;
  function onlylockedstonesonfield() : Boolean;
  function ConvertABCtoArray(fieldstatus: gitterstatus) : feldstatus;
  function ConvertArrayResultToABCResult(input: string) : string;

//uses <Liste von units>;	{ optional }
{ public-Deklarationen }
implementation

//Konvertiert das ArrayResult in das Interne ABC Result
function ConvertArrayResultToABCResult(input: string) : string;
begin
 if input = '01' then Result := 'a1'
 else if input = '02' then Result := 'a2'
 else if input = '03' then Result := 'a3'
 else if input = '04' then Result := 'a4'
 else if input = '05' then Result := 'a5'
 else if input = '06' then Result := 'a6'
 else if input = '07' then Result := 'a7'
 else if input = '08' then Result := 'a8'
 else if input = '09' then Result := 'b1'
 else if input = '10' then Result := 'b2'
 else if input = '11' then Result := 'b3'
 else if input = '12' then Result := 'b4'
 else if input = '13' then Result := 'b5'
 else if input = '14' then Result := 'b6'
 else if input = '15' then Result := 'b7'
 else if input = '16' then Result := 'b8'
 else if input = '17' then Result := 'c1'
 else if input = '18' then Result := 'c2'
 else if input = '19' then Result := 'c3'
 else if input = '20' then Result := 'c4'
 else if input = '21' then Result := 'c5'
 else if input = '22' then Result := 'c6'
 else if input = '23' then Result := 'c7'
 else if input = '24' then Result := 'c8';
end;

// Konvertiert die Internen ABC Werte in AI Array Werte
function ConvertABCtoArray(fieldstatus: gitterstatus) : feldstatus;
var tmpfds: feldstatus;
begin
 tmpfds[1] := fieldstatus.a1;
 tmpfds[2] := fieldstatus.a2;
 tmpfds[3] := fieldstatus.a3;
 tmpfds[4] := fieldstatus.a4;
 tmpfds[5] := fieldstatus.a5;
 tmpfds[6] := fieldstatus.a6;
 tmpfds[7] := fieldstatus.a7;
 tmpfds[8] := fieldstatus.a8;
 tmpfds[9] := fieldstatus.b1;
 tmpfds[10] := fieldstatus.b2;
 tmpfds[11] := fieldstatus.b3;
 tmpfds[12] := fieldstatus.b4;
 tmpfds[13] := fieldstatus.b5;
 tmpfds[14] := fieldstatus.b6;
 tmpfds[15] := fieldstatus.b7;
 tmpfds[16] := fieldstatus.b8;
 tmpfds[17] := fieldstatus.c1;
 tmpfds[18] := fieldstatus.c2;
 tmpfds[19] := fieldstatus.c3;
 tmpfds[20] := fieldstatus.c4;
 tmpfds[21] := fieldstatus.c5;
 tmpfds[22] := fieldstatus.c6;
 tmpfds[23] := fieldstatus.c7;
 tmpfds[24] := fieldstatus.c8;
 Result := tmpfds;
end;

// Hilfsfunktionen
function logical_or(vergleich, a,b: Integer) : Boolean; overload;
begin
if vergleich = a then begin logical_or:=true; exit; end;
if vergleich = b then begin logical_or:=true; exit; end;
logical_or := false;
end;

function logical_or(vergleich, a,b,c: Integer) : Boolean; overload;
begin
if vergleich = a then begin logical_or:=true; exit; end;
if vergleich = b then begin logical_or:=true; exit; end;
if vergleich = c then begin logical_or:=true; exit; end;
logical_or := false;
end;

function logical_or(vergleich, a,b,c,d: Integer) : Boolean; overload;
begin
if vergleich = a then begin logical_or:=true; exit; end;
if vergleich = b then begin logical_or:=true; exit; end;
if vergleich = c then begin logical_or:=true; exit; end;
if vergleich = d then begin logical_or:=true; exit; end;
logical_or := false;
end;
// Hilfsfunktionen END

function canplayermove() : Boolean;
begin
if mpr = 1 then begin
 if playerstatus_white.gamephase = 1 then begin
if fieldstatus.a1 = mpr then begin if logical_or(0, fieldstatus.a2, fieldstatus.a8) = true then begin canplayermove := true; exit; end; end;
if fieldstatus.a2 = mpr then begin if logical_or(0, fieldstatus.a1, fieldstatus.a3, fieldstatus.b2) = true then begin canplayermove := true; exit; end; end;
if fieldstatus.a3 = mpr then begin if logical_or(0, fieldstatus.a2, fieldstatus.a4) = true then begin canplayermove := true; exit; end; end;
if fieldstatus.a4 = mpr then begin if logical_or(0, fieldstatus.a3, fieldstatus.a5, fieldstatus.b4) = true then begin canplayermove := true; exit; end; end;
if fieldstatus.a5 = mpr then begin if logical_or(0, fieldstatus.a4, fieldstatus.a6) = true then begin canplayermove := true; exit; end; end;
if fieldstatus.a6 = mpr then begin if logical_or(0, fieldstatus.a5, fieldstatus.a7, fieldstatus.b6) = true then begin canplayermove := true; exit; end; end;
if fieldstatus.a7 = mpr then begin if logical_or(0, fieldstatus.a6, fieldstatus.a8) = true then begin canplayermove := true; exit; end; end;
if fieldstatus.a8 = mpr then begin if logical_or(0, fieldstatus.a7, fieldstatus.a1, fieldstatus.b8) = true then begin canplayermove := true; exit; end; end;

if fieldstatus.b1 = mpr then begin if logical_or(0, fieldstatus.b8, fieldstatus.b2) = true then begin canplayermove := true; exit; end; end;
if fieldstatus.b2 = mpr then begin if logical_or(0, fieldstatus.b1, fieldstatus.b3, fieldstatus.a2, fieldstatus.c2) = true then begin canplayermove := true; exit; end; end;
if fieldstatus.b3 = mpr then begin if logical_or(0, fieldstatus.b2, fieldstatus.b4) = true then begin canplayermove := true; exit; end; end;
if fieldstatus.b4 = mpr then begin if logical_or(0, fieldstatus.b3, fieldstatus.b5, fieldstatus.a4, fieldstatus.c4) = true then begin canplayermove := true; exit; end; end;
if fieldstatus.b5 = mpr then begin if logical_or(0, fieldstatus.b4, fieldstatus.b6) = true then begin canplayermove := true; exit; end; end;
if fieldstatus.b6 = mpr then begin if logical_or(0, fieldstatus.b5, fieldstatus.b7, fieldstatus.a6, fieldstatus.c6) = true then begin canplayermove := true; exit; end; end;
if fieldstatus.b7 = mpr then begin if logical_or(0, fieldstatus.b6, fieldstatus.b8) = true then begin canplayermove := true; exit; end; end;
if fieldstatus.b8 = mpr then begin if logical_or(0, fieldstatus.b7, fieldstatus.b1, fieldstatus.a8, fieldstatus.c8) = true then begin canplayermove := true; exit; end; end;

if fieldstatus.c1 = mpr then begin if logical_or(0, fieldstatus.c2, fieldstatus.c8) = true then begin canplayermove := true; exit; end; end;
if fieldstatus.c2 = mpr then begin if logical_or(0, fieldstatus.c1, fieldstatus.c3, fieldstatus.b2) = true then begin canplayermove := true; exit; end; end;
if fieldstatus.c3 = mpr then begin if logical_or(0, fieldstatus.c2, fieldstatus.c4) = true then begin canplayermove := true; exit; end; end;
if fieldstatus.c4 = mpr then begin if logical_or(0, fieldstatus.c3, fieldstatus.c5, fieldstatus.b4) = true then begin canplayermove := true; exit; end; end;
if fieldstatus.c5 = mpr then begin if logical_or(0, fieldstatus.c4, fieldstatus.c6) = true then begin canplayermove := true; exit; end; end;
if fieldstatus.c6 = mpr then begin if logical_or(0, fieldstatus.c5, fieldstatus.c7, fieldstatus.b6) = true then begin canplayermove := true; exit; end; end;
if fieldstatus.c7 = mpr then begin if logical_or(0, fieldstatus.c6, fieldstatus.c8) = true then begin canplayermove := true; exit; end; end;
if fieldstatus.c8 = mpr then begin if logical_or(0, fieldstatus.c7, fieldstatus.c1, fieldstatus.b8) = true then begin canplayermove := true; exit; end; end;
 canplayermove := false;
 exit;
 end;
end

else if mpr = 2 then begin
 if playerstatus_black.gamephase = 1 then begin
if fieldstatus.a1 = mpr then begin if logical_or(0, fieldstatus.a2, fieldstatus.a8) = true then begin canplayermove := true; exit; end; end;
if fieldstatus.a2 = mpr then begin if logical_or(0, fieldstatus.a1, fieldstatus.a3, fieldstatus.b2) = true then begin canplayermove := true; exit; end; end;
if fieldstatus.a3 = mpr then begin if logical_or(0, fieldstatus.a2, fieldstatus.a4) = true then begin canplayermove := true; exit; end; end;
if fieldstatus.a4 = mpr then begin if logical_or(0, fieldstatus.a3, fieldstatus.a5, fieldstatus.b4) = true then begin canplayermove := true; exit; end; end;
if fieldstatus.a5 = mpr then begin if logical_or(0, fieldstatus.a4, fieldstatus.a6) = true then begin canplayermove := true; exit; end; end;
if fieldstatus.a6 = mpr then begin if logical_or(0, fieldstatus.a5, fieldstatus.a7, fieldstatus.b6) = true then begin canplayermove := true; exit; end; end;
if fieldstatus.a7 = mpr then begin if logical_or(0, fieldstatus.a6, fieldstatus.a8) = true then begin canplayermove := true; exit; end; end;
if fieldstatus.a8 = mpr then begin if logical_or(0, fieldstatus.a7, fieldstatus.a1, fieldstatus.b8) = true then begin canplayermove := true; exit; end; end;

if fieldstatus.b1 = mpr then begin if logical_or(0, fieldstatus.b8, fieldstatus.b2) = true then begin canplayermove := true; exit; end; end;
if fieldstatus.b2 = mpr then begin if logical_or(0, fieldstatus.b1, fieldstatus.b3, fieldstatus.a2, fieldstatus.c2) = true then begin canplayermove := true; exit; end; end;
if fieldstatus.b3 = mpr then begin if logical_or(0, fieldstatus.b2, fieldstatus.b4) = true then begin canplayermove := true; exit; end; end;
if fieldstatus.b4 = mpr then begin if logical_or(0, fieldstatus.b3, fieldstatus.b5, fieldstatus.a4, fieldstatus.c4) = true then begin canplayermove := true; exit; end; end;
if fieldstatus.b5 = mpr then begin if logical_or(0, fieldstatus.b4, fieldstatus.b6) = true then begin canplayermove := true; exit; end; end;
if fieldstatus.b6 = mpr then begin if logical_or(0, fieldstatus.b5, fieldstatus.b7, fieldstatus.a6, fieldstatus.c6) = true then begin canplayermove := true; exit; end; end;
if fieldstatus.b7 = mpr then begin if logical_or(0, fieldstatus.b6, fieldstatus.b8) = true then begin canplayermove := true; exit; end; end;
if fieldstatus.b8 = mpr then begin if logical_or(0, fieldstatus.b7, fieldstatus.b1, fieldstatus.a8, fieldstatus.c8) = true then begin canplayermove := true; exit; end; end;

if fieldstatus.c1 = mpr then begin if logical_or(0, fieldstatus.c2, fieldstatus.c8) = true then begin canplayermove := true; exit; end; end;
if fieldstatus.c2 = mpr then begin if logical_or(0, fieldstatus.c1, fieldstatus.c3, fieldstatus.b2) = true then begin canplayermove := true; exit; end; end;
if fieldstatus.c3 = mpr then begin if logical_or(0, fieldstatus.c2, fieldstatus.c4) = true then begin canplayermove := true; exit; end; end;
if fieldstatus.c4 = mpr then begin if logical_or(0, fieldstatus.c3, fieldstatus.c5, fieldstatus.b4) = true then begin canplayermove := true; exit; end; end;
if fieldstatus.c5 = mpr then begin if logical_or(0, fieldstatus.c4, fieldstatus.c6) = true then begin canplayermove := true; exit; end; end;
if fieldstatus.c6 = mpr then begin if logical_or(0, fieldstatus.c5, fieldstatus.c7, fieldstatus.b6) = true then begin canplayermove := true; exit; end; end;
if fieldstatus.c7 = mpr then begin if logical_or(0, fieldstatus.c6, fieldstatus.c8) = true then begin canplayermove := true; exit; end; end;
if fieldstatus.c8 = mpr then begin if logical_or(0, fieldstatus.c7, fieldstatus.c1, fieldstatus.b8) = true then begin canplayermove := true; exit; end; end;
 canplayermove := false;
 exit;
 end;
end;

canplayermove := true;
end;

function setfieldstatuszero (field: string) : Boolean;
begin
field := lowercase(field);
if field = 'a1' then fieldstatus.a1 := 0
else if field = 'a2' then fieldstatus.a2 := 0
else if field = 'a3' then fieldstatus.a3 := 0
else if field = 'a4' then fieldstatus.a4 := 0
else if field = 'a5' then fieldstatus.a5 := 0
else if field = 'a6' then fieldstatus.a6 := 0
else if field = 'a7' then fieldstatus.a7 := 0
else if field = 'a8' then fieldstatus.a8 := 0
else if field = 'b1' then fieldstatus.b1 := 0
else if field = 'b2' then fieldstatus.b2 := 0
else if field = 'b3' then fieldstatus.b3 := 0
else if field = 'b4' then fieldstatus.b4 := 0
else if field = 'b5' then fieldstatus.b5 := 0
else if field = 'b6' then fieldstatus.b6 := 0
else if field = 'b7' then fieldstatus.b7 := 0
else if field = 'b8' then fieldstatus.b8 := 0
else if field = 'c1' then fieldstatus.c1 := 0
else if field = 'c2' then fieldstatus.c2 := 0
else if field = 'c3' then fieldstatus.c3 := 0
else if field = 'c4' then fieldstatus.c4 := 0
else if field = 'c5' then fieldstatus.c5 := 0
else if field = 'c6' then fieldstatus.c6 := 0
else if field = 'c7' then fieldstatus.c7 := 0
else if field = 'c8' then fieldstatus.c8 := 0;
setfieldstatuszero := true;
end;

function ismuehle (point_to_check: string) : Boolean;
var
   a,b,c,d : Integer;
begin
point_to_check := LowerCase(point_to_check);
a:=0;b:=0;c:=0;d:=0;

// A1
if point_to_check = 'a1' then begin a := fieldstatus.a2;
b := fieldstatus.a3; c := fieldstatus.a8; d := fieldstatus.a7; end
// A2
else if point_to_check = 'a2' then begin a := fieldstatus.a1;
b := fieldstatus.a3; c := fieldstatus.b2; d := fieldstatus.c2; end
// A3
else if point_to_check = 'a3' then begin a := fieldstatus.a1;
b := fieldstatus.a2; c := fieldstatus.a4; d := fieldstatus.a5; end
// A4
else if point_to_check = 'a4' then begin a := fieldstatus.a3;
b := fieldstatus.a5; c := fieldstatus.b4; d := fieldstatus.c4; end
// A5
else if point_to_check = 'a5' then begin a := fieldstatus.a4;
b := fieldstatus.a3; c := fieldstatus.a6; d := fieldstatus.a7; end
// A6
else if point_to_check = 'a6' then begin a := fieldstatus.a5;
b := fieldstatus.a7; c := fieldstatus.b6; d := fieldstatus.c6; end
// A7
else if point_to_check = 'a7' then begin a := fieldstatus.a6;
b := fieldstatus.a5; c := fieldstatus.a8; d := fieldstatus.a1; end
// A8
else if point_to_check = 'a8' then begin a := fieldstatus.a7;
b := fieldstatus.a1; c := fieldstatus.b8; d := fieldstatus.c8; end
// B1
else if point_to_check = 'b1' then begin a := fieldstatus.b2;
b := fieldstatus.b3; c := fieldstatus.b8; d := fieldstatus.b7; end
// B2
else if point_to_check = 'b2' then begin a := fieldstatus.b1;
b := fieldstatus.b3; c := fieldstatus.a2; d := fieldstatus.c2; end
// B3
else if point_to_check = 'b3' then begin a := fieldstatus.b1;
b := fieldstatus.b2; c := fieldstatus.b4; d := fieldstatus.b5; end
// B4
else if point_to_check = 'b4' then begin a := fieldstatus.b3;
b := fieldstatus.b5; c := fieldstatus.a4; d := fieldstatus.c4; end
// B5
else if point_to_check = 'b5' then begin a := fieldstatus.b3;
b := fieldstatus.b4; c := fieldstatus.b6; d := fieldstatus.b7; end
// B6
else if point_to_check = 'b6' then begin a := fieldstatus.b5;
b := fieldstatus.b7; c := fieldstatus.a6; d := fieldstatus.c6; end
// B7
else if point_to_check = 'b7' then begin a := fieldstatus.b6;
b := fieldstatus.b5; c := fieldstatus.b8; d := fieldstatus.b1; end
// B8
else if point_to_check = 'b8' then begin a := fieldstatus.b7;
b := fieldstatus.b1; c := fieldstatus.a8; d := fieldstatus.c8; end
// C1
else if point_to_check = 'c1' then begin a := fieldstatus.c2;
b := fieldstatus.c3; c := fieldstatus.c8; d := fieldstatus.c7; end
// C2
else if point_to_check = 'c2' then begin a := fieldstatus.c1;
b := fieldstatus.c3; c := fieldstatus.a2; d := fieldstatus.b2; end
// C3
else if point_to_check = 'c3' then begin a := fieldstatus.c1;
b := fieldstatus.c2; c := fieldstatus.c4; d := fieldstatus.c5; end
// C4
else if point_to_check = 'c4' then begin a := fieldstatus.c3;
b := fieldstatus.c5; c := fieldstatus.a4; d := fieldstatus.b4; end
// C5
else if point_to_check = 'c5' then begin a := fieldstatus.c3;
b := fieldstatus.c4; c := fieldstatus.c6; d := fieldstatus.c7; end
// C6
else if point_to_check = 'c6' then begin a := fieldstatus.c5;
b := fieldstatus.c7; c := fieldstatus.a6; d := fieldstatus.b6; end
// C7
else if point_to_check = 'c7' then begin a := fieldstatus.c6;
b := fieldstatus.c5; c := fieldstatus.c8; d := fieldstatus.c1; end
// C8
else if point_to_check = 'c8' then begin a := fieldstatus.c7;
b := fieldstatus.c1; c := fieldstatus.a8; d := fieldstatus.b8; end;

// Mühlecheck
if (a and b) = mpr then begin ismuehle := true; exit; end
else if (c and d) = mpr then begin ismuehle := true; exit; end;

ismuehle := false;
end;


function validmove (von, nach: string) : Boolean;
var
 phase1: Boolean;
begin
von := LowerCase(von); nach := LowerCase(nach);
phase1 := false;

if mpr = 1 then
   begin
    if logical_or(playerstatus_white.gamephase, 0, 2) = true then
       begin
        if nach = 'a1' then begin if fieldstatus.a1 = 0 then begin validmove := true; exit; end; end;
        if nach = 'a2' then begin if fieldstatus.a2 = 0 then begin validmove := true; exit; end; end;
        if nach = 'a3' then begin if fieldstatus.a3 = 0 then begin validmove := true; exit; end; end;
        if nach = 'a4' then begin if fieldstatus.a4 = 0 then begin validmove := true; exit; end; end;
        if nach = 'a5' then begin if fieldstatus.a5 = 0 then begin validmove := true; exit; end; end;
        if nach = 'a6' then begin if fieldstatus.a6 = 0 then begin validmove := true; exit; end; end;
        if nach = 'a7' then begin if fieldstatus.a7 = 0 then begin validmove := true; exit; end; end;
        if nach = 'a8' then begin if fieldstatus.a8 = 0 then begin validmove := true; exit; end; end;
        if nach = 'b1' then begin if fieldstatus.b1 = 0 then begin validmove := true; exit; end; end;
        if nach = 'b2' then begin if fieldstatus.b2 = 0 then begin validmove := true; exit; end; end;
        if nach = 'b3' then begin if fieldstatus.b3 = 0 then begin validmove := true; exit; end; end;
        if nach = 'b4' then begin if fieldstatus.b4 = 0 then begin validmove := true; exit; end; end;
        if nach = 'b5' then begin if fieldstatus.b5 = 0 then begin validmove := true; exit; end; end;
        if nach = 'b6' then begin if fieldstatus.b6 = 0 then begin validmove := true; exit; end; end;
        if nach = 'b7' then begin if fieldstatus.b7 = 0 then begin validmove := true; exit; end; end;
        if nach = 'b8' then begin if fieldstatus.b8 = 0 then begin validmove := true; exit; end; end;
        if nach = 'c1' then begin if fieldstatus.c1 = 0 then begin validmove := true; exit; end; end;
        if nach = 'c2' then begin if fieldstatus.c2 = 0 then begin validmove := true; exit; end; end;
        if nach = 'c3' then begin if fieldstatus.c3 = 0 then begin validmove := true; exit; end; end;
        if nach = 'c4' then begin if fieldstatus.c4 = 0 then begin validmove := true; exit; end; end;
        if nach = 'c5' then begin if fieldstatus.c5 = 0 then begin validmove := true; exit; end; end;
        if nach = 'c6' then begin if fieldstatus.c6 = 0 then begin validmove := true; exit; end; end;
        if nach = 'c7' then begin if fieldstatus.c7 = 0 then begin validmove := true; exit; end; end;
        if nach = 'c8' then begin if fieldstatus.c8 = 0 then begin validmove := true; exit; end; end;
       end
    else phase1 := true;
   end
else
   begin
    if logical_or(playerstatus_black.gamephase, 0, 2) = true then
       begin
        if nach = 'a1' then begin if fieldstatus.a1 = 0 then begin validmove := true; exit; end; end;
        if nach = 'a2' then begin if fieldstatus.a2 = 0 then begin validmove := true; exit; end; end;
        if nach = 'a3' then begin if fieldstatus.a3 = 0 then begin validmove := true; exit; end; end;
        if nach = 'a4' then begin if fieldstatus.a4 = 0 then begin validmove := true; exit; end; end;
        if nach = 'a5' then begin if fieldstatus.a5 = 0 then begin validmove := true; exit; end; end;
        if nach = 'a6' then begin if fieldstatus.a6 = 0 then begin validmove := true; exit; end; end;
        if nach = 'a7' then begin if fieldstatus.a7 = 0 then begin validmove := true; exit; end; end;
        if nach = 'a8' then begin if fieldstatus.a8 = 0 then begin validmove := true; exit; end; end;
        if nach = 'b1' then begin if fieldstatus.b1 = 0 then begin validmove := true; exit; end; end;
        if nach = 'b2' then begin if fieldstatus.b2 = 0 then begin validmove := true; exit; end; end;
        if nach = 'b3' then begin if fieldstatus.b3 = 0 then begin validmove := true; exit; end; end;
        if nach = 'b4' then begin if fieldstatus.b4 = 0 then begin validmove := true; exit; end; end;
        if nach = 'b5' then begin if fieldstatus.b5 = 0 then begin validmove := true; exit; end; end;
        if nach = 'b6' then begin if fieldstatus.b6 = 0 then begin validmove := true; exit; end; end;
        if nach = 'b7' then begin if fieldstatus.b7 = 0 then begin validmove := true; exit; end; end;
        if nach = 'b8' then begin if fieldstatus.b8 = 0 then begin validmove := true; exit; end; end;
        if nach = 'c1' then begin if fieldstatus.c1 = 0 then begin validmove := true; exit; end; end;
        if nach = 'c2' then begin if fieldstatus.c2 = 0 then begin validmove := true; exit; end; end;
        if nach = 'c3' then begin if fieldstatus.c3 = 0 then begin validmove := true; exit; end; end;
        if nach = 'c4' then begin if fieldstatus.c4 = 0 then begin validmove := true; exit; end; end;
        if nach = 'c5' then begin if fieldstatus.c5 = 0 then begin validmove := true; exit; end; end;
        if nach = 'c6' then begin if fieldstatus.c6 = 0 then begin validmove := true; exit; end; end;
        if nach = 'c7' then begin if fieldstatus.c7 = 0 then begin validmove := true; exit; end; end;
        if nach = 'c8' then begin if fieldstatus.c8 = 0 then begin validmove := true; exit; end; end;
       end
    else phase1 := true;
   end;

if phase1 = true then
   begin

    // A1
    if von = 'a1' then begin
     if nach = 'a2' then begin if fieldstatus.a2 = 0 then begin validmove := true; exit; end; end;
     if nach = 'a8' then begin if fieldstatus.a8 = 0 then begin validmove := true; exit; end; end;
    end
    // A2
    else if von = 'a2' then begin
     if nach = 'a1' then begin if fieldstatus.a1 = 0 then begin validmove := true; exit; end; end;
     if nach = 'a3' then begin if fieldstatus.a3 = 0 then begin validmove := true; exit; end; end;
     if nach = 'b2' then begin if fieldstatus.b2 = 0 then begin validmove := true; exit; end; end;
    end
    // A3
    else if von = 'a3' then begin
     if nach = 'a2' then begin if fieldstatus.a2 = 0 then begin validmove := true; exit; end; end;
     if nach = 'a4' then begin if fieldstatus.a4 = 0 then begin validmove := true; exit; end; end;
    end
    // A4
    else if von = 'a4' then begin
     if nach = 'a3' then begin if fieldstatus.a3 = 0 then begin validmove := true; exit; end; end;
     if nach = 'a5' then begin if fieldstatus.a5 = 0 then begin validmove := true; exit; end; end;
     if nach = 'b4' then begin if fieldstatus.b4 = 0 then begin validmove := true; exit; end; end;
    end
    // A5
    else if von = 'a5' then begin
     if nach = 'a4' then begin if fieldstatus.a4 = 0 then begin validmove := true; exit; end; end;
     if nach = 'a6' then begin if fieldstatus.a6 = 0 then begin validmove := true; exit; end; end;
    end
    // A6
    else if von = 'a6' then begin
     if nach = 'a5' then begin if fieldstatus.a5 = 0 then begin validmove := true; exit; end; end;
     if nach = 'a7' then begin if fieldstatus.a7 = 0 then begin validmove := true; exit; end; end;
     if nach = 'b6' then begin if fieldstatus.b6 = 0 then begin validmove := true; exit; end; end;
    end
    // A7
    else if von = 'a7' then begin
     if nach = 'a6' then begin if fieldstatus.a6 = 0 then begin validmove := true; exit; end; end;
     if nach = 'a8' then begin if fieldstatus.a8 = 0 then begin validmove := true; exit; end; end;
    end
    // A8
    else if von = 'a8' then begin
     if nach = 'a7' then begin if fieldstatus.a7 = 0 then begin validmove := true; exit; end; end;
     if nach = 'a1' then begin if fieldstatus.a1 = 0 then begin validmove := true; exit; end; end;
     if nach = 'b8' then begin if fieldstatus.b8 = 0 then begin validmove := true; exit; end; end;
    end
    // B1
    else if von = 'b1' then begin
     if nach = 'b2' then begin if fieldstatus.b2 = 0 then begin validmove := true; exit; end; end;
     if nach = 'b8' then begin if fieldstatus.b8 = 0 then begin validmove := true; exit; end; end;
    end
    // B2
    else if von = 'b2' then begin
     if nach = 'b1' then begin if fieldstatus.b1 = 0 then begin validmove := true; exit; end; end;
     if nach = 'b3' then begin if fieldstatus.b3 = 0 then begin validmove := true; exit; end; end;
     if nach = 'a2' then begin if fieldstatus.a2 = 0 then begin validmove := true; exit; end; end;
     if nach = 'c2' then begin if fieldstatus.c2 = 0 then begin validmove := true; exit; end; end;
    end
    // B3
    else if von = 'b3' then begin
     if nach = 'b2' then begin if fieldstatus.b2 = 0 then begin validmove := true; exit; end; end;
     if nach = 'b4' then begin if fieldstatus.b4 = 0 then begin validmove := true; exit; end; end;
    end
    // B4
    else if von = 'b4' then begin
     if nach = 'b3' then begin if fieldstatus.b3 = 0 then begin validmove := true; exit; end; end;
     if nach = 'b5' then begin if fieldstatus.b5 = 0 then begin validmove := true; exit; end; end;
     if nach = 'a4' then begin if fieldstatus.a4 = 0 then begin validmove := true; exit; end; end;
     if nach = 'c4' then begin if fieldstatus.c4 = 0 then begin validmove := true; exit; end; end;
    end
    // B5
    else if von = 'b5' then begin
     if nach = 'b4' then begin if fieldstatus.b4 = 0 then begin validmove := true; exit; end; end;
     if nach = 'b6' then begin if fieldstatus.b6 = 0 then begin validmove := true; exit; end; end;
    end
    // B6
    else if von = 'b6' then begin
     if nach = 'b5' then begin if fieldstatus.b5 = 0 then begin validmove := true; exit; end; end;
     if nach = 'b7' then begin if fieldstatus.b7 = 0 then begin validmove := true; exit; end; end;
     if nach = 'a6' then begin if fieldstatus.a6 = 0 then begin validmove := true; exit; end; end;
     if nach = 'c6' then begin if fieldstatus.c6 = 0 then begin validmove := true; exit; end; end;
    end
    // B7
    else if von = 'b7' then begin
     if nach = 'b6' then begin if fieldstatus.b6 = 0 then begin validmove := true; exit; end; end;
     if nach = 'b8' then begin if fieldstatus.b8 = 0 then begin validmove := true; exit; end; end;
    end
    // B8
    else if von = 'b8' then begin
     if nach = 'b7' then begin if fieldstatus.b7 = 0 then begin validmove := true; exit; end; end;
     if nach = 'b1' then begin if fieldstatus.b1 = 0 then begin validmove := true; exit; end; end;
     if nach = 'a8' then begin if fieldstatus.a8 = 0 then begin validmove := true; exit; end; end;
     if nach = 'c8' then begin if fieldstatus.c8 = 0 then begin validmove := true; exit; end; end;
    end
    // C1
    else if von = 'c1' then begin
     if nach = 'c2' then begin if fieldstatus.c2 = 0 then begin validmove := true; exit; end; end;
     if nach = 'c8' then begin if fieldstatus.c8 = 0 then begin validmove := true; exit; end; end;
    end
    // C2
    else if von = 'c2' then begin
     if nach = 'c1' then begin if fieldstatus.c1 = 0 then begin validmove := true; exit; end; end;
     if nach = 'c3' then begin if fieldstatus.c3 = 0 then begin validmove := true; exit; end; end;
     if nach = 'b2' then begin if fieldstatus.b2 = 0 then begin validmove := true; exit; end; end;
   end
    // C3
    else if von = 'c3' then begin
     if nach = 'c2' then begin if fieldstatus.c2 = 0 then begin validmove := true; exit; end; end;
     if nach = 'c4' then begin if fieldstatus.c4 = 0 then begin validmove := true; exit; end; end;
   end
    // C4
    else if von = 'c4' then begin
     if nach = 'c3' then begin if fieldstatus.c3 = 0 then begin validmove := true; exit; end; end;
     if nach = 'c5' then begin if fieldstatus.c5 = 0 then begin validmove := true; exit; end; end;
     if nach = 'b4' then begin if fieldstatus.b4 = 0 then begin validmove := true; exit; end; end;
   end
    // C5
    else if von = 'c5' then begin
     if nach = 'c4' then begin if fieldstatus.c4 = 0 then begin validmove := true; exit; end; end;
     if nach = 'c6' then begin if fieldstatus.c6 = 0 then begin validmove := true; exit; end; end;
   end
    // C6
    else if von = 'c6' then begin
     if nach = 'c5' then begin if fieldstatus.c5 = 0 then begin validmove := true; exit; end; end;
     if nach = 'c7' then begin if fieldstatus.c7 = 0 then begin validmove := true; exit; end; end;
     if nach = 'b6' then begin if fieldstatus.b6 = 0 then begin validmove := true; exit; end; end;
    end
    // C7
    else if von = 'c7' then begin
     if nach = 'c6' then begin if fieldstatus.c6 = 0 then begin validmove := true; exit; end; end;
     if nach = 'c8' then begin if fieldstatus.c8 = 0 then begin validmove := true; exit; end; end;
   end
    // C8
    else if von = 'c8' then begin
     if nach = 'c7' then begin if fieldstatus.c7 = 0 then begin validmove := true; exit; end; end;
     if nach = 'c1' then begin if fieldstatus.c1 = 0 then begin validmove := true; exit; end; end;
     if nach = 'b8' then begin if fieldstatus.b8 = 0 then begin validmove := true; exit; end; end;
       end
   end;

validmove := false;
end;

// wechselt die Spieler
function switchplayer() : Boolean;
begin
if mpr = 1 then mpr := 2
else mpr := 1;

switchplayer := true;
end;

// ermittelt die gamephase des momentanen spielers und gibt sie zurück
function playergamephase () : Integer;
begin
 if mpr = 1 then playergamephase := playerstatus_white.gamephase
 else playergamephase := playerstatus_black.gamephase;
end;

function checkplayergamephase () : Boolean;
begin
if mpr = 1 then
 begin
  if playerstatus_white.setstones = 0 then playerstatus_white.gamephase := 1;
  if playerstatus_white.stones = 3 then playerstatus_white.gamephase := 2;
 end
else if mpr = 2 then
 begin
  if playerstatus_black.setstones < 1 then playerstatus_black.gamephase := 1;
  if playerstatus_black.stones = 3 then playerstatus_black.gamephase := 2;
 end;

 checkplayergamephase := true;
end;

function incplayergamephase () : Boolean;
begin
 if mpr = 1 then inc(playerstatus_white.gamephase)
 else inc(playerstatus_black.gamephase);
incplayergamephase := true;
end;

function getplayersetstones () : Integer;
begin
 if mpr = 1 then getplayersetstones := playerstatus_white.setstones
 else getplayersetstones := playerstatus_black.setstones;
end;

function setfieldstatus_on_mpr (field: string) : Boolean;
begin
 if field = 'a1' then fieldstatus.a1 := mpr
 else if field = 'a2' then fieldstatus.a2 := mpr
 else if field = 'a3' then fieldstatus.a3 := mpr
 else if field = 'a4' then fieldstatus.a4 := mpr
 else if field = 'a5' then fieldstatus.a5 := mpr
 else if field = 'a6' then fieldstatus.a6 := mpr
 else if field = 'a7' then fieldstatus.a7 := mpr
 else if field = 'a8' then fieldstatus.a8 := mpr
 else if field = 'b1' then fieldstatus.b1 := mpr
 else if field = 'b2' then fieldstatus.b2 := mpr
 else if field = 'b3' then fieldstatus.b3 := mpr
 else if field = 'b4' then fieldstatus.b4 := mpr
 else if field = 'b5' then fieldstatus.b5 := mpr
 else if field = 'b6' then fieldstatus.b6 := mpr
 else if field = 'b7' then fieldstatus.b7 := mpr
 else if field = 'b8' then fieldstatus.b8 := mpr
 else if field = 'c1' then fieldstatus.c1 := mpr
 else if field = 'c2' then fieldstatus.c2 := mpr
 else if field = 'c3' then fieldstatus.c3 := mpr
 else if field = 'c4' then fieldstatus.c4 := mpr
 else if field = 'c5' then fieldstatus.c5 := mpr
 else if field = 'c6' then fieldstatus.c6 := mpr
 else if field = 'c7' then fieldstatus.c7 := mpr
 else if field = 'c8' then fieldstatus.c8 := mpr;
setfieldstatus_on_mpr := true;
end;


function removestone(field:string) : Boolean;
begin
 if field = 'a1' then fieldstatus.a1 := 0
 else if field = 'a2' then fieldstatus.a2 := 0
 else if field = 'a3' then fieldstatus.a3 := 0
 else if field = 'a4' then fieldstatus.a4 := 0
 else if field = 'a5' then fieldstatus.a5 := 0
 else if field = 'a6' then fieldstatus.a6 := 0
 else if field = 'a7' then fieldstatus.a7 := 0
 else if field = 'a8' then fieldstatus.a8 := 0
 else if field = 'b1' then fieldstatus.b1 := 0
 else if field = 'b2' then fieldstatus.b2 := 0
 else if field = 'b3' then fieldstatus.b3 := 0
 else if field = 'b4' then fieldstatus.b4 := 0
 else if field = 'b5' then fieldstatus.b5 := 0
 else if field = 'b6' then fieldstatus.b6 := 0
 else if field = 'b7' then fieldstatus.b7 := 0
 else if field = 'b8' then fieldstatus.b8 := 0
 else if field = 'c1' then fieldstatus.c1 := 0
 else if field = 'c2' then fieldstatus.c2 := 0
 else if field = 'c3' then fieldstatus.c3 := 0
 else if field = 'c4' then fieldstatus.c4 := 0
 else if field = 'c5' then fieldstatus.c5 := 0
 else if field = 'c6' then fieldstatus.c6 := 0
 else if field = 'c7' then fieldstatus.c7 := 0
 else if field = 'c8' then fieldstatus.c8 := 0;
 removestone := true;
end;

function isfieldzero(field: string) : boolean;
begin
if field = 'a1' then begin if fieldstatus.a1 = 0 then begin isfieldzero:=true; exit; end; end
else if field = 'a2' then begin if fieldstatus.a2 = 0 then begin isfieldzero:=true; exit; end; end
else if field = 'a3' then begin if fieldstatus.a3 = 0 then begin isfieldzero:=true; exit; end; end
else if field = 'a4' then begin if fieldstatus.a4 = 0 then begin isfieldzero:=true; exit; end; end
else if field = 'a5' then begin if fieldstatus.a5 = 0 then begin isfieldzero:=true; exit; end; end
else if field = 'a6' then begin if fieldstatus.a6 = 0 then begin isfieldzero:=true; exit; end; end
else if field = 'a7' then begin if fieldstatus.a7 = 0 then begin isfieldzero:=true; exit; end; end
else if field = 'a8' then begin if fieldstatus.a8 = 0 then begin isfieldzero:=true; exit; end; end

else if field = 'b1' then begin if fieldstatus.b1 = 0 then begin isfieldzero:=true; exit; end; end
else if field = 'b2' then begin if fieldstatus.b2 = 0 then begin isfieldzero:=true; exit; end; end
else if field = 'b3' then begin if fieldstatus.b3 = 0 then begin isfieldzero:=true; exit; end; end
else if field = 'b4' then begin if fieldstatus.b4 = 0 then begin isfieldzero:=true; exit; end; end
else if field = 'b5' then begin if fieldstatus.b5 = 0 then begin isfieldzero:=true; exit; end; end
else if field = 'b6' then begin if fieldstatus.b6 = 0 then begin isfieldzero:=true; exit; end; end
else if field = 'b7' then begin if fieldstatus.b7 = 0 then begin isfieldzero:=true; exit; end; end
else if field = 'b8' then begin if fieldstatus.b8 = 0 then begin isfieldzero:=true; exit; end; end

else if field = 'c1' then begin if fieldstatus.c1 = 0 then begin isfieldzero:=true; exit; end; end
else if field = 'c2' then begin if fieldstatus.c2 = 0 then begin isfieldzero:=true; exit; end; end
else if field = 'c3' then begin if fieldstatus.c3 = 0 then begin isfieldzero:=true; exit; end; end
else if field = 'c4' then begin if fieldstatus.c4 = 0 then begin isfieldzero:=true; exit; end; end
else if field = 'c5' then begin if fieldstatus.c5 = 0 then begin isfieldzero:=true; exit; end; end
else if field = 'c6' then begin if fieldstatus.c6 = 0 then begin isfieldzero:=true; exit; end; end
else if field = 'c7' then begin if fieldstatus.c7 = 0 then begin isfieldzero:=true; exit; end; end
else if field = 'c8' then begin if fieldstatus.c8 = 0 then begin isfieldzero:=true; exit; end; end;
isfieldzero:=false;
end;

function onlylockedstonesonfield() : Boolean;
begin                                                                                                                 
if fieldstatus.a1 = mpr then begin if ismuehle('a1') = false then begin onlylockedstonesonfield:=false; exit; end; end;
if fieldstatus.a2 = mpr then begin if ismuehle('a2') = false then begin onlylockedstonesonfield:=false; exit; end; end;
if fieldstatus.a3 = mpr then begin if ismuehle('a3') = false then begin onlylockedstonesonfield:=false; exit; end; end;
if fieldstatus.a4 = mpr then begin if ismuehle('a4') = false then begin onlylockedstonesonfield:=false; exit; end; end;
if fieldstatus.a5 = mpr then begin if ismuehle('a5') = false then begin onlylockedstonesonfield:=false; exit; end; end;
if fieldstatus.a6 = mpr then begin if ismuehle('a6') = false then begin onlylockedstonesonfield:=false; exit; end; end;
if fieldstatus.a7 = mpr then begin if ismuehle('a7') = false then begin onlylockedstonesonfield:=false; exit; end; end;
if fieldstatus.a8 = mpr then begin if ismuehle('a8') = false then begin onlylockedstonesonfield:=false; exit; end; end;
if fieldstatus.b1 = mpr then begin if ismuehle('b1') = false then begin onlylockedstonesonfield:=false; exit; end; end;
if fieldstatus.b2 = mpr then begin if ismuehle('b2') = false then begin onlylockedstonesonfield:=false; exit; end; end;
if fieldstatus.b3 = mpr then begin if ismuehle('b3') = false then begin onlylockedstonesonfield:=false; exit; end; end;
if fieldstatus.b4 = mpr then begin if ismuehle('b4') = false then begin onlylockedstonesonfield:=false; exit; end; end;
if fieldstatus.b5 = mpr then begin if ismuehle('b5') = false then begin onlylockedstonesonfield:=false; exit; end; end;
if fieldstatus.b6 = mpr then begin if ismuehle('b6') = false then begin onlylockedstonesonfield:=false; exit; end; end;
if fieldstatus.b7 = mpr then begin if ismuehle('b7') = false then begin onlylockedstonesonfield:=false; exit; end; end;
if fieldstatus.b8 = mpr then begin if ismuehle('b8') = false then begin onlylockedstonesonfield:=false; exit; end; end;
if fieldstatus.c1 = mpr then begin if ismuehle('c1') = false then begin onlylockedstonesonfield:=false; exit; end; end;
if fieldstatus.c2 = mpr then begin if ismuehle('c2') = false then begin onlylockedstonesonfield:=false; exit; end; end;
if fieldstatus.c3 = mpr then begin if ismuehle('c3') = false then begin onlylockedstonesonfield:=false; exit; end; end;
if fieldstatus.c4 = mpr then begin if ismuehle('c4') = false then begin onlylockedstonesonfield:=false; exit; end; end;
if fieldstatus.c5 = mpr then begin if ismuehle('c5') = false then begin onlylockedstonesonfield:=false; exit; end; end;
if fieldstatus.c6 = mpr then begin if ismuehle('c6') = false then begin onlylockedstonesonfield:=false; exit; end; end;
if fieldstatus.c7 = mpr then begin if ismuehle('c7') = false then begin onlylockedstonesonfield:=false; exit; end; end;
if fieldstatus.c8 = mpr then begin if ismuehle('c8') = false then begin onlylockedstonesonfield:=false; exit; end; end;

onlylockedstonesonfield:=true;
end;

//uses <Liste von units>;	{ optional }
{ private-Deklarationen }
{ Implementierung von Prozeduren und Funktionen }
initialization	{ optional }
playerstatus_white.gamephase := 0;
playerstatus_black.gamephase := 0;

playerstatus_white.stones := 9;
playerstatus_black.stones := 9;

playerstatus_white.setstones := 9;
playerstatus_black.setstones := 9;

mms := '';
mpr := 1; // Spieler 1

global_gamestatus.gamemodus := 0;
{ optionaler Initialisierungs-Quelltext }
end.
