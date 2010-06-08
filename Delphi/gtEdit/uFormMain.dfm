object FormMain: TFormMain
  Left = 258
  Top = 116
  Width = 866
  Height = 496
  Caption = 'gtEdit'
  Color = clBtnFace
  DragMode = dmAutomatic
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  Menu = MainMenu
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnKeyDown = FormKeyDown
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object pcMain: TPageControl
    Left = 0
    Top = 28
    Width = 858
    Height = 403
    Align = alClient
    PopupMenu = pmenuTabs
    TabOrder = 0
    OnChange = pcMainChange
  end
  object StatusBar: TStatusBar
    Left = 0
    Top = 431
    Width = 858
    Height = 19
    Panels = <
      item
        Width = 80
      end
      item
        Text = 'NUM'
        Width = 50
      end
      item
        Text = 'EINFG'
        Width = 50
      end
      item
        Text = 'CAPS'
        Width = 50
      end
      item
        Text = 'SCROLL'
        Width = 50
      end>
  end
  object TBDock1: TTBDock
    Left = 0
    Top = 0
    Width = 858
    Height = 28
    object TBToolbar1: TTBToolbar
      Left = 0
      Top = 0
      Caption = 'Datei'
      DockPos = 0
      Images = TBImageList1
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
      object TBItem1: TTBItem
        Caption = 'Neu'
        ImageIndex = 1
        OnClick = TBItem1Click
      end
      object TBSeparatorItem1: TTBSeparatorItem
      end
      object TBItem3: TTBItem
        Caption = #214'ffnen'
        ImageIndex = 2
        OnClick = TBItem3Click
      end
      object TBSeparatorItem2: TTBSeparatorItem
      end
      object TBItem2: TTBItem
        Caption = 'Speichern'
        ImageIndex = 0
        OnClick = TBItem2Click
      end
      object TBItem4: TTBItem
        Caption = 'Speichern unter...'
        ImageIndex = 3
        OnClick = TBItem4Click
      end
      object TBSeparatorItem3: TTBSeparatorItem
      end
      object TBItem5: TTBItem
        Caption = 'Drucken'
        ImageIndex = 4
        OnClick = TBItem5Click
      end
    end
    object TBToolbar2: TTBToolbar
      Left = 153
      Top = 0
      Caption = 'Bearbeiten'
      DockPos = 144
      Images = TBImageList2
      ParentShowHint = False
      ShowHint = True
      TabOrder = 1
      object TBItem9: TTBItem
        Caption = 'R'#252'ckg'#228'ngig'
        ImageIndex = 4
        OnClick = TBItem9Click
      end
      object TBItem10: TTBItem
        Caption = 'Wiederherstellen'
        ImageIndex = 3
        OnClick = TBItem10Click
      end
      object TBSeparatorItem4: TTBSeparatorItem
      end
      object TBItem7: TTBItem
        Caption = 'Ausschneiden'
        ImageIndex = 1
        OnClick = TBItem7Click
      end
      object TBItem6: TTBItem
        Caption = 'Kopieren'
        ImageIndex = 0
        OnClick = TBItem6Click
      end
      object TBItem8: TTBItem
        Caption = 'Einf'#252'gen'
        ImageIndex = 2
        OnClick = TBItem8Click
      end
    end
    object TBToolbar3: TTBToolbar
      Left = 284
      Top = 0
      Caption = 'Suchen'
      DockPos = 280
      Images = TBImageList3
      ParentShowHint = False
      ShowHint = True
      TabOrder = 2
      object TBItem11: TTBItem
        Caption = 'Suchen'
        ImageIndex = 0
        OnClick = TBItem11Click
      end
    end
  end
  object MainMenu: TMainMenu
    Left = 8
    Top = 272
    object datei1: TMenuItem
      Caption = '&Datei'
      object N1: TMenuItem
        Caption = '&Neu'
        ShortCut = 16462
        OnClick = N1Click
      end
      object ffen1: TMenuItem
        Caption = #214'&ffen...'
        ShortCut = 16463
        OnClick = ffen1Click
      end
      object Schlien1: TMenuItem
        Caption = 'Schlie'#223'en'
        ShortCut = 16499
        OnClick = Schlien1Click
      end
      object Allesschlieen1: TMenuItem
        Caption = 'Alles schlie'#223'en'
        OnClick = Allesschlieen1Click
      end
      object AllesschlieenausseraktuellerDatei1: TMenuItem
        Caption = 'Alles ausser aktueller Datei schlie'#223'en'
        OnClick = AllesschlieenausseraktuellerDatei1Click
      end
      object N2: TMenuItem
        Caption = '-'
      end
      object Speichern1: TMenuItem
        Caption = 'Speichern'
        ShortCut = 16467
        OnClick = Speichern1Click
      end
      object Speichernunter1: TMenuItem
        Caption = 'Speichern unter...'
        ShortCut = 123
        OnClick = Speichernunter1Click
      end
      object Allesspeichern1: TMenuItem
        Caption = 'Alles speichern'
        OnClick = Allesspeichern1Click
      end
      object N27: TMenuItem
        Caption = '-'
      end
      object Zeichensatz1: TMenuItem
        Caption = 'Zeichensatz'
        object ANSI1: TMenuItem
          Caption = 'ANSI'
          OnClick = ANSI1Click
        end
        object Unicode1: TMenuItem
          Caption = 'Unicode'
          OnClick = Unicode1Click
        end
      end
      object N3: TMenuItem
        Caption = '-'
      end
      object Drucken1: TMenuItem
        Caption = 'Drucken...'
        ShortCut = 16464
        OnClick = Drucken1Click
      end
      object Seitenansicht1: TMenuItem
        Caption = 'Seitenansicht...'
        OnClick = Seitenansicht1Click
      end
      object Druckereinrichten1: TMenuItem
        Caption = 'Drucker einrichten...'
        OnClick = Druckereinrichten1Click
      end
      object N4: TMenuItem
        Caption = '-'
      end
      object Letzte1: TMenuItem
        Caption = 'Letzte Dateien'
        object M11: TMenuItem
          Caption = 'M1'
          OnClick = M11Click
        end
        object M21: TMenuItem
          Caption = 'M2'
          OnClick = M11Click
        end
        object M31: TMenuItem
          Caption = 'M3'
          OnClick = M11Click
        end
        object M41: TMenuItem
          Caption = 'M4'
          OnClick = M11Click
        end
        object M51: TMenuItem
          Caption = 'M5'
          OnClick = M11Click
        end
      end
      object N17: TMenuItem
        Caption = '-'
      end
      object Beenden1: TMenuItem
        Caption = 'B&eenden'
        OnClick = Beenden1Click
      end
    end
    object Bearbeiten1: TMenuItem
      Caption = '&Bearbeiten'
      object Rckgngig1: TMenuItem
        Caption = '&R'#252'ckg'#228'ngig'
        ShortCut = 16474
        OnClick = Rckgngig1Click
      end
      object Wiederherstellen1: TMenuItem
        Caption = '&Wiederherstellen'
        ShortCut = 16473
        OnClick = Wiederherstellen1Click
      end
      object N5: TMenuItem
        Caption = '-'
      end
      object Ausschneiden1: TMenuItem
        Caption = 'Ausschneiden'
        ShortCut = 16472
        OnClick = Ausschneiden1Click
      end
      object Kopieren1: TMenuItem
        Caption = 'Kopieren'
        ShortCut = 16451
        OnClick = Kopieren1Click
      end
      object Einfgen1: TMenuItem
        Caption = 'Einf'#252'gen'
        ShortCut = 16470
        OnClick = Einfgen1Click
      end
      object N6: TMenuItem
        Caption = '-'
      end
      object Allesmarkieren1: TMenuItem
        Caption = 'Alles markieren'
        ShortCut = 16449
        OnClick = Allesmarkieren1Click
      end
    end
    object Suchen1: TMenuItem
      Caption = '&Suchen'
      object Suchen2: TMenuItem
        Caption = '&Suchen...'
        ShortCut = 16454
        OnClick = Suchen2Click
      end
      object Weitersuchen1: TMenuItem
        Caption = '&Weitersuchen'
        ShortCut = 114
        OnClick = Weitersuchen1Click
      end
      object Weitersuchenletzes1: TMenuItem
        Caption = 'Vorher suchen'
        ShortCut = 16498
        OnClick = Weitersuchenletzes1Click
      end
      object Ersetzen1: TMenuItem
        Caption = '&Ersetzen...'
        ShortCut = 16466
        OnClick = Ersetzen1Click
      end
      object N13: TMenuItem
        Caption = '-'
      end
      object GehezuZeile1: TMenuItem
        Caption = 'Gehe zu Zeile...'
        ShortCut = 16455
        OnClick = GehezuZeile1Click
      end
    end
    object Ansicht1: TMenuItem
      Caption = '&Ansicht'
      object Syntaxhervorhebung1: TMenuItem
        Caption = '&Syntaxhervorhebung'
        object keineHervorhebung1: TMenuItem
          Caption = 'keine Hervorhebung'
          OnClick = keineHervorhebung1Click
        end
        object N8: TMenuItem
          Caption = '-'
        end
        object Assembler1: TMenuItem
          Caption = 'Assembler'
          OnClick = Assembler1Click
        end
        object awk1: TMenuItem
          Caption = 'awk'
          OnClick = awk1Click
        end
        object BatchSkriptDOS1: TMenuItem
          Caption = 'Batch Skript DOS'
          OnClick = BatchSkriptDOS1Click
        end
        object CC1: TMenuItem
          Caption = 'C/C++'
          OnClick = CC1Click
        end
        object C1: TMenuItem
          Caption = 'C#'
          OnClick = C1Click
        end
        object Cobol1: TMenuItem
          Caption = 'Cobol'
          OnClick = Cobol1Click
        end
        object CSS1: TMenuItem
          Caption = 'CSS'
          OnClick = CSS1Click
        end
        object Eiffel1: TMenuItem
          Caption = 'Eiffel'
          OnClick = Eiffel1Click
        end
        object Fortran1: TMenuItem
          Caption = 'Fortran'
          OnClick = Fortran1Click
        end
        object FoxPr1: TMenuItem
          Caption = 'FoxPro'
          OnClick = FoxPr1Click
        end
        object HTML1: TMenuItem
          Caption = 'HTML'
          OnClick = HTML1Click
        end
        object Pascal1: TMenuItem
          Caption = 'Pascal'
          OnClick = Pascal1Click
        end
        object Perl1: TMenuItem
          Caption = 'Perl'
          OnClick = Perl1Click
        end
        object PHP1: TMenuItem
          Caption = 'PHP'
          OnClick = PHP1Click
        end
        object Python1: TMenuItem
          Caption = 'Python'
          OnClick = Python1Click
        end
        object Java1: TMenuItem
          Caption = 'Java'
          OnClick = Java1Click
        end
        object Javascript1: TMenuItem
          Caption = 'Javascript'
          OnClick = Javascript1Click
        end
        object Ruby1: TMenuItem
          Caption = 'Ruby'
          OnClick = Ruby1Click
        end
        object SQL1: TMenuItem
          Caption = 'SQL'
          OnClick = SQL1Click
        end
        object tcl1: TMenuItem
          Caption = 'Tcl'
          OnClick = tcl1Click
        end
        object eX1: TMenuItem
          Caption = 'TeX'
          OnClick = eX1Click
        end
        object VisualBasic1: TMenuItem
          Caption = 'Visual Basic'
          OnClick = VisualBasic1Click
        end
        object VisualBasicScript1: TMenuItem
          Caption = 'Visual Basic Script'
          OnClick = VisualBasicScript1Click
        end
        object UNIXShellSkript1: TMenuItem
          Caption = 'UNIX Shell Skript'
          OnClick = UNIXShellSkript1Click
        end
        object VRML971: TMenuItem
          Caption = 'VRML 97'
          OnClick = VRML971Click
        end
        object XML1: TMenuItem
          Caption = 'XML'
          OnClick = XML1Click
        end
      end
      object N9: TMenuItem
        Caption = '-'
      end
      object Schriftvergrern1: TMenuItem
        Caption = 'Schrift vergr'#246#223'ern'
        ShortCut = 16571
        OnClick = Schriftvergrern1Click
      end
      object Schriftverkleinern1: TMenuItem
        Caption = 'Schrift verkleinern'
        ShortCut = 16575
        OnClick = Schriftverkleinern1Click
      end
      object N22: TMenuItem
        Caption = '-'
      end
      object Schriftarteinstellen1: TMenuItem
        Caption = 'Schriftart einstellen...'
        OnClick = Schriftarteinstellen1Click
      end
      object N10: TMenuItem
        Caption = '-'
      end
      object SichtbareZeichenEinAus1: TMenuItem
        Caption = 'Nicht druckbare Zeichen Ein/Aus'
        ShortCut = 16471
        OnClick = SichtbareZeichenEinAus1Click
      end
      object N16: TMenuItem
        Caption = '-'
      end
      object Zeilennummern1: TMenuItem
        Caption = 'Zeilennummern anzeigen'
        ShortCut = 16458
        OnClick = Zeilennummern1Click
      end
      object Zeilenmarkeranzeigen1: TMenuItem
        Caption = 'Zeilenmarker anzeigen'
        ShortCut = 16461
        OnClick = Zeilenmarkeranzeigen1Click
      end
      object N21: TMenuItem
        Caption = '-'
      end
      object WordWrap1: TMenuItem
        Caption = 'WordWrap'
        ShortCut = 16450
        OnClick = WordWrap1Click
      end
    end
    object Format1: TMenuItem
      Caption = '&Format'
      object Grobuchstaben1: TMenuItem
        Caption = 'Gro'#223'buchstaben'
        ShortCut = 32884
        OnClick = Grobuchstaben1Click
      end
      object Kleinbuchstaben1: TMenuItem
        Caption = 'Kleinbuchstaben'
        ShortCut = 16500
        OnClick = Kleinbuchstaben1Click
      end
      object Kapitale1: TMenuItem
        Caption = 'Kapitale'
        ShortCut = 116
        OnClick = Kapitale1Click
      end
      object GroundKleinbuchstabenvertauschen1: TMenuItem
        Caption = 'Gro'#223'-/Kleinschreibung vertauschen'
        ShortCut = 8308
        OnClick = GroundKleinbuchstabenvertauschen1Click
      end
      object N23: TMenuItem
        Caption = '-'
      end
      object T1: TMenuItem
        Caption = 'Tabulatoren in Leerzeichen umwandeln'
        OnClick = T1Click
      end
      object LeerzeicheninTabulatorenumwandelnAlle1: TMenuItem
        Caption = 'Leerzeichen in Tabulatoren umwandeln (Alle)'
        OnClick = LeerzeicheninTabulatorenumwandelnAlle1Click
      end
      object LeerzeicheninTabulatorenumwandelnfhrende1: TMenuItem
        Caption = 'Leerzeichen in Tabulatoren umwandeln (F'#252'hrende)'
        OnClick = LeerzeicheninTabulatorenumwandelnfhrende1Click
      end
      object N26: TMenuItem
        Caption = '-'
      end
      object Zeiletrimmen1: TMenuItem
        Caption = 'Zeile trimmen'
        OnClick = Zeiletrimmen1Click
      end
      object Zeilelinkstrimmen1: TMenuItem
        Caption = 'Zeile links trimmen'
        OnClick = Zeilelinkstrimmen1Click
      end
      object Zeilerechtstrimmen1: TMenuItem
        Caption = 'Zeile rechts trimmen'
        OnClick = Zeilerechtstrimmen1Click
      end
      object N24: TMenuItem
        Caption = '-'
      end
      object WhitespacesanZeilenendenentfernen1: TMenuItem
        Caption = 'Whitespaces an Zeilenenden entfernen'
        OnClick = WhitespacesanZeilenendenentfernen1Click
      end
    end
    object Extras1: TMenuItem
      Caption = '&Extras'
      object Lesezeichensetzen2: TMenuItem
        Caption = 'Lesezeichen umschalten'
        object Lesezeichen05: TMenuItem
          Caption = 'Lesezeichen 0'
          OnClick = Lesezeichen05Click
        end
        object Lesezeichen15: TMenuItem
          Caption = 'Lesezeichen 1'
          OnClick = Lesezeichen15Click
        end
        object Lesezeichen25: TMenuItem
          Caption = 'Lesezeichen 2'
          OnClick = Lesezeichen25Click
        end
        object Lesezeichen35: TMenuItem
          Caption = 'Lesezeichen 3'
          OnClick = Lesezeichen35Click
        end
        object Lesezeichen45: TMenuItem
          Caption = 'Lesezeichen 4'
          OnClick = Lesezeichen45Click
        end
        object Lesezeichen55: TMenuItem
          Caption = 'Lesezeichen 5'
          OnClick = Lesezeichen55Click
        end
        object Lesezeichen65: TMenuItem
          Caption = 'Lesezeichen 6'
          OnClick = Lesezeichen65Click
        end
        object Lesezeichen75: TMenuItem
          Caption = 'Lesezeichen 7'
          OnClick = Lesezeichen75Click
        end
        object Lesezeichen85: TMenuItem
          Caption = 'Lesezeichen 8'
          OnClick = Lesezeichen85Click
        end
        object Lesezeichen95: TMenuItem
          Caption = 'Lesezeichen 9'
          OnClick = Lesezeichen95Click
        end
      end
      object Lesezeichen1: TMenuItem
        Caption = 'Lesezeichen anspringen'
        object Lesezeichen01: TMenuItem
          Caption = 'Lesezeichen 0'
          OnClick = Lesezeichen01Click
        end
        object Lesezeichen11: TMenuItem
          Caption = 'Lesezeichen 1'
          OnClick = Lesezeichen11Click
        end
        object Lesezeichen21: TMenuItem
          Caption = 'Lesezeichen 2'
          OnClick = Lesezeichen21Click
        end
        object Lesezeichen31: TMenuItem
          Caption = 'Lesezeichen 3'
          OnClick = Lesezeichen31Click
        end
        object Lesezeichen41: TMenuItem
          Caption = 'Lesezeichen 4'
          OnClick = Lesezeichen41Click
        end
        object Lesezeichen51: TMenuItem
          Caption = 'Lesezeichen 5'
          OnClick = Lesezeichen51Click
        end
        object Lesezeichen61: TMenuItem
          Caption = 'Lesezeichen 6'
          OnClick = Lesezeichen61Click
        end
        object Lesezeichen71: TMenuItem
          Caption = 'Lesezeichen 7'
          OnClick = Lesezeichen71Click
        end
        object Lesezeichen81: TMenuItem
          Caption = 'Lesezeichen 8'
          OnClick = Lesezeichen81Click
        end
        object Lesezeichen91: TMenuItem
          Caption = 'Lesezeichen 9'
          OnClick = Lesezeichen91Click
        end
      end
      object N14: TMenuItem
        Caption = '-'
      end
      object Wrterzhlen1: TMenuItem
        Caption = 'W'#246'rter z'#228'hlen...'
        OnClick = Wrterzhlen1Click
      end
      object N25: TMenuItem
        Caption = '-'
      end
      object Optionen1: TMenuItem
        Caption = 'Optionen...'
        OnClick = Optionen1Click
      end
    end
    object Hilfe1: TMenuItem
      Caption = '&Hilfe'
      object Inhalt1: TMenuItem
        Caption = 'Inhalt'
        ShortCut = 112
        OnClick = Inhalt1Click
      end
      object N7: TMenuItem
        Caption = '-'
      end
      object ber1: TMenuItem
        Caption = #220'ber...'
        OnClick = ber1Click
      end
    end
    object X1: TMenuItem
      Caption = 'X'
      OnClick = X1Click
    end
    object Debug1: TMenuItem
      Caption = 'Debug'
      Visible = False
      object Addopen1: TMenuItem
        Caption = 'Addopen'
        OnClick = Addopen1Click
      end
      object est1: TMenuItem
        Caption = 'Test'
      end
      object Syneditfilename1: TMenuItem
        Caption = 'Synedit filename'
        OnClick = Syneditfilename1Click
      end
      object Setbookmarkonzeile1: TMenuItem
        Caption = 'Set bookmark on zeile'
        OnClick = Setbookmarkonzeile1Click
      end
    end
  end
  object OpenDialog: TOpenDialog
    Filter = 'Alle Dateien (*.*)|*.*'
    Left = 8
    Top = 304
  end
  object shPascal: TSynPasSyn
    CommentAttri.Foreground = clNavy
    StringAttri.Foreground = clGray
    Left = 360
    Top = 336
  end
  object shCPlusPlus: TSynCppSyn
    CommentAttri.Foreground = clNavy
    StringAttri.Foreground = clGray
    Left = 104
    Top = 336
  end
  object shCSharp: TSynCSSyn
    CommentAttri.Foreground = clNavy
    StringAttri.Foreground = clGray
    Left = 136
    Top = 336
  end
  object shCSS: TSynCssSyn
    CommentAttri.Foreground = clNavy
    StringAttri.Foreground = clGray
    Left = 200
    Top = 336
  end
  object shHTML: TSynHTMLSyn
    DefaultFilter = 'HTML Documents (*.htm;*.html;*.shtml)|*.htm;*.html;*.shtml'
    CommentAttri.Foreground = clNavy
    Left = 328
    Top = 336
  end
  object shPerl: TSynPerlSyn
    CommentAttri.Foreground = clNavy
    StringAttri.Foreground = clGray
    Left = 392
    Top = 336
  end
  object shPHP: TSynPHPSyn
    CommentAttri.Foreground = clNavy
    IdentifierAttri.Foreground = clRed
    KeyAttri.Foreground = clBlack
    StringAttri.Foreground = clNavy
    SymbolAttri.Foreground = clRed
    Left = 424
    Top = 336
  end
  object shJava: TSynJavaSyn
    CommentAttri.Foreground = clNavy
    StringAttri.Foreground = clGray
    Left = 40
    Top = 368
  end
  object shXML: TSynXMLSyn
    CommentAttri.Foreground = clNavy
    WantBracesParsed = False
    Left = 360
    Top = 368
  end
  object shEiffel: TSynEiffelSyn
    CommentAttri.Foreground = clNavy
    Left = 232
    Top = 336
  end
  object shFortran: TSynFortranSyn
    CommentAttri.Foreground = clNavy
    StringAttri.Foreground = clGray
    Left = 264
    Top = 336
  end
  object shVB: TSynVBSyn
    CommentAttri.Foreground = clNavy
    StringAttri.Foreground = clGray
    Left = 232
    Top = 368
  end
  object shCobol: TSynCobolSyn
    CommentAttri.Foreground = clNavy
    AreaAStartPos = 7
    AreaBStartPos = 11
    CodeEndPos = 71
    Left = 168
    Top = 336
  end
  object shJavascript: TSynJScriptSyn
    CommentAttri.Foreground = clNavy
    StringAttri.Foreground = clGray
    Left = 72
    Top = 368
  end
  object shVBScript: TSynVBScriptSyn
    CommentAttri.Foreground = clNavy
    StringAttri.Foreground = clGray
    Left = 264
    Top = 368
  end
  object shVRML97: TSynVrml97Syn
    Left = 328
    Top = 368
  end
  object shAWK: TSynAWKSyn
    CommentAttri.Foreground = clNavy
    Left = 40
    Top = 336
  end
  object shBatchScriptDOS: TSynBatSyn
    Left = 72
    Top = 336
  end
  object shPython: TSynPythonSyn
    CommentAttri.Foreground = clNavy
    Left = 8
    Top = 368
  end
  object shTcl: TSynTclTkSyn
    CommentAttri.Foreground = clNavy
    StringAttri.Foreground = clGray
    Left = 168
    Top = 368
  end
  object shRuby: TSynRubySyn
    CommentAttri.Foreground = clNavy
    Left = 104
    Top = 368
  end
  object shUNIXShellScript: TSynUNIXShellScriptSyn
    CommentAttri.Foreground = clNavy
    Left = 296
    Top = 368
  end
  object shAssembler: TSynAsmSyn
    CommentAttri.Foreground = clNavy
    StringAttri.Foreground = clGray
    Left = 8
    Top = 336
  end
  object shSQL: TSynSQLSyn
    CommentAttri.Foreground = clNavy
    StringAttri.Foreground = clGray
    Left = 136
    Top = 368
  end
  object shTEX: TSynTeXSyn
    CommentAttri.Foreground = clNavy
    Left = 200
    Top = 368
  end
  object shFoxPro: TSynFoxproSyn
    CommentAttri.Foreground = clNavy
    StringAttri.Foreground = clGray
    Left = 296
    Top = 336
  end
  object TimerMain: TTimer
    Interval = 250
    OnTimer = TimerMainTimer
    Left = 40
    Top = 272
  end
  object SaveDialog: TSaveDialog
    Filter = 'Alle Dateien (ASCII) (*.*)|*.*|Alle Dateien (Unicode) (*.*) |*.*'
    Left = 40
    Top = 304
  end
  object PrinterSetupDialog: TPrinterSetupDialog
    Left = 72
    Top = 304
  end
  object PrinterDialog: TPrintDialog
    Options = [poSelection]
    Left = 104
    Top = 304
  end
  object SynEditPrint: TSynEditPrint
    Copies = 1
    Header.DefaultFont.Charset = DEFAULT_CHARSET
    Header.DefaultFont.Color = clBlack
    Header.DefaultFont.Height = -13
    Header.DefaultFont.Name = 'Arial'
    Header.DefaultFont.Style = []
    Footer.DefaultFont.Charset = DEFAULT_CHARSET
    Footer.DefaultFont.Color = clBlack
    Footer.DefaultFont.Height = -13
    Footer.DefaultFont.Name = 'Arial'
    Footer.DefaultFont.Style = []
    Margins.Left = 25.000000000000000000
    Margins.Right = 15.000000000000000000
    Margins.Top = 25.000000000000000000
    Margins.Bottom = 25.000000000000000000
    Margins.Header = 15.000000000000000000
    Margins.Footer = 15.000000000000000000
    Margins.LeftHFTextIndent = 2.000000000000000000
    Margins.RightHFTextIndent = 2.000000000000000000
    Margins.HFInternalMargin = 0.500000000000000000
    Margins.MirrorMargins = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    TabWidth = 8
    Color = clWhite
    Left = 136
    Top = 304
  end
  object pmenuTabs: TPopupMenu
    Left = 72
    Top = 272
    object Schlieen1: TMenuItem
      Caption = 'Schlie'#223'en'
      ShortCut = 16499
      OnClick = Schlieen1Click
    end
    object Alleschlieen1: TMenuItem
      Caption = 'Alles schlie'#223'en'
      OnClick = Alleschlieen1Click
    end
    object AllesausseraktuellerDateischlieen1: TMenuItem
      Caption = 'Alles ausser aktueller Datei schlie'#223'en'
      OnClick = AllesausseraktuellerDateischlieen1Click
    end
    object N11: TMenuItem
      Caption = '-'
    end
    object Speichern2: TMenuItem
      Caption = 'Speichern'
      ShortCut = 16467
      OnClick = Speichern2Click
    end
    object Speichernunter2: TMenuItem
      Caption = 'Speichern unter...'
      ShortCut = 123
      OnClick = Speichernunter2Click
    end
    object N12: TMenuItem
      Caption = '-'
    end
    object Drucken2: TMenuItem
      Caption = 'Drucken'
      ShortCut = 16464
      OnClick = Drucken2Click
    end
    object Seitenansicht2: TMenuItem
      Caption = 'Seitenansicht'
      OnClick = Seitenansicht2Click
    end
  end
  object actlMain: TActionList
    Left = 8
    Top = 400
    object actFileOpen: TAction
      Caption = '&Open...'
      ImageIndex = 0
      ShortCut = 16463
    end
    object actSearch: TAction
      Caption = '&Find...'
      ImageIndex = 1
      ShortCut = 16454
    end
    object actSearchNext: TAction
      Caption = 'Find &next'
      Enabled = False
      ImageIndex = 2
      ShortCut = 114
    end
    object actSearchPrev: TAction
      Caption = 'Find &previous'
      Enabled = False
      ImageIndex = 3
      ShortCut = 8306
    end
    object actSearchReplace: TAction
      Caption = '&Replace...'
      Enabled = False
      ImageIndex = 4
      ShortCut = 16456
    end
  end
  object SynEditRegexSearch: TSynEditRegexSearch
    Left = 76
    Top = 400
  end
  object SynEditSearch: TSynEditSearch
    Left = 44
    Top = 400
  end
  object TBImageList1: TTBImageList
    Height = 18
    Width = 18
    Left = 8
    Top = 240
    Bitmap = {
      494C010105000900040012001200FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      000000000000360000002800000048000000360000000100200000000000C03C
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000005E5252006E5E5E00BAB2
      B200D4D0D000D5D1D100D5D1D100D5D0D000D5D0D000D5CFCF00D4CFCF00D4CF
      CF00D4CECE00D5CFCF00C0B9B900746565006053530060575700000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000565757005D5C5C006E626200BEB6
      B600FBFAFA00FAF8F800F9F6F600F8F5F500F6F2F200F4EEEE00F2ECEC00F0EA
      EA00EDE7E700F2EBEB00C8C0C000726868005F5E5E0058585800000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000005C5D5D009A989800BDB6B600CABF
      BF00F6F3F300FAF8F800F7F4F400F5F1F100F3EFEF00F1EAEA00EFE7E700ECE4
      E400E9E1E100F0E9E900CFC4C400BEB8B8009F9C9C0060606000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000073727200DAD3D300E8E0E000B4AE
      AE00CDCACA00F0EFEF00EAE8E800E9E6E600E7E5E500E6E2E200E4DFDF00E1DC
      DC00E4DFDF00D0CCCC00B2ABAB00E5DEDE00E0D7D7007A787800000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000086828200DDD0D000D6C9C9006F6C
      6C00606160008384840080818100808181008081810080818200808182008081
      8100838484006365650067666600D0C4C400E0D2D2008E898900000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000008F878700D2C0C000CDBCBC00A99D
      9D00938888009387850096888400968782009786810097868000968782009688
      83009387840093888700A69A9A00CBBABA00D4C1C1009A909000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000093898900D0BDBD00D3C5C500DCD2
      D400E6AF8C00F59B5F00F89A5700F9964F00FA934A00FA934A00F9954F00F89A
      5600F69C5F00E8A88200DDD2D200D4C6C600D1BEBE009E919100000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000A19B9B00EEE6E600ECE6E700E6E5
      E800E3A97000FF891600FF7F0100FF7E0000FF7E0000FF7F0000FF7F0000FF80
      0000FF7E0200E5904100E5E4E700EAE5E600E9E0E000ACA4A400000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000A1A1A100F9F7F700F2EEEE00E8E5
      EA00DDBF9800FDBF6200FEB14300FEA42100FDA01800FDA01700FDA01800FDA0
      1800FE9D1100DCAB6500E2E1E700E7E0E000EDE6E600ABA6A600000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000082828200F0EBEB00F2EEEE00F1EE
      EF00D1C5B700F4D9AE00FCE3BB00FBDFB300FBD9A400FBD19300FACF8E00FBCE
      8B00F7C88100D0BBA300DAD3D300C7C8B000DAD3CB0088848400000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000005D5C5C00C5BFBF00E9E3E300F2EC
      EC00C8C0BD00D9C4B100F3E1CE00EFE0CE00EFE1D000EEE1D000EDE0CE00EEE0
      CC00DDC8B300C2B8B300E6DCDD00DCD4D000C1BAB90063616100000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000484848006463630089868600A39E
      9E00A49F9F00D0C5C100F6F3ED00F0F2EC00EDF2EC00EAF2ED00E7F2ED00EAF3
      EE00D4CDCA00A39C9C00A5A1A1008E8A8B00696767004B4B4B00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000004848480046474700454545004042
      42005A585800D1CACA00FCFFFF00F6FFFF00F3FFFF00F0FFFF00ECFFFF00EFFF
      FF00D8D4D5005E5A5A0040424200454646004747470048494900000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000004848480048484800444545004A44
      440061535300CEC6C600FDFFFF00F9FFFF00F7FFFF00F3FFFF00EFFFFF00F2FF
      FF00D7D1D100665757004B4646004545450049494900494A4A00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000484848004A484800544A4A00634F
      4F0069535300CAC3C300FEFFFF00FCFFFF00F9FFFF00F6FFFF00F2FFFF00F5FF
      FF00D4CFCF006E5A5A0067555500574E4E004B49490048494900000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000004F494900574949005E4B4B005E4B
      4B00614E4E00C8C1C100FFFFFF00FEFFFF00FCFFFF00F9FFFF00F5FFFF00F8FF
      FF00D2CDCD006554540062515100625151005A4D4D00514C4C00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000005A4949005B4949005B4949005B49
      49005E4C4C00C9C4C400FFFFFF00FFFFFF00FEFFFF00FDFFFF00FCFFFF00FCFF
      FF00D5CFCF00625353006050500060505000605050005E4F4F00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000604D4D005F4D4D005F4D4D005F4D
      4D0061505000A89F9F00CBC7C700CAC5C500CAC5C500CBC5C500CBC5C500CCC6
      C600B0A7A7006455550063535300635353006353530063535300000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000EEEEEE00D2D0D000D3D0
      D000D3D0D000D3D0D000D3D0D000D3D0D000D3D0D000D3D0D000D3D0D000D3D0
      D000D3D0D000D2D0D000D3D0D000D1D0D000D0D0D000F6F6F60000000000C8B5
      A3007A420E008B501A008C501A008C501A008C5019008C5019008C5019008B50
      18007F471800824618006E3F38002D77D2005F4E600085451700391B60000401
      BD00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000AEA2A200340E0A00491E
      1400471D17004526260045272700452727004526260045262600452727004524
      2200471E1600481D1300491D1200320F0A000A010100D0D0D00000000000DAC3
      AC00CA9E6B00F4D9B800F4D7B500F4D6B200F4D5B000F4D4AE00F4D2AB00E8CF
      A8009292A3008490A9009988A00051BAE9008999B3007E98A8002156C0000209
      C200EEEEEE00A2A2A200A2A2A200A2A2A200A2A2A200A2A2A200A2A2A200A2A2
      A200A2A2A200A2A2A200A2A2A200A2A2A200A2A2A200A2A2A200A2A2A200A2A2
      A200A2A2A200EEEEEE0000000000F0DFDF00E2BAB400EDCDBF00E8CBC300E6D4
      D400E7D5D500E7D4D400E7D5D500E7D5D500E7D5D500E6D2D100EBCFC800EDCD
      C000EDCABB00E3BBB200D5A5A400D3A2A20000000000D1ADAA00AE553700DB89
      5000D0795400C19FA100C4AAAB00C4A6A600C4A4A400C4A4A400C4A5A600C398
      9100D4805100DB7A3A00DB783400AE542B00300E0A00D1D0D00000000000E1C9
      B200DABB9400FFFBF400FFF7EE00FFF6EA00FFF4E700FFF3E400FFF1E100F6F1
      DE00AFBCD20078B2E3005D8CD4004DB7EC00499AE00045B2E000345CAA00080D
      C500D0D0D0000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000D0D0D00000000000E0B7B100CA6F4900E9975800D48A6900C8B0
      B200CCB7B800CDB3B300CDB1B100CDB1B100CCB2B300CBA9A500E1A18400E991
      5400E9833900CE68360093170F008500000000000000DFB7B200D87E4F00FFAE
      5D00E7915F00D0BBBD00D2ABA400D4BAB700D5C8C800D6C8C800D5C9CB00D6BA
      B100F1925300FE8F3500FF903000D7743400441A1100D2D0D00000000000E1C9
      B200D9B99200FFF9F100FFF5EB00FFF3E700FFF1E400FFF0E100FDF1DF00BFC3
      CE0092A9C9005F8CCD0061BCEC006EE6F90049D2F5004291D000455D9E001030
      D100E3D7D000792E0000963A0000963A0000B0440000B3450000B3450000B345
      0000B3450000B3450000B3450000B3470000AF3C0000A52800008C360000280F
      000000000000D0D0D00000000000E9C6BC00E3945C00FFA95900E3986F00CFBD
      BF00D4A79F00D3BAB800D4C8C800D5C8C800D4C9CA00D5BFB900F0AA8700FD98
      4C00FF8C2B00E7833B009C2618008400000000000000DFB7B100D77D4F00FEAC
      5F00E0946300D5BAB700D9614600DDA39500DFD7D700E0D6D600DFD8DA00DDC3
      BB00EF824800FD883300FF903400D7743500431A1000D2D0D00000000000E1C9
      B100D9B99300FFFAF300FFF6ED00FFF4EA00FFF3E700FFF1E400FAF0E000789A
      C60082BAE10074B8E50077DAF60086FAFE0058EBFB0036BFED0029BFE9001B83
      E500F0DDD000CB540400EB6A0D00C7510300F8934400FE9A4B00FE984900FE97
      4600FE964200FE943F00FE913B00FE943A00F87D3100EB552200F4822B007A35
      040000000000D0D0D00000000000E9C5BB00E3935D00FFA95B00E79F7700CDB3
      B500CC574700DEAAA100E1DBDA00E0D7D700DFD8D900DDC8C300EE977200FD90
      4500FF8F3100E7823C009C2617008400000000000000DFB7B000D67D5000FEAE
      6300DC9A6A00D9C8C700CC6E5700DDB0A500E8E6E600E8E4E500E8E7E900E4CE
      C600EE764000FC853200FF943900D7743600431A0F00D2D0D00000000000E1CB
      B500D9BD9B00FFFCF700FFF8F200FFF6ED00FFF4EA00FFF3E700FFF3E500DAD5
      D700A8A9C9006588C9005DAFE60062D9F70043C5F300458BCB00493D7F000D0F
      BE00F1DDD000CF5B0900F0781800D4590600FAAA6700FFB37200FFB16F00FFAF
      6A00FFAC6500FFA95F00FFA75B00FFA85900F78D4900E9603100FF9640008B3F
      060000000000D0D0D00000000000E9C4BA00E3935D00FFAC5F00EBA57F00C7C2
      C900695966008B869400C8C7CF00E7DFDE00EBE7E700E5D1CB00EE876100FC8A
      4000FF933700E7833D009C2516008400000000000000DFB6B000D67D5000FEB1
      6700DB9B6E00E2DEE000DEC9C300E5DCDA00ECEDEF00ECEDEF00ECF0F200E9D3
      CC00ED683700FA813100FF973E00D775360043190F00D2D0D00000000000E1CF
      BD00D9C3AA00FFFEFC00FFFBF700FFF9F400FFF7EF00FFF5EB00FFF2E700F3F2
      E400A0B5D30074AEDE006584CD004DB4EA005593D90047B5E1002761B9000708
      BB00F1DDD000CF5D0E00F07E2400D45B0900FAB27800FFBC8400FFBA8000FFB8
      7B00FFB57600FFB16E00FFAE6900FFAF6700F7935300E9643800FF9948008B3E
      070000000000D0D0D00000000000E9C4B900E3935E00FFAD6200EEAA8400DFE0
      E7009BA2AF009BB6C50094B5CF0085A3C700CDD3DE00EDD8D200ED764F00FA84
      3A00FF973D00E7833D009C2415008400000000000000DFB5AF00D67D5000FEB5
      6D00E49B6100E0B59600E5BB9B00E4B89800E6B69500EAB69400EDB69400EFA6
      7E00F36B2D00FC853300FF983F00D775370043190E00D2D0D00000000000E1CF
      BD00D9C4AB00FFFFFD00FFFDF900FFFBF800FFFAF500FFF9F200FFF6ED00F3F1
      E500A7B5D3009BB1D400A9A8CE0045AEE90094AFD700A2B9CD003E5BAA00130F
      AF00F1DDD000CF601300F0873200D45D0C00FABC8A00FFC79700FFC59300FFC2
      8E00FFBF8900FAB87E00DFA16C00D1976300CB805200C0593900D18347007C3B
      110007050500D0D0D00000000000E9C3B800E3935E00FFB26A00F39C6900ECB3
      9A00C6A39A00C6D4DE0074C7F800118AE700588EC800D49D8C00F46C3400FB84
      3500FF993E00E7833E009C2314008400000000000000DFB5AE00D67D4F00FEBB
      7C00FAB77D00F7B07500F7AF7300F6AD6F00F7AB6D00F8A96900F9A86700FAA6
      6400FAA56300FAA66200FDA25400D776380043180D00D2D0D00000000000E1CF
      BD00D9C4AB00FFFFFD00FFFDFB00FFFCFA00FFFBF800FFFAF600FFF9F400FDF6
      EE00F3EFE500F2F0E300DBD6DA005B8DD500BDC5DA00F2DEBF009D6641007135
      1D00F1DDD000CF631800F08F4000D45F1000FAC59A00FFD2AB00FFCFA600FFCC
      A000FFC89A00EAC1A200F6D3B600F1D1B200EDC0A500E6A59100F1C29C00E5BC
      A0005E5A5A00D5D4D40000000000E9C3B700E3935E00FFBA7A00FBB17400FAAC
      6C00DA9C6E00A1B8C00085DBFB0013AAFE000992E90069788F00E7945600FAA1
      5800FD9F4F00E7843F009C2313008400000000000000DFB4AD00D67B4C00FACC
      A200F6F3EF00F9F5F100F8F4F100F7F3F100F6F2F000F5EFED00F4EDEA00F3EA
      E700F2E8E400ECE4E200F2BB8B00D775350043170C00D2D0D00000000000E1CF
      BD00D9C4AB00FFFFFD00FFFEFE00FFFDFB00FFFDFA00FFFCF800FFFBF600FFFA
      F400FFF6EF00FFF3E800FFF4E500FAEEDF00FFF2E100F6DDC200A36934007A3A
      0000F1DDD000CF671E00F0984F00D4611400FACDA800FFDABA00FFD7B300FFD4
      AF00FFD1A900E0C0A800FFE0C400FFDCBD00FBCBAF00F4AD9900FFCCA500FFD4
      B6006E6B6900D5D4D40000000000E9C2B500E3915B00F8D2AD00F4EFEA00F5EF
      EA00F1EAE5009EBACB0079D0E2008AE8FE0026C6FF000AA8EE006597BC00DDD1
      CE00ECBA8F00E7843D009C2211008400000000000000DFB4AC00D67B4C00F9CC
      A200F8FAF80000000000FFFEFE00FFFDFD00FFFBFA00FFF8F500FFF5F100FFF2
      EC00FFF0EA00F5ECE900F0B98A00D776360043170B00D2D0D00000000000E1CF
      BD00D9C4AB00FFFFFD00FFFEFE00FFFEFD00FFFDFB00FFFCFA00FFFBF800FFFA
      F700FFF9F500FFF7F000FFF4E900FFF3E400FFF3E400F6DFC400A36935007A3A
      0000F1DDD000CF6B2600F0A46300D4641900FADDC600FFEBDA00FFEAD700FFE8
      D500FFE7D100DFC9B900FFE6D100FFE1CB00FCD7C300F7C4B400FCD0B100F9CE
      AC006E696400D5D4D40000000000E9C1B500E3915B00F6D4B000FAFBF900FEFF
      FF00FEFEFE00F1EFF30096BDCF0081DEE9007CEBFD002DD8FF001AB8E90084AD
      C900E4B18A00E7853D009C2110008400000000000000DFB4AC00D67C4D00F8CB
      A000F8F8F700FFFEFE00FFFDFC00FFFAF800FFF6F300FFF3EF00FFF0EA00FFEE
      E700FFEFE900F4EDEA00EFB88900D776360043170A00D2D0D00000000000E1CF
      BD00D9C4AB00FFFFFD0000000000FFFFFE00FFFEFD00FFFDFC00FFFCF900FFFB
      F800FFFAF600FFFAF400FFF7F100FFF4EB00FFF4E900F6E1C600A36A35007A39
      0000F1DDD000CF773A00F8CA9E00E1935900FBB88600FFBD8D00FFBD8D00FFBD
      8D00FFBD8D00DFB49500FFCDAA00FFC8A500FEC6A300FDC2A000FBC3A000F7CF
      B6006E666000D5D5D40000000000E9C0B400E3915B00F5D2AE00FAFBF900FFFE
      FE00FFFDFC00FFFBFA00EFECED0089BACB007DDCE8007AF3FE0031E8FE0028C4
      E20094978900E07F3D009E220E008300000000000000DFB3AB00D67C4D00F7C9
      9F00F7F7F700FFFDFD00FFF9F800FFF7F400FFF4EF00FFF0EB00FFEDE700FFEF
      E800FFF2ED00F4EEEC00EEB88800D777380043160A00D2D0D00000000000E1CF
      BD00D9C4AB00FFFFFD000000000000000000FFFEFE00FFFEFD00FFFDFB00FFFC
      FA00FFFBF800FFFAF600FFFAF500FFF8F300FFF8F200F6E7D400A3703F007A3D
      0500F1DDD000CF7F4900FFE5C800F9D3B200FEC79C00FFC69B00FFC69B00FECC
      A500F9D2B800B38F7700FFC5A300FFC09F00FFC1A100FFC1A100FFC3A500FFD4
      BD006E635900D5D5D40000000000E9C0B200E3925B00F3D0AD00F8FAF900FFFD
      FC00FFFAF800FFF7F400FFF6F200E0E1E00086BACA0083E1EC0076F4FE0029ED
      FC003BC9D300967561009E190C008D00000000000000DFB3AA00D67C4E00F6C9
      9E00F6F5F500FFFBF800FFF7F300FFF4EF00FFF1EB00FFEEE700FFEFE900FFF2
      ED00FFF5F100F3F0EE00ECB48500D573340044160900D2D0D00000000000E1CF
      BD00D9C4AB00FFFFFD00000000000000000000000000FFFFFE00FFFEFD00FFFD
      FB00FFFCF900FFFBF800FFFAF600FFF9F400FFFAF500F6EBDD00A37648007A42
      0B00F1DDD000CF845100FFF1DE00FFE6D000FFE2CB00FFE2CA00FEE9D800ECD1
      BF00B95B2F00A3918800FFE1CC00FFDCCA00FEDCCB00FEDDCC00FFDCCA00FFE3
      D0006E686100D5D5D50000000000E9BFB200E3915C00F2CEAB00F7F8F800FFFA
      F800FFF7F400FFF4F000FFF1EB00FDF0E800DDDDDC007BB8CC0089E5EF006FEF
      FE0027EBFD0035B7C8005338550050193E0000000000DEB1AA00D57B4D00F6CB
      9E00F7F4F000FDF9F400FDF6F000FDF3EB00FDF0E800FDF2EA00FDF4EE00FDF6
      F100FDF8F400F4F2ED00E2AD7F00C7662A0043140700D2D0D00000000000E1CF
      BE00DAC4AC00FFFFFE000000000000000000000000000000000000000000FFFE
      FE00FFFDFC00FFFCFA00FFFBF900FFFBF700FFFBF700F6EBDF00A37648007B42
      0B00F1DDD000C9794700EDD5C500EDD5C500EDD5C500EDD5C500E6BEA400BA5C
      2D00621E0000A3A19C00FFF8F000FFF0E800FFEFE800FFEFE800FFF0E800FFF8
      F1006E727000D5D6D60000000000E9BFB200E3945E00F1D0AD00F8F6F600FFF9
      F700FFF7F300FFF4EF00FFF1EA00FFF1EB00FFF6F100D5D9DF0072BBD20090EB
      F60064EDFF0028E9FE0026ABCB002C41750000000000D8A8A400B5432600D380
      5B00D3978A00D5988B00D5978900D4968700D4958600D4968800D4968900D396
      8A00D3968A00CE948700D1775000AD441D0031090200D1D0D00000000000E0CF
      BD00D9C3AB00FFFFFE0000000000000000000000000000000000000000000000
      000000000000FFFEFE00FFFEFD00FFFDFC00FFFDFB00F6EBDE00A27547007940
      0A00F7ECE500D89F7C00DCAA8B00DCAA8B00DCAA8B00DCAA8B00DCAA8B00CA97
      7C008178730081838200C0BFBE00BEBEBB00BEBEBB00BEBEBB00BEBEBB00BFBF
      BE0050525200D3D4D40000000000E2B4AB00D1724400E5B18B00E7C9BF00EBCB
      C100EACABF00EAC9BB00E9C8BA00E9C8BB00E8C9BD00E8C9BF00BCA8A800609F
      B50085EAF8005AECFF0021DBFB00286EA20000000000EFDDDD00D8A8A400DFB3
      AB00DFB5B000DFB4AF00DFB4AF00DFB4AF00DFB4AF00DFB4AF00DEB4AF00DEB4
      AF00DEB4AF00DEB4AF00E0B3AA00D1A9A400ADA2A200EEEEEE0000000000D2BF
      AD00AC845C00D1B59600D1B59700D1B59700D1B59700D1B59700D1B59700D1B5
      9700D1B59700D1B59600D1B59600D1B49600D2B59600C5A37E00835224006833
      0300000000000000000000000000000000000000000000000000000000000000
      000000000000C1C2C200CCCCCC00CACACA00CACACA00CACACA00CBCACB00CCCC
      CB00B1B1B100EEEEEE0000000000D6A4A3009A190D00A62E2000A5332B00A533
      2B00A4332B00A4322A00A4322900A3322900A3312900A3322A00A82F27007829
      32004B9BBB004FDCF9001DA5DD002B4C83000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000F5F2
      EE00EBE2D900F2E9E100F2E9E100F2E9E100F2E9E100F2E9E100F2E9E100F2E9
      E100F2E9E100F2E9E100F2E9E100F2E9E100F2EAE100EFE6DD00E5DCD300E2D8
      D000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000D4A2A2008A0000008E0100008E0000008E00
      00008E0000008E0000008E0000008E0000008E0000008D000000920000008404
      0A003737670027689E002D467D00342D5F00424D3E000000000000003E000000
      2800000048000000360000000100010000000000880200000000000000000000
      000000000000000000000000FFFFFF0000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000800000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      800020000FFFFFFFFF0000008000200000000200000000008000200000000200
      0000000080002000000002000000000080002000000002000000000080002000
      0000020000000000800020000000020000000000800020000000020000000000
      8000200000000200000000008000200000000200000000008400200000000200
      0000000080002200000002000000000080002300000002000000000080002380
      0000020000000000800023E00000020000000000800023F80000020000000000
      800020000FF8020000000000FFFFE0000FFFFE00000000000000000000000000
      0000000000000000000000000000}
  end
  object TBImageList2: TTBImageList
    Left = 40
    Top = 240
    Bitmap = {
      494C010105000900040010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000400000003000000001002000000000000030
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000EFDDDD00D4A2A200D4A2
      A200D6A5A200D6A6A200D6A7A200D5A6A200D7AAA500D9B0A600D8ADA200D8AD
      A200D7AEA200D8B1A200F1E3DD00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000D5A2A2008A0000008900
      00008F0A00008E0A00008C09000090140900B15F5400A74B3500911A00009119
      000092220000952A0000D9B3A200000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000D5A2A2008A0000008900
      00008F0800008C0600009D302A00C7928E00E4D7D300B66C5C008F1400008F16
      000092220000952A0000D9B3A200000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000D5A2A2008A0000008800
      0000CB949200EDE2DC00E0B79900CF8B5D00E8DEDC00C0817800A03B2C00A242
      2C00A4492B00A0421B00DAB6A500000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000D4A2A200890000009C29
      2900F4E5D800E5B18400D47A3300D1824600E8DDDB00E2CFCC00DBC1B900DAC0
      B800DAC4BD00C3917B00DFC0B300000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000D3A2A20099252500D7AA
      AA00EFAE7200E48D3F00DC823600D7823D00D7976800D3946700CE8E6400C886
      5D00D8BFB500CCA69800E0C3B700000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000D8ABAB00BF767700F7E8
      DE00F49E4800EC974600E58E4000DD853A00D4793100CD702B00C5672400BD5D
      1D00D4B09E00CDA69700E0C3B600000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000D7AAAA00BC717200F6E8
      E000FDA85000F6A34F00EF9A4900E7914200DE863900D77D3300CF732D00C769
      2600DAB7A300CDA79800E0C2B600000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000D3A2A20097212000D2A1
      A100FEC48700FCAB5700F7A14B00EFA15500EAB48700E7B38800E2AE8400DDA7
      7F00E5D1C700CFAA9B00E0C3B700000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000D5A2A200890000009723
      2300FAECE000FED3A400FDAD5900F7B06800F4EFEE00E8D5D200DEC2BB00DEC2
      BB00DEC4BC00C48E7700DFC0B200000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000D5A2A2008B0000008800
      0000C7858400F4E3DD00FEDFBD00FBC68E00F5EEED00C07D75009C3126009E39
      2600A14026009E3D1700DAB6A500000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000D5A2A2008B0000008A00
      00008F0B00008C0600009A262000C8898300EAD4CF00BA6F5E008F1400009017
      000093240000952B0000D9B3A200000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000D5A2A2008B0000008A00
      0000900B00008F0C00008E0B00008F110400AE554900A7473100921B0000921A
      000093230000952B0000D9B3A200000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000EFDDDD00D4A2A200D4A2
      A200D6A6A200D6A6A200D6A8A200D6A7A200D6A8A300D8AEA400D8AEA200D8AD
      A200D8AEA200D8B1A200F1E3DD00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000EEE5DC00EEE5DC00EEE4
      DC00EEE4DB00EEE4DB00EEE4DB00EEE4DB00EDE3DA00EAE0D500EFE5DA00F1E6
      DB00F1E6DA00F1E6DA00F1E5DA00E8DDD300000000000E0E0E00212121002A2A
      260022225D0027278A0019197000060624000000000000000000000000000000
      00000000000000000000000000000000000000000000EEF1FA00D2DFF500D2E4
      F600D2E3F600D2E3F500D2E3F400D2E2F400D2E2F400D2E1F300D2E1F300D2E0
      F200D2E0F100D1DBED00EEEFF700000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000008A592900C5A37D00C5A37D00C5A0
      7A00C59E7500C59D7300C59C7100C59B6F00BE956600A16E3900C2966500D0A3
      7200CFA16E00D0A16D00CEA06A00986026000A0A0900212121001C1C1C002727
      24006A6AEA005151DA003A3ACC002727B10004041D0000000000000000000000
      00000000000000000000000000000000000000000000A5B8EB002075D60037A3
      E200359FDF00349EDD00349DDB00339ADA003398D8003397D7003295D5003293
      D300338FD0001D5FB500A5B1D8000000000000000000F1E3DD00D8B1A200D7AE
      A200D8ADA200D8ADA200D9B0A600D7AAA500D5A6A200D6A7A200D6A6A200D6A5
      A200D4A2A200D4A2A200EFDDDD0000000000A87E5500FFFBEE00FFF8EC00FFF4
      E500FFF0DC00FFEED800FFECD400FFE9D000F3E1C100C39B6F00E6D7BD00FFEF
      D700FFE8CE00FFE8CD00FFEBCB00C38D52002424200020202000000000001D1D
      1D007272DD0021215C0022223C003B3BBA001A1A8A0000000400000000000000
      00000000000000000000000000000000000000000000A9C2EF0049AAEB007DE9
      FD0084C7CB0083C8CD0083C7CD0082C6CD0082C5CD0082C3CD0081C3CD0080C0
      CB007DE3FD004A9CD800AABBDF000000000000000000D9B3A200952A00009222
      000091190000911A0000A74B3500B15F5400901409008C0900008E0A00008F0A
      0000890000008A000000D5A2A20000000000A87E5500FFFAF100FFF6EE00FFF3
      E800FFEFDE00FFEDDB00FFEAD600FFE8D100F3E0C400C19A7000E5D5BE00FFED
      D900FFE7D000FFE6CE00FFE9CD00C58E550033332B0020202000000000001E1E
      1C007B7BE10020205E00161635004646BF002727BD0001010900000000000000
      00000000000000000000000000000000000000000000A9C1F00041A2EC0072BC
      D500D2B4A700CFB1A300CFAF9F00CEAC9C00CEA99800CDA69500CCA39200CDA3
      900072AFCD004296D900AABAE0000000000000000000D9B3A200952A00009222
      00008F1600008F140000B66C5C00E4D7D300C7928E009D302A008C0600008F08
      0000890000008A000000D5A2A20000000000AE8D6D00FFFEFB00FFFAF500FFF7
      EF00FFF3E700FFF0E300FFEFDE00FFECDA00F3E4CC00C19D7400E5D7C200FFF0
      DE00FFEAD500FFE9D400FFECD300C48F56002F2F3500343472003B3B9B002424
      76001C1C30005959AB006B6BEB001D1D720013130F0000000000000000000000
      00000000000000000000000000000000000000000000A9C0F2003C9EEF007AAC
      BA00FFFBF300FFF2E600FFF1E300FFEEDE00FFECD900FFEAD500FFE7D000FFEB
      D1007899AD003D92DB00A9B8E2000000000000000000DAB6A500A0421B00A449
      2B00A2422C00A03B2C00C0817800E8DEDC00CF8B5D00E0B79900EDE2DC00CB94
      9200880000008A000000D5A2A20000000000AE8D6D00FFFEFC00FFFCF900FFF9
      F300FFF5EB00FFF3E700FFF0E200FFEEDE00F3E6D000C19D7600E5D9C500FFF1
      E100FFECD800FFEBD700FFEED600C48F570038387B006E6EDD005D5DBC005050
      C8000C0C3F001C1C39005E5EB8005656C3001B1B310000000000000000000000
      00000000000000000000000000000000000000000000A9BFF3003B9BF10079AC
      BB00FFFCF900FFF6ED00FFF4E800FFF1E400FFEFDE00FFEDD900FFEBD500FFEF
      D7007999AD003D90DD00A9B7E4000000000000000000DFC0B300C3917B00DAC4
      BD00DAC0B800DBC1B900E2CFCC00E8DDDB00D1824600D47A3300E5B18400F4E5
      D8009C29290089000000D4A2A20000000000AE8D6D00FFFFFD00FFFEFC00FFFB
      F700FFF6EF00FFF5EB00FFF3E600FFF0E300F3E8D400C19E7700E5DAC800FFF2
      E500FFEDDB00FFECDA00FFEFD900C48F58005050B1006868C7001A1A39002828
      55003333CB0027277C009393AD00BABAD500767681002B2B2B00171717000303
      03000000000000000000000000000000000000000000A9BFF4003898F20072A7
      BB00FFFDFC00FFF9F500FFF8F000FFF4E900FFF1E300FFEFDE00FFECD900FFF1
      DC007999AC003D8EDE00A9B7E5000000000000000000E0C3B700CCA69800D8BF
      B500C8865D00CE8E6400D3946700D7976800D7823D00DC823600E48D3F00EFAE
      7200D7AAAA0099252500D3A2A20000000000AE8D6D00FFFFFD00FFFEFE00FFFE
      FC00FFF9F300FFF7EF00FFF5EB00FFF2E700F3EAD800C19F7900E5DACA00FFF4
      E800FFEFDE00FFEEDD00FFF1DC00C49059003D3D7F005B5BC4000E0E2D001616
      39003737B4004242C100A4A4CB009C9C9900969695008C8C8C008E8E8E007070
      70000B0B0B0000000000000000000000000000000000A9BFF6003695F3006EA5
      BB00FFFEFD00FFFCF900FFFBF700FFF9F200FFF4EA00FFF1E300FFEEDE00FFF4
      E100799AAB003B8CE000A9B6E6000000000000000000E0C3B600CDA69700D4B0
      9E00BD5D1D00C5672400CD702B00D4793100DD853A00E58E4000EC974600F49E
      4800F7E8DE00BF767700D8ABAB0000000000AE8D6D00FFFFFD00FFFFFF00FFFF
      FF00FFFCF800FFF9F400FFF7F000FFF5EB00F3EDDF00C3A78700E5DCCD00FFF5
      EB00FFF0E200FFF0E100FFF2DF00C4915B002C2C310041418A004646AD004444
      C500141423002222420073739900C5C5C600C1C1C1009E9E9E00AAAAAA00B8B8
      B8009A9A9A0050505000121212000000000000000000A8BEF7003592F50070A6
      BB00FFFEFE00FFFEFC00FFFCF900FFFBF700FFF9F300FFF5EC00FFF1E300FFF6
      E6007A9BAB003B8AE100A9B6E7000000000000000000E0C2B600CDA79800DAB7
      A300C7692600CF732D00D77D3300DE863900E7914200EF9A4900F6A34F00FDA8
      5000F6E8E000BC717200D7AAAA0000000000AF8E6E00FFFFFE00FFFFFF00FFFF
      FF00FFFEFD00FFFCFA00FFFBF700FFF9F400F4EFE500C4AB8E00E5DBD000FFF7
      EE00FFF2E500FFF1E400FFF3E200C4915C002F2F27002F2F3200393964004545
      87002929210024241E0045454700C7C7C800D7D7D700AAAAAA007F7F7F009595
      9500B8B8B800B9B9B900787878001717170000000000A8BEF8003390F6006AA5
      BA0000000000FFFFFE00FFFEFC00FFFCF900FFFBF700FFF9F300FFF6EC00FFF9
      EE007B9CAB003B89E200A8B5E8000000000000000000E0C3B700CFAA9B00E5D1
      C700DDA77F00E2AE8400E7B38800EAB48700EFA15500F7A14B00FCAB5700FEC4
      8700D2A1A10097212000D3A2A20000000000A37E5A00EBE1D600ECE2D700E9DF
      D300E6DBCE00E6DBCE00E6DBCE00E6DBCD00DDCDBC00BDA18300E8E0D600FFF7
      F000FFF3E800FFF3E600FFF5E500C4915C003131290034342E0031312F002E2E
      2E002D2D250025251F002E2E2D0094949400E4E4E400BDBDBD004C4C4C002D2D
      2D00646464007D7D7D00919191004444440000000000A9BDF9002D8CF80055A0
      BA000000000000000000FFFFFE00FFFDFC00FFFCF900FFFAF600FFF9F300FFFD
      F800779CAD003988E400A9B5E9000000000000000000DFC0B200C48E7700DEC4
      BC00DEC2BB00DEC2BB00E8D5D200F4EFEE00F7B06800FDAD5900FED3A400FAEC
      E0009723230089000000D5A2A2000000000072411400875B350086593700A67E
      5900C5AD9500C5AD9500C5AD9400C5AD9400C3AA9100D4C3B200F9F5EF00FFF8
      F100FFF4EB00FFF3E900FFF7E900C79B6D002525200036363000343433003333
      33002F2F280027272300292929004F4F4F00E4E4E400D6D6D6007A7A7A001414
      140030303000323232003C3C3C003939390000000000AABDFA002888F9004899
      B900000000000000000000000000FFFEFE00FFFEFD00FFFDFD00FFFDFC00FFFE
      FD00568EAD002E84E500ABB7EA000000000000000000DAB6A5009E3D1700A140
      26009E3926009C312600C07D7500F5EEED00FBC68E00FEDFBD00F4E3DD00C785
      8400880000008B000000D5A2A20000000000622E00005E2900005E290000AF85
      6000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFEFE00FFFEFD00FFFCFB00FFFB
      F800FFF8F200FFF7EF00FFFBF200C9A780000000000000000000040404000707
      070002020200191919002D2D2D00292929004B4B4B00CDCDCD00E2E2E2006666
      6600272727002A2A2A00303030003232320000000000A9BDFD002D83FC00229E
      F20038834F001D8F1200158C0C0017870C001A850C001C840C001A7707002B5D
      3900229EF0003182E900ABB9ED000000000000000000D9B3A200952B00009324
      0000901700008F140000BA6F5E00EAD4CF00C88983009A2620008C0600008F0B
      00008A0000008B000000D5A2A20000000000622E0000602C00005E290000AD82
      5D00FFFFFE00FFFFFE00FFFFFE00FFFFFE00FFFFFE00FFFFFE00FFFEFD00FFFE
      FC00FFFDF800FFFCF500FFFDF700C7A67F000000000000000000000000000000
      000000000000060606001F1F1F00292929002C2C2C006F6F6F00D9D9D900B8B8
      B800050505000B0B0B00141414001B1B1B0000000000A7BBFE002772FD00248F
      FD002880B00052B1520058D7500056D7520056D8530055D84F00399F35001C6D
      9400248DF1002B6CE000A8B6EC000000000000000000D9B3A200952B00009323
      0000921A0000921B0000A7473100AE5549008F1104008E0B00008F0C0000900B
      00008A0000008B000000D5A2A20000000000612E0000612E00005F2B00008757
      2A00CAAD8F00CAAC8E00CAAC8E00CAAC8E00CAAC8E00CAAC8E00CAAC8E00CAAC
      8D00CAAC8C00CAAC8B00C9AC8A00976B3E000000000000000000000000000000
      000000000000000000000606060019191900282828002F2F2F0069696900ACAC
      AC00171717001A1A1A00131313000303030000000000A3B5FE00093BFD000E40
      FA00163EDA005B857900AAE6A100B4F6B600B3F6B40099E19400377253000D31
      B9000F2FCD000A26C700A3ADE9000000000000000000F1E3DD00D8B1A200D8AE
      A200D8ADA200D8AEA200D8AEA400D6A8A300D6A7A200D6A8A200D6A6A200D6A6
      A200D4A2A200D4A2A200EFDDDD0000000000E2D9D000E2D9D000E2D8D000E5DC
      D300F0E7DF00EFE7DE00EFE7DE00EFE7DE00EFE7DE00EFE7DE00EFE7DE00EFE7
      DE00EFE7DE00EFE7DE00EFE7DE00E7DED500D0D0D000D0D0D000D0D0D000D0D0
      D000D0D0D000D0D0D000D0D0D000D3D3D300D8D8D800D7D7D700DBDBDB00EAEA
      EA00D7D7D700D8D8D800D6D6D600D1D1D10000000000A2B4FF00002DFD000027
      F9000C29DC004D5E6100879965007EA66F0063A25B00448E3900144C3800021C
      BA000012C3000014C000A2ABE800000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000424D3E000000000000003E000000
      2800000040000000300000000100010000000000800100000000000000000000
      000000000000000000000000FFFFFF0000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000FFFF0000000000008001000000000000
      8001000000000000800100000000000080010000000000008001000000000000
      8001000000000000800100000000000080010000000000008001000000000000
      8001000000000000800100000000000080010000000000008001000000000000
      8001000000000000FFFF000000000000800080008001FFFF0000000080018001
      0000000080018001000000008001800100000000800180010000000080018001
      0000000080018001000000008001800100000001800180010000000088018001
      000000008C018001000000008E01800100000000800180010000000080018001
      0000000080018001000000008001FFFF00000000000000000000000000000000
      000000000000}
  end
  object TBImageList3: TTBImageList
    Left = 72
    Top = 240
    Bitmap = {
      494C010101000400040010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000400000001000000001002000000000000010
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000001C55000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000009D581200FFD8B100FFDC
      BA00FFDAB600FFD9B400FFD8B300FFD6AF00FFD5AD00FFD3A900FFD2A700FFD2
      A500F5C799008194AB004FBBFF002256AD000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000099551100FFF6EC00FFF4
      EA00FFF2E500FFF0E200FFEFDF00FFECDA00FFEBD800FFE8D300FFE7D000FFE6
      CD006984B10053BEFF003FA5EB00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000099551100FFF7EF00FFF6
      EC00FFF3E700FFF2E500FFF0E200FFEEDD00F5E3D200F8E4D000FFE8D300FFE7
      D0004FB6F80050BBF8004B4F5B00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000099551100FFFAF400FFF8
      F200FFF6EC00FFF4EA00C8C0B700D2AB8400E6C29F00E0BA9600BD956E006261
      6000BCC2CB00FFE6CD008F4F0F00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000995F2500FFFCF900FFFB
      F700FFF7F000F8EFE6009C948C00F9F4F200F6EFEB00F0E4DE00EDDFD700D7B8
      9B00FFE8D300FFE7D0008F4F0F00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000099622C00FFFDFC00FFFC
      FA00FFFBF700B4B1AE00DAC0A700F9F4F200F6EFEB00F0E4DE00EDDFD700E8D2
      C400DBCAB900FFE8D3008F4F0F00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000099622C00FFFEFE00FFFE
      FD00FFFCFA0092929100F2D8BF0000000000FAF6F500F0E4DE00EDDFD700EADA
      D100998F8600FFEBD8008F4F0F00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000099622C0000000000FFFE
      FE00FFFDFC00B9B8B700EACAAA000000000000000000F0E4DE00EDDFD700EADA
      D100B2A79D00FFECDA008F4F0F00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000099622C00000000000000
      0000FFFEFE00FFFEFD00A1A0A000FAF3EC000000000000000000F1DAC500B59F
      8A00FFF0E200FFEFDF008F4F0F00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000099622C00000000000000
      000000000000FFFEFE00FFFEFD00AA968300E1C0A000D4B89E00A4978A00BCB8
      B400FFF3E800FFF0E2008F4F0F00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000099622C00000000000000
      00000000000000000000FFFEFE00E5E4E300B2B1AF00BFBCBA00F2EDE900FFF9
      F400FFF7F100FFF7EF008F592300000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000099622C00000000000000
      0000000000000000000000000000FFFEFE00FFFEFD00FFFCFA00FFFCF800FFFB
      F700FFF9F400FFF8F2008F5C2900000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000099622C00000000000000
      000000000000000000000000000000000000FFFEFE00FFFDFC00FFFCFA00FFFC
      F800FFFAF500FFF9F4008F5C2900000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000099622C00FFF3E8000000
      00000000000000000000000000000000000000000000FFFEFD00FFFDFC00FFFC
      FA00FFFBF700FFEFE00092602D00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000424D3E000000000000003E000000
      2800000040000000100000000100010000000000800000000000000000000000
      000000000000000000000000FFFFFF0080000000000000008000000000000000
      8000000000000000800000000000000080000000000000008000000000000000
      80000000000000008100000000000000A180000000000000B0C0000000000000
      B800000000000000BC00000000000000BE00000000000000BF00000000000000
      9F80000000000000FFFF00000000000000000000000000000000000000000000
      000000000000}
  end
  object aeMain: TApplicationEvents
    OnMessage = aeMainMessage
    Left = 8
    Top = 40
  end
  object pmenuSyn: TPopupMenu
    Left = 104
    Top = 272
    object Lesezeichensetzen1: TMenuItem
      Caption = 'Lesezeichen umschalten'
      object Lesezeichen04: TMenuItem
        Caption = 'Lesezeichen 0'
        OnClick = Lesezeichen04Click
      end
      object Lesezeichen14: TMenuItem
        Caption = 'Lesezeichen 1'
        OnClick = Lesezeichen14Click
      end
      object Lesezeichen24: TMenuItem
        Caption = 'Lesezeichen 2'
        OnClick = Lesezeichen24Click
      end
      object Lesezeichen34: TMenuItem
        Caption = 'Lesezeichen 3'
        OnClick = Lesezeichen34Click
      end
      object Lesezeichen44: TMenuItem
        Caption = 'Lesezeichen 4'
        OnClick = Lesezeichen44Click
      end
      object Lesezeichen54: TMenuItem
        Caption = 'Lesezeichen 5'
        OnClick = Lesezeichen54Click
      end
      object Lesezeichen64: TMenuItem
        Caption = 'Lesezeichen 6'
        OnClick = Lesezeichen64Click
      end
      object Lesezeichen74: TMenuItem
        Caption = 'Lesezeichen 7'
        OnClick = Lesezeichen74Click
      end
      object Lesezeichen84: TMenuItem
        Caption = 'Lesezeichen 8'
        OnClick = Lesezeichen84Click
      end
      object Lesezeichen94: TMenuItem
        Caption = 'Lesezeichen 9'
        OnClick = Lesezeichen94Click
      end
    end
    object Lesezeichen2: TMenuItem
      Caption = 'Lesezeichen anspringen'
      object Lesezeichen02: TMenuItem
        Caption = 'Lesezeichen 0'
        OnClick = Lesezeichen02Click
      end
      object Lesezeichen12: TMenuItem
        Caption = 'Lesezeichen 1'
        OnClick = Lesezeichen12Click
      end
      object Lesezeichen22: TMenuItem
        Caption = 'Lesezeichen 2'
        OnClick = Lesezeichen22Click
      end
      object Lesezeichen32: TMenuItem
        Caption = 'Lesezeichen 3'
        OnClick = Lesezeichen32Click
      end
      object Lesezeichen42: TMenuItem
        Caption = 'Lesezeichen 4'
        OnClick = Lesezeichen42Click
      end
      object Lesezeichen52: TMenuItem
        Caption = 'Lesezeichen 5'
        OnClick = Lesezeichen52Click
      end
      object Lesezeichen62: TMenuItem
        Caption = 'Lesezeichen 6'
        OnClick = Lesezeichen62Click
      end
      object Lesezeichen72: TMenuItem
        Caption = 'Lesezeichen 7'
        OnClick = Lesezeichen72Click
      end
      object Lesezeichen82: TMenuItem
        Caption = 'Lesezeichen 8'
        OnClick = Lesezeichen82Click
      end
      object Lesezeichen92: TMenuItem
        Caption = 'Lesezeichen 9'
        OnClick = Lesezeichen92Click
      end
    end
    object N15: TMenuItem
      Caption = '-'
    end
    object Rckgngig2: TMenuItem
      Caption = 'R'#252'ckg'#228'ngig'
      ShortCut = 16474
      OnClick = Rckgngig1Click
    end
    object Wiederherstellen2: TMenuItem
      Caption = 'Wiederherstellen'
      ShortCut = 16473
      OnClick = Wiederherstellen1Click
    end
    object N20: TMenuItem
      Caption = '-'
    end
    object Ausschneiden2: TMenuItem
      Caption = 'Ausschneiden'
      ShortCut = 16472
      OnClick = Ausschneiden1Click
    end
    object Kopieren2: TMenuItem
      Caption = 'Kopieren'
      ShortCut = 16451
      OnClick = Kopieren1Click
    end
    object Einfgen2: TMenuItem
      Caption = 'Einf'#252'gen'
      ShortCut = 16470
      OnClick = Einfgen1Click
    end
    object N19: TMenuItem
      Caption = '-'
    end
    object Suchen3: TMenuItem
      Caption = 'Suchen'
      ShortCut = 16454
      OnClick = Suchen2Click
    end
    object Ersetzen2: TMenuItem
      Caption = 'Ersetzen'
      ShortCut = 16466
      OnClick = Ersetzen1Click
    end
    object N18: TMenuItem
      Caption = '-'
    end
    object MenuItem1: TMenuItem
      Caption = 'Schlie'#223'en'
      ShortCut = 16499
      OnClick = Schlieen1Click
    end
    object MenuItem2: TMenuItem
      Caption = 'Alles schlie'#223'en'
      OnClick = Alleschlieen1Click
    end
    object MenuItem3: TMenuItem
      Caption = 'Alles ausser aktueller Datei schlie'#223'en'
      OnClick = AllesausseraktuellerDateischlieen1Click
    end
    object MenuItem4: TMenuItem
      Caption = '-'
    end
    object MenuItem5: TMenuItem
      Caption = 'Speichern'
      ShortCut = 16467
      OnClick = Speichern2Click
    end
    object MenuItem6: TMenuItem
      Caption = 'Speichern unter...'
      ShortCut = 123
      OnClick = Speichernunter2Click
    end
    object Allesspeichern2: TMenuItem
      Caption = 'Alles speichern'
      OnClick = Allesspeichern2Click
    end
    object MenuItem7: TMenuItem
      Caption = '-'
    end
    object MenuItem8: TMenuItem
      Caption = 'Drucken'
      ShortCut = 16464
      OnClick = Drucken2Click
    end
    object MenuItem9: TMenuItem
      Caption = 'Seitenansicht'
      OnClick = Seitenansicht2Click
    end
  end
  object TrayIcon: TJvTrayIcon
    Icon.Data = {
      0000010001002020100000000000E80200001600000028000000200000004000
      0000010004000000000080020000000000000000000000000000000000000000
      000000008000008000000080800080000000800080008080000080808000C0C0
      C0000000FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000008080000000000000000000000000088800077777777777700000000
      00008880000F000000000000000000008888000F0F0FFFFFFFFFFFF000000000
      8000FFFF0F0FFFFFFFFFFFF00000000080FFFFF0FF0FFF7F7F7F7FF000000000
      80FFFFF0FF0FFFFFFFFFFF900000000090FFF70FFF0FFF7F7F7F7FF000000000
      8097FF0FFF0FFFFFFFFFFFF00000000080FFFF0FFF0FFF7F7F7F7FF000000000
      80FFF70FFF0FFFFFFFFFFFF00000000080F7FF0FFF0FFF7F7F7F7FF000000000
      80FFFF0FFF0FFFFFFFFFFFF00000000080FFF70FFF0FFF7F7F7F7FF000000000
      F0F7FF0FFF0FFFFFFFFFFFF000000000F0FFFF0FFF00FFFFFFFFFFF000000000
      F0FFF70FFF0000000000000000000000F0F7FF0FF00000000000000000000000
      F0FFFF0FF0000000000000000000000000FF000F000000000000000000000000
      0000000F00000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FFFF
      FFFFFFFFFFFFFFFFFFFFFFF8FFFFFFC00007FE000007C0000007C0000007C000
      0007C0000007C0000007C0000007C0000007C0000007C0000007C0000007C000
      0007C0000007C0000007C000000FC001000FC003FFFFC003FFFFE007FFFFF8C7
      FFFFFFCFFFFFFFCFFFFFFFCFFFFFFFDFFFFFFFFFFFFFFFFFFFFFFFFFFFFF}
    IconIndex = -1
    Hint = 'gtEdit'
    Visibility = [tvVisibleTaskBar, tvVisibleTaskList, tvAutoHide, tvAutoHideIcon, tvRestoreDbClick]
    Left = 168
    Top = 304
  end
  object FontDialog: TFontDialog
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    Options = []
    Left = 200
    Top = 304
  end
end
