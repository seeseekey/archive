object mainform: Tmainform
  Left = 0
  Top = 1
  Width = 800
  Height = 574
  Caption = 'Movie Disc Administration V1.00'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Menu = mainmenu
  OldCreateOrder = False
  WindowState = wsMaximized
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object leftpanel: TPanel
    Left = 0
    Top = 0
    Width = 377
    Height = 528
    Align = alLeft
    BevelOuter = bvNone
    TabOrder = 0
    object printfield: TRichEdit
      Left = 0
      Top = 0
      Width = 377
      Height = 408
      Align = alClient
      TabOrder = 2
    end
    object leftsubpanel: TPanel
      Left = 0
      Top = 408
      Width = 377
      Height = 120
      Align = alBottom
      TabOrder = 0
      object datacount: TLabel
        Left = 8
        Top = 96
        Width = 119
        Height = 13
        Caption = 'Anzahl der Datens'#228'tze: 0'
      end
      object mainedit: TEdit
        Left = 8
        Top = 8
        Width = 361
        Height = 21
        TabOrder = 0
        OnChange = maineditChange
        OnKeyDown = maineditKeyDown
      end
      object mainnewbutton: TButton
        Left = 288
        Top = 32
        Width = 81
        Height = 25
        Caption = 'Neu'
        TabOrder = 3
        OnClick = mainnewbuttonClick
      end
      object maineditbutton: TButton
        Left = 208
        Top = 32
        Width = 75
        Height = 25
        Caption = 'Bearbeiten'
        TabOrder = 2
        OnClick = maineditbuttonClick
      end
      object mainsearchbutton: TButton
        Left = 8
        Top = 64
        Width = 361
        Height = 25
        Caption = 'Suchen'
        TabOrder = 4
        OnClick = mainsearchbuttonClick
      end
      object maindeletebutton: TButton
        Left = 8
        Top = 32
        Width = 75
        Height = 25
        Caption = 'L'#246'schen'
        TabOrder = 1
        OnClick = maindeletebuttonClick
      end
    end
    object mainlistbox: TGT_ListValueBox
      Left = 0
      Top = 0
      Width = 377
      Height = 408
      Align = alClient
      ItemHeight = 13
      TabOrder = 1
      OnClick = mainlistboxClick
      OnKeyDown = mainlistboxKeyDown
    end
  end
  object rightpanel: TPanel
    Left = 377
    Top = 0
    Width = 415
    Height = 528
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 1
    object infofield00: TRichEdit
      Left = 9
      Top = 0
      Width = 406
      Height = 528
      Align = alClient
      BorderStyle = bsNone
      Color = clBtnFace
      ReadOnly = True
      ScrollBars = ssVertical
      TabOrder = 0
    end
    object platzhalter: TPanel
      Left = 0
      Top = 0
      Width = 9
      Height = 528
      Align = alLeft
      BevelOuter = bvNone
      TabOrder = 1
    end
  end
  object mainmenu: TMainMenu
    Left = 8
    Top = 8
    object Datei1: TMenuItem
      Caption = '&Datei'
      object NeuerDatensatz1: TMenuItem
        Caption = '&Neuer Datensatz...'
        OnClick = NeuerDatensatz1Click
      end
      object N7: TMenuItem
        Caption = '-'
      end
      object Datensatzbearbeiten1: TMenuItem
        Caption = 'Datensatz &bearbeiten...'
        OnClick = Datensatzbearbeiten1Click
      end
      object Datensatzlschen1: TMenuItem
        Caption = 'Datensatz &l'#246'schen...'
        OnClick = Datensatzlschen1Click
      end
      object N2: TMenuItem
        Caption = '-'
      end
      object Suchen1: TMenuItem
        Caption = '&Suchen'
        ShortCut = 16454
        OnClick = Suchen1Click
      end
      object N1: TMenuItem
        Caption = '-'
      end
      object Extras1: TMenuItem
        Caption = 'Extras'
        object Listeinlistetxtspeichern1: TMenuItem
          Caption = 'Liste in liste.txt speichern'
          OnClick = Listeinlistetxtspeichern1Click
        end
      end
      object N4: TMenuItem
        Caption = '-'
      end
      object Beenden1: TMenuItem
        Caption = 'B&eenden'
        OnClick = Beenden1Click
      end
    end
  end
  object maintimer: TTimer
    Interval = 500
    OnTimer = maintimerTimer
    Left = 40
    Top = 8
  end
end
