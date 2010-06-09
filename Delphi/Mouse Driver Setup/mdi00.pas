unit mdi00;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ComCtrls, ExtCtrls;

type
  TForm1 = class(TForm)
    Image1: TImage;
    Label1: TLabel;
    pb: TProgressBar;
    Button1: TButton;
    Button2: TButton;
    Timer1: TTimer;
    procedure Button2Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  Form1: TForm1;

implementation

uses mdi01;

{$R *.DFM}

procedure TForm1.Button2Click(Sender: TObject);
begin
close;
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
timer1.Enabled := true;
end;

procedure TForm1.Timer1Timer(Sender: TObject);
begin
pb.Position := pb.Position + 1;

if pb.Position > 70 then
begin
 form2.show;
 timer1.Enabled := false;
end;
end;

end.
