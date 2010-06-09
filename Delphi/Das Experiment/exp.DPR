program Exp;

uses
  Forms,
  Expu0 in 'EXPU0.PAS' {startwindow},
  Expu1 in 'EXPU1.PAS' {infobox},
  Expu2 in 'EXPU2.PAS' {gamestart},
  Expu3 in 'EXPU3.PAS' {warten},
  Expu4 in 'EXPU4.PAS' {schaltkasten},
  Expu5 in 'EXPU5.PAS' {readkasten},
  Expu6 in 'EXPU6.PAS' {rib},
  Expu7 in 'EXPU7.PAS' {stromschlag},
  Expu8 in 'EXPU8.PAS' {flur},
  Expu9 in 'EXPU9.PAS' {rufehilfe},
  Expu10 in 'EXPU10.PAS' {raum},
  Expu11 in 'EXPU11.PAS' {kurzschluss},
  Expu12 in 'EXPU12.PAS' {spritzen},
  Expu13 in 'EXPU13.PAS' {befreiung},
  Expu14 in 'EXPU14.PAS' {zelle},
  Expu15 in 'EXPU15.PAS' {schauzelle},
  Expu16 in 'EXPU16.PAS' {notopendoor},
  Expu17 in 'EXPU17.PAS' {terminal},
  Expu18 in 'EXPU18.PAS' {gameterminal},
  Expu19 in 'EXPU19.PAS' {heftigerschlag},
  Expu20 in 'EXPU20.PAS' {verschwommen},
  Expu21 in 'EXPU21.PAS' {schwarz},
  Expu22 in 'EXPU22.PAS' {schwarzauge},
  Expu23 in 'EXPU23.PAS' {fnv},
  Expu24 in 'EXPU24.PAS' {fastend},
  Expu25 in 'EXPU25.PAS' {theend};

{$R *.RES}

begin
  Application.Title := 'Das Experiment';
  Application.CreateForm(Tstartwindow, startwindow);
  Application.CreateForm(Tinfobox, infobox);
  Application.CreateForm(Tgamestart, gamestart);
  Application.CreateForm(Twarten, warten);
  Application.CreateForm(Tschaltkasten, schaltkasten);
  Application.CreateForm(Treadkasten, readkasten);
  Application.CreateForm(Trib, rib);
  Application.CreateForm(Tstromschlag, stromschlag);
  Application.CreateForm(Tflur, flur);
  Application.CreateForm(Trufehilfe, rufehilfe);
  Application.CreateForm(Traum, raum);
  Application.CreateForm(Tkurzschluss, kurzschluss);
  Application.CreateForm(Tspritzen, spritzen);
  Application.CreateForm(Tbefreiung, befreiung);
  Application.CreateForm(Tzelle, zelle);
  Application.CreateForm(Tschauzelle, schauzelle);
  Application.CreateForm(Tnotopendoor, notopendoor);
  Application.CreateForm(Tterminal, terminal);
  Application.CreateForm(Tgameterminal, gameterminal);
  Application.CreateForm(Theftigerschlag, heftigerschlag);
  Application.CreateForm(Tverschwommen, verschwommen);
  Application.CreateForm(Tschwarz, schwarz);
  Application.CreateForm(Tschwarzauge, schwarzauge);
  Application.CreateForm(Tfnv, fnv);
  Application.CreateForm(Tfastend, fastend);
  Application.CreateForm(Ttheend, theend);
  Application.Run;
end.
