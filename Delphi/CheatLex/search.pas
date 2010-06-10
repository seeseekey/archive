unit Search;

interface

uses WinProcs,
  SysUtils,
  StdCtrls,
  Dialogs;

const
  { Default word delimiters are any character except the core alphanumerics. }
  WordDelimiters: set of Char = [#0..#255] - ['a'..'z','A'..'Z','1'..'9','0'];

{ SearchMemo scans the text of a TEdit, TMemo, or other TCustomEdit-derived
  component for a given search string.  The search starts at the current
  caret position in the control.  The Options parameter determines whether the
  search runs forward (frDown) or backward from the caret position, whether
  or not the text comparison is case sensitive, and whether the matching
  string must be a whole word.  If text is already selected in the control,
  the search starts at the 'far end' of the selection (SelStart if searching
  backwards, SelEnd if searching forwards).  If a match is found, the
  control's text selection is changed to select the found text and the
  function returns True.  If no match is found, the function returns False. }
function SearchMemo(Memo: TCustomEdit;
                    const SearchString: String;
                    Options: TFindOptions): Boolean;

{ SearchBuf is a lower-level search routine for arbitrary text buffers.  Same
  rules as SearchMemo above.  If a match is found, the function returns a
  pointer to the start of the matching string in the buffer.  If no match,
  the function returns nil. }
function SearchBuf(Buf: PChar; BufLen: Integer;
                   SelStart, SelLength: Integer;
                   SearchString: String;
                   Options: TFindOptions): PChar;

implementation


function SearchMemo(Memo: TCustomEdit;
                    const SearchString: String;
                    Options: TFindOptions): Boolean;
var
  Buffer, P: PChar;
  Size: Word;
begin
  Result := False;
  if (Length(SearchString) = 0) then Exit;
  Size := Memo.GetTextLen;
  if (Size = 0) then Exit;
  Buffer := StrAlloc(Size + 1);
  try
    Memo.GetTextBuf(Buffer, Size + 1);
    P := SearchBuf(Buffer, Size, Memo.SelStart, Memo.SelLength,
                   SearchString, Options);
    if P <> nil then
    begin
      Memo.SelStart := P - Buffer;
      Memo.SelLength := Length(SearchString);
      Result := True;
    end;
  finally
    StrDispose(Buffer);
  end;
end;


function SearchBuf(Buf: PChar; BufLen: Integer;
                   SelStart, SelLength: Integer;
                   SearchString: String;
                   Options: TFindOptions): PChar;
var
  SearchCount, I: Integer;
  C: Char;
  Direction: Shortint;
  CharMap: array [Char] of Char;

  function FindNextWordStart(var BufPtr: PChar): Boolean;
  begin                   { (True XOR N) is equivalent to (not N) }
   // Result := False;      { (False XOR N) is equivalent to (N)    }
     { When Direction is forward (1), skip non delimiters, then skip delimiters. }
     { When Direction is backward (-1), skip delims, then skip non delims }
    while (SearchCount > 0) and
          ((Direction = 1) xor (BufPtr^ in WordDelimiters)) do
    begin
      Inc(BufPtr, Direction);
      Dec(SearchCount);
    end;
    while (SearchCount > 0) and
          ((Direction = -1) xor (BufPtr^ in WordDelimiters)) do
    begin
      Inc(BufPtr, Direction);
      Dec(SearchCount);
    end;
    Result := SearchCount > 0;
    if Direction = -1 then
    begin   { back up one char, to leave ptr on first non delim }
      Dec(BufPtr, Direction);
      Inc(SearchCount);
    end;
  end;

begin
  Result := nil;
  if BufLen <= 0 then Exit;
  if frDown in Options then
  begin
    Direction := 1;
    Inc(SelStart, SelLength);  { start search past end of selection }
    SearchCount := BufLen - SelStart - Length(SearchString);
    if SearchCount < 0 then Exit;
    if Longint(SelStart) + SearchCount > BufLen then Exit;
  end
  else
  begin
    Direction := -1;
    Dec(SelStart, Length(SearchString));
    SearchCount := SelStart;
  end;
  if (SelStart < 0) or (SelStart > BufLen) then Exit;
  Result := @Buf[SelStart];

  { Using a Char map array is faster than calling AnsiUpper on every character }
  for C := Low(CharMap) to High(CharMap) do
    CharMap[C] := C;

  if not (frMatchCase in Options) then
  begin
    AnsiUpperBuff(PChar(@CharMap), sizeof(CharMap));
    AnsiUpperBuff(@SearchString[1], Length(SearchString));
  end;

  while SearchCount > 0 do
  begin
    if frWholeWord in Options then
      if not FindNextWordStart(Result) then Break;
    I := 0;
    while (CharMap[Result[I]] = SearchString[I+1]) do
    begin
      Inc(I);
      if I >= Length(SearchString) then
      begin
        if (not (frWholeWord in Options)) or
           (SearchCount = 0) or
           (Result[I] in WordDelimiters) then
          Exit;
        Break;
      end;
    end;
    Inc(Result, Direction);
    Dec(SearchCount);
  end;
  Result := nil;
end;

end.

