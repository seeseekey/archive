object FormReadDrive: TFormReadDrive
  Left = 320
  Top = 273
  BorderStyle = bsDialog
  Caption = 'Lese Laufwerk aus...'
  ClientHeight = 90
  ClientWidth = 524
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object GroupBox1: TGroupBox
    Left = 8
    Top = 8
    Width = 513
    Height = 73
    Caption = 'Statistik'
    TabOrder = 0
    object staReadFiles: TLabel
      Left = 8
      Top = 16
      Width = 94
      Height = 13
      Caption = 'Gelesende Dateien:'
    end
    object staReadFolders: TLabel
      Left = 8
      Top = 32
      Width = 122
      Height = 13
      Caption = 'Gelesende Verzeichnisse:'
    end
    object staCurrentFolder: TLabel
      Left = 8
      Top = 48
      Width = 126
      Height = 13
      Caption = 'Momentanes Verzeichniss:'
    end
  end
end
