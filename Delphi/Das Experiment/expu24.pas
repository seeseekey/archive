unit Expu24;

interface

uses
  SysUtils, WinTypes, WinProcs, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, StdCtrls, ExtCtrls, Menus, expu1, expu25;

type
  Tfastend = class(TForm)
    Image1: TImage;
    procedure Button2Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure DasExperimentbeenden1Click(Sender: TObject);
    procedure Information1Click(Sender: TObject);
    procedure Image1Click(Sender: TObject);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  fastend: Tfastend;

implementation

{$R *.DFM}

procedure Tfastend.Button2Click(Sender: TObject);
begin
close;
end;

procedure Tfastend.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if MessageDlg('Möchten sie das Spiel wirklich beenden?',
     mtConfirmation,
    [mbYes, mbNo], 0) = mrYes then
    Action := caFree
  else
    Action := caNone;
end;

procedure Tfastend.FormCreate(Sender: TObject);
begin
{spielbeenden1.Visible := False; }
{spielbeenden1.Enabled:= False;}
end;

procedure Tfastend.DasExperimentbeenden1Click(Sender: TObject);
begin
close;
end;

procedure Tfastend.Information1Click(Sender: TObject);
begin
infobox.ShowModal;
end;

procedure Tfastend.Image1Click(Sender: TObject);
begin
expu25.theend.show;
close;
end;

end.
