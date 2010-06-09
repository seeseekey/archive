unit uFormMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, Menus, StdCtrls, ComCtrls, Math, Buttons, uFormAbout;

type
  TFormMain = class(TForm)
    Viewport: TImage;
    Panel1: TPanel;
    MainMenu: TMainMenu;
    datei1: TMenuItem;
    Beenden1: TMenuItem;
    LabelPanzerungRotold: TLabel;
    Rot: TLabel;
    TrackbarWinkel: TTrackBar;
    TrackbarGeschwindigkeit: TTrackBar;
    LabelWinkel: TLabel;
    LabelGeschwindigkeit: TLabel;
    LabelWind: TLabel;
    ButtonFeuer: TButton;
    ControlbarWind: TControlBar;
    TimerFlugbahn: TTimer;
    TimerExplosion: TTimer;
    LabelPanzerungRot: TProgressBar;
    LabelPanzerungBlau: TProgressBar;
    Label1: TLabel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    BitBtn4: TBitBtn;
    Hilfe1: TMenuItem;
    ber1: TMenuItem;
    Highscore1: TMenuItem;
    N1: TMenuItem;
    Hilfe2: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    NeuesSpiel1: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure TrackbarWinkelChange(Sender: TObject);
    procedure TrackbarGeschwindigkeitChange(Sender: TObject);
    procedure ButtonFeuerClick(Sender: TObject);
    procedure TimerFlugbahnTimer(Sender: TObject);
    procedure TimerExplosionTimer(Sender: TObject);
    procedure Beenden1Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure BitBtn4Click(Sender: TObject);
    procedure ber1Click(Sender: TObject);
  private
    { Private-Deklarationen }
    procedure Landschaftsgenerator();
    procedure SpielfeldZeichnen();
    procedure PositionGenerieren();
    procedure PanzerZeichnen(farbe:string);
    procedure Startspieler();
    procedure AnzeigeAktualisieren();
    procedure Spielerwechsel();
    procedure Explosion(x,y:integer);
    procedure SchadenBerechnen();
    procedure PositionNeuBerechnen();
  public
    { Public-Deklarationen }
  end;

var
  FormMain: TFormMain;

implementation

{$R *.dfm}

type TPanzer=record
    X : integer;
    Y : integer;
    Winkel : integer;
    Geschwindigkeit : integer;
    Panzerung : byte;
end;

var Landschaft, Buffer, Panzer, Rohr, Geschoss : TBitmap;
    PanzerRot,PanzerBlau : TPanzer;
    Spieler:String;
    Wind:ShortInt;
    x0, y0, geschwindigkeit : integer;
    winkel, zeit : double;

    Bahn_alt, ExKoord:TPoint;
    XplodeValue: Byte=20; //Explosionsradius
    //ResX: Word=800;
    //ResY: Word=600;
    ResX, ResY: Word;

const gravitation=9.81;

// Programmstart
procedure TFormMain.FormCreate(Sender: TObject);
begin
    //Double Buffer
    FormMain.DoubleBuffered := true;

    //Auflösung einstellen
    ResX := Viewport.Width;
    ResY := Viewport.Height;

    // Bitmaps anlegen & Größe einstellen
    Landschaft:=TBitmap.Create;
    Landschaft.Width:=ResX;
    Landschaft.Height:=ResY;

    Buffer:=TBitmap.Create;
    Buffer.Width:=ResX;
    Buffer.Height:=ResY;

    Panzer:=TBitmap.Create;
    Panzer.Width:=15;
    Panzer.Height:=7;

    Rohr:=TBitmap.Create;
    Rohr.Width:=15;
    Rohr.Height:=7;

    Geschoss:=TBitmap.Create;
    Geschoss.Width:=5;
    Geschoss.Height:=5;

    ControlbarWind.Picture.Bitmap:=TBitmap.Create;
    ControlbarWind.Picture.Bitmap.Width:=200;
    ControlbarWind.Picture.Bitmap.Height:=20;

    Randomize;

    Landschaftsgenerator();
    PositionGenerieren();
    SpielfeldZeichnen();
    Startspieler();
    AnzeigeAktualisieren();
end;


procedure TFormMain.Landschaftsgenerator();
var punkt:array[1..19] of TPoint;
    i,j : integer;
begin
    punkt[ 1].y:=Random(100)+450;
    punkt[17].y:=Random(100)+450;

    punkt[ 9].y:=(punkt[1].y+punkt[17].y) div 2;
    punkt[ 9].y:=punkt[9].y-Random(200)-200;

    punkt[ 5].y:=(punkt[ 1].y+punkt[ 9].y)div 2 + Random(100)-50;
    punkt[13].y:=(punkt[ 9].y+punkt[17].y)div 2 + Random(100)-50;

    punkt[ 3].y:=(punkt[ 1].y+punkt[ 5].y)div 2 + Random(100)-50;
    punkt[ 7].y:=(punkt[ 5].y+punkt[ 9].y)div 2 + Random(100)-50;
    punkt[11].y:=(punkt[ 9].y+punkt[13].y)div 2 + Random(100)-50;
    punkt[15].y:=(punkt[13].y+punkt[17].y)div 2 + Random(100)-50;

    punkt[ 2].y:=(punkt[ 1].y+punkt[ 3].y)div 2 + Random(100)-50;
    punkt[ 4].y:=(punkt[ 3].y+punkt[ 5].y)div 2 + Random(100)-50;
    punkt[ 6].y:=(punkt[ 5].y+punkt[ 7].y)div 2 + Random(100)-50;
    punkt[ 8].y:=(punkt[ 7].y+punkt[ 9].y)div 2 + Random(100)-50;
    punkt[10].y:=(punkt[ 9].y+punkt[11].y)div 2 + Random(100)-50;
    punkt[12].y:=(punkt[11].y+punkt[13].y)div 2 + Random(100)-50;
    punkt[14].y:=(punkt[13].y+punkt[15].y)div 2 + Random(100)-50;
    punkt[16].y:=(punkt[15].y+punkt[17].y)div 2 + Random(100)-50;

    punkt[18].x:=ResX;punkt[18].y:=ResY;
    punkt[19].X:=0;punkt[19].Y:=ResY;

    for i:=1 to 17 do punkt[i].X:=(i-1)*50;

    with Landschaft.Canvas do
    begin
        pen.Color:=clWhite;
        brush.Color:=clWhite;
        rectangle(0,0,ResX,ResY);
    end;

    for i:=0 to 10 do
    begin
        with Landschaft.Canvas do
        begin
            Pen.Color:=RGB(0,255-i*20,0);
            Brush.Color:=Pen.Color;

            Polygon(punkt);

            for j:=1 to 17 do punkt[j].Y:=punkt[j].Y+5;
        end;
    end;

    Landschaft.TransparentColor:=clWhite;
    Landschaft.Transparent:=true;
end;


procedure TFormMain.SpielfeldZeichnen();
var i:integer;
begin
    with Buffer.Canvas do
    begin
        for i:=1 to ResY do
        begin
            Pen.Color:=RGB(255 - i div 3,255 - i div 3,255);
            MoveTo(0,i);
            LineTo(ResX,i);
        end;
    end;

    Buffer.Canvas.Draw(0,0,Landschaft);

    PanzerZeichnen('rot');
    Buffer.Canvas.Draw(PanzerRot.X-7,PanzerRot.Y-3,Panzer);

    Panzerzeichnen('blau');
    Buffer.Canvas.Draw(PanzerBlau.X-7,PanzerBlau.Y-3,Panzer);

    Viewport.Picture.Bitmap:=Buffer;

    TrackbarWinkelChange(nil);
end;


procedure TFormMain.PositionGenerieren();
var zufall:byte;
    i:integer;
begin
    zufall:=Random(100);

    if zufall<50 then
    begin
        PanzerRot.X:=Random(300)+50;
        PanzerBlau.X:=random(300)+450
    end
    else
    begin
        PanzerRot.X:=Random(300)+450;
        PanzerBlau.X:=random(300)+50
    end;

    for i:=1 to ResY do
        if Landschaft.Canvas.Pixels[PanzerRot.X,i]<>clWhite then
        begin
            PanzerRot.Y:=i;
            break;
        end;

    for i:=1 to ResY do
        if Landschaft.Canvas.Pixels[PanzerBlau.X,i]<>clWhite then
        begin
            PanzerBlau.Y:=i;
            break;
        end;

    PanzerRot.Winkel:=90;
    PanzerRot.Geschwindigkeit:=50;
    PanzerRot.Panzerung:=100;

    PanzerBlau.Winkel:=90;
    PanzerBlau.Geschwindigkeit:=50;
    PanzerBlau.Panzerung:=100;
end;


procedure TFormMain.PanzerZeichnen(farbe:string);
begin
    with Panzer.Canvas do
    begin
        pen.Color:=clWhite;
        brush.Color:=clWhite;
        Rectangle(0,0,Panzer.Width,Panzer.Height);
    end;

    Panzer.TransparentColor:=clWhite;
    Panzer.Transparent:=true;

    if farbe='rot' then
    begin
        Panzer.Canvas.Brush.Color:=clRed;
        Panzer.Canvas.Pen.Color:=RGB(150,0,0);
    end;

    if farbe='blau' then
    begin
        Panzer.Canvas.Brush.Color:=clBlue;
        Panzer.Canvas.Pen.Color:=RGB(0,0,150);
    end;

    with Panzer.Canvas do
    begin
        Polygon([Point(0,3),Point(0,2),Point(1,1),Point(2,1),Point(3,0),Point(11,0),
                Point(12,1),Point(13,1),Point(14,2),Point(14,3),Point(13,4),Point(1,4)]);
        Polygon([Point(2,5),Point(3,4),Point(11,4),Point(12,5),Point(11,6),Point(3,6)]);
    end;
end;

procedure TFormMain.TrackBarWinkelChange(Sender: TObject);
var x,y:integer;
    winkel:double;
begin
    LabelWinkel.Caption:='Winkel: '+IntToStr(180-TrackbarWinkel.Position);

    winkel:=degtorad(TrackbarWinkel.Position+180);

    x:=round(cos(winkel)*7+7);
    y:=round(sin(winkel)*7+6);

    with Rohr.Canvas do
    begin
        Pen.Color:=clBlack;

        if Spieler='rot' then
        begin
            CopyRect(Rect(0,0,15,7),Buffer.Canvas,Rect(PanzerRot.X-7,PanzerRot.Y-10,PanzerRot.X+7,PanzerRot.Y-3));
            MoveTo(7,6);
            LineTo(x,y);
            Viewport.Canvas.Draw(PanzerRot.X-7,PanzerRot.Y-10,Rohr);
        end;

        if Spieler='blau' then
        begin
            CopyRect(Rect(0,0,15,7),Buffer.Canvas,Rect(PanzerBlau.X-7,PanzerBlau.Y-10,PanzerBlau.X+7,PanzerBlau.Y-3));
            MoveTo(7,6);
            LineTo(x,y);
            Viewport.Canvas.Draw(PanzerBlau.X-7,PanzerBlau.Y-10,Rohr);
        end;
    end;
end;

procedure TFormMain.TrackBarGeschwindigkeitChange(Sender: TObject);
begin
    LabelGeschwindigkeit.Caption:='Geschwindigkeit: '+IntToStr(TrackbarGeschwindigkeit.Position);
end;

procedure TFormMain.Startspieler();
var i : byte;
begin
    i:=Random(2);
    if i<1 then Spieler:='rot' else Spieler:='blau';
end;

procedure TFormMain.AnzeigeAktualisieren();
begin
    ButtonFeuer.Enabled:=true;

    Wind:=Round(Random(20)-10);

    LabelWind.Caption:='Windstärke: '+IntToStr(Wind);

    with ControlbarWind.Picture.Bitmap.Canvas do
    begin
        Pen.Color:=clWhite;
        Brush.Color:=clWhite;
        Rectangle(1,1,200,20);

        Pen.Color:=clBlue;
        Brush.Color:=clBlue;

        if Wind>0 then Rectangle(100,1,100+Wind*10,20);
        if Wind<0 then Rectangle(100+Wind*10,1,100,20);
    end;

    LabelPanzerungRot.Position := PanzerRot.Panzerung;
    LabelPanzerungBlau.Position := PanzerBlau.Panzerung;
    //LabelPanzerungRot.Caption:='Panzer Rot:'+IntToStr(PanzerRot.Panzerung);
    //LabelPanzerungBlau.Caption:='Panzer Blau:'+IntToStr(PanzerBlau.Panzerung);

    if Spieler='rot' then
    begin
        TrackbarWinkel.Position:=180-PanzerRot.Winkel;
        TrackbarGeschwindigkeit.Position:=PanzerRot.Geschwindigkeit;
        Panel1.Color:=RGB(255,50,50);
        //Panel2.Color:=RGB(255,50,50);
    end;

    if Spieler='blau' then
    begin
        TrackbarWinkel.Position:=180-PanzerBlau.Winkel;
        TrackbarGeschwindigkeit.Position:=PanzerBlau.Geschwindigkeit;
        Panel1.Color:=RGB(100,100,255);
        //Panel2.Color:=RGB(100,100,255);
    end;

    if FormMain.Visible=true then
    begin
        TrackbarWinkel.SetFocus;
        TrackbarGeschwindigkeit.SetFocus;
    end;
end;

procedure TFormMain.ButtonFeuerClick(Sender: TObject);
begin
    ButtonFeuer.Enabled:=false;

    if Spieler='rot' then
    begin
        PanzerRot.Winkel:=180-TrackbarWinkel.Position;
        PanzerRot.Geschwindigkeit:=TrackbarGeschwindigkeit.Position;
        winkel:=degtorad(PanzerRot.Winkel);
        geschwindigkeit:=PanzerRot.Geschwindigkeit;
        x0:=round(cos(winkel)*10+PanzerRot.X);
        y0:=round(-sin(winkel)*10+PanzerRot.Y-4);
    end;

    if Spieler='blau' then
    begin
        PanzerBlau.Winkel:=180-TrackbarWinkel.Position;
        PanzerBlau.Geschwindigkeit:=TrackbarGeschwindigkeit.Position;
        winkel:=degtorad(PanzerBlau.Winkel);
        geschwindigkeit:=PanzerBlau.Geschwindigkeit;
        x0:=round(cos(winkel)*10+PanzerBlau.X);
        y0:=round(-sin(winkel)*10+PanzerBlau.Y-4);
    end;

    zeit:=0;

    TimerFlugbahn.Enabled:=true;
end;

procedure TFormMain.TimerFlugbahnTimer(Sender: TObject);
var x,y : integer;
begin
    zeit:=zeit+0.08;

    x := Round(x0 + geschwindigkeit*cos(winkel)*zeit + wind*zeit*zeit*0.3);
    y := Round(y0 - (geschwindigkeit*sin(winkel)*zeit - 0.5*gravitation*zeit*zeit));

    with Geschoss.Canvas do
    begin
        CopyRect(Rect(0,0,5,5),Buffer.Canvas,Rect(x-2,y-2,x+2,y+2));
        Pen.Color:=RGB(0,0,0);;
        Brush.Color:=RGB(255,0,0);
        Ellipse(1,1,4,4);
    end;

    with Viewport.Canvas do
    begin
        CopyRect(Rect(Bahn_alt.x-2,Bahn_alt.y-2,Bahn_alt.x+2,Bahn_alt.y+2),Buffer.Canvas,Rect(Bahn_alt.x-2,Bahn_alt.y-2,Bahn_alt.x+2,Bahn_alt.y+2));
        Draw(x-2,y-2,Geschoss);
    end;

    Bahn_alt.x:=x;
    Bahn_alt.y:=y;

    if (x<0) or (x>ResX) then
    begin
        TimerFlugbahn.Enabled:=false;
        Spielerwechsel(); exit;
    end;

    if (y>ResY) then
    begin
        TimerFlugbahn.Enabled:=false;
        Explosion(x,y); exit;
    end;

    if (x>PanzerRot.X-8) and (x<PanzerRot.X+8) and (y>PanzerRot.Y-4) and (y<PanzerRot.Y+4) then
    begin
        TimerFlugbahn.Enabled:=false;
        Explosion(x,y); exit;
    end;
    if (x>PanzerBlau.X-8) and (x<PanzerBlau.X+8) and (y>PanzerBlau.Y-4) and (y<PanzerBlau.Y+4) then
    begin
        TimerFlugbahn.Enabled:=false;
        Explosion(x,y); exit;
    end;

    if (Landschaft.Canvas.Pixels[x,y]<>clWhite) and (x>0) and (x<ResX) and (y>0) and (y<ResY) then
    begin
        TimerFlugbahn.Enabled:=false;
        Explosion(x,y); exit;
    end;

end;

procedure TFormMain.Explosion(x,y:integer);
begin
    ExKoord.X:=x;
    ExKoord.Y:=y;

    TimerExplosion.Enabled:=true;
end;

procedure TFormMain.Spielerwechsel();
begin
    if Spieler='rot' then Spieler:='blau'
    else if Spieler='blau' then Spieler:='rot';

    SpielfeldZeichnen();
    AnzeigeAktualisieren();
end;


procedure TFormMain.TimerExplosionTimer(Sender: TObject);
begin
    TimerExplosion.Tag:=TimerExplosion.Tag+1;

    with Viewport.Canvas do
    begin
        Pen.Color:=clRed;
        Brush.Color:=clRed;
        Ellipse(ExKoord.X-TimerExplosion.Tag,ExKoord.Y-TimerExplosion.Tag,ExKoord.X+TimerExplosion.Tag,ExKoord.Y+TimerExplosion.Tag)
    end;

    if TimerExplosion.Tag=XplodeValue then
    begin
        TimerExplosion.Enabled:=false;
        TimerExplosion.Tag:=0;

        with Landschaft.Canvas do
        begin
            Pen.Color:=clWhite;
            Brush.Color:=clWhite;
            //Ellipse(ExKoord.X-20,ExKoord.Y-20,ExKoord.X+20,ExKoord.Y+20);
            Ellipse(ExKoord.X-XplodeValue,ExKoord.Y-XplodeValue,ExKoord.X+XplodeValue,ExKoord.Y+XplodeValue);
        end;

        SchadenBerechnen();
        PositionNeuBerechnen();
        Spielerwechsel();
    end;
end;

procedure TFormMain.SchadenBerechnen();
var abstand : double;
begin
    abstand:=sqrt(sqr(abs(PanzerRot.X-ExKoord.X))+sqr(abs(PanzerRot.Y-ExKoord.Y)));
    if abstand<=XplodeValue+3 then PanzerRot.Panzerung:=PanzerRot.Panzerung-25;

    abstand:=sqrt(sqr(abs(PanzerBlau.X-ExKoord.X))+sqr(abs(PanzerBlau.Y-ExKoord.Y)));
    if abstand<=XplodeValue+3 then PanzerBlau.Panzerung:=PanzerBlau.Panzerung-25;

    if PanzerRot.Panzerung<=0 then
    begin
        if MessageDlg('Blau hat das Spiel gewonnen. Neues Spiel?',mtConfirmation, [mbYes, mbNo], 0) = mrno then close
        else
        begin
            Landschaftsgenerator();
            PositionGenerieren();
            SpielfeldZeichnen();
            Startspieler();
            AnzeigeAktualisieren();
        end;
    end;

    if PanzerBlau.Panzerung<=0 then
    begin
        if MessageDlg('Rot hat das Spiel gewonnen. Neues Spiel?',mtConfirmation, [mbYes, mbNo], 0) = mrno then close
        else
        begin
            Landschaftsgenerator();
            PositionGenerieren();
            SpielfeldZeichnen();
            Startspieler();
            AnzeigeAktualisieren();
        end;
    end;
end;

procedure TFormMain.PositionNeuBerechnen();
var i:integer;
begin
    if (Landschaft.Canvas.Pixels[PanzerRot.X,PanzerRot.Y+3]=clWhite) and (PanzerRot.Y+3<ResY) then
    begin
        for i:=PanzerRot.Y+3 to ResY do
        if (Landschaft.Canvas.Pixels[PanzerRot.X,i]<>clWhite) or (i=ResY) then
        begin
            PanzerRot.Y:=i;
            break;
        end;
    end;

    if (Landschaft.Canvas.Pixels[PanzerBlau.X,PanzerBlau.Y+3]=clWhite) and (PanzerBlau.Y+3<ResY) then
    begin
        for i:=PanzerBlau.Y+3 to ResY do
        if (Landschaft.Canvas.Pixels[PanzerBlau.X,i]<>clWhite) or (i=ResY) then
        begin
            PanzerBlau.Y:=i;
            break;
        end;
    end;
end;

procedure TFormMain.Beenden1Click(Sender: TObject);
begin
  FormMain.Close;
end;

procedure TFormMain.BitBtn1Click(Sender: TObject);
begin
  XplodeValue := 20;
end;

procedure TFormMain.BitBtn2Click(Sender: TObject);
begin
  XplodeValue := 50;
end;

procedure TFormMain.BitBtn3Click(Sender: TObject);
begin
  XplodeValue := 100;
end;

procedure TFormMain.BitBtn4Click(Sender: TObject);
begin
  XplodeValue := 255;
end;

procedure TFormMain.ber1Click(Sender: TObject);
begin
  FormAbout.ShowModal;
end;

end.
