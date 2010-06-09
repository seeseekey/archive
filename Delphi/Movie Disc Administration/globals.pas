unit globals;

interface

uses Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Menus, ExtCtrls, StdCtrls, ComCtrls;

var reload: boolean = false;
    searchkey: string;
    searchswitch: boolean = false;
    searchpage: integer;
    globallistindex: integer;
    globallist: TStringList;
    convertlist: TStringList;
    api: integer; //Active Page Index
    createsearch: string = ''; //speichert suchstring zum springen anach new
    delsearch: string = ''; //speichert suchstring zum springen anach new
    deloldindex: longint=0; //alterindex des gelöschten Datensatzes
    reloadview: boolean = false;

procedure creategloballist;
procedure deletegloballist;
procedure createconvertlist;
procedure deleteconvertlist;
procedure fillconvertlistwithcommatext(input: string);

procedure xorfile(Source, Dest, Schluessel: String);

implementation

procedure creategloballist;
begin
globallist := TStringList.Create;
end;

procedure deletegloballist;
begin
globallist.Free;
end;

procedure createconvertlist;
begin
convertlist := TStringList.Create;
end;

procedure deleteconvertlist;
begin
convertlist.free;
end;

procedure fillconvertlistwithcommatext(input: string);
begin
convertlist.CommaText := input;
end;

procedure xorfile(Source, Dest, Schluessel: String);
var buffer: Array[1..40000] of Byte; // dynamischer Speicher wäre schöner
  f, f2: file;
  loop, loop2, gelesen: integer;
begin
  if Trim(Schluessel)='' then
    Schluessel:='asdlkfjöalskjdfölaksdjfölaksjfd';
  AssignFile(f, Source);
  ReSet(f,1);
  AssignFile(f2,Dest);
  ReWrite(f2,1);
  loop2:=1;
  while not EOF(f) do
  begin
    BlockRead(f, buffer, sizeof(buffer), gelesen);
    for loop:= 1 to Gelesen do
    begin
      buffer[loop]:=buffer[loop] XOR Ord(Schluessel[loop2]);
      Inc(loop2);
      if loop2>length(Schluessel) then loop2:=1;
    end; // XOR
    BlockWrite(f2, buffer, gelesen);
  end; // bis zum Ende der Datei
  CloseFile(f);
  CloseFile(f2);
end;

end.

