object childform01: Tchildform01
  Left = 182
  Top = 97
  HorzScrollBar.Visible = False
  VertScrollBar.Visible = False
  BorderStyle = bsDialog
  Caption = 'Datensatz bearbeiten...'
  ClientHeight = 349
  ClientWidth = 536
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poMainFormCenter
  OnClose = FormClose
  OnKeyDown = FormKeyDown
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Label25: TLabel
    Left = 16
    Top = 184
    Width = 34
    Height = 13
    Caption = 'Straﬂe:'
  end
  object Label26: TLabel
    Left = 16
    Top = 160
    Width = 114
    Height = 13
    Caption = 'Adresse Hauptwohnsitz:'
  end
  object Label27: TLabel
    Left = 144
    Top = 184
    Width = 56
    Height = 13
    Caption = 'Postleitzahl:'
  end
  object Label29: TLabel
    Left = 272
    Top = 184
    Width = 17
    Height = 13
    Caption = 'Ort:'
  end
  object panel: TPanel
    Left = 0
    Top = 0
    Width = 536
    Height = 313
    Align = alTop
    TabOrder = 0
    object Label1: TLabel
      Left = 8
      Top = 8
      Width = 47
      Height = 13
      Caption = 'Filmname:'
    end
    object Label2: TLabel
      Left = 8
      Top = 56
      Width = 33
      Height = 13
      Caption = 'L‰nge:'
    end
    object Label3: TLabel
      Left = 8
      Top = 104
      Width = 43
      Height = 13
      Caption = 'Sprache:'
    end
    object Label4: TLabel
      Left = 8
      Top = 152
      Width = 56
      Height = 13
      Caption = 'Movie Disc:'
    end
    object Label5: TLabel
      Left = 8
      Top = 200
      Width = 29
      Height = 13
      Caption = 'Inhalt:'
    end
    object filmname: TEdit
      Left = 8
      Top = 24
      Width = 521
      Height = 21
      TabOrder = 0
    end
    object laenge: TEdit
      Left = 8
      Top = 72
      Width = 521
      Height = 21
      TabOrder = 1
    end
    object inhalt: TMemo
      Left = 8
      Top = 216
      Width = 521
      Height = 89
      ScrollBars = ssVertical
      TabOrder = 4
    end
    object sprache: TComboBox
      Left = 8
      Top = 120
      Width = 521
      Height = 21
      ItemHeight = 13
      TabOrder = 2
      Items.Strings = (
        'Deutsch'
        'Englisch'
        'Japanisch')
    end
    object md: TComboBox
      Left = 8
      Top = 168
      Width = 521
      Height = 21
      ItemHeight = 13
      TabOrder = 3
      Items.Strings = (
        '0003'
        '0004'
        '0005'
        '0006'
        '0007'
        '0008'
        '0009'
        '0010'
        '0011'
        '0012'
        '0013'
        '0014'
        '0015')
    end
  end
  object OK: TButton
    Left = 456
    Top = 320
    Width = 75
    Height = 25
    Caption = 'OK'
    TabOrder = 1
    OnClick = OKClick
  end
  object cancel: TButton
    Left = 376
    Top = 320
    Width = 75
    Height = 25
    Caption = 'Abbrechen'
    TabOrder = 2
    OnClick = cancelClick
  end
end
