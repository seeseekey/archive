program tc;

uses
  Forms,
  tc01 in 'tc01.pas' {FormMain},
  tc02 in 'tc02.pas' {FormDefine},
  globals in 'globals.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'TimeChanger';
  Application.CreateForm(TFormMain, FormMain);
  Application.CreateForm(TFormDefine, FormDefine);
  Application.ShowMainForm:= false;
  Application.Run;
end.
