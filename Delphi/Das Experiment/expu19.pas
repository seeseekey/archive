unit Expu19;

interface

uses WinTypes, WinProcs, Classes, Graphics, Forms, Controls, StdCtrls,
  Buttons, ExtCtrls, expu20;

type
  Theftigerschlag = class(TForm)
    Panel1: TPanel;
    OKButton: TBitBtn;
    Label1: TLabel;
    Label2: TLabel;
    procedure OKButtonClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  heftigerschlag: Theftigerschlag;

implementation

{$R *.DFM}

procedure Theftigerschlag.OKButtonClick(Sender: TObject);
begin
expu20.verschwommen.close;
close;
end;

end.
 
