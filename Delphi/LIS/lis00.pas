unit lis00;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, StdCtrls, ComCtrls, inifiles, Menus, ShellAPI, fmxutils;

type
  Tmainform = class(TForm)
    ausgabe: TRichEdit;
    ai: TImage;
    eingabe: TEdit;
    debugmenu: TPopupMenu;
    QuestionMode: TMenuItem;
    StayonTop: TMenuItem;
    N1: TMenuItem;
    fileopen: TMenuItem;
    docbox: TListBox;
    savedialog: TSaveDialog;
    sessionsave: TMenuItem;
    sessionnormsave: TMenuItem;
    informationen: TMenuItem;
    altpic: TMenuItem;
    lis: TImage;
    N2: TMenuItem;
    debugend: TMenuItem;
    N3: TMenuItem;
    Begrungndern1: TMenuItem;
    Versionsnummerndern1: TMenuItem;
    procedure eingabeKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
    procedure aiClick(Sender: TObject);
    procedure QuestionModeClick(Sender: TObject);
    procedure StayonTopClick(Sender: TObject);
    procedure fileopenClick(Sender: TObject);
    procedure sessionsaveClick(Sender: TObject);
    procedure sessionnormsaveClick(Sender: TObject);
    procedure informationenClick(Sender: TObject);
    procedure altpicClick(Sender: TObject);
    procedure debugendClick(Sender: TObject);
    procedure Begrungndern1Click(Sender: TObject);
    procedure Versionsnummerndern1Click(Sender: TObject);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  mainform: Tmainform;
  cheat: byte;
  StrList: TStringList;
  answer: string;
  answerfalse: boolean;
  lastquestion: string;

implementation

{$R *.DFM}
function ce(str: string): Boolean;
var
  Ini: TIniFile;
  wert: integer;
  schleife: longint;

begin
StrList := TStringList.Create;
Ini := TIniFile.Create(ExtractFilePath(Application.ExeName) + 'lis.dat');
Ini.ReadSection ('answers', Strlist);
schleife := strlist.Count;
str := lowercase(str);

try
repeat
dec(schleife);
wert := AnsiPos(strlist.Strings[schleife],str);
until wert > 0;
except
  Result := False;
  exit;
end;

answer := ini.ReadString('answers', strlist.Strings[schleife], 'Ich bin beschädigt. (lis.dat)');
Ini.Free;
Result := true;
end;

procedure Tmainform.eingabeKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
zufall :integer;
Ini: TIniFile;
begin
if key = vk_RETURN then
begin
if eingabe.Text = '' then
else
begin
docbox.Items.Add('User: ' + eingabe.text);
if answerfalse = true then
 begin
  answerfalse := false;
  if lowercase(eingabe.text) = 'exit qm' then
  begin
   questionmode.Checked := false;
   eingabe.text := '';
   ausgabe.Enabled := true;
   ausgabe.Lines.add('exit qm ausgeführt!');
   docbox.Items.Add('LIS: exit qm ausgeführt!');
   ausgabe.Enabled := false;
   eingabe.SetFocus;
  end
  else
  begin
  Ini := TIniFile.Create(ExtractFilePath(Application.ExeName) + 'lis.dat');
  lastquestion := lowercase(lastquestion);
  ini.writeString('answers', lastquestion, eingabe.text);
  Ini.Free;
  eingabe.text := '';
  ausgabe.Enabled := true;
  ausgabe.Lines.add('Danke für diese Information.');
  docbox.Items.Add('LIS: Danke für diese Information.');
  ausgabe.Enabled := false;
  eingabe.SetFocus;
  end
 end
else
begin
if ce (eingabe.text) = false then
 begin
  ausgabe.Enabled := true;
  ausgabe.SetFocus;
  zufall := random(5);
  if questionmode.Checked = true then zufall := -1;
  if zufall = 0 then
   begin
     ausgabe.Lines.add('Wie bitte...');
     docbox.Items.Add('LIS: Wie bitte...');
   end;
  if zufall = 1 then
   begin
     ausgabe.Lines.add('Das habe ich nicht verstanden.');
     docbox.Items.Add('LIS: Das habe ich nicht verstanden.');
   end;
  if zufall = 2 then
   begin
     ausgabe.Lines.add('Könntest du das bitte anders formulieren.');
     docbox.Items.Add('LIS: Könntest du das bitte anders formulieren.');
   end;
  if zufall = 3 then 
   begin
     ausgabe.Lines.add('Wie jetzt?');
     docbox.Items.Add('LIS: Wie jetzt?');
   end;
  if zufall = 4 then
   begin
     ausgabe.Lines.add('Erzähl mir bitte etwas anderes.');
     docbox.Items.Add('LIS: Erzähl mir bitte etwas anderes.');
   end;
  if zufall = -1 then
   begin
    ausgabe.lines.add(eingabe.Text + ' - Ich verstehe das nicht. Was könnte ich auf diesen Satz antworten?');
    docbox.Items.Add('LIS: '+eingabe.Text + ' - Ich verstehe das nicht. Was könnte ich auf diesen Satz antworten?');
    answerfalse := true;
    lastquestion := eingabe.text;
   end;
  ausgabe.Enabled := false;
  eingabe.SetFocus;
 end
else
 begin
  ausgabe.Enabled := true;
  ausgabe.SetFocus;
  ausgabe.Lines.add(answer);
  docbox.Items.Add('LIS: ' + answer);
  ausgabe.Enabled := false;
  eingabe.SetFocus;
 end;
 eingabe.text := '';
end;
end;
end;
end;

procedure Tmainform.FormCreate(Sender: TObject);
var
  Ini: TIniFile;
begin
mainform.left := Screen.Width - 508;

randomize;
answerfalse := false;
// INI Zugriff
Ini := TIniFile.Create(ExtractFilePath(Application.ExeName) + 'lis.dat');
caption := caption + Ini.ReadString('lisop', 'Version', 'V0.00');

docbox.Items.Add('LIS: '+ Ini.ReadString('lisop', 'startone', 'LIS ONLINE, System Ready.'));
docbox.Items.Add('LIS: '+ Ini.ReadString('lisop', 'starttwo', 'Guten Tag ich bin LIS, das Language Interaction System.'));

ausgabe.Lines.Add(Ini.ReadString('lisop', 'startone', 'LIS ONLINE, System Ready.'));
ausgabe.Lines.Add(Ini.ReadString('lisop', 'starttwo', 'Guten Tag ich bin LIS, das Language Interaction System.'));

Ini.Free;
end;

procedure Tmainform.aiClick(Sender: TObject);
begin
inc (cheat);
if cheat = 10 then
begin
cheat := 0;
ai.PopupMenu := debugmenu;
debugmenu.AutoPopup := True;
end;
end;

procedure Tmainform.QuestionModeClick(Sender: TObject);
begin
if questionmode.Checked = true then questionmode.Checked := false
else questionmode.Checked := true;
end;

procedure Tmainform.StayonTopClick(Sender: TObject);
begin
if stayontop.Checked = true then stayontop.Checked := false
else stayontop.Checked := true;

if stayontop.Checked = true then mainform.FormStyle := fsStayOnTop
else mainform.FormStyle := fsnormal;
end;

procedure Tmainform.fileopenClick(Sender: TObject);
begin
ShellExecute(0,Nil,PChar(ExtractFilePath(Application.ExeName)+'lis.dat'),
              Nil, Nil, SW_NORMAL);
end;

procedure Tmainform.sessionsaveClick(Sender: TObject);
begin
if savedialog.Execute then docbox.Items.SaveToFile(savedialog.filename);
end;

procedure Tmainform.sessionnormsaveClick(Sender: TObject);
begin
 if savedialog.Filename = '' then sessionsaveClick(Sender)
 else docbox.Items.SaveToFile(savedialog.filename);
end;

procedure Tmainform.informationenClick(Sender: TObject);
begin
  ausgabe.Enabled := true;
  ausgabe.SetFocus;

  ausgabe.Lines.add(Format('%s, %d bytes', ['lis.dat', GetFileSize(ExtractFilePath(Application.ExeName) + 'lis.dat')]));
  docbox.Items.Add('LIS: ' + Format('%s, %d bytes', ['lis.dat', GetFileSize(ExtractFilePath(Application.ExeName) + 'lis.dat')]));

  ausgabe.Lines.add('© 2003 by Botts Software / www.botts-software.de.vu');
  docbox.Items.Add('© 2003 by Botts Software / www.botts-software.de.vu');
  ausgabe.Lines.add('www.seeseekey.de.vu / www.global-technology.de.vu');
  docbox.Items.Add('www.seeseekey.de.vu / www.global-technology.de.vu');


  ausgabe.Enabled := false;
  eingabe.SetFocus;

end;

procedure Tmainform.altpicClick(Sender: TObject);

begin
if altpic.Checked = true then altpic.Checked := false
else altpic.Checked := true;

if altpic.Checked = true then
 begin
  ai.Visible := false;
  lis.Visible := true;
 end
else
 begin
  lis.Visible := false;
  ai.Visible := true;
 end;

end;

procedure Tmainform.debugendClick(Sender: TObject);
begin
debugmenu.AutoPopup := false;
lis.Visible := false;
ai.Visible := true;

questionmode.Checked := false;
stayontop.Checked := false;
altpic.Checked := false;

stayontop.Checked := false;
mainform.FormStyle := fsnormal;
end;

procedure Tmainform.Begrungndern1Click(Sender: TObject);
var
 stringsave: string;
 failorsave: boolean;
 Ini: TIniFile;
begin
Ini := TIniFile.Create(ExtractFilePath(Application.ExeName) + 'lis.dat');
stringsave := 'LIS ONLINE, System Ready.';
failorsave := InputQuery('Begrüßung ändern', 'Bitte Begrüßung Zeile 1 eingeben:', stringsave);
if failorsave = true then Ini.WriteString('lisop', 'startone', stringsave);

stringsave := 'Guten Tag ich bin LIS, das Language Interaction System.';
failorsave := InputQuery('Begrüßung ändern', 'Bitte Begrüßung Zeile 2 eingeben:', stringsave);
if failorsave = true then Ini.WriteString('lisop', 'starttwo', stringsave);

ini.free;
end;

procedure Tmainform.Versionsnummerndern1Click(Sender: TObject);
var
 stringsave: string;
 failorsave: boolean;
 Ini: TIniFile;
begin
Ini := TIniFile.Create(ExtractFilePath(Application.ExeName) + 'lis.dat');
stringsave := Ini.ReadString('lisop', 'version', 'V0.00');
failorsave := InputQuery('Begrüßung ändern', 'Bitte neue Versionsnummer eingeben:', stringsave);
if failorsave = true then Ini.WriteString('lisop', 'version', stringsave);



ini.free;
end;

end.
