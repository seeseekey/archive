object FormProjectNewEdit: TFormProjectNewEdit
  Left = 192
  Top = 103
  BorderStyle = bsDialog
  Caption = 'FormProjectNewEdit'
  ClientHeight = 302
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
    Top = 8
    Width = 62
    Height = 13
    Caption = 'Projektname:'
  end
  object Label2: TLabel
    Left = 8
    Top = 56
    Width = 65
    Height = 13
    Caption = 'Beschreibung'
  end
  object Label3: TLabel
    Left = 8
    Top = 224
    Width = 99
    Height = 13
    Caption = 'Programmiersprache:'
  end
  object edProjectName: TEdit
    Left = 8
    Top = 24
    Width = 625
    Height = 21
    TabOrder = 0
  end
  object mmDescription: TMemo
    Left = 8
    Top = 72
    Width = 625
    Height = 137
    TabOrder = 1
  end
  object edLanguage: TEdit
    Left = 8
    Top = 240
    Width = 625
    Height = 21
    TabOrder = 2
  end
  object Button1: TButton
    Left = 560
    Top = 272
    Width = 75
    Height = 25
    Caption = 'Abbrechen'
    TabOrder = 3
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 480
    Top = 272
    Width = 75
    Height = 25
    Caption = 'OK'
    TabOrder = 4
    OnClick = Button2Click
  end
end
