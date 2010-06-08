program cMem;

uses
  Forms,
  uFormMain in 'uFormMain.pas' {FormMain},
  uFormAbout in 'uFormAbout.pas' {FormAbout},
  uFormHighscore in 'uFormHighscore.pas' {FormHighscore},
  uGlobals in 'uGlobals.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'cMem';
  Application.CreateForm(TFormMain, FormMain);
  Application.CreateForm(TFormAbout, FormAbout);
  Application.CreateForm(TFormHighscore, FormHighscore);
  Application.Run;
end.
