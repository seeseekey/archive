object mailsendform: Tmailsendform
  Left = 192
  Top = 107
  BorderStyle = bsDialog
  Caption = 'Sende Mails...'
  ClientHeight = 47
  ClientWidth = 425
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  PixelsPerInch = 96
  TextHeight = 13
  object mailstatus: TLabel
    Left = 8
    Top = 8
    Width = 120
    Height = 13
    Caption = 'Bereite Mailversand vor...'
  end
  object fortschritt: TProgressBar
    Left = 8
    Top = 24
    Width = 409
    Height = 16
    Min = 0
    Max = 100
    TabOrder = 0
  end
  object Timer1: TTimer
    Interval = 250
    OnTimer = FormShow
    Left = 72
    Top = 16
  end
  object IdAntiFreeze1: TIdAntiFreeze
    OnlyWhenIdle = False
    Left = 8
    Top = 16
  end
  object smtp: TIdSMTP
    SASLMechanisms = <>
    Left = 40
    Top = 16
  end
end
