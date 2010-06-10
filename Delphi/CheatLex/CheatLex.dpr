program cheatLex;

uses
  Forms,
  clxu1 in 'clxu1.pas' {mainform},
  Clxu3 in 'Clxu3.pas',
  Clxu4 in 'Clxu4.pas' {N64},
  Clxu2 in 'Clxu2.pas' {viewer},
  Clxu5 in 'Clxu5.pas' {PC},
  Clxu6 in 'Clxu6.pas' {SNES},
  Clxu7 in 'Clxu7.pas' {GB},
  Clxu8 in 'Clxu8.pas' {PS},
  Clxu9 in 'Clxu9.pas' {PS2},
  Clxu10 in 'Clxu10.pas' {DC},
  Clxu11 in 'Clxu11.pas' {C64},
  Clxu12 in 'Clxu12.pas' {amiga},
  Clxu13 in 'Clxu13.pas' {MD},
  Clxu14 in 'Clxu14.pas' {saturn},
  Clxu15 in 'Clxu15.pas' {xbox},
  Clxu16 in 'Clxu16.pas' {atarijaguar},
  clxu18 in 'clxu18.pas' {gamecube},
  Clxu17 in 'clxu17.pas' {nintendo},
  clxu19 in 'clxu19.pas' {optionen},
  clxu20 in 'clxu20.pas' {Ueber},
  clxu21 in 'clxu21.pas' {palmpilot};

{$R *.RES}

begin
  Application.Initialize;
  Application.Title := 'CheatLex';
  Application.HelpFile := 'G:\Delphi 3\PROJECTE\CheatLex\CheatLex.hlp';
  Application.CreateForm(Tmainform, mainform);
  Application.CreateForm(TN64, N64);
  Application.CreateForm(TPC, PC);
  Application.CreateForm(TSNES, SNES);
  Application.CreateForm(TGB, GB);
  Application.CreateForm(TPS, PS);
  Application.CreateForm(TPS2, PS2);
  Application.CreateForm(TDC, DC);
  Application.CreateForm(TC64, C64);
  Application.CreateForm(Tamiga, amiga);
  Application.CreateForm(TMD, MD);
  Application.CreateForm(Tsaturn, saturn);
  Application.CreateForm(Txbox, xbox);
  Application.CreateForm(Tatarijaguar, atarijaguar);
  Application.CreateForm(Tgamecube, gamecube);
  Application.CreateForm(Tnintendo, nintendo);
  Application.CreateForm(Toptionen, optionen);
  Application.CreateForm(TUeber, Ueber);
  Application.CreateForm(Tpalmpilot, palmpilot);
  Application.Run;
end.
