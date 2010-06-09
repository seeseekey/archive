unit Expu10;

interface

uses
  SysUtils, WinTypes, WinProcs, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, StdCtrls, ExtCtrls, Menus, expu1, expu14, expu15,
  expu16, expu17;

type
  Traum = class(TForm)
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
    procedure endeClick(Sender: TObject);
    procedure antwortcClick(Sender: TObject);
    procedure antwortbClick(Sender: TObject);
    procedure antwortaClick(Sender: TObject);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  raum: Traum;

implementation

{$R *.DFM}

procedure Traum.Button2Click(Sender: TObject);
begin
close;
end;

procedure Traum.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if MessageDlg('Möchten sie das Spiel wirklich beenden?',
     mtConfirmation,
    [mbYes, mbNo], 0) = mrYes then
    Action := caFree
  else
    Action := caNone;
end;

procedure Traum.FormCreate(Sender: TObject);
begin
{spielbeenden1.Visible := False; }
{spielbeenden1.Enabled:= False;}
end;

procedure Traum.DasExperimentbeenden1Click(Sender: TObject);
begin
close;
end;

procedure Traum.Information1Click(Sender: TObject);
begin
infobox.ShowModal;
end;

procedure Traum.endeClick(Sender: TObject);
begin
close;
end;

procedure Traum.antwortcClick(Sender: TObject);
begin
expu14.zelle.show;
expu15.schauzelle.show;
end;

procedure Traum.antwortbClick(Sender: TObject);
begin
expu16.notopendoor.show;
end;

procedure Traum.antwortaClick(Sender: TObject);
begin
expu17.terminal.show;
close;
end;

end.
