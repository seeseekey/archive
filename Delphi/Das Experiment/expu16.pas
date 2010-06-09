unit Expu16;

interface

uses WinTypes, WinProcs, Classes, Graphics, Forms, Controls, StdCtrls,
  Buttons, ExtCtrls;

type
  Tnotopendoor = class(TForm)
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
  notopendoor: Tnotopendoor;

implementation

{$R *.DFM}

procedure Tnotopendoor.OKButtonClick(Sender: TObject);
begin
close;
end;

end.
 
