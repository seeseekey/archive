unit react00;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  _GClass, AbRMeter, AbHMeter, ExtCtrls, AbMTrend, AbDial, AbTank, AbVSlide,
  AbCBitBt, AbSwitch, AbBar, AbOpHour;

type
  Tmainform = class(TForm)
    temptoc: TAb270Meter;
    volttoc: TAbHMeter;
    trend: TAbMiniTrend;
    timer: TTimer;
    ze: TAbDial;
    rpp: TAbVSlider;
    tank: TAbTank;
    wzg: TAbDial;
    volta: TAbRockerSwitch;
    overload: TAbBar;
    ats: TAbToggleSwitch;
    waterr: TAbRockerSwitch;
    offe: TAbRockerSwitch;
    auls: TAbRockerSwitch;
    AbRockerSwitch2: TAbRockerSwitch;
    procedure timerTimer(Sender: TObject);
    procedure tankLimit(Sender: TObject; Lower, Upper: Boolean);
    procedure voltaClick(Sender: TObject);
    procedure AbColBitBtn1Click(Sender: TObject);
    procedure offeClick(Sender: TObject);
    procedure waterrClick(Sender: TObject);
    procedure AbRockerSwitch2Click(Sender: TObject);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  mainform: Tmainform;
  volto: real;
  water: longint;

implementation

{$R *.DFM}

procedure Tmainform.timerTimer(Sender: TObject);
begin
if overload.Value > 100 then timer.Enabled := false;

if ats.StatusInt = 1 then
begin
rpp.value := 100;
ze.value := 0;
wzg.value := 100;
end;

if auls.StatusInt = 1 then
begin
if overload.Value > 45 then ats.StatusInt := 1;
end;

trend.valuech1 := volttoc.value;

if random(2) = 1 then trend.valuech2 := 5000000 + random(5000000)
else trend.valuech2 := 5000000 - random(5000000);

temptoc.value := temptoc.value - (rpp.value * 1000);
temptoc.value := temptoc.value + (ze.value * 1000);

volttoc.value := volttoc.value - (rpp.value * 1000);
volttoc.value := volttoc.value + (ze.value * 1000);

if volttoc.value < 0 then volttoc.value := 0;

tank.Value := tank.Value - (rpp.value * 1000);
tank.Value := tank.Value + (wzg.value * 750) + water;

if volttoc.value > 10000000 then overload.Value := overload.Value + 1;
if temptoc.value > 10000000 then overload.Value := overload.Value + 1;

if overload.Value > 0 then
begin
if volttoc.value < 9000000 then if temptoc.value < 9000000 then overload.Value := overload.Value - 1;
//if temptoc.value < 9000000 then overload.Value := overload.Value - 1 - volto;
if volto > 0 then volttoc.value := volttoc.value - 10000;
end;

if overload.Value > 0 then overload.Value := overload.Value - volto;

if water > 0 then volttoc.value := volttoc.value - 40000;

if ze.Value < 15 then
begin
temptoc.value := temptoc.value - 1000;
volttoc.value := volttoc.value - 1000;
end

end;

procedure Tmainform.tankLimit(Sender: TObject; Lower, Upper: Boolean);
begin
rpp.Value := 0;
end;

procedure Tmainform.voltaClick(Sender: TObject);
begin
if waterr.StatusInt = 0 then water := water - 10000;
if waterr.StatusInt = 1 then water := water + 10000;
end;

procedure Tmainform.AbColBitBtn1Click(Sender: TObject);
begin
wzg.Value := 0;
end;

procedure Tmainform.offeClick(Sender: TObject);
begin
if offe.StatusInt = 0 then timer.Enabled := false;
if offe.StatusInt = 1 then timer.Enabled := true;
end;

procedure Tmainform.waterrClick(Sender: TObject);
begin
if waterr.StatusInt = 0 then water := 0;
if waterr.StatusInt = 1 then water := 10000;
end;

procedure Tmainform.AbRockerSwitch2Click(Sender: TObject);
begin
if waterr.StatusInt = 0 then volto := 0;
if waterr.StatusInt = 1 then volto := 0.5;
end;

end.
