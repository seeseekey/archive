program reactor;

uses
  Forms,
  react00 in 'react00.pas' {mainform};

{$R *.RES}

begin
  Application.Initialize;
  Application.Title := 'NET REACT';
  Application.CreateForm(Tmainform, mainform);
  Application.Run;
end.
