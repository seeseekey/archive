unit clxu1;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Menus, clxu3, clxu4, StdCtrls, clxu2, clxu5, clxu6, clxu7,
  clxu11, clxu10, clxu9, clxu8, clxu12, clxu13, clxu14, clxu15, clxu16,
  clxu17, clxu18, clxu19, Registry, clxu20, fmxutils, 
  ABSystemInfo, clxu21, CoolTrayIcon, ExtCtrls, ImgList;

type
  Tmainform = class(TForm)
    MainMenu1: TMainMenu;
    Datei1: TMenuItem;
    N1: TMenuItem;
    Drucken1: TMenuItem;
    System1: TMenuItem;
    Amiga1: TMenuItem;
    c641: TMenuItem;
    N2: TMenuItem;
    Nintendo1: TMenuItem;
    SNES1: TMenuItem;
    N641: TMenuItem;
    gamecube1: TMenuItem;
    GameBoy1: TMenuItem;
    N3: TMenuItem;
    N4: TMenuItem;
    Atatri1: TMenuItem;
    PC1: TMenuItem;
    N5: TMenuItem;
    Playstation1: TMenuItem;
    Playstation21: TMenuItem;
    N7: TMenuItem;
    Dreamcast1: TMenuItem;
    MegaDrive1: TMenuItem;
    Saturn1: TMenuItem;
    Fenster1: TMenuItem;
    berlappend1: TMenuItem;
    Nebeneinander1: TMenuItem;
    Symboleanordnen1: TMenuItem;
    N6: TMenuItem;
    AlleFensterverkleinern1: TMenuItem;
    AlleFensterschliessen1: TMenuItem;
    N8: TMenuItem;
    XBox1: TMenuItem;
    Hilfe1: TMenuItem;
    Inhalt1: TMenuItem;
    HilfezurHilfe1: TMenuItem;
    Index1: TMenuItem;
    N9: TMenuItem;
    Optionen1: TMenuItem;
    N11: TMenuItem;
    ber1: TMenuItem;
    Tools1: TMenuItem;
    RegistryEditor1: TMenuItem;
    Rechner1: TMenuItem;
    Editor1: TMenuItem;
    HexEditor1: TMenuItem;
    sysinfo: TABSystemInfo;
    N10: TMenuItem;
    PalmPilot1: TMenuItem;
    cooltray: TCoolTrayIcon;
    iconlist: TImageList;
    taskmenu: TPopupMenu;
    Beenden1: TMenuItem;
    N12: TMenuItem;
    Wiederherstellen1: TMenuItem;
    procedure N641Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure berlappend1Click(Sender: TObject);
    procedure Nebeneinander1Click(Sender: TObject);
    procedure Symboleanordnen1Click(Sender: TObject);
    procedure AlleFensterverkleinern1Click(Sender: TObject);
    procedure AlleFensterschlieen1Click(Sender: TObject);
    procedure PC1Click(Sender: TObject);
    procedure SNES1Click(Sender: TObject);
    procedure Informationen1Click(Sender: TObject);
    procedure Drucken1Click(Sender: TObject);
    procedure GameBoy1Click(Sender: TObject);
    procedure c641Click(Sender: TObject);
    procedure Dreamcast1Click(Sender: TObject);
    procedure Playstation21Click(Sender: TObject);
    procedure Playstation1Click(Sender: TObject);
    procedure Amiga1Click(Sender: TObject);
    procedure MegaDrive1Click(Sender: TObject);
    procedure Saturn1Click(Sender: TObject);
    procedure Atatri1Click(Sender: TObject);
    procedure Nintendo1Click(Sender: TObject);
    procedure gamecube1Click(Sender: TObject);
    procedure XBox1Click(Sender: TObject);
    procedure Inhalt1Click(Sender: TObject);
    procedure HilfezurHilfe1Click(Sender: TObject);
    procedure Index1Click(Sender: TObject);
    procedure Optionen1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Rechner1Click(Sender: TObject);
    procedure Editor1Click(Sender: TObject);
    procedure HexEditor1Click(Sender: TObject);
    procedure RegistryEditor1Click(Sender: TObject);
    procedure PalmPilot1Click(Sender: TObject);
    procedure Beenden1Click(Sender: TObject);
    procedure Wiederherstellen1Click(Sender: TObject);
    procedure cooltrayDblClick(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure FormActivate(Sender: TObject);

  private
    { Private-Deklarationen }
    // Systemmenüerweiterungsprozeduren
    procedure WMSysCommand(VAR Message: TWMSysCommand);
    message WM_SYSCOMMAND;
  public
    { Public-Deklarationen }
    function AndereDSM32InstanzAktivieren: boolean;
   end;

var
  mainform: Tmainform;
  SingleInstance: boolean;

implementation

{$R *.DFM}
procedure Tmainform.WMSysCommand(var Message: TWMSysCommand);
begin
  Inherited;
  If Message.CmdType = $F200 Then
    clxu20.ueber.show;
end;

function Tmainform.AndereDSM32InstanzAktivieren: boolean;
var FindTitle: pchar; Sem: THandle; Wind: HWnd;
begin
  Sem:=CreateSemaphore(nil,0,1,'DSM32 V5 - Semaphore'); Result:=(Sem<>0)and(GetLastError=ERROR_ALREADY_EXISTS);
  If Result then begin CloseHandle(Sem); FindTitle:=PChar(Application.Title); Application.Title:='CheatLex'; Wind:=FindWindow(nil,FindTitle);
    If Wind<>0 then begin ShowWindow(Wind,SW_RESTORE); SetForegroundWindow(Wind); end; end;
end;

procedure Tmainform.N641Click(Sender: TObject);
begin
clxu4.n64.show;
end;

procedure Tmainform.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
if MessageDlg('Möchten sie CheatLex wirklich beenden?',
     mtConfirmation,
    [mbYes, mbNo], 0) = mrYes then
     begin
        Action := caFree
     end
  else
    Action := caNone;
end;

procedure Tmainform.berlappend1Click(Sender: TObject);
begin
  Cascade;
end;

procedure Tmainform.Nebeneinander1Click(Sender: TObject);
begin
  Tile;
end;

procedure Tmainform.Symboleanordnen1Click(Sender: TObject);
begin
  ArrangeIcons;
end;

procedure Tmainform.AlleFensterverkleinern1Click(Sender: TObject);
var
  I: Integer;
begin
  { Must be done backwards through the MDIChildren array }
  for I := MDIChildCount - 1 downto 0 do
    MDIChildren[I].WindowState := wsMinimized;
end;

procedure Tmainform.AlleFensterschlieen1Click(Sender: TObject);
var
  I: Integer;
begin
 for I := MDIChildCount - 1 downto 0 do
   MDIChildren[I].close;
end;

procedure Tmainform.PC1Click(Sender: TObject);
begin
clxu5.pc.showmodal;
end;

procedure Tmainform.SNES1Click(Sender: TObject);
begin
clxu6.snes.showmodal;
end;

procedure Tmainform.Informationen1Click(Sender: TObject);
begin
clxu20.ueber.showmodal;
end;

procedure Tmainform.Drucken1Click(Sender: TObject);
begin
close;
end;

procedure Tmainform.GameBoy1Click(Sender: TObject);
begin
clxu7.gb.showmodal;
end;

procedure Tmainform.c641Click(Sender: TObject);
begin
clxu11.c64.showmodal;
end;

procedure Tmainform.Dreamcast1Click(Sender: TObject);
begin
clxu10.dc.showmodal;
end;

procedure Tmainform.Playstation21Click(Sender: TObject);
begin
clxu9.ps2.showmodal;
end;

procedure Tmainform.Playstation1Click(Sender: TObject);
begin
clxu8.ps.showmodal;
end;

procedure Tmainform.Amiga1Click(Sender: TObject);
begin
clxu12.amiga.ShowModal;
end;

procedure Tmainform.MegaDrive1Click(Sender: TObject);
begin
clxu13.md.showmodal;
end;

procedure Tmainform.Saturn1Click(Sender: TObject);
begin
clxu14.saturn.showmodal;
end;

procedure Tmainform.Atatri1Click(Sender: TObject);
begin
clxu16.atarijaguar.showmodal;
end;

procedure Tmainform.Nintendo1Click(Sender: TObject);
begin
clxu17.nintendo.showmodal;
end;

procedure Tmainform.gamecube1Click(Sender: TObject);
begin
clxu18.gamecube.showmodal;
end;

procedure Tmainform.XBox1Click(Sender: TObject);
begin
clxu15.xbox.showmodal;
end;

procedure Tmainform.Inhalt1Click(Sender: TObject);
begin
Application.HelpFile := ExtractFilePath(Application.ExeName) + 'cheatlex.hlp';
Application.HelpCommand(HELP_SETWINPOS,SW_SHOWMAXIMIZED);
Application.HelpCommand(HELP_FINDER, 0);
{
Application.HelpCommand(HELP_FINDER, 150);
}
 end;

procedure Tmainform.HilfezurHilfe1Click(Sender: TObject);
begin
Application.HelpFile := ExtractFilePath(Application.ExeName) + 'cheatlex.hlp';
Application.HelpCommand(HELP_HELPONHELP, 0);
end;

procedure Tmainform.Index1Click(Sender: TObject);
begin
Application.HelpFile := ExtractFilePath(Application.ExeName) + 'cheatlex.hlp';
Application.HelpCommand(HELP_SETWINPOS,SW_SHOWMAXIMIZED);
Application.HelpCommand(HELP_KEY, 0);
end;

procedure Tmainform.Optionen1Click(Sender: TObject);
begin
clxu19.optionen.show;
end;

procedure Tmainform.FormCreate(Sender: TObject);
var
  regist: TRegistry;
const
 crMyCursor = 22391; //x-beliebige Zahl
begin

// Systemmenüerweiterung
{             AppendMenu(GetSystemMenu(Handle, False),
             MF_STRING,
             $F201,
             -);     }

  AppendMenu(GetSystemMenu(Handle, False),
             MF_STRING,
             $F200,
             '&Über...');
  //$F200 ist der eindeutige Identifizierer

//REGISTERYCHECK
regist:=TRegistry.Create;
regist.RootKey:=HKEY_CURRENT_USER;

try
regist.OpenKey('Software\Global Technology\CheatLex', true );
regist.ReadInteger('standardoptions');
except
regist.Writeinteger('standardoptions', 0);
regist.Writestring('Instanz', 'false');
regist.Writestring('Default Extension', 'true');
regist.Writestring('Systray', 'false');
regist.Writestring('Mauszeiger', 'true');

regist.Writestring('Editor', sysinfo.Software.SystemPath.WindowsDir + '\Notepad.exe');
regist.writestring('Rechner', sysinfo.Software.SystemPath.WindowsDir + '\Calc.exe');
regist.Writestring('Hex Editor', 'Keine Datei angegeben');
regist.Writestring('Registry Editor', sysinfo.Software.SystemPath.WindowsDir + '\Regedit.exe');
end;

//Allgemein
if regist.Readstring('Instanz') = 'true' then
SingleInstance := true
else
SingleInstance := false;

if regist.Readstring('Mauszeiger') = 'true' then
begin
  Screen.Cursors[crMyCursor]:=LoadCursorFromFile('cheatlex.ani');
  Screen.Cursor := crMyCursor;
end
else Screen.Cursor := mainform.Cursor;

if regist.Readstring('Systray') = 'true' then
 begin
   cooltray.iconvisible := true;
  cooltray.minimizetotray := true;
 end
else
begin
  cooltray.iconvisible := false;
  cooltray.minimizetotray := false;
end;

regist.free;

//Allgemein
If SingleInstance = true then
 If AndereDSM32InstanzAktivieren then
  Try Free; Finally Halt; end;


end;

procedure Tmainform.Rechner1Click(Sender: TObject);
var
regist: TRegistry;

begin
regist:=TRegistry.Create;
regist.RootKey:=HKEY_CURRENT_USER;
regist.OpenKey('Software\Global Technology\CheatLex', false);

if FileExists (regist.readstring('Rechner'))then
ExecuteFile(regist.readstring('Rechner'), '', '', SW_SHOW)
else
begin
MessageDlg('Datei nicht gefunden.', mtInformation, [mbOk], 0);
end;

regist.free;
end;

procedure Tmainform.Editor1Click(Sender: TObject);
var regist: TRegistry;

begin
regist:=TRegistry.Create;
regist.RootKey:=HKEY_CURRENT_USER;
regist.OpenKey('Software\Global Technology\CheatLex', false);
if FileExists (regist.readstring('Editor'))then
ExecuteFile(regist.readstring('Editor'), '', '', SW_SHOW)
else
begin
MessageDlg('Datei nicht gefunden.', mtInformation, [mbOk], 0);
end;

regist.free;
end;

procedure Tmainform.HexEditor1Click(Sender: TObject);
var regist: TRegistry;

begin
regist:=TRegistry.Create;
regist.RootKey:=HKEY_CURRENT_USER;
regist.OpenKey('Software\Global Technology\CheatLex', false);

if FileExists (regist.readstring('Hex Editor'))then
ExecuteFile(regist.readstring('Hex Editor'), '', '', SW_SHOW)
else
begin
MessageDlg('Datei nicht gefunden.', mtInformation, [mbOk], 0);
end;

regist.free;
end;

procedure Tmainform.RegistryEditor1Click(Sender: TObject);
var regist: TRegistry;

begin
regist:=TRegistry.Create;
regist.RootKey:=HKEY_CURRENT_USER;
regist.OpenKey('Software\Global Technology\CheatLex', false);

if FileExists (regist.readstring('Registry Editor'))then
ExecuteFile(regist.readstring('Registry Editor'), '', '', SW_SHOW)
else
begin
MessageDlg('Datei nicht gefunden.', mtInformation, [mbOk], 0);
end;

regist.free;
end;




procedure Tmainform.PalmPilot1Click(Sender: TObject);
begin
clxu21.palmpilot.showmodal;
end;

procedure Tmainform.Beenden1Click(Sender: TObject);
begin
close;
end;

procedure Tmainform.Wiederherstellen1Click(Sender: TObject);
begin
cooltrayDblClick(Sender);
end;

procedure Tmainform.cooltrayDblClick(Sender: TObject);
begin
cooltray.ShowMainForm;
mainform.SetFocus;
end;

procedure Tmainform.Timer1Timer(Sender: TObject);
var
  regist: TRegistry;
begin
// Systray Check
regist:=TRegistry.Create;
regist.RootKey:=HKEY_CURRENT_USER;
regist.OpenKey('Software\Global Technology\CheatLex', true );

if regist.Readstring('Systray') = 'true' then
 begin
   cooltray.iconvisible := true;
  cooltray.minimizetotray := true;

    {ShowWindow( Application.Handle, SW_HIDE );
  SetWindowLong( Application.Handle, GWL_EXSTYLE,
              GetWindowLong(Application.Handle, GWL_EXSTYLE) or
               WS_EX_TOOLWINDOW and not WS_EX_APPWINDOW);
  ShowWindow( Application.Handle, SW_SHOW );    }

 end
else
begin
  {SetWindowLong(Handle, GWL_ExStyle, WS_Ex_AppWindow);  }
  cooltray.iconvisible := false;
  cooltray.minimizetotray := false;

end;
regist.free;
end;


procedure Tmainform.FormActivate(Sender: TObject);
var
  regist: TRegistry;
const
 crMyCursor = 22391; //x-beliebige Zahl
begin
// Systray Check
regist:=TRegistry.Create;
regist.RootKey:=HKEY_CURRENT_USER;
regist.OpenKey('Software\Global Technology\CheatLex', true );

if regist.Readstring('Mauszeiger') = 'true' then
begin
  Screen.Cursors[crMyCursor]:=LoadCursorFromFile('cheatlex.ani');
  Screen.Cursor := crMyCursor;
end
else Screen.Cursor := mainform.Cursor;

if regist.Readstring('Systray') = 'true' then
 begin
   cooltray.iconvisible := true;
  cooltray.minimizetotray := true;

    {ShowWindow( Application.Handle, SW_HIDE );
  SetWindowLong( Application.Handle, GWL_EXSTYLE,
              GetWindowLong(Application.Handle, GWL_EXSTYLE) or
               WS_EX_TOOLWINDOW and not WS_EX_APPWINDOW);
  ShowWindow( Application.Handle, SW_SHOW );    }

 end
else
begin
  {SetWindowLong(Handle, GWL_ExStyle, WS_Ex_AppWindow);  }
  cooltray.iconvisible := false;
  cooltray.minimizetotray := false;

end;
regist.free;
end;



end.
