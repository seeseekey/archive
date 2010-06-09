unit Expu4;

interface

uses
  SysUtils, WinTypes, WinProcs, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, StdCtrls, ExtCtrls, Menus, expu1, expu7, expu5, expu10,
  expu11;

type
  Tschaltkasten = class(TForm)
    Image1: TImage;
    aufgabentext: TLabel;
    antwortc: TButton;
    antwortb: TButton;
    antworta: TButton;
    ende: TButton;
    procedure Button2Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure DasExperimentbeenden1Click(Sender: TObject);
    procedure Information1Click(Sender: TObject);
    procedure antwortcClick(Sender: TObject);
    procedure endeClick(Sender: TObject);
    procedure antwortbClick(Sender: TObject);
    procedure antwortaClick(Sender: TObject);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  schaltkasten: Tschaltkasten;

implementation

{$R *.DFM}

procedure Tschaltkasten.Button2Click(Sender: TObject);
begin
close;
end;

procedure Tschaltkasten.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if MessageDlg('Möchten sie das Spiel wirklich beenden?',
     mtConfirmation,
    [mbYes, mbNo], 0) = mrYes then
    Action := caFree
  else
    Action := caNone;
end;

procedure Tschaltkasten.FormCreate(Sender: TObject);
begin
{spielbeenden1.Visible := False; }
{spielbeenden1.Enabled:= False;}
end;

procedure Tschaltkasten.DasExperimentbeenden1Click(Sender: TObject);
begin
close;
end;

procedure Tschaltkasten.Information1Click(Sender: TObject);
begin
infobox.ShowModal;
end;

procedure Tschaltkasten.antwortcClick(Sender: TObject);
begin
expu5.readkasten.show;
end;

procedure Tschaltkasten.endeClick(Sender: TObject);
begin
close;
end;

procedure Tschaltkasten.antwortbClick(Sender: TObject);
begin
expu6.rib.show;
expu7.stromschlag.show;
close;
end;

procedure Tschaltkasten.antwortaClick(Sender: TObject);
begin
expu10.raum.show;
expu11.kurzschluss.show;
close;
end;

end.
