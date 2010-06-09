unit pongpong01;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, dglOpenGL, Textures, StdCtrls, ExtCtrls, gtcl_PongBoard;

type
  Tmainform = class(TForm)
    maintimer: TTimer;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure FormMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure maintimerTimer(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    private
     { Private-Deklarationen }
    public
     procedure Render(Sender : TObject; var Done : Boolean);
     procedure Render_stateInGame(Sender : TObject);

     // Font Engine
     procedure BuildFont(pFontName : String);
     procedure PrintText(pX,pY : Integer; const pText : String);
     procedure ShowTextInGame;

   end;

const
 // Größe des Viewports
 SizeX   : Double = 1;
 SizeY   : Double = 1;

 stateMainMenu  = $00;
 stateInGame    = $01;

var
 mainform   : Tmainform;
 DC         : HDC;
 RC         : HGLRC;
 Rotation   : Single;

 TexPad: glUInt;
 TexBall: glUInt;
 TexBackground: glUInt;
 TexOffset: Single;

 // Pfadvariablen
 texpfad: string = 'xdata\';

 // Pong Klasse
 PongGame: TPongBoard;

 //Statemachine
 CurrentState: Word;   // Die Szene in der unsere Statemachine sich gerade befindet

 //FontEngine
 FontBase  : GLUInt;

 //Frames
 StartTick : Cardinal;
 Frames    : Integer;
 FPS       : Single;


implementation

{$R *.dfm}
// Font Engine

// =============================================================================
//  TForm1.BuildFont
// =============================================================================
//  Displaylisten für Bitmapfont erstellen
// =============================================================================
procedure TMainForm.BuildFont(pFontName : String);
var
 Font : HFONT;
begin
// Displaylisten für 256 Zeichen erstellen
FontBase := glGenLists(96);
// Fontobjekt erstellen
Font     := CreateFont(16, 0, 0, 0, FW_MEDIUM, 0, 0, 0, ANSI_CHARSET, OUT_TT_PRECIS, CLIP_DEFAULT_PRECIS,
                       ANTIALIASED_QUALITY, FF_DONTCARE or DEFAULT_PITCH, PChar(pFontName));
// Fontobjekt als aktuell setzen
SelectObject(DC, Font);
// Displaylisten erstellen
wglUseFontBitmaps(DC, 0, 256, FontBase);
// Fontobjekt wieder freigeben
DeleteObject(Font)
end;

// =============================================================================
//  TForm1.PrintText
// =============================================================================
//  Gibt einen Text an Position x/y aus
// =============================================================================
procedure TMainForm.PrintText(pX,pY : Integer; const pText : String);
begin
if (pText = '') then
 exit;
glPushAttrib(GL_LIST_BIT);
 glRasterPos2i(pX, pY);
 glListBase(FontBase);
 glCallLists(Length(pText), GL_UNSIGNED_BYTE, PChar(pText));
glPopAttrib;
end;

// =============================================================================
//  TForm1.ShowText
// =============================================================================
//  FPS, Hilfstext usw. ausgeben
// =============================================================================
procedure TMainForm.ShowTextInGame;
begin
// Tiefentest und Texturierung für Textanzeige deaktivieren
glDisable(GL_DEPTH_TEST);
glDisable(GL_TEXTURE_2D);
// In orthagonale (2D) Ansicht wechseln
glMatrixMode(GL_PROJECTION);
glLoadIdentity;
glOrtho(0,640,480,0, -1,1);
glMatrixMode(GL_MODELVIEW);
glLoadIdentity;
 PrintText(5, 10, 'Punkte: ' + IntToStr(PongGame.p2Score));
 PrintText(5, 470, 'Punkte: ' + IntToStr(PongGame.p1Score));
 //PrintText(5,30, 'FPS: ' + IntToStr(Round(FPS)));

// Debug Level
 PrintText(500, 10, 'Pong Pong v1.0 Alpha Debug');
 PrintText(500, 20, 'FPS: '+ IntToStr(Round(FPS))); //+ FloatToStr(FPS));
 PrintText(500, 30, 'Speed: '+ IntToStr(maintimer.Interval));
glEnable(GL_DEPTH_TEST);
glEnable(GL_TEXTURE_2D);
end;



// Font Engine Out

procedure SetState(state: Word);
begin
 CurrentState := state;
end;

// =============================================================================
//   DrawQuad
// =============================================================================
//   Kleine Routine die ein Quad rendert. Da wir das öfters brauchen ist das
//   sehr praktisch.
// =============================================================================
procedure DrawQuad(pX, pY, pZ, pWidth, pHeight : Single);
begin
glBegin(GL_QUADS);
 glTexCoord2f(0,0); glVertex3f(pX-pWidth/2, pY-pHeight/2, -pZ);
 glTexCoord2f(1,0); glVertex3f(pX+pWidth/2, pY-pHeight/2, -pZ);
 glTexCoord2f(1,1); glVertex3f(pX+pWidth/2, pY+pHeight/2, -pZ);
 glTexCoord2f(0,1); glVertex3f(pX-pWidth/2, pY+pHeight/2, -pZ);
 {glTexCoord2f(0,0); glVertex3f(pX, pY, pZ);
 glTexCoord2f(1,0); glVertex3f(pX+pWidth, pY, pZ);
 glTexCoord2f(1,1); glVertex3f(pX+pWidth, pY+pHeight, pZ);
 glTexCoord2f(0,1); glVertex3f(pX, pY+pHeight, pZ);
 //glVertex2d(1, 1);                }
glEnd;
end;

// =============================================================================
// Tmainform.Create
// =============================================================================
// Initialisierung des Programmes
// =============================================================================
procedure Tmainform.FormCreate(Sender: TObject);
begin
 // Schaltet auf den ganzen Schirm. Auskommentieren um im Fenster laufen zu lassen
 WindowState := wsMaximized;
 BorderStyle := bsNone;

 InitOpenGL;
 DC := GetDC(Handle);
 RC := CreateRenderingContext(DC, [opDoubleBuffered], 32, 24, 0, 0, 0, 0);
 ActivateRenderingContext(DC, RC);

 // Auch in 2D werden wir den Z-Puffer (und Tiefentest) nutzen, denn damit sparen
 // wir uns das eigenhändige Sortieren von Objekten anhand ihres Layers
 glEnable(GL_DEPTH_TEST);
 glDepthFunc(GL_LESS);
 glEnable(GL_TEXTURE_2D);
 glEnable(GL_ALPHA_TEST);
 glAlphaFunc(GL_GREATER, 0.1);

 // On Idle Event definieren
 Application.OnIdle := Render;

 // Pong Klasse initialisieren
 PongGame := TPongBoard.Create;
 PongGame.StartNewGame(1);
 SetState(stateInGame);

 // Texturen laden
 LoadTexture(texpfad + 'pad.tga', TexPad, False);
 LoadTexture(texpfad + 'ball.tga', TexBall, False);
 LoadTexture(texpfad + 'background.jpg', TexBackground, False);

 // Mauszeiger zentrieren
 SetCursorPos((ClientWidth div 2), 0);

 // Displayfont erstellen
 BuildFont('Denmark');

 // Mauscursor deaktiveren
 //ShowCursor(FALSE);
end;

// =============================================================================
//   TGLForm.FormDestroy
// =============================================================================
procedure Tmainform.FormDestroy(Sender: TObject);
begin
 PongGame.Free;
 DeactivateRenderingContext;
 DestroyRenderingContext(RC);
 ReleaseDC(Handle, DC);
end;

// =============================================================================
//   TGLForm.Render / stateInGame
// =============================================================================
procedure Tmainform.Render_stateInGame(Sender : TObject);
begin
 glClear(GL_DEPTH_BUFFER_BIT);
 glMatrixMode(GL_PROJECTION);
 glLoadIdentity;
 glViewport(0,0,ClientWidth,ClientHeight);
 glOrtho(0, SizeX, 0, SizeY, 0, 128);
 glMatrixMode(GL_MODELVIEW);
 glLoadIdentity;

 glClear(GL_COLOR_BUFFER_BIT);
 glBindTexture(GL_TEXTURE_2D, TexBackground);
 DrawQuad(0.5, 0.5, 10, 1, 1);


 glBindTexture(GL_TEXTURE_2D, TexPad);
 DrawQuad(PongGame.p1Pos.x, PongGame.p1Pos.y, 5, 0.1, 0.025);   // player 1
 DrawQuad(PongGame.p2Pos.x, PongGame.p2Pos.y, 5, 0.1, 0.025);   // player 2

 glBindTexture(GL_TEXTURE_2D, TexBall);
 DrawQuad(PongGame.BallPos.x, PongGame.BallPos.y, 5, 0.010, 0.010);   // ball

 // Score
 ShowTextInGame;

 SwapBuffers(DC);
end;

// =============================================================================
//   TGLForm.Render
// =============================================================================
procedure Tmainform.Render(Sender : TObject; var Done : Boolean);
begin
 case CurrentState of
  stateMainMenu : Render_stateInGame(Sender);
  stateInGame  : Render_stateInGame(Sender);
 else
  Render_stateInGame(Sender);
 end;

 Done := False;

 // Nummer des gezeichneten Frames erhöhen
inc(Frames);
// FPS aktualisieren
if GetTickCount - StartTick >= 500 then
 begin
 FPS       := Frames/(GetTickCount-StartTick)*1000;
 Frames    := 0;
 StartTick := GetTickCount
 end;

end;

procedure Tmainform.FormMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
var tmp: TVektor2d;
begin
 tmp.x := (1/ClientWidth)*x;
 tmp.y := 0.050000;
 PongGame.p1Pos:= tmp;
end;

procedure Tmainform.FormMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
 PongGame.SetDiagBallSpin;
end;

procedure Tmainform.maintimerTimer(Sender: TObject);
begin
 PongGame.CalcGame;
end;

procedure Tmainform.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
 // Reguliert die Geschwindigkeit
 if Key = VK_ADD then maintimer.Interval := maintimer.Interval + 1
 else if Key = VK_SUBTRACT then maintimer.Interval := maintimer.Interval - 1;
end;

end.
