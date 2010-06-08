object createkontoform: Tcreatekontoform
  Left = 198
  Top = 107
  BorderStyle = bsDialog
  Caption = 'Neues Konto anlegen...'
  ClientHeight = 301
  ClientWidth = 535
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  OnPaint = FormPaint
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 8
    Width = 57
    Height = 13
    Caption = 'Kontoname:'
  end
  object Label2: TLabel
    Left = 272
    Top = 8
    Width = 85
    Height = 13
    Caption = 'Absenderadresse:'
  end
  object kontoname: TEdit
    Left = 8
    Top = 24
    Width = 257
    Height = 21
    TabOrder = 0
  end
  object abs: TEdit
    Left = 272
    Top = 24
    Width = 257
    Height = 21
    TabOrder = 1
  end
  object GroupBox1: TGroupBox
    Left = 8
    Top = 56
    Width = 521
    Height = 209
    Caption = ' SMTP Server Daten: '
    TabOrder = 2
    object Label3: TLabel
      Left = 8
      Top = 16
      Width = 67
      Height = 13
      Caption = 'SMTP Server:'
    end
    object Label4: TLabel
      Left = 8
      Top = 112
      Width = 71
      Height = 13
      Caption = 'Benutzername:'
    end
    object Label5: TLabel
      Left = 8
      Top = 160
      Width = 46
      Height = 13
      Caption = 'Passwort:'
    end
    object Label6: TLabel
      Left = 8
      Top = 64
      Width = 125
      Height = 13
      Caption = 'SMTP Port (Standard: 25):'
    end
    object smtpserver: TEdit
      Left = 8
      Top = 32
      Width = 505
      Height = 21
      TabOrder = 0
    end
    object benutzername: TEdit
      Left = 8
      Top = 128
      Width = 505
      Height = 21
      TabOrder = 2
    end
    object passwort: TEdit
      Left = 8
      Top = 176
      Width = 505
      Height = 21
      PasswordChar = '*'
      TabOrder = 3
    end
    object smtpport: TEdit
      Left = 8
      Top = 80
      Width = 505
      Height = 21
      TabOrder = 1
    end
  end
  object Button1: TButton
    Left = 456
    Top = 272
    Width = 75
    Height = 25
    Caption = 'O&K'
    TabOrder = 3
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 376
    Top = 272
    Width = 75
    Height = 25
    Caption = '&Abbrechen'
    TabOrder = 4
    OnClick = Button2Click
  end
end
