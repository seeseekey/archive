unit globals;

interface

uses Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
 Menus, ExtCtrls, StdCtrls, ComCtrls, ShellAPI, MPlayer, MMSystem, ShlObj,
 ActiveX, IdMessage;

var reload: boolean=false;
    reload2: boolean=false;
    reload3: boolean=false;
    folderglobal, sectionglobal, mailglobal: string;
    bearbeiten: boolean=false;
    bearbeitenges: boolean=false;
    listindex: Integer=0;
    dellistanhang: TStrings;
    kontoedit: boolean=false;
    sendmessage: boolean=false;
    smtpmessage: TIdMessage;
    swstatus: boolean = false; //Softwareschutz
    swswitch: boolean = false; //Softwareschutz

procedure GetFilesInDirectory(ADirectory : string; AMask : String; AList : TStrings; ARekursiv : Boolean);
function xorstring(const S, Key: string): string;
Function GetNodePath(ANode: TTreenode; ADelimiter: Char='|'): String;
function GetTimeString(mode: byte): string;
function MyGetFileSize(const FileName: String): Int64;
function GetFolder(const ARoot : integer; const ACaption : String) : String;
function DelDir(Dir : String) : Boolean;

implementation
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

// 20.02.2003/shmia
function xorstring(const S, Key: string): string;
var
  i, j: Integer;
  C: Byte;
  P: PByte;
begin
  SetLength(Result, Length(S));
  P := PByte(Result);

  j := 1;
  for i := 1 to Length(S) do
  begin
    C := Ord(S[i]);

    C := C xor Ord(Key[j]);
    P^ := C;
    Inc(P);
    Inc(j);
    if j > Length(Key) then
      j := 1;
  end;
end;

//Gibt den Pfad eines treenodes zurück
Function GetNodePath(ANode: TTreenode; ADelimiter: Char='|'): String;
Begin
Result := '';

while assigned(ANode) do 
begin
 Result := ADelimiter + aNode.Text + Result;
 ANode := ANode.Parent;
end;

if Result <> '' then
 Delete(Result,1,1);
End;

function GetTimeString(mode: byte): string;
var Present: TDateTime;
    Year, Month, Day, Hour, Min, Sec, MSec: Word;
begin
 Present:= Now;
 DecodeDate(Present, Year, Month, Day);
 DecodeTime(Present, Hour, Min, Sec, MSec);

 if mode = 1 then
 begin
  Result := IntToStr(Year) + IntToStr(Month) + IntToStr(Day) + IntToStr(Hour) +
            IntToStr(Min) + IntToStr(Sec) + IntToStr(MSec);
 end
 else if mode = 2 then
 begin
  //OPTI77
  DateTimeToString(Result, 'c',  Present);
 end;

end;

function MyGetFileSize(const FileName: String): Int64;
var
  hFile: THandle;
  Data: WIN32_FIND_DATA;
  Size: LARGE_INTEGER;
begin
  Result := -1;
  hFile := FindFirstFile(PChar(FileName), Data);
  try
    if hFile <> INVALID_HANDLE_VALUE then begin
      Size.LowPart := Data.nFileSizeLow;
      Size.HighPart := Data.nFileSizeHigh;
      Result := Size.QuadPart;
    end;
  finally
    Windows.FindClose(hFile);
  end;
end;

// Erstellt einen Verzeichnis auswählen Dialog
//Konstanten für System-Ordner
//CSIDL_Desktop  für "Desktop"
//CSIDL_Controls  für "Systemsteuerung",
//CSIDL_Printers  für "Drucker",
//CSIDL_Personal  für "Eigene Dateien",
//CSIDL_Drives  für "Arbeitsplatz",
//CSIDL_Network  für "Netzwerkumgebung".
//Weitere Konstanten stehen in der Unit ShlObj
function GetFolder(const ARoot : integer; const ACaption : String) : String;
var
 bi : TBROWSEINFO;
 lpBuffer : PChar;
 pidlPrograms,
 pidlBrowse : PItemIDList;
 ShellH : IMalloc;
begin
 if (not SUCCEEDED(SHGetSpecialFolderLocation(GetActiveWindow,
  ARoot,
  pidlPrograms))) then
  begin Exit end;
 try
  GetMem(lpBuffer, MAX_PATH);
  try
   bi.hwndOwner := GetActiveWindow;
   bi.pidlRoot := pidlPrograms;
   bi.pszDisplayName := lpBuffer;
   bi.lpszTitle := PChar(ACaption);
   bi.ulFlags := BIF_RETURNONLYFSDIRS;
   bi.lpfn := NIL;
   bi.lParam := 0;
   pidlBrowse := SHBrowseForFolder(bi);

   if (pidlBrowse <> nil) and (SHGetPathFromIDList(pidlBrowse,
    lpBuffer)) then
    begin Result := lpBuffer end;
  finally
   FreeMem(lpBuffer);
   end;
 finally
  if SHGetMalloc(ShellH) = NOERROR then
   begin ShellH.Free(pidlBrowse) end;
  end;
end;

function DelDir(Dir : String) : Boolean;
var
 FileOption : TSHFileOpStruct;
begin
 ZeroMemory(@FileOption,SizeOf(FileOption));
 with FileOption do
 begin
   wFunc := FO_DELETE;
   fFlags := FOF_SILENT or FOF_NOCONFIRMATION;
   pFrom := PChar(Dir + #0);
 end;
 Result := (ShFileOperation(FileOption) = 0);
end;

end.
