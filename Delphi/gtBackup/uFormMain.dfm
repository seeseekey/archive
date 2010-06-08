object FormMain: TFormMain
  Left = 576
  Top = 347
  Width = 704
  Height = 425
  Caption = 'gBackup v0.10'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Menu = MainMenu
  OldCreateOrder = False
  WindowState = wsMaximized
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 536
    Top = 0
    Width = 160
    Height = 360
    Align = alRight
    TabOrder = 0
    object btnStartBackup: TButton
      Left = 8
      Top = 8
      Width = 145
      Height = 25
      Caption = 'Starte Backup...'
      TabOrder = 0
      OnClick = btnStartBackupClick
    end
  end
  object Viewport: TVirtualStringTree
    Left = 0
    Top = 0
    Width = 536
    Height = 360
    Align = alClient
    Header.AutoSizeIndex = 0
    Header.Font.Charset = DEFAULT_CHARSET
    Header.Font.Color = clWindowText
    Header.Font.Height = -11
    Header.Font.Name = 'MS Sans Serif'
    Header.Font.Style = []
    Header.Options = [hoColumnResize, hoDrag, hoVisible]
    Indent = 0
    TabOrder = 1
    TreeOptions.PaintOptions = [toHideFocusRect, toShowButtons, toShowDropmark, toShowRoot, toThemeAware, toUseBlendedImages]
    TreeOptions.SelectionOptions = [toFullRowSelect]
    OnGetText = ViewportGetText
    Columns = <
      item
        Position = 0
        WideText = 'Name'
      end
      item
        Position = 1
        WideText = 'Quellen'
      end
      item
        Position = 2
        WideText = 'Ziel'
      end
      item
        Position = 3
        WideText = 'Zuletzt ausgef'#252'hrt'
      end>
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 360
    Width = 696
    Height = 19
    Panels = <>
  end
  object MainMenu: TMainMenu
    Left = 8
    Top = 24
    object Datei1: TMenuItem
      Caption = '&Datei'
      object NeueAufgabe1: TMenuItem
        Caption = 'Neue Aufgabe'
        OnClick = NeueAufgabe1Click
      end
      object Aufgabendern1: TMenuItem
        Caption = 'Aufgabe '#228'ndern...'
      end
      object Aufgabelschen1: TMenuItem
        Caption = 'Aufgabe l'#246'schen...'
      end
      object N2: TMenuItem
        Caption = '-'
      end
      object Optionen1: TMenuItem
        Caption = 'Optionen'
      end
      object N1: TMenuItem
        Caption = '-'
      end
      object Beenden1: TMenuItem
        Caption = 'B&eenden'
        OnClick = Beenden1Click
      end
    end
    object Hilfe1: TMenuItem
      Caption = '&Hilfe'
      object Inhalt1: TMenuItem
        Caption = 'Inhalt'
        ShortCut = 112
      end
      object N3: TMenuItem
        Caption = '-'
      end
      object ber1: TMenuItem
        Caption = #220'ber...'
      end
    end
  end
end
