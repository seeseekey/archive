object FormOptions: TFormOptions
  Left = 349
  Top = 255
  BorderStyle = bsDialog
  Caption = 'Optionen'
  ClientHeight = 172
  ClientWidth = 388
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object tabcontrol: TPageControl
    Left = 0
    Top = 0
    Width = 388
    Height = 137
    ActivePage = Audio
    Align = alTop
    TabOrder = 0
    object Audio: TTabSheet
      Caption = 'Audio'
      object Label2: TLabel
        Left = 8
        Top = 40
        Width = 53
        Height = 13
        Caption = 'Lautst'#228'rke:'
      end
      object backgroundmusic: TCheckBox
        Left = 8
        Top = 16
        Width = 169
        Height = 17
        Caption = 'Hintergrundmusik aktiveren'
        TabOrder = 0
      end
      object SoundLevel: TTrackBar
        Left = 4
        Top = 58
        Width = 369
        Height = 22
        Max = 10000
        Frequency = 1000
        TabOrder = 1
        OnChange = SoundLevelChange
      end
    end
    object system: TTabSheet
      Caption = 'System'
      ImageIndex = 1
      object doublebuffer: TCheckBox
        Left = 8
        Top = 16
        Width = 289
        Height = 17
        Caption = 'Double Buffer deaktivieren (nur f'#252'r langsame Rechner)'
        TabOrder = 0
      end
    end
  end
  object cancel: TButton
    Left = 312
    Top = 144
    Width = 75
    Height = 23
    Caption = '&Abbrechen'
    TabOrder = 1
    OnClick = cancelClick
  end
  object okay: TButton
    Left = 234
    Top = 144
    Width = 75
    Height = 23
    Caption = 'O&K'
    TabOrder = 2
    OnClick = okayClick
  end
end
