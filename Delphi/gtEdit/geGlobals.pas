unit geGlobals;

interface

uses IniFiles, gtcl_FileSystem, Graphics, Classes;

type CharacterSet = (ANSI, Unicode);

const appVersion = '1.25';

var myGlobalIni: TIniFile;
    optEditorZeilennummer: boolean;
    optEditorZeilenmarker: boolean;
    optEditorLineal: boolean;
    optEditorAutoHighlighterOpen: boolean;
    optEditorWordWrap: boolean;
    optAnwendungInTrayMinimize: boolean;
    optAnwendungBeimStartMaximieren: boolean;
    optEditorFont: TFont;
    optEditorTabSpaces: Byte;
    lastFiles: array[1..5] of string;
    optFontStyle: string;
    optCharSet: CharacterSet=ANSI;
    optLastConfigSave: Boolean;
    optLastWindowSettings: Boolean;

implementation

initialization
  { initialization-Abschnitt }
  myGlobalIni := TIniFile.Create(gtFileSystem.GetApplicationPath + 'gtEdit.ini');
  optEditorFont := TFont.Create;

finalization
  { finalization-Abschnitt }

  myGlobalIni.Free;
end.
