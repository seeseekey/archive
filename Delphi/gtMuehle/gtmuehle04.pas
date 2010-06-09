unit gtmuehle04;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, Menus, muehle;

type TGetAIInfo = function (mode: Integer) : PChar;
type TGetMove = function (fieldstatus: feldstatus; mpr: Integer;
                          playergamephase: Integer;
                          removemode: Boolean): PChar;

function SSFGetAIInfo(mode: Integer) : String;
function SSFGetMove(fieldstatus: gitterstatus; mpr: Integer;
                    playergamephase: Integer;
                    removemode: Boolean): cbc;
                    
function GetAIFilename(id:string) : string;

procedure GetFilesInDirectory(ADirectory : string; AMask : String; AList : TStrings; ARekursiv : Boolean);

var
aidllname, aidllname1, aidllname2: string; // AI DLL NAME

implementation
function GetAIFilename(id:string) : string;
var  ailist: TStrings;
     i: Integer;
begin
 ailist := TStringlist.Create;

 GetFilesInDirectory(ExtractFilePath(Application.ExeName)+'aifiles\', '*.dll', ailist, false);

for i := 0 to ailist.Count-1 do
begin
 aidllname := ailist.Strings[i];
 try
  if SSFGetAIInfo(8) = id then
  begin
   Result:= ailist.Strings[i];
   ailist.Free;
   Exit;
  end;
 except
 end; //ecept ende
end;

 Result := 'none';
 ailist.Free;
end;

//gibt ai info zurück
function SSFGetAIInfo (mode: Integer) : String;
 var SSF: TGetAIInfo; Handle: THandle;
begin
Handle:=Loadlibrary(PChar(aidllname));
 if Handle <> 0 then
  begin
   @SSF := GetProcAddress(Handle, 'GetAIInfo');
    if SSF(mode) <> nil then
    begin
      Result := String(SSF(mode));
    end;
  FreeLibrary(Handle);
 end;
end;

// gibt einen zug zurück
function SSFGetMove (fieldstatus: gitterstatus; mpr: Integer;
                    playergamephase: Integer;
                    removemode: Boolean): cbc;
var
 SSF: TGetMove;
 Handle: THandle;
 tmpstr: string;
 tmpcbc: cbc;
begin
//aidllname := 'D:\Development\Aktive Projekte\gt muehle\standard.dll';
Handle:=Loadlibrary(PChar(aidllname));
 if Handle <> 0 then
  begin
   @SSF := GetProcAddress(Handle, 'GetMove');
   // if SSF(fieldstatus, mpr, playergamephase, true, pos01, pos02) <> nil then
  //  begin
tmpcbc.cbc01 := '';
tmpcbc.cbc02 := '';
//SSF(fieldstatus, mpr, playergamephase, true);

tmpstr := string(SSF(ConvertABCtoArray(fieldstatus), mpr, playergamephase, removemode));

tmpcbc.cbc01 := copy(tmpstr, 1,2);
tmpcbc.cbc01 := ConvertArrayResultToABCResult(tmpcbc.cbc01);
tmpcbc.cbc02 := copy(tmpstr, 3,2);
tmpcbc.cbc02 := ConvertArrayResultToABCResult(tmpcbc.cbc02);
Result := tmpcbc;
  //  end;
  FreeLibrary(Handle);
 end;
end;

procedure GetFilesInDirectory(ADirectory : string; AMask : String; AList : TStrings; ARekursiv : Boolean);
var
 SR : TSearchRec;
begin
 if (ADirectory <> '') and (ADirectory[length(ADirectory)] <> '\') then
  begin ADirectory := ADirectory + '\' end;

 if (FindFirst(ADirectory + AMask, faAnyFile - faDirectory, SR) = 0) then
  begin
  repeat
   if (SR.Name <> '.') and (SR.Name <> '..') and (SR.Attr <> faDirectory) then
    begin AList.Add(ADirectory + SR.Name) end
  until FindNext(SR) <> 0;
  FindClose(SR);
  end;

 if ARekursiv then
  begin if (FindFirst(ADirectory + '*.*', faDirectory, SR) = 0) then
   begin
   repeat
    if (SR.Name <> '.') and (SR.Name <> '..') then
     begin GetFilesInDirectory(ADirectory + SR.Name, AMask, AList, True) end;
   until FindNext(SR) <> 0;
   FindClose(SR);
   end end;
end;

end.
