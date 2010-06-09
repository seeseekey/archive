object mainform: Tmainform
  Left = 186
  Top = 107
  BorderStyle = bsNone
  Caption = 'mainform'
  ClientHeight = 453
  ClientWidth = 688
  Color = clWhite
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  WindowState = wsMaximized
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  PixelsPerInch = 96
  TextHeight = 13
  object mainlabel: TLabel
    Left = 8
    Top = 8
    Width = 49
    Height = 13
    Caption = 'Speed: 95'
    Color = clWhite
    ParentColor = False
  end
  object maintimer: TTimer
    Interval = 985
    OnTimer = maintimerTimer
    Left = 8
    Top = 32
  end
end
