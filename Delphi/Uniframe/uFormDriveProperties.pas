unit uFormDriveProperties;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TFormDriveProperties = class(TForm)
    MemoProperty: TMemo;
    BtnOkay: TButton;
    procedure BtnOkayClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  FormDriveProperties: TFormDriveProperties;

implementation

{$R *.dfm}

procedure TFormDriveProperties.BtnOkayClick(Sender: TObject);
begin
  FormDriveProperties.Close;
end;

procedure TFormDriveProperties.FormShow(Sender: TObject);
begin
  BtnOkay.SetFocus;
end;

end.
