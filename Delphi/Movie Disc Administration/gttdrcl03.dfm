object mainsearchform: Tmainsearchform
  Left = 192
  Top = 175
  BorderStyle = bsDialog
  Caption = 'Suchen'
  ClientHeight = 150
  ClientWidth = 477
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
  object pagecontrol: TPageControl
    Left = 0
    Top = 0
    Width = 477
    Height = 150
    ActivePage = s_global
    Align = alClient
    TabOrder = 0
    object s_global: TTabSheet
      Caption = 'Globale Suche'
      object Label2: TLabel
        Left = 8
        Top = 4
        Width = 67
        Height = 13
        Caption = 'Suchen nach:'
      end
      object sf_global: TEdit
        Left = 80
        Top = 0
        Width = 289
        Height = 21
        TabOrder = 0
        OnKeyDown = searchfieldKeyDown
      end
      object rb_global: TGT_ListValueBox
        Left = 8
        Top = 24
        Width = 361
        Height = 97
        ItemHeight = 13
        TabOrder = 1
        OnDblClick = resultboxDblClick
      end
      object sb_global: TButton
        Left = 376
        Top = 0
        Width = 89
        Height = 21
        Caption = 'Suchen'
        TabOrder = 2
        OnClick = suchenClick
      end
      object gz_global: TButton
        Left = 376
        Top = 24
        Width = 89
        Height = 21
        Caption = 'Gehe zu'
        TabOrder = 3
        OnClick = gehezuClick
      end
      object cl_global: TButton
        Left = 376
        Top = 96
        Width = 89
        Height = 25
        Caption = 'Abbrechen'
        TabOrder = 4
        OnClick = cancelClick
      end
    end
    object s_field: TTabSheet
      Caption = 'Feldbezogende Suche'
      ImageIndex = 1
      object Label1: TLabel
        Left = 8
        Top = 28
        Width = 61
        Height = 13
        Caption = 'Suche nach:'
      end
      object Label3: TLabel
        Left = 32
        Top = 2
        Width = 37
        Height = 13
        Caption = 'Im Feld:'
      end
      object sf_field: TEdit
        Left = 80
        Top = 24
        Width = 289
        Height = 21
        TabOrder = 1
        OnKeyDown = sf_fieldKeyDown
      end
      object cb_field: TComboBox
        Left = 80
        Top = 0
        Width = 289
        Height = 21
        ItemHeight = 13
        TabOrder = 0
        Items.Strings = (
          'Filmname'
          'L'#228'nge'
          'Sprache'
          'Movie Disc'
          'Inhalt')
      end
      object rb_field: TGT_ListValueBox
        Left = 8
        Top = 48
        Width = 361
        Height = 73
        ItemHeight = 13
        TabOrder = 2
        OnDblClick = rb_fieldDblClick
      end
      object sb_field: TButton
        Left = 376
        Top = 0
        Width = 89
        Height = 21
        Caption = 'Suchen'
        TabOrder = 3
        OnClick = sb_fieldClick
      end
      object gb_field: TButton
        Left = 376
        Top = 24
        Width = 89
        Height = 21
        Caption = 'Gehe zu'
        TabOrder = 4
        OnClick = gb_fieldClick
      end
      object cl_fielf: TButton
        Left = 376
        Top = 96
        Width = 89
        Height = 25
        Caption = 'Abbrechen'
        TabOrder = 5
        OnClick = cancelClick
      end
    end
  end
end
