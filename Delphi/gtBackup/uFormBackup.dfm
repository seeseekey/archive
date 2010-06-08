object FormBackup: TFormBackup
  Left = 635
  Top = 604
  BorderStyle = bsDialog
  Caption = 'FormBackup'
  ClientHeight = 124
  ClientWidth = 637
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 8
    Width = 28
    Height = 13
    Caption = 'Datei:'
  end
  object Label2: TLabel
    Left = 8
    Top = 56
    Width = 39
    Height = 13
    Caption = 'Gesamt:'
  end
  object lblCurrentFile: TLabel
    Left = 40
    Top = 8
    Width = 3
    Height = 13
  end
  object lblStatus: TLabel
    Left = 8
    Top = 104
    Width = 39
    Height = 13
    Caption = 'Status: -'
  end
  object pbFile: TProgressBar
    Left = 8
    Top = 24
    Width = 625
    Height = 25
    TabOrder = 0
  end
  object pbAll: TProgressBar
    Left = 8
    Top = 72
    Width = 625
    Height = 25
    TabOrder = 1
  end
end
