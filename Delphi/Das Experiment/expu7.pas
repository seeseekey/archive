unit Expu7;

interface

uses WinTypes, WinProcs, Classes, Graphics, Forms, Controls, StdCtrls,
  Buttons, ExtCtrls, expu6;

type
  Tstromschlag = class(TForm)
    Panel1: TPanel;
    OKButton: TBitBtn;
    ProductName: TLabel;
    procedure dieandclose(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  stromschlag: Tstromschlag;

implementation

{$R *.DFM}

procedure Tstromschlag.dieandclose(Sender: TObject);
begin
expu6.rib.show;
close;
end;

end.

