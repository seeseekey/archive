unit tc02;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Mask, JvExMask, JvToolEdit, JvMaskEdit, JvCheckedMaskEdit,
  JvDatePickerEdit, StdCtrls, Spin, IniFiles, globals;

type
  TFormDefine = class(TForm)
    GroupBox1: TGroupBox;
    a1Stunde: TSpinEdit;
    a1Date: TJvDateEdit;
    a1Minute: TSpinEdit;
    a1Sekunde: TSpinEdit;
    a1Name: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    a2Name: TEdit;
    a2Date: TJvDateEdit;
    a2Stunde: TSpinEdit;
    a2Minute: TSpinEdit;
    a2Sekunde: TSpinEdit;
    a3Name: TEdit;
    a3Date: TJvDateEdit;
    a3Stunde: TSpinEdit;
    a3Minute: TSpinEdit;
    a3Sekunde: TSpinEdit;
    a4Name: TEdit;
    a4Date: TJvDateEdit;
    a4Stunde: TSpinEdit;
    a4Minute: TSpinEdit;
    a4Sekunde: TSpinEdit;
    a5Name: TEdit;
    a5Date: TJvDateEdit;
    a5stunde: TSpinEdit;
    a5Minute: TSpinEdit;
    a5Sekunde: TSpinEdit;
    a1a: TCheckBox;
    a2a: TCheckBox;
    a3a: TCheckBox;
    a4a: TCheckBox;
    a5a: TCheckBox;
    Label6: TLabel;
    GroupBox2: TGroupBox;
    TimeServer: TEdit;
    Button1: TButton;
    Button2: TButton;
    GroupBox3: TGroupBox;
    downpeak: TCheckBox;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  FormDefine: TFormDefine;

implementation

{$R *.dfm}

procedure TFormDefine.Button1Click(Sender: TObject);
begin
  FormDefine.Close;
end;

procedure TFormDefine.Button2Click(Sender: TObject);
var Ini: TIniFile;
begin
  Ini := TIniFile.Create(ExtractFilePath(Application.ExeName) + 'config.ini');

  Ini.WriteString('general', 'timeserver', TimeServer.Text);
  Ini.WriteBool('general', 'downpeak', downpeak.Checked);

  Ini.WriteString('a1', 'name', a1name.Text);
  Ini.WriteString('a2', 'name', a2name.Text);
  Ini.WriteString('a3', 'name', a3name.Text);
  Ini.WriteString('a4', 'name', a4name.Text);
  Ini.WriteString('a5', 'name', a5name.Text);

  Ini.WriteDate('a1', 'date', a1date.Date);
  Ini.WriteDate('a2', 'date', a2date.Date);
  Ini.WriteDate('a3', 'date', a3date.Date);
  Ini.WriteDate('a4', 'date', a4date.Date);
  Ini.WriteDate('a5', 'date', a5date.Date);

  Ini.WriteInteger('a1', 'stunde', a1Stunde.Value);
  Ini.WriteInteger('a2', 'stunde', a2Stunde.Value);
  Ini.WriteInteger('a3', 'stunde', a3Stunde.Value);
  Ini.WriteInteger('a4', 'stunde', a4Stunde.Value);
  Ini.WriteInteger('a5', 'stunde', a5Stunde.Value);

  Ini.WriteInteger('a1', 'minute', a1Minute.Value);
  Ini.WriteInteger('a2', 'minute', a2Minute.Value);
  Ini.WriteInteger('a3', 'minute', a3Minute.Value);
  Ini.WriteInteger('a4', 'minute', a4Minute.Value);
  Ini.WriteInteger('a5', 'minute', a5Minute.Value);

  Ini.WriteInteger('a1', 'sekunde', a1Sekunde.Value);
  Ini.WriteInteger('a2', 'sekunde', a2Sekunde.Value);
  Ini.WriteInteger('a3', 'sekunde', a3Sekunde.Value);
  Ini.WriteInteger('a4', 'sekunde', a4Sekunde.Value);
  Ini.WriteInteger('a5', 'sekunde', a5Sekunde.Value);

  Ini.WriteBool('a1', 'aktiv', a1a.Checked);
  Ini.WriteBool('a2', 'aktiv', a2a.Checked);
  Ini.WriteBool('a3', 'aktiv', a3a.Checked);
  Ini.WriteBool('a4', 'aktiv', a4a.Checked);
  Ini.WriteBool('a5', 'aktiv', a5a.Checked);

  Ini.Free;

  Reload := true;
  
  FormDefine.Close;
end;

procedure TFormDefine.FormShow(Sender: TObject);
var Ini: TIniFile;
    xDate: TDateTime;
begin
  Ini := TIniFile.Create(ExtractFilePath(Application.ExeName) + 'config.ini');

  if Ini.ReadString('general','timeserver', '') <> '' then
  TimeServer.Text := Ini.ReadString('general','timeserver', '');

  downpeak.Checked :=  Ini.ReadBool('general', 'downpeak', false);

  a1name.Text := Ini.ReadString('a1', 'name', '');
  a2name.Text := Ini.ReadString('a2', 'name', '');
  a3name.Text := Ini.ReadString('a3', 'name', '');
  a4name.Text := Ini.ReadString('a4', 'name', '');
  a5name.Text := Ini.ReadString('a5', 'name', '');

  a1date.Date := Ini.ReadDate('a1', 'date', xDate);
  a2date.Date := Ini.ReadDate('a2', 'date', xDate);
  a3date.Date := Ini.ReadDate('a3', 'date', xDate);
  a4date.Date := Ini.ReadDate('a4', 'date', xDate);
  a5date.Date := Ini.ReadDate('a5', 'date', xDate);

  a1Stunde.Value := Ini.ReadInteger('a1', 'stunde', 0);
  a2Stunde.Value := Ini.ReadInteger('a2', 'stunde', 0);
  a3Stunde.Value := Ini.ReadInteger('a3', 'stunde', 0);
  a4Stunde.Value := Ini.ReadInteger('a4', 'stunde', 0);
  a5Stunde.Value := Ini.ReadInteger('a5', 'stunde', 0);

  a1Minute.Value := Ini.ReadInteger('a1', 'minute', 0);
  a2Minute.Value := Ini.ReadInteger('a2', 'minute', 0);
  a3Minute.Value := Ini.ReadInteger('a3', 'minute', 0);
  a4Minute.Value := Ini.ReadInteger('a4', 'minute', 0);
  a5Minute.Value := Ini.ReadInteger('a5', 'minute', 0);

  a1Sekunde.Value := Ini.ReadInteger('a1', 'sekunde', 0);
  a2Sekunde.Value := Ini.ReadInteger('a2', 'sekunde', 0);
  a3Sekunde.Value := Ini.ReadInteger('a3', 'sekunde', 0);
  a4Sekunde.Value := Ini.ReadInteger('a4', 'sekunde', 0);
  a5Sekunde.Value := Ini.ReadInteger('a5', 'sekunde', 0);

  a1a.Checked := Ini.ReadBool('a1', 'aktiv', false);
  a2a.Checked := Ini.ReadBool('a2', 'aktiv', false);
  a3a.Checked := Ini.ReadBool('a3', 'aktiv', false);
  a4a.Checked := Ini.ReadBool('a4', 'aktiv', false);
  a5a.Checked := Ini.ReadBool('a5', 'aktiv', false);

  Ini.Free;

end;

end.
