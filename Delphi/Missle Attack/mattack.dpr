program mattack;

uses
  Forms,
  uFormMain in 'uFormMain.pas' {FormMain},
  uFormNewGame in 'uFormNewGame.pas' {FormNewGame},
  uFormAbout in 'uFormAbout.pas' {FormAbout};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'Missle Attack';
  Application.CreateForm(TFormMain, FormMain);
  Application.CreateForm(TFormNewGame, FormNewGame);
  Application.CreateForm(TFormAbout, FormAbout);
  Application.Run;
end.
