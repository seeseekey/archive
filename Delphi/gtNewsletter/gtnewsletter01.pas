unit gtnewsletter01;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Globals, bigini;

type
  Tcreatekontoform = class(TForm)
    Label1: TLabel;
    kontoname: TEdit;
    Label2: TLabel;
    abs: TEdit;
    GroupBox1: TGroupBox;
    Label3: TLabel;
    smtpserver: TEdit;
    Label4: TLabel;
    benutzername: TEdit;
    Label5: TLabel;
    passwort: TEdit;
    Button1: TButton;
    Button2: TButton;
    Label6: TLabel;
    smtpport: TEdit;
    procedure Button2Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Button1Click(Sender: TObject);
    procedure FormPaint(Sender: TObject);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  createkontoform: Tcreatekontoform;
  kontoedit2: boolean=false;

implementation

{$R *.dfm}

procedure Tcreatekontoform.Button2Click(Sender: TObject);
begin
createkontoform.Close;
end;

procedure Tcreatekontoform.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
kontoname.Text := '';
abs.Text := '';
smtpserver.Text := '';
benutzername.Text := '';
passwort.Text := '';
end;

procedure Tcreatekontoform.Button1Click(Sender: TObject);
var inifile: TBiggerIniFile;
    kontoordner: string;
    sectionlist: TStrings;
    i: Integer;
begin
 reload3 := true;
 if kontoedit2 = true then
 begin
  kontoordner := sectionglobal;
 end
 else
 begin
  kontoordner := GetTimeString(1);
 end;
 
 if ansipos('|', kontoname.Text) > 0 then
 begin
   MessageDlg('Das Zeichen | darf nicht im Kontonamen enthalten sein!',
               mtInformation,[mbOk], 0);
   Exit;
 end;

 inifile := TBiggerIniFile.Create(ExtractFilePath(Application.ExeName) + 'konten.ini');

 //Überprüfen ob der kontoname schon existiert
 if kontoedit2 = true then
 begin
    kontoedit2 := false;
 end
 else
 begin
  sectionlist := TStringlist.Create;
  inifile.ReadSections(sectionlist);
  for i := 0 to sectionlist.Count-1 do
  begin
   if inifile.ReadString(sectionlist.Strings[i], 'kontoname', '') = kontoname.Text then
   begin
    inifile.Free;
    MessageDlg('Dieser Kontoname existiert bereits! Bitte wählen Sie einen anderen Kontoname.',
                mtInformation,[mbOk], 0);
    Exit;
   end;
  end;
  sectionlist.Free;
 end;
 
 //Kontoname schreiben
 inifile.WriteString(kontoordner, 'kontoname', kontoname.Text);
 inifile.WriteString(kontoordner, 'abs', abs.Text);
 inifile.WriteString(kontoordner, 'smtpserver', smtpserver.Text);
 inifile.WriteString(kontoordner, 'smtpport', smtpport.Text);
 inifile.WriteString(kontoordner, 'benutzername', benutzername.Text);
 inifile.WriteString(kontoordner, 'password', passwort.Text);
 //BUILD88
 //inifile.WriteString(kontoordner, 'password', xorstring(passwort.Text, 'nethanolove'));
 inifile.Free;

 ForceDirectories(ExtractFilePath(Application.ExeName) + 'konten\' + kontoordner + '\Entwurf');
 ForceDirectories(ExtractFilePath(Application.ExeName) + 'konten\' + kontoordner + '\Gesendet');
 //ForceDirectories(ExtractFilePath(Application.ExeName) + 'konten\' + kontoordner + '\Papierkorb');

 Reload := true;

 createkontoform.Close;
end;

procedure Tcreatekontoform.FormPaint(Sender: TObject);
var inifile: TBiggerIniFile;
begin
 if kontoedit = true then
 begin
  createkontoform.Caption := 'Kontodaten bearbeiten...';
  inifile := TBiggerIniFile.Create(ExtractFilePath(Application.ExeName) + 'konten.ini');
  kontoname.text := inifile.ReadString(sectionglobal, 'kontoname', '');
  abs.text :=  inifile.ReadString(sectionglobal, 'abs', '');
  smtpserver.text :=  inifile.ReadString(sectionglobal, 'smtpserver', '');
  smtpport.text :=  inifile.ReadString(sectionglobal, 'smtpport', '');
  benutzername.text :=  inifile.ReadString(sectionglobal, 'benutzername', '');
  passwort.text  :=  inifile.ReadString(sectionglobal, 'password', '');
  inifile.Free;

  kontoedit := false;
  kontoedit2 := true;
 end
 else
 begin
   createkontoform.Caption := 'Neues Konto anlegen...';
 end;
end;

end.
