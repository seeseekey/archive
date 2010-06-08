unit gtnewsletter03;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, globals, ComCtrls, ToolWin, StdCtrls, ExtCtrls, Buttons,
   bigini, StrUtils, IdAttachment, IdAttachmentFile, IdMessage;

type
  Tcreatenewmail = class(TForm)
    mailtext: TMemo;
    toolbarpanel: TPanel;
    anhanglist: TListBox;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    SpeedButton3: TSpeedButton;
    opendialog: TOpenDialog;
    betreffpanel: TPanel;
    betreff: TEdit;
    Label1: TLabel;
    procedure SaveSend(Sender: TObject);
    procedure SpeedButton3Click(Sender: TObject);
    procedure FormPaint(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure anhanglistKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure SpeedButton1Click(Sender: TObject);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  createnewmail: Tcreatenewmail;
  bearbeiten2: boolean=false;
  bsavefile: string='';

implementation

uses gtnewsletter05;

{$R *.dfm}

procedure Tcreatenewmail.SaveSend(Sender: TObject);
var inifile: TBiggerIniFile;
    localalist: TStrings;
    i, j: Integer;
    timestring: string;
begin
 if bearbeiten2 = true then
 begin
  inifile := TBiggerIniFile.Create(bsavefile);
  timestring := ExtractFileName(bsavefile);
  timestring := LeftStr(timestring, Ansipos('.ini', timestring)-1);
  bearbeiten2 := false;
 end
 else
 begin
  timestring := GetTimeString(1);
  ForceDirectories(ExtractFilePath(Application.ExeName) +
             'Konten\' + sectionglobal + '\Gesendet\');
  inifile := TBiggerIniFile.Create(ExtractFilePath(Application.ExeName) +
             'Konten\' + sectionglobal + '\Gesendet\' + (timestring+ '.ini') );
 end;

 inifile.WriteString('message', 'betreff', betreff.Text);
 mailtext.Lines.Delimiter := #254;
 mailtext.Lines.quotechar := #255;
 inifile.WriteString('message', 'body', mailtext.Lines.DelimitedText);
 inifile.WriteString('message', 'datum', GetTimeString(2));

 if anhanglist.Count > 0 then
 begin
  localalist := TStringList.Create;


  for j := 0 to dellistanhang.Count-1 do
  begin
   DeleteFile(dellistanhang.Strings[j]);
  end;

  for i := 0 to anhanglist.Count-1 do
  begin
   localalist.Add(ExtractFileName(anhanglist.Items.Strings[i]));
   //Verzeichnis erstellen
   ForceDirectories(ExtractFilePath(Application.ExeName) + 'Konten\' + sectionglobal + '\Gesendet\' + timestring + '\');

   // Anhangdatein Kopieren
   copyFile(PChar(anhanglist.Items.Strings[i]),
            PChar(
            ExtractFilePath(Application.ExeName) +
            'Konten\' + sectionglobal + '\Gesendet\' + timestring + '\' +  localalist.Strings[i])
            , true);
  end;

  inifile.WriteString('message', 'anhang', localalist.CommaText);

  localalist.Free;
 end;

 inifile.Free;

 reload3 := true;
 createnewmail.Close;
end;

procedure Tcreatenewmail.SpeedButton3Click(Sender: TObject);
Var anhang: TIdAttachmentFile;
begin
 if opendialog.Execute then
 begin
  anhanglist.Items.Add(opendialog.FileName);
  //TIdAttachment.Create(smtpmessage.MessageParts, opendialog.FileName);

  smtpmessage.IsEncoded:=true;
  anhang:=TIdAttachmentFile.Create(smtpmessage.MessageParts );
  anhang.StoredPathName:=opendialog.FileName;
  anhang.FileName:=opendialog.FileName;
  anhang.OpenLoadStream;
  anhang.CloseLoadStream;
 end;
end;

procedure Tcreatenewmail.FormPaint(Sender: TObject);
var bfilelist: TStrings;
    binifile: TBiggerIniFile;
    anhang: TStrings;
begin
betreff.Width := betreffpanel.Width-4;
anhanglist.Left := speedbutton3.Left + speedbutton3.Width + 4;
anhanglist.Width := createnewmail.Width - (anhanglist.Left + 12);

if bearbeiten = true then
begin
 createnewmail.Caption := 'Mail bearbeiten...';
               
 bfilelist := TStringList.Create;

 if bearbeitenges = true then
 begin
  GetFilesInDirectory(ExtractFilePath(Application.ExeName) +
                     'konten\'+sectionglobal+ '\Gesendet\', '*.ini', bfilelist, false);
 end
 else
 begin
  GetFilesInDirectory(ExtractFilePath(Application.ExeName) +
                     'konten\'+sectionglobal+ '\Entwurf\', '*.ini', bfilelist, false);
 end;

 binifile := TBiggerIniFile.Create(bfilelist.Strings[listindex]);
 bsavefile := bfilelist.Strings[listindex];

 betreff.Text := binifile.ReadString('message', 'betreff', '');

 mailtext.Lines.Delimiter := #254;
 mailtext.Lines.quotechar := #255;
 mailtext.Lines.DelimitedText := binifile.ReadString('message', 'body', '');

 // Anhang adden
 anhang := TStringList.Create;
 anhang.CommaText := binifile.ReadString('message', 'anhang', '');

 anhanglist.Items.AddStrings(anhang);
 anhang.Free;

 binifile.Free;
 bfilelist.Free;


 if bearbeitenges = false then bearbeiten2 := true;
 bearbeiten := false;
end
else createnewmail.Caption := 'Verfassen...';

betreff.SetFocus;
end;

procedure Tcreatenewmail.SpeedButton2Click(Sender: TObject);
var inifile: TBiggerIniFile;
    localalist: TStrings;
    i, j: Integer;
    timestring: string;
begin
 if bearbeiten2 = true then
 begin
  inifile := TBiggerIniFile.Create(bsavefile);
  timestring := ExtractFileName(bsavefile);
  timestring := LeftStr(timestring, Ansipos('.ini', timestring)-1);
  bearbeiten2 := false;
 end
 else
 begin
  timestring := GetTimeString(1);
  ForceDirectories(ExtractFilePath(Application.ExeName) +
             'Konten\' + sectionglobal + '\Entwurf\');
  inifile := TBiggerIniFile.Create(ExtractFilePath(Application.ExeName) +
             'Konten\' + sectionglobal + '\Entwurf\' + (timestring+ '.ini') );
 end;

 inifile.WriteString('message', 'betreff', betreff.Text);
 mailtext.Lines.Delimiter := #254;
 mailtext.Lines.quotechar := #255;
 inifile.WriteString('message', 'body', mailtext.Lines.DelimitedText);
 inifile.WriteString('message', 'datum', GetTimeString(2));

 if anhanglist.Count > 0 then
 begin
  localalist := TStringList.Create;


  for j := 0 to dellistanhang.Count-1 do
  begin
   DeleteFile(dellistanhang.Strings[j]);
  end;

  for i := 0 to anhanglist.Count-1 do
  begin
   localalist.Add(ExtractFileName(anhanglist.Items.Strings[i]));
   //Verzeichnis erstellen
   ForceDirectories(ExtractFilePath(Application.ExeName) + 'Konten\' + sectionglobal + '\Entwurf\' + timestring + '\');

   // Anhangdatein Kopieren
   copyFile(PChar(anhanglist.Items.Strings[i]),
            PChar(
            ExtractFilePath(Application.ExeName) +
            'Konten\' + sectionglobal + '\Entwurf\' + timestring + '\' +  localalist.Strings[i])
            , true);
  end;

  inifile.WriteString('message', 'anhang', localalist.CommaText);

  localalist.Free;
 end;

 inifile.Free;

 reload3 := true;
 createnewmail.Close;
end;

{

//struktur
konten
 20042223435504
  Entwürfe
   200442222345504.ini
    betreff=test123
    body= Hallo Leute
    anhang= "tes.zip", "zur.zpi"
    datum=24.06.2004

    //fehlerabfrage
    const
  cSep = ' - ';
var
  sSrc, sDest: string;
begin
  sSrc := 'D:\winscp.RND';
  sDest := 'D:\backup\winscp.RND' + cSep + DateToStr( Now );

  if not CopyFile( PChar(sSrc), PChar(sDest), true ) then begin
    MessageDlg( 'Could not copy file!'
              + #$A#$D
              + SysErrorMessage( GetLastError )
              , mtError, [mbOK], 0 );
  end;
end;

}

procedure Tcreatenewmail.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
dellistanhang.Clear;
anhanglist.Clear;
betreff.Clear;
mailtext.Clear;
end;

procedure Tcreatenewmail.anhanglistKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var mailfolder: string;
begin
 if key = vk_delete then
 begin
  mailfolder := LeftStr(mailglobal, ansipos('.ini', mailglobal)-1);
  if FileExists(mailfolder + '\' + anhanglist.Items[anhanglist.ItemIndex]) then
  begin
   dellistanhang.Add(mailfolder + '\' + anhanglist.Items[anhanglist.ItemIndex]);
  end;
  anhanglist.Items.Delete(anhanglist.ItemIndex);
 end;
end;

procedure Tcreatenewmail.SpeedButton1Click(Sender: TObject);
var inifile: TBiggerIniFile;
begin
 inifile := TBiggerIniFile.Create(ExtractFilePath(Application.ExeName) + 'konten.ini');

 sendmessage := true;

   with smtpmessage do begin
    Body.Assign(mailtext.Lines);
    // Name des Absenders
    From.Text := inifile.ReadString(sectionglobal, 'abs', '');
    //E-Mail-Adressen der Empfänger (durch Komma getrennt)
   // Recipients.EMailAddresses := rlist.CommaText;
    //Betreff (Subject) der Mail
    Subject := betreff.Text;
    //Priorität
    Priority := TIdMessagePriority(mpNormal);
    //E-Mail-Adressen der Kopie-Empfänger (CC=Carbon Copy)
    //CCList.EMailAddresses := edtCC.Text;
    //E-Mail-Adressen der versteckten Kopie-Empfänger (BCC=Blind Carbon  Copy)
    //BccList.EMailAddresses := edtBCC.Text;
  end;

   //Authentifizierung nötig?
 { case smtp.smSmtpAuthType of
    0: SMTP.AuthenticationType := atNone;
    1: SMTP.AuthenticationType := atLogin; Simple Login
   end;         }
 inifile.Free;

 mailsendform.showmodal();
 SaveSend(Sender);
 createnewmail.Close;
end;

end.
