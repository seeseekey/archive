program gtmuehle;

uses
  Forms,
  uFormMain in 'uFormMain.pas' {FormMain},
  muehle in 'muehle.pas',
  uFormGameNew in 'uFormGameNew.pas' {FormGameNew},
  uFormOptions in 'uFormOptions.pas' {FormOptions},
  gtmuehle04 in 'gtmuehle04.pas',
  uFormAbout in 'uFormAbout.pas' {FormAbout},
  uFormNetworkConnect in 'uFormNetworkConnect.pas' {FormNetworkConnect};

{$R *.RES}

begin
  Application.Initialize;
  Application.Title := 'gtMühle';
  Application.CreateForm(TFormMain, FormMain);
  Application.CreateForm(TFormGameNew, FormGameNew);
  Application.CreateForm(TFormOptions, FormOptions);
  Application.CreateForm(TFormAbout, FormAbout);
  Application.CreateForm(TFormNetworkConnect, FormNetworkConnect);
  Application.Run;
end.
