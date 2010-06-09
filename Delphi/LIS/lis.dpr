program lis;

uses
  Forms,
  lis00 in 'lis00.pas' {mainform};

{$R *.RES}

begin
  Application.Initialize;
  Application.Title := 'AI LIS';
  Application.CreateForm(Tmainform, mainform);
  Application.Run;
end.
