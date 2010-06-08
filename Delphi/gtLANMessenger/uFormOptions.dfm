object FormOptions: TFormOptions
  Left = 222
  Top = 138
  BorderStyle = bsDialog
  Caption = 'Optionen'
  ClientHeight = 257
  ClientWidth = 433
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
  object PageControl: TPageControl
    Left = 0
    Top = 0
    Width = 433
    Height = 217
    ActivePage = TabSheet2
    Align = alTop
    TabOrder = 0
    object TabSheet2: TTabSheet
      Caption = 'Anwendung'
      ImageIndex = 1
      object cbNormalSizeAndPosition: TCheckBox
        Left = 8
        Top = 8
        Width = 385
        Height = 17
        Caption = 'Anwendung beim Start rechts unten positionieren (Standardgr'#246#223'e)'
        TabOrder = 0
      end
      object CheckBox1: TCheckBox
        Left = 8
        Top = 32
        Width = 97
        Height = 17
        Caption = 'CheckBox1'
        TabOrder = 1
      end
    end
    object TabSheet3: TTabSheet
      Caption = 'Nachrichtenfenster'
      ImageIndex = 2
      object rgTkSend: TRadioGroup
        Left = 0
        Top = 0
        Width = 425
        Height = 121
        Caption = 'Tastenkombination zum Senden'
        Items.Strings = (
          'Enter'
          'Strg + Enter'
          'Alt + S'
          'Strg + Alt')
        TabOrder = 0
      end
    end
    object TabSheet1: TTabSheet
      Caption = 'Profil'
      object Label1: TLabel
        Left = 8
        Top = 8
        Width = 31
        Height = 13
        Caption = 'Name:'
      end
      object name: TEdit
        Left = 8
        Top = 24
        Width = 409
        Height = 21
        TabOrder = 0
      end
    end
  end
  object okay: TButton
    Left = 272
    Top = 224
    Width = 75
    Height = 25
    Caption = 'OK'
    Default = True
    TabOrder = 1
    OnClick = okayClick
  end
  object abbrechen: TButton
    Left = 352
    Top = 224
    Width = 75
    Height = 25
    Cancel = True
    Caption = 'Abbrechen'
    TabOrder = 2
    OnClick = abbrechenClick
  end
end
