object FormNewMap: TFormNewMap
  Left = 198
  Top = 103
  BorderStyle = bsDialog
  Caption = 'Neue Map...'
  ClientHeight = 182
  ClientWidth = 902
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
  object Label1: TLabel
    Left = 8
    Top = 8
    Width = 73
    Height = 13
    Caption = 'Name der Map:'
  end
  object Label2: TLabel
    Left = 8
    Top = 56
    Width = 72
    Height = 13
    Caption = 'Breite der Map:'
  end
  object Label3: TLabel
    Left = 8
    Top = 104
    Width = 71
    Height = 13
    Caption = 'H'#246'he der Map:'
  end
  object Label4: TLabel
    Left = 208
    Top = 8
    Width = 99
    Height = 13
    Caption = 'Verwendetes Tileset:'
  end
  object btnOk: TButton
    Left = 744
    Top = 152
    Width = 75
    Height = 25
    Caption = 'OK'
    TabOrder = 4
    OnClick = btnOkClick
  end
  object btCancel: TButton
    Left = 824
    Top = 152
    Width = 75
    Height = 25
    Caption = 'Abbrechen'
    TabOrder = 5
    OnClick = btCancelClick
  end
  object edNameOfMap: TEdit
    Left = 8
    Top = 24
    Width = 185
    Height = 21
    TabOrder = 0
  end
  object seWidthOfMap: TSpinEdit
    Left = 8
    Top = 72
    Width = 185
    Height = 22
    MaxValue = 10000
    MinValue = 1
    TabOrder = 1
    Value = 5
  end
  object seHeightOfMap: TSpinEdit
    Left = 8
    Top = 120
    Width = 185
    Height = 22
    MaxValue = 10000
    MinValue = 1
    TabOrder = 2
    Value = 5
  end
  object lbTilesets: TListBox
    Left = 208
    Top = 24
    Width = 689
    Height = 121
    ItemHeight = 13
    TabOrder = 3
  end
end
