unit Expu8;

interface

uses
  SysUtils, WinTypes, WinProcs, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, StdCtrls, ExtCtrls, Menus, expu1, expu9, expu6, expu12,
  expu13, expu10;

type
  Tflur = class(TForm)
    Image1: TImage;
    aufgabentext: TLabel;
    antwortb: TButton;
    antworta: TButton;
    ende: TButton;
    antwortc: TButton;
    procedure Button2Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure DasExperimentbeenden1Click(Sender: TObject);
    procedure Information1Click(Sender: TObject);
    procedure antwortcClick(Sender: TObject);
    procedure endeClick(Sender: TObject);
    procedure antwortaClick(Sender: TObject);
    procedure antwortbClick(Sender: TObject);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  flur: Tflur;

implementation

{$R *.DFM}

procedure Tflur.Button2Click(Sender: TObject);
begin
close;
end;

procedure Tflur.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if MessageDlg('Möchten sie das Spiel wirklich beenden?',
     mtConfirmation,
    [mbYes, mbNo], 0) = mrYes then
    Action := caFree
  else
    Action := caNone;
end;

procedure Tflur.FormCreate(Sender: TObject);
begin
{spielbeenden1.Visible := False; }
{spielbeenden1.Enabled:= False;}
end;

procedure Tflur.DasExperimentbeenden1Click(Sender: TObject);
begin
close;
end;

procedure Tflur.Information1Click(Sender: TObject);
begin
infobox.ShowModal;
end;

procedure Tflur.antwortcClick(Sender: TObject);
begin
expu9.rufehilfe.show;
end;

procedure Tflur.endeClick(Sender: TObject);
begin
close;
end;

procedure Tflur.antwortaClick(Sender: TObject);
begin
expu6.rib.show;
expu12.spritzen.show;
close;
end;

procedure Tflur.antwortbClick(Sender: TObject);
begin
expu10.raum.show;
expu13.befreiung.show;
close;
end;

end.
