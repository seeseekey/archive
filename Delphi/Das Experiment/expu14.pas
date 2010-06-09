unit Expu14;

interface

uses
  SysUtils, WinTypes, WinProcs, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, StdCtrls, ExtCtrls, Menus, expu1;

type
  Tzelle = class(TForm)
    Image1: TImage;
    procedure Button2Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure DasExperimentbeenden1Click(Sender: TObject);
    procedure Information1Click(Sender: TObject);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  zelle: Tzelle;

implementation

{$R *.DFM}

procedure Tzelle.Button2Click(Sender: TObject);
begin
close;
end;

procedure Tzelle.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if MessageDlg('Möchten sie das Spiel wirklich beenden?',
     mtConfirmation,
    [mbYes, mbNo], 0) = mrYes then
    Action := caFree
  else
    Action := caNone;
end;

procedure Tzelle.FormCreate(Sender: TObject);
begin
{spielbeenden1.Visible := False; }
{spielbeenden1.Enabled:= False;}
end;

procedure Tzelle.DasExperimentbeenden1Click(Sender: TObject);
begin
close;
end;

procedure Tzelle.Information1Click(Sender: TObject);
begin
infobox.ShowModal;
end;

end.
