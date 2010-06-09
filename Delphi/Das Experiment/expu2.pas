unit Expu2;

interface

uses
  SysUtils, WinTypes, WinProcs, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, StdCtrls, ExtCtrls, Menus, expu1, expu3, expu4, expu8;

type
  Tgamestart = class(TForm)
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
  gamestart: Tgamestart;

implementation

{$R *.DFM}

procedure Tgamestart.Button2Click(Sender: TObject);
begin
close;
end;

procedure Tgamestart.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if MessageDlg('Möchten sie das Spiel wirklich beenden?',
     mtConfirmation,
    [mbYes, mbNo], 0) = mrYes then
    Action := caFree
  else
    Action := caNone;
end;

procedure Tgamestart.FormCreate(Sender: TObject);
begin
{spielbeenden1.Visible := False; }
{spielbeenden1.Enabled:= False;}
end;

procedure Tgamestart.DasExperimentbeenden1Click(Sender: TObject);
begin
close;
end;

procedure Tgamestart.Information1Click(Sender: TObject);
begin
infobox.ShowModal;
end;

procedure Tgamestart.antwortcClick(Sender: TObject);
begin
expu3.warten.show;
end;

procedure Tgamestart.endeClick(Sender: TObject);
begin
close;
end;

procedure Tgamestart.antwortbClick(Sender: TObject);
begin
expu4.schaltkasten.show;
close;
end;

procedure Tgamestart.antwortaClick(Sender: TObject);
begin
expu8.flur.show;
close;
end;

end.
