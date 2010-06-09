object FormMain: TFormMain
  Left = -4
  Top = -4
  Width = 1288
  Height = 780
  Caption = 'Missle Attack v1.00'
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
  object Viewport: TImage
    Left = 0
    Top = 0
    Width = 1047
    Height = 734
    Align = alClient
  end
  object Panel1: TPanel
    Left = 1047
    Top = 0
    Width = 233
    Height = 734
    Align = alRight
    TabOrder = 0
    object LabelPanzerungRotold: TLabel
      Left = 8
      Top = 16
      Width = 24
      Height = 13
      Caption = 'Blau:'
    end
    object Rot: TLabel
      Left = 8
      Top = 56
      Width = 17
      Height = 13
      Caption = 'Rot'
    end
    object LabelWinkel: TLabel
      Left = 8
      Top = 104
      Width = 59
      Height = 13
      Caption = 'LabelWinkel'
    end
    object LabelGeschwindigkeit: TLabel
      Left = 8
      Top = 168
      Width = 104
      Height = 13
      Caption = 'LabelGeschwindigkeit'
    end
    object LabelWind: TLabel
      Left = 8
      Top = 240
      Width = 51
      Height = 13
      Caption = 'LabelWind'
    end
    object Label1: TLabel
      Left = 8
      Top = 352
      Width = 32
      Height = 13
      Caption = 'Waffe:'
    end
    object TrackbarWinkel: TTrackBar
      Left = 8
      Top = 120
      Width = 217
      Height = 45
      Max = 180
      Frequency = 2
      TabOrder = 0
      TickMarks = tmBoth
      TickStyle = tsManual
      OnChange = TrackbarWinkelChange
    end
    object TrackbarGeschwindigkeit: TTrackBar
      Left = 8
      Top = 184
      Width = 217
      Height = 45
      Max = 100
      Frequency = 2
      TabOrder = 1
      TickMarks = tmBoth
      TickStyle = tsManual
      OnChange = TrackbarGeschwindigkeitChange
    end
    object ButtonFeuer: TButton
      Left = 8
      Top = 288
      Width = 217
      Height = 49
      Caption = 'Feuer'
      TabOrder = 2
      OnClick = ButtonFeuerClick
    end
    object ControlbarWind: TControlBar
      Left = 8
      Top = 256
      Width = 217
      Height = 20
      BevelKind = bkFlat
      TabOrder = 3
    end
    object LabelPanzerungRot: TProgressBar
      Left = 8
      Top = 32
      Width = 217
      Height = 16
      TabOrder = 4
    end
    object LabelPanzerungBlau: TProgressBar
      Left = 8
      Top = 72
      Width = 217
      Height = 16
      TabOrder = 5
    end
    object BitBtn1: TBitBtn
      Left = 8
      Top = 368
      Width = 50
      Height = 50
      Caption = 'Normal'
      TabOrder = 6
      OnClick = BitBtn1Click
    end
    object BitBtn2: TBitBtn
      Left = 64
      Top = 368
      Width = 50
      Height = 50
      Caption = 'Gut'
      TabOrder = 7
      OnClick = BitBtn2Click
    end
    object BitBtn3: TBitBtn
      Left = 120
      Top = 368
      Width = 50
      Height = 50
      Caption = 'Heavy'
      TabOrder = 8
      OnClick = BitBtn3Click
    end
    object BitBtn4: TBitBtn
      Left = 176
      Top = 368
      Width = 50
      Height = 50
      Caption = 'XTREME'
      TabOrder = 9
      OnClick = BitBtn4Click
    end
  end
  object MainMenu: TMainMenu
    Left = 8
    Top = 8
    object datei1: TMenuItem
      Caption = '&Datei'
      object NeuesSpiel1: TMenuItem
        Caption = '&Neues Spiel'
      end
      object N3: TMenuItem
        Caption = '-'
      end
      object Highscore1: TMenuItem
        Caption = 'Highscore'
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
      object Hilfe2: TMenuItem
        Caption = '&Inhalt'
      end
      object N2: TMenuItem
        Caption = '-'
      end
      object ber1: TMenuItem
        Caption = #220'&ber...'
        OnClick = ber1Click
      end
    end
  end
  object TimerFlugbahn: TTimer
    Enabled = False
    Interval = 30
    OnTimer = TimerFlugbahnTimer
    Left = 40
    Top = 8
  end
  object TimerExplosion: TTimer
    Enabled = False
    Interval = 20
    OnTimer = TimerExplosionTimer
    Left = 72
    Top = 8
  end
end
