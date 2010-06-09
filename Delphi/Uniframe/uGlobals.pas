unit uGlobals;

interface

type
  PMyRec = ^TMyRec;
  TMyRec = record
    Caption: WideString;
    ImageIndex: Integer;
    TableListEntry: WideString;
    RelativePath: WideString;
  end;

const giAnyFile = 0;
      giRar = 1;
      giZip = 2;
      giTxt = 3;
      giPdf = 4;
      giBlend = 5;
      giAce = 6;

var Laufwerk: Char;
    TableName: string;
    CanDriveRead: Boolean=false;

function anzahl (text : STRING; zeichen : CHAR) : Integer;
function CropAbChar(text: string; zeichen: char; anzahl: Byte) : string;
function GetStringFromPositionOfCoutedChar(text: string; zeichen: char; anzahl: Byte) : string;

implementation

function GetStringFromPositionOfCoutedChar(text: string; zeichen: char; anzahl: Byte) : string;
VAR position : INTEGER;
    count: Integer;
begin
  count := 0;
  position := 1;
  while(position<Length(text)) do
  begin
    if(text[position]=zeichen) then
    begin
      Inc(Count);
      if count = anzahl then break;
    end;
    Inc(Position);

  end;

  if count < anzahl then Result := text
  else Result := Copy(text, position, Length(text)-position);
end;

function CropAbChar(text: string; zeichen: char; anzahl: Byte) : string;
begin

end;

function anzahl (text : STRING; zeichen : CHAR) : Integer;
VAR position : INTEGER;
begin
  position:=Pos(zeichen,text);
  if position=0 then result:=0 else
  result:=1+anzahl(Copy(text,position+1,Length(text)-position),zeichen);
end;

end.
