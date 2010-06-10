object FormNewTileset: TFormNewTileset
  Left = 192
  Top = 103
  BorderStyle = bsDialog
  Caption = 'Neues Tileset'
  ClientHeight = 127
  ClientWidth = 216
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
    Width = 90
    Height = 13
    Caption = 'Name des Tilesets:'
  end
  object Label2: TLabel
    Left = 8
    Top = 48
    Width = 92
    Height = 13
    Caption = 'Gr'#246#223'e der Kacheln:'
  end
  object EditTilesetName: TEdit
    Left = 8
    Top = 24
    Width = 201
    Height = 21
    TabOrder = 0
    OnKeyDown = EditTilesetNameKeyDown
  end
  object btn_OK: TButton
    Left = 8
    Top = 96
    Width = 97
    Height = 25
    Caption = 'OK'
    TabOrder = 2
    OnClick = btn_OKClick
  end
  object btn_Cancel: TButton
    Left = 112
    Top = 96
    Width = 97
    Height = 25
    Caption = 'Abbrechen'
    TabOrder = 3
    OnClick = btn_CancelClick
  end
  object cbTilesetTileSize: TComboBox
    Left = 8
    Top = 64
    Width = 201
    Height = 21
    Style = csDropDownList
    ItemHeight = 13
    ItemIndex = 0
    TabOrder = 1
    Text = '8'
    Items.Strings = (
      '8'
      '16'
      '32'
      '64'
      '128')
  end
end
