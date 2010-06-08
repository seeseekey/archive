object FormJob: TFormJob
  Left = 192
  Top = 107
  BorderStyle = bsDialog
  Caption = 'FormJob'
  ClientHeight = 368
  ClientWidth = 575
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
    Width = 46
    Height = 13
    Caption = 'Jobname:'
  end
  object Label2: TLabel
    Left = 8
    Top = 56
    Width = 57
    Height = 13
    Caption = 'Quellordner:'
  end
  object Label3: TLabel
    Left = 8
    Top = 288
    Width = 50
    Height = 13
    Caption = 'Zielordner:'
  end
  object edJobname: TEdit
    Left = 8
    Top = 24
    Width = 561
    Height = 21
    TabOrder = 0
  end
  object lbSourceFolders: TListBox
    Left = 8
    Top = 72
    Width = 561
    Height = 153
    ItemHeight = 13
    TabOrder = 1
  end
  object btnAddSourceFolder: TButton
    Left = 472
    Top = 264
    Width = 97
    Height = 21
    Caption = 'Hinzuf'#252'gen...'
    TabOrder = 2
    OnClick = btnAddSourceFolderClick
  end
  object edTargetFolder: TEdit
    Left = 8
    Top = 304
    Width = 457
    Height = 21
    TabOrder = 3
  end
  object btnBrowsetargetFolder: TButton
    Left = 472
    Top = 304
    Width = 97
    Height = 21
    Caption = 'Durchsuchen...'
    TabOrder = 4
    OnClick = btnBrowsetargetFolderClick
  end
  object btnOK: TButton
    Left = 416
    Top = 336
    Width = 75
    Height = 25
    Caption = 'OK'
    TabOrder = 5
    OnClick = btnOKClick
  end
  object btnCancel: TButton
    Left = 496
    Top = 336
    Width = 75
    Height = 25
    Caption = 'Abbrechen'
    TabOrder = 6
    OnClick = btnCancelClick
  end
  object btnRemoveSourceFolder: TButton
    Left = 312
    Top = 264
    Width = 75
    Height = 21
    Caption = 'L'#246'schen...'
    TabOrder = 7
  end
  object btnEditSourceFolder: TButton
    Left = 392
    Top = 264
    Width = 75
    Height = 21
    Caption = #196'ndern...'
    TabOrder = 8
  end
  object edSourceFolder: TEdit
    Left = 8
    Top = 232
    Width = 457
    Height = 21
    TabOrder = 9
  end
  object btnBrowseSourceFolder: TButton
    Left = 472
    Top = 232
    Width = 97
    Height = 21
    Caption = 'Durchsuchen...'
    TabOrder = 10
    OnClick = btnBrowseSourceFolderClick
  end
end
