object FormGameNew: TFormGameNew
  Left = 260
  Top = 218
  BorderStyle = bsDialog
  Caption = 'Neues Spiel'
  ClientHeight = 247
  ClientWidth = 495
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnCreate = FormCreate
  OnPaint = FormPaint
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 0
    Top = 112
    Width = 92
    Height = 13
    Caption = 'Computer Spieler 1:'
  end
  object Label2: TLabel
    Left = 248
    Top = 112
    Width = 92
    Height = 13
    Caption = 'Computer Spieler 2:'
  end
  object RadioGroup1: TRadioGroup
    Left = 0
    Top = 0
    Width = 489
    Height = 105
    Caption = ' Spielmodus '
    TabOrder = 0
  end
  object mode1: TRadioButton
    Left = 8
    Top = 16
    Width = 113
    Height = 17
    Caption = 'Spieler vs. Spieler'
    Checked = True
    TabOrder = 1
    TabStop = True
    OnClick = mode1Click
  end
  object mode2: TRadioButton
    Left = 8
    Top = 32
    Width = 209
    Height = 17
    Caption = 'Spieler vs. Computer (Spieler beginnt)'
    TabOrder = 2
    OnClick = mode2Click
  end
  object mode4: TRadioButton
    Left = 8
    Top = 64
    Width = 169
    Height = 17
    Caption = 'Computer vs. Computer'
    TabOrder = 4
    OnClick = mode4Click
  end
  object GroupBox1: TGroupBox
    Left = 0
    Top = 152
    Width = 241
    Height = 57
    Caption = ' Informationen '
    TabOrder = 7
    object ai1level: TLabel
      Left = 8
      Top = 16
      Width = 93
      Height = 13
      Caption = 'Schwierigkeitslevel:'
    end
    object aip1mb: TButton
      Left = 8
      Top = 32
      Width = 225
      Height = 17
      Caption = 'Mehr...'
      TabOrder = 0
      OnClick = aip1mbClick
    end
  end
  object GroupBox2: TGroupBox
    Left = 248
    Top = 152
    Width = 241
    Height = 57
    Caption = ' Informationen '
    TabOrder = 8
    object ai2level: TLabel
      Left = 8
      Top = 16
      Width = 93
      Height = 13
      Caption = 'Schwierigkeitslevel:'
    end
    object aip2mb: TButton
      Left = 8
      Top = 32
      Width = 225
      Height = 17
      Caption = 'Mehr...'
      TabOrder = 0
      OnClick = aip2mbClick
    end
  end
  object confirm: TButton
    Left = 416
    Top = 216
    Width = 75
    Height = 25
    Caption = 'O&K'
    TabOrder = 10
    OnClick = confirmClick
  end
  object cancel: TButton
    Left = 336
    Top = 216
    Width = 75
    Height = 25
    Caption = '&Abbrechen'
    TabOrder = 9
    OnClick = cancelClick
  end
  object aip1: TGT_ComboValueBox
    Left = 0
    Top = 128
    Width = 241
    Height = 21
    Style = csDropDownList
    ItemHeight = 13
    TabOrder = 5
  end
  object aip2: TGT_ComboValueBox
    Left = 248
    Top = 128
    Width = 241
    Height = 21
    Style = csDropDownList
    ItemHeight = 13
    TabOrder = 6
  end
  object mode3: TRadioButton
    Left = 8
    Top = 48
    Width = 217
    Height = 17
    Caption = 'Spieler vs. Computer (Computer beginnt)'
    TabOrder = 3
    OnClick = mode3Click
  end
  object mode5: TRadioButton
    Left = 8
    Top = 80
    Width = 153
    Height = 17
    Caption = 'Spieler vs. Spieler '#252'ber LAN'
    TabOrder = 11
    OnClick = mode5Click
  end
end
