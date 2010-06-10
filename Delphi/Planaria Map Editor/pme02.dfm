object FormTilesetEditor: TFormTilesetEditor
  Left = 192
  Top = 103
  BorderStyle = bsDialog
  Caption = 'Tileset Editor'
  ClientHeight = 473
  ClientWidth = 862
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnPaint = FormPaint
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 424
    Top = 160
    Width = 64
    Height = 13
    Caption = 'Informationen'
  end
  object Panel2: TPanel
    Left = 0
    Top = 0
    Width = 156
    Height = 473
    Align = alLeft
    Caption = 'Panel2'
    TabOrder = 0
    object cbLayers: TComboBox
      Left = 8
      Top = 8
      Width = 145
      Height = 21
      Style = csDropDownList
      ItemHeight = 13
      ItemIndex = 0
      TabOrder = 0
      Text = 'Layer 0 (Hintergrund)'
      OnChange = cbLayersChange
      Items.Strings = (
        'Layer 0 (Hintergrund)'
        'Layer 1 (Kollisionsebende)'
        'Layer 2 (Dekorationsebende)'
        'Layer 3 (Reserviert)'
        'Layer 4 (Einheitenebene)'
        'Layer 5 (Ereignissebene)'
        'Layer 6 (Reserviert)'
        'Layer 7 (Reserviert)')
    end
    object Panel3: TPanel
      Left = 1
      Top = 40
      Width = 155
      Height = 409
      Caption = 'Panel3'
      TabOrder = 1
      object dgTileset: TDrawGrid
        Left = 1
        Top = 1
        Width = 153
        Height = 407
        Align = alClient
        ColCount = 2
        DefaultRowHeight = 64
        FixedCols = 0
        RowCount = 1
        FixedRows = 0
        ScrollBars = ssVertical
        TabOrder = 0
        OnDrawCell = dgTilesetDrawCell
      end
    end
  end
  object Button1: TButton
    Left = 392
    Top = 128
    Width = 465
    Height = 25
    Caption = 'Tileset '#246'ffnen...'
    TabOrder = 1
    OnClick = Button1Click
  end
  object lbTilesets: TListBox
    Left = 160
    Top = 8
    Width = 697
    Height = 113
    ItemHeight = 13
    TabOrder = 2
  end
  object Panel1: TPanel
    Left = 160
    Top = 160
    Width = 257
    Height = 313
    Caption = 'Panel1'
    TabOrder = 3
    object Button2: TButton
      Left = 8
      Top = 8
      Width = 241
      Height = 25
      Caption = '<- Tiles zu diesem Layer hinzuf'#252'gen...'
      TabOrder = 0
      OnClick = Button2Click
    end
  end
  object lbInformationen: TListBox
    Left = 424
    Top = 176
    Width = 433
    Height = 297
    ItemHeight = 13
    TabOrder = 4
  end
  object Button3: TButton
    Left = 160
    Top = 128
    Width = 225
    Height = 25
    Caption = 'Tileset l'#246'schen...'
    TabOrder = 5
  end
  object OpenDialog: TOpenDialog
    Filter = 'PNG Bilder (*.png)|*.png'
    Options = [ofHideReadOnly, ofAllowMultiSelect, ofEnableSizing]
    Left = 168
    Top = 16
  end
end
