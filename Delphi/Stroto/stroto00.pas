unit stroto00;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, StdCtrls;

type
  Tmainform = class(TForm)
    maintimer: TTimer;
    mainlabel: TLabel;
    procedure maintimerTimer(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  mainform: Tmainform;

implementation

{$R *.DFM}

procedure Tmainform.maintimerTimer(Sender: TObject);
begin
mainlabel.Caption := 'Speed: ' + inttostr(maintimer.interval);
if mainform.Color = clWhite then
 begin
      maintimer.interval := maintimer.Interval - 50;
      mainform.Color := clBlack;
 end
else
 begin
      maintimer.interval := maintimer.Interval + 50;
      mainform.Color := clWhite;
 end;


end;

procedure Tmainform.FormCreate(Sender: TObject);
begin
mainform.DoubleBuffered := true;
end;

procedure Tmainform.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
if (Key=VK_F8) then
  begin
  maintimer.Interval := maintimer.Interval + 10;
  mainlabel.Caption := 'Speed: ' + inttostr(maintimer.interval);
  end
else if (Key=VK_F9) then
  begin
  maintimer.Interval := maintimer.Interval - 10;
  mainlabel.Caption := 'Speed: ' + inttostr(maintimer.interval);
  end
end;

end.
