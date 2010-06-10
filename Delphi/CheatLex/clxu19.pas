unit clxu19;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ComCtrls, StdCtrls, Registry, UPathDialog, BtChkBox;

type
  Toptionen = class(TForm)
    PageControl1: TPageControl;
    Allgemein: TTabSheet;
    Button_Uebernehmen: TButton;
    Button1: TButton;
    tools: TTabSheet;
    Edit1: TEdit;
    Button2: TButton;
    Label1: TLabel;
    OpenDialog1: TOpenDialog;
    Edit2: TEdit;
    Button3: TButton;
    Label2: TLabel;
    Label3: TLabel;
    Edit3: TEdit;
    Button4: TButton;
    Label4: TLabel;
    Edit4: TEdit;
    Button5: TButton;
    CheckBoxInstanz: TBitCheckBox;
    extrtf: TBitCheckBox;
    systray: TBitCheckBox;
    mauszeiger: TBitCheckBox;
    procedure Button1Click(Sender: TObject);
    procedure Button_UebernehmenClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  optionen: Toptionen;

implementation

{$R *.DFM}

procedure Toptionen.Button1Click(Sender: TObject);
begin
optionen.close;
end;

procedure Toptionen.Button_UebernehmenClick(Sender: TObject);
 var regist: TRegistry;
begin
regist:=TRegistry.Create;
regist.RootKey:=HKEY_CURRENT_USER;
regist.OpenKey('Software\Global Technology\CheatLex', true);

// Allgemein
if CheckBoxInstanz.Checked = true then
regist.Writestring('Instanz', 'true')
else
regist.Writestring('Instanz', 'false');

if extrtf.Checked = true then
regist.Writestring('Default Extension', 'true')
else
regist.Writestring('Default Extension', 'false');

if systray.Checked = true then
regist.Writestring('Systray', 'true')
else
regist.Writestring('Systray', 'false');

if mauszeiger.Checked = true then
regist.Writestring('Mauszeiger', 'true')
else
regist.Writestring('Mauszeiger', 'false');

{if autostart.Checked = true then
regist.Writestring('Autostart', 'true')
else
regist.Writestring('Autostart', 'false');

regist.RootKey:=HKEY_LOCAL_MACHINE;
regist.OpenKey('SOFTWARE\Microsoft\Windows\CurrentVersion\Run', true);
if autostart.Checked = true then
regist.Writestring('CheatLex', 'cheatlex.exe')
else
regist.DeleteKey('CheatLex');

regist.RootKey:=HKEY_CURRENT_USER;
regist.OpenKey('Software\Global Technology\CheatLex', true);}

// Tools
if edit1.text = '' then
regist.Writestring('Editor', 'Keine Datei angegeben')
else
regist.Writestring('Editor', edit1.text);

if edit2.text = '' then
regist.Writestring('Rechner', 'Keine Datei angegeben')
else
regist.writestring('Rechner', edit2.text);

if edit3.text = '' then
regist.Writestring('Hex Editor', 'Keine Datei angegeben')
else
regist.Writestring('Hex Editor', edit3.text);

if edit4.text = '' then
regist.Writestring('Registry Editor', 'Keine Datei angegeben')
else
regist.Writestring('Registry Editor', edit4.text);

regist.CloseKey;
 optionen.close;
end;

procedure Toptionen.FormCreate(Sender: TObject);
var regist: TRegistry;
begin
regist:=TRegistry.Create;
regist.RootKey:=HKEY_CURRENT_USER;
regist.OpenKey('Software\Global Technology\CheatLex', true);

// Allgemein
if regist.Readstring('Instanz') = 'true' then
CheckBoxInstanz.Checked := true
else
CheckBoxInstanz.Checked := false;

if regist.Readstring('Default Extension') = 'true' then
extrtf.Checked := true
else
extrtf.Checked := false;

if regist.Readstring('Systray') = 'true' then
systray.Checked := true
else
systray.Checked := false;

if regist.Readstring('Mauszeiger') = 'true' then
mauszeiger.Checked := true
else
mauszeiger.Checked := false;
{if regist.Readstring('Autostart') = 'true' then
autostart.Checked := true
else
autostart.Checked := false;}


// Tools
edit1.text := regist.Readstring('Editor');
edit2.text := regist.Readstring('Rechner');
edit3.text := regist.Readstring('Hex Editor');
edit4.text := regist.Readstring('Registry Editor');
regist.free;
end;

procedure Toptionen.Button2Click(Sender: TObject);
begin
if openDialog1.execute then
edit1.text := opendialog1.FileName;
end;

procedure Toptionen.Button3Click(Sender: TObject);
begin
if openDialog1.execute then
edit2.text := opendialog1.FileName;
end;

procedure Toptionen.Button4Click(Sender: TObject);
begin
if openDialog1.execute then
edit3.text := opendialog1.FileName;
end;

procedure Toptionen.Button5Click(Sender: TObject);
begin
 if openDialog1.execute then
edit4.text := opendialog1.FileName;
end;



end.
