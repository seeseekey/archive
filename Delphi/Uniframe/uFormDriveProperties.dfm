object FormDriveProperties: TFormDriveProperties
  Left = 488
  Top = 214
  BorderStyle = bsDialog
  Caption = 'Eigenschaften des Datentr'#228'gers...'
  ClientHeight = 311
  ClientWidth = 540
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object MemoProperty: TMemo
    Left = 0
    Top = 0
    Width = 537
    Height = 273
    ReadOnly = True
    TabOrder = 0
  end
  object BtnOkay: TButton
    Left = 464
    Top = 280
    Width = 75
    Height = 25
    Caption = 'O&K'
    TabOrder = 1
    OnClick = BtnOkayClick
  end
end
