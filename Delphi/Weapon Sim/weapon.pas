unit weapon;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, LED, ExtCtrls;

type
  TForm1 = class(TForm)
    LED1: TLED;
    LED2: TLED;
    Label1: TLabel;
    Button1: TButton;
    Button2: TButton;
    Label2: TLabel;
    stadtname: TEdit;
    Label3: TLabel;
    ezahl: TEdit;
    RadioGroup1: TRadioGroup;
    RadioButton1: TRadioButton;
    RadioButton2: TRadioButton;
    RadioButton3: TRadioButton;
    RadioButton4: TRadioButton;
    RadioButton5: TRadioButton;
    RadioButton6: TRadioButton;
    Timer1: TTimer;
    GroupBox1: TGroupBox;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Button3: TButton;
    Label9: TLabel;
    Image1: TImage;
    procedure Timer1Timer(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  Form1: TForm1;
  restart :boolean;

implementation

{$R *.DFM}

procedure TForm1.Timer1Timer(Sender: TObject);
var
ez :longint;
tz :longint;
effekt :longint;
begin

if restart = true then
begin
 timer1.Enabled := false;
 MessageDlg('System muss erst gerestarten werden!', mtInformation, [mbOk], 0)
end
 else
begin
if stadtname.text = '' then
 begin
  timer1.Enabled := false;
  MessageDlg('Das Feld Stadtname ist leer.', mtInformation, [mbOk], 0);
 end
else
 begin
  if ezahl.text = '' then
   begin
    timer1.Enabled := false;
    MessageDlg('Das Feld Einwohnerzahl ist leer.', mtInformation, [mbOk], 0)
   end
  else
   begin

if led2.Number = 0 then
 begin
  if led1.number = 0 then
   begin

    if led2.number = 0  then
     begin
      timer1.Enabled := false;
      image1.Visible := false;
       if radiobutton1.Checked = true then
        begin
         ez := strtoint(ezahl.text);
         tz := ez;
         ez := ez - 50;
         ez := ez - Random(200);
         if ez < 1 then  ez := 0
         else if strtoint(ezahl.text) < ez then ez := 0
         else tz := tz - ez;
        end;

       if radiobutton2.Checked = true then
        begin
         ez := strtoint(ezahl.text);
         tz := ez;
         ez := ez - 300;
         ez := ez - Random(1000);
         if ez < 1 then  ez := 0
         else if strtoint(ezahl.text) < ez then ez := 0
         else tz := tz - ez;
        end;

       if radiobutton3.Checked = true then
        begin
         ez := strtoint(ezahl.text);
         tz := ez;
         ez := ez - 600;
         ez := ez - Random(15000);
         if ez < 1 then  ez := 0
         else if strtoint(ezahl.text) < ez then ez := 0
         else tz := tz - ez;
        end;

       if radiobutton4.Checked = true then
        begin
         ez := strtoint(ezahl.text);
         tz := ez;
         ez := ez - 8000;
         ez := ez - (Random(ez) div 6);
         if ez < 1 then  ez := 0
         else if strtoint(ezahl.text) < ez then ez := 0
         else tz := tz - ez;
        end;

       if radiobutton5.Checked = true then
        begin
         ez := strtoint(ezahl.text);
         tz := ez;
         ez := ez - 20000;
         ez := ez - (Random(ez) div 2);
         if ez < 1 then  ez := 0
         else if strtoint(ezahl.text) < ez then ez := 0
         else tz := tz - ez;
        end;

         if radiobutton6.Checked = true then
        begin
         ez := strtoint(ezahl.text);
         tz := ez;
         ez := ez - 80000;
         ez := ez - (Random(ez));
         if ez < 1 then  ez := 0
         else if strtoint(ezahl.text) < ez then ez := 0
         else tz := tz - ez;
        end;

       label4.caption := label4.caption + ' ' + inttostr(ez);
       label5.caption := label5.caption + ' ' + inttostr(tz);
       label6.caption := label6.caption + ' ' + inttostr((ez*100 div strtoint(ezahl.text))) + ' %';
       label7.caption := label7.caption + ' ' + inttostr(100-(ez*100 div strtoint(ezahl.text))) + ' %';
       label8.caption := label8.caption + ' ' + stadtname.text + ':';
       effekt := 100-(ez*100 div strtoint(ezahl.text));
       if effekt > 94 then if effekt < 101 then label9.caption := 'extrem hoch';
       if effekt > 89 then if effekt < 95 then label9.caption := 'sehr hoch';
       if effekt > 84 then if effekt < 90 then label9.caption := 'hoch';
       if effekt > 69 then if effekt < 85 then label9.caption := 'überdurchschnittlich';
       if effekt > 49 then if effekt < 70 then label9.caption := 'durchschnittlich';
       if effekt > 29 then if effekt < 50 then label9.caption := 'unterdurchschnittlich';
       if effekt > 19 then if effekt < 30 then label9.caption := 'gering';
       if effekt > 9 then if effekt < 20 then label9.caption := 'sehr gering';
       if effekt > 0 then if effekt < 10 then label9.caption := 'extrem gering';
       restart := true;
      if timer1.Enabled = true then
       begin
       led2.number := 9;
       end
     end
   end
  else
   begin
    led2.number := 9;
    led1.number := led1.number - 1;
   end
 end
else
begin
led2.number := led2.number - 1;
end
   end
 end
 end
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
timer1.Enabled := true;
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
timer1.Enabled := false;
end;

procedure TForm1.Button3Click(Sender: TObject);
begin
timer1.Enabled := false;
image1.Visible := true;
label4.Caption := 'Einwohnerzahl:';
label5.Caption := 'Tote:';
label6.Caption := 'Überlebende in Prozent:';
label7.Caption := 'Tote in Prozent:';
label8.Caption := 'Effektivität der Waffe in';
label9.caption := '';
led1.number := 1;
led2.number := 5;
restart := false;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
Randomize;
restart := false;
end;



end.
