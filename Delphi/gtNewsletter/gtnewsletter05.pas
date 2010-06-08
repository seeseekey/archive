unit gtnewsletter05;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, StdCtrls, IdComponent, IdTCPConnection, IdTCPClient,
  IdMessageClient, IdSMTP, globals, bigini, ExtCtrls, IdExplicitTLSClientServerBase,
  IdSMTPBase, IdBaseComponent, IdAntiFreeze, IdAntiFreezeBase;


type
  Tmailsendform = class(TForm)
    mailstatus: TLabel;
    fortschritt: TProgressBar;
    Timer1: TTimer;
    IdAntiFreeze1: TIdAntiFreeze;
    smtp: TIdSMTP;
    procedure FormShow(Sender: TObject);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  mailsendform: Tmailsendform;

implementation

{$R *.dfm}

procedure Tmailsendform.FormShow(Sender: TObject);
var inifile: TBiggerIniFile;
    rlist: TStrings;
    i: integer;
begin
 if sendmessage = true then
 begin
  inifile := TBiggerIniFile.Create(ExtractFilePath(Application.ExeName) + 'konten.ini');
  rlist := TStringList.Create;

  rlist.LoadFromFile(ExtractFilePath(Application.ExeName) + 'konten\'+sectionglobal+'\receivers.gtl');
  fortschritt.Max := rlist.Count;
  fortschritt.Position := 0;

  sendmessage := false;
  SMTP.AuthType := atDefault; {Simple Login}

  //Benutzerdaten für Authentifizierung
  SMTP.Username  := inifile.ReadString(sectionglobal, 'benutzername', '');
  SMTP.Password := inifile.ReadString(sectionglobal, 'password', '');

  //Server-Daten
  SMTP.Host :=  inifile.ReadString(sectionglobal, 'smtpserver', '');
  SMTP.Port := StrtoInt(inifile.ReadString(sectionglobal, 'smtpport', ''));

  SMTP.Connect;

  try
   for i := 0 to rlist.Count-1 do
   begin
    //mailstatus.Caption := 'Sende Mail an Mailempfänger Nr. ' + InttoStr(i+1) +
    //                      ' (' + rlist.strings[i]+')';
    smtpmessage.Recipients.EMailAddresses := rlist.Strings[i];
    SMTP.Send(smtpmessage);
    fortschritt.Position := fortschritt.Position + 1;
   end;
  finally
    rlist.free;
    inifile.free;
    SMTP.Disconnect;
    //mailstatus.Caption := 'Bereite Mailversand vor...';
    mailsendform.Close;
  end;
 end;
end;

end.
