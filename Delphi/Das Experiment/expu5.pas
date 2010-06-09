unit Expu5;

interface

uses WinTypes, WinProcs, Classes, Graphics, Forms, Controls, StdCtrls,
  Buttons, ExtCtrls;

type
  Treadkasten = class(TForm)
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
  readkasten: Treadkasten;

implementation

{$R *.DFM}

procedure Treadkasten.OKButtonClick(Sender: TObject);
begin
close;
end;

end.
 
