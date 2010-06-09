unit Expu13;

interface

uses WinTypes, WinProcs, Classes, Graphics, Forms, Controls, StdCtrls,
  Buttons, ExtCtrls;

type
  Tbefreiung = class(TForm)
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
  befreiung: Tbefreiung;

implementation

{$R *.DFM}

procedure Tbefreiung.OKButtonClick(Sender: TObject);
begin
close;
end;

end.
 
