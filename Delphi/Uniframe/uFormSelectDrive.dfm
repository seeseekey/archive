object FormSelectDrive: TFormSelectDrive
  Left = 527
  Top = 124
  BorderStyle = bsDialog
  Caption = 'Laufwerk ausw'#228'hlen'
  ClientHeight = 486
  ClientWidth = 655
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
  object Label1: TLabel
    Left = 0
    Top = 200
    Width = 70
    Height = 13
    Caption = 'Seriennummer:'
  end
  object Label2: TLabel
    Left = 0
    Top = 240
    Width = 159
    Height = 13
    Caption = 'Bezeichnung (max. 256 Zeichen):'
  end
  object Label3: TLabel
    Left = 0
    Top = 280
    Width = 168
    Height = 13
    Caption = 'Beschreibung (max. 1024 Zeichen):'
  end
  object Label4: TLabel
    Left = 0
    Top = 408
    Width = 158
    Height = 13
    Caption = 'Archivnummer (max. 32 Zeichen):'
  end
  object Label5: TLabel
    Left = 0
    Top = 160
    Width = 140
    Height = 13
    Caption = 'Medientyp (max. 32 Zeichen):'
  end
  object Label6: TLabel
    Left = 0
    Top = 120
    Width = 91
    Height = 13
    Caption = 'Interner Medientyp:'
  end
  object DriveBox: TListBox
    Left = 0
    Top = 0
    Width = 649
    Height = 113
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Courier New'
    Font.Style = []
    ItemHeight = 16
    ParentFont = False
    TabOrder = 0
    OnClick = DriveBoxClick
  end
  object OK: TButton
    Left = 576
    Top = 456
    Width = 75
    Height = 25
    Caption = '&OK'
    TabOrder = 1
    OnClick = OKClick
  end
  object CANCEL: TButton
    Left = 496
    Top = 456
    Width = 75
    Height = 25
    Caption = 'A&bbrechen'
    TabOrder = 2
    OnClick = CANCELClick
  end
  object EditSerialNumber: TEdit
    Left = 0
    Top = 216
    Width = 649
    Height = 21
    ReadOnly = True
    TabOrder = 3
  end
  object EditBezeichnung: TEdit
    Left = 0
    Top = 256
    Width = 649
    Height = 21
    MaxLength = 256
    TabOrder = 4
  end
  object EditBeschreibung: TMemo
    Left = 0
    Top = 296
    Width = 649
    Height = 105
    MaxLength = 1024
    TabOrder = 5
  end
  object EditArchivnummer: TEdit
    Left = 0
    Top = 424
    Width = 649
    Height = 21
    MaxLength = 32
    TabOrder = 6
  end
  object cbMediaTyp: TComboBox
    Left = 0
    Top = 176
    Width = 649
    Height = 21
    ItemHeight = 13
    MaxLength = 32
    Sorted = True
    TabOrder = 7
    Items.Strings = (
      'Blu-Ray Disc'
      'CD-ROM'
      'CD-RW'
      'Compact Flash'
      'Diskette'
      'DVD-RAM'
      'DVD-ROM'
      'Festplatte'
      'HD-DVD'
      'Magneto Optical Disk'
      'MiniDisc'
      'SD Karte'
      'USB-Stick')
  end
  object EditInternalMediaTyp: TEdit
    Left = 0
    Top = 136
    Width = 649
    Height = 21
    ReadOnly = True
    TabOrder = 8
  end
end
