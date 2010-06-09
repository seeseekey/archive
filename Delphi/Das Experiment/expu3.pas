unit Expu3;

interface

uses WinTypes, WinProcs, Classes, Graphics, Forms, Controls, StdCtrls,
  Buttons, ExtCtrls;

type
  Twarten = class(TForm)
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
  warten: Twarten;

implementation

{$R *.DFM}

procedure Twarten.OKButtonClick(Sender: TObject);
begin
close;
end;

end.
 
