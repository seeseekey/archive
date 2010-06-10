unit Clxu2;

interface

uses
  SysUtils, Windows, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, StdCtrls, Buttons, ExtCtrls, Menus, ComCtrls, ClipBrd,
  ToolWin, clxu3, search, Registry, bsaarc, fmxutils;

type
  Tviewer = class(TForm)
    MainMenu: TMainMenu;
    FilePrintItem: TMenuItem;
    FileExitItem: TMenuItem;
    PrintDialog: TPrintDialog;
    Editor: TRichEdit;
    Bearbeiten1: TMenuItem;
    Kopieren1: TMenuItem;
    PrinterSetupDialog1: TPrinterSetupDialog;
    DruckerSetup1: TMenuItem;
    N1: TMenuItem;
    Allesmarkieren1: TMenuItem;
    Suchen1: TMenuItem;
    Suchen2: TMenuItem;
    Weitersuchen1: TMenuItem;
    FindDialog1: TFindDialog;
    N11: TMenuItem;
    Lsungspeichernunter1: TMenuItem;
    SaveDialog1: TSaveDialog;
    N12: TMenuItem;
    Optionen1: TMenuItem;
    RAR1: TBSA;
    vpopup: TPopupMenu;
    Kopieren2: TMenuItem;
    AllesMarkieren2: TMenuItem;
    N2: TMenuItem;


   procedure FilePrint(Sender: TObject);
    procedure FileExit(Sender: TObject);
    procedure EditUndo(Sender: TObject);
    procedure EditCut(Sender: TObject);
    procedure EditCopy(Sender: TObject);
    procedure EditPaste(Sender: TObject);
    procedure RulerItemMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure RulerItemMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure FileOpenItemClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure DruckerSetup1Click(Sender: TObject);
    procedure Allesmarkieren1Click(Sender: TObject);
    procedure FindDialog1Find(Sender: TObject);
    procedure Informationen1Click(Sender: TObject);
    procedure Suchen2Click(Sender: TObject);
    procedure Weitersuchen1Click(Sender: TObject);
    procedure Lsungspeichernunter1Click(Sender: TObject);
    procedure Optionen1Click(Sender: TObject);
    procedure RAR1ReqPassword(Sender: TObject; eFile: RARHeaderData;
      var Password: String);
    procedure Kopieren2Click(Sender: TObject);
    procedure AllesMarkieren2Click(Sender: TObject);
    procedure RAR1Error(Sender: TObject; Error: Integer);
   
  private
    FFileName: string;
   { FUpdating: Boolean;    }
    FDragOfs: Integer;
    FDragging: Boolean;
    {FClipboardOwner: HWnd; }
  {  function CurrText: TTextAttributes;
    procedure SetFileName(const FileName: String);    }
    procedure PerformFileOpen(const AFileName: string);
  end;

var
  viewer: Tviewer;

implementation

uses RichEdit, ShellAPI, clxu1;

{$R *.DFM}


{
function Tviewer.CurrText: TTextAttributes;
begin
  if Editor.SelLength > 0 then Result := Editor.SelAttributes
  else Result := Editor.DefAttributes;
end; }

function EnumFontsProc(var LogFont: TLogFont; var TextMetric: TTextMetric;
  FontType: Integer; Data: Pointer): Integer; stdcall;
begin
  TStrings(Data).Add(LogFont.lfFaceName);
  Result := 1;
end;

{
procedure Tviewer.SetFileName(const FileName: String);
begin
  FFileName := FileName;
  Caption := Format('%s - %s', [ExtractFileName(FileName), Application.Title]);
end; }


{ Event Handlers }

procedure Tviewer.PerformFileOpen(const AFileName: string);
begin
  Editor.Lines.LoadFromFile(AFilename);
end;

procedure Tviewer.FilePrint(Sender: TObject);
begin
  if PrintDialog.Execute then
    Editor.Print(FFileName);
end;

procedure Tviewer.FileExit(Sender: TObject);
begin
 mainform.Drucken1Click(Sender);
end;

procedure Tviewer.EditUndo(Sender: TObject);
begin
  with Editor do
    if HandleAllocated then SendMessage(Handle, EM_UNDO, 0, 0);
end;

procedure Tviewer.EditCut(Sender: TObject);
begin
  Editor.CutToClipboard;
end;

procedure Tviewer.EditCopy(Sender: TObject);
begin
  Editor.CopyToClipboard;
end;

procedure Tviewer.EditPaste(Sender: TObject);
begin
  Editor.PasteFromClipboard;
end;

{ Ruler Indent Dragging }

procedure Tviewer.RulerItemMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  FDragOfs := (TLabel(Sender).Width div 2);
  TLabel(Sender).Left := TLabel(Sender).Left+X-FDragOfs;
  FDragging := True;
end;

procedure Tviewer.RulerItemMouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
begin
  if FDragging then
    TLabel(Sender).Left :=  TLabel(Sender).Left+X-FDragOfs
end;

procedure Tviewer.FileOpenItemClick(Sender: TObject);
//var
 // Rect: TRect;
begin
 // SendMessage(Editor.Handle, EM_GETRECT, 0, LongInt(@Rect));
 // Rect.Left:= 20;
 // SendMessage(Editor.Handle, EM_SETRECT, 0, LongInt(@Rect));
 // Editor.Refresh;

// 32 KB Begrenzung deaktivieren
  Editor.MaxLength:=High(Integer);
{$I-}

{
rar1.FilesToExtract.Add(augs);
rar1.ExtractArchive;
rar1.FilesToExtract.Clear;
 }
caption := 'CheatLex - ' + slrd;
PerformFileOpen(slrd);
  {
sysutils.deletefile (slrd);
RmDir('Data\amiga');
RmDir('Data\c64');
RmDir('Data\atari jaguar');
RmDir('Data\nintendo');
RmDir('Data\snes');
RmDir('Data\n64');
RmDir('Data\gamecube');
RmDir('Data\gb');
RmDir('Data\saturn');
RmDir('Data\md');
RmDir('Data\dreamcast');
RmDir('Data\ps');
RmDir('Data\ps2');
RmDir('Data\x-box');
RmDir('Data\palmpilot');
RmDir('Data\pc');
RmDir('Data');
   }
{$I+}
end;



procedure Tviewer.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure Tviewer.DruckerSetup1Click(Sender: TObject);
begin
  PrinterSetupDialog1.Execute;
end;

procedure Tviewer.Allesmarkieren1Click(Sender: TObject);
begin
  Editor.SelectAll;
end;

procedure Tviewer.FindDialog1Find(Sender: TObject);
begin
with Sender as TFindDialog do
    if not SearchMemo(Editor, FindText, Options) then
      ShowMessage('Kann "' + FindText + '" nicht finden.');
       FindDialog1.CloseDialog;
end;



procedure Tviewer.Informationen1Click(Sender: TObject);
begin
 mainform.Informationen1Click(Sender);
end;

procedure Tviewer.Suchen2Click(Sender: TObject);
begin
  FindDialog1.Execute;
  Weitersuchen1.Enabled := True;
end;

procedure Tviewer.Weitersuchen1Click(Sender: TObject);
begin
  FindDialog1Find(FindDialog1);
end;

procedure Tviewer.Lsungspeichernunter1Click(Sender: TObject);
var
regist: TRegistry;
extension: string;
begin
try
regist:=TRegistry.Create;
regist.RootKey:=HKEY_CURRENT_USER;
regist.OpenKey('Software\Global Technology\CheatLex', true);

// Autoextension Bestimmung
if SaveDialog1.Execute then
 begin
  if regist.Readstring('Default Extension') = 'true' then
   begin
    if SaveDialog1.FilterIndex = 1 then extension := '.rtf';
    if SaveDialog1.FilterIndex = 2 then extension := '.txt';
   end
  else
   extension := '';
 end;
regist.free;

// Formatsave Funktionen
if SaveDialog1.FilterIndex = 1  then
 begin
  Editor.Lines.SaveToFile(SaveDialog1.FileName + extension);
 end;
if SaveDialog1.FilterIndex = 2 then
 begin
   Editor.PlainText := true;
   Editor.Lines.SaveToFile(SaveDialog1.FileName + extension);
   Editor.PlainText := false;
 end;

{ if SaveDialog1.FilterIndex = 3 then
 begin

   Editor.PlainText := true;
   Editor.Lines.SaveToFile(SaveDialog1.FileName + '.pml');
   Editor.PlainText := false;

   {
   rar1.FilesToExtract.Add(ExtractFilePath(Application.ExeName) + 'data\dropbook.exe');
   rar1.ExtractArchive;
   rar1.FilesToExtract.Clear;
   }
    //ExecuteFile(ExtractFilePath(Application.ExeName) + 'data\dropbook.exe',
    //SaveDialog1.FileName + '.pml', '', SW_SHOW);
   // sysutils.deletefile(SaveDialog1.FileName + '.pml')
   {
   sysutils.deletefile (ExtractFilePath(Application.ExeName) + 'data\dropbook.exe');
   RmDir('Data\');
 end;  }

except
end;
end;

procedure Tviewer.Optionen1Click(Sender: TObject);
begin
mainform.Optionen1Click(Sender);
end;

procedure Tviewer.RAR1ReqPassword(Sender: TObject; eFile: RARHeaderData;
  var Password: String);
begin
Password := 'noraboraworalora';
end;
procedure Tviewer.Kopieren2Click(Sender: TObject);
begin
EditCopy(Sender);
end;

procedure Tviewer.AllesMarkieren2Click(Sender: TObject);
begin
Allesmarkieren1Click(Sender);
end;

procedure Tviewer.RAR1Error(Sender: TObject; Error: Integer);
begin
    MessageDlg('RAR Error', mtInformation,
      [mbOk], 0);

end;

end.
