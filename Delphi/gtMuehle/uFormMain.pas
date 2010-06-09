unit uFormMain;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, Menus, muehle, StdCtrls, MPlayer, inifiles,
  jpeg, hh, hh_funcs, D6OnHelpFix, IdUDPClient,
  IdBaseComponent, IdComponent, IdUDPBase, IdUDPServer, IdSocketHandle,
  ImgList, gtcl_FileSystem, gtcl_TWideStrings, DSPack, directshow9, synunicode,
  gtmuehle04, uFormOptions;

type
  TFormMain = class(TForm)
    spielbrett: TImage;
    mainmenu: TMainMenu;
    Datei1: TMenuItem;
    Beenden1: TMenuItem;
    background: TImage;
    a1: TImage;
    a2: TImage;
    a3: TImage;
    a4: TImage;
    a5: TImage;
    a6: TImage;
    a7: TImage;
    a8: TImage;
    b1: TImage;
    b8: TImage;
    b7: TImage;
    b6: TImage;
    b5: TImage;
    b4: TImage;
    b3: TImage;
    b2: TImage;
    c3: TImage;
    c1: TImage;
    c2: TImage;
    c4: TImage;
    c5: TImage;
    c6: TImage;
    c7: TImage;
    c8: TImage;
    sw01: TImage;
    sw02: TImage;
    sw04: TImage;
    sw03: TImage;
    sw08: TImage;
    sw07: TImage;
    sw05: TImage;
    sw06: TImage;
    sw09: TImage;
    sb01: TImage;
    sb02: TImage;
    sb04: TImage;
    sb03: TImage;
    sb08: TImage;
    sb07: TImage;
    sb06: TImage;
    sb05: TImage;
    sb09: TImage;
    lsb07: TImage;
    lsb06: TImage;
    lsb05: TImage;
    lsb03: TImage;
    lsb04: TImage;
    lsb02: TImage;
    lsb01: TImage;
    lsw07: TImage;
    lsw05: TImage;
    lsw03: TImage;
    lsw01: TImage;
    lsw02: TImage;
    lsw04: TImage;
    lsw06: TImage;
    NeuesSpiel1: TMenuItem;
    N1: TMenuItem;
    maintimer: TTimer;
    Spielffnen1: TMenuItem;
    Spielspeichern1: TMenuItem;
    N3: TMenuItem;
    N4: TMenuItem;
    Hilfe1: TMenuItem;
    Inhalt1: TMenuItem;
    N5: TMenuItem;
    ber1: TMenuItem;
    N6: TMenuItem;
    Optionen1: TMenuItem;
    N7: TMenuItem;
    statuslabel: TLabel;
    gamemodelabel: TLabel;
    savedialog: TSaveDialog;
    opendialog: TOpenDialog;
    comtimer: TTimer;
    comtimer2: TTimer;
    comtimer3: TTimer;
    UPDGameServer: TIdUDPServer;
    UDPGameClient: TIdUDPClient;
    FilterGraph: TFilterGraph;
    procedure FormCreate(Sender: TObject);
    procedure Beenden1Click(Sender: TObject);
    procedure calcrelcord (x, y: Integer; var rgw_x,rgw_y:Integer);
    function show_mnv : Boolean;
    function savegame(stream: TFileStream) : Boolean;
    function fieldcheck (field: string) : Boolean;
    function modetofilestring (mode: Integer) : string;
    function setgraphic (field:string; mode: Integer) : Boolean;
    function checkfieldtoremove (field:string) : Boolean;
    function subsetstones () : boolean;
    function addlosedstone () : Boolean;
    function setpicturezero (field: string) : Boolean;
    function executegamefunctions (field: string) : Boolean;
    function resetgamefield() : Boolean;
    function setstatuslabel (labelmessage: string) : Boolean;
    function refresh_field () : Boolean;
    procedure a1Click(Sender: TObject);
    procedure NeuesSpiel1Click(Sender: TObject);
    procedure maintimerTimer(Sender: TObject);
    procedure a2Click(Sender: TObject);
    procedure a3Click(Sender: TObject);
    procedure a4Click(Sender: TObject);
    procedure a5Click(Sender: TObject);
    procedure a6Click(Sender: TObject);
    procedure a7Click(Sender: TObject);
    procedure a8Click(Sender: TObject);
    procedure b1Click(Sender: TObject);
    procedure b2Click(Sender: TObject);
    procedure b3Click(Sender: TObject);
    procedure b4Click(Sender: TObject);
    procedure b5Click(Sender: TObject);
    procedure b6Click(Sender: TObject);
    procedure b7Click(Sender: TObject);
    procedure b8Click(Sender: TObject);
    procedure c1Click(Sender: TObject);
    procedure c2Click(Sender: TObject);
    procedure c3Click(Sender: TObject);
    procedure c4Click(Sender: TObject);
    procedure c5Click(Sender: TObject);
    procedure c6Click(Sender: TObject);
    procedure c7Click(Sender: TObject);
    procedure c8Click(Sender: TObject);
    procedure ber1Click(Sender: TObject);
    procedure N1Click(Sender: TObject);
    procedure Spielffnen1Click(Sender: TObject);
    procedure Spielspeichern1Click(Sender: TObject);
    procedure Optionen1Click(Sender: TObject);
    procedure comtimerTimer(Sender: TObject);
    procedure comtimer2Timer(Sender: TObject);
    procedure comtimer3Timer(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure Inhalt1Click(Sender: TObject);
    procedure HilfezurHilfe1Click(Sender: TObject);
    procedure UPDGameServerUDPRead(Sender: TObject; AData: TBytes;
      ABinding: TIdSocketHandle);
    function CanMessageShow: Boolean;
    procedure OpenMusicFile(filename: string);
    procedure FilterGraphGraphComplete(sender: TObject; Result: HRESULT;
      Renderer: IBaseFilter);
    private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
    MusicVolume: Integer;
  end;

var
  FormMain: TFormMain;
  mHHelp: THookHelpSystem; //variable für die hilfe
  removemode: boolean = false; //gibt an ob ein stein removed werden soll
  movenotvalid : Boolean = false; //gibt an ob der zug valid war
  markedstone : Boolean = false; // gibt an ob ein stein markiert wurde
  gamemode2com : Boolean = false; //gibt an ob computer für zug autorisiert ist
  swtime: Cardinal = 0; // Demo Zeit

  MusicPlayList: TWideStringList; //Liste der Musikstücke
  MusicListIndex: LongWord=0; //Index auf Playlist

{$R gtrStones.res}

implementation

uses infodialog, uFormGameNew, uFormAbout;

{$R *.DFM}
procedure TFormMain.OpenMusicFile(filename: string);
begin
    if not FilterGraph.Active then FilterGraph.Active := true;
    FilterGraph.ClearGraph;
    FilterGraph.RenderFile(filename);
    FilterGraph.Volume := MusicVolume; //MAX 10000
    FilterGraph.Play;
end;

function TFormMain.CanMessageShow: Boolean; // Gibt an ob eine fehlermessage gezeigt werden soll
begin
 if mpr = net.player then Result := true
 else Result := false;
end;

function TFormMain.resetgamefield() : Boolean; // setzt alle spielparamter auf 0
begin
  removemode := false;
  gamemodelabel.Caption := '';

  playerstatus_white.gamephase := 0; playerstatus_black.gamephase := 0;
  playerstatus_white.stones := 9; playerstatus_black.stones := 9;
  playerstatus_white.setstones := 9; playerstatus_black.setstones := 9;

  mms := ''; mpr := 1; // Spieler 1

  sw01.Visible := true; sw02.Visible := true; sw03.Visible := true;
  sw04.Visible := true; sw05.Visible := true; sw06.Visible := true;
  sw07.visible := true; sw08.Visible := true; sw09.Visible := true;
  sb01.Visible := true; sb02.Visible := true; sb03.Visible := true;
  sb04.Visible := true; sb05.Visible := true; sb06.Visible := true;
  sb07.visible := true; sb08.Visible := true; sb09.Visible := true;

  lsw01.Visible := false; lsw02.Visible := false; lsw03.Visible := false;
  lsw04.Visible := false; lsw05.Visible := false; lsw06.Visible := false;
  lsw07.visible := false; lsb01.Visible := false; lsb02.Visible := false;
  lsb03.Visible := false; lsb04.Visible := false; lsb05.Visible := false;
  lsb06.Visible := false; lsb07.visible := false;

  a1.Picture.graphic := nil; a2.picture.graphic := nil; a3.picture.graphic := nil; a4.picture.graphic := nil;
  a5.picture.graphic := nil; a6.picture.graphic := nil; a7.picture.graphic := nil; a8.picture.graphic := nil;
  b1.picture.graphic := nil; b2.picture.graphic := nil; b3.picture.graphic := nil; b4.picture.graphic := nil;
  b5.picture.graphic := nil; b6.picture.graphic := nil; b7.picture.graphic := nil; b8.picture.graphic := nil;
  c1.picture.graphic := nil; c2.picture.graphic := nil; c3.picture.graphic := nil; c4.picture.graphic := nil;
  c5.picture.graphic := nil; c6.picture.graphic := nil; c7.picture.graphic := nil; c8.picture.graphic := nil;

  fieldstatus.a1:=0; fieldstatus.a2:=0; fieldstatus.a3:=0; fieldstatus.a4:=0;
  fieldstatus.a5:=0; fieldstatus.a6:=0; fieldstatus.a7:=0; fieldstatus.a8:=0;
  fieldstatus.b1:=0; fieldstatus.b2:=0; fieldstatus.b3:=0; fieldstatus.b4:=0;
  fieldstatus.b5:=0; fieldstatus.b6:=0; fieldstatus.b7:=0; fieldstatus.b8:=0;
  fieldstatus.c1:=0; fieldstatus.c2:=0; fieldstatus.c3:=0; fieldstatus.c4:=0;
  fieldstatus.c5:=0; fieldstatus.c6:=0; fieldstatus.c7:=0; fieldstatus.c8:=0;

  global_gamestatus.gamemodus := 0;
  statuslabel.Caption := '';
  markedstone:=false;
  
  resetgamefield := true;
end;

function TFormMain.setstatuslabel (labelmessage: string) : Boolean;
begin
  if global_gamestatus.gamemodus = 1 then gamemodelabel.Caption := 'Spieler vs. Spieler'
  else if global_gamestatus.gamemodus = 2 then gamemodelabel.Caption := 'Spieler vs. Computer'
  else if global_gamestatus.gamemodus = 3 then gamemodelabel.Caption := 'Computer vs. Spieler'
  else if global_gamestatus.gamemodus = 4 then gamemodelabel.Caption := 'Computer vs. Computer'
  else if global_gamestatus.gamemodus = 5 then gamemodelabel.Caption := 'Spieler vs. Spieler über LAN';

  gamemodelabel.Left := (spielbrett.left + (spielbrett.Width div 2)) - (gamemodelabel.Width div 2);
  gamemodelabel.top := (spielbrett.Top) + 2;

  statuslabel.Caption := labelmessage;
  statuslabel.Left := (spielbrett.left + (spielbrett.Width div 2)) - (statuslabel.Width div 2);
  statuslabel.top := (spielbrett.Top + spielbrett.Height) - 25;
  setstatuslabel := true;
end;

// gibt an ob auf dem überebenden feld ein stein des momentanen spielers steht.
function fieldstatusonfield (field: string) : Boolean;
begin
 if field = 'a1' then begin if fieldstatus.a1 = mpr then begin fieldstatusonfield := true; exit; end; end
 else if field = 'a2' then begin if fieldstatus.a2 = mpr then begin fieldstatusonfield := true; exit; end; end
 else if field = 'a3' then begin if fieldstatus.a3 = mpr then begin fieldstatusonfield := true; exit; end; end
 else if field = 'a4' then begin if fieldstatus.a4 = mpr then begin fieldstatusonfield := true; exit; end; end
 else if field = 'a5' then begin if fieldstatus.a5 = mpr then begin fieldstatusonfield := true; exit; end; end
 else if field = 'a6' then begin if fieldstatus.a6 = mpr then begin fieldstatusonfield := true; exit; end; end
 else if field = 'a7' then begin if fieldstatus.a7 = mpr then begin fieldstatusonfield := true; exit; end; end
 else if field = 'a8' then begin if fieldstatus.a8 = mpr then begin fieldstatusonfield := true; exit; end; end
 else if field = 'b1' then begin if fieldstatus.b1 = mpr then begin fieldstatusonfield := true; exit; end; end
 else if field = 'b2' then begin if fieldstatus.b2 = mpr then begin fieldstatusonfield := true; exit; end; end
 else if field = 'b3' then begin if fieldstatus.b3 = mpr then begin fieldstatusonfield := true; exit; end; end
 else if field = 'b4' then begin if fieldstatus.b4 = mpr then begin fieldstatusonfield := true; exit; end; end
 else if field = 'b5' then begin if fieldstatus.b5 = mpr then begin fieldstatusonfield := true; exit; end; end
 else if field = 'b6' then begin if fieldstatus.b6 = mpr then begin fieldstatusonfield := true; exit; end; end
 else if field = 'b7' then begin if fieldstatus.b7 = mpr then begin fieldstatusonfield := true; exit; end; end
 else if field = 'b8' then begin if fieldstatus.b8 = mpr then begin fieldstatusonfield := true; exit; end; end
 else if field = 'c1' then begin if fieldstatus.c1 = mpr then begin fieldstatusonfield := true; exit; end; end
 else if field = 'c2' then begin if fieldstatus.c2 = mpr then begin fieldstatusonfield := true; exit; end; end
 else if field = 'c3' then begin if fieldstatus.c3 = mpr then begin fieldstatusonfield := true; exit; end; end
 else if field = 'c4' then begin if fieldstatus.c4 = mpr then begin fieldstatusonfield := true; exit; end; end
 else if field = 'c5' then begin if fieldstatus.c5 = mpr then begin fieldstatusonfield := true; exit; end; end
 else if field = 'c6' then begin if fieldstatus.c6 = mpr then begin fieldstatusonfield := true; exit; end; end
 else if field = 'c7' then begin if fieldstatus.c7 = mpr then begin fieldstatusonfield := true; exit; end; end
 else if field = 'c8' then begin if fieldstatus.c8 = mpr then begin fieldstatusonfield := true; exit; end; end;
  fieldstatusonfield := false;
end;

// gibt den string für die spielsteine zurück
function TFormMain.modetofilestring (mode: Integer) : string;
begin
 if mode = 0 then Result := ''
 else if mode = 1 then Result := 'STONEWHITE'
 else if mode = 2 then Result := 'STONEBLACK';

 if markedstone = true then
 begin
  if mpr = 1 then Result := 'STONEMARKEDWHITE'
  else if mpr = 2 then  Result:= 'STONEMARKEDBLACK';
 end;
end;

// entfernt die graphiken der bereits gesetzen steine vom randbereich
function tFormMain.subsetstones () : boolean;
begin
 if mpr = 1 then
 begin
  if playerstatus_white.setstones = 9 then sw09.visible := false
  else if playerstatus_white.setstones = 8 then sw08.visible := false
  else if playerstatus_white.setstones = 7 then sw07.visible := false
  else if playerstatus_white.setstones = 6 then sw06.visible := false
  else if playerstatus_white.setstones = 5 then sw05.visible := false
  else if playerstatus_white.setstones = 4 then sw04.visible := false
  else if playerstatus_white.setstones = 3 then sw03.visible := false
  else if playerstatus_white.setstones = 2 then sw02.visible := false
  else if playerstatus_white.setstones = 1 then sw01.visible := false;
  playerstatus_white.setstones := playerstatus_white.setstones-1;
 end
else
 begin
  if playerstatus_black.setstones = 9 then sb09.visible := false
  else if playerstatus_black.setstones = 8 then sb08.visible := false
  else if playerstatus_black.setstones = 7 then sb07.visible := false
  else if playerstatus_black.setstones = 6 then sb06.visible := false
  else if playerstatus_black.setstones = 5 then sb05.visible := false
  else if playerstatus_black.setstones = 4 then sb04.visible := false
  else if playerstatus_black.setstones = 3 then sb03.visible := false
  else if playerstatus_black.setstones = 2 then sb02.visible := false
  else if playerstatus_black.setstones = 1 then sb01.visible := false;
  playerstatus_black.setstones := playerstatus_black.setstones-1;
 end;
subsetstones := true;
end;

// fügt die removten steine in den randbereich ein
function tFormMain.addlosedstone () : boolean;
begin
 if mpr = 1 then
 begin
  if playerstatus_white.stones = 8 then lsw01.visible := true
  else if playerstatus_white.stones = 7 then lsw02.visible := true
  else if playerstatus_white.stones = 6 then lsw03.visible := true
  else if playerstatus_white.stones = 5 then lsw04.visible := true
  else if playerstatus_white.stones = 4 then lsw05.visible := true
  else if playerstatus_white.stones = 3 then lsw06.visible := true
  else if playerstatus_white.stones = 2 then lsw07.visible := true;
 end
else if mpr = 2 then
 begin
  if playerstatus_black.stones = 8 then lsb01.visible := true
  else if playerstatus_black.stones = 7 then lsb02.visible := true
  else if playerstatus_black.stones = 6 then lsb03.visible := true
  else if playerstatus_black.stones = 5 then lsb04.visible := true
  else if playerstatus_black.stones = 4 then lsb05.visible := true
  else if playerstatus_black.stones = 3 then lsb06.visible := true
  else if playerstatus_black.stones = 2 then lsb07.visible := true;
 end;
addlosedstone := true;
end;

// setzt die entsprechende fieldgraphic
function tFormMain.setgraphic (field:string; mode: Integer) : Boolean;
var bmpX: TBitmap;
begin
 if field = 'a1' then a1.Picture.bitmap.handle:=LoadBitMap(HInstance, PChar(modetofilestring(mode)))
 else if field = 'a2' then a2.Picture.bitmap.handle:=LoadBitMap(HInstance, PChar(modetofilestring(mode)))
 else if field = 'a3' then a3.Picture.bitmap.handle:=LoadBitMap(HInstance, PChar(modetofilestring(mode)))
 else if field = 'a4' then a4.Picture.bitmap.handle:=LoadBitMap(HInstance, PChar(modetofilestring(mode)))
 else if field = 'a5' then a5.Picture.bitmap.handle:=LoadBitMap(HInstance, PChar(modetofilestring(mode)))
 else if field = 'a6' then a6.Picture.bitmap.handle:=LoadBitMap(HInstance, PChar(modetofilestring(mode)))
 else if field = 'a7' then a7.Picture.bitmap.handle:=LoadBitMap(HInstance, PChar(modetofilestring(mode)))
 else if field = 'a8' then a8.Picture.bitmap.handle:=LoadBitMap(HInstance, PChar(modetofilestring(mode)))
 else if field = 'b1' then b1.Picture.bitmap.handle:=LoadBitMap(HInstance, PChar(modetofilestring(mode)))
 else if field = 'b2' then b2.Picture.bitmap.handle:=LoadBitMap(HInstance, PChar(modetofilestring(mode)))
 else if field = 'b3' then b3.Picture.bitmap.handle:=LoadBitMap(HInstance, PChar(modetofilestring(mode)))
 else if field = 'b4' then b4.Picture.bitmap.handle:=LoadBitMap(HInstance, PChar(modetofilestring(mode)))
 else if field = 'b5' then b5.Picture.bitmap.handle:=LoadBitMap(HInstance, PChar(modetofilestring(mode)))
 else if field = 'b6' then b6.Picture.bitmap.handle:=LoadBitMap(HInstance, PChar(modetofilestring(mode)))
 else if field = 'b7' then b7.Picture.bitmap.handle:=LoadBitMap(HInstance, PChar(modetofilestring(mode)))
 else if field = 'b8' then b8.Picture.bitmap.handle:=LoadBitMap(HInstance, PChar(modetofilestring(mode)))
 else if field = 'c1' then c1.Picture.bitmap.handle:=LoadBitMap(HInstance, PChar(modetofilestring(mode)))
 else if field = 'c2' then c2.Picture.bitmap.handle:=LoadBitMap(HInstance, PChar(modetofilestring(mode)))
 else if field = 'c3' then c3.Picture.bitmap.handle:=LoadBitMap(HInstance, PChar(modetofilestring(mode)))
 else if field = 'c4' then c4.Picture.bitmap.handle:=LoadBitMap(HInstance, PChar(modetofilestring(mode)))
 else if field = 'c5' then c5.Picture.bitmap.handle:=LoadBitMap(HInstance, PChar(modetofilestring(mode)))
 else if field = 'c6' then c6.Picture.bitmap.handle:=LoadBitMap(HInstance, PChar(modetofilestring(mode)))
 else if field = 'c7' then c7.Picture.bitmap.handle:=LoadBitMap(HInstance, PChar(modetofilestring(mode)))
 else if field = 'c8' then c8.Picture.bitmap.handle:=LoadBitMap(HInstance, PChar(modetofilestring(mode)));
 setgraphic := true;
end;

function tFormMain.checkfieldtoremove (field:string) : Boolean;
begin
switchplayer;
 if field = 'a1' then begin if fieldstatus.a1 = mpr then begin checkfieldtoremove := true; exit; end; end
 else if field = 'a2' then begin if fieldstatus.a2 = mpr then begin checkfieldtoremove := true; exit; end; end
 else if field = 'a3' then begin if fieldstatus.a3 = mpr then begin checkfieldtoremove := true; exit; end; end
 else if field = 'a4' then begin if fieldstatus.a4 = mpr then begin checkfieldtoremove := true; exit; end; end
 else if field = 'a5' then begin if fieldstatus.a5 = mpr then begin checkfieldtoremove := true; exit; end; end
 else if field = 'a6' then begin if fieldstatus.a6 = mpr then begin checkfieldtoremove := true; exit; end; end
 else if field = 'a7' then begin if fieldstatus.a7 = mpr then begin checkfieldtoremove := true; exit; end; end
 else if field = 'a8' then begin if fieldstatus.a8 = mpr then begin checkfieldtoremove := true; exit; end; end
 else if field = 'b1' then begin if fieldstatus.b1 = mpr then begin checkfieldtoremove := true; exit; end; end
 else if field = 'b2' then begin if fieldstatus.b2 = mpr then begin checkfieldtoremove := true; exit; end; end
 else if field = 'b3' then begin if fieldstatus.b3 = mpr then begin checkfieldtoremove := true; exit; end; end
 else if field = 'b4' then begin if fieldstatus.b4 = mpr then begin checkfieldtoremove := true; exit; end; end
 else if field = 'b5' then begin if fieldstatus.b5 = mpr then begin checkfieldtoremove := true; exit; end; end
 else if field = 'b6' then begin if fieldstatus.b6 = mpr then begin checkfieldtoremove := true; exit; end; end
 else if field = 'b7' then begin if fieldstatus.b7 = mpr then begin checkfieldtoremove := true; exit; end; end
 else if field = 'b8' then begin if fieldstatus.b8 = mpr then begin checkfieldtoremove := true; exit; end; end
 else if field = 'c1' then begin if fieldstatus.c1 = mpr then begin checkfieldtoremove := true; exit; end; end
 else if field = 'c2' then begin if fieldstatus.c2 = mpr then begin checkfieldtoremove := true; exit; end; end
 else if field = 'c3' then begin if fieldstatus.c3 = mpr then begin checkfieldtoremove := true; exit; end; end
 else if field = 'c4' then begin if fieldstatus.c4 = mpr then begin checkfieldtoremove := true; exit; end; end
 else if field = 'c5' then begin if fieldstatus.c5 = mpr then begin checkfieldtoremove := true; exit; end; end
 else if field = 'c6' then begin if fieldstatus.c6 = mpr then begin checkfieldtoremove := true; exit; end; end
 else if field = 'c7' then begin if fieldstatus.c7 = mpr then begin checkfieldtoremove := true; exit; end; end
 else if field = 'c8' then begin if fieldstatus.c8 = mpr then begin checkfieldtoremove := true; exit; end; end;

 checkfieldtoremove := false;
end;

// gibt die absoluten koordinaten für die spielbrettfelder zurück
procedure tFormMain.calcrelcord (x, y: Integer; var rgw_x,rgw_y:Integer);
begin
 rgw_x := x+spielbrett.left;
 rgw_y := y+spielbrett.top;
end;

function tFormMain.show_mnv : Boolean;
begin
 if CanMessageShow = true then MessageDlg('Zug nicht möglich!', mtInformation, [mbOk], 0);
 movenotvalid := true;
 show_mnv := true;
end;

// führt die jeweilige playerphase stone set routine aus
function tFormMain.fieldcheck (field: string) : Boolean;
begin
checkplayergamephase;

if playergamephase = 0 then
   begin
    if validmove('', field) = true then
     begin
      setfieldstatus_on_mpr(field);
      setgraphic(field, mpr);
      subsetstones();
      if getplayersetstones = 0 then incplayergamephase();
     end
    else show_mnv();
   end

else if playergamephase = 1 then
begin
// phase 2 routine
 begin
  if mms = '' then
   begin
    if not (isfieldzero(field)=true) then
     begin
      markedstone := true;
      // Stein markieren
       if fieldstatusonfield(field) = true then begin mms := field;  setgraphic(field, mpr); fieldcheck:= true; exit; end;
     end;
    end
    else if mms = field then begin markedstone := false; movenotvalid := true; setgraphic(field, mpr); mms := '';  end // stein demarkierung
    else
     begin
      if validmove (mms, field) = true then
       begin markedstone:= false; removestone(mms);  setpicturezero (mms); setfieldstatus_on_mpr(field); setgraphic(field, mpr); mms := ''; end
       else show_mnv;
     end;
end;
   end

else if playergamephase = 2 then
   begin
    if mms = '' then
     begin
     markedstone := true;
     // Stein markieren
      if fieldstatusonfield(field) = true then begin mms := field; setgraphic(field, mpr); fieldcheck:= true; exit; end;
     end
    else if mms = field then begin markedstone := false; movenotvalid := true; mms := ''; setgraphic(field, mpr); end // stein demarkierung
    else
     begin
      if validmove (mms, field) = true then
       begin markedstone := false; removestone(mms);  setpicturezero (mms); setfieldstatus_on_mpr(field); setgraphic(field, mpr); mms := ''; end
       else show_mnv;
     end;
   end;

fieldcheck := true;

if playergamephase = 1 then begin
if (isfieldzero(field)=true) then movenotvalid := true; end;

if playergamephase = 2 then begin
if (isfieldzero(field)=true) then movenotvalid := true; end;

end;

procedure TFormMain.FormCreate(Sender: TObject);
var a,b: Integer;
  Ini: TIniFile;
  chmFile: string;  // Hilfe variable
begin
  MusicPlayList := TWideStringList.Create();

  if(gtFileSystem.ExistsDirectory(gtFileSystem.GetApplicationPath + 'music\')=true) then
  begin
    gtFileSystem.GetFiles(gtFileSystem.GetApplicationPath + 'music\', '*.mp3', MusicPlayList, true);
    gtFileSystem.GetFiles(gtFileSystem.GetApplicationPath + 'music\', '*.wav', MusicPlayList, true);
    gtFileSystem.GetFiles(gtFileSystem.GetApplicationPath + 'music\', '*.midi', MusicPlayList, true);
    gtFileSystem.GetFiles(gtFileSystem.GetApplicationPath + 'music\', '*.mid', MusicPlayList, true);
    gtTWideStrings.ShuffleStringList(MusicPlayList);
  end;

  MusicListIndex := 0;

  chmFile := ExtractFilePath(ParamStr(0))+'gtmuehle.chm';

  mHHelp := nil;

  if not FileExists(chmFile) then
    ShowMessage('Hilfe-Datei nicht gefunden'#13+chmFile);

  {HH 1.2 oder höher Versionskontrolle}
  if (hh.HHCtrlHandle = 0) or (hh_funcs._hhMajVer < 4)
  or ((hh_funcs._hhMajVer = 4) and (hh_funcs._hhMinVer < 73)) then
      ShowMessage('Diese Anwendung erfordert die Installation der '+
      'MS HTML Help 1.2 oder höher');

  {Hook - verwendet HH_FUNCS.pas}
  mHHelp := hh_funcs.THookHelpSystem.Create(chmFile, '', htHHAPI);

  //Hilfe einbindung ende

  Ini := TIniFile.Create(gtFileSystem.GetApplicationPath+'gtmuehle.gtc');
  try
    if ini.ReadBool('audio', 'backgroundmusic', true) = true then
 begin
  if MusicPlayList.Count > 0 then OpenMusicFile(MusicPlayList[MusicListIndex])
  else begin
    //nichts geladen meldung
  end;
 end;
except
end;

if ini.ReadBool('system', 'double buffer', true) = true then FormMain.DoubleBuffered := false
else FormMain.DoubleBuffered := true;

Ini.Free;


// Verhindert sichtbare Bildschirmaktualiesierungen
//mainform.DoubleBuffered := true;

n1.Enabled := false;
Spielspeichern1.Enabled := false;

opendialog.InitialDir := ExtractFilePath(Application.ExeName)+'savegame\';
savedialog.InitialDir := ExtractFilePath(Application.ExeName)+'savegame\';

spielbrett.Left := (FormMain.Width div 2) - (spielbrett.Width div 2);
spielbrett.Top := (FormMain.Height div 2) - (spielbrett.Height div 2) -25;

statuslabel.Left := (spielbrett.left + (spielbrett.Width div 2)) - (statuslabel.Width div 2);
statuslabel.top := (spielbrett.Top + spielbrett.Height) - 25;

// Setzen der Felder auf die korrekten Positionen
calcrelcord(43,45, a, b); a1.left:=a; a1.top:=b;
calcrelcord(225,45, a, b); a2.left:=a; a2.top:=b;
calcrelcord(405,45, a, b); a3.left:=a; a3.top:=b;
calcrelcord(406,223, a, b); a4.left:=a; a4.top:=b;
calcrelcord(405,407, a, b); a5.left:=a; a5.top:=b;
calcrelcord(224,407, a, b); a6.left:=a; a6.top:=b;
calcrelcord(45,405, a, b); a7.left:=a; a7.top:=b;
calcrelcord(45,223, a, b); a8.left:=a; a8.top:=b;

calcrelcord(106,104, a, b); b1.left:=a; b1.top:=b;
calcrelcord(224,105, a, b); b2.left:=a; b2.top:=b;
calcrelcord(348,104, a, b); b3.left:=a; b3.top:=b;
calcrelcord(346,224, a, b); b4.left:=a; b4.top:=b;
calcrelcord(350,347, a, b); b5.left:=a; b5.top:=b;
calcrelcord(225,346, a, b); b6.left:=a; b6.top:=b;
calcrelcord(105,347, a, b); b7.left:=a; b7.top:=b;
calcrelcord(105,223, a, b); b8.left:=a; b8.top:=b;
     
calcrelcord(163,166, a, b); c1.left:=a; c1.top:=b;
calcrelcord(225,164, a, b); c2.left:=a; c2.top:=b;
calcrelcord(284,165, a, b); c3.left:=a; c3.top:=b;
calcrelcord(283,223, a, b); c4.left:=a; c4.top:=b;
calcrelcord(285,285, a, b); c5.left:=a; c5.top:=b;
calcrelcord(225,286, a, b); c6.left:=a; c6.top:=b;
calcrelcord(166,285, a, b); c7.left:=a; c7.top:=b;
calcrelcord(165,223, a, b); c8.left:=a; c8.top:=b;

// extra steine relativ anordnung
sb01.Left := FormMain.Width - 68; // Felder rechts oben
sb02.Left := FormMain.Width - 124;
sb03.Left := FormMain.Width - 68;
sb04.Left := FormMain.Width - 124;
sb05.Left := FormMain.Width - 68;
sb06.Left := FormMain.Width - 124;
sb07.Left := FormMain.Width - 68;
sb08.Left := FormMain.Width - 124;
sb09.Left := FormMain.Width - 68;

lsb01.top := FormMain.height - 108; // Felder links unten
lsb02.top := FormMain.height - 108;
lsb03.top := FormMain.height - 164;
lsb04.top := FormMain.height - 164;
lsb05.top := FormMain.height - 220;
lsb06.top := FormMain.height - 220;
lsb07.top := FormMain.height - 276;

lsw01.top := FormMain.height - 108; // Felder rechts unten
lsw02.top := FormMain.height - 108;
lsw03.top := FormMain.height - 164;
lsw04.top := FormMain.height - 164;
lsw05.top := FormMain.height - 220;
lsw06.top := FormMain.height - 220;
lsw07.top := FormMain.height - 276;
lsw01.left := FormMain.Width - 68; // Felder rechts unten
lsw02.left := FormMain.Width - 124;
lsw03.left := FormMain.Width - 68;
lsw04.left := FormMain.Width - 124;
lsw05.left := FormMain.Width - 68;
lsw06.left := FormMain.Width - 124;
lsw07.left := FormMain.Width - 68;
end;

procedure TFormMain.Beenden1Click(Sender: TObject);
begin
  FormMain.close;
end;


function TFormMain.setpicturezero (field:string) : Boolean;
begin
if field = 'a1' then a1.Picture.graphic := nil
else if field = 'a2' then a2.picture.graphic := nil
else if field = 'a3' then a3.picture.graphic := nil
else if field = 'a4' then a4.picture.graphic := nil
else if field = 'a5' then a5.picture.graphic := nil
else if field = 'a6' then a6.picture.graphic := nil
else if field = 'a7' then a7.picture.graphic := nil
else if field = 'a8' then a8.picture.graphic := nil
else if field = 'b1' then b1.picture.graphic := nil
else if field = 'b2' then b2.picture.graphic := nil
else if field = 'b3' then b3.picture.graphic := nil
else if field = 'b4' then b4.picture.graphic := nil
else if field = 'b5' then b5.picture.graphic := nil
else if field = 'b6' then b6.picture.graphic := nil
else if field = 'b7' then b7.picture.graphic := nil
else if field = 'b8' then b8.picture.graphic := nil
else if field = 'c1' then c1.picture.graphic := nil
else if field = 'c2' then c2.picture.graphic := nil
else if field = 'c3' then c3.picture.graphic := nil
else if field = 'c4' then c4.picture.graphic := nil
else if field = 'c5' then c5.picture.graphic := nil
else if field = 'c6' then c6.picture.graphic := nil
else if field = 'c7' then c7.picture.graphic := nil
else if field = 'c8' then c8.picture.graphic := nil;
setpicturezero := true;
end;

function tFormMain.refresh_field () : Boolean;
begin
//resetgamefield;
if not (fieldstatus.a1 = 0) then setgraphic('a1', fieldstatus.a1)
else setpicturezero('a1');
if not (fieldstatus.a2 = 0) then setgraphic('a2', fieldstatus.a2)
else setpicturezero('a2');
if not (fieldstatus.a3 = 0) then setgraphic('a3', fieldstatus.a3)
else setpicturezero('a3');
if not (fieldstatus.a4 = 0) then setgraphic('a4', fieldstatus.a4)
else setpicturezero('a4');
if not (fieldstatus.a5 = 0) then setgraphic('a5', fieldstatus.a5)
else setpicturezero('a5');
if not (fieldstatus.a6 = 0) then setgraphic('a6', fieldstatus.a6)
else setpicturezero('a6');
if not (fieldstatus.a7 = 0) then setgraphic('a7', fieldstatus.a7)
else setpicturezero('a7');
if not (fieldstatus.a8 = 0) then setgraphic('a8', fieldstatus.a8)
else setpicturezero('a8');
if not (fieldstatus.b1 = 0) then setgraphic('b1', fieldstatus.b1)
else setpicturezero('b1');
if not (fieldstatus.b2 = 0) then setgraphic('b2', fieldstatus.b2)
else setpicturezero('b2');
if not (fieldstatus.b3 = 0) then setgraphic('b3', fieldstatus.b3)
else setpicturezero('b3');
if not (fieldstatus.b4 = 0) then setgraphic('b4', fieldstatus.b4)
else setpicturezero('b4');
if not (fieldstatus.b5 = 0) then setgraphic('b5', fieldstatus.b5)
else setpicturezero('b5');
if not (fieldstatus.b6 = 0) then setgraphic('b6', fieldstatus.b6)
else setpicturezero('b6');
if not (fieldstatus.b7 = 0) then setgraphic('b7', fieldstatus.b7)
else setpicturezero('b7');
if not (fieldstatus.b8 = 0) then setgraphic('b8', fieldstatus.b8)
else setpicturezero('b8');
if not (fieldstatus.c1 = 0) then setgraphic('c1', fieldstatus.c1)
else setpicturezero('c1');
if not (fieldstatus.c2 = 0) then setgraphic('c2', fieldstatus.c2)
else setpicturezero('c2');
if not (fieldstatus.c3 = 0) then setgraphic('c3', fieldstatus.c3)
else setpicturezero('c3');
if not (fieldstatus.c4 = 0) then setgraphic('c4', fieldstatus.c4)
else setpicturezero('c4');
if not (fieldstatus.c5 = 0) then setgraphic('c5', fieldstatus.c5)
else setpicturezero('c5');
if not (fieldstatus.c6 = 0) then setgraphic('c6', fieldstatus.c6)
else setpicturezero('c6');
if not (fieldstatus.c7 = 0) then setgraphic('c7', fieldstatus.c7)
else setpicturezero('c7');
if not (fieldstatus.c8 = 0) then setgraphic('c8', fieldstatus.c8)
else setpicturezero('c8');
if playerstatus_white.setstones < 9 then sw09.Visible := false;
if playerstatus_white.setstones < 8 then sw08.Visible := false;
if playerstatus_white.setstones < 7 then sw07.Visible := false;
if playerstatus_white.setstones < 6 then sw06.Visible := false;
if playerstatus_white.setstones < 5 then sw05.Visible := false;
if playerstatus_white.setstones < 4 then sw04.Visible := false;
if playerstatus_white.setstones < 3 then sw03.Visible := false;
if playerstatus_white.setstones < 2 then sw02.Visible := false;
if playerstatus_white.setstones < 1 then sw01.Visible := false;

if playerstatus_black.setstones < 9 then sb09.Visible := false;
if playerstatus_black.setstones < 8 then sb08.Visible := false;
if playerstatus_black.setstones < 7 then sb07.Visible := false;
if playerstatus_black.setstones < 6 then sb06.Visible := false;
if playerstatus_black.setstones < 5 then sb05.Visible := false;
if playerstatus_black.setstones < 4 then sb04.Visible := false;
if playerstatus_black.setstones < 3 then sb03.Visible := false;
if playerstatus_black.setstones < 2 then sb02.Visible := false;
if playerstatus_black.setstones < 1 then sb01.Visible := false;

if playerstatus_white.stones < 9 then lsw01.visible := true;
if playerstatus_white.stones < 8 then lsw02.visible := true;
if playerstatus_white.stones < 7 then lsw03.visible := true;
if playerstatus_white.stones < 6 then lsw04.visible := true;
if playerstatus_white.stones < 5 then lsw05.visible := true;
if playerstatus_white.stones < 4 then lsw06.visible := true;
if playerstatus_white.stones < 3 then lsw07.visible := true;
if playerstatus_black.stones < 9 then lsb01.visible := true;
if playerstatus_black.stones < 8 then lsb02.visible := true;
if playerstatus_black.stones < 7 then lsb03.visible := true;
if playerstatus_black.stones < 6 then lsb04.visible := true;
if playerstatus_black.stones < 5 then lsb05.visible := true;
if playerstatus_black.stones < 4 then lsb06.visible := true;
if playerstatus_black.stones < 3 then lsb07.visible := true;
refresh_field := true;
end;

function TFormMain.executegamefunctions (field:string) : Boolean;
begin
//Computer speer überprüfung
if global_gamestatus.gamemodus = 2 then
begin
 //wenn spieler computer dran ist dann keine aktion (wegen spieler schumelt)
 if (mpr = 2) and (gamemode2com = false) then
 begin
  executegamefunctions := true;
  exit;
 end;
 gamemode2com := false;
end;

//Computer speer überprüfung
if global_gamestatus.gamemodus = 3 then
begin
 //wenn spieler computer dran ist dann keine aktion (wegen spieler schumlent)
 if (mpr = 1) and (gamemode2com = false) then
 begin
  executegamefunctions := true;
  exit;
 end;
 gamemode2com := false;
end;

//Computer speer überprüfung
if global_gamestatus.gamemodus = 4 then
begin
 //wenn spieler computer dran ist dann keine aktion (wegen spieler schumlent)
 if gamemode2com = false then
 begin
  executegamefunctions := true;
  exit;
 end;
 gamemode2com := false;
end;

//Computer speer überprüfung
if global_gamestatus.gamemodus = 5 then
begin
 if mpr = net.player then
 begin
 UDPGameClient.Host := net.AnotherIP;
 UDPGameClient.Active := true;
 UDPGameClient.Send(field); // hier muss auch der Port angegeben werden
 UDPGameClient.Active := false;
 end
 else if gamemode2com = false then
 begin
  executegamefunctions := true;
  exit;
 end;
 gamemode2com := false;
end;

if global_gamestatus.gamemodus <> 0 then
begin
 if removemode = false then
  begin
   fieldcheck(field);
// Playerphase 0 Eröffnung
    if playergamephase = 0 then
     begin
     if movenotvalid = false then begin
      if ismuehle(field) = true then
       begin
        maintimer.Enabled := false;
        if mpr = 1 then setstatuslabel('Spieler 1, bitte schwarzen Stein entfernen')
        else if mpr = 2 then setstatuslabel('Spieler 2, bitte weißen Stein entfernen');
        removemode := true;
       end
      else switchplayer;
     end else movenotvalid := false;
     end
// Playerphase 1 Mittelspiel
    else if playergamephase = 1 then
     begin
     if movenotvalid = false then begin
      if (ismuehle(field) = true) and (markedstone = false) then
       begin
        maintimer.Enabled := false;
        if mpr = 1 then setstatuslabel('Spieler 1, bitte schwarzen Stein entfernen')
        else if mpr = 2 then setstatuslabel('Spieler 2 bitte weißen Stein entfernen');
        removemode := true;
       end
      else if markedstone = false then switchplayer;
     end else movenotvalid := false;
     end
// Playergamephase 2 Endspiel
    else if playergamephase = 2 then
     begin
     if movenotvalid = false then begin
      if (ismuehle(field) = true) and (markedstone = false) then
       begin
        maintimer.Enabled := false;
        if mpr = 1 then setstatuslabel('Spieler 1, bitte schwarzen Stein entfernen')
        else if mpr = 2 then setstatuslabel('Spieler 2, bitte weißen Stein entfernen');
        removemode := true;
       end
      else if markedstone = false then switchplayer;
     end else movenotvalid := false;
     end;
  end
// Remove Mode Else
 else
  begin
  // switchplayer;
   if ((checkfieldtoremove(field) = true) and (ismuehle(field) = false)) then
    begin
     // switchlayer
     setfieldstatuszero(field);
     setpicturezero(field);
     if mpr = 1 then playerstatus_white.stones := playerstatus_white.stones-1
     else if mpr = 2 then playerstatus_black.stones := playerstatus_black.stones-1;
     addlosedstone;
     removemode := false;
     //switchplayer;
     maintimer.Enabled := true;
    end
// Alle Steine durch Mühlen blockiert
   else if (onlylockedstonesonfield=true) then begin switchplayer;
    if(checkfieldtoremove(field) = true) then
    begin
     //switchlayer
     setfieldstatuszero(field);
     setpicturezero(field);
     if mpr = 1 then playerstatus_white.stones := playerstatus_white.stones-1
     else if mpr = 2 then playerstatus_black.stones := playerstatus_black.stones-1;
     addlosedstone;
     removemode := false;
     //switchplayer;
     maintimer.Enabled := true;
    end;
    end else
         begin
          switchplayer;
          if ((checkfieldtoremove(field) = true) and (ismuehle(field) = true)) then
           begin
            if  mpr <> net.player then MessageDlg('Stein kann nicht aus einer Mühle enfernt werden!', mtInformation, [mbOk], 0);
           end;
          switchplayer;
         end;
  end;
end;

executegamefunctions := true;
end;

procedure TFormMain.a1Click(Sender: TObject);
begin
executegamefunctions('a1');
end;

procedure TFormMain.NeuesSpiel1Click(Sender: TObject);
begin
  FormGameNew.ShowModal;
end;

procedure TFormMain.maintimerTimer(Sender: TObject);
begin
// XCV
checkplayergamephase();

// verhindert den error das nach einer aus dieser mühle kann nichts
// genommen error der computer dran ist
if global_gamestatus.gamemodus = 2 then // spieler gegen computer dann
 begin
  // hier muss zug angefragt werden und definiert werden
  // wenn er mühle nehemen muss muss geschaut werden etc
  if mpr = 2 then comtimer.Enabled := true
  else comtimer.Enabled := false;
 end;

// verhindert den error das nach einer aus dieser mühle kann nichts
// genommen error der computer dran ist
if global_gamestatus.gamemodus = 3 then // spieler gegen computer dann
 begin
  // hier muss zug angefragt werden und definiert werden
  // wenn er mühle nehemen muss muss geschaut werden etc
  if mpr = 1 then comtimer2.Enabled := true
  else comtimer2.Enabled := false;
 end;

//if mainform.doublebuffered = true then mainform.caption := 'DB TRUE DB ONLINE'
//else mainform.caption := 'DB ALSE DB OFFLINE';
if (global_gamestatus.gamemodus = 0) or (global_gamestatus.gamemodus = 5) then
 begin
      n1.Enabled := false;
      Spielspeichern1.Enabled := false;
 end
else
 begin
      n1.Enabled := true;
      Spielspeichern1.Enabled := true;
 end;

if global_gamestatus.gamemodus = 1 then
 begin
  if mpr = 1 then setstatuslabel('Spieler 1 (Weiß) am Zug')
  else if mpr = 2 then setstatuslabel('Spieler 2 (Schwarz) am Zug');

  // Überprüft ob noch ein Zug möglich ist
  if canplayermove() = false then
  begin
   if mpr = 1 then playerstatus_white.stones := 2
   else if mpr = 2 then playerstatus_black.stones := 2;
  end;

  if playerstatus_white.stones = 2 then
  begin
   global_gamestatus.gamemodus := 0;
   setstatuslabel('Spieler 2 (Schwarz) hat gewonnen');
  end
  else if playerstatus_black.stones = 2 then
  begin
   global_gamestatus.gamemodus := 0;
   setstatuslabel('Spieler 1 (Weiß) hat gewonnen');
  end;
 end;

//gamemode netzwerk LAN
if global_gamestatus.gamemodus = 5 then
 begin
  if mpr = 1 then setstatuslabel('Spieler 1 (Weiß) am Zug')
  else if mpr = 2 then setstatuslabel('Spieler 2 (Schwarz) am Zug');

  // Überprüft ob noch ein Zug möglich ist
  if canplayermove() = false then
  begin
   if mpr = 1 then playerstatus_white.stones := 2
   else if mpr = 2 then playerstatus_black.stones := 2;
  end;

  if playerstatus_white.stones = 2 then
  begin
   global_gamestatus.gamemodus := 0;
   setstatuslabel('Spieler 2 (Schwarz) hat gewonnen');
  end
  else if playerstatus_black.stones = 2 then
  begin
   global_gamestatus.gamemodus := 0;
   setstatuslabel('Spieler 1 (Weiß) hat gewonnen');
  end;
 end;
//gamemode netzwerk offline

if global_gamestatus.gamemodus = 2 then
 begin
  if mpr = 1 then setstatuslabel('Spieler 1 (Weiß) am Zug')
  else if mpr = 2 then setstatuslabel('Computer (Schwarz) am Zug');

  // Überprüft ob noch ein Zug möglich ist
  if canplayermove() = false then
  begin
   if mpr = 1 then playerstatus_white.stones := 2
   else if mpr = 2 then playerstatus_black.stones := 2;
  end;

  if playerstatus_white.stones = 2 then
  begin
   global_gamestatus.gamemodus := 0;
   setstatuslabel('Computer (Schwarz) hat gewonnen');
  end
  else if playerstatus_black.stones = 2 then
  begin
   global_gamestatus.gamemodus := 0;
   setstatuslabel('Spieler 1 (Weiß) hat gewonnen');
  end;
 end;

if global_gamestatus.gamemodus = 3 then
 begin
  if mpr = 1 then setstatuslabel('Computer (Weiß) am Zug')
  else if mpr = 2 then setstatuslabel('Spieler 2 (Schwarz) am Zug');

  // Überprüft ob noch ein Zug möglich ist
  if canplayermove() = false then
  begin
   if mpr = 1 then playerstatus_white.stones := 2
   else if mpr = 2 then playerstatus_black.stones := 2;
  end;

  if playerstatus_white.stones = 2 then
  begin
   global_gamestatus.gamemodus := 0;
   setstatuslabel('Spieler 2 (Schwarz) hat gewonnen');
  end
  else if playerstatus_black.stones = 2 then
  begin
   global_gamestatus.gamemodus := 0;
   setstatuslabel('Computer (Weiß) hat gewonnen');
  end;
 end;

if global_gamestatus.gamemodus = 4 then
 begin
  if mpr = 1 then setstatuslabel('Computer (Weiß) am Zug')
  else if mpr = 2 then setstatuslabel('Computer (Schwarz) am Zug');

  // Überprüft ob noch ein Zug möglich ist
  if canplayermove() = false then
  begin
   if mpr = 1 then playerstatus_white.stones := 2
   else if mpr = 2 then playerstatus_black.stones := 2;
  end;

  if playerstatus_white.stones = 2 then
  begin
   global_gamestatus.gamemodus := 0;
   setstatuslabel('Computer (Schwarz) hat gewonnen');
  end
  else if playerstatus_black.stones = 2 then
  begin
   global_gamestatus.gamemodus := 0;
   setstatuslabel('Computer (Weiß) hat gewonnen');
  end;
 end;
end;

procedure TFormMain.a2Click(Sender: TObject);
begin
executegamefunctions('a2');
end;

procedure TFormMain.a3Click(Sender: TObject);
begin
executegamefunctions('a3');
end;

procedure TFormMain.a4Click(Sender: TObject);
begin
executegamefunctions('a4');
end;

procedure TFormMain.a5Click(Sender: TObject);
begin
executegamefunctions('a5');
end;

procedure TFormMain.a6Click(Sender: TObject);
begin
executegamefunctions('a6');
end;

procedure TFormMain.a7Click(Sender: TObject);
begin
executegamefunctions('a7');
end;

procedure TFormMain.a8Click(Sender: TObject);
begin
executegamefunctions('a8');
end;

procedure TFormMain.b1Click(Sender: TObject);
begin
executegamefunctions('b1');
end;

procedure TFormMain.b2Click(Sender: TObject);
begin
executegamefunctions('b2');
end;

procedure TFormMain.b3Click(Sender: TObject);
begin
executegamefunctions('b3');
end;

procedure TFormMain.b4Click(Sender: TObject);
begin
executegamefunctions('b4');
end;

procedure TFormMain.b5Click(Sender: TObject);
begin
executegamefunctions('b5');
end;

procedure TFormMain.b6Click(Sender: TObject);
begin
executegamefunctions('b6');
end;

procedure TFormMain.b7Click(Sender: TObject);
begin
executegamefunctions('b7');
end;

procedure TFormMain.b8Click(Sender: TObject);
begin
executegamefunctions('b8');
end;

procedure TFormMain.c1Click(Sender: TObject);
begin
executegamefunctions('c1');
end;

procedure TFormMain.c2Click(Sender: TObject);
begin
executegamefunctions('c2');
end;

procedure TFormMain.c3Click(Sender: TObject);
begin
executegamefunctions('c3');
end;

procedure TFormMain.c4Click(Sender: TObject);
begin
executegamefunctions('c4');
end;

procedure TFormMain.c5Click(Sender: TObject);
begin
executegamefunctions('c5');
end;

procedure TFormMain.c6Click(Sender: TObject);
begin
executegamefunctions('c6');
end;

procedure TFormMain.c7Click(Sender: TObject);
begin
executegamefunctions('c7');
end;

procedure TFormMain.c8Click(Sender: TObject);
begin
executegamefunctions('c8');
end;

procedure TFormMain.ber1Click(Sender: TObject);
begin
  FormAbout.ShowModal;
end;

function TFormMain.savegame(stream: TFileStream) : Boolean;
var
  sign : Word;
 i : Cardinal;
begin
// Global Technology Format Descriptor
  stream.Write(PChar('GTFD')^, Length('GTFD'));
// Format Kennung
  sign := 0; for i:=1 to 4 do stream.Write(sign, 1);
// Format Versions Kennung
  sign := 0; for i:=1 to 2 do stream.Write(sign, 1);
// fieldstatus
  sign := fieldstatus.a1; stream.write(sign,1);
  sign := fieldstatus.a2; stream.write(sign,1);
  sign := fieldstatus.a3; stream.write(sign,1);
  sign := fieldstatus.a4; stream.write(sign,1);
  sign := fieldstatus.a5; stream.write(sign,1);
  sign := fieldstatus.a6; stream.write(sign,1);
  sign := fieldstatus.a7; stream.write(sign,1);
  sign := fieldstatus.a8; stream.write(sign,1);
  sign := fieldstatus.b1; stream.write(sign,1);
  sign := fieldstatus.b2; stream.write(sign,1);
  sign := fieldstatus.b3; stream.write(sign,1);
  sign := fieldstatus.b4; stream.write(sign,1);
  sign := fieldstatus.b5; stream.write(sign,1);
  sign := fieldstatus.b6; stream.write(sign,1);
  sign := fieldstatus.b7; stream.write(sign,1);
  sign := fieldstatus.b8; stream.write(sign,1);
  sign := fieldstatus.c1; stream.write(sign,1);
  sign := fieldstatus.c2; stream.write(sign,1);
  sign := fieldstatus.c3; stream.write(sign,1);
  sign := fieldstatus.c4; stream.write(sign,1);
  sign := fieldstatus.c5; stream.write(sign,1);
  sign := fieldstatus.c6; stream.write(sign,1);
  sign := fieldstatus.c7; stream.write(sign,1);
  sign := fieldstatus.c8; stream.write(sign,1);
// gamemode
  sign := global_gamestatus.gamemodus; stream.write(sign,1);
// mpr
  sign := mpr; stream.write(sign,1);
// Player 1 Setstones
  sign := playerstatus_white.setstones; stream.write(sign,1);
// Player 1 Stones
  sign := playerstatus_white.stones; stream.write(sign,1);
// Player 1 gamephase
  sign := playerstatus_white.gamephase; stream.write(sign,1);
// Player 2 Setstones
  sign := playerstatus_black.setstones; stream.write(sign,1);
// Player 2 Stones
  sign := playerstatus_black.stones; stream.write(sign,1);
// Player 2 gamephase
  sign := playerstatus_black.gamephase; stream.write(sign,1);
// Player 1 Computer ID;
// if global_gamestatus = 1 then
  aidllname := aidllname1;
  stream.Write(PChar(SSFGetAIInfo(8))^, Length('ALK8'));
// else
// Player 2 Computer ID;
  aidllname := aidllname2; 
  stream.Write(PChar(SSFGetAIInfo(8))^, Length('SFEH'));
// checksumme
  sign := mpr + global_gamestatus.gamemodus; stream.write(sign,1);
  sign := playerstatus_white.gamephase +
          playerstatus_white.stones +
          playerstatus_white.setstones;
          stream.Write(sign,1);
  sign := playerstatus_black.gamephase +
          playerstatus_black.stones +
          playerstatus_black.setstones;
          stream.Write(sign,1);
  sign := fieldstatus.a1 + fieldstatus.a2 + fieldstatus.a3 + fieldstatus.a4 +
          fieldstatus.a5 + fieldstatus.a6 + fieldstatus.a7 + fieldstatus.a8 +
          fieldstatus.b1 + fieldstatus.b2 + fieldstatus.b3 + fieldstatus.b4 +
          fieldstatus.b5 + fieldstatus.b6 + fieldstatus.b7 + fieldstatus.b8 +
          fieldstatus.c1 + fieldstatus.c2 + fieldstatus.c3 + fieldstatus.c4 +
          fieldstatus.c5 + fieldstatus.c6 + fieldstatus.c7 + fieldstatus.c8;
          stream.Write(sign,1);
savegame := true;
end;

procedure TFormMain.N1Click(Sender: TObject);
var
 stream : TFileStream;
begin
// constructor Create(const FileName: string; Mode: Word);
// function Write(const Buffer; Count: Longint): Longint; override;
if removemode = true then begin MessageDlg('Das Spiel kann nicht gespeichert werden. Entfernen Sie zuerst einen Spielstein.',
 mtInformation, [mbOk], 0); exit; end;

if savedialog.Execute then
 begin
  stream := TFileStream.Create(savedialog.FileName, fmCreate or fmShareDenyNone);
  savegame(stream);
  stream.Free;
 end;
end;

procedure TFormMain.Spielffnen1Click(Sender: TObject);
var
 stream: TFileStream;
 sign : Word;
 i : Cardinal;
 readstring: string;
// tmpnumbstr: string;
begin
if opendialog.Execute then
begin
// maintimer.enabled := false;
 stream := TFileStream.Create(opendialog.filename, fmOpenRead or fmShareDenyNone);
try

// Global Technology Format Descriptor
  readstring := EmptyStr;
  setlength(readstring, 4);
  stream.read(readstring[1], 4);
// filetostring(opendialog.filename, 4, readstring, stream);
 if not (readstring='GTFD') then
  begin
   MessageDlg('Diese Datei ist keine gültige GTM Datei!', mtInformation, [mbOk], 0);
   exit;
  end;

// Format Number
readstring := '';
for I:=1 to 4 do
begin
 stream.read(sign, 1);
 readstring := readstring + inttostr(sign);
end;
 if not (readstring='0000') then
  begin
   MessageDlg('Diese Datei ist keine gültige GTM Datei!', mtInformation, [mbOk], 0);
   exit;
  end;

// Version String
readstring := '';
for I:=1 to 2 do
begin
 stream.read(sign, 1);
 readstring := readstring + inttostr(sign);
end;
 if not (readstring='00') then
  begin
   MessageDlg('Diese Datei wurde mit einer neueren Version von GT Mühle erstellt.', mtInformation, [mbOk], 0);
   exit;
  end;

resetgamefield;
// Fieldspace Zuweisung
stream.read(sign, 1);
fieldstatus.a1 := sign;
//sign:=0;
stream.read(sign, 1);
fieldstatus.a2 := sign;
stream.read(sign, 1);
fieldstatus.a3 := sign;
stream.read(sign, 1);
fieldstatus.a4 := sign;
stream.read(sign, 1);
fieldstatus.a5 := sign;
stream.read(sign, 1);
fieldstatus.a6 := sign;
stream.read(sign, 1);
fieldstatus.a7 := sign;
stream.read(sign, 1);
fieldstatus.a8 := sign;
stream.read(sign, 1);
fieldstatus.b1 := sign;
stream.read(sign, 1);
fieldstatus.b2 := sign;
stream.read(sign, 1);
fieldstatus.b3 := sign;
stream.read(sign, 1);
fieldstatus.b4 := sign;
stream.read(sign, 1);
fieldstatus.b5 := sign;
stream.read(sign, 1);
fieldstatus.b6 := sign;
stream.read(sign, 1);
fieldstatus.b7 := sign;
stream.read(sign, 1);
fieldstatus.b8 := sign;
stream.read(sign, 1);
fieldstatus.c1 := sign;
stream.read(sign, 1);
fieldstatus.c2 := sign;
stream.read(sign, 1);
fieldstatus.c3 := sign;
stream.read(sign, 1);
fieldstatus.c4 := sign;
stream.read(sign, 1);
fieldstatus.c5 := sign;
stream.read(sign, 1);
fieldstatus.c6 := sign;
stream.read(sign, 1);
fieldstatus.c7 := sign;
stream.read(sign, 1);
fieldstatus.c8 := sign;

// gamemode
stream.read(sign, 1);
global_gamestatus.gamemodus := sign;

// mpr
stream.read(sign, 1);
mpr := sign;

// p1 setstones
stream.read(sign, 1);
playerstatus_white.setstones := sign;

// p1 stones
stream.read(sign, 1);
playerstatus_white.stones := sign;

// p1 gamemode
stream.read(sign, 1);
playerstatus_white.gamephase := sign;

// p2 setstones
stream.read(sign, 1);
playerstatus_black.setstones := sign;

// p2 stones
stream.read(sign, 1);
playerstatus_black.stones := sign;

// p2 gamemode
stream.read(sign, 1);
playerstatus_black.gamephase := sign;

// Computer Player 1 ID
  readstring := EmptyStr;
  setlength(readstring, 4);
  stream.read(readstring[1], 4);
  aidllname1 := GetAIFilename(readstring);

// Computer Player 2 ID
  readstring := EmptyStr;
  setlength(readstring, 4);
  stream.read(readstring[1], 4);
  aidllname2 := GetAIFilename(readstring);


//checksumme
stream.Read(sign,1);
 if (sign<>(mpr + global_gamestatus.gamemodus))then
  begin
   resetgamefield;
   MessageDlg('Die Spielstand Datei wurde manipuliert! (PB01)', mtInformation, [mbOk], 0);
   exit;
  end;

stream.Read(sign,1);
 if (sign<>(playerstatus_white.gamephase +
          playerstatus_white.stones +
          playerstatus_white.setstones))then
  begin
   resetgamefield;
   MessageDlg('Die Spielstand Datei wurde manipuliert! (PB02)', mtInformation, [mbOk], 0);
   exit;
  end;

stream.Read(sign,1);
 if (sign<>(playerstatus_black.gamephase +
          playerstatus_black.stones +
          playerstatus_black.setstones))then
  begin
   resetgamefield;
   MessageDlg('Die Spielstand Datei wurde manipuliert! (PB03)', mtInformation, [mbOk], 0);
   exit;
  end;

stream.Read(sign,1);
 if (sign<>(fieldstatus.a1 + fieldstatus.a2 + fieldstatus.a3 + fieldstatus.a4 +
          fieldstatus.a5 + fieldstatus.a6 + fieldstatus.a7 + fieldstatus.a8 +
          fieldstatus.b1 + fieldstatus.b2 + fieldstatus.b3 + fieldstatus.b4 +
          fieldstatus.b5 + fieldstatus.b6 + fieldstatus.b7 + fieldstatus.b8 +
          fieldstatus.c1 + fieldstatus.c2 + fieldstatus.c3 + fieldstatus.c4 +
          fieldstatus.c5 + fieldstatus.c6 + fieldstatus.c7 + fieldstatus.c8))then
  begin
     resetgamefield;
   MessageDlg('Die Spielstand Datei wurde manipuliert! (PB04)', mtInformation, [mbOk], 0);
   exit;
  end;  

refresh_field;


// mainform.Caption := 'A' + readstring + 'A';
 //mainform.caption := inttostr(sign);
 //mainform.caption := tmpnumbstr;
finally
 stream.Free;
end;
end;

end;


procedure TFormMain.Spielspeichern1Click(Sender: TObject);
var
 stream: TFileStream;
begin
if (savedialog.filename = '') then N1Click(Sender)
else
begin
  stream := TFileStream.Create(savedialog.FileName, fmCreate or fmShareDenyNone);
  savegame(stream);
  stream.Free;
end;
end;

procedure TFormMain.Optionen1Click(Sender: TObject);
begin
  uFormOptions.FormOptions.ShowModal;
end;

procedure TFormMain.comtimerTimer(Sender: TObject);
var rcbc: cbc; //rückgabewert
begin
if global_gamestatus.gamemodus = 2 then // spieler gegen computer dann
 begin
  // hier muss zug angefragt werden und definiert werden
  // wenn er mühle nehemen muss muss geschaut werden etc
  if mpr = 2 then
  begin
   try
    aidllname := aidllname1; // zuweisen der ersten ai
    rcbc := SSFGetMove (fieldstatus, mpr, playergamephase, removemode);
    //mainform.caption := rcbc.cbc01 + rcbc.cbc02;
   except
   end;
   if rcbc.cbc01 <> '' then
   begin
    gamemode2com := true;
    executegamefunctions(rcbc.cbc01);
   end;

   if rcbc.cbc02 <> '' then
   begin
    gamemode2com := true;
    executegamefunctions(rcbc.cbc02);
   end;
  end;
 end;
 
end;

procedure TFormMain.comtimer2Timer(Sender: TObject);
var rcbc: cbc; //rückgabewert
begin
if global_gamestatus.gamemodus = 3 then // computer gegen spieler dann
 begin
  // hier muss zug angefragt werden und definiert werden
  // wenn er mühle nehemen muss muss geschaut werden etc
  if mpr = 1 then
  begin
   try
    aidllname := aidllname1; // zuweisen der ersten ai
    rcbc := SSFGetMove (fieldstatus, mpr, playergamephase, removemode);
    //mainform.caption := rcbc.cbc01 + rcbc.cbc02;
   except
   end;
   if rcbc.cbc01 <> '' then
   begin
    gamemode2com := true;
    executegamefunctions(rcbc.cbc01);
   end;

   if rcbc.cbc02 <> '' then
   begin
    gamemode2com := true;
    executegamefunctions(rcbc.cbc02);
   end;
  end;
 end;

end;

procedure TFormMain.comtimer3Timer(Sender: TObject);
var rcbc: cbc; //rückgabewert
begin
if global_gamestatus.gamemodus = 4 then // computer gegen computer dann
 begin
  // hier muss zug angefragt werden und definiert werden
  // wenn er mühle nehemen muss muss geschaut werden etc
  if mpr = 1 then
  begin
   try
    aidllname := aidllname1; // zuweisen der ersten ai
    rcbc := SSFGetMove (fieldstatus, mpr, playergamephase, removemode);
    //mainform.caption := rcbc.cbc01 + rcbc.cbc02;
   except
   end;
   if rcbc.cbc01 <> '' then
   begin
    gamemode2com := true;
    executegamefunctions(rcbc.cbc01);
   end;

   if rcbc.cbc02 <> '' then
   begin
    gamemode2com := true;
    executegamefunctions(rcbc.cbc02);
   end;
  end
  else if mpr = 2 then
  begin
   try
    aidllname := aidllname2; // zuweisen der zweiten ai
    rcbc := SSFGetMove (fieldstatus, mpr, playergamephase, removemode);
    //mainform.caption := rcbc.cbc01 + rcbc.cbc02;
   except
   end;
   if rcbc.cbc01 <> '' then
   begin
    gamemode2com := true;
    executegamefunctions(rcbc.cbc01);
   end;

   if rcbc.cbc02 <> '' then
   begin
    gamemode2com := true;
    executegamefunctions(rcbc.cbc02);
   end;
  end;


 end;

end;

procedure TFormMain.FormDestroy(Sender: TObject);
begin
  HHCloseAll; // Schließt alle Hilfe-Fenster
  if Assigned(mHHelp) then mHHelp.Free;

  FilterGraph.ClearGraph;
  MusicPlayList.Free;
end;

procedure TFormMain.Inhalt1Click(Sender: TObject);
begin
 Application.HelpContext(10);
end;

procedure TFormMain.HilfezurHilfe1Click(Sender: TObject);
begin
 Application.HelpFile := ExtractFilePath(Application.ExeName) + 'gtmuehle.chm';
 Application.HelpCommand(HELP_HELPONHELP, 0);
end;

procedure TFormMain.UPDGameServerUDPRead(Sender: TObject; AData: TBytes;
  ABinding: TIdSocketHandle);
var
  S: String;
  i: Integer;
begin
  S:='';
  for i:=Low(AData) to High(AData) do
    S:=S + Chr(AData[i]);
  // Umwandeln der Anfrage
  //if not mpr = net.player then
  gamemode2com := true;
  executegamefunctions(s);
end;

procedure TFormMain.FilterGraphGraphComplete(sender: TObject;
  Result: HRESULT; Renderer: IBaseFilter);
begin
  Inc(MusicListIndex);
  if(MusicListIndex >= MusicPlayList.Count) then MusicListIndex := 0;
  OpenMusicFile(MusicPlayList[MusicListIndex]);
end;

end.
