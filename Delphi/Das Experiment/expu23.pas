unit Expu23;

interface

uses WinTypes, WinProcs, Classes, Graphics, Forms, Controls, StdCtrls,
  Buttons, ExtCtrls;

type
  Tfnv = class(TForm)
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
  fnv: Tfnv;

implementation

{$R *.DFM}

procedure Tfnv.OKButtonClick(Sender: TObject);
begin
close;
end;

end.
 
