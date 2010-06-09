program spesyn;

uses
  Forms,
  spesyn00 in 'spesyn00.pas' {mainform};

{$R *.RES}

begin
  Application.Initialize;
  Application.Title := 'Speech Synthesis';
  Application.CreateForm(Tmainform, mainform);
  Application.Run;
end.
