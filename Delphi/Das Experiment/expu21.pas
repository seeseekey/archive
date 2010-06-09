unit Expu21;

interface

uses
  SysUtils, WinTypes, WinProcs, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, StdCtrls, ExtCtrls, Menus, expu1, expu24;

type
  Tschwarz = class(TForm)
    procedure Button2Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure DasExperimentbeenden1Click(Sender: TObject);
    procedure Information1Click(Sender: TObject);
    procedure FormClick(Sender: TObject);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  schwarz: Tschwarz;

implementation

{$R *.DFM}

procedure Tschwarz.Button2Click(Sender: TObject);
begin
close;
end;

procedure Tschwarz.FormClose(Sender: TObject; var Action: TCloseAction);
begin
expu24.fastend.show;
end;

procedure Tschwarz.FormCreate(Sender: TObject);
begin
{spielbeenden1.Visible := False; }
{spielbeenden1.Enabled:= False;}
end;

procedure Tschwarz.DasExperimentbeenden1Click(Sender: TObject);
begin
close;
end;

procedure Tschwarz.Information1Click(Sender: TObject);
begin
infobox.ShowModal;
end;

procedure Tschwarz.FormClick(Sender: TObject);
begin
expu24.fastend.show;
close;
end;

end.
