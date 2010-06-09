unit Expu6;

interface

uses
  SysUtils, WinTypes, WinProcs, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, StdCtrls, ExtCtrls, Menus, expu1;

type
  Trib = class(TForm)
    Image1: TImage;
    Label1: TLabel;
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
  rib: Trib;

implementation

{$R *.DFM}

procedure Trib.Button2Click(Sender: TObject);
begin
close;
end;

procedure Trib.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if MessageDlg('Möchten sie das Spiel wirklich beenden?',
     mtConfirmation,
    [mbYes, mbNo], 0) = mrYes then
    Action := caFree
  else
    Action := caNone;
end;

procedure Trib.FormCreate(Sender: TObject);
begin
{spielbeenden1.Visible := False; }
{spielbeenden1.Enabled:= False;}
end;

procedure Trib.DasExperimentbeenden1Click(Sender: TObject);
begin
close;
end;

procedure Trib.Information1Click(Sender: TObject);
begin
infobox.ShowModal;
end;

procedure Trib.Image1Click(Sender: TObject);
begin
close;
end;

end.
