unit Expu15;

interface

uses WinTypes, WinProcs, Classes, Graphics, Forms, Controls, StdCtrls,
  Buttons, ExtCtrls, expu14;

type
  Tschauzelle = class(TForm)
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
  schauzelle: Tschauzelle;

implementation

{$R *.DFM}

procedure Tschauzelle.OKButtonClick(Sender: TObject);
begin
expu14.zelle.close;
close;
end;

end.
 
