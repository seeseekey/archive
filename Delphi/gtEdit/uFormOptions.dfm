object FormOptions: TFormOptions
  Left = 192
  Top = 103
  BorderStyle = bsDialog
  Caption = 'Optionen'
  ClientHeight = 313
  ClientWidth = 717
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object PageControl1: TPageControl
    Left = 0
    Top = 0
    Width = 717
    Height = 273
    ActivePage = TabSheet3
    Align = alTop
    TabOrder = 0
    object TabSheet3: TTabSheet
      Caption = 'Anwendung'
      ImageIndex = 2
      object cbInTrayMinimize: TCheckBox
        Left = 8
        Top = 8
        Width = 257
        Height = 17
        Caption = 'Anwendung in den Tray minimieren'
        TabOrder = 0
      end
      object cbAnwendungBeimStartMaximieren: TCheckBox
        Left = 8
        Top = 32
        Width = 225
        Height = 17
        Caption = 'Anwendung beim Start maximieren'
        TabOrder = 1
        OnClick = cbAnwendungBeimStartMaximierenClick
      end
      object cbLastWindowSettings: TCheckBox
        Left = 8
        Top = 56
        Width = 289
        Height = 17
        Caption = 'Letze Fenstergr'#246#223'e und Position wiederherstellen'
        TabOrder = 2
        OnClick = cbLastWindowSettingsClick
      end
    end
    object TabSheet1: TTabSheet
      Caption = 'Editor'
      object Label1: TLabel
        Left = 352
        Top = 8
        Width = 101
        Height = 13
        Caption = 'Leerzeichen pro Tab:'
      end
      object cbZeilennummer: TCheckBox
        Left = 16
        Top = 80
        Width = 145
        Height = 17
        Caption = 'Zeilennummern anzeigen'
        TabOrder = 0
      end
      object cbZeilenmarker: TCheckBox
        Left = 16
        Top = 56
        Width = 153
        Height = 17
        Caption = 'Aktuelle Zeile markieren'
        TabOrder = 1
      end
      object cbLineal: TCheckBox
        Left = 8
        Top = 224
        Width = 105
        Height = 17
        Caption = 'Lineal anzeigen'
        TabOrder = 2
        Visible = False
      end
      object cbAutoHighlighter: TCheckBox
        Left = 8
        Top = 128
        Width = 321
        Height = 17
        Caption = 'Automatisch passenden Highlighter zur Dateiendung laden'
        TabOrder = 3
      end
      object cbWordWrap: TCheckBox
        Left = 16
        Top = 32
        Width = 321
        Height = 17
        Caption = 'WordWrap anzeigen'
        TabOrder = 4
      end
      object seTabSpaces: TSpinEdit
        Left = 352
        Top = 24
        Width = 353
        Height = 22
        MaxValue = 128
        MinValue = 1
        TabOrder = 5
        Value = 8
      end
      object cbLastConfigSave: TCheckBox
        Left = 8
        Top = 8
        Width = 241
        Height = 17
        Caption = 'Letze Einstellungen automatisch speichern...'
        TabOrder = 6
      end
    end
    object TabSheet2: TTabSheet
      Caption = 'Integration'
      ImageIndex = 1
      object cbIntegration: TCheckBox
        Left = 8
        Top = 8
        Width = 185
        Height = 17
        Caption = 'Integration in Shell'
        TabOrder = 0
      end
    end
  end
  object Button1: TButton
    Left = 640
    Top = 280
    Width = 75
    Height = 25
    Cancel = True
    Caption = 'Abbrechen'
    TabOrder = 1
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 560
    Top = 280
    Width = 75
    Height = 25
    Caption = 'OK'
    Default = True
    TabOrder = 2
    OnClick = Button2Click
  end
end
