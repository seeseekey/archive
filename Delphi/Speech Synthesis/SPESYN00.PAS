unit spesyn00;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, mmsystem;

type
  Tmainform = class(TForm)
    sourcetext: TMemo;
    Label1: TLabel;
    Label2: TLabel;
    syntable: TListBox;
    calcsyn: TButton;
    playsyn: TButton;
    procedure calcsynClick(Sender: TObject);
    procedure playsynClick(Sender: TObject);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  mainform: Tmainform;

implementation

{$R *.DFM}

procedure Tmainform.calcsynClick(Sender: TObject);
var i: longint;
    workstring: string;
begin

workstring := lowercase(sourcetext.text);
syntable.Clear;

for i:=0 to strlen(PCHAR(workstring)) do
begin
 case INTEGER(workstring[i]) of
 97..122: syntable.Items.Add('syndata\'+workstring[i]+'.wav');  //Buchstaben
 32: syntable.Items.Add('syndata\shortbreak.wav'); //Leerzeichen
 33, 46, 63: syntable.Items.Add('syndata\longbreak.wav'); //Interpunktionszeichen
 48..57: syntable.Items.Add('syndata\'+workstring[i]+'.wav'); //Zahlen
 end;
end;

end;

procedure Tmainform.playsynClick(Sender: TObject);
var i: integer;
begin

for i:=0 to syntable.Items.Count-1 do
begin
   sndPlaySound(PCHAR(syntable.Items.strings[i]), SND_SYNC);
end;

end;

end.
