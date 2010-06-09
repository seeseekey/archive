program mda;

uses
  Forms,
  gttdrcl00 in 'gttdrcl00.pas' {mainform},
  gttdrcl01 in 'gttdrcl01.pas' {childform00},
  globals in 'globals.pas',
  gttdrcl02 in 'gttdrcl02.pas' {childform01},
  gttdrcl03 in 'gttdrcl03.pas' {mainsearchform};

{$R *.RES}

begin
  Application.Initialize;
  Application.Title := 'Movie Disc Administration';
  Application.HelpFile := '';
  Application.CreateForm(Tmainform, mainform);
  Application.CreateForm(Tchildform00, childform00);
  Application.CreateForm(Tchildform01, childform01);
  Application.CreateForm(Tmainsearchform, mainsearchform);
  Application.Run;
end.
