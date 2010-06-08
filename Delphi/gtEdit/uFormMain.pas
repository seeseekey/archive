unit uFormMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus, ComCtrls, SynEdit, ExtCtrls, SynHighlighterCS,
  SynHighlighterCpp, SynEditHighlighter, SynHighlighterPas,
  SynHighlighterCSS, SynHighlighterHtml, SynHighlighterPerl,
  SynHighlighterPHP, SynHighlighterJava, SynHighlighterXML,
  SynHighlighterEiffel, SynHighlighterFortran, SynHighlighterVB,
  SynHighlighterCobol, SynHighlighterJScript, SynHighlighterVBScript,
  SynHighlighterVrml97, SynHighlighterAWK, SynHighlighterBat,
  SynHighlighterPython, SynHighlighterTclTk, SynHighlighterRuby,
  SynHighlighterUNIXShellScript, SynHighlighterAsm, SynHighlighterSQL,
  SynHighlighterTeX, SynHighlighterFoxpro, Clipbrd, SynEditPrint, gtcl_Strings,
  SynEditMiscClasses, SynEditSearch, SynEditTypes, SynEditMiscProcs,
  SynEditRegexSearch, ActnList, TB2Dock, TB2Toolbar, ImgList, TB2Item,
  AppEvnts, gtcl_MemoryMappedFile, hh, hh_funcs, D6OnHelpFix, XPMan, gtcl_Forms,
  JvComponentBase, JvTrayIcon, gtcl_Menu, gtcl_InputDevices, ShellApi, synunicode,
  gtcl_WideStrings, geGlobals;


type
  TTabInfo = record
    active: Boolean;
    fileName: string;
    contentChanged: Boolean;
    captionOfTab: string;
    optZeilennummer: boolean;
    optZeilenmarker: boolean;
    optWordWrap: boolean;
    charSet: CharacterSet;
    itlBookmark00: boolean;
    itlBookmark01: boolean;
    itlBookmark02: boolean;
    itlBookmark03: boolean;
    itlBookmark04: boolean;
    itlBookmark05: boolean;
    itlBookmark06: boolean;
    itlBookmark07: boolean;
    itlBookmark08: boolean;
    itlBookmark09: boolean;
  end;

type
  TFormMain = class(TForm)
    MainMenu: TMainMenu;
    datei1: TMenuItem;
    N1: TMenuItem;
    ffen1: TMenuItem;
    Speichern1: TMenuItem;
    Speichernunter1: TMenuItem;
    Allesschlieen1: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    Schlien1: TMenuItem;
    Drucken1: TMenuItem;
    Druckereinrichten1: TMenuItem;
    N4: TMenuItem;
    Beenden1: TMenuItem;
    Bearbeiten1: TMenuItem;
    Rckgngig1: TMenuItem;
    Wiederherstellen1: TMenuItem;
    N5: TMenuItem;
    Ausschneiden1: TMenuItem;
    Kopieren1: TMenuItem;
    Einfgen1: TMenuItem;
    N6: TMenuItem;
    Allesmarkieren1: TMenuItem;
    Suchen1: TMenuItem;
    Suchen2: TMenuItem;
    Weitersuchen1: TMenuItem;
    Ersetzen1: TMenuItem;
    Ansicht1: TMenuItem;
    Syntaxhervorhebung1: TMenuItem;
    XML1: TMenuItem;
    Pascal1: TMenuItem;
    CC1: TMenuItem;
    Java1: TMenuItem;
    C1: TMenuItem;
    PHP1: TMenuItem;
    HTML1: TMenuItem;
    Perl1: TMenuItem;
    CSS1: TMenuItem;
    Format1: TMenuItem;
    Hilfe1: TMenuItem;
    Extras1: TMenuItem;
    Optionen1: TMenuItem;
    Inhalt1: TMenuItem;
    N7: TMenuItem;
    ber1: TMenuItem;
    pcMain: TPageControl;
    OpenDialog: TOpenDialog;
    shPascal: TSynPasSyn;
    shCPlusPlus: TSynCppSyn;
    shCSharp: TSynCSSyn;
    keineHervorhebung1: TMenuItem;
    N8: TMenuItem;
    shCSS: TSynCssSyn;
    shHTML: TSynHTMLSyn;
    shPerl: TSynPerlSyn;
    shPHP: TSynPHPSyn;
    shJava: TSynJavaSyn;
    shXML: TSynXMLSyn;
    shEiffel: TSynEiffelSyn;
    Eiffel1: TMenuItem;
    shFortran: TSynFortranSyn;
    Fortran1: TMenuItem;
    shVB: TSynVBSyn;
    VisualBasic1: TMenuItem;
    shCobol: TSynCobolSyn;
    Cobol1: TMenuItem;
    shJavascript: TSynJScriptSyn;
    Javascript1: TMenuItem;
    shVBScript: TSynVBScriptSyn;
    VisualBasicScript1: TMenuItem;
    shVRML97: TSynVrml97Syn;
    VRML971: TMenuItem;
    awk1: TMenuItem;
    shAWK: TSynAWKSyn;
    shBatchScriptDOS: TSynBatSyn;
    BatchSkriptDOS1: TMenuItem;
    shPython: TSynPythonSyn;
    Python1: TMenuItem;
    shTcl: TSynTclTkSyn;
    tcl1: TMenuItem;
    shRuby: TSynRubySyn;
    Ruby1: TMenuItem;
    shUNIXShellScript: TSynUNIXShellScriptSyn;
    UNIXShellSkript1: TMenuItem;
    shAssembler: TSynAsmSyn;
    Assembler1: TMenuItem;
    shSQL: TSynSQLSyn;
    SQL1: TMenuItem;
    shTEX: TSynTeXSyn;
    eX1: TMenuItem;
    shFoxPro: TSynFoxproSyn;
    FoxPr1: TMenuItem;
    TimerMain: TTimer;
    SaveDialog: TSaveDialog;
    N9: TMenuItem;
    Schriftvergrern1: TMenuItem;
    Schriftverkleinern1: TMenuItem;
    N10: TMenuItem;
    SichtbareZeichenEinAus1: TMenuItem;
    StatusBar: TStatusBar;
    Debug1: TMenuItem;
    est1: TMenuItem;
    PrinterSetupDialog: TPrinterSetupDialog;
    PrinterDialog: TPrintDialog;
    SynEditPrint: TSynEditPrint;
    Seitenansicht1: TMenuItem;
    Syneditfilename1: TMenuItem;
    Weitersuchenletzes1: TMenuItem;
    pmenuTabs: TPopupMenu;
    Schlieen1: TMenuItem;
    Alleschlieen1: TMenuItem;
    N11: TMenuItem;
    Speichern2: TMenuItem;
    Speichernunter2: TMenuItem;
    N12: TMenuItem;
    Drucken2: TMenuItem;
    Seitenansicht2: TMenuItem;
    N13: TMenuItem;
    GehezuZeile1: TMenuItem;
    Grobuchstaben1: TMenuItem;
    Kleinbuchstaben1: TMenuItem;
    GroundKleinbuchstabenvertauschen1: TMenuItem;
    Lesezeichen1: TMenuItem;
    Lesezeichen01: TMenuItem;
    Lesezeichen11: TMenuItem;
    Lesezeichen21: TMenuItem;
    Lesezeichen31: TMenuItem;
    Lesezeichen41: TMenuItem;
    Lesezeichen51: TMenuItem;
    Lesezeichen61: TMenuItem;
    Lesezeichen71: TMenuItem;
    Lesezeichen81: TMenuItem;
    Lesezeichen91: TMenuItem;
    N14: TMenuItem;
    AllesschlieenausseraktuellerDatei1: TMenuItem;
    AllesausseraktuellerDateischlieen1: TMenuItem;
    actlMain: TActionList;
    actFileOpen: TAction;
    actSearch: TAction;
    actSearchNext: TAction;
    actSearchPrev: TAction;
    actSearchReplace: TAction;
    SynEditRegexSearch: TSynEditRegexSearch;
    SynEditSearch: TSynEditSearch;
    TBDock1: TTBDock;
    TBToolbar1: TTBToolbar;
    TBImageList1: TTBImageList;
    TBItem2: TTBItem;
    TBItem1: TTBItem;
    TBItem3: TTBItem;
    TBSeparatorItem1: TTBSeparatorItem;
    TBSeparatorItem2: TTBSeparatorItem;
    TBItem4: TTBItem;
    TBSeparatorItem3: TTBSeparatorItem;
    TBItem5: TTBItem;
    TBToolbar2: TTBToolbar;
    TBImageList2: TTBImageList;
    TBItem6: TTBItem;
    TBItem7: TTBItem;
    TBItem8: TTBItem;
    TBSeparatorItem4: TTBSeparatorItem;
    TBItem9: TTBItem;
    TBItem10: TTBItem;
    TBToolbar3: TTBToolbar;
    TBImageList3: TTBImageList;
    TBItem11: TTBItem;
    N16: TMenuItem;
    Zeilennummern1: TMenuItem;
    Zeilenmarkeranzeigen1: TMenuItem;
    aeMain: TApplicationEvents;
    N17: TMenuItem;
    Letzte1: TMenuItem;
    M11: TMenuItem;
    M21: TMenuItem;
    M31: TMenuItem;
    M41: TMenuItem;
    M51: TMenuItem;
    pmenuSyn: TPopupMenu;
    MenuItem1: TMenuItem;
    MenuItem2: TMenuItem;
    MenuItem3: TMenuItem;
    MenuItem4: TMenuItem;
    MenuItem5: TMenuItem;
    MenuItem6: TMenuItem;
    MenuItem7: TMenuItem;
    MenuItem8: TMenuItem;
    MenuItem9: TMenuItem;
    N18: TMenuItem;
    Ausschneiden2: TMenuItem;
    Kopieren2: TMenuItem;
    Einfgen2: TMenuItem;
    N19: TMenuItem;
    Suchen3: TMenuItem;
    Ersetzen2: TMenuItem;
    N20: TMenuItem;
    Wiederherstellen2: TMenuItem;
    Rckgngig2: TMenuItem;
    Addopen1: TMenuItem;
    TrayIcon: TJvTrayIcon;
    Setbookmarkonzeile1: TMenuItem;
    Lesezeichen2: TMenuItem;
    Lesezeichen92: TMenuItem;
    Lesezeichen82: TMenuItem;
    Lesezeichen72: TMenuItem;
    Lesezeichen62: TMenuItem;
    Lesezeichen52: TMenuItem;
    Lesezeichen42: TMenuItem;
    Lesezeichen32: TMenuItem;
    Lesezeichen22: TMenuItem;
    Lesezeichen12: TMenuItem;
    Lesezeichen02: TMenuItem;
    N15: TMenuItem;
    Lesezeichensetzen1: TMenuItem;
    Lesezeichen94: TMenuItem;
    Lesezeichen84: TMenuItem;
    Lesezeichen74: TMenuItem;
    Lesezeichen64: TMenuItem;
    Lesezeichen54: TMenuItem;
    Lesezeichen44: TMenuItem;
    Lesezeichen34: TMenuItem;
    Lesezeichen24: TMenuItem;
    Lesezeichen14: TMenuItem;
    Lesezeichen04: TMenuItem;
    Lesezeichensetzen2: TMenuItem;
    Lesezeichen95: TMenuItem;
    Lesezeichen85: TMenuItem;
    Lesezeichen75: TMenuItem;
    Lesezeichen65: TMenuItem;
    Lesezeichen55: TMenuItem;
    Lesezeichen45: TMenuItem;
    Lesezeichen35: TMenuItem;
    Lesezeichen25: TMenuItem;
    Lesezeichen15: TMenuItem;
    Lesezeichen05: TMenuItem;
    N21: TMenuItem;
    WordWrap1: TMenuItem;
    N22: TMenuItem;
    Schriftarteinstellen1: TMenuItem;
    FontDialog: TFontDialog;
    N23: TMenuItem;
    Zeilelinkstrimmen1: TMenuItem;
    Zeilerechtstrimmen1: TMenuItem;
    Zeiletrimmen1: TMenuItem;
    N24: TMenuItem;
    WhitespacesanZeilenendenentfernen1: TMenuItem;
    Kapitale1: TMenuItem;
    N25: TMenuItem;
    Wrterzhlen1: TMenuItem;
    N26: TMenuItem;
    T1: TMenuItem;
    LeerzeicheninTabulatorenumwandelnAlle1: TMenuItem;
    Allesspeichern1: TMenuItem;
    Allesspeichern2: TMenuItem;
    X1: TMenuItem;
    LeerzeicheninTabulatorenumwandelnfhrende1: TMenuItem;
    N27: TMenuItem;
    Zeichensatz1: TMenuItem;
    ANSI1: TMenuItem;
    Unicode1: TMenuItem;
    procedure CreateNewTab; // Erzeugt einen neuen Tab
    procedure GetParameters;
    procedure FormCreate(Sender: TObject);
    procedure N1Click(Sender: TObject);
    procedure ffen1Click(Sender: TObject);
    procedure pcMainChange(Sender: TObject);
    procedure CC1Click(Sender: TObject);
    procedure C1Click(Sender: TObject);
    procedure CSS1Click(Sender: TObject);
    procedure HTML1Click(Sender: TObject);
    procedure Pascal1Click(Sender: TObject);
    procedure Perl1Click(Sender: TObject);
    procedure PHP1Click(Sender: TObject);
    procedure Java1Click(Sender: TObject);
    procedure XML1Click(Sender: TObject);
    procedure Eiffel1Click(Sender: TObject);
    procedure Fortran1Click(Sender: TObject);
    procedure VisualBasic1Click(Sender: TObject);
    procedure Javascript1Click(Sender: TObject);
    procedure Cobol1Click(Sender: TObject);
    procedure VisualBasicScript1Click(Sender: TObject);
    procedure VRML971Click(Sender: TObject);
    procedure awk1Click(Sender: TObject);
    procedure BatchSkriptDOS1Click(Sender: TObject);
    procedure keineHervorhebung1Click(Sender: TObject);
    procedure Python1Click(Sender: TObject);
    procedure tcl1Click(Sender: TObject);
    procedure Ruby1Click(Sender: TObject);
    procedure UNIXShellSkript1Click(Sender: TObject);
    procedure Assembler1Click(Sender: TObject);
    procedure SQL1Click(Sender: TObject);
    procedure eX1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FoxPr1Click(Sender: TObject);
    procedure Schlien1Click(Sender: TObject);
    procedure TimerMainTimer(Sender: TObject);
    procedure Allesschlieen1Click(Sender: TObject);
    procedure ber1Click(Sender: TObject);
    procedure SichtbareZeichenEinAus1Click(Sender: TObject);
    procedure Schriftvergrern1Click(Sender: TObject);
    procedure Schriftverkleinern1Click(Sender: TObject);
    procedure Speichernunter1Click(Sender: TObject);
    procedure Beenden1Click(Sender: TObject);
    procedure Kopieren1Click(Sender: TObject);
    procedure Ausschneiden1Click(Sender: TObject);
    procedure Einfgen1Click(Sender: TObject);
    procedure Allesmarkieren1Click(Sender: TObject);
    procedure Druckereinrichten1Click(Sender: TObject);
    procedure Drucken1Click(Sender: TObject);
    procedure Seitenansicht1Click(Sender: TObject);
    procedure Syneditfilename1Click(Sender: TObject);
    procedure SetEditHighlighter(myHL: TSynCustomHighlighter);
    procedure GetValues;
    procedure FormDestroy(Sender: TObject);
    procedure DeleteTab(myActivePageIndex: Integer);
    procedure Speichern1Click(Sender: TObject);
    procedure Schlieen1Click(Sender: TObject);
    procedure Alleschlieen1Click(Sender: TObject);
    procedure Speichern2Click(Sender: TObject);
    procedure Speichernunter2Click(Sender: TObject);
    procedure Drucken2Click(Sender: TObject);
    procedure Seitenansicht2Click(Sender: TObject);
    procedure GehezuZeile1Click(Sender: TObject);
    procedure SetCaretY(line: Integer);
    procedure Grobuchstaben1Click(Sender: TObject);
    procedure Kleinbuchstaben1Click(Sender: TObject);
    procedure GroundKleinbuchstabenvertauschen1Click(Sender: TObject);
    procedure AllesschlieenausseraktuellerDatei1Click(Sender: TObject);
    procedure AllesausseraktuellerDateischlieen1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Suchen2Click(Sender: TObject);
    procedure Weitersuchen1Click(Sender: TObject);
    procedure Weitersuchenletzes1Click(Sender: TObject);
    procedure Ersetzen1Click(Sender: TObject);
    procedure actSearchUpdate(Sender: TObject);
    procedure SynEditorReplaceText(Sender: TObject; const ASearch, AReplace: WideString; Line, Column: Integer; var Action: TSynReplaceAction);
    procedure Rckgngig1Click(Sender: TObject);
    procedure Wiederherstellen1Click(Sender: TObject);
    procedure Optionen1Click(Sender: TObject);
    procedure TBItem2Click(Sender: TObject);
    procedure TBItem1Click(Sender: TObject);
    procedure TBItem3Click(Sender: TObject);
    procedure TBItem4Click(Sender: TObject);
    procedure TBItem5Click(Sender: TObject);
    procedure TBItem7Click(Sender: TObject);
    procedure TBItem6Click(Sender: TObject);
    procedure TBItem8Click(Sender: TObject);
    procedure TBItem9Click(Sender: TObject);
    procedure TBItem10Click(Sender: TObject);
    procedure TBItem11Click(Sender: TObject);
    procedure Zeilennummern1Click(Sender: TObject);
    procedure Zeilenmarkeranzeigen1Click(Sender: TObject);
    procedure OpenFile(filename: string);
    procedure aeMainMessage(var Msg: tagMSG; var Handled: Boolean);
    procedure GetHighlighter(extension: string);
    procedure ShowSynEditOnStatusButton(Sender: TObject; Changes: TSynStatusChanges);
    procedure SynEditChange(Sender: TObject);
    procedure M11Click(Sender: TObject);
    procedure SetLastFiles;
    procedure Addopen1Click(Sender: TObject);
    procedure Inhalt1Click(Sender: TObject);
    procedure Setbookmarkonzeile1Click(Sender: TObject);
    procedure Lesezeichen01Click(Sender: TObject);
    procedure Lesezeichen11Click(Sender: TObject);
    procedure Lesezeichen21Click(Sender: TObject);
    procedure Lesezeichen31Click(Sender: TObject);
    procedure Lesezeichen41Click(Sender: TObject);
    procedure Lesezeichen51Click(Sender: TObject);
    procedure Lesezeichen61Click(Sender: TObject);
    procedure Lesezeichen71Click(Sender: TObject);
    procedure Lesezeichen81Click(Sender: TObject);
    procedure Lesezeichen91Click(Sender: TObject);
    procedure SetBookmark(bookmark: Integer);
    procedure Lesezeichen05Click(Sender: TObject);
    procedure Lesezeichen15Click(Sender: TObject);
    procedure Lesezeichen25Click(Sender: TObject);
    procedure Lesezeichen35Click(Sender: TObject);
    procedure Lesezeichen45Click(Sender: TObject);
    procedure Lesezeichen55Click(Sender: TObject);
    procedure Lesezeichen65Click(Sender: TObject);
    procedure Lesezeichen75Click(Sender: TObject);
    procedure Lesezeichen85Click(Sender: TObject);
    procedure Lesezeichen95Click(Sender: TObject);
    procedure Lesezeichen02Click(Sender: TObject);
    procedure Lesezeichen12Click(Sender: TObject);
    procedure Lesezeichen22Click(Sender: TObject);
    procedure Lesezeichen32Click(Sender: TObject);
    procedure Lesezeichen42Click(Sender: TObject);
    procedure Lesezeichen52Click(Sender: TObject);
    procedure Lesezeichen62Click(Sender: TObject);
    procedure Lesezeichen72Click(Sender: TObject);
    procedure Lesezeichen82Click(Sender: TObject);
    procedure Lesezeichen92Click(Sender: TObject);
    procedure Lesezeichen04Click(Sender: TObject);
    procedure Lesezeichen14Click(Sender: TObject);
    procedure Lesezeichen24Click(Sender: TObject);
    procedure Lesezeichen34Click(Sender: TObject);
    procedure Lesezeichen44Click(Sender: TObject);
    procedure Lesezeichen54Click(Sender: TObject);
    procedure Lesezeichen64Click(Sender: TObject);
    procedure Lesezeichen74Click(Sender: TObject);
    procedure Lesezeichen84Click(Sender: TObject);
    procedure Lesezeichen94Click(Sender: TObject);
    procedure WordWrap1Click(Sender: TObject);
    procedure Schriftarteinstellen1Click(Sender: TObject);
    procedure SetFont(newFont: TFont);
    procedure Zeilelinkstrimmen1Click(Sender: TObject);
    procedure Zeilerechtstrimmen1Click(Sender: TObject);
    procedure Zeiletrimmen1Click(Sender: TObject);
    procedure WhitespacesanZeilenendenentfernen1Click(Sender: TObject);
    procedure Kapitale1Click(Sender: TObject);
    procedure Wrterzhlen1Click(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure T1Click(Sender: TObject);
    procedure LeerzeicheninTabulatorenumwandelnAlle1Click(Sender: TObject);
    procedure Allesspeichern1Click(Sender: TObject);
    procedure GetValuesOfPageNumber(pagenumber:integer; var vvPageIndex, vvArrayNumber, vvCptNumber: Integer);
    procedure Allesspeichern2Click(Sender: TObject);
    procedure X1Click(Sender: TObject);
    procedure LeerzeicheninTabulatorenumwandelnfhrende1Click(
      Sender: TObject);
    procedure ANSI1Click(Sender: TObject);
    procedure Unicode1Click(Sender: TObject);
  private
    fSearchFromCaret: boolean;
    procedure DoSearchReplaceText(AReplace: boolean; ABackwards: boolean);
    procedure ShowSearchReplaceDialog(AReplace: boolean);
    procedure actSearchReplaceUpdate(Sender: TObject);

    procedure WMDROPFILES (var Msg: TMessage); message WM_DROPFILES;
  public
    { Public-Deklarationen }
  end;

const
  MyGUID = '{EABD7162-08E5-4C68-96E1-434A89729895}';

var
  FormMain: TFormMain;
  TabCount: LongWord=0;
  tmpPageIndex, tmpCptNummer, tmpArrayStateNumber: LongWord;
  myTabStatusArray: array of TTabInfo;
  ArraySizeMultiplikator: LongWord=4;
  mySaveCancel: boolean = false;
  mySaveDontClose: boolean = false;

  //new
  gbSearchBackwards: boolean;
  gbSearchCaseSensitive: boolean;
  gbSearchFromCaret: boolean;
  gbSearchSelectionOnly: boolean;
  gbSearchTextAtCaret: boolean;
  gbSearchWholeWords: boolean;
  gbSearchRegex: boolean;

  gsSearchText: string;
  gsSearchTextHistory: string;
  gsReplaceText: string;
  gsReplaceTextHistory: string;

  //activeate
  ActivationMessage: Cardinal;

  mHHelp : THookHelpSystem; //Chm Hilfe Unterstüzung

resourcestring
  STextNotFound = 'Text nicht gefunden!';

implementation

{$R *.dfm}

uses uFormAbout, uFormOptions, uFormPrintPreview, uFormJumpToLine,
  uFormReplaceConfirm, uFormSearch, uFormReplace;

procedure TFormMain.GetValues;
var mySplitList: TStringList;
begin
  if(pcMain.PageCount > 0) then
  begin
    mySplitList := TStringList.Create;
    mySplitList := gtStrings.Split(pcMain.ActivePage.Name, '_');
    tmpCptNummer := StrToInt(mySplitList[1]);
    mySplitList.Free;
    tmpPageIndex := TTabSheet(pcMain.FindComponent('tab_' + IntToStr(tmpCptNummer))).PageIndex;
    tmpArrayStateNumber := TTabSheet(pcMain.FindComponent('tab_' + IntToStr(tmpCptNummer))).Tag;
  end;
end;

procedure TFormMain.SynEditChange(Sender: TObject);
begin
 if Sender is TSynEdit then myTabStatusArray[tmpArrayStateNumber].contentChanged := true;
end;

procedure TFormMain.ShowSynEditOnStatusButton(Sender: TObject;
  Changes: TSynStatusChanges);
begin
  if Sender is TSynEdit then
  begin
     StatusBar.Panels[0].Text := Format('Zeile:%6d, Spalte:%3d', [TSynEdit(Sender).CaretY, TSynEdit(Sender).CaretX]);
  end;
end;

//Source
procedure TFormMain.CreateNewTab;
var tabPageIndex: Integer;
    i: Integer;
begin
  Inc(TabCount);

  with TTabSheet.Create(pcMain) do
    begin
      PageControl := pcMain;
      Name        := 'tab_' + IntToStr(TabCount);
      Caption     := 'Bearbeiten' + IntToStr(TabCount);
    end;

  tabPageIndex := TTabSheet(pcMain.FindComponent('tab_' + IntToStr(TabCount))).PageIndex;

  //Synedit
  with TSynEdit.Create(pcMain.Pages[tabPageIndex]) do
  begin
    Name   := 'synEdit_' + IntToStr(TabCount);
    Parent := pcMain.Pages[tabPageIndex];
    Align := alClient;
    RightEdge := 0;
    Text := '';
    Options := [eoAltSetsColumnMode, eoGroupUndo];
    WantTabs := true;
    TabWidth := optEditorTabSpaces;

    Lines.SaveUnicode := false;

    Gutter.AutoSize := true;

    //Optionale Dinge
    if optEditorZeilennummer = true then Gutter.ShowLineNumbers := true;
    if optEditorZeilenmarker = true then ActiveLineColor := clYellow;

    //Events
    TSynEdit(pcMain.Pages[tabPageIndex].FindComponent('synEdit_' + IntToStr(TabCount))).PopupMenu := pmenuSyn;
    TSynEdit(pcMain.Pages[tabPageIndex].FindComponent('synEdit_' + IntToStr(TabCount))).Font := optEditorFont;
                                       
    TSynEdit(pcMain.Pages[tabPageIndex].FindComponent('synEdit_' + IntToStr(TabCount))).OnChange := SynEditChange;
    TSynEdit(pcMain.Pages[tabPageIndex].FindComponent('synEdit_' + IntToStr(TabCount))).OnStatusChange := ShowSynEditOnStatusButton;

    TSynEdit(pcMain.Pages[tabPageIndex].FindComponent('synEdit_' + IntToStr(TabCount))).OnReplaceText := SynEditorReplaceText; // (UK)
  end;

  //TTabInfo zuweisen
  for i:=Low(myTabStatusArray) to High(myTabStatusArray) do
  begin
    if myTabStatusArray[i].active = false then
    begin
      TTabSheet(pcMain.FindComponent('tab_' + IntToStr(TabCount))).Tag := i;

      myTabStatusArray[i].active := true;
      myTabStatusArray[i].captionOfTab := 'Bearbeiten' + IntToStr(TabCount);
      myTabStatusArray[i].optZeilennummer := optEditorZeilennummer;
      myTabStatusArray[i].optZeilenmarker := optEditorZeilenmarker;
      myTabStatusArray[i].optWordWrap := optEditorWordWrap;
      myTabStatusArray[i].charSet := optCharSet;

      Break;
    end;

    if i = High(myTabStatusArray) then
    begin
      ArraySizeMultiplikator := ArraySizeMultiplikator+ArraySizeMultiplikator;
      SetLength(myTabStatusArray, ArraySizeMultiplikator);
      TTabSheet(pcMain.FindComponent('tab_' + IntToStr(TabCount))).Tag := i+1;

      myTabStatusArray[i+1].active := true;
      myTabStatusArray[i+1].captionOfTab := 'Bearbeiten' + IntToStr(TabCount);
      myTabStatusArray[i+1].optZeilennummer := optEditorZeilennummer;
      myTabStatusArray[i+1].optZeilenmarker := optEditorZeilenmarker;
      myTabStatusArray[i+1].optWordWrap := optEditorWordWrap;

      Break;
    end;
  end;

  pcMain.ActivePageIndex := tabPageIndex;
  GetParameters;
end;

//SetParameters
procedure TFormMain.GetParameters;
var oldState: boolean;
begin
  GetValues;

  keineHervorhebung1.Checked := false;
  Assembler1.Checked := false;
  awk1.Checked := false;
  BatchSkriptDOS1.Checked := false;
  CC1.Checked := false;
  C1.Checked := false;
  Cobol1.Checked := false;
  CSS1.Checked := false;
  Eiffel1.Checked := false;
  Fortran1.Checked := false;
  FoxPr1.Checked := false;
  HTML1.Checked := false;
  Pascal1.Checked := false;
  Perl1.Checked := false;
  PHP1.Checked := false;
  Python1.Checked := false;
  Java1.Checked := false;
  Javascript1.Checked := false;
  Ruby1.Checked := false;
  SQL1.Checked := false;
  tcl1.Checked := false;
  eX1.Checked := false; //TeX
  VisualBasic1.Checked := false;
  VisualBasicScript1.Checked := false;
  UNIXShellSkript1.Checked := false;
  VRML971.Checked := false;
  XML1.Checked := false;

  if TSynEdit(pcMain.Pages[tmpPageIndex].FindComponent('synEdit_' + IntToStr(tmpCptNummer))).Highlighter = shAssembler then
  begin
    Assembler1.Checked := true;
  end
  else if TSynEdit(pcMain.Pages[tmpPageIndex].FindComponent('synEdit_' + IntToStr(tmpCptNummer))).Highlighter = shAWK then
  begin
    awk1.Checked := true;
  end
  else if TSynEdit(pcMain.Pages[tmpPageIndex].FindComponent('synEdit_' + IntToStr(tmpCptNummer))).Highlighter = shBatchScriptDOS then
  begin
    BatchSkriptDOS1.Checked := true;
  end
  else if TSynEdit(pcMain.Pages[tmpPageIndex].FindComponent('synEdit_' + IntToStr(tmpCptNummer))).Highlighter = shCPlusPlus then
  begin
    CC1.Checked := true;
  end
  else if TSynEdit(pcMain.Pages[tmpPageIndex].FindComponent('synEdit_' + IntToStr(tmpCptNummer))).Highlighter = shCSharp then
  begin
    C1.Checked := true;
  end
  else if TSynEdit(pcMain.Pages[tmpPageIndex].FindComponent('synEdit_' + IntToStr(tmpCptNummer))).Highlighter = shCobol then
  begin
    Cobol1.Checked := true;
  end
  else if TSynEdit(pcMain.Pages[tmpPageIndex].FindComponent('synEdit_' + IntToStr(tmpCptNummer))).Highlighter = shCSS then
  begin
    CSS1.Checked := true;
  end
  else if TSynEdit(pcMain.Pages[tmpPageIndex].FindComponent('synEdit_' + IntToStr(tmpCptNummer))).Highlighter = shEiffel then
  begin
    Eiffel1.Checked := true;
  end
  else if TSynEdit(pcMain.Pages[tmpPageIndex].FindComponent('synEdit_' + IntToStr(tmpCptNummer))).Highlighter = shFortran then
  begin
    Fortran1.Checked := true;
  end
  else if TSynEdit(pcMain.Pages[tmpPageIndex].FindComponent('synEdit_' + IntToStr(tmpCptNummer))).Highlighter = shFoxPro then
  begin
    FoxPr1.Checked := true;
  end
  else if TSynEdit(pcMain.Pages[tmpPageIndex].FindComponent('synEdit_' + IntToStr(tmpCptNummer))).Highlighter = shHTML then
  begin
    HTML1.Checked := true;
  end
  else if TSynEdit(pcMain.Pages[tmpPageIndex].FindComponent('synEdit_' + IntToStr(tmpCptNummer))).Highlighter = shPascal then
  begin
    Pascal1.Checked := true;
  end
  else if TSynEdit(pcMain.Pages[tmpPageIndex].FindComponent('synEdit_' + IntToStr(tmpCptNummer))).Highlighter = shPerl then
  begin
    Perl1.Checked := true;
  end
  else if TSynEdit(pcMain.Pages[tmpPageIndex].FindComponent('synEdit_' + IntToStr(tmpCptNummer))).Highlighter = shPHP then
  begin
    PHP1.Checked := true;
  end
  else if TSynEdit(pcMain.Pages[tmpPageIndex].FindComponent('synEdit_' + IntToStr(tmpCptNummer))).Highlighter = shPython then
  begin
    Python1.Checked := true;
  end
  else if TSynEdit(pcMain.Pages[tmpPageIndex].FindComponent('synEdit_' + IntToStr(tmpCptNummer))).Highlighter = shJava then
  begin
    Java1.Checked := true;
  end
  else if TSynEdit(pcMain.Pages[tmpPageIndex].FindComponent('synEdit_' + IntToStr(tmpCptNummer))).Highlighter = shJavascript then
  begin
    Javascript1.Checked := true;
  end
  else if TSynEdit(pcMain.Pages[tmpPageIndex].FindComponent('synEdit_' + IntToStr(tmpCptNummer))).Highlighter = shRuby then
  begin
    Ruby1.Checked := true;
  end
  else if TSynEdit(pcMain.Pages[tmpPageIndex].FindComponent('synEdit_' + IntToStr(tmpCptNummer))).Highlighter = shSQL then
  begin
    SQL1.Checked := true;
  end
  else if TSynEdit(pcMain.Pages[tmpPageIndex].FindComponent('synEdit_' + IntToStr(tmpCptNummer))).Highlighter = shTcl then
  begin
    Tcl1.Checked := true;
  end
  else if TSynEdit(pcMain.Pages[tmpPageIndex].FindComponent('synEdit_' + IntToStr(tmpCptNummer))).Highlighter = shTEX then
  begin
    eX1.Checked := true;
  end
  else if TSynEdit(pcMain.Pages[tmpPageIndex].FindComponent('synEdit_' + IntToStr(tmpCptNummer))).Highlighter = shUNIXShellScript then
  begin
    UNIXShellSkript1.Checked := true;
  end
  else if TSynEdit(pcMain.Pages[tmpPageIndex].FindComponent('synEdit_' + IntToStr(tmpCptNummer))).Highlighter = shVB then
  begin
    VisualBasic1.Checked := true;
  end
  else if TSynEdit(pcMain.Pages[tmpPageIndex].FindComponent('synEdit_' + IntToStr(tmpCptNummer))).Highlighter = shVBScript then
  begin
    VisualBasicScript1.Checked := true;
  end
  else if TSynEdit(pcMain.Pages[tmpPageIndex].FindComponent('synEdit_' + IntToStr(tmpCptNummer))).Highlighter = shVRML97 then
  begin
    VRML971.Checked := true;
  end
  else if TSynEdit(pcMain.Pages[tmpPageIndex].FindComponent('synEdit_' + IntToStr(tmpCptNummer))).Highlighter = shXML then
  begin
    XML1.Checked := true;
  end
  else
  begin
    keineHervorhebung1.Checked := true;
  end;

  //Sichtbare Zeichen
  if eoShowSpecialChars in TSynEdit(pcMain.Pages[tmpPageIndex].FindComponent('synEdit_' + IntToStr(tmpCptNummer))).Options then
  begin
    SichtbareZeichenEinAus1.Checked := true;
  end
  else
  begin
    SichtbareZeichenEinAus1.Checked := false;
  end;

  //Schrift vergrößern verkleinern
  if TSynEdit(pcMain.Pages[tmpPageIndex].FindComponent('synEdit_' + IntToStr(tmpCptNummer))).Font.Size >= 10 then
  begin
    Schriftverkleinern1.Enabled := true;
  end
  else
  begin
    Schriftverkleinern1.Enabled := false;
  end;

  ANSI1.Checked := false;
  Unicode1.Checked := false;

  if myTabStatusArray[tmpArrayStateNumber].charSet = ANSI then ANSI1.Checked := true
  else if myTabStatusArray[tmpArrayStateNumber].charSet = Unicode then Unicode1.Checked := true;

  //Allgemeine Sachen
  //Anzeige der Zeilen und Spalten
  oldState := myTabStatusArray[tmpArrayStateNumber].contentChanged;
  ShowSynEditOnStatusButton(TSynEdit(pcMain.Pages[tmpPageIndex].FindComponent('synEdit_' + IntToStr(tmpCptNummer))), [scAll]);
  myTabStatusArray[tmpArrayStateNumber].contentChanged := oldState;

  //Leseetc zeichen
  Zeilennummern1.Checked := myTabStatusArray[tmpArrayStateNumber].optZeilennummer;
  Zeilenmarkeranzeigen1.Checked := myTabStatusArray[tmpArrayStateNumber].optZeilenmarker;

  WordWrap1.Checked := myTabStatusArray[tmpArrayStateNumber].optWordWrap;

  TSynEdit(pcMain.Pages[tmpPageIndex].FindComponent('synEdit_' + IntToStr(tmpCptNummer))).WordWrap := myTabStatusArray[tmpArrayStateNumber].optWordWrap;

  //Bookmaks
   if myTabStatusArray[tmpArrayStateNumber].itlBookmark00 = true then
   begin
     Lesezeichen05.Checked := true;
     Lesezeichen01.Checked := true;
     Lesezeichen04.Checked := true;
     Lesezeichen02.Checked := true;
   end
   else
   begin
     Lesezeichen05.Checked := false;
     Lesezeichen01.Checked := false;
     Lesezeichen04.Checked := false;
     Lesezeichen02.Checked := false;
   end;

   if myTabStatusArray[tmpArrayStateNumber].itlBookmark01 = true then
   begin
     Lesezeichen15.Checked := true;
     Lesezeichen11.Checked := true;
     Lesezeichen14.Checked := true;
     Lesezeichen12.Checked := true;
   end
   else
   begin
     Lesezeichen15.Checked := false;
     Lesezeichen11.Checked := false;
     Lesezeichen14.Checked := false;
     Lesezeichen12.Checked := false;
   end;

   if myTabStatusArray[tmpArrayStateNumber].itlBookmark02 = true then
   begin
     Lesezeichen25.Checked := true;
     Lesezeichen21.Checked := true;
     Lesezeichen24.Checked := true;
     Lesezeichen22.Checked := true;
   end
   else
   begin
     Lesezeichen25.Checked := false;
     Lesezeichen21.Checked := false;
     Lesezeichen24.Checked := false;
     Lesezeichen22.Checked := false;
   end;

   if myTabStatusArray[tmpArrayStateNumber].itlBookmark03 = true then
   begin
     Lesezeichen35.Checked := true;
     Lesezeichen31.Checked := true;
     Lesezeichen34.Checked := true;
     Lesezeichen32.Checked := true;
   end
   else
   begin
     Lesezeichen35.Checked := false;
     Lesezeichen31.Checked := false;
     Lesezeichen34.Checked := false;
     Lesezeichen32.Checked := false;
   end;

   if myTabStatusArray[tmpArrayStateNumber].itlBookmark04 = true then
   begin
     Lesezeichen45.Checked := true;
     Lesezeichen41.Checked := true;
     Lesezeichen44.Checked := true;
     Lesezeichen42.Checked := true;
   end
   else
   begin
     Lesezeichen45.Checked := false;
     Lesezeichen41.Checked := false;
     Lesezeichen44.Checked := false;
     Lesezeichen42.Checked := false;
   end;

   if myTabStatusArray[tmpArrayStateNumber].itlBookmark05 = true then
   begin
     Lesezeichen55.Checked := true;
     Lesezeichen51.Checked := true;
     Lesezeichen54.Checked := true;
     Lesezeichen52.Checked := true;
   end
   else
   begin
     Lesezeichen55.Checked := false;
     Lesezeichen51.Checked := false;
     Lesezeichen54.Checked := false;
     Lesezeichen52.Checked := false;
   end;

   if myTabStatusArray[tmpArrayStateNumber].itlBookmark06 = true then
   begin
     Lesezeichen65.Checked := true;
     Lesezeichen61.Checked := true;
     Lesezeichen64.Checked := true;
     Lesezeichen62.Checked := true;
   end
   else
   begin
     Lesezeichen65.Checked := false;
     Lesezeichen61.Checked := false;
     Lesezeichen64.Checked := false;
     Lesezeichen62.Checked := false;
   end;

   if myTabStatusArray[tmpArrayStateNumber].itlBookmark07 = true then
   begin
     Lesezeichen75.Checked := true;
     Lesezeichen71.Checked := true;
     Lesezeichen74.Checked := true;
     Lesezeichen72.Checked := true;
   end
   else
   begin
     Lesezeichen75.Checked := false;
     Lesezeichen71.Checked := false;
     Lesezeichen74.Checked := false;
     Lesezeichen72.Checked := false;
   end;

   if myTabStatusArray[tmpArrayStateNumber].itlBookmark08 = true then
   begin
     Lesezeichen85.Checked := true;
     Lesezeichen81.Checked := true;
     Lesezeichen84.Checked := true;
     Lesezeichen82.Checked := true;
   end
   else
   begin
     Lesezeichen85.Checked := false;
     Lesezeichen81.Checked := false;
     Lesezeichen84.Checked := false;
     Lesezeichen82.Checked := false;
   end;

   if myTabStatusArray[tmpArrayStateNumber].itlBookmark09 = true then
   begin
     Lesezeichen95.Checked := true;
     Lesezeichen91.Checked := true;
     Lesezeichen94.Checked := true;
     Lesezeichen92.Checked := true;
   end
   else
   begin
     Lesezeichen95.Checked := false;
     Lesezeichen91.Checked := false;
     Lesezeichen94.Checked := false;
     Lesezeichen92.Checked := false;
   end;

  //Gutter Visible
  if ((myTabStatusArray[tmpArrayStateNumber].optZeilennummer = false) and
   (myTabStatusArray[tmpArrayStateNumber].itlBookmark00 = false) and
   (myTabStatusArray[tmpArrayStateNumber].itlBookmark01 = false) and
   (myTabStatusArray[tmpArrayStateNumber].itlBookmark02 = false) and
   (myTabStatusArray[tmpArrayStateNumber].itlBookmark03 = false) and
   (myTabStatusArray[tmpArrayStateNumber].itlBookmark04 = false) and
   (myTabStatusArray[tmpArrayStateNumber].itlBookmark05 = false) and
   (myTabStatusArray[tmpArrayStateNumber].itlBookmark06 = false) and
   (myTabStatusArray[tmpArrayStateNumber].itlBookmark07 = false) and
   (myTabStatusArray[tmpArrayStateNumber].itlBookmark08 = false) and
   (myTabStatusArray[tmpArrayStateNumber].itlBookmark09 = false)) then
     begin
       TSynEdit(pcMain.Pages[tmpPageIndex].FindComponent('synEdit_' + IntToStr(tmpCptNummer))).Gutter.Visible := false;
     end
     else TSynEdit(pcMain.Pages[tmpPageIndex].FindComponent('synEdit_' + IntToStr(tmpCptNummer))).Gutter.Visible := true;

  //Application Titel
  if myTabStatusArray[tmpArrayStateNumber].fileName <> '' then
  begin
    Application.Title := 'gtEdit - [' + myTabStatusArray[tmpArrayStateNumber].fileName + ']';
    TrayIcon.Hint := 'gtEdit - [' + myTabStatusArray[tmpArrayStateNumber].fileName + ']';
    FormMain.Caption := 'gtEdit v' + appVersion + ' - [' + myTabStatusArray[tmpArrayStateNumber].fileName + ']';
  end
  else if myTabStatusArray[tmpArrayStateNumber].captionOfTab <> '' then
  begin
    Application.Title := 'gtEdit - [' + myTabStatusArray[tmpArrayStateNumber].captionOfTab + ']';
    TrayIcon.Hint := 'gtEdit - [' + myTabStatusArray[tmpArrayStateNumber].captionOfTab + ']';
    FormMain.Caption := 'gtEdit v' + appVersion + ' - [' + myTabStatusArray[tmpArrayStateNumber].captionOfTab + ']';
  end;
end;

procedure TFormMain.SetLastFiles;
begin
//LastFiles Systen
  if lastFiles[1] <> '' then begin M11.Caption := '1 ' + lastFiles[1]; M11.Visible := true; end
  else M11.Visible := false;

  if lastFiles[2] <> '' then begin M21.Caption := '2 ' + lastFiles[2]; M21.Visible := true; end
  else M21.Visible := false;

  if lastFiles[3] <> '' then begin M31.Caption := '3 ' + lastFiles[3]; M31.Visible := true; end
  else M31.Visible := false;

  if lastFiles[4] <> '' then begin M41.Caption := '4 ' + lastFiles[4]; M41.Visible := true; end
  else M41.Visible := false;

  if lastFiles[5] <> '' then begin M51.Caption := '5 ' + lastFiles[5]; M51.Visible := true; end
  else M51.Visible := false;
end;

procedure TFormMain.FormCreate(Sender: TObject);
var chmFile: string;
begin
  //First Instanz Handle (FIH)
  gtMemoryMappedFile.WriteStringToMMF(myGUID + 'FHI', IntToStr(FormMain.Handle));

  // Hilfe CHM Init
 chmFile := ExtractFilePath(Application.ExeName) + 'gtEdit.chm';

 mHHelp := nil;

 if not FileExists(chmFile) then
  begin ShowMessage('Hilfe-Datei nicht gefunden'#13 + chmFile) end;

 {HH 1.2 oder höher Versionskontrolle}
 if (hh.HHCtrlHandle = 0)
  or (hh_funcs._hhMajVer < 4)
  or ((hh_funcs._hhMajVer = 4) and (hh_funcs._hhMinVer < 73)) then
  begin ShowMessage('Diese Anwendung erfordert die Installation der ' +
   'MS HTML Help 1.2 oder höher') end;

 {Hook - verwendet HH_FUNCS.pas}
 mHHelp := hh_funcs.THookHelpSystem.Create(chmFile, '', htHHAPI);

 // Hilfe CHM Init Ende

   DragAcceptFiles(FormMain.Handle, true);


  // Menurechts
  gtMenu.MenuItemRightJustify(X1);

  //Optionen laden
  optEditorZeilennummer := myGlobalIni.ReadBool('editor', 'zeilennummer', true);
  optEditorZeilenmarker := myGlobalIni.ReadBool('editor', 'zeilenmarker', true);
  optEditorLineal := myGlobalIni.ReadBool('editor', 'lineal', true);
  optEditorAutoHighlighterOpen := myGlobalIni.ReadBool('editor', 'autohighlighter', true);
  optEditorWordWrap := myGlobalIni.ReadBool('editor', 'wordwrap', false);

  optLastConfigSave := myGlobalIni.ReadBool('editor', 'lastconfigsave', false);
  optLastWindowSettings := myGlobalIni.ReadBool('editor', 'lastwindowsettings', false);

  optAnwendungInTrayMinimize := myGlobalIni.ReadBool('anwendung', 'intrayminimize', false);
  if optAnwendungInTrayMinimize = true then TrayIcon.Active := true;

  optAnwendungBeimStartMaximieren := myGlobalIni.ReadBool('anwendung', 'onstartmaximize', true);

  optEditorFont.Name := myGlobalIni.ReadString('editor', 'fontname', 'Courier New');
  optEditorFont.Size := myGlobalIni.ReadInteger('editor', 'fontsize', 10);
  optEditorTabSpaces := myGlobalIni.ReadInteger('editor', 'tabspaces', 4);

  lastFiles[1] := myGlobalIni.ReadString('lastfiles', 'm1', '');
  lastFiles[2] := myGlobalIni.ReadString('lastfiles', 'm2', '');
  lastFiles[3] := myGlobalIni.ReadString('lastfiles', 'm3', '');
  lastFiles[4] := myGlobalIni.ReadString('lastfiles', 'm4', '');
  lastFiles[5] := myGlobalIni.ReadString('lastfiles', 'm5', '');

  //Sonstiges
  FormMain.DoubleBuffered := true;
  SetLength(myTabStatusArray, ArraySizeMultiplikator);
  CreateNewTab;
  GetParameters;

  SetLastFiles;

  //maximize
  if optAnwendungBeimStartMaximieren = true then WindowState := wsMaximized
  else if optLastWindowSettings = true then
  begin
    FormMain.Left := myGlobalIni.ReadInteger('editor', 'lwsX', 0);
    FormMain.Top := myGlobalIni.ReadInteger('editor', 'lwsY', 0);
    FormMain.Width := myGlobalIni.ReadInteger('editor', 'lwsWidth', 640);
    FormMain.Height := myGlobalIni.ReadInteger('editor', 'lwsHeight', 480);
  end;
end;

procedure TFormMain.N1Click(Sender: TObject);
begin
  GetValues;
  CreateNewTab;
  TSynEdit(pcMain.Pages[tmpPageIndex].FindComponent('synEdit_' + IntToStr(tmpCptNummer))).SetFocus;
  GetParameters;
end;

procedure TFormMain.GetHighlighter(extension: string);
begin
  extension := AnsiLowerCase(extension);
  if AnsiPos(extension, shAssembler.DefaultFilter) > 0 then SetEditHighlighter(shAssembler)
  else if AnsiPos(extension, shAWK.DefaultFilter) > 0 then SetEditHighlighter(shAWK)
  else if AnsiPos(extension, shBatchScriptDOS.DefaultFilter) > 0 then SetEditHighlighter(shBatchScriptDOS)
  else if AnsiPos(extension, shCPlusPlus.DefaultFilter) > 0 then SetEditHighlighter(shCPlusPlus)
  else if AnsiPos(extension, shCSharp.DefaultFilter) > 0 then SetEditHighlighter(shCSharp)
  else if AnsiPos(extension, shCobol.DefaultFilter) > 0 then SetEditHighlighter(shCobol)
  else if AnsiPos(extension, shCSS.DefaultFilter) > 0 then SetEditHighlighter(shCSS)
  else if AnsiPos(extension, shEiffel.DefaultFilter) > 0 then SetEditHighlighter(shEiffel)
  else if AnsiPos(extension, shFortran.DefaultFilter) > 0 then SetEditHighlighter(shFortran)
  else if AnsiPos(extension, shFoxPro.DefaultFilter) > 0 then SetEditHighlighter(shFoxPro)
  else if AnsiPos(extension, shHTML.DefaultFilter) > 0 then SetEditHighlighter(shHTML)
  else if AnsiPos(extension, shPascal.DefaultFilter) > 0 then SetEditHighlighter(shPascal)
  else if AnsiPos(extension, shPerl.DefaultFilter) > 0 then SetEditHighlighter(shPerl)
  else if AnsiPos(extension, shPHP.DefaultFilter) > 0 then SetEditHighlighter(shPHP)
  else if AnsiPos(extension, shPython.DefaultFilter) > 0 then SetEditHighlighter(shPython)
  else if AnsiPos(extension, shJava.DefaultFilter) > 0 then SetEditHighlighter(shJava)
  else if AnsiPos(extension, shJavascript.DefaultFilter) > 0 then SetEditHighlighter(shJavascript)
  else if AnsiPos(extension, shRuby.DefaultFilter) > 0 then SetEditHighlighter(shRuby)
  else if AnsiPos(extension, shSQL.DefaultFilter) > 0 then SetEditHighlighter(shSQL)
  else if AnsiPos(extension, shTcl.DefaultFilter) > 0 then SetEditHighlighter(shTcl)
  else if AnsiPos(extension, shTEX.DefaultFilter) > 0 then SetEditHighlighter(shTEX)
  else if AnsiPos(extension, shVB.DefaultFilter) > 0 then SetEditHighlighter(shVB)
  else if AnsiPos(extension, shVBScript.DefaultFilter) > 0 then SetEditHighlighter(shVBScript)
  else if AnsiPos(extension, shUNIXShellScript.DefaultFilter) > 0 then SetEditHighlighter(shUNIXShellScript)
  else if AnsiPos(extension, shVRML97.DefaultFilter) > 0 then SetEditHighlighter(shVRML97)
  else if AnsiPos(extension, shXML.DefaultFilter) > 0 then SetEditHighlighter(shXML)
  else SetEditHighlighter(nil);
end;

procedure TFormMain.OpenFile(filename: string);
begin
  if FileExists(filename)=false then
  begin
    MessageDlg('Die zu öffnende Datei existiert nicht. Das Öffnen wird abgebrochen!', mtInformation, [mbOk], 0);
    Exit;
  end;

    if ((myTabStatusArray[tmpArrayStateNumber].fileName <> '') or (myTabStatusArray[tmpArrayStateNumber].contentChanged = true) or (pcMain.PageCount=0)) then
    begin
      CreateNewTab;
    end;

    //lastfile system
    if lastFiles[1] <> filename then
    begin
      lastFiles[5] := lastFiles[4];
      lastFiles[4] := lastFiles[3];
      lastFiles[3] := lastFiles[2];
      lastFiles[2] := lastFiles[1];
      lastFiles[1] := filename;
    end;

    SetLastFiles;

    TSynEdit(pcMain.Pages[tmpPageIndex].FindComponent('synEdit_' + IntToStr(tmpCptNummer))).Lines.LoadFromFile(filename);
    TTabSheet(pcMain.FindComponent('tab_' + IntToStr(tmpCptNummer))).Caption := ExtractFileName(filename);

    myTabStatusArray[tmpArrayStateNumber].fileName := filename;
    myTabStatusArray[tmpArrayStateNumber].captionOfTab := ExtractFileName(filename);
    myTabStatusArray[tmpArrayStateNumber].contentChanged := false;

    if TSynEdit(pcMain.Pages[tmpPageIndex].FindComponent('synEdit_' + IntToStr(tmpCptNummer))).Lines.SaveUnicode = true then myTabStatusArray[tmpArrayStateNumber].charSet := Unicode
    else myTabStatusArray[tmpArrayStateNumber].charSet := ANSI;

    //andere sachen
    if optEditorAutoHighlighterOpen = true then GetHighlighter(ExtractFileExt(filename));
end;

procedure TFormMain.ffen1Click(Sender: TObject);
begin
  GetValues;

  if OpenDialog.Execute then
  begin
    OpenFile(OpenDialog.FileName);
  end;
end;

procedure TFormMain.pcMainChange(Sender: TObject);
begin
  GetParameters;
end;

procedure TFormMain.SetEditHighlighter(myHL: TSynCustomHighlighter);
begin
  GetValues;

  TSynEdit(pcMain.Pages[tmpPageIndex].FindComponent('synEdit_' + IntToStr(tmpCptNummer))).Highlighter := myHL;
  GetParameters;
end;

procedure TFormMain.CC1Click(Sender: TObject);
begin
  SetEditHighlighter(shCPlusPlus);
end;

procedure TFormMain.C1Click(Sender: TObject);
begin
  SetEditHighlighter(shCSharp);
end;

procedure TFormMain.CSS1Click(Sender: TObject);
begin
  SetEditHighlighter(shCSS);
end;

procedure TFormMain.HTML1Click(Sender: TObject);
begin
  SetEditHighlighter(shHTML);
end;

procedure TFormMain.Pascal1Click(Sender: TObject);
begin
  SetEditHighlighter(shPascal);
end;

procedure TFormMain.Perl1Click(Sender: TObject);
begin
  SetEditHighlighter(shPerl);
end;

procedure TFormMain.PHP1Click(Sender: TObject);
begin
  SetEditHighlighter(shPHP);
end;

procedure TFormMain.Java1Click(Sender: TObject);
begin
  SetEditHighlighter(shJava);
end;

procedure TFormMain.XML1Click(Sender: TObject);
begin
  SetEditHighlighter(shXML);
end;

procedure TFormMain.Eiffel1Click(Sender: TObject);
begin
  SetEditHighlighter(shEiffel);
end;

procedure TFormMain.Fortran1Click(Sender: TObject);
begin
  SetEditHighlighter(shFortran);
end;

procedure TFormMain.VisualBasic1Click(Sender: TObject);
begin
  SetEditHighlighter(shVB);
end;

procedure TFormMain.Javascript1Click(Sender: TObject);
begin
  SetEditHighlighter(shJavascript);
end;

procedure TFormMain.Cobol1Click(Sender: TObject);
begin
  SetEditHighlighter(shCobol);
end;

procedure TFormMain.VisualBasicScript1Click(Sender: TObject);
begin
  SetEditHighlighter(shVBScript);
end;

procedure TFormMain.VRML971Click(Sender: TObject);
begin
  SetEditHighlighter(shVRML97);
end;

procedure TFormMain.awk1Click(Sender: TObject);
begin
  SetEditHighlighter(shAWK);
end;

procedure TFormMain.BatchSkriptDOS1Click(Sender: TObject);
begin
  SetEditHighlighter(shBatchScriptDOS);
end;

procedure TFormMain.keineHervorhebung1Click(Sender: TObject);
begin
  SetEditHighlighter(nil);
end;

procedure TFormMain.Python1Click(Sender: TObject);
begin
  SetEditHighlighter(shPython);
end;

procedure TFormMain.tcl1Click(Sender: TObject);
begin
  SetEditHighlighter(shTcl);
end;

procedure TFormMain.Ruby1Click(Sender: TObject);
begin
  SetEditHighlighter(shRuby);
end;

procedure TFormMain.UNIXShellSkript1Click(Sender: TObject);
begin
  SetEditHighlighter(shUNIXShellScript);
end;

procedure TFormMain.Assembler1Click(Sender: TObject);
begin
  SetEditHighlighter(shAssembler);
end;

procedure TFormMain.SQL1Click(Sender: TObject);
begin
  SetEditHighlighter(shSQL);
end;

procedure TFormMain.eX1Click(Sender: TObject);
begin
  SetEditHighlighter(shTEX);
end;

procedure TFormMain.FormShow(Sender: TObject);
begin
  GetValues;
  TSynEdit(pcMain.Pages[tmpPageIndex].FindComponent('synEdit_' + IntToStr(tmpCptNummer))).SetFocus;
  GetParameters;

  if FileExists(ParamStr(1)) then OpenFile(ParamStr(1));
end;

procedure TFormMain.FoxPr1Click(Sender: TObject);
begin
  SetEditHighlighter(shFoxPro);
end;

procedure TFormMain.DeleteTab(myActivePageIndex: Integer);
var myResult: Integer;
begin
  if pcMain.PageCount = 0 then Exit;

  pcMain.ActivePageIndex := myActivePageIndex;
  GetParameters;

  if myTabStatusArray[tmpArrayStateNumber].contentChanged  = true then
  begin
    myResult := MessageDlg('Änderungen in ' + myTabStatusArray[tmpArrayStateNumber].captionOfTab + ' speichern?' , mtConfirmation, [mbYes, mbNo, mbCancel], 0);
    if myresult = 2 then begin mySaveCancel := true; Exit; end;
    if myresult = 6 then Speichern1Click(self);
  end;

  myTabStatusArray[tmpArrayStateNumber].active := false;
  myTabStatusArray[tmpArrayStateNumber].fileName := '';
  myTabStatusArray[tmpArrayStateNumber].contentChanged := false;
  myTabStatusArray[tmpArrayStateNumber].captionOfTab := '';

   myTabStatusArray[tmpArrayStateNumber].itlBookmark00 := false;
   myTabStatusArray[tmpArrayStateNumber].itlBookmark01 := false;
   myTabStatusArray[tmpArrayStateNumber].itlBookmark02 := false;
   myTabStatusArray[tmpArrayStateNumber].itlBookmark03 := false;
   myTabStatusArray[tmpArrayStateNumber].itlBookmark04 := false;
   myTabStatusArray[tmpArrayStateNumber].itlBookmark05 := false;
   myTabStatusArray[tmpArrayStateNumber].itlBookmark06 := false;
   myTabStatusArray[tmpArrayStateNumber].itlBookmark07 := false;
   myTabStatusArray[tmpArrayStateNumber].itlBookmark08 := false;
   myTabStatusArray[tmpArrayStateNumber].itlBookmark09 := false;

  pcMain.Pages[pcMain.ActivePageIndex].Free;
end;

procedure TFormMain.Schlien1Click(Sender: TObject);
var tmpPI: Integer;
begin
  //GetParameters;
  //TimerMainTimer(Sender);
  tmpPI := pcMain.ActivePageIndex;
  DeleteTab(pcMain.ActivePageIndex);

  //TODO NEW
  if pcMain.PageCount>1 then
  begin
    if tmpPI = 0 then pcMain.ActivePageIndex := 0
    else pcMain.ActivePageIndex := tmpPI-1;
  end;

  mySaveCancel := false;
end;

procedure TFormMain.TimerMainTimer(Sender: TObject);
begin
  StatusBar.Panels[0].Width := FormMain.Width - 220;

  StatusBar.Panels[1].Text := gtInputDevices.GetNumState;
  StatusBar.Panels[3].Text := gtInputDevices.GetCapsState;
  StatusBar.Panels[4].Text := gtInputDevices.GetScrollState;

  //Andere
  if(pcMain.PageCount > 0) then
  begin
    GetParameters;

    if TSynEdit(pcMain.Pages[tmpPageIndex].FindComponent('synEdit_' + IntToStr(tmpCptNummer))).InsertMode = true then
    begin
      StatusBar.Panels[2].Text := 'EINF';
    end
    else
    begin
      StatusBar.Panels[2].Text := 'ÜBR';
    end;

    if(myTabStatusArray[tmpArrayStateNumber].contentChanged = true) then
    begin
      Speichern1.Enabled := true;
      TBItem2.Enabled := true;
      TTabSheet(pcMain.FindComponent('tab_' + IntToStr(tmpCptNummer))).Caption := myTabStatusArray[tmpArrayStateNumber].captionOfTab + '*';
    end
    else
    begin
      Speichern1.Enabled := false;
      TBItem2.Enabled := false;
      TTabSheet(pcMain.FindComponent('tab_' + IntToStr(tmpCptNummer))).Caption := myTabStatusArray[tmpArrayStateNumber].captionOfTab;
    end;
  end;

  if pcMain.ActivePageIndex = -1 then
  begin
    FormMain.Caption := 'gtEdit v' + appVersion;
    Application.Title := 'gtEdit';
    TrayIcon.Hint := 'gtEdit';

    StatusBar.Panels[2].Text := '';

    Schlien1.Enabled := false;
    Allesschlieen1.Enabled := false;
    Syntaxhervorhebung1.Enabled := false;
    SichtbareZeichenEinAus1.Enabled := false;
    Schriftverkleinern1.Enabled := false;
    Schriftvergrern1.Enabled := false;
    Speichernunter1.Enabled := false;
    TBItem4.Enabled := false;
    Ausschneiden1.Enabled := false;
    Kopieren1.Enabled := false;
    Einfgen1.Enabled := false;
    Allesmarkieren1.Enabled := false;
    Drucken1.Enabled := false;
    TBItem5.Enabled := false;
    Seitenansicht1.Enabled := false;
    GehezuZeile1.Enabled := false;
    AllesschlieenausseraktuellerDatei1.Enabled := false;
    Rckgngig1.Enabled := false;
    TBItem9.Enabled := false;
    Wiederherstellen1.Enabled := false;
    TBItem10.Enabled := false;

    TBItem6.Enabled := false;
    TBItem7.Enabled := false;
    TBItem8.Enabled := false;

    Suchen2.Enabled := false;
    Weitersuchen1.Enabled := false;
    Weitersuchenletzes1.Enabled := false;
    Ersetzen1.Enabled := false;

    Speichern1.Enabled := false;
    TBItem2.Enabled := false;
    TBItem11.Enabled := false;

    Grobuchstaben1.Enabled := false;
    Kleinbuchstaben1.Enabled := false;
    GroundKleinbuchstabenvertauschen1.Enabled := false;

    Zeilennummern1.Enabled := false;
    Zeilenmarkeranzeigen1.Enabled := false;

    Lesezeichen1.Enabled := false;
    Lesezeichensetzen2.Enabled := false;

    WordWrap1.Enabled := false;

    Schriftarteinstellen1.Enabled := false;
Kapitale1.Enabled := false;
T1.Enabled := false;
LeerzeicheninTabulatorenumwandelnAlle1.Enabled := false;
Zeiletrimmen1.Enabled := false;
Zeilelinkstrimmen1.Enabled := false;
Zeilerechtstrimmen1.Enabled := false;
WhitespacesanZeilenendenentfernen1.Enabled := false;
Wrterzhlen1.Enabled := false;

 Allesspeichern1.Enabled := false;

    ANSI1.Enabled := false;
    Unicode1.Enabled := false;
  end
  else
  begin
    if TSynEdit(pcMain.Pages[tmpPageIndex].FindComponent('synEdit_' + IntToStr(tmpCptNummer))).Font.Size <= 8 then
    begin
      Schriftverkleinern1.Enabled := false;
    end
    else
    begin
      Schriftverkleinern1.Enabled := true;
    end;

    if pcMain.PageCount > 1 then
    begin
      AllesschlieenausseraktuellerDatei1.Enabled := true;
      AllesausseraktuellerDateischlieen1.Enabled := true;
    end
    else
    begin
      AllesschlieenausseraktuellerDatei1.Enabled := false;
      AllesausseraktuellerDateischlieen1.Enabled := false;
    end;

    Schlien1.Enabled := true;
    Allesschlieen1.Enabled := true;
    Syntaxhervorhebung1.Enabled := true;
    SichtbareZeichenEinAus1.Enabled := true;
    Schriftvergrern1.Enabled := true;
    Speichernunter1.Enabled := true;
    TBItem4.Enabled := true;
    Ausschneiden1.Enabled := true;
    Kopieren1.Enabled := true;
    Einfgen1.Enabled := true;
    Allesmarkieren1.Enabled := true;
    Drucken1.Enabled := true;
    TBItem5.Enabled := true;
    Seitenansicht1.Enabled := true;
    GehezuZeile1.Enabled := true;
    Rckgngig1.Enabled := true;
    TBItem9.Enabled := true;
    Wiederherstellen1.Enabled := true;
    TBItem10.Enabled := true;

    TBItem6.Enabled := true;
    TBItem7.Enabled := true;
    TBItem8.Enabled := true;

    Suchen2.Enabled := true;
    Weitersuchen1.Enabled := true;
    Weitersuchenletzes1.Enabled := true;
    Ersetzen1.Enabled := true;

    TBItem11.Enabled := true;

    Grobuchstaben1.Enabled := true;
    Kleinbuchstaben1.Enabled := true;
    GroundKleinbuchstabenvertauschen1.Enabled := true;

    Zeilennummern1.Enabled := true;
    Zeilenmarkeranzeigen1.Enabled := true;

    Lesezeichen1.Enabled := true;
    Lesezeichensetzen2.Enabled := true;

    WordWrap1.Enabled := true;

    Schriftarteinstellen1.Enabled := true;
Kapitale1.Enabled := true;
T1.Enabled := true;
LeerzeicheninTabulatorenumwandelnAlle1.Enabled := true;
Zeiletrimmen1.Enabled := true;
Zeilelinkstrimmen1.Enabled := true;
Zeilerechtstrimmen1.Enabled := true;
WhitespacesanZeilenendenentfernen1.Enabled := true;
Wrterzhlen1.Enabled := true;

Allesspeichern1.Enabled := true;

ANSI1.Enabled := true;
    Unicode1.Enabled := true;
  end;
   {
   //Debug
  try
   if myTabStatusArray[tmpArrayStateNumber].charSet = ANSI then FormMain.Caption := 'ANSI'
   else FormMain.Caption := 'Unicode';
   if TSynEdit(pcMain.Pages[tmpPageIndex].FindComponent('synEdit_' + IntToStr(tmpCptNummer))).Lines.SaveUnicode = true then FormMain.Caption := FormMain.Caption + ' - Unicode'
   else FormMain.Caption := FormMain.Caption + ' - ANSI'
  except
  end;  }
end;

procedure TFormMain.Allesschlieen1Click(Sender: TObject);
var i: Integer;
begin
  mySaveDontClose := false;
  for i := 0 to pcMain.PageCount-1 do
  begin
    DeleteTab(0);
    if mySaveCancel = true then
    begin
      mySaveCancel := false;
      mySaveDontClose := true;
      Exit;
    end;
  end;
end;

procedure TFormMain.ber1Click(Sender: TObject);
begin
  FormAbout.ShowModal;
end;

procedure TFormMain.SichtbareZeichenEinAus1Click(Sender: TObject);
begin
  GetValues;

  if eoShowSpecialChars in TSynEdit(pcMain.Pages[tmpPageIndex].FindComponent('synEdit_' + IntToStr(tmpCptNummer))).Options then
  begin
    TSynEdit(pcMain.Pages[tmpPageIndex].FindComponent('synEdit_' + IntToStr(tmpCptNummer))).Options := TSynEdit(pcMain.Pages[tmpPageIndex].FindComponent('synEdit_' + IntToStr(tmpCptNummer))).Options - [eoShowSpecialChars];
  end
  else
  begin
    TSynEdit(pcMain.Pages[tmpPageIndex].FindComponent('synEdit_' + IntToStr(tmpCptNummer))).Options := TSynEdit(pcMain.Pages[tmpPageIndex].FindComponent('synEdit_' + IntToStr(tmpCptNummer))).Options + [eoShowSpecialChars];
  end;

  GetParameters;
end;

procedure TFormMain.Schriftvergrern1Click(Sender: TObject);
begin
  GetValues;
  TSynEdit(pcMain.Pages[tmpPageIndex].FindComponent('synEdit_' + IntToStr(tmpCptNummer))).Font.Size := TSynEdit(pcMain.Pages[tmpPageIndex].FindComponent('synEdit_' + IntToStr(tmpCptNummer))).Font.Size + 2;
  GetParameters;
end;

procedure TFormMain.Schriftverkleinern1Click(Sender: TObject);
begin
  GetValues;
  TSynEdit(pcMain.Pages[tmpPageIndex].FindComponent('synEdit_' + IntToStr(tmpCptNummer))).Font.Size := TSynEdit(pcMain.Pages[tmpPageIndex].FindComponent('synEdit_' + IntToStr(tmpCptNummer))).Font.Size - 2;
  GetParameters;
end;

procedure TFormMain.Speichernunter1Click(Sender: TObject);
begin
  GetValues;

  SaveDialog.FileName := myTabStatusArray[tmpArrayStateNumber].captionOfTab;

  //UNITODO
  //Hier müsste ein check ob es ein ascci oder ein unicode document ist (wenn ascii false ist
  // generel beim speichern
    //if synunicode.IsWideStringMappableToAnsi(TSynEdit(pcMain.Pages[tmpPageIndex].FindComponent('synEdit_' + IntToStr(tmpCptNummer))).Text) = true then MessageDlg('ist mapbar', mtInformation, [mbOk], 0)
  //else MessageDlg('ist NICHT mapbar', mtInformation, [mbOk], 0)
  //zusammenbauen der strings

  //Voreinstellung
  if TSynEdit(pcMain.Pages[tmpPageIndex].FindComponent('synEdit_' + IntToStr(tmpCptNummer))).Lines.SaveUnicode = true then SaveDialog.FilterIndex := 2
  else SaveDialog.FilterIndex := 1;

  if SaveDialog.Execute then
  begin
    //Ob Unicode gespeichert werden soll

    if SaveDialog.FilterIndex = 1 then
    begin TSynEdit(pcMain.Pages[tmpPageIndex].FindComponent('synEdit_' + IntToStr(tmpCptNummer))).Lines.SaveUnicode := false; end
    else if SaveDialog.FilterIndex = 2 then
    begin TSynEdit(pcMain.Pages[tmpPageIndex].FindComponent('synEdit_' + IntToStr(tmpCptNummer))).Lines.SaveUnicode := true; end;

    TSynEdit(pcMain.Pages[tmpPageIndex].FindComponent('synEdit_' + IntToStr(tmpCptNummer))).Lines.SaveToFile(SaveDialog.FileName);
    TTabSheet(pcMain.FindComponent('tab_' + IntToStr(tmpCptNummer))).Caption := ExtractFileName(SaveDialog.FileName);
    myTabStatusArray[tmpArrayStateNumber].fileName := SaveDialog.FileName;
    myTabStatusArray[tmpArrayStateNumber].captionOfTab := ExtractFileName(SaveDialog.FileName);
    myTabStatusArray[tmpArrayStateNumber].contentChanged := false;
  end;
end;

procedure TFormMain.Beenden1Click(Sender: TObject);
begin
  FormMain.Close;
end;

procedure TFormMain.Kopieren1Click(Sender: TObject);
begin
  GetValues;
  TSynEdit(pcMain.Pages[tmpPageIndex].FindComponent('synEdit_' + IntToStr(tmpCptNummer))).CopyToClipboard;
  GetValues;
 // GetParameters;
 // Clipboard.AsText := TSynEdit(pcMain.Pages[tmpPageIndex].FindComponent('synEdit_' + IntToStr(tmpCptNummer))).SelText;
  //GetParameters;
end;

procedure TFormMain.Ausschneiden1Click(Sender: TObject);
begin
  GetValues;
  TSynEdit(pcMain.Pages[tmpPageIndex].FindComponent('synEdit_' + IntToStr(tmpCptNummer))).CutToClipboard;
  GetValues;

  //GetValues;
 // Clipboard.AsText := TSynEdit(pcMain.Pages[tmpPageIndex].FindComponent('synEdit_' + IntToStr(tmpCptNummer))).SelText;
 // TSynEdit(pcMain.Pages[tmpPageIndex].FindComponent('synEdit_' + IntToStr(tmpCptNummer))).SelText := '';
 // GetParameters;
end;

//Bearbeiten / EInfügen
procedure TFormMain.Einfgen1Click(Sender: TObject);
begin
  GetValues;
  TSynEdit(pcMain.Pages[tmpPageIndex].FindComponent('synEdit_' + IntToStr(tmpCptNummer))).PasteFromClipboard;
  GetParameters;
end;      

procedure TFormMain.Allesmarkieren1Click(Sender: TObject);
var tmpLength: Integer;
begin
  GetValues;
  tmpLength := Length(TSynEdit(pcMain.Pages[tmpPageIndex].FindComponent('synEdit_' + IntToStr(tmpCptNummer))).Text);
  TSynEdit(pcMain.Pages[tmpPageIndex].FindComponent('synEdit_' + IntToStr(tmpCptNummer))).SelStart := 0;
  TSynEdit(pcMain.Pages[tmpPageIndex].FindComponent('synEdit_' + IntToStr(tmpCptNummer))).SelLength := tmpLength;
  GetParameters;
end;

procedure TFormMain.Druckereinrichten1Click(Sender: TObject);
begin
  PrinterSetupDialog.Execute;
end;

procedure TFormMain.Drucken1Click(Sender: TObject);
begin
  GetValues;

  if PrinterDialog.Execute then
  begin
    if PrinterDialog.PrintRange = prAllPages then
    begin
      SynEditPrint.SynEdit := TSynEdit(pcMain.Pages[tmpPageIndex].FindComponent('synEdit_' + IntToStr(tmpCptNummer)));
      SynEditPrint.SelectedOnly:=false;
    end
    else if PrinterDialog.PrintRange = prSelection then
    begin
      SynEditPrint.SynEdit := TSynEdit(pcMain.Pages[tmpPageIndex].FindComponent('synEdit_' + IntToStr(tmpCptNummer)));
      SynEditPrint.SelectedOnly:=true;
    end;

    SynEditPrint.Title := pcMain.Pages[tmpPageIndex].Caption;
    SynEditPrint.Print;
  end;
end;

procedure TFormMain.Seitenansicht1Click(Sender: TObject);
begin
  GetValues;

  SynEditPrint.SynEdit := TSynEdit(pcMain.Pages[tmpPageIndex].FindComponent('synEdit_' + IntToStr(tmpCptNummer)));
  SynEditPrint.Title := pcMain.Pages[tmpPageIndex].Caption;
  with FormPrintPreview do begin
    SynEditPrintPreview.SynEditPrint := SynEditPrint;
    ShowModal;
  end;
end;

procedure TFormMain.Syneditfilename1Click(Sender: TObject);
begin
  GetValues;
  FormMain.Caption := TSynEdit(pcMain.Pages[tmpPageIndex].FindComponent('synEdit_' + IntToStr(tmpCptNummer))).GetNamePath;
end;

procedure TFormMain.FormDestroy(Sender: TObject);
begin
  myGlobalIni.WriteString('lastfiles', 'm1', lastFiles[1]);
  myGlobalIni.WriteString('lastfiles', 'm2', lastFiles[2]);
  myGlobalIni.WriteString('lastfiles', 'm3', lastFiles[3]);
  myGlobalIni.WriteString('lastfiles', 'm4', lastFiles[4]);
  myGlobalIni.WriteString('lastfiles', 'm5', lastFiles[5]);

  myGlobalIni.WriteString('editor', 'fontname', optEditorFont.Name);
  myGlobalIni.WriteInteger('editor', 'fontsize', optEditorFont.Size);

  SetLength(myTabStatusArray, 0);

 HHCloseAll; // Schließt alle Hilfe-Fenster
 if Assigned(mHHelp) then
  begin mHHelp.Free end;
end;

procedure TFormMain.Speichern1Click(Sender: TObject);
var myTmpFileName: string;
begin
  GetParameters;

  myTmpFileName := myTabStatusArray[tmpArrayStateNumber].fileName;

  if (myTmpFileName <> '') then
  begin
    TSynEdit(pcMain.Pages[tmpPageIndex].FindComponent('synEdit_' + IntToStr(tmpCptNummer))).Lines.SaveToFile(myTmpFileName);
    TTabSheet(pcMain.FindComponent('tab_' + IntToStr(tmpCptNummer))).Caption := ExtractFileName(myTmpFileName);
    myTabStatusArray[tmpArrayStateNumber].contentChanged := false;
  end
  else
  begin
    Speichernunter1Click(Sender);
  end;
end;

procedure TFormMain.Schlieen1Click(Sender: TObject);
begin
  Schlien1Click(Sender);
end;

procedure TFormMain.Alleschlieen1Click(Sender: TObject);
begin
  Allesschlieen1Click(Sender);
end;

procedure TFormMain.Speichern2Click(Sender: TObject);
begin
  Speichern1Click(Sender);
end;

procedure TFormMain.Speichernunter2Click(Sender: TObject);
begin
  Speichernunter1Click(Sender);
end;

procedure TFormMain.Drucken2Click(Sender: TObject);
begin
  Drucken1Click(Sender);
end;

procedure TFormMain.Seitenansicht2Click(Sender: TObject);
begin
  Seitenansicht1Click(Sender);
end;

procedure TFormMain.GehezuZeile1Click(Sender: TObject);
begin
  FormJumpToLine.ShowModal;
end;

procedure TFormMain.SetCaretY(line: Integer);
begin
  TSynEdit(pcMain.Pages[tmpPageIndex].FindComponent('synEdit_' + IntToStr(tmpCptNummer))).CaretY := line;
end;

procedure TFormMain.Grobuchstaben1Click(Sender: TObject);
var tmpStr: WideString;
begin
  GetValues;
  tmpStr := TSynEdit(pcMain.Pages[tmpPageIndex].FindComponent('synEdit_' + IntToStr(tmpCptNummer))).SelText;
  TSynEdit(pcMain.Pages[tmpPageIndex].FindComponent('synEdit_' + IntToStr(tmpCptNummer))).SelText := '';

  tmpStr := SynWideUpperCase(tmpStr);

  TSynEdit(pcMain.Pages[tmpPageIndex].FindComponent('synEdit_' + IntToStr(tmpCptNummer))).SelLength := 0;
  TSynEdit(pcMain.Pages[tmpPageIndex].FindComponent('synEdit_' + IntToStr(tmpCptNummer))).SelText := tmpStr;
  GetParameters;
end;

procedure TFormMain.Kleinbuchstaben1Click(Sender: TObject);
var tmpStr: WideString;
begin
  GetValues;
  tmpStr := TSynEdit(pcMain.Pages[tmpPageIndex].FindComponent('synEdit_' + IntToStr(tmpCptNummer))).SelText;
  TSynEdit(pcMain.Pages[tmpPageIndex].FindComponent('synEdit_' + IntToStr(tmpCptNummer))).SelText := '';

  tmpStr := SynWideLowerCase(tmpStr);

  TSynEdit(pcMain.Pages[tmpPageIndex].FindComponent('synEdit_' + IntToStr(tmpCptNummer))).SelLength := 0;
  TSynEdit(pcMain.Pages[tmpPageIndex].FindComponent('synEdit_' + IntToStr(tmpCptNummer))).SelText := tmpStr;
  GetParameters;
end;

procedure TFormMain.GroundKleinbuchstabenvertauschen1Click(
  Sender: TObject);
var tmpStr: WideString;
begin
  GetValues;
  tmpStr := TSynEdit(pcMain.Pages[tmpPageIndex].FindComponent('synEdit_' + IntToStr(tmpCptNummer))).SelText;
  TSynEdit(pcMain.Pages[tmpPageIndex].FindComponent('synEdit_' + IntToStr(tmpCptNummer))).SelText := '';

  tmpStr := gtWideStrings.StringCaseInvert(tmpStr);

  TSynEdit(pcMain.Pages[tmpPageIndex].FindComponent('synEdit_' + IntToStr(tmpCptNummer))).SelLength := 0;
  TSynEdit(pcMain.Pages[tmpPageIndex].FindComponent('synEdit_' + IntToStr(tmpCptNummer))).SelText := tmpStr;
  GetParameters;
end;

procedure TFormMain.AllesschlieenausseraktuellerDatei1Click(
  Sender: TObject);
var i: Integer;
begin
  TTabSheet(pcMain.FindComponent('tab_' + IntToStr(tmpCptNummer))).PageIndex := 0;
  for i := 0 to pcMain.PageCount-2 do
  begin
    DeleteTab(1);
    if mySaveCancel = true then
    begin
      mySaveCancel := false;
      Exit;
    end;
  end;
end;

procedure TFormMain.AllesausseraktuellerDateischlieen1Click(
  Sender: TObject);
begin
  AllesschlieenausseraktuellerDatei1Click(Sender);
end;

procedure TFormMain.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Allesschlieen1Click(Sender);

  if mySaveDontClose = true then Action := caNone
  else Action := caFree;

//Speichern der Fesnterpostion
  myGlobalIni.WriteInteger('editor', 'lwsX', FormMain.Left);
  myGlobalIni.WriteInteger('editor', 'lwsY', FormMain.Top);
  myGlobalIni.WriteInteger('editor', 'lwsWidth', FormMain.Width);
  myGlobalIni.WriteInteger('editor', 'lwsHeight', FormMain.Height);
end;

procedure TFormMain.Suchen2Click(Sender: TObject);
begin
  ShowSearchReplaceDialog(FALSE);
end;

//new
procedure TFormMain.DoSearchReplaceText(AReplace: boolean;
  ABackwards: boolean);
var
  Options: TSynSearchOptions;
begin
  Statusbar.SimpleText := '';
  if AReplace then
    Options := [ssoPrompt, ssoReplace, ssoReplaceAll]
  else
    Options := [];
  if ABackwards then
    Include(Options, ssoBackwards);
  if gbSearchCaseSensitive then
    Include(Options, ssoMatchCase);
  if not fSearchFromCaret then
    Include(Options, ssoEntireScope);
  if gbSearchSelectionOnly then
    Include(Options, ssoSelectedOnly);
  if gbSearchWholeWords then
    Include(Options, ssoWholeWord);
  if gbSearchRegex then
    TSynEdit(pcMain.Pages[tmpPageIndex].FindComponent('synEdit_' + IntToStr(tmpCptNummer))).SearchEngine := SynEditRegexSearch
  else
    TSynEdit(pcMain.Pages[tmpPageIndex].FindComponent('synEdit_' + IntToStr(tmpCptNummer))).SearchEngine := SynEditSearch;

  if TSynEdit(pcMain.Pages[tmpPageIndex].FindComponent('synEdit_' + IntToStr(tmpCptNummer))).SearchReplace(gsSearchText, gsReplaceText, Options) = 0 then
  begin
    MessageBeep(MB_ICONASTERISK);
    MessageDlg(STextNotFound, mtInformation, [mbOk], 0);

    if ssoBackwards in Options then
      TSynEdit(pcMain.Pages[tmpPageIndex].FindComponent('synEdit_' + IntToStr(tmpCptNummer))).BlockEnd := TSynEdit(pcMain.Pages[tmpPageIndex].FindComponent('synEdit_' + IntToStr(tmpCptNummer))).BlockBegin
    else
      TSynEdit(pcMain.Pages[tmpPageIndex].FindComponent('synEdit_' + IntToStr(tmpCptNummer))).BlockBegin := TSynEdit(pcMain.Pages[tmpPageIndex].FindComponent('synEdit_' + IntToStr(tmpCptNummer))).BlockEnd;
    TSynEdit(pcMain.Pages[tmpPageIndex].FindComponent('synEdit_' + IntToStr(tmpCptNummer))).CaretXY := TSynEdit(pcMain.Pages[tmpPageIndex].FindComponent('synEdit_' + IntToStr(tmpCptNummer))).BlockBegin;
  end;

  if FormReplaceConfirm <> nil then
    FormReplaceConfirm.Free;
end;

procedure TFormMain.ShowSearchReplaceDialog(AReplace: boolean);
var
  dlg: TFormSearch;
begin
  Statusbar.SimpleText := '';
  if AReplace then
    dlg := TFormReplace.Create(Self)
  else
    dlg := TFormSearch.Create(Self);
  with dlg do try
    // assign search options
    SearchBackwards := gbSearchBackwards;
    SearchCaseSensitive := gbSearchCaseSensitive;
    SearchFromCursor := gbSearchFromCaret;
    SearchInSelectionOnly := gbSearchSelectionOnly;
    // start with last search text
    SearchText := gsSearchText;
    if gbSearchTextAtCaret then begin
      // if something is selected search for that text
      if TSynEdit(pcMain.Pages[tmpPageIndex].FindComponent('synEdit_' + IntToStr(tmpCptNummer))).SelAvail and (TSynEdit(pcMain.Pages[tmpPageIndex].FindComponent('synEdit_' + IntToStr(tmpCptNummer))).BlockBegin.Line = TSynEdit(pcMain.Pages[tmpPageIndex].FindComponent('synEdit_' + IntToStr(tmpCptNummer))).BlockEnd.Line)
      then
        SearchText := TSynEdit(pcMain.Pages[tmpPageIndex].FindComponent('synEdit_' + IntToStr(tmpCptNummer))).SelText
      else
        SearchText := TSynEdit(pcMain.Pages[tmpPageIndex].FindComponent('synEdit_' + IntToStr(tmpCptNummer))).GetWordAtRowCol(TSynEdit(pcMain.Pages[tmpPageIndex].FindComponent('synEdit_' + IntToStr(tmpCptNummer))).CaretXY);
    end;
    SearchTextHistory := gsSearchTextHistory;
    if AReplace then with dlg as TFormReplace do begin
      ReplaceText := gsReplaceText;
      ReplaceTextHistory := gsReplaceTextHistory;
    end;
    SearchWholeWords := gbSearchWholeWords;
    if ShowModal = mrOK then begin
      gbSearchBackwards := SearchBackwards;
      gbSearchCaseSensitive := SearchCaseSensitive;
      gbSearchFromCaret := SearchFromCursor;
      gbSearchSelectionOnly := SearchInSelectionOnly;
      gbSearchWholeWords := SearchWholeWords;
      gbSearchRegex := SearchRegularExpression;
      gsSearchText := SearchText;
      gsSearchTextHistory := SearchTextHistory;
      if AReplace then with dlg as TFormReplace do begin
        gsReplaceText := ReplaceText;
        gsReplaceTextHistory := ReplaceTextHistory;
      end;
      fSearchFromCaret := gbSearchFromCaret;
      if gsSearchText <> '' then begin
        DoSearchReplaceText(AReplace, gbSearchBackwards);
        fSearchFromCaret := TRUE;
      end;
    end;
  finally
    dlg.Free;
  end;
end;

{ event handler }

procedure TFormMain.actSearchUpdate(Sender: TObject);
begin
  (Sender as TAction).Enabled := gsSearchText <> '';
end;

procedure TFormMain.actSearchReplaceUpdate(Sender: TObject);
begin
  (Sender as TAction).Enabled := (gsSearchText <> '')
    and not TSynEdit(pcMain.Pages[tmpPageIndex].FindComponent('synEdit_' + IntToStr(tmpCptNummer))).ReadOnly;
end;

procedure TFormMain.SynEditorReplaceText(Sender: TObject;
  const ASearch, AReplace: WideString; Line, Column: Integer;
  var Action: TSynReplaceAction);
var
  APos: TPoint;
  EditRect: TRect;
begin
  if ASearch = AReplace then
    Action := raSkip
  else begin
    APos := TSynEdit(pcMain.Pages[tmpPageIndex].FindComponent('synEdit_' + IntToStr(tmpCptNummer))).ClientToScreen(
      TSynEdit(pcMain.Pages[tmpPageIndex].FindComponent('synEdit_' + IntToStr(tmpCptNummer))).RowColumnToPixels(
      TSynEdit(pcMain.Pages[tmpPageIndex].FindComponent('synEdit_' + IntToStr(tmpCptNummer))).BufferToDisplayPos(
        BufferCoord(Column, Line) ) ) );
    EditRect := ClientRect;
    EditRect.TopLeft := ClientToScreen(EditRect.TopLeft);
    EditRect.BottomRight := ClientToScreen(EditRect.BottomRight);

    if FormReplaceConfirm = nil then
      FormReplaceConfirm := TFormReplaceConfirm.Create(Application);
    FormReplaceConfirm.PrepareShow(EditRect, APos.X, APos.Y,
      APos.Y + TSynEdit(pcMain.Pages[tmpPageIndex].FindComponent('synEdit_' + IntToStr(tmpCptNummer))).LineHeight, ASearch);
    case FormReplaceConfirm.ShowModal of
      mrYes: Action := raReplace;
      mrYesToAll: Action := raReplaceAll;
      mrNo: Action := raSkip;
      else Action := raCancel;
    end;
  end;
end;

procedure TFormMain.Weitersuchen1Click(Sender: TObject);
begin
  DoSearchReplaceText(FALSE, FALSE);
end;

procedure TFormMain.Weitersuchenletzes1Click(Sender: TObject);
begin
  DoSearchReplaceText(FALSE, TRUE);
end;

procedure TFormMain.Ersetzen1Click(Sender: TObject);
begin
ShowSearchReplaceDialog(TRUE);
end;

procedure TFormMain.Rckgngig1Click(Sender: TObject);
begin
  TSynEdit(pcMain.Pages[tmpPageIndex].FindComponent('synEdit_' + IntToStr(tmpCptNummer))).Undo;
end;

procedure TFormMain.Wiederherstellen1Click(Sender: TObject);
begin
  TSynEdit(pcMain.Pages[tmpPageIndex].FindComponent('synEdit_' + IntToStr(tmpCptNummer))).Redo;
end;

procedure TFormMain.Optionen1Click(Sender: TObject);
begin
  FormOptions.ShowModal;
end;

procedure TFormMain.TBItem2Click(Sender: TObject);
begin
  Speichern1Click(Sender);
end;

procedure TFormMain.TBItem1Click(Sender: TObject);
begin
  N1Click(Sender);
end;

procedure TFormMain.TBItem3Click(Sender: TObject);
begin
  ffen1Click(Sender);
end;

procedure TFormMain.TBItem4Click(Sender: TObject);
begin
  Speichernunter1Click(Sender);
end;

procedure TFormMain.TBItem5Click(Sender: TObject);
begin
  Drucken1Click(Sender);
end;

procedure TFormMain.TBItem7Click(Sender: TObject);
begin
  Ausschneiden1Click(Sender);
end;

procedure TFormMain.TBItem6Click(Sender: TObject);
begin
  Kopieren1Click(Sender);
end;

procedure TFormMain.TBItem8Click(Sender: TObject);
begin
  Einfgen1Click(Sender);
end;

procedure TFormMain.TBItem9Click(Sender: TObject);
begin
  Rckgngig1Click(Sender);
end;

procedure TFormMain.TBItem10Click(Sender: TObject);
begin
  Wiederherstellen1Click(Sender);
end;

procedure TFormMain.TBItem11Click(Sender: TObject);
begin
  Suchen2Click(Sender);
end;

procedure TFormMain.Zeilennummern1Click(Sender: TObject);
begin
  if Zeilennummern1.Checked = true then Zeilennummern1.Checked := false
  else Zeilennummern1.Checked := true;

  myTabStatusArray[tmpArrayStateNumber].optZeilennummer := Zeilennummern1.Checked;
  TSynEdit(pcMain.Pages[tmpPageIndex].FindComponent('synEdit_' + IntToStr(tmpCptNummer))).Gutter.ShowLineNumbers := myTabStatusArray[tmpArrayStateNumber].optZeilennummer;

  GetParameters;

  //Opt sys
  if optLastConfigSave = true then optEditorZeilennummer := Zeilennummern1.Checked;
end;

procedure TFormMain.Zeilenmarkeranzeigen1Click(Sender: TObject);
begin
  if Zeilenmarkeranzeigen1.Checked = true then Zeilenmarkeranzeigen1.Checked := false
  else Zeilenmarkeranzeigen1.Checked := true;

  myTabStatusArray[tmpArrayStateNumber].optZeilenmarker := Zeilenmarkeranzeigen1.Checked;

  if myTabStatusArray[tmpArrayStateNumber].optZeilenmarker = true then
  begin
    TSynEdit(pcMain.Pages[tmpPageIndex].FindComponent('synEdit_' + IntToStr(tmpCptNummer))).ActiveLineColor := clYellow;
  end
  else
  begin
    TSynEdit(pcMain.Pages[tmpPageIndex].FindComponent('synEdit_' + IntToStr(tmpCptNummer))).ActiveLineColor := clNone;
  end;

  TSynEdit(pcMain.Pages[tmpPageIndex].FindComponent('synEdit_' + IntToStr(tmpCptNummer))).Refresh;

  GetParameters;

  //Opt sys
  if optLastConfigSave = true then optEditorZeilenmarker := Zeilenmarkeranzeigen1.Checked;
end;

procedure TFormMain.aeMainMessage(var Msg: tagMSG; var Handled: Boolean);
var myTmpName: string;
begin
  if (Msg.message = ActivationMessage) then
  begin

     myTmpName := gtMemoryMappedFile.ReadStringFromMMF(MyGUID + 'MMF');
     if myTmpName <> '' then
     begin
       OpenFile(myTmpName);
     end;

     Application.Restore;
     gtForms.ForceForegroundWindow(Handle);
     if optAnwendungInTrayMinimize = true then TrayIcon.ShowApplication;
     Handled := True;
  end;
end;

procedure TFormMain.M11Click(Sender: TObject);
var tmpValue: string;
    tmpPosition: Integer;
begin
  tmpValue := TMenuItem(Sender).Caption;
  tmpPosition := AnsiPos(' ', tmpValue);
  tmpValue := Copy(tmpValue, tmpPosition+1, Length(tmpValue)-tmpPosition);
  OpenFile(tmpValue);
end;                    

procedure TFormMain.Addopen1Click(Sender: TObject);
begin
  OpenDialog.Filter := OpenDialog.Filter + shPascal.DefaultFilter;
end;

procedure TFormMain.Inhalt1Click(Sender: TObject);
begin
 Application.HelpFile := ExtractFilePath(Application.ExeName) + 'gtEdit.chm';
 Application.HelpContext(10);
end;

procedure TFormMain.Setbookmarkonzeile1Click(Sender: TObject);
var cX, cY: Integer;
begin
  cX := TSynEdit(pcMain.Pages[tmpPageIndex].FindComponent('synEdit_' + IntToStr(tmpCptNummer))).CaretX;
  cY := TSynEdit(pcMain.Pages[tmpPageIndex].FindComponent('synEdit_' + IntToStr(tmpCptNummer))).CaretY;
  TSynEdit(pcMain.Pages[tmpPageIndex].FindComponent('synEdit_' + IntToStr(tmpCptNummer))).SetBookMark(0, cX, cY);
end;

procedure TFormMain.SetBookmark(bookmark: Integer);
var cX, cY: Integer;
begin
  cX := TSynEdit(pcMain.Pages[tmpPageIndex].FindComponent('synEdit_' + IntToStr(tmpCptNummer))).CaretX;
  cY := TSynEdit(pcMain.Pages[tmpPageIndex].FindComponent('synEdit_' + IntToStr(tmpCptNummer))).CaretY;
  TSynEdit(pcMain.Pages[tmpPageIndex].FindComponent('synEdit_' + IntToStr(tmpCptNummer))).SetBookMark(bookmark, cX, cY);

  case bookmark of
   0: myTabStatusArray[tmpArrayStateNumber].itlBookmark00 := true;
   1: myTabStatusArray[tmpArrayStateNumber].itlBookmark01 := true;
   2: myTabStatusArray[tmpArrayStateNumber].itlBookmark02 := true;
   3: myTabStatusArray[tmpArrayStateNumber].itlBookmark03 := true;
   4: myTabStatusArray[tmpArrayStateNumber].itlBookmark04 := true;
   5: myTabStatusArray[tmpArrayStateNumber].itlBookmark05 := true;
   6: myTabStatusArray[tmpArrayStateNumber].itlBookmark06 := true;
   7: myTabStatusArray[tmpArrayStateNumber].itlBookmark07 := true;
   8: myTabStatusArray[tmpArrayStateNumber].itlBookmark08 := true;
   9: myTabStatusArray[tmpArrayStateNumber].itlBookmark09 := true;
  end;
end;

procedure TFormMain.Lesezeichen01Click(Sender: TObject);
begin
  TSynEdit(pcMain.Pages[tmpPageIndex].FindComponent('synEdit_' + IntToStr(tmpCptNummer))).GotoBookMark(0);
end;

procedure TFormMain.Lesezeichen11Click(Sender: TObject);
begin
TSynEdit(pcMain.Pages[tmpPageIndex].FindComponent('synEdit_' + IntToStr(tmpCptNummer))).GotoBookMark(1);
end;

procedure TFormMain.Lesezeichen21Click(Sender: TObject);
begin
TSynEdit(pcMain.Pages[tmpPageIndex].FindComponent('synEdit_' + IntToStr(tmpCptNummer))).GotoBookMark(2);
end;

procedure TFormMain.Lesezeichen31Click(Sender: TObject);
begin
TSynEdit(pcMain.Pages[tmpPageIndex].FindComponent('synEdit_' + IntToStr(tmpCptNummer))).GotoBookMark(3);
end;

procedure TFormMain.Lesezeichen41Click(Sender: TObject);
begin
TSynEdit(pcMain.Pages[tmpPageIndex].FindComponent('synEdit_' + IntToStr(tmpCptNummer))).GotoBookMark(4);
end;

procedure TFormMain.Lesezeichen51Click(Sender: TObject);
begin
TSynEdit(pcMain.Pages[tmpPageIndex].FindComponent('synEdit_' + IntToStr(tmpCptNummer))).GotoBookMark(5);
end;

procedure TFormMain.Lesezeichen61Click(Sender: TObject);
begin
TSynEdit(pcMain.Pages[tmpPageIndex].FindComponent('synEdit_' + IntToStr(tmpCptNummer))).GotoBookMark(6);
end;

procedure TFormMain.Lesezeichen71Click(Sender: TObject);
begin
TSynEdit(pcMain.Pages[tmpPageIndex].FindComponent('synEdit_' + IntToStr(tmpCptNummer))).GotoBookMark(7);
end;

procedure TFormMain.Lesezeichen81Click(Sender: TObject);
begin
TSynEdit(pcMain.Pages[tmpPageIndex].FindComponent('synEdit_' + IntToStr(tmpCptNummer))).GotoBookMark(8);
end;

procedure TFormMain.Lesezeichen91Click(Sender: TObject);
begin
TSynEdit(pcMain.Pages[tmpPageIndex].FindComponent('synEdit_' + IntToStr(tmpCptNummer))).GotoBookMark(9);
end;

procedure TFormMain.Lesezeichen05Click(Sender: TObject);
begin
  SetBookmark(0);
end;

procedure TFormMain.Lesezeichen15Click(Sender: TObject);
begin
SetBookmark(1);
end;

procedure TFormMain.Lesezeichen25Click(Sender: TObject);
begin
SetBookmark(2);
end;

procedure TFormMain.Lesezeichen35Click(Sender: TObject);
begin
SetBookmark(3);
end;

procedure TFormMain.Lesezeichen45Click(Sender: TObject);
begin
SetBookmark(4);
end;

procedure TFormMain.Lesezeichen55Click(Sender: TObject);
begin
SetBookmark(5);
end;

procedure TFormMain.Lesezeichen65Click(Sender: TObject);
begin
SetBookmark(6);
end;

procedure TFormMain.Lesezeichen75Click(Sender: TObject);
begin
SetBookmark(7);
end;

procedure TFormMain.Lesezeichen85Click(Sender: TObject);
begin
SetBookmark(8);
end;

procedure TFormMain.Lesezeichen95Click(Sender: TObject);
begin
SetBookmark(9);
end;

procedure TFormMain.Lesezeichen02Click(Sender: TObject);
begin
  Lesezeichen01Click(Sender);
end;

procedure TFormMain.Lesezeichen12Click(Sender: TObject);
begin
Lesezeichen11Click(Sender);
end;

procedure TFormMain.Lesezeichen22Click(Sender: TObject);
begin
Lesezeichen21Click(Sender);
end;

procedure TFormMain.Lesezeichen32Click(Sender: TObject);
begin
Lesezeichen31Click(Sender);
end;

procedure TFormMain.Lesezeichen42Click(Sender: TObject);
begin
Lesezeichen41Click(Sender);
end;

procedure TFormMain.Lesezeichen52Click(Sender: TObject);
begin
Lesezeichen51Click(Sender);
end;

procedure TFormMain.Lesezeichen62Click(Sender: TObject);
begin
Lesezeichen61Click(Sender);
end;

procedure TFormMain.Lesezeichen72Click(Sender: TObject);
begin
Lesezeichen71Click(Sender);
end;

procedure TFormMain.Lesezeichen82Click(Sender: TObject);
begin
Lesezeichen81Click(Sender);
end;

procedure TFormMain.Lesezeichen92Click(Sender: TObject);
begin
Lesezeichen91Click(Sender);
end;

procedure TFormMain.Lesezeichen04Click(Sender: TObject);
begin
  Lesezeichen05Click(Sender);
end;

procedure TFormMain.Lesezeichen14Click(Sender: TObject);
begin
Lesezeichen15Click(Sender);
end;

procedure TFormMain.Lesezeichen24Click(Sender: TObject);
begin
Lesezeichen25Click(Sender);
end;

procedure TFormMain.Lesezeichen34Click(Sender: TObject);
begin
Lesezeichen35Click(Sender);
end;

procedure TFormMain.Lesezeichen44Click(Sender: TObject);
begin
Lesezeichen45Click(Sender);
end;

procedure TFormMain.Lesezeichen54Click(Sender: TObject);
begin
Lesezeichen55Click(Sender);
end;

procedure TFormMain.Lesezeichen64Click(Sender: TObject);
begin
Lesezeichen65Click(Sender);
end;

procedure TFormMain.Lesezeichen74Click(Sender: TObject);
begin
Lesezeichen75Click(Sender);
end;

procedure TFormMain.Lesezeichen84Click(Sender: TObject);
begin
Lesezeichen85Click(Sender);
end;

procedure TFormMain.Lesezeichen94Click(Sender: TObject);
begin
Lesezeichen95Click(Sender);
end;

procedure TFormMain.WordWrap1Click(Sender: TObject);
begin
  if WordWrap1.Checked = true then WordWrap1.Checked := false
  else WordWrap1.Checked := true;

  myTabStatusArray[tmpArrayStateNumber].optWordWrap := WordWrap1.Checked;
  TSynEdit(pcMain.Pages[tmpPageIndex].FindComponent('synEdit_' + IntToStr(tmpCptNummer))).WordWrap := myTabStatusArray[tmpArrayStateNumber].optWordWrap;

  GetParameters;

  //Opt sys
  if optLastConfigSave = true then optEditorWordWrap := WordWrap1.Checked;
end;

procedure TFormMain.SetFont(newFont: TFont);
var i: Integer;
    mySplitList: TStringList;
    myCptNummer: Integer;
begin
  for i := 0 to pcMain.PageCount-1 do
  begin
    mySplitList := TStringList.Create;
    mySplitList := gtStrings.Split(pcMain.Pages[i].Name, '_');
    myCptNummer := StrToInt(mySplitList[1]);
    mySplitList.Free;

    TSynEdit(pcMain.Pages[i].FindComponent('synEdit_' + IntToStr(myCptNummer))).Font := optEditorFont;
  end;
end;

procedure TFormMain.Schriftarteinstellen1Click(Sender: TObject);
begin
  FontDialog.Font := optEditorFont;
  if FontDialog.Execute then
  begin
    optEditorFont := FontDialog.Font;
    SetFont(optEditorFont);
  end;
end;

procedure TFormMain.Zeilelinkstrimmen1Click(Sender: TObject);
var myZeile: WideString;
    myMomZeile: Integer;
begin
 myMomZeile := TSynEdit(pcMain.Pages[tmpPageIndex].FindComponent('synEdit_' + IntToStr(tmpCptNummer))).CaretY;
 myZeile := TSynEdit(pcMain.Pages[tmpPageIndex].FindComponent('synEdit_' + IntToStr(tmpCptNummer))).Lines[myMomZeile-1];
 myZeile := TrimLeft(myZeile);
 TSynEdit(pcMain.Pages[tmpPageIndex].FindComponent('synEdit_' + IntToStr(tmpCptNummer))).Lines[myMomZeile-1] := myZeile;
end;

procedure TFormMain.Zeilerechtstrimmen1Click(Sender: TObject);
var myZeile: WideString;
    myMomZeile: Integer;
begin
 myMomZeile := TSynEdit(pcMain.Pages[tmpPageIndex].FindComponent('synEdit_' + IntToStr(tmpCptNummer))).CaretY;
 myZeile := TSynEdit(pcMain.Pages[tmpPageIndex].FindComponent('synEdit_' + IntToStr(tmpCptNummer))).Lines[myMomZeile-1];
 myZeile := TrimRight(myZeile);
 TSynEdit(pcMain.Pages[tmpPageIndex].FindComponent('synEdit_' + IntToStr(tmpCptNummer))).Lines[myMomZeile-1] := myZeile;
end;

procedure TFormMain.Zeiletrimmen1Click(Sender: TObject);
var myZeile: WideString;
    myMomZeile: Integer;
begin
 myMomZeile := TSynEdit(pcMain.Pages[tmpPageIndex].FindComponent('synEdit_' + IntToStr(tmpCptNummer))).CaretY;
 myZeile := TSynEdit(pcMain.Pages[tmpPageIndex].FindComponent('synEdit_' + IntToStr(tmpCptNummer))).Lines[myMomZeile-1];
 myZeile := Trim(myZeile);
 TSynEdit(pcMain.Pages[tmpPageIndex].FindComponent('synEdit_' + IntToStr(tmpCptNummer))).Lines[myMomZeile-1] := myZeile;
end;

procedure TFormMain.WhitespacesanZeilenendenentfernen1Click(
  Sender: TObject);
var myZeile: WideString;
    i: Integer;
begin
 for i := 1 to TSynEdit(pcMain.Pages[tmpPageIndex].FindComponent('synEdit_' + IntToStr(tmpCptNummer))).Lines.Count do
 begin
   myZeile := TSynEdit(pcMain.Pages[tmpPageIndex].FindComponent('synEdit_' + IntToStr(tmpCptNummer))).Lines[i-1];
   myZeile := TrimRight(myZeile);
   TSynEdit(pcMain.Pages[tmpPageIndex].FindComponent('synEdit_' + IntToStr(tmpCptNummer))).Lines[i-1] := myZeile;
 end;
end;

procedure TFormMain.Kapitale1Click(Sender: TObject);
var tmpStr: WideString;
begin
  GetValues;
  tmpStr := TSynEdit(pcMain.Pages[tmpPageIndex].FindComponent('synEdit_' + IntToStr(tmpCptNummer))).SelText;
  TSynEdit(pcMain.Pages[tmpPageIndex].FindComponent('synEdit_' + IntToStr(tmpCptNummer))).SelText := '';

  tmpStr := gtWideStrings.Kapitale(tmpStr);

  TSynEdit(pcMain.Pages[tmpPageIndex].FindComponent('synEdit_' + IntToStr(tmpCptNummer))).SelLength := 0;
  TSynEdit(pcMain.Pages[tmpPageIndex].FindComponent('synEdit_' + IntToStr(tmpCptNummer))).SelText := tmpStr;
  GetParameters;
end;

procedure TFormMain.Wrterzhlen1Click(Sender: TObject);
var myWords: LongWord;
begin
  myWords := gtWideStrings.WordCount(TSynEdit(pcMain.Pages[tmpPageIndex].FindComponent('synEdit_' + IntToStr(tmpCptNummer))).Text);
  MessageDlg('Es wurden ' + IntToStr(myWords) + ' Wörter gezählt.', mtInformation, [mbOk], 0);
end;

procedure TFormMain.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if pcMain.PageCount > 1 then
  begin
    if (ssCtrl in Shift) and (ssShift in Shift) and (Key = VK_TAB) then //(Key = Ord('L')) then
    begin
     if pcMain.ActivePageIndex > 0 then pcMain.ActivePageIndex := pcMain.ActivePageIndex - 1
     else pcMain.ActivePageIndex := pcMain.PageCount-1;
    end
    else if (ssCtrl in Shift) and (Key = VK_TAB) then //(Key = Ord('L')) then
    begin
      if pcMain.ActivePageIndex < pcMain.PageCount-1 then pcMain.ActivePageIndex := pcMain.ActivePageIndex + 1
      else pcMain.ActivePageIndex := 0;
    end
  end;
end;

procedure TFormMain.T1Click(Sender: TObject);
var tmpStr: WideString;
begin
 tmpStr := TSynEdit(pcMain.Pages[tmpPageIndex].FindComponent('synEdit_' + IntToStr(tmpCptNummer))).Text;
 tmpStr := gtWideStrings.TabsToSpaces(tmpStr, optEditorTabSpaces);
 TSynEdit(pcMain.Pages[tmpPageIndex].FindComponent('synEdit_' + IntToStr(tmpCptNummer))).Text := tmpStr;
end;

procedure TFormMain.LeerzeicheninTabulatorenumwandelnAlle1Click(
  Sender: TObject);
var tmpStr: WideString;
begin
 tmpStr := TSynEdit(pcMain.Pages[tmpPageIndex].FindComponent('synEdit_' + IntToStr(tmpCptNummer))).Text;
 tmpStr := gtWideStrings.SpacesToTab(tmpStr, optEditorTabSpaces);
 TSynEdit(pcMain.Pages[tmpPageIndex].FindComponent('synEdit_' + IntToStr(tmpCptNummer))).Text := tmpStr;
end;

procedure TFormMain.GetValuesOfPageNumber(pagenumber:integer; var vvPageIndex, vvArrayNumber, vvCptNumber: Integer);
var mySplitList: TStringList;
    myTmpCptNummer: Integer;
    myTmpArrayStateNumber: Integer;
    myTmpPageIndex:Integer;
begin
    mySplitList := TStringList.Create;
    mySplitList := gtStrings.Split(pcMain.Pages[pagenumber].Name, '_');
    myTmpCptNummer := StrToInt(mySplitList[1]);
    mySplitList.Free;

    myTmpPageIndex := TTabSheet(pcMain.FindComponent('tab_' + IntToStr(myTmpCptNummer))).PageIndex;
    myTmpArrayStateNumber := TTabSheet(pcMain.FindComponent('tab_' + IntToStr(myTmpCptNummer))).Tag;

    vvPageIndex := myTmpPageIndex;
    vvArrayNumber := myTmpArrayStateNumber;
    vvCptNumber := myTmpCptNummer;
end;

procedure TFormMain.Allesspeichern1Click(Sender: TObject);
var i: Integer;
    myTmpFileName: string;
    myArrayNumber, myPageIndex, myCptNumber: Integer;
begin
  for i := 0 to pcMain.PageCount-1 do
  begin

    GetValuesOfPageNumber(i, myPageIndex, myArrayNumber, myCptNumber);
    myTmpFileName := myTabStatusArray[myArrayNumber].fileName;

    if myTabStatusArray[myArrayNumber].contentChanged = true then
    begin

    if (myTmpFileName <> '') then
    begin
      TSynEdit(pcMain.Pages[myPageIndex].FindComponent('synEdit_' + IntToStr(myCptNumber))).Lines.SaveToFile(myTmpFileName);
      TTabSheet(pcMain.FindComponent('tab_' + IntToStr(myCptNumber))).Caption := ExtractFileName(myTmpFileName);
      myTabStatusArray[myArrayNumber].contentChanged := false;
    end
    else
    begin
      SaveDialog.FileName := myTabStatusArray[myArrayNumber].captionOfTab;
      if SaveDialog.Execute then
      begin
        TSynEdit(pcMain.Pages[myPageIndex].FindComponent('synEdit_' + IntToStr(myCptNumber))).Lines.SaveToFile(SaveDialog.FileName);
        TTabSheet(pcMain.FindComponent('tab_' + IntToStr(myCptNumber))).Caption := ExtractFileName(SaveDialog.FileName);
        myTabStatusArray[myArrayNumber].fileName := SaveDialog.FileName;
        myTabStatusArray[myArrayNumber].captionOfTab := ExtractFileName(SaveDialog.FileName);
        myTabStatusArray[myArrayNumber].contentChanged := false;
      end;
    end;
    end;
  end;
end;

procedure TFormMain.Allesspeichern2Click(Sender: TObject);
begin
  Allesspeichern1Click(Sender);
end;

procedure TFormMain.X1Click(Sender: TObject);
begin
  if pcMain.PageCount > 0 then Schlien1Click(Sender);
end;

procedure TFormMain.WMDROPFILES (var Msg: TMessage);
var i, anzahl, size: integer;
  Dateiname: PChar;
begin
  inherited;
  anzahl := DragQueryFile(Msg.WParam, $FFFFFFFF, Dateiname, 255);
  for i := 0 to (anzahl - 1) do
  begin
    size := DragQueryFile(Msg.WParam, i , nil, 0) + 1;
    Dateiname:= StrAlloc(size);
    DragQueryFile(Msg.WParam,i , Dateiname, size);
    OpenFile(StrPas(Dateiname));
    StrDispose(Dateiname);
  end;
  DragFinish(Msg.WParam);
end;


//Führende Leerzeichen in Tabs umwandeln
//Unicode konform (UK)
procedure TFormMain.LeerzeicheninTabulatorenumwandelnfhrende1Click(
  Sender: TObject);
var myList: TWideStringList;
begin
 myList := TWideStringList.Create;
 myList.AddStrings(TSynEdit(pcMain.Pages[tmpPageIndex].FindComponent('synEdit_' + IntToStr(tmpCptNummer))).Lines);
 gtWideStrings.LeaderSpacesToTab(optEditorTabSpaces, myList);
 TSynEdit(pcMain.Pages[tmpPageIndex].FindComponent('synEdit_' + IntToStr(tmpCptNummer))).Lines.Clear;
 TSynEdit(pcMain.Pages[tmpPageIndex].FindComponent('synEdit_' + IntToStr(tmpCptNummer))).Lines.AddStrings(myList);
 myList.Free;
end;

procedure TFormMain.ANSI1Click(Sender: TObject);
begin
  GetValues;

  if myTabStatusArray[tmpArrayStateNumber].charSet = ANSI then Exit;

  myTabStatusArray[tmpArrayStateNumber].charSet := ANSI;
  TSynEdit(pcMain.Pages[tmpPageIndex].FindComponent('synEdit_' + IntToStr(tmpCptNummer))).Lines.SaveUnicode := false;

  GetParameters;
end;

procedure TFormMain.Unicode1Click(Sender: TObject);
begin
  GetValues;

  if myTabStatusArray[tmpArrayStateNumber].charSet = Unicode then Exit;

  myTabStatusArray[tmpArrayStateNumber].charSet := Unicode;
  TSynEdit(pcMain.Pages[tmpPageIndex].FindComponent('synEdit_' + IntToStr(tmpCptNummer))).Lines.SaveUnicode := true;

  GetParameters;
end;

end.
