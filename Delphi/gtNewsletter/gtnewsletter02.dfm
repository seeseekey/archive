object editrecievers: Teditrecievers
  Left = 190
  Top = 144
  BorderStyle = bsDialog
  Caption = 'Empf'#228'ngerliste bearbeiten...'
  ClientHeight = 303
  ClientWidth = 688
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
  object eelist: TListBox
    Left = 0
    Top = 0
    Width = 688
    Height = 265
    Align = alTop
    ItemHeight = 13
    Sorted = True
    TabOrder = 0
  end
  object delete: TButton
    Left = 0
    Top = 272
    Width = 75
    Height = 25
    Caption = 'L'#246'schen'
    TabOrder = 1
    OnClick = deleteClick
  end
  object edit: TButton
    Left = 80
    Top = 272
    Width = 75
    Height = 25
    Caption = 'Bearbeiten'
    TabOrder = 2
    OnClick = editClick
  end
  object new: TButton
    Left = 160
    Top = 272
    Width = 75
    Height = 25
    Caption = 'Neu'
    TabOrder = 3
    OnClick = newClick
  end
  object ok: TButton
    Left = 608
    Top = 272
    Width = 75
    Height = 25
    Caption = 'O&K'
    TabOrder = 4
    OnClick = okClick
  end
  object cancel: TButton
    Left = 528
    Top = 272
    Width = 75
    Height = 25
    Caption = '&Abbrechen'
    TabOrder = 5
    OnClick = cancelClick
  end
end
