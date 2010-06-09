unit Expu20;

interface

uses
  SysUtils, WinTypes, WinProcs, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, StdCtrls, ExtCtrls, Menus, expu1, expu21, expu22;

type
  Tverschwommen = class(TForm)
    Image1: TImage;
    procedure Button2Click(Sender: TObject);
    procedure sys(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure DasExperimentbeenden1Click(Sender: TObject);
    procedure Information1Click(Sender: TObject);
    procedure FormClick(Sender: TObject);
    procedure Image1Click(Sender: TObject);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  verschwommen: Tverschwommen;

implementation

{$R *.DFM}

procedure Tverschwommen.Button2Click(Sender: TObject);
begin
close;
end;

procedure Tverschwommen.sys(Sender: TObject; var Action: TCloseAction);
begin
 expu21.schwarz.show;
expu22.schwarzauge.show;
end;

procedure Tverschwommen.FormCreate(Sender: TObject);
begin
{spielbeenden1.Visible := False; }
{spielbeenden1.Enabled:= False;}
end;

procedure Tverschwommen.DasExperimentbeenden1Click(Sender: TObject);
begin
close;
end;

procedure Tverschwommen.Information1Click(Sender: TObject);
begin
infobox.ShowModal;
end;

procedure Tverschwommen.FormClick(Sender: TObject);
begin
expu21.schwarz.show;
expu22.schwarzauge.show;
close;
end;

procedure Tverschwommen.Image1Click(Sender: TObject);
begin
expu21.schwarz.show;
expu22.schwarzauge.show;
close;
end;

end.
