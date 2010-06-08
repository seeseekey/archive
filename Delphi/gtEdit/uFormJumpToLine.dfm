object FormJumpToLine: TFormJumpToLine
  Left = 192
  Top = 103
  BorderStyle = bsDialog
  Caption = 'Gehe zu Zeile'
  ClientHeight = 89
  ClientWidth = 289
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poScreenCenter
  OnKeyDown = FormKeyDown
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 8
    Width = 69
    Height = 13
    Caption = 'Gehe zu Zeile:'
  end
  object seLine: TSpinEdit
    Left = 8
    Top = 24
    Width = 273
    Height = 22
    MaxValue = 1000000000
    MinValue = 1
    TabOrder = 0
    Value = 1
  end
  object Button1: TButton
    Left = 128
    Top = 56
    Width = 75
    Height = 25
    Caption = 'OK'
    Default = True
    TabOrder = 1
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 208
    Top = 56
    Width = 75
    Height = 25
    Cancel = True
    Caption = 'Abbrechen'
    TabOrder = 2
    OnClick = Button2Click
  end
end
