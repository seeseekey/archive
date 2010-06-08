program gtnewsletter;

uses
  Forms,
  uFormMain in 'uFormMain.pas' {FormMain},
  uFormAbout in 'uFormAbout.pas' {FormAbout},
  gtnewsletter01 in 'gtnewsletter01.pas' {createkontoform},
  globals in 'globals.pas',
  gtnewsletter02 in 'gtnewsletter02.pas' {editrecievers},
  gtnewsletter03 in 'gtnewsletter03.pas' {createnewmail},
  gtnewsletter04 in 'gtnewsletter04.pas' {sendmails},
  gtnewsletter05 in 'gtnewsletter05.pas' {mailsendform};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'GT Newsletter';
  Application.CreateForm(TFormMain, FormMain);
  Application.CreateForm(TFormAbout, FormAbout);
  Application.CreateForm(Tcreatekontoform, createkontoform);
  Application.CreateForm(Teditrecievers, editrecievers);
  Application.CreateForm(Tcreatenewmail, createnewmail);
  Application.CreateForm(Tsendmails, sendmails);
  Application.CreateForm(Tmailsendform, mailsendform);
  Application.Run;
end.
