program stroto;

uses
  Forms,
  stroto00 in 'stroto00.pas' {mainform};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(Tmainform, mainform);
  Application.Run;
end.
