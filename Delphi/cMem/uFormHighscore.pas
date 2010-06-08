unit uFormHighscore;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, uGlobals;

type
  TFormHighscore = class(TForm)
    Highscore: TLabel;
    reHsNames: TRichEdit;
    btnOK: TButton;
    reHsPoints: TRichEdit;
    procedure FormShow(Sender: TObject);
    procedure btnOKClick(Sender: TObject);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  FormHighscore: TFormHighscore;

implementation

{$R *.dfm}

procedure TFormHighscore.FormShow(Sender: TObject);
var name: string;
    points: Integer;
    i: Integer;
begin
  reHsPoints.Clear;
  reHsNames.Clear;

  reHsNames.SelAttributes.Style := [fsBold];
  reHsPoints.SelAttributes.Style := [fsBold];

  reHsNames.Lines.Add('Name');
  reHsPoints.Lines.Add('Punkte');

  reHsNames.SelAttributes.Style := [];
  reHsPoints.SelAttributes.Style := [];

  for i:=0 to myHighscore.Count-1  do
  begin
    myHighscore.GetEntry(name, points, i);
    reHsNames.Lines.Add(name);
    reHsPoints.Lines.Add(IntToStr(points));
  end;
end;

procedure TFormHighscore.btnOKClick(Sender: TObject);
begin
  FormHighscore.Close;
end;

end.
