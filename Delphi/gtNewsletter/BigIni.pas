{ BigIni.PAS  v 4.51 - see bottom of file for details                        }
{ -------------------------------------------------------------------------- }
unit BigIni;

// activate the following line, if you never access lines longer than 255 chars:
{ $ DEFINE UseShortStrings}

{$IFDEF UseShortStrings}
{$H-}{using short strings in old pascal style increases speed}
{$ENDIF}

{$IFDEF VER140}{$DEFINE DELPHI6_UP}{$ENDIF D6}
{$IFDEF VER150}{$DEFINE DELPHI6_UP}{$ENDIF D7}
{$IFDEF VER160}{$DEFINE DELPHI6_UP}{$ENDIF}

interface


uses classes, Windows, ShellAPI, SysUtils, Forms, Graphics;

const
 IniTextBufferSize = $7000;
 {Note [1]: don't use more than $7FFF - it's an integer}

 cIniCount = 'Count';                 // count keyword
 cDefaultUsePrefixOnCount = false;             // see ReadNumberedList / WriteNumberedList
type
 TEraseSectionCallback = function(const sectionName : string; const sl1, sl2 : TStringList) : Boolean of object;

{
TCommaSeparatedInfo is a Tool-Class to read and write multiple parameters/values
from a single, comma-separated string. These parameters are positional.

Please see descendant TCSIFont for some useful example.
}
 TCommaSeparatedInfo = class
 private
  FValues : TStringList;
 public
  constructor Create;
  destructor Destroy; override;
  function GetValue : String;
  function GetElement(index : Integer) : String;
  function GetInteger(index : Integer) : Integer;
  function GetBoolean(index : Integer) : Boolean;
  function GetColor(index : Integer) : TColor;
  procedure SetValue(const Value : String);
  procedure SetBoolean(index : Integer; const Value : Boolean);
  procedure SetElement(index : Integer; const Value : String);
  procedure SetInteger(index : Integer; const Value : Integer);
  procedure SetColor(const Index : Integer; const Value : TColor);
  Property Value : String read GetValue write SetValue;
  Property Element[index : Integer] : String read GetElement write SetElement; default;
  Property AsInteger[index : Integer] : Integer read GetInteger write SetInteger;
  Property AsBoolean[index : Integer] : Boolean read GetBoolean write SetBoolean;
 end;

 TCSIFont = class(TCommaSeparatedInfo)
 private
  function GetFontStyle : TFontStyles;
  procedure SetFontStyle(const Value : TFontStyles);
 public
  Property FontName : String index 0 read GetElement write SetElement;
  Property FontSize : Integer index 1 read GetInteger write SetInteger;
  Property FontStyle : TFontStyles read GetFontStyle write SetFontStyle;
  Property FontColor : TColor index 6 read GetColor write SetColor;
  Property FontCharset : Integer index 7 read GetInteger write SetInteger;
  Property FontPitch : Integer index 8 read GetInteger write SetInteger;
 end;

 TCSIPoint = class(TCommaSeparatedInfo)
  function GetPoint : TPoint;
  procedure SetPoint(const Value : TPoint);
 public
  Property X : Integer index 0 read GetInteger write SetInteger;
  Property Y : Integer index 1 read GetInteger write SetInteger;
 end;

 TCSIRect = class(TCommaSeparatedInfo)
  function GetRect : TRect;
  procedure SetRect(const Value : TRect);
 public
  Property Left : Integer index 0 read GetInteger write SetInteger;
  Property Top : Integer index 1 read GetInteger write SetInteger;
  Property Right : Integer index 2 read GetInteger write SetInteger;
  Property Bottom : Integer index 3 read GetInteger write SetInteger;
 end;

{
TSectionList is a Tool-Class for TBigIniFile
It's a descendant of TStringList with "enhanced" IndexOf function (and others)
}
 TSectionList = class(TStringList)
 private
  FPrevIndex : Integer;
 public
  constructor Create;
  function EraseDuplicates(callBackProc : TEraseSectionCallback) : Boolean;
  function GetSectionItems(index : Integer) : TStringList;
  function IndexOf(const S : AnsiString) : Integer; override;
{$IFDEF DELPHI6_UP}// must be overridden in D6 ff
  function IndexOfName(const name : string) : Integer; override;
{$ELSE DELPHI6_UP}
  function IndexOfName(const name : string) : Integer; virtual;
{$ENDIF DELPHI6_UP}
  property SectionItems[index : Integer] : TStringList Read GetSectionItems;
 end;

 TBigIniFile = class(TObject)
 protected
  FHasChanged : Boolean;
  FTextBufferSize : Integer;
 private
  FEraseSectionCallback : TEraseSectionCallback;
  FFileName : string;
  FPrevSectionIndex : Integer;
  FFlagClearOnReadSectionValues,   {set true if clearing wanted}
  FFlagDropCommentLines,           {set false to keep lines starting with ';'}
  FFlagFilterOutInvalid,           {set false to keep lines without '='      }
  FFlagDropWhiteSpace,             {set false to keep white space around '='}
  FFlagDropApostrophes,            {set false to keep apostrophes around key }
  FFlagTrimRight : Boolean; {set false to keep white space at end of line}
  FSectionList : TSectionList;

  function FindItemIndex(const aSection, aKey : string; CreateNew : Boolean;
   var FoundStringList : TStringList) : Integer;
  procedure SetFileName(const aName : string);
  procedure ClearSectionList;
 public
  constructor Create(const FileName : string);
  destructor Destroy; override;

  procedure AppendFromFile(const aName : string); virtual;
  procedure Clear; virtual;
  procedure DeleteKey(const aSection, aKey : string); virtual;
  procedure EraseSection(const aSection : string); virtual;
  procedure GetStrings(List : TStrings); virtual;
  procedure SetStrings(const aStrings : TStrings); virtual;
  procedure FlushFile; virtual;
  function HasSection(const aSection : String) : Boolean; virtual;
  function ReadAnsiString(const aSection, aKey, aDefault : String) : AnsiString; virtual;
  procedure ReadAll(aStrings : TStrings); virtual;
  function ReadBool(const aSection, aKey : string; aDefault : Boolean) : Boolean; virtual;
  function ReadDate(const aSection, aKey : string; aDefault : TDateTime) : TDateTime; virtual;
  function ReadDateTime(const aSection, aKey : string; aDefault : TDateTime) : TDateTime; virtual;
  function ReadFloat(const aSection, aKey : string; aDefault : Double) : Double; virtual;
  function ReadInteger(const aSection, aKey : string; aDefault : Longint) : Longint; virtual;
  procedure ReadSection(const aSection : string; aStrings : TStrings); virtual;
  procedure ReadSections(aStrings : TStrings); virtual;
  procedure ReadSectionValues(const aSection : string; aStrings : TStrings); virtual;
  function ReadString(const aSection, aKey, aDefault : string) : string; virtual;
  function ReadTime(const aSection, aKey : string; aDefault : TDateTime) : TDateTime; virtual;
  function SectionExists(const aSection : String) : Boolean; virtual;
  procedure UpdateFile; virtual;
  function ValueExists(const aSection, aValue : string) : Boolean; virtual;
  procedure WriteAnsiString(const aSection, aKey, aValue : AnsiString); virtual;
  procedure WriteBool(const aSection, aKey : string; aValue : Boolean); virtual;
  procedure WriteDate(const aSection, aKey : string; aValue : TDateTime); virtual;
  procedure WriteDateTime(const aSection, aKey : string; aValue : TDateTime); virtual;
  procedure WriteFloat(const aSection, aKey : string; aValue : Double); virtual;
  procedure WriteInteger(const aSection, aKey : string; aValue : Longint); virtual;
  procedure WriteString(const aSection, aKey, aValue : string); virtual;
  procedure WriteTime(const aSection, aKey : string; aValue : TDateTime); virtual;

  property EraseSectionCallback : TEraseSectionCallback Read FEraseSectionCallback Write FEraseSectionCallback;
  property FlagClearOnReadSectionValues : Boolean Read FFlagClearOnReadSectionValues Write FFlagClearOnReadSectionValues;
  property FlagDropApostrophes : Boolean Read FFlagDropApostrophes Write FFlagDropApostrophes;
  property FlagDropCommentLines : Boolean Read FFlagDropCommentLines Write FFlagDropCommentLines;
  property FlagDropWhiteSpace : Boolean Read FFlagDropWhiteSpace Write FFlagDropWhiteSpace;
  property FlagFilterOutInvalid : Boolean Read FFlagFilterOutInvalid Write FFlagFilterOutInvalid;
  property FlagTrimRight : Boolean Read FFlagTrimRight Write FFlagTrimRight;
  property FileName : string Read FFileName Write SetFileName;
  property SectionNames : TSectionList Read FSectionList;
 end;

 TBiggerIniFile = class(TBigIniFile)
 private
 public
  procedure EraseNumberedList(const Section : string;
   aPrefix : String = '';
   IndexStart : Integer = 1;
   usePrefixOnCount : Boolean = cDefaultUsePrefixOnCount); virtual;
  procedure LaunchInEditor;
  function ReadBinaryData(const aSection, aKey : String; var Buffer; BufSize : Integer) : Integer; virtual;
  function ReadColor(const aSection,
   aKey : string;
   aDefault : TColor) : TColor; virtual;
  function ReadFont(const aSection, aKey : string; aDefault : TFont) : TFont; virtual;
  procedure ReadNumberedList(const Section : string;
   aStrings : TStrings;
   Deflt : string;
   aPrefix : String = '';
   IndexStart : Integer = 1;
   usePrefixOnCount : Boolean = cDefaultUsePrefixOnCount); virtual;
  function ReadPoint(const aSection, aKey : string; aDefault : TPoint) : TPoint;
  function ReadRect(const aSection, aKey : string; aDefault : TRect) : TRect;
  procedure RenameKey(const aSection, OldKey, NewKey : String); virtual;
  procedure RenameSection(const OldSection, NewSection : String); virtual;
  procedure WriteBinaryData(const aSection, aKey : String; var Buffer; BufSize : Integer); virtual;
  procedure WriteBoolDef(const aSection, aKey : string; aValue : Boolean; const aDefault : Boolean); virtual;
  procedure WriteColor(const aSection,
   aKey : string;
   aValue : TColor); virtual;
  procedure WriteFont(const aSection, aKey : string; aFont : TFont); virtual;
  procedure WriteNumberedList(const Section : string;
   aStrings : TStrings;
   aPrefix : String = '';
   IndexStart : Integer = 1;
   usePrefixOnCount : Boolean = cDefaultUsePrefixOnCount); virtual;
  procedure WritePoint(const aSection, aKey : string; aPoint : TPoint);
  procedure WriteRect(const aSection, aKey : string; aRect : TRect);
  procedure WriteSectionValues(const aSection : string; const aStrings : TStrings); virtual;

  property HasChanged : Boolean Read FHasChanged Write FHasChanged;
  property TextBufferSize : Integer Read FTextBufferSize Write FTextBufferSize;
 end;

 TAppIniFile = class(TBiggerIniFile)
  constructor Create;
  class function defaultFileName : String; virtual;
 end;

 TLibIniFile = class(TAppIniFile)
  class function defaultFileName : String; override;
 end;

function ModuleName(getLibraryName : Boolean) : String;

{ -------------------------------------------------------------------------- }
implementation
{ -------------------------------------------------------------------------- }

{........................................................................... }
{ classless functions/procedures                                             }
{........................................................................... }

{. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . }
{ function ModuleName
  purpose : get the full path of the current module
  - if flag getLibraryName is set (and the module is a library) then the library
    name is returned. Otherwise the application's name is returned.
  - the result is in proper mixed case (the similar function Application.ExeName
    returns all in uppercase chars)
 . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . }
function ModuleName(getLibraryName : Boolean) : String;
var
 Buffer : array[0..260] of Char;
 theHandle : THandle;
 thePath : String;
 theSearchRec : TSearchRec;
begin
 if getLibraryName then
  begin theHandle := HInstance end
 else
  begin theHandle := 0 end;
 SetString(Result, Buffer, GetModuleFileName(theHandle, Buffer, SizeOf(Buffer)));
 { GetModuleFileName returns a result in uppercase letters only }
 { The following FindFirst construct returns the mixed case name }
 thePath := ExtractFilePath(Result);
 if FindFirst(Result, faAnyFile, theSearchRec) = 0 then
  begin
  Result := thePath + theSearchRec.name;
  end;
 FindClose(theSearchRec);
end;

// . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
// Needed no more. Left here for backward compatibility
function max(a, b : Integer) : Integer;
begin
 if a > b then
  begin Result := a end
 else
  begin Result := b end;
end;

//------------------------------------------------------------------------------
// check if two StringLists contain identical strings
//------------------------------------------------------------------------------
function ListIdentical(l1, l2 : TStringList) : Boolean;
var
 ix : Integer;
begin
 Result := False;
 if l1.count = l2.count then
  begin
  for ix := 0 to l1.count - 1 do
   begin
   if (l1[ix] <> l2[ix]) then
    begin Exit end;
   end;
  Result := True;
  end;
end;

{........................................................................... }
{ class TCommaSeparatedInfo                                                  }
{........................................................................... }

constructor TCommaSeparatedInfo.Create;
begin
 FValues := TStringList.Create;
end;

destructor TCommaSeparatedInfo.Destroy;
begin
 FValues.Free;
 inherited;
end;

function TCommaSeparatedInfo.GetBoolean(index : Integer) : Boolean;
begin
 // '1' stands for 'true', any other value for 'false'
 Result := (Element[index] = '1');
end;

function TCommaSeparatedInfo.GetColor(index : Integer) : TColor;
begin
 Result := StrToIntDef('$' + Element[index], -1);
 if result = -1 then
  begin
  try
   Result := StringToColor(Element[index]);
  except
   result := clBlack;
   end;
  end;
end;

function TCommaSeparatedInfo.GetElement(index : Integer) : String;
begin
 result := FValues[index];
end;

function TCommaSeparatedInfo.GetInteger(index : Integer) : Integer;
begin
 Result := StrToIntDef(Element[index], -1);
end;

function TCommaSeparatedInfo.GetValue : String;
begin
 result := FValues.CommaText;
end;

procedure TCommaSeparatedInfo.SetBoolean(index : Integer;
 const Value : Boolean);
const
 BoolText: array[Boolean] of string[1] = ('', '1');
begin
 SetElement(index, BoolText[Value]);
end;

procedure TCommaSeparatedInfo.SetElement(index : Integer;
 const Value : String);
begin
 while (FValues.Count - 1) < Index do
  begin FValues.Add('') end;
 FValues[index] := Value;
end;

procedure TCommaSeparatedInfo.SetInteger(index : Integer;
 const Value : Integer);
begin
 SetElement(index, IntToStr(Value));
end;

procedure TCommaSeparatedInfo.SetValue(const Value : String);
begin
 FValues.CommaText := Value;
end;

procedure TCommaSeparatedInfo.SetColor(const Index : Integer; const Value : TColor);
begin
 Element[index] := ColorToString(Value);
end;

{........................................................................... }
{ class TCSIFont                                                             }
{........................................................................... }

function TCSIFont.GetFontStyle : TFontStyles;
begin
 result := [];
 if AsBoolean[2] then
  begin result := result + [fsBold] end;
 if AsBoolean[3] then
  begin result := result + [fsItalic] end;
 if AsBoolean[4] then
  begin result := result + [fsUnderline] end;
 if AsBoolean[5] then
  begin result := result + [fsStrikeOut] end;
end;

procedure TCSIFont.SetFontStyle(const Value : TFontStyles);
begin
 AsBoolean[2] := fsBold in Value;
 AsBoolean[3] := fsItalic in Value;
 AsBoolean[4] := fsUnderline in Value;
 AsBoolean[5] := fsStrikeOut in Value;
end;

{........................................................................... }
{ TCSIPoint }
{........................................................................... }

function TCSIPoint.GetPoint : TPoint;
begin
 result := Point(X, Y);
end;

procedure TCSIPoint.SetPoint(const Value : TPoint);
begin
 AsInteger[0] := value.X;
 AsInteger[1] := value.Y;
end;

{........................................................................... }
{ TCSIRect }
{........................................................................... }

function TCSIRect.GetRect : TRect;
begin
 result := Rect(Left, Top, Right, Bottom);
end;

procedure TCSIRect.SetRect(const Value : TRect);
begin
 AsInteger[0] := value.Left;
 AsInteger[1] := value.Top;
 AsInteger[2] := value.Right;
 AsInteger[3] := value.Bottom;
end;

{........................................................................... }
{ class TSectionList                                                         }
{........................................................................... }

{. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . }
{ create new instance                                                        }
{. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . }
constructor TSectionList.Create;
begin
 inherited Create;
 FPrevIndex := 0;
end;
{. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . }
{ access to property SectionItems                                            }
{. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . }
function TSectionList.GetSectionItems(index : Integer) : TStringList;
begin
 Result := TStringList(Objects[index]);
end;
{. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . }
{ erase duplicate entries                                                    }
{ results TRUE if changes were made                                          }
{. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . }
function TSectionList.EraseDuplicates(callBackProc : TEraseSectionCallback) : Boolean;
var
 slDuplicateTracking : TStringList;
 idxToDelete,
 ixLow,
 ixHigh,
 ix : Integer;

 { swap two integer variables }
 procedure SwapInt(var a, b : Integer);
 var
  c : Integer;
 begin
  c := a;
  a := b;
  b := c;
 end;
begin
 Result := False; { no changes made yet }

 if count > 1 then
  begin
  slDuplicateTracking := TStringList.Create;
  slDuplicateTracking.Assign(Self);
  { store current position in the objects field: }
  for ix := 0 to slDuplicateTracking.count - 1 do
   begin slDuplicateTracking.Objects[ix] := Pointer(ix) end;
  { sort the list to find out duplicates }
  slDuplicateTracking.Sort;
  ixLow := 0;
  for ix := 1 to slDuplicateTracking.count - 1 do
   begin
   if (AnsiCompareText(slDuplicateTracking.STRINGS[ixLow],
    slDuplicateTracking.STRINGS[ix]) <> 0) then
    begin
    ixLow := ix;
    end
   else
    begin
    ixHigh := ix;
    { find the previous entry (with lower integer number) }
    if Integer(slDuplicateTracking.Objects[ixLow]) >
     Integer(slDuplicateTracking.Objects[ixHigh]) then
     begin SwapInt(ixHigh, ixLow) end;

    if Assigned(callBackProc) then
     begin
          { ask callback/user wether to delete the higher (=true)
            or the lower one (=false)}
     if NOT callBackProc(slDuplicateTracking.STRINGS[ix],
      SectionItems[Integer(slDuplicateTracking.Objects[ixLow])],
      SectionItems[Integer(slDuplicateTracking.Objects[ixHigh])])
     then
      begin SwapInt(ixHigh, ixLow) end;
     end;
    idxToDelete := Integer(slDuplicateTracking.Objects[ixHigh]);

    { free associated object and mark it as unassigned }
    SectionItems[idxToDelete].Free;
    Objects[idxToDelete] := nil;
    Result := True; { list had been changed }
    end {if};
   end {for};

  ix := 0;
  while ix < count do
   begin
   if Objects[ix] = nil then
    begin Delete(ix) end
   else
    begin Inc(ix) end;
   end;
  slDuplicateTracking.Free;
  end {if};

end;
{. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . }
{ search string                                                              }
{. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . }
function TSectionList.IndexOf(const S : AnsiString) : Integer;
var
 ix,
 LastIX : Integer;
  { This routine doesn't search from the first item each time,
    but from the last successful item. It is likely that the
    next item is to be found downward. }
begin
 Result := -1;
 if count = 0 then
  begin Exit end;

 LastIX := FPrevIndex;
 { Search from last successful point to the end: }
 for ix := LastIX to count - 1 do
  begin
  if (AnsiCompareText(Get(ix), S) = 0) then
   begin
   Result := ix;
   FPrevIndex := ix;
   Exit;
   end;
  end;
 { Not found yet? Search from beginning to last successful point: }
 for ix := 0 to LastIX - 1 do
  begin
  if (AnsiCompareText(Get(ix), S) = 0) then
   begin
   Result := ix;
   FPrevIndex := ix;
   Exit;
   end;
  end;
end;

{. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . }

function TSectionList.IndexOfName(const name : string) : Integer;
var
 P : Integer;
 s1,
 s2 : AnsiString;
begin
 s2 := name;
 for Result := 0 to GetCount - 1 do
  begin
  s1 := Get(Result);
  P  := AnsiPos('=', s1);
  SetLength(s1, P - 1);
  if (P <> 0) AND (
   CompareString(LOCALE_USER_DEFAULT, NORM_IGNORECASE,
   PChar(s1), -1,
   PChar(s2), -1)
   = 2) then
   begin Exit end;
  end;
 Result := -1;
end;

{........................................................................... }
{ class TBigIniFile                                                          }
{........................................................................... }

{. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . }
{ create new instance                                                        }
{. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . }
constructor TBigIniFile.Create(const FileName : string);
begin
 FSectionList := TSectionList.Create;
 FTextBufferSize := IniTextBufferSize;   { you may set to zero to switch off }
 FFlagDropCommentLines := False;         { change this aDefaults if needed }
 FFlagFilterOutInvalid := False;
 FFlagDropWhiteSpace := False;
 FFlagDropApostrophes := False;
 FFlagTrimRight := False;
 FFlagClearOnReadSectionValues := False;
 FFileName := '';
 FPrevSectionIndex := 0;
 FEraseSectionCallback := nil;
 SetFileName(FileName);
end;
{. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . }
{ destructor                                                                 }
{. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . }
destructor TBigIniFile.Destroy;
begin
 FlushFile;
 ClearSectionList;
 FSectionList.Free;
 inherited Destroy;
end;
{. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . }
{ clean up                                                                   }
{. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . }
procedure TBigIniFile.ClearSectionList;
var
 ixSections : Integer;
begin
 with FSectionList do
  begin
  for ixSections := 0 to count - 1 do
   begin
   SectionItems[ixSections].Free;
   end;
  Clear;
  FPrevIndex := 0;
  end;
end;
{. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . }
{ Erases all data from the INI file                                          }
{. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . }
procedure TBigIniFile.Clear;
begin
 ClearSectionList;
end;
{. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . }
{ Append from File                                                           }
{. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . }
procedure TBigIniFile.AppendFromFile(const aName : string);
var
 CurrStringList : TStringList;
 CurrSectionName : string;
 lpTextBuffer : Pointer;
 Source : TextFile;
 OneLine : string;
 LL : Integer;
 LastPos,
 EqPos : Integer;
 nospace : Boolean;
begin
 CurrStringList := nil;
 lpTextBuffer := nil; {only to avoid compiler warnings}
 FPrevSectionIndex := 0;
 if FileExists(aName) then
  begin
  Assign(Source, aName);
  if FTextBufferSize > 0 then
   begin
   GetMem(lpTextBuffer, FTextBufferSize);
   SetTextBuf(Source, lpTextBuffer^, FTextBufferSize);
   end;
  Reset(Source);
  while NOT Eof(Source) do
   begin
   ReadLn(Source, OneLine);
   if OneLine = #$1A {EOF} then
    begin OneLine := '' end;
   { drop lines with leading ';' : }
   if FFlagDropCommentLines then
    begin if (OneLine <> '') then
     begin if (OneLine[1] = ';') then
      begin OneLine := '' end end end;
   { drop lines without '=' }
   if OneLine <> '' then
    begin
    LL := Length(OneLine);
    if (OneLine[1] = '[') AND (OneLine[LL] = ']') then
     begin
     CurrSectionName := Copy(OneLine, 2, LL - 2);
     CurrStringList  := TStringList.Create;
     FSectionList.AddObject(CurrSectionName, CurrStringList);
     end
    else
     begin
     if FFlagDropWhiteSpace then
      begin
      nospace := False;
      repeat
       { delete white space left to equal sign }
       EqPos := AnsiPos('=', OneLine);
       if EqPos > 1 then
        begin
        if OneLine[EqPos - 1] IN [' ', #9] then
         begin Delete(OneLine, EqPos - 1, 1) end
        else
         begin nospace := True end;
        end
       else
        begin nospace := True end;
      until nospace;
      nospace := False;
      EqPos := AnsiPos('=', OneLine);
      if EqPos > 1 then
       begin
       repeat
        { delete white space right to equal sign }
        if EqPos < Length(OneLine) then
         begin
         if OneLine[EqPos + 1] IN [' ', #9] then
          begin Delete(OneLine, EqPos + 1, 1) end
         else
          begin nospace := True end;
         end
        else
         begin nospace := True end;
       until nospace;
       end;
      end; {FFlagDropWhiteSpace}
     if FFlagDropApostrophes then
      begin
      EqPos := AnsiPos('=', OneLine);
      if EqPos > 1 then
       begin
       LL := Length(OneLine);
       { filter out the apostrophes }
       if EqPos < LL - 1 then
        begin
        if (OneLine[EqPos + 1] = OneLine[LL]) AND (OneLine[LL] IN ['"', #39]) then
         begin
         Delete(OneLine, LL, 1);
         Delete(OneLine, EqPos + 1, 1);
         end;
        end;
       end;
      end; {FFlagDropApostrophes}
     if FFlagTrimRight then
      begin
      LastPos := Length(OneLine);
      while ((LastPos > 0) AND (OneLine[LastPos] < #33)) do
       begin Dec(LastPos) end;
      OneLine := Copy(OneLine, 1, LastPos);
      end; {FFlagTrimRight}
     if (NOT FFlagFilterOutInvalid) OR (AnsiPos('=', OneLine) > 0) then
      begin
      if Assigned(CurrStringList) then
       begin CurrStringList.Add(OneLine) end;
      end;
     end;
    end;
   end;

  if FSectionList.EraseDuplicates(FEraseSectionCallback) then
   begin FHasChanged := True end;

  Close(Source);
  if FTextBufferSize > 0 then
   begin
   FreeMem(lpTextBuffer, FTextBufferSize);
   end;
  end;
end;
{. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . }
{ Set or change FileName                                                     }
{. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . }
procedure TBigIniFile.SetFileName(const aName : string);
begin
 FlushFile;
 ClearSectionList;
 FFileName := aName;
 if aName <> '' then
  begin AppendFromFile(aName) end;
 FHasChanged := False;
end;

{. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . }
{ find item in specified section                                             }
{ depending on CreateNew-flag, the section is created, if not existing       }
{. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . }
function TBigIniFile.FindItemIndex(const aSection, aKey : string; CreateNew : Boolean;
 var FoundStringList : TStringList) : Integer;
var
 SectionIndex : Integer;
 LastIX : Integer;
begin
 SectionIndex := -1;

 if FSectionList.count > 0 then
  begin
  LastIX := FPrevSectionIndex - 1;
  if LastIX < 0 then
   begin LastIX := FSectionList.count - 1 end;
  while (AnsiCompareText(aSection, FSectionList[FPrevSectionIndex]) <> 0)
   AND (FPrevSectionIndex <> LastIX) do
   begin
   Inc(FPrevSectionIndex);
   if FPrevSectionIndex = FSectionList.count then
    begin FPrevSectionIndex := 0 end;
   end;
  if AnsiCompareText(aSection, FSectionList[FPrevSectionIndex]) = 0 then
   begin
   SectionIndex := FPrevSectionIndex;
   end;
  end;

 if SectionIndex = -1 then
  begin
  if CreateNew then
   begin
   FoundStringList := TStringList.Create;
   FPrevSectionIndex := FSectionList.AddObject(aSection, FoundStringList);
   end
  else
   begin
   FoundStringList := nil;
   end;
  Result := -1;
  end
 else
  begin
  FoundStringList := FSectionList.SectionItems[SectionIndex];
  Result := FoundStringList.IndexOfName(aKey);
  end;
end;
{. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . }
{ the basic function: return single string                                   }
{. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . }
function TBigIniFile.ReadString(const aSection, aKey, aDefault : string) : string;
var
 ItemIndex : Integer;
 CurrStringList : TStringList;
begin
 ItemIndex := FindItemIndex(aSection, aKey, False, CurrStringList);
 if ItemIndex = -1 then
  begin
  Result := aDefault
  end
 else
  begin
  Result := Copy(CurrStringList[ItemIndex], Length(aKey) + 2, MaxInt);
  end;
end;
{. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . }
{ same as ReadString, but returns AnsiString type                            }
{. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . }
function TBigIniFile.ReadAnsiString(const aSection, aKey, aDefault : String) : AnsiString;
var
 ItemIndex : Integer;
 CurrStringList : TStringList;
begin
 ItemIndex := FindItemIndex(aSection, aKey, False, CurrStringList);
 if ItemIndex = -1 then
  begin
  Result := aDefault
  end
 else
  begin
  Result := CurrStringList.Values[aKey];
  end;
end;
{. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . }
{ here is the one to write the string                                        }
{. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . }
procedure TBigIniFile.WriteString(const aSection, aKey, aValue : string);
var
 ItemIndex : Integer;
 CurrStringList : TStringList;
 newLine : string;
begin
 if aKey = '' then
  begin
    {behaviour of WritePrivateProfileString: if all parameters are null strings,
     the file is flushed to disk. Otherwise, if key name is a null string,
     the entire Section is to be deleted}
  if (aSection = '') AND (aValue = '') then
   begin FlushFile end
  else
   begin EraseSection(aSection) end;
  end
 else
  begin
  newLine := aKey + '=' + aValue;
  ItemIndex := FindItemIndex(aSection, aKey, True, CurrStringList);
  if ItemIndex = -1 then
   begin
   CurrStringList.Add(newLine);
   FHasChanged := True;
   end
  else
   begin
   if (CurrStringList[ItemIndex] <> newLine) then
    begin
    FHasChanged := True;
    CurrStringList[ItemIndex] := newLine;
    end;
   end;
  end;
end;
{. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . }
{ Same as writestring, but processes AnsiString type                         }
{. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . }
procedure TBigIniFile.WriteAnsiString(const aSection, aKey, aValue : AnsiString);
var
 ItemIndex : Integer;
 CurrStringList : TStringList;
 newLine : AnsiString;
begin
 if aKey = '' then
  begin
    {behaviour of WritePrivateProfileString: if all parameters are null strings,
     the file is flushed to disk. Otherwise, if key name is a null string,
     the entire Section is to be deleted}
  if (aSection = '') AND (aValue = '') then
   begin FlushFile end
  else
   begin EraseSection(aSection) end;
  end
 else
  begin
  newLine := aKey + '=' + aValue;
  ItemIndex := FindItemIndex(aSection, aKey, True, CurrStringList);
  if ItemIndex = -1 then
   begin
   CurrStringList.Add(newLine);
   FHasChanged := True;
   end
  else
   begin
   if (CurrStringList[ItemIndex] <> newLine) then
    begin
    FHasChanged := True;
    CurrStringList[ItemIndex] := newLine;
    end;
   end;
  end;
end;
{. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . }
{ read integer value                                                         }
{. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . }
function TBigIniFile.ReadInteger(const aSection, aKey : string;
 aDefault : Longint) : Longint;
var
 IStr : string;
begin
 IStr := ReadString(aSection, aKey, '');
 if CompareText(Copy(IStr, 1, 2), '0x') = 0 then
  begin IStr := '$' + Copy(IStr, 3, 255) end;
 Result := StrToIntDef(IStr, aDefault);
end;
{. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . }
{ Yes, you guessed right: this procedure writes an integer value             }
{. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . }
procedure TBigIniFile.WriteInteger(const aSection, aKey : string; aValue : Longint);
begin
 WriteString(aSection, aKey, IntToStr(aValue));
end;
{. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . }
{ read boolean value                                                         }
{. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . }
function TBigIniFile.ReadBool(const aSection, aKey : string;
 aDefault : Boolean) : Boolean;
begin
 Result := ReadInteger(aSection, aKey, Ord(aDefault)) <> 0;
end;
{. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . }
{ write boolean value                                                        }
{. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . }
procedure TBigIniFile.WriteBool(const aSection, aKey : string; aValue : Boolean);
const
 BoolText: array[Boolean] of string[1] = ('0', '1');
begin
 WriteString(aSection, aKey, BoolText[aValue]);
end;
{. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . }
{ read date value                                                            }
{. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . }
function TBigIniFile.ReadDate(const aSection, aKey : string; aDefault : TDateTime) : TDateTime;
var
 DateStr : string;
begin
 DateStr := ReadString(aSection, aKey, '');
 Result  := aDefault;
 if DateStr <> '' then
  begin try
   Result := StrToDate(DateStr);
  except
   on EConvertError do
   else raise;
   end end;
end;
{. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . }
{ write date value                                                           }
{. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . }
procedure TBigIniFile.WriteDate(const aSection, aKey : string; aValue : TDateTime);
begin
 WriteString(aSection, aKey, DateToStr(aValue));
end;
{. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . }
{ read DateTime value                                                        }
{. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . }
function TBigIniFile.ReadDateTime(const aSection, aKey : string; aDefault : TDateTime) : TDateTime;
var
 DateStr : string;
begin
 DateStr := ReadString(aSection, aKey, '');
 Result  := aDefault;
 if DateStr <> '' then
  begin try
   Result := StrToDateTime(DateStr);
  except
   on EConvertError do
   else raise;
   end end;
end;
{. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . }
{ write DateTime value                                                       }
{. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . }
procedure TBigIniFile.WriteDateTime(const aSection, aKey : string; aValue : TDateTime);
begin
 WriteString(aSection, aKey, DateTimeToStr(aValue));
end;
{. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . }
{ read Float value                                                           }
{. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . }
function TBigIniFile.ReadFloat(const aSection, aKey : string; aDefault : Double) : Double;
var
 FloatStr : string;
begin
 FloatStr := ReadString(aSection, aKey, '');
 Result := aDefault;
 if FloatStr <> '' then
  begin try
   Result := StrToFloat(FloatStr);
  except
   on EConvertError do
   else raise;
   end end;
end;
{. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . }
{ write Float value                                                          }
{. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . }
procedure TBigIniFile.WriteFloat(const aSection, aKey : string; aValue : Double);
begin
 WriteString(aSection, aKey, FloatToStr(aValue));
end;
{. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . }
{ read Time value                                                            }
{. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . }
function TBigIniFile.ReadTime(const aSection, aKey : string; aDefault : TDateTime) : TDateTime;
var
 TimeStr : string;
begin
 TimeStr := ReadString(aSection, aKey, '');
 Result  := aDefault;
 if TimeStr <> '' then
  begin try
   Result := StrToTime(TimeStr);
  except
   on EConvertError do
   else raise;
   end end;
end;
{. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . }
{ write Time value                                                           }
{. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . }
procedure TBigIniFile.WriteTime(const aSection, aKey : string; aValue : TDateTime);
begin
 WriteString(aSection, aKey, TimeToStr(aValue));
end;
{. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . }
{ read entire section (hoho, only the item names)                            }
{. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . }
procedure TBigIniFile.ReadSection(const aSection : string; aStrings : TStrings);
var
 SectionIndex : Integer;
 CurrStringList : TStringList;
 ix : Integer;
begin
 SectionIndex := FSectionList.IndexOf(aSection);
 if SectionIndex <> -1 then
  begin
  aStrings.BeginUpdate;
  CurrStringList := FSectionList.SectionItems[SectionIndex];
  for ix := 0 to CurrStringList.count - 1 do
   begin
   if CurrStringList.Names[IX] = '' then
    begin continue end;
   if FFlagDropCommentLines and (CurrStringList.Names[IX][1] = ';') then
    begin continue end;
   aStrings.Add(CurrStringList.Names[ix]);
   end;
  aStrings.EndUpdate;
  end;
end;
{. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . }
{ copy all section names to TStrings object                                  }
{. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . }
procedure TBigIniFile.ReadSections(aStrings : TStrings);
begin
 aStrings.Assign(SectionNames);
end;
{. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . }
{ read entire section                                                        }
{. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . }
procedure TBigIniFile.ReadSectionValues(const aSection : string; aStrings : TStrings);
var
 SectionIndex : Integer;
begin
 SectionIndex := FSectionList.IndexOf(aSection);
 if SectionIndex <> -1 then
  begin
  aStrings.BeginUpdate;
    {In prior versions of TIniFile the target-Strings were _not_ cleared
    That's why my procedure didn't either. Meanwhile, Borland changed their
    mind and I added the following line for D5 compatibility.
    Use FFlagClearOnReadSectionValues if needed}
  if FFlagClearOnReadSectionValues then
   begin aStrings.Clear end; // new since 3.09,3.10
  aStrings.AddStrings(FSectionList.SectionItems[SectionIndex]);
  aStrings.EndUpdate;
  end;
end;
{. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . }
{ copy all 'lines' to TStrings-object                                        }
{ Note [2]: under Delphi 1, GetStrings may cause errors when a TMemo.Lines   }
{      array is destination and source is greater than 64 KB                 }
{. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . }
procedure TBigIniFile.GetStrings(List : TStrings);
var
 ixSections : Integer;
 CurrStringList : TStringList;
begin
 List.BeginUpdate;
 with FSectionList do
  begin
  for ixSections := 0 to count - 1 do
   begin
   CurrStringList := SectionItems[ixSections];
   if CurrStringList.count > 0 then
    begin
    List.Add('[' + STRINGS[ixSections] + ']');
    List.AddStrings(CurrStringList);
    List.Add('');
    end;
   end;
  end;
 List.EndUpdate;
end;

{. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . }
{ Deprecated. For backward compatibility only. Use GetStrings                }
{. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . }
procedure TBigIniFile.ReadAll(aStrings : TStrings);
begin
 GetStrings(aStrings);
end;
{. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . }
{ Gets data from TStrings Object                                             }
{. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . }
procedure TBigIniFile.SetStrings(const aStrings : TStrings);
var
 CurrStringList : TStringList;
 CurrSectionName : string;
 OneLine : string;
 LL : Integer;
 LastPos,
 EqPos : Integer;
 nospace : Boolean;
 ix : Integer;
begin
 CurrStringList := nil;
 FPrevSectionIndex := 0;
 for ix := 0 to aStrings.Count - 1 do
  begin
  OneLine := aStrings.Strings[ix];
  { drop lines with leading ';' : }
  if FFlagDropCommentLines then
   begin if (OneLine <> '') then
    begin if (OneLine[1] = ';') then
     begin OneLine := '' end end end;
  { drop lines without '=' }
  if OneLine <> '' then
   begin
   LL := Length(OneLine);
   if (OneLine[1] = '[') AND (OneLine[LL] = ']') then
    begin
    CurrSectionName := Copy(OneLine, 2, LL - 2);
    CurrStringList  := TStringList.Create;
    FSectionList.AddObject(CurrSectionName, CurrStringList);
    end
   else
    begin
    if FFlagDropWhiteSpace then
     begin
     nospace := False;
     repeat
      { delete white space left to equal sign }
      EqPos := AnsiPos('=', OneLine);
      if EqPos > 1 then
       begin
       if OneLine[EqPos - 1] IN [' ', #9] then
        begin Delete(OneLine, EqPos - 1, 1) end
       else
        begin nospace := True end;
       end
      else
       begin nospace := True end;
     until nospace;
     nospace := False;
     EqPos := AnsiPos('=', OneLine);
     if EqPos > 1 then
      begin
      repeat
       { delete white space right to equal sign }
       if EqPos < Length(OneLine) then
        begin
        if OneLine[EqPos + 1] IN [' ', #9] then
         begin Delete(OneLine, EqPos + 1, 1) end
        else
         begin nospace := True end;
        end
       else
        begin nospace := True end;
      until nospace;
      end;
     end; {FFlagDropWhiteSpace}
    if FFlagDropApostrophes then
     begin
     EqPos := AnsiPos('=', OneLine);
     if EqPos > 1 then
      begin
      LL := Length(OneLine);
      { filter out the apostrophes }
      if EqPos < LL - 1 then
       begin
       if (OneLine[EqPos + 1] = OneLine[LL]) AND (OneLine[LL] IN ['"', #39]) then
        begin
        Delete(OneLine, LL, 1);
        Delete(OneLine, EqPos + 1, 1);
        end;
       end;
      end;
     end; {FFlagDropApostrophes}
    if FFlagTrimRight then
     begin
     LastPos := Length(OneLine);
     while ((LastPos > 0) AND (OneLine[LastPos] < #33)) do
      begin Dec(LastPos) end;
     OneLine := Copy(OneLine, 1, LastPos);
     end; {FFlagTrimRight}
    if (NOT FFlagFilterOutInvalid) OR (AnsiPos('=', OneLine) > 0) then
     begin
     if Assigned(CurrStringList) then
      begin CurrStringList.Add(OneLine) end;
     end;
    end;
   end;
  end;
 if FSectionList.EraseDuplicates(FEraseSectionCallback) then
  begin FHasChanged := True end;
end;
{. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . }
{ flush (save) data to disk                                                  }
{. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . }
procedure TBigIniFile.FlushFile;
var
 CurrStringList : TStringList;
 lpTextBuffer : Pointer;
 Destin : TextFile;
 ix,
 ixSections : Integer;
begin
 lpTextBuffer := nil; {only to avoid compiler warnings}
 if FHasChanged then
  begin
  if FFileName <> '' then
   begin
   Assign(Destin, FFileName);
   if FTextBufferSize > 0 then
    begin
    GetMem(lpTextBuffer, FTextBufferSize);
    SetTextBuf(Destin, lpTextBuffer^, FTextBufferSize);
    end;
   Rewrite(Destin);

   with FSectionList do
    begin
    for ixSections := 0 to count - 1 do
     begin
     CurrStringList := SectionItems[ixSections];
     if CurrStringList.count > 0 then
      begin
      WriteLn(Destin, '[', STRINGS[ixSections], ']');
      for ix := 0 to CurrStringList.count - 1 do
       begin
       WriteLn(Destin, CurrStringList[ix]);
       end;
      WriteLn(Destin);
      end;
     end;
    end;

   Close(Destin);
   if FTextBufferSize > 0 then
    begin
    FreeMem(lpTextBuffer, FTextBufferSize);
    end;
   end;
  FHasChanged := False;
  end;
end;
{. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . }
{ Flushes buffered INI file data to disk                                     }
{. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . }
procedure TBigIniFile.UpdateFile;
begin
 FlushFile;
end;
{. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . }
{ erase specified section                                                    }
{. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . }
procedure TBigIniFile.EraseSection(const aSection : string);
var
 SectionIndex : Integer;
begin
 SectionIndex := FSectionList.IndexOf(aSection);
 if SectionIndex <> -1 then
  begin
  FSectionList.SectionItems[SectionIndex].Free;
  FSectionList.Delete(SectionIndex);
  FSectionList.FPrevIndex := 0;
  FHasChanged := True;
  if FPrevSectionIndex >= FSectionList.count then
   begin FPrevSectionIndex := 0 end;
  end;
end;

{. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . }
{ remove a single key                                                        }
{. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . }
procedure TBigIniFile.DeleteKey(const aSection, aKey : string);
var
 ItemIndex : Integer;
 CurrStringList : TStringList;
begin
 ItemIndex := FindItemIndex(aSection, aKey, True, CurrStringList);
 if ItemIndex > -1 then
  begin
  FHasChanged := True;
  CurrStringList.Delete(ItemIndex);
  end;
end;

{. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . }
{ check for existance of a section                                           }
{. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . }
function TBigIniFile.HasSection(const aSection : String) : Boolean;
begin
 Result := (FSectionList.IndexOf(aSection) > -1)
end;

{. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . }
{ Indicates whether a section exists                                         }
{. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . }
function TBigIniFile.SectionExists(const aSection : String) : Boolean;
begin
 Result := HasSection(aSection);
end;

{. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . }
{ Indicates whether a key exists                                             }
{. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . }
function TBigIniFile.ValueExists(const aSection, aValue : string) : Boolean;
var
 S : TStringList;
begin
 S := TStringList.Create;
 try
  ReadSection(aSection, S);
  Result := S.IndexOf(aValue) > -1;
 finally
  S.Free;
  end;
end;

{........................................................................... }
{ class TBiggerIniFile                                                       }
{........................................................................... }

{. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . }
{ write/replace complete section                                             }
{. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . }
procedure TBiggerIniFile.WriteSectionValues(const aSection : string; const aStrings : TStrings);
var
 SectionIndex : Integer;
 FoundStringList : TStringList;
 ix : Integer;
begin
 SectionIndex := FSectionList.IndexOf(aSection);
 if SectionIndex = -1 then
  begin
  { create new section }
  FoundStringList := TStringList.Create;
  FSectionList.AddObject(aSection, FoundStringList);
  FoundStringList.AddStrings(aStrings);
  FHasChanged := True;
  end
 else
  begin
  { compare existing section }
  FoundStringList := FSectionList.SectionItems[SectionIndex];
  if FoundStringList.count <> aStrings.count then
   begin
   { if count differs, replace complete section }
   FoundStringList.Clear;
   FoundStringList.AddStrings(aStrings);
   FHasChanged := True;
   end
  else
   begin
   { compare line by line }
   for ix := 0 to FoundStringList.count - 1 do
    begin
    if FoundStringList[ix] <> aStrings[ix] then
     begin
     FoundStringList[ix] := aStrings[ix];
     FHasChanged := True;
     end;
    end;
   end;
  end;
end;

{. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . }
{ read a numbered list                                                       }
{. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . }
procedure TBiggerIniFile.ReadNumberedList(const Section : string;
 aStrings : TStrings;
 Deflt : string;
 aPrefix : String = '';
 IndexStart : Integer = 1;
 usePrefixOnCount : Boolean = cDefaultUsePrefixOnCount);
var
 maxEntries : Integer;
 ix : Integer;
 countKey : String;
begin
 if usePrefixOnCount then
  begin countKey := aPrefix + cIniCount end
 else
  begin countKey := cIniCount end;
 maxEntries := ReadInteger(Section, countKey, 0);
 aStrings.BeginUpdate;
 for ix := 0 to maxEntries - 1 do
  begin
  aStrings.Add(ReadString(Section, aPrefix + IntToStr(ix + IndexStart), Deflt));
  end;
 aStrings.EndUpdate;
end;

{. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . }
{ write a numbered list (TStrings contents)                                  }
{. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . }
procedure TBiggerIniFile.WriteNumberedList(const Section : string;
 aStrings : TStrings;
 aPrefix : String = '';
 IndexStart : Integer = 1;
 usePrefixOnCount : Boolean = cDefaultUsePrefixOnCount);
var
 prevCount,
 ix : Integer;
 prevHasChanged : Boolean;
 oldSectionValues,
 newSectionValues : TStringList;
 countKey : String;
begin
 oldSectionValues := TStringList.Create;
 newSectionValues := TStringList.Create;

 if usePrefixOnCount then
  begin countKey := aPrefix + cIniCount end
 else
  begin countKey := cIniCount end;

 try
  { store previous entries }
  ReadSectionValues(Section, oldSectionValues);

  prevCount := ReadInteger(Section, countKey, 0);
  WriteInteger(Section, countKey, aStrings.count);
  prevHasChanged := HasChanged;

  { remove all previous lines to get new ones together }
  for ix := 0 to prevCount - 1 do
   begin
   DeleteKey(Section, aPrefix + IntToStr(ix + IndexStart));
   end;
  for ix := 0 to aStrings.count - 1 do
   begin
   WriteString(Section, aPrefix + IntToStr(ix + IndexStart), aStrings[ix]);
   end;

  { check if entries really had changed }
  if NOT prevHasChanged then
   begin
   { read new entries and compare with old }
   ReadSectionValues(Section, newSectionValues);
   HasChanged := NOT ListIdentical(newSectionValues, oldSectionValues);
   end;
 finally
  oldSectionValues.Free;
  newSectionValues.Free;
  end;
end;

{. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . }
{ erase a numbered list                                                      }
{. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . }
procedure TBiggerIniFile.EraseNumberedList(const Section : string;
 aPrefix : String;
 IndexStart : Integer;
 usePrefixOnCount : Boolean);
var
 prevCount,
 ix : Integer;
 countKey : String;
begin
 if usePrefixOnCount then
  begin countKey := aPrefix + cIniCount end
 else
  begin countKey := cIniCount end;

 try
  prevCount := ReadInteger(Section, countKey, -1);
  if prevCount >= 0 then
   begin
   HasChanged := true;
   Deletekey(Section, countKey);
   { remove all previous lines }
   for ix := 0 to prevCount - 1 do
    begin
    DeleteKey(Section, aPrefix + IntToStr(ix + IndexStart));
    end;
   end;
 finally
  end;
end;

{. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . }
{ read a TColor value stored as hex-string                                   }
{. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . }
function TBiggerIniFile.ReadColor(const aSection, aKey : string; aDefault : TColor) : TColor;
begin
 ReadColor := StrToInt('$' + ReadString(aSection, aKey, IntToHex(aDefault, 8)));
end;

{. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . }
{ write TColor as hex-string in the form 00bbggrr                            }
{. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . }
procedure TBiggerIniFile.WriteColor(const aSection, aKey : string; aValue : TColor);
begin
 WriteString(aSection, aKey, IntToHex(aValue, 8));
end;

{. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . }
{ read a font's properties                                                   }
{ example: ReadFont('Fonts','Label1',Label1.Font);                           }
{. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . }
function TBiggerIniFile.ReadFont(const aSection, aKey : string; aDefault : TFont) : TFont;
begin
 with TCSIFont.Create do
  begin
  Value := ReadString(aSection, aKey, '');
  if (Value <> '') then
   begin
   aDefault.Name := FontName;
   aDefault.Size := FontSize;
   aDefault.Style := FontStyle;
   aDefault.Color := FontColor;
   aDefault.Charset := FontCharset;
   aDefault.Pitch := TFontPitch(FontPitch);
   end;
  Free;
  end;
 result := aDefault;
end;

{. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . }
{ writes a font's properties                                                 }
{ example: WriteFont('Fonts','Label1',Label1.Font);                          }
{. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . }
procedure TBiggerIniFile.WriteFont(const aSection, aKey : string; aFont : TFont);
begin
 with TCSIFont.Create do
  begin
  FontName := aFont.Name;
  FontSize := aFont.Size;
  FontStyle := aFont.Style;
  FontColor := aFont.Color;
  FontCharset := aFont.Charset;
  FontPitch := Ord(aFont.Pitch);
  WriteString(aSection, aKey, Value);
  Free;
  end;
end;

{. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . }
{ read a Point's properties                                                  }
{. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . }
function TBiggerIniFile.ReadPoint(const aSection, aKey : string; aDefault : TPoint) : TPoint;
begin
 with TCSIPoint.Create do
  begin
  Value := ReadString(aSection, aKey, '');
  if (Value <> '') then
   begin
   aDefault.X := X;
   aDefault.Y := Y;
   end;
  Free;
  end;
 result := aDefault;
end;

{. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . }
{ writes a Point's properties                                                 }
{. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . }
procedure TBiggerIniFile.WritePoint(const aSection, aKey : string; aPoint : TPoint);
begin
 with TCSIPoint.Create do
  begin
  X := aPoint.X;
  Y := aPoint.Y;
  WriteString(aSection, aKey, Value);
  Free;
  end;
end;

{. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . }
{ read a Rect's properties                                                   }
{. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . }
function TBiggerIniFile.ReadRect(const aSection, aKey : string; aDefault : TRect) : TRect;
begin
 with TCSIRect.Create do
  begin
  Value := ReadString(aSection, aKey, '');
  if (Value <> '') then
   begin
   aDefault.Left := Left;
   aDefault.Top  := Top;
   aDefault.Right := Right;
   aDefault.Bottom := Bottom;
   end;
  Free;
  end;
 result := aDefault;
end;

{. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . }
{ writes a Rect's properties                                                 }
{. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . }
procedure TBiggerIniFile.WriteRect(const aSection, aKey : string; aRect : TRect);
begin
 with TCSIRect.Create do
  begin
  Left := aRect.Left;
  Top  := aRect.Top;
  Right := aRect.Right;
  Bottom := aRect.Bottom;
  WriteString(aSection, aKey, Value);
  Free;
  end;
end;

{. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . }
{ renames a section                                                          }
{. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . }
procedure TBiggerIniFile.RenameSection(const OldSection, NewSection : String);
var
 SectionIndex : Integer;
begin
 if NewSection <> OldSection then
  begin
  SectionIndex := FSectionList.IndexOf(OldSection);
  if SectionIndex <> -1 then
   begin
   FSectionList[SectionIndex] := NewSection;
   end;
  FHasChanged := True;
  end;
end;

{. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . }
{ renames a key                                                              }
{. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . }
procedure TBiggerIniFile.RenameKey(const aSection, OldKey, NewKey : String);
var
 ItemIndex : Integer;
 CurrStringList : TStringList;
begin
 if NewKey <> OldKey then
  begin
  ItemIndex := FindItemIndex(aSection, OldKey, False, CurrStringList);
  if ItemIndex <> -1 then
   begin
   WriteString(aSection, NewKey, ReadString(aSection, OldKey, ''));
   DeleteKey(aSection, OldKey);
   end;
  end;
end;

{. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . }
{ reads data into a buffer                                                   }
{ result: actually read bytes                                                }
{. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . }
function TBiggerIniFile.ReadBinaryData(const aSection, aKey : String; var Buffer; BufSize : Integer) : Integer;
var
 ix : Integer;
 bufPtr : PChar;
 hexDump : AnsiString;
begin
 hexDump := ReadAnsiString(aSection, aKey, '');
 result  := Length(hexDump) div 2;
 if result > BufSize then
  begin result := BufSize end;

 bufPtr := Pointer(Buffer);
 for ix := 0 to result - 1 do
  begin
  Byte(bufPtr[ix]) := StrToIntDef('$' + Copy(hexDump, 1 + ix * 2, 2), 0);
  end;
end;

{. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . }
{ writes data from a buffer                                                  }
{ each represented byte is stored as hexadecimal string                      }
{. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . }
procedure TBiggerIniFile.WriteBinaryData(const aSection, aKey : String; var Buffer; BufSize : Integer);
var
 ix : Integer;
 bufPtr : PChar;
 hexDump : AnsiString;
begin
 hexDump := '';
 bufPtr  := Pointer(Buffer);
 for ix := 0 to BufSize - 1 do
  begin
  hexDump := hexDump + IntToHex(Byte(bufPtr[ix]), 2);
  end;
 WriteAnsiString(aSection, aKey, hexDump);
end;

{. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . }
{ write boolean value if it's differen from given default                    }
{ otherwise the key will be removed from the section                         }
{. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . }
procedure TBiggerIniFile.WriteBoolDef(const aSection, aKey : string; aValue : Boolean; const aDefault : Boolean);
begin
 if (aValue <> aDefault) then
  begin WriteBool(aSection, aKey, aValue) end
 else
  begin DeleteKey(aSection, aKey) end;
end;

{. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . }
{ Starts editor (as found in registry) to show the file                      }
{. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . }
procedure TBiggerIniFile.LaunchInEditor;
begin
 FlushFile;
 if FileExists(FileName) then
  begin
  ShellExecute(0,
   'open',
   PChar(FileName),
   NIL,
   NIL,
   SW_SHOWNORMAL);
  end;
end;

{........................................................................... }
{ class TAppIniFile                                                          }
{........................................................................... }
constructor TAppIniFile.Create;
begin
 inherited Create(defaultFileName);
end;

{. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . }
class function TAppIniFile.defaultFileName : String;
begin
 result := ChangeFileExt(ModuleName(False), '.ini');
end;

{........................................................................... }
{ class TLibIniFile                                                          }
{........................................................................... }

class function TLibIniFile.defaultFileName : String;
begin
 result := ChangeFileExt(ModuleName(True), '.ini');
end;

{ -------------------------------------------------------------------------- }
{ BigIni.pas                                                   eh 2004-04-08 }
{ Version 4.51                                                               }
{    Delphi 3..7 version  (8 ff. not tested, yet)                            }
{    for a Delphi 1/2 version, please see homepage URL below                 }
{ Unit to read/write *.ini files even greater than 64 kB                     }
{ (till today, the KERNEL.DLL and KERNEL32.DLL do it NOT).                   }

{ (c) Edy Hinzen 1996-2004 - Freeware                                        }
{ Mailto:Edy[ at ]Hinzen.de            (thanks for the resonance yet!)       }
{ http://www.hinzen.de/delphi          (where you find the latest version)   }

{ -------------------------------------------------------------------------- }
{ The TBigIniFile object is designed to work like TIniFile from the Borland  }
{ unit called IniFiles.                                                      }
{ The following procedures/functions were added:                             }
{    procedure FlushFile              write data to disk                     }
{    procedure ReadAll                copy entire contents to TStrings-object}
{    procedure AppendFromFile         appends from other *.ini               }
{    property  SectionNames                                                  }
{    procedure WriteAnsiString        writes AnsiString types                }
{    function  ReadAnsiString         reads AnsiString types                 }

{ -------------------------------------------------------------------------- }
{ The TBiggerIniFile object is a child object with some functions that came  }
{ in handy at my projects:                                                   }
{    property  TextBufferSize                                                }
{    procedure WriteSectionValues(const aSection: string;                    }
{                                 const aStrings: TStrings);                 }
{              analog to ReadSectionValues, replace/write all lines from     }
{              aStrings into specified section                               }
{    procedure ReadNumberedList(const Section: string;                       }
{                              aStrings: TStrings;                           }
{                              Deflt: String);                               }
{    procedure WriteNumberedList(const Section: string;                      }
{                                aStrings: TStrings);                        }
{    procedure EraseNumberedList(const Section: string;                      }
{                                aStrings: TStrings);                        }
{    function  ReadColor(const aSection, aKey: string;                       }
{                        aDefault: TColor): TColor;                          }
{    procedure WriteColor(const aSection, aKey: string;                      }
{                         aValue: TColor); virtual;                          }
{    function  ReadFont(const aSection, aKey: string;                        }
{                       aFont: TFont): TFont;                                }
{    procedure WriteFont(const aSection, aKey: string;                       }
{                          aFont: TFont);                                    }
{    function  ReadBinaryData(const aSection, aKey: String;                  }
{                             var Buffer; BufSize: Integer): Integer;        }
{    procedure WriteBinaryData(const aSection, aKey: String;                 }
{                              var Buffer; BufSize: Integer);                }
{    procedure RenameSection(const OldSection, NewSection : String);         }
{    procedure RenameKey(const aSection, OldKey, NewKey : String);           }
{    procedure WriteBoolDef(const aSection, aKey: string;                    }
{                     aValue: Boolean; const aDefault: Boolean);             }

{ -------------------------------------------------------------------------- }
{ The TAppIniFile object is a child again.                                   }
{ It's constructor create() has no parameters. The filename is the           }
{ application's exename with with extension '.ini' (instead of '.exe').      }
{    constructor Create;                                                     }
{ -------------------------------------------------------------------------- }
{ The TLibIniFile object very similar to TAppIniFile.                        }
{ But if the module is a library (e.g. DLL) the library name is used.        }
{    constructor Create;                                                     }
{ -------------------------------------------------------------------------- }

{ ========================================================================== }
{   This program is distributed in the hope that it will be useful,          }
{   but WITHOUT ANY WARRANTY; without even the implied warranty of           }
{   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.                     }
{ ========================================================================== }

{ Version history                                                            }
{ 1.10 faster read by replaceing TStringlist with simple ReadLn instructions }
{      improved FindItemIndex by storing last results                        }
{ 1.20 Ignore duplicate sections                                             }
{      improved (for this use) TStringList child TSectionList                }
{ 1.21 fixed 1.20 bug in case of empty file                                  }
{ 1.22 added ReadNumberedList and WriteNumberedList                          }
{ 1.23 Delphi 1.0 backward compatibility e.g. local class TStringList        }
{ 1.24 added AppendFromFile                                                  }
{ 2.00 Changed compare-routines of aSection Parameters to AnsiCompareText    }
{      to handle case insensitive search in languages with special chars;    }
{      some efforts to increase speed                                        }
{      * new web and e-mail address *                                        }
{ 2.01 implemented modifications/suggestions from Gyula Mészáros, Budapest   }
{ procedure TIniFile.ReadSections(aStrings: TStrings);                       }
{    - The extra 16K file buffer is removeable                               }
{      see property TextBufferSize                                           }
{    - comment lines (beginning with ';') can be ignored                     }
{      set property FlagDropCommentLines to True                             }
{    - invalid lines (which do not contain an '=' sign) can be ignored       }
{      set property FlagFilterOutInvalid to True                             }
{    - white spaces around the '='-sign can be dropped                       }
{      set property FlagDropWhiteSpace to True                               }
{    - surrounding single or double apostrophes from keys can be dropped     }
{      set property FlagDropApostrophes to True                              }
{ 2.01 (continued)                                                           }
{      property SectionNames is now part of TBigIni (instead of TBiggerIni   }
{      added procedure ReadSections (seems new in Delphi 3)                  }
{ 2.02 fixed WriteNumberedList bug                                           }
{      added DeleteKey                                                       }
{      changed Pos() calls to AnsiPos()                                      }
{ 2.03 minor corrections                                                     }
{ 2.04 new flag FlagTrimRight                                                }
{      set it true to strip off white spaces at end of line                  }
{ 2.05 fixed bug in EraseSection                                             }
{ 2.06 For Win32 apps, TAppIniFile now creates ini-filename in correct mixed }
{      case                                                                  }
{      added HasChanged-check routine in WriteNumberedList                   }
{ 2.07 added note [1] and [2]                                                }
{      used new function ListIdentical instead of property named text within }
{      WriteNumberedList for backward-compatibility                          }
{ 3.01 fixed another bug in EraseSection (variable FPrevSectionIndex)        }
{ 3.02 dropped some $IFDEFS related to prior (Delphi 1/2) compatibility code }
{ 3.03 added ReadColor / WriteColor                                          }
{ 3.04 added notice about incombatibility with TMemIniFile.ReadSectionValues }
{ 3.05 fixed TTextBufferSize vs. IniBufferSize bug                           }
{ 3.06 added TBigIniFile.HasSection                                          }
{ 3.07 fixed ClearSectionList bug (variable FPrevIndex)                      }
{ 3.08 fixed EraseDuplicates memory-bug                                      }
{ 3.09 inproved ReadSection: empty and commented tags are removed            }
{      ReadSectionValues now clears target TStrings (if flag set, see 3.10)  }
{      improved handling of TStrings by using BeginUpdate, EndUpdate         }
{ 3.10 partly revided 3.09 change by adding FFlagClearOnReadSectionValues    }
{ 3.11 added TLibIniFile and ModuleName                                      }
{ 3.20 new Methods (for Delphi 5 IniFiles compatibility):                    }
{      clear,                                                                }
{      UpdateFile (same as FlushFile),                                       }
{      SectionExists (same as HasSection),                                   }
{      ReadDate, WriteDate, ReadDateTime, WriteDateTime,                     }
{      ReadFloat, WriteFloat, ReadTime, WriteTime                            }
{ 3.21 Added some exception-handling                                         }
{ 4.00 Introduced tool-class TCommaSeparatedInfo                             }
{      Added TBigIniFile.ReadFont, TBigIniFile.WriteFont                     }
{ 4.01 Added TBigIniFile.ReadAnsiString,TBigIniFile.WriteAnsiString          }
{      added TBiggerIniFile.RenameSection,TBiggerIniFile.RenameKey           }
{      added TBiggerIniFile.ReadBinaryData,TBiggerIniFile.WriteBinaryData    }
{ 4.02 Added compiler directive "$DEFINE UseShortStrings"                    }
{ 4.03 improved ReadString performance                                       }
{ 4.04 Added TBigIniFile.ValueExists                                         }
{ 4.05 fixed HasChanged-bug in RenameSection                                 }
{ 4.10 $DEFINE UseShortStrings deactivated; now uses wide strings as default }
{ 4.11 ReadNumberedList, WriteNumberedList have new (defaulted) parameters   }
{ 4.12 Added WriteBoolDef                                                    }
{ 4.20 ReadNumberedList, WriteNumberedList with parameter usePrefixOnCount   }
{ 4.30 TSectionList.IndexOfName: override in D6                              }
{      Changed TCommaSeparatedInfo functions/procedures to PUBLIC            }
{ 4.31 Changed FHasChanged and FTextBufferSize to PROTECTED                  }
{ 4.32 Added TBiggerIniFile.LaunchInEditor                                   }
{ 4.40 Added readPoint, writePoint, readRect, writeRect                      }
{ 4.42 Added EraseNumberedList                                               }
{ 4.43 Added GetStrings, SetStrings                                          }
{ 4.50 Compiler directives for Delphi 7                                      }
{ 4.51 minor changes ...                                                     }
{ -------------------------------------------------------------------------- }

{ -------------------------------------------------------------------------- }
{ Question: how can I set these properties _before_ the file is opened?      }
{ Answer: call create with empty filename, look at this sample:              }
{       myIniFile := TBigIniFile.Create('');                                 }
{       myIniFile.FlagDropCommentLines := True;                              }
{       myIniFile.FileName := 'my.ini';                                      }
{........................................................................... }
{ Question: how can I write comment lines into the file?                     }
{ Answer: like this:                                                         }
{       tempStringList := TStringList.Create;                                }
{       tempStringList.Add('; this is a comment line.');                     }
{       BiggerIniFile.WriteSectionValues('important note',TempStringList);   }
{       BiggerIniFile.FlushFile;                                             }
{       tempStringList.Free;                                                 }
{ -------------------------------------------------------------------------- }
end.
