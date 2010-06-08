object FormChat: TFormChat
  Left = 244
  Top = 137
  Width = 579
  Height = 316
  Caption = 'Unterhaltung'
  Color = clBtnFace
  Constraints.MinHeight = 275
  Constraints.MinWidth = 355
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  OnClose = FormClose
  OnKeyDown = FormKeyDown
  OnShow = FormShow
  DesignSize = (
    571
    289)
  PixelsPerInch = 96
  TextHeight = 13
  object GroupBox1: TGroupBox
    Left = 8
    Top = 8
    Width = 556
    Height = 34
    Anchors = [akLeft, akTop, akRight]
    Caption = 'Sende Nachricht zu:'
    TabOrder = 0
    object Lname: TLabel
      Left = 112
      Top = 16
      Width = 31
      Height = 13
      Caption = 'Name:'
    end
    object Label2: TLabel
      Left = 8
      Top = 16
      Width = 13
      Height = 13
      Caption = 'IP:'
    end
    object Lip: TLabel
      Left = 24
      Top = 16
      Width = 81
      Height = 13
      Caption = '100.100.100.100'
    end
  end
  object Panel1: TPanel
    Left = 8
    Top = 152
    Width = 556
    Height = 34
    Anchors = [akLeft, akRight, akBottom]
    TabOrder = 1
    DesignSize = (
      556
      34)
    object zeichen: TLabel
      Left = 8
      Top = 8
      Width = 92
      Height = 13
      Anchors = [akLeft]
      Caption = 'Zeichen: 0 / 32768'
    end
  end
  object Send: TButton
    Left = 484
    Top = 192
    Width = 78
    Height = 49
    Anchors = [akRight, akBottom]
    Caption = 'Senden'
    Enabled = False
    TabOrder = 2
    OnClick = SendClick
  end
  object text: TMemo
    Left = 8
    Top = 192
    Width = 473
    Height = 72
    Anchors = [akLeft, akRight, akBottom]
    MaxLength = 32768
    ScrollBars = ssVertical
    TabOrder = 3
    OnKeyDown = textKeyDown
    OnKeyPress = textKeyPress
  end
  object msgbox: TRichEdit
    Left = 8
    Top = 46
    Width = 556
    Height = 102
    Anchors = [akLeft, akTop, akRight, akBottom]
    ReadOnly = True
    ScrollBars = ssVertical
    TabOrder = 4
  end
  object StatusBar: TStatusBar
    Left = 0
    Top = 270
    Width = 571
    Height = 19
    Anchors = []
    Panels = <
      item
        Text = 'Senden ()'
        Width = 50
      end>
  end
  object btnAdditionalSends: TButton
    Left = 484
    Top = 248
    Width = 78
    Height = 17
    Anchors = [akRight, akBottom]
    Caption = 'Senden an...'
    TabOrder = 6
    OnClick = btnAdditionalSendsClick
  end
  object UDPSenderClient: TIdUDPClient
    Port = 2401
    Left = 16
    Top = 56
  end
  object ppmSendTo: TPopupMenu
    Left = 48
    Top = 56
    object Alle1: TMenuItem
      Caption = 'Alle (Alt + A)'
      OnClick = Alle1Click
    end
  end
end
