object FormDefine: TFormDefine
  Left = 192
  Top = 125
  BorderStyle = bsDialog
  Caption = 'Optionen...'
  ClientHeight = 328
  ClientWidth = 603
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object GroupBox1: TGroupBox
    Left = 8
    Top = 8
    Width = 585
    Height = 169
    Caption = 'Zeiten definieren'
    TabOrder = 0
    object Label1: TLabel
      Left = 8
      Top = 16
      Width = 31
      Height = 13
      Caption = 'Name:'
    end
    object Label2: TLabel
      Left = 208
      Top = 16
      Width = 34
      Height = 13
      Caption = 'Datum:'
    end
    object Label3: TLabel
      Left = 336
      Top = 16
      Width = 37
      Height = 13
      Caption = 'Stunde:'
    end
    object Label4: TLabel
      Left = 400
      Top = 16
      Width = 35
      Height = 13
      Caption = 'Minute:'
    end
    object Label5: TLabel
      Left = 464
      Top = 16
      Width = 46
      Height = 13
      Caption = 'Sekunde:'
    end
    object Label6: TLabel
      Left = 528
      Top = 16
      Width = 41
      Height = 13
      Caption = 'Aktiviert:'
    end
    object a1Stunde: TSpinEdit
      Left = 336
      Top = 32
      Width = 57
      Height = 22
      Enabled = False
      MaxValue = 23
      MinValue = 0
      TabOrder = 0
      Value = 0
    end
    object a1Date: TJvDateEdit
      Left = 208
      Top = 32
      Width = 121
      Height = 21
      TabOrder = 1
    end
    object a1Minute: TSpinEdit
      Left = 400
      Top = 32
      Width = 57
      Height = 22
      Enabled = False
      MaxValue = 59
      MinValue = 0
      TabOrder = 2
      Value = 0
    end
    object a1Sekunde: TSpinEdit
      Left = 464
      Top = 32
      Width = 57
      Height = 22
      Enabled = False
      MaxValue = 59
      MinValue = 0
      TabOrder = 3
      Value = 0
    end
    object a1Name: TEdit
      Left = 8
      Top = 32
      Width = 193
      Height = 21
      TabOrder = 4
    end
    object a1a: TCheckBox
      Left = 528
      Top = 32
      Width = 50
      Height = 17
      Caption = 'Aktiv'
      TabOrder = 5
    end
    object a2a: TCheckBox
      Left = 528
      Top = 56
      Width = 50
      Height = 17
      Caption = 'Aktiv'
      TabOrder = 6
    end
    object a3a: TCheckBox
      Left = 528
      Top = 80
      Width = 50
      Height = 17
      Caption = 'Aktiv'
      TabOrder = 7
    end
    object a4a: TCheckBox
      Left = 528
      Top = 104
      Width = 50
      Height = 17
      Caption = 'Aktiv'
      TabOrder = 8
    end
    object a5a: TCheckBox
      Left = 528
      Top = 128
      Width = 50
      Height = 17
      Caption = 'Aktiv'
      TabOrder = 9
    end
  end
  object a2Name: TEdit
    Left = 16
    Top = 64
    Width = 193
    Height = 21
    TabOrder = 1
  end
  object a2Date: TJvDateEdit
    Left = 216
    Top = 64
    Width = 121
    Height = 21
    TabOrder = 2
  end
  object a2Stunde: TSpinEdit
    Left = 344
    Top = 64
    Width = 57
    Height = 22
    Enabled = False
    MaxValue = 23
    MinValue = 0
    TabOrder = 3
    Value = 0
  end
  object a2Minute: TSpinEdit
    Left = 408
    Top = 64
    Width = 57
    Height = 22
    Enabled = False
    MaxValue = 59
    MinValue = 0
    TabOrder = 4
    Value = 0
  end
  object a2Sekunde: TSpinEdit
    Left = 472
    Top = 64
    Width = 57
    Height = 22
    Enabled = False
    MaxValue = 59
    MinValue = 0
    TabOrder = 5
    Value = 0
  end
  object a3Name: TEdit
    Left = 16
    Top = 88
    Width = 193
    Height = 21
    TabOrder = 6
  end
  object a3Date: TJvDateEdit
    Left = 216
    Top = 88
    Width = 121
    Height = 21
    TabOrder = 7
  end
  object a3Stunde: TSpinEdit
    Left = 344
    Top = 88
    Width = 57
    Height = 22
    Enabled = False
    MaxValue = 23
    MinValue = 0
    TabOrder = 8
    Value = 0
  end
  object a3Minute: TSpinEdit
    Left = 408
    Top = 88
    Width = 57
    Height = 22
    Enabled = False
    MaxValue = 59
    MinValue = 0
    TabOrder = 9
    Value = 0
  end
  object a3Sekunde: TSpinEdit
    Left = 472
    Top = 88
    Width = 57
    Height = 22
    Enabled = False
    MaxValue = 59
    MinValue = 0
    TabOrder = 10
    Value = 0
  end
  object a4Name: TEdit
    Left = 16
    Top = 112
    Width = 193
    Height = 21
    TabOrder = 11
  end
  object a4Date: TJvDateEdit
    Left = 216
    Top = 112
    Width = 121
    Height = 21
    TabOrder = 12
  end
  object a4Stunde: TSpinEdit
    Left = 344
    Top = 112
    Width = 57
    Height = 22
    Enabled = False
    MaxValue = 23
    MinValue = 0
    TabOrder = 13
    Value = 0
  end
  object a4Minute: TSpinEdit
    Left = 408
    Top = 112
    Width = 57
    Height = 22
    Enabled = False
    MaxValue = 59
    MinValue = 0
    TabOrder = 14
    Value = 0
  end
  object a4Sekunde: TSpinEdit
    Left = 472
    Top = 112
    Width = 57
    Height = 22
    Enabled = False
    MaxValue = 59
    MinValue = 0
    TabOrder = 15
    Value = 0
  end
  object a5Name: TEdit
    Left = 16
    Top = 136
    Width = 193
    Height = 21
    TabOrder = 16
  end
  object a5Date: TJvDateEdit
    Left = 216
    Top = 136
    Width = 121
    Height = 21
    TabOrder = 17
  end
  object a5stunde: TSpinEdit
    Left = 344
    Top = 136
    Width = 57
    Height = 22
    Enabled = False
    MaxValue = 23
    MinValue = 0
    TabOrder = 18
    Value = 0
  end
  object a5Minute: TSpinEdit
    Left = 408
    Top = 136
    Width = 57
    Height = 22
    Enabled = False
    MaxValue = 59
    MinValue = 0
    TabOrder = 19
    Value = 0
  end
  object a5Sekunde: TSpinEdit
    Left = 472
    Top = 136
    Width = 57
    Height = 22
    Enabled = False
    MaxValue = 59
    MinValue = 0
    TabOrder = 20
    Value = 0
  end
  object GroupBox2: TGroupBox
    Left = 8
    Top = 184
    Width = 585
    Height = 49
    Caption = 'Zeitserver'
    TabOrder = 21
    object TimeServer: TEdit
      Left = 8
      Top = 16
      Width = 569
      Height = 21
      TabOrder = 0
      Text = 'ptbtime1.ptb.de'
    end
  end
  object Button1: TButton
    Left = 520
    Top = 296
    Width = 75
    Height = 25
    Caption = 'Abbrechen'
    TabOrder = 22
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 440
    Top = 296
    Width = 75
    Height = 25
    Caption = 'O&K'
    TabOrder = 23
    OnClick = Button2Click
  end
  object GroupBox3: TGroupBox
    Left = 8
    Top = 240
    Width = 585
    Height = 49
    Caption = 'Sonstiges'
    TabOrder = 24
    object downpeak: TCheckBox
      Left = 8
      Top = 24
      Width = 569
      Height = 17
      Caption = 'Beim Herunterfahren, Zeit auf aktuelle Zeit stellen'
      TabOrder = 0
    end
  end
end
