program Lostis;

uses
  Forms,
  Lishu in 'LISHU.PAS' {Form1},
  Jeridia in 'JERIDIA.PAS' {MultPageDlg},
  Info in 'INFO.PAS' {AboutBox},
  Lissgv in 'LISSGV.PAS';

{$R *.RES}

begin
  Application.Title := 'Lost in Space';
  Application.Title := 'Lost in Space';
  Application.HelpFile := 'D:\DELPHI\LISHD.HLP';
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TMultPageDlg, MultPageDlg);
  Application.CreateForm(TAboutBox, AboutBox);
  Application.Run;
end.
