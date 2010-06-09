unit Lishu;

interface

uses
  SysUtils, WinTypes, WinProcs, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, StdCtrls, ExtCtrls, Buttons, jeridia, Menus, info, lissgv;

type
  TForm1 = class(TForm)
    Image1: TImage;
    Image2: TImage;
    MainMenu1: TMainMenu;
    Datei1: TMenuItem;
    Spielbeenden1: TMenuItem;
    N1: TMenuItem;
    Image3: TImage;
    Timer1: TTimer;
    Hilfe: TMenuItem;
    Inhalt1: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    Highscore1: TMenuItem;
     procedure FormPaint(Sender: TObject);
     procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Spielbeenden1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure Inhalt1Click(Sender: TObject);
    procedure N3Click(Sender: TObject);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  Form1: TForm1;
  zaehler: integer;

implementation

{$R *.DFM}

procedure TForm1.FormPaint(Sender: TObject);
begin
{Erstellung der Sterne}
for zaehler := 1 to 1000 do begin
Canvas.Pixels[Random(800), Random(600)] := clwhite;
Canvas.Pixels[Random(800), Random(600)+1] := clwhite;
Canvas.Pixels[Random(800)+1, Random(600)] := clwhite;
Canvas.Pixels[Random(800)+1, Random(600)+1] := clwhite;
 end;
end;

{Steuerungsprozedur}
procedure TForm1.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin

{Cursor Links}
 if Key = VK_LEFT then
  begin
   Image1.Picture.LoadFromFile('data\shipl.bmp');
    {Planetenabfrage}
    if (image1.ClientOrigin.x > 152) and (image1.ClientOrigin.x < 286) then
  begin
   if (image1.ClientOrigin.y > 166) and (image1.ClientOrigin.y < 317) then
    begin
     image1.left := image1.left+8;
     if MessageDlg('Möchten sie Jeridia betreten?', mtConfirmation,[mbYes, mbNo],
     0) = mryes then   jeridia.multpagedlg.Show;
    end;
  end;
   image1.left := image1.left-pixelprozug;
end;

{Cursor Rechts}
 if Key = VK_RIGHT then
  begin
   Image1.Picture.LoadFromFile('data\shipr.bmp');
   {Planetenabfrage}
    if (image1.ClientOrigin.x > 152) and (image1.ClientOrigin.x < 286) then
  begin
   if (image1.ClientOrigin.y > 166) and (image1.ClientOrigin.y < 317) then
    begin
     image1.left := image1.left-8;
     if MessageDlg('Möchten sie Jeridia betreten?', mtConfirmation,[mbYes, mbNo],
     0) = mryes then  jeridia.multpagedlg.Show;
    end;
  end;
   image1.left := image1.left+pixelprozug;
  end;

{Cursor Oben}
 if Key = VK_UP then
  begin
   Image1.Picture.LoadFromFile('data\shipo.bmp');
    {Planetenabfrage}
    if (image1.ClientOrigin.x > 152) and (image1.ClientOrigin.x < 286) then
  begin
   if (image1.ClientOrigin.y > 166) and (image1.ClientOrigin.y < 317) then
    begin
     image1.top := image1.top+8;
     if MessageDlg('Möchten sie Jeridia betreten?', mtConfirmation,[mbYes, mbNo],
     0) = mryes then jeridia.multpagedlg.Show;
    end;
  end;
   image1.top := image1.top-pixelprozug;
  end;

{Cursor unten}
 if Key = VK_DOWN then
   begin
    Image1.Picture.LoadFromFile('data\shipu.bmp');
    {Planetenabfrage}
     if (image1.ClientOrigin.x > 152) and (image1.ClientOrigin.x < 286) then
  begin
   if (image1.ClientOrigin.y > 166) and (image1.ClientOrigin.y < 317) then
    begin
     image1.top := image1.top-8;
     if MessageDlg('Möchten sie Jeridia betreten?', mtConfirmation,[mbYes, mbNo],
     0) = mryes then jeridia.multpagedlg.Show;
    end;
  end;
    image1.top := image1.top+pixelprozug;
   end;
end;

procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if MessageDlg('Möchten sie das Spiel wirklich beenden?',
     mtConfirmation,
    [mbYes, mbNo], 0) = mrYes then
    Action := caFree
  else
    Action := caNone;
 end;

procedure TForm1.Spielbeenden1Click(Sender: TObject);
begin
close;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
image3.visible := true;
randomize;
credits := 100000;
laderaum := 20;
mladeraum := 0;
chemikalien := 0;
chemikalienpreis := 100;
chemikalienmenge := 50;
computer := 0;
computerpreis := 500;
computermenge := 40;
energiezellen := 0;
energiezellenpreis := 200;
energiezellenmenge := 60;
kunststoffe := 0;
kunststoffepreis := 100;
kunststoffemenge := 60;
luxusgueter := 0;
luxusgueterpreis := 1000;
luxusguetermenge := 30;
metalle := 0;
metallepreis := 100;
metallemenge := 40;
nahrungsmittel := 0;
nahrungsmittelpreis := 50;
nahrungsmittelmenge := 65;
papier := 0;
papierpreis := 100;
papiermenge := 55;
rauschgifte := 0;
rauschgiftepreis := 600;
rauschgiftemenge := 45;
sklaven := 0;
sklavenpreis := 400;
sklavenmenge := 45;
sprengstoff := 0;
sprengstoffpreis := 300;
sprengstoffmenge := 40;
waffen := 0;
waffenpreis := 1500;
waffenmenge := 55;
wasser := 0;
wassermenge := 50;
wasserpreis := 65;

laser := 0;
pixelprozug := 2;
maxschild := 50;
mschild := 50;
end;

procedure TForm1.Timer1Timer(Sender: TObject);
begin
image3.visible := false;
end;

procedure TForm1.Inhalt1Click(Sender: TObject);
begin
 Application.HelpFile := 'LISHD.HLP';
 Application.HelpCommand(HELP_CONTENTS, 0);
end;

procedure TForm1.N3Click(Sender: TObject);
begin
 info.aboutbox.show;
end;

end.
