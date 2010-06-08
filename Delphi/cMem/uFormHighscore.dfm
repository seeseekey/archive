object FormHighscore: TFormHighscore
  Left = 198
  Top = 106
  BorderStyle = bsDialog
  Caption = 'Highscore'
  ClientHeight = 238
  ClientWidth = 492
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Highscore: TLabel
    Left = 178
    Top = 8
    Width = 144
    Height = 37
    Caption = 'Highscore'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -32
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object reHsNames: TRichEdit
    Left = 0
    Top = 56
    Width = 250
    Height = 145
    Alignment = taCenter
    BevelInner = bvNone
    BevelOuter = bvNone
    BorderStyle = bsNone
    Color = clBtnFace
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    Lines.Strings = (
      'Name'
      '')
    ParentFont = False
    ReadOnly = True
    TabOrder = 1
  end
  object btnOK: TButton
    Left = 25
    Top = 208
    Width = 450
    Height = 25
    Caption = 'OK'
    Default = True
    TabOrder = 0
    OnClick = btnOKClick
  end
  object reHsPoints: TRichEdit
    Left = 251
    Top = 56
    Width = 250
    Height = 145
    Alignment = taCenter
    BevelInner = bvNone
    BevelOuter = bvNone
    BorderStyle = bsNone
    Color = clBtnFace
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    Lines.Strings = (
      'Punkte'
      '')
    ParentFont = False
    ReadOnly = True
    TabOrder = 2
  end
end
