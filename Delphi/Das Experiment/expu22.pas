unit Expu22;

interface

uses WinTypes, WinProcs, Classes, Graphics, Forms, Controls, StdCtrls,
  Buttons, ExtCtrls, expu21;

type
  Tschwarzauge = class(TForm)
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
  schwarzauge: Tschwarzauge;

implementation

{$R *.DFM}

procedure Tschwarzauge.OKButtonClick(Sender: TObject);
begin
expu21.schwarz.close;
close;
end;

end.
 
