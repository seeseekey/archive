unit vs00;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Menus, StdCtrls, ExtCtrls, inifiles, BtChkBox;

type
  Tmainform = class(TForm)
    ListBox: TListBox;
    MainMenu1: TMainMenu;
    Datei1: TMenuItem;
    ffne1: TMenuItem;
    Beenden1: TMenuItem;
    Button1: TButton;
    Timer: TTimer;
    od: TOpenDialog;
    stayontop: TBitCheckBox;
    procedure Beenden1Click(Sender: TObject);
    procedure TimerTimer(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure ffne1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure stayontopClick(Sender: TObject);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  mainform: Tmainform;
  timing: integer;
  StrList: TStringList;
  wert: boolean;
  schleife: integer;

implementation

{$R *.DFM}

procedure Tmainform.Beenden1Click(Sender: TObject);
begin
close;
end;

procedure Tmainform.TimerTimer(Sender: TObject);
var
  Ini: TIniFile;
begin
StrList := TStringList.Create;
Ini := TIniFile.Create(od.FileName);
Ini.ReadSection ('song', Strlist);
schleife := strlist.Count;


inc (timing);
if timing = 60 then timing := 100;
if timing = 160 then timing := 200;
if timing = 260 then timing := 300;
if timing = 360 then timing := 400;
if timing = 460 then timing := 500;
if timing = 560 then timing := 600;
if timing = 660 then timing := 700;
if timing = 760 then timing := 800;
if timing = 860 then timing := 900;
if timing = 960 then timing := 1000;
if timing = 1060 then timing := 1100;
if timing = 1160 then timing := 1200;
if timing = 1260 then timing := 1300;

if ini.ReadString('another', 'counter', '') = 'true' then
caption := inttostr(timing);

try
repeat
dec(schleife);
if timing = strtoint(strlist.Strings[schleife]) then wert := true;
until wert = true;
wert := false;
listbox.Items.Clear;
listbox.items.add(ini.ReadString('song', strlist.Strings[schleife] , 'Fehler in Datei.'));
except
 end;
if timing = ini.Readinteger('antoher', 'end', 0) then timing := 0;
ini.free;
end;

procedure Tmainform.Button1Click(Sender: TObject);
begin
if timer.Enabled = true then
 begin
  timer.enabled := false;
  timing := 0;
  button1.caption := 'Start';
  listbox.clear;
 end
else
 begin
  timer.enabled := true;
  timing := 0;
  button1.caption := 'Stop';
  listbox.clear;
 end

end;

procedure Tmainform.ffne1Click(Sender: TObject);
var
  Ini: TIniFile;
begin
if OD.Execute then
begin
  button1.Enabled := true;
  Ini := TIniFile.Create(od.FileName);
  caption := 'Visual Song V1.15 (' +
  ini.ReadString('another', 'band','Unbekannt') + ' - ' +
  ini.ReadString('another', 'songname','Unbekannt') + ')';
  ini.free;
end;
end;

procedure Tmainform.FormCreate(Sender: TObject);
begin
mainform.left := Screen.Width - 490;
end;

procedure Tmainform.stayontopClick(Sender: TObject);
begin
if stayontop.Checked = true then FormStyle := fsStayOnTop
else
mainform.FormStyle := fsnormal;
end;

end.
