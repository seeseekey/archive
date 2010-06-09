unit Expu12;

interface

uses WinTypes, WinProcs, Classes, Graphics, Forms, Controls, StdCtrls,
  Buttons, ExtCtrls;

type
  Tspritzen = class(TForm)
    Panel1: TPanel;
    OKButton: TBitBtn;
    ProductName: TLabel;
    procedure OKButtonClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  spritzen: Tspritzen;

implementation

{$R *.DFM}

procedure Tspritzen.OKButtonClick(Sender: TObject);
begin
close;
end;

end.
 
