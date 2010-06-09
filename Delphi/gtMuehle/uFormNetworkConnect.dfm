object FormNetworkConnect: TFormNetworkConnect
  Left = 240
  Top = 178
  BorderStyle = bsDialog
  Caption = 'Verbinden...'
  ClientHeight = 182
  ClientWidth = 492
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object HostOrClient: TComboBox
    Left = 8
    Top = 8
    Width = 481
    Height = 21
    Style = csDropDownList
    ItemHeight = 13
    TabOrder = 0
    OnChange = HostOrClientChange
    Items.Strings = (
      'Host'
      'Client')
  end
  object gb_Client: TGroupBox
    Left = 184
    Top = 40
    Width = 305
    Height = 137
    Caption = 'Client'
    TabOrder = 1
    object Label3: TLabel
      Left = 168
      Top = 56
      Width = 38
      Height = 13
      Caption = 'Host IP:'
    end
    object hostlist: TListBox
      Left = 8
      Top = 16
      Width = 153
      Height = 113
      ItemHeight = 13
      TabOrder = 0
      OnClick = hostlistClick
    end
    object HostSuchen: TButton
      Left = 168
      Top = 16
      Width = 129
      Height = 25
      Caption = 'Host suchen'
      TabOrder = 1
      OnClick = HostSuchenClick
    end
    object hostip: TEdit
      Left = 168
      Top = 72
      Width = 129
      Height = 21
      TabOrder = 2
    end
    object Verbinden: TButton
      Left = 168
      Top = 104
      Width = 129
      Height = 25
      Caption = 'Verbinden...'
      TabOrder = 3
      OnClick = VerbindenClick
    end
  end
  object gb_host: TGroupBox
    Left = 8
    Top = 40
    Width = 169
    Height = 137
    Caption = 'Host'
    TabOrder = 2
    object hoststatus: TLabel
      Left = 8
      Top = 16
      Width = 66
      Height = 13
      Caption = 'Status: Offline'
    end
    object Label1: TLabel
      Left = 8
      Top = 32
      Width = 30
      Height = 13
      Caption = 'Farbe:'
    end
    object SpielHostenAbbrechen: TButton
      Left = 8
      Top = 104
      Width = 153
      Height = 25
      Caption = 'Abbrechen'
      Enabled = False
      TabOrder = 0
      OnClick = SpielHostenAbbrechenClick
    end
    object SpielHostenStart: TButton
      Left = 8
      Top = 72
      Width = 153
      Height = 25
      Caption = 'Spiel hosten'
      TabOrder = 1
      OnClick = SpielHostenStartClick
    end
    object hcwhite: TRadioButton
      Left = 8
      Top = 48
      Width = 57
      Height = 17
      Caption = 'Wei'#223
      Checked = True
      TabOrder = 2
      TabStop = True
    end
    object hcblack: TRadioButton
      Left = 88
      Top = 48
      Width = 65
      Height = 17
      Caption = 'Schwarz'
      TabOrder = 3
    end
  end
  object UDPServer: TIdUDPServer
    BroadcastEnabled = True
    Bindings = <>
    DefaultPort = 2024
    OnUDPRead = UDPServerUDPRead
    Left = 144
    Top = 48
  end
  object UDPClient: TIdUDPClient
    BroadcastEnabled = True
    Port = 2024
    Left = 112
    Top = 48
  end
  object UDPCServer: TIdUDPServer
    Active = True
    BroadcastEnabled = True
    Bindings = <>
    DefaultPort = 2025
    OnUDPRead = UDPCServerUDPRead
    Left = 200
    Top = 64
  end
end
