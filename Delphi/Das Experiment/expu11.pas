unit Expu11;

interface

uses WinTypes, WinProcs, Classes, Graphics, Forms, Controls, StdCtrls,
  Buttons, ExtCtrls;

type
  Tkurzschluss = class(TForm)
    Panel1: TPanel;
    OKButton: TBitBtn;
    ProductName: TLabel;
    Label1: TLabel;
    procedure OKButtonClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  kurzschluss: Tkurzschluss;

implementation

{$R *.DFM}

procedure Tkurzschluss.OKButtonClick(Sender: TObject);
begin
close;
end;

end.
 
