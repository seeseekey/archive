unit uFormMain;

//Problemm:
//das delay nach dem unsichtbar machen
// wenn eine anzeige opration stattfindet müssen die clicks gespeert werden

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, gtcl_ColorMemory, Menus, ExtCtrls, gtcl_Timer, StdCtrls, uFormAbout,
  uFormHighscore, gtcl_FileSystem, uGlobals, gtcl_Highscore;

type
  TFormMain = class(TForm)
    MainMenu: TMainMenu;
    datei1: TMenuItem;
    Beenden1: TMenuItem;
    N1: TMenuItem;
    Highscore1: TMenuItem;
    N2: TMenuItem;
    NeuesSpiel1: TMenuItem;
    Hilfe1: TMenuItem;
    ber1: TMenuItem;
    btnGreen: TImage;
    btnBlue: TImage;
    btnYellow: TImage;
    Spielfeld: TImage;
    ina_Red: TImage;
    ina_Green: TImage;
    ina_Blue: TImage;
    ina_Yellow: TImage;
    LabelSchaue: TLabel;
    LabelUndLos: TLabel;
    punkte: TLabel;
    btnRed: TImage;
    procedure Beenden1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure NeuesSpiel1Click(Sender: TObject);
    procedure btnRedClick(Sender: TObject);
    procedure btnGreenClick(Sender: TObject);
    procedure btnBlueClick(Sender: TObject);
    procedure btnYellowClick(Sender: TObject);
    procedure Make_ST_GAME_SHOW;
    procedure Make_ST_GAMEOVER;
    procedure ber1Click(Sender: TObject);
    procedure Highscore1Click(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  FormMain: TFormMain;
  xGame: gtColorMemory;
  locked: boolean=true;

implementation

{$R *.dfm}

//Blue Yellow

procedure TFormMain.Beenden1Click(Sender: TObject);
begin
  FormMain.Close;
end;

procedure TFormMain.FormCreate(Sender: TObject);
begin
  FormMain.DoubleBuffered := true;
  xGame := gtColorMemory.Create;

  myHighscore := gtHighscore.Create;

  if Fileexists(gtFileSystem.GetApplicationPath + 'cMem.dat') = false then
  begin
    myHighscore.Add('Jeri Lynn', 75);
    myHighscore.Add('Ceril Natan', 50);
    myHighscore.Add('Fred Feuerbein', 45);
    myHighscore.Add('Alfred Quark', 2);
    myHighscore.Add('Isabell Veniziano', 89);
    myHighscore.SaveToFile(gtFileSystem.GetApplicationPath + 'cMem.dat', cmSimple);
  end
  else myHighscore.LoadFromFile(gtFileSystem.GetApplicationPath + 'cMem.dat', cmSimple);
end;

procedure TFormMain.Make_ST_GAME_SHOW;
var i:Integer;
begin
   punkte.Caption := 'Punkte: ' + IntToStr(xGame.getPunkte);

  LabelSchaue.Visible := true;
  gtTimer.Delay(1000);
  LabelSchaue.Visible := false;

    for i:=0 to xGame.GetAnzahlEintraege-1 do
    begin
      btnRed.Visible := false;
      btnGreen.Visible := false;
      btnBlue.Visible := false;
      btnYellow.Visible := false;

      if xGame.GetValueOfArray(i) = Red then btnRed.Visible := true
      else if xGame.GetValueOfArray(i) = Green then btnGreen.Visible := true
      else if xGame.GetValueOfArray(i) = Blue then btnBlue.Visible := true
      else btnYellow.Visible := true;

      gtTimer.Delay(500);

      btnRed.Visible := false;
      btnGreen.Visible := false;
      btnBlue.Visible := false;
      btnYellow.Visible := false;

      gtTimer.Delay(500);

    end;

    xGame.SetGameStatus(ST_GAME_CLICK);

    LabelUndlos.Visible := true;
    gtTimer.Delay(1000);
    LabelUndlos.Visible := false;

    locked:=false;
end;

procedure TFormMain.Make_ST_GAMEOVER;
begin
    //GameOver
    xgame.SetGameStatus(ST_PREGAME);
    MessageDlg('GAME OVER!', mtInformation, [mbOk], 0);

    if myHighscore.IsEntryHighscoreAble(xGame.getPunkte) = true then
    begin
      //function InputBox(const ACaption, APrompt, ADefault: string): string;
      myHighscore.Add(InputBox('Neuer Rekord', 'Namen eingeben:', ''), xGame.getPunkte);
      myHighscore.SaveToFile(gtFileSystem.GetApplicationPath + 'cMem.dat', cmSimple);
      FormHighscore.ShowModal;
    end;
end;

procedure TFormMain.NeuesSpiel1Click(Sender: TObject);
begin
  xGame.Clear;
  punkte.Caption := 'Punkte: 0';
  xGame.SetGameStatus(ST_GAME_SHOW);
  Make_ST_GAME_SHOW;
end;

//Red
procedure TFormMain.btnRedClick(Sender: TObject);
begin
 if locked = true then Exit;
 locked := true;
 if xGame.ColorGameState=ST_GAME_CLICK then
 begin
   btnRed.Visible := true;
   gtTimer.Delay(500);
   btnRed.Visible := false;

   if xGame.SetClick(Red) = false then
   begin
     xGame.SetGameStatus(ST_GAMEOVER);
     Make_ST_GAMEOVER;
   end
   else if xGame.GetClickCounter = (xGame.GetAnzahlEintraege) then
   begin
     xGame.SetGameStatus(ST_GAME_SHOW);
     locked := true;
     Make_ST_GAME_SHOW;
   end;
 end;
 locked := false;
end;

// Green
procedure TFormMain.btnGreenClick(Sender: TObject);
begin
 if locked = true then Exit;
 locked := true;
 if xGame.ColorGameState=ST_GAME_CLICK then
 begin
    btnGreen.Visible := true;
   gtTimer.Delay(500);
   btnGreen.Visible := false;

   if xGame.SetClick(Green) = false then
   begin
     xGame.SetGameStatus(ST_GAMEOVER);
     Make_ST_GAMEOVER;
   end
   else if xGame.GetClickCounter = (xGame.GetAnzahlEintraege) then
   begin
     xGame.SetGameStatus(ST_GAME_SHOW);
     locked := true;
     Make_ST_GAME_SHOW;
   end;
 end;
 locked := false;
end;

// Blue
procedure TFormMain.btnBlueClick(Sender: TObject);
begin
 if locked = true then Exit;
 locked := true;
 if xGame.ColorGameState=ST_GAME_CLICK then
 begin
    btnBlue.Visible := true;
   gtTimer.Delay(500);
   btnBlue.Visible := false;

   if xGame.SetClick(Blue) = false then
   begin
     xGame.SetGameStatus(ST_GAMEOVER);
     Make_ST_GAMEOVER;
   end
   else if xGame.GetClickCounter = (xGame.GetAnzahlEintraege) then
   begin
     xGame.SetGameStatus(ST_GAME_SHOW);
     locked := true;
     Make_ST_GAME_SHOW;
   end;
 end;
 locked := false;
end;

// Gelb
procedure TFormMain.btnYellowClick(Sender: TObject);
begin
 if locked = true then Exit;
 locked := true;
 if xGame.ColorGameState=ST_GAME_CLICK then
 begin
   btnYellow.Visible := true;
   gtTimer.Delay(500);
   btnYellow.Visible := false;

   if xGame.SetClick(Yellow) = false then
   begin
     xGame.SetGameStatus(ST_GAMEOVER);
     Make_ST_GAMEOVER;
   end
   else if xGame.GetClickCounter = (xGame.GetAnzahlEintraege) then
   begin
     xGame.SetGameStatus(ST_GAME_SHOW);
     locked := true;
     Make_ST_GAME_SHOW;
   end;
 end;
 locked := false;
end;


procedure TFormMain.ber1Click(Sender: TObject);
begin
   FormAbout.ShowModal;
end;

procedure TFormMain.Highscore1Click(Sender: TObject);
begin
  FormHighscore.ShowModal;
end;

procedure TFormMain.FormDestroy(Sender: TObject);
begin
  myHighscore.Free;
end;

end.
