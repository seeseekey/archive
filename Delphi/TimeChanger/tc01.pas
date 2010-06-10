unit tc01;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, JvComponentBase, JvTrayIcon, Menus, tc02, globals, IniFiles,
  IdBaseComponent, IdComponent, IdTCPConnection, IdTCPClient, IdTime;

type
  TFormMain = class(TForm)
    TrayIcon: TJvTrayIcon;
    PopupMenu: TPopupMenu;
    Beenden1: TMenuItem;
    N1: TMenuItem;
    a1: TMenuItem;
    a2: TMenuItem;
    a3: TMenuItem;
    a4: TMenuItem;
    a5: TMenuItem;
    N2: TMenuItem;
    Zeitendefinieren1: TMenuItem;
    N3: TMenuItem;
    ZeitberInternetsychronisieren1: TMenuItem;
    IdTime: TIdTime;
    procedure Beenden1Click(Sender: TObject);
    procedure Zeitendefinieren1Click(Sender: TObject);
    procedure Reload;
    procedure FormCreate(Sender: TObject);
    procedure PopupMenuPopup(Sender: TObject);
    procedure a1Click(Sender: TObject);
    procedure ZeitberInternetsychronisieren1Click(Sender: TObject);
    procedure a2Click(Sender: TObject);
    procedure a3Click(Sender: TObject);
    procedure a4Click(Sender: TObject);
    procedure a5Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private-Deklarationen }

  public
    { Public-Deklarationen }
  end;

var
  FormMain: TFormMain;
  OpTimeServer: string='ptbtime1.ptb.de';

implementation

{$R *.dfm}

procedure TFormMain.Reload;
var Ini: TIniFile;
    xDate: TDateTime;
begin
  Ini := TIniFile.Create(ExtractFilePath(Application.ExeName) + 'config.ini');

  if Ini.ReadString('general','timeserver', '') <> '' then
  OpTimeServer := Ini.ReadString('general','timeserver', '');

  a1.Caption := Ini.ReadString('a1', 'name', '');
  a2.Caption := Ini.ReadString('a2', 'name', '');
  a3.Caption := Ini.ReadString('a3', 'name', '');
  a4.Caption := Ini.ReadString('a4', 'name', '');
  a5.Caption := Ini.ReadString('a5', 'name', '');

  if Ini.ReadBool('a1', 'aktiv', false) = true then a1.Visible := true
  else a1.Visible := false;

  if Ini.ReadBool('a2', 'aktiv', false) = true then a2.Visible := true
  else a2.Visible := false;

  if Ini.ReadBool('a3', 'aktiv', false) = true then a3.Visible := true
  else a3.Visible := false;

  if Ini.ReadBool('a4', 'aktiv', false) = true then a4.Visible := true
  else a4.Visible := false;

  if Ini.ReadBool('a5', 'aktiv', false) = true then a5.Visible := true
  else a5.Visible := false;

  Ini.Free;
end;

procedure TFormMain.Beenden1Click(Sender: TObject);
begin
  FormMain.Close;
end;

procedure TFormMain.Zeitendefinieren1Click(Sender: TObject);
begin
  FormDefine.Show;
end;

procedure TFormMain.FormCreate(Sender: TObject);
begin
  Reload;
end;

procedure TFormMain.PopupMenuPopup(Sender: TObject);
begin
  Reload;
end;

procedure TFormMain.a1Click(Sender: TObject);
var Ini: TIniFile;
    xDate: TDateTime;
begin
  Ini := TIniFile.Create(ExtractFilePath(Application.ExeName) + 'config.ini');

  xdate := Ini.ReadDate('a1', 'date', xdate);
  SetPCSystemTime(xdate+Time);

  Ini.Free;
end;

procedure TFormMain.ZeitberInternetsychronisieren1Click(Sender: TObject);
var Ini: TIniFile;
begin
  Ini := TIniFile.Create(ExtractFilePath(Application.ExeName) + 'config.ini');

  if Ini.ReadString('general','timeserver', '') <> '' then
  IdTime.Host := Ini.ReadString('general','timeserver', '');

  SetPCSystemTime(IDTime.DateTime);

  Ini.Free;
end;

procedure TFormMain.a2Click(Sender: TObject);
var Ini: TIniFile;
    xDate: TDateTime;
begin
  Ini := TIniFile.Create(ExtractFilePath(Application.ExeName) + 'config.ini');

  xdate := Ini.ReadDate('a2', 'date', xdate);
  SetPCSystemTime(xdate);

  Ini.Free;
end;

procedure TFormMain.a3Click(Sender: TObject);
var Ini: TIniFile;
    xDate: TDateTime;
begin
  Ini := TIniFile.Create(ExtractFilePath(Application.ExeName) + 'config.ini');

  xdate := Ini.ReadDate('a3', 'date', xdate);
  SetPCSystemTime(xdate);

  Ini.Free;
end;

procedure TFormMain.a4Click(Sender: TObject);
var Ini: TIniFile;
    xDate: TDateTime;
begin
  Ini := TIniFile.Create(ExtractFilePath(Application.ExeName) + 'config.ini');

  xdate := Ini.ReadDate('a4', 'date', xdate);
  SetPCSystemTime(xdate);

  Ini.Free;
end;

procedure TFormMain.a5Click(Sender: TObject);
var Ini: TIniFile;
    xDate: TDateTime;
begin
  Ini := TIniFile.Create(ExtractFilePath(Application.ExeName) + 'config.ini');

  xdate := Ini.ReadDate('a5', 'date', xdate);
  SetPCSystemTime(xdate);

  Ini.Free;
end;

procedure TFormMain.FormClose(Sender: TObject; var Action: TCloseAction);
var Ini: TIniFile;
    xDate: TDateTime;
begin
  Ini := TIniFile.Create(ExtractFilePath(Application.ExeName) + 'config.ini');

  if Ini.ReadBool('general','timeserver', false) = true then
  ZeitberInternetsychronisieren1Click(Sender);

  Ini.Free;
end;

end.
