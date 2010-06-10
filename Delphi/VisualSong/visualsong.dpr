program visualsong;

uses
  Forms,
  vs00 in 'vs00.pas' {mainform};

{$R *.RES}

begin
  Application.Initialize;
  Application.Title := 'Visual Song';
  Application.CreateForm(Tmainform, mainform);
  Application.Run;
end.
