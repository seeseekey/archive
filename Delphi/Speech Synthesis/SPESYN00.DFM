object mainform: Tmainform
  Left = 192
  Top = 107
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsDialog
  Caption = 'Speech Synthesis V1.00'
  ClientHeight = 334
  ClientWidth = 589
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 0
    Top = 0
    Width = 126
    Height = 13
    Caption = 'Zu synthetesierender Text:'
  end
  object Label2: TLabel
    Left = 0
    Top = 184
    Width = 183
    Height = 13
    Caption = 'Umgerechnete Syntheseanweisungen:'
  end
  object sourcetext: TMemo
    Left = 0
    Top = 16
    Width = 585
    Height = 161
    TabOrder = 0
  end
  object syntable: TListBox
    Left = 0
    Top = 200
    Width = 585
    Height = 97
    ItemHeight = 13
    TabOrder = 1
  end
  object calcsyn: TButton
    Left = 0
    Top = 304
    Width = 193
    Height = 25
    Caption = 'In Syntheseweisungen umrechnen'
    TabOrder = 2
    OnClick = calcsynClick
  end
  object playsyn: TButton
    Left = 200
    Top = 304
    Width = 385
    Height = 25
    Caption = 'Synthese vorspielen'
    TabOrder = 3
    OnClick = playsynClick
  end
end
