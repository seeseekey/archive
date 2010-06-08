unit uFormJumpToLine;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Spin;

type
  TFormJumpToLine = class(TForm)
    Label1: TLabel;
    seLine: TSpinEdit;
    Button1: TButton;
    Button2: TButton;
    procedure Button2Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  FormJumpToLine: TFormJumpToLine;

implementation

{$R *.dfm}

uses uFormMain;

procedure TFormJumpToLine.Button2Click(Sender: TObject);
begin
  FormJumpToLine.Close;
end;

procedure TFormJumpToLine.Button1Click(Sender: TObject);
begin
  FormMain.SetCaretY(seLine.Value);
  FormJumpToLine.Close;
end;

procedure TFormJumpToLine.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_RETURN then
  begin
    Button1Click(Sender);
  end
  else if Key = VK_ESCAPE then
  begin
    Button2Click(Sender);
  end;
end;

end.
