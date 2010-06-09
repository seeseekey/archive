object FormFeatureNewEdit: TFormFeatureNewEdit
  Left = 192
  Top = 103
  BorderStyle = bsDialog
  Caption = 'Neuer Bug'
  ClientHeight = 370
  ClientWidth = 639
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 240
    Width = 38
    Height = 13
    Caption = 'Priorit'#228't:'
  end
  object Label3: TLabel
    Left = 8
    Top = 288
    Width = 33
    Height = 13
    Caption = 'Status:'
  end
  object Label4: TLabel
    Left = 8
    Top = 8
    Width = 92
    Height = 13
    Caption = 'Zusammenfassung:'
  end
  object Label5: TLabel
    Left = 8
    Top = 56
    Width = 68
    Height = 13
    Caption = 'Beschreibung:'
  end
  object edPriority: TComboBox
    Left = 8
    Top = 256
    Width = 625
    Height = 21
    Style = csDropDownList
    ItemHeight = 13
    ItemIndex = 2
    TabOrder = 2
    Text = 'normal'
    Items.Strings = (
      'sehr niedrig'
      'niedrig'
      'normal'
      'hoch'
      'sehr hoch')
  end
  object edState: TComboBox
    Left = 8
    Top = 304
    Width = 625
    Height = 21
    Style = csDropDownList
    ItemHeight = 13
    ItemIndex = 0
    TabOrder = 3
    Text = 'neu'
    Items.Strings = (
      'neu'
      'R'#252'ckmeldung'
      'anerkannt'
      'best'#228'tigt'
      'zugewiesen'
      'geschlossen')
  end
  object edSummary: TEdit
    Left = 8
    Top = 24
    Width = 625
    Height = 21
    TabOrder = 0
  end
  object edDescription: TMemo
    Left = 8
    Top = 72
    Width = 625
    Height = 161
    ScrollBars = ssVertical
    TabOrder = 1
  end
  object Button1: TButton
    Left = 480
    Top = 336
    Width = 75
    Height = 25
    Caption = 'OK'
    TabOrder = 4
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 560
    Top = 336
    Width = 75
    Height = 25
    Caption = 'Abbrechen'
    TabOrder = 5
    OnClick = Button2Click
  end
end
