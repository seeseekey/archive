program gtBackup;

uses
  Forms,
  uFormMain in 'uFormMain.pas' {FormMain},
  uFormJob in 'uFormJob.pas' {FormJob},
  uGlobals in 'uGlobals.pas',
  uFormBackup in 'uFormBackup.pas' {FormBackup},
  uThreadBackup in 'uThreadBackup.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'gtBackup';
  Application.CreateForm(TFormMain, FormMain);
  Application.CreateForm(TFormJob, FormJob);
  Application.CreateForm(TFormBackup, FormBackup);
  Application.Run;
end.
