unit uFormOptions;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, Registry, gtcl_FileSystem, Spin;

type
  TFormOptions = class(TForm)
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    Button1: TButton;
    Button2: TButton;
    cbZeilennummer: TCheckBox;
    cbZeilenmarker: TCheckBox;
    cbLineal: TCheckBox;
    TabSheet2: TTabSheet;
    cbIntegration: TCheckBox;
    cbAutoHighlighter: TCheckBox;
    TabSheet3: TTabSheet;
    cbInTrayMinimize: TCheckBox;
    cbAnwendungBeimStartMaximieren: TCheckBox;
    cbWordWrap: TCheckBox;
    Label1: TLabel;
    seTabSpaces: TSpinEdit;
    cbLastConfigSave: TCheckBox;
    cbLastWindowSettings: TCheckBox;
    procedure Button1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure cbLastWindowSettingsClick(Sender: TObject);
    procedure cbAnwendungBeimStartMaximierenClick(Sender: TObject);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  FormOptions: TFormOptions;

implementation

{$R *.dfm}

uses uGlobals, uFormMain;

procedure TFormOptions.Button1Click(Sender: TObject);
begin
  FormOptions.Close;
end;

procedure TFormOptions.FormShow(Sender: TObject);
var myRegistry: TRegistry;
begin
  cbZeilennummer.Checked := false;
  cbZeilenmarker.Checked := false;
  cbLineal.Checked := false;
  cbAutoHighlighter.Checked := false;
  cbWordWrap.Checked := false;

  cbInTrayMinimize.Checked := false;
  cbAnwendungBeimStartMaximieren.Checked := false;

  if optEditorZeilennummer = true then cbZeilennummer.Checked := true;
  if optEditorZeilenmarker = true then cbZeilenmarker.Checked := true;
  if optEditorLineal = true then cbLineal.Checked := true;
  if optEditorAutoHighlighterOpen = true then cbAutoHighlighter.Checked := true;
  if optEditorWordWrap = true then cbWordWrap.Checked := true;

  if optLastConfigSave = true then cbLastConfigSave.Checked := true;
  if optLastWindowSettings = true then cbLastWindowSettings.Checked := true;

  if optAnwendungInTrayMinimize = true then cbInTrayMinimize.Checked := true;
  if optAnwendungBeimStartMaximieren = true then cbAnwendungBeimStartMaximieren.Checked := true;

  seTabSpaces.Value := optEditorTabSpaces;

  //Registry
  myRegistry := TRegistry.Create;
  myRegistry.RootKey:=HKEY_CLASSES_ROOT;
  if myRegistry.KeyExists('*\shell\gtEdit\Command') = true then cbIntegration.Checked := true;
  myRegistry.Free;
end;

procedure TFormOptions.Button2Click(Sender: TObject);
var myRegistry: TRegistry;
begin
  optEditorZeilennummer:= cbZeilennummer.Checked;
  optEditorZeilenmarker:= cbZeilenmarker.Checked;
  optEditorLineal:= cbLineal.Checked;
  optEditorAutoHighlighterOpen := cbAutoHighlighter.Checked;
  optEditorWordWrap := cbWordWrap.Checked;
  optLastConfigSave := cbLastConfigSave.Checked;
  optLastWindowSettings := cbLastWindowSettings.checked;

  optAnwendungInTrayMinimize := cbInTrayMinimize.Checked;
  optAnwendungBeimStartMaximieren := cbAnwendungBeimStartMaximieren.Checked;

  optEditorTabSpaces := seTabSpaces.Value;

  myGlobalIni.WriteBool('editor', 'zeilennummer', optEditorZeilennummer);
  myGlobalIni.WriteBool('editor', 'zeilenmarker', optEditorZeilenmarker);
  myGlobalIni.WriteBool('editor', 'lineal', optEditorLineal);
  myGlobalIni.WriteBool('editor', 'autohighlighter', optEditorAutoHighlighterOpen);
  myGlobalIni.WriteBool('editor', 'wordwrap', optEditorWordWrap);
  myGlobalIni.WriteBool('editor', 'lastconfigsave', optLastConfigSave);
  myGlobalIni.WriteBool('editor', 'lastwindowsettings', optLastWindowSettings);

  myGlobalIni.WriteBool('anwendung', 'intrayminimize', optAnwendungInTrayMinimize);

  if optAnwendungInTrayMinimize = true then FormMain.TrayIcon.Active := true
  else FormMain.TrayIcon.Active := false;

  myGlobalIni.WriteBool('anwendung', 'onstartmaximize', optAnwendungBeimStartMaximieren);

  myGlobalIni.WriteInteger('editor', 'tabspaces', optEditorTabSpaces);


  if cbIntegration.Checked = true then
  begin
    myRegistry := TRegistry.Create;
    myRegistry.RootKey:=HKEY_CLASSES_ROOT;
    myRegistry.OpenKey('*\shell\gtEdit\Command',true);
    myRegistry.WriteString('', '"'+ gtFileSystem.GetApplicationPathWithFilename + '" "%1"');
    myRegistry.Free;
  end
  else
  begin
    myRegistry := TRegistry.Create;
    myRegistry.RootKey:=HKEY_CLASSES_ROOT;
    myRegistry.OpenKey('*\shell\',true);
    myRegistry.DeleteKey('gtEdit');
    myRegistry.Free;
  end;

  FormOptions.Close;
end;

procedure TFormOptions.cbLastWindowSettingsClick(Sender: TObject);
begin
  if cbLastWindowSettings.Checked = true then cbAnwendungBeimStartMaximieren.Checked := false;
end;

procedure TFormOptions.cbAnwendungBeimStartMaximierenClick(
  Sender: TObject);
begin
  if cbAnwendungBeimStartMaximieren.Checked = true then cbLastWindowSettings.Checked := false;
end;

end.                      
