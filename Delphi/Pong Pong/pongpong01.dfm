object mainform: Tmainform
  Left = 123
  Top = 434
  Width = 879
  Height = 278
  Caption = 'mainform'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnKeyDown = FormKeyDown
  OnMouseDown = FormMouseDown
  OnMouseMove = FormMouseMove
  PixelsPerInch = 96
  TextHeight = 13
  object maintimer: TTimer
    Interval = 20
    OnTimer = maintimerTimer
    Left = 8
    Top = 8
  end
end
