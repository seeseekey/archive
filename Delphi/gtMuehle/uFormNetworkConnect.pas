unit uFormNetworkConnect;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, IdBaseComponent, IdComponent, IdUDPBase, IdUDPServer,
  IdUDPClient, IdSocketHandle, muehle;



type
  TFormNetworkConnect = class(TForm)
    HostOrClient: TComboBox;
    gb_Client: TGroupBox;
    gb_host: TGroupBox;
    hoststatus: TLabel;
    SpielHostenAbbrechen: TButton;
    SpielHostenStart: TButton;
    hostlist: TListBox;
    HostSuchen: TButton;
    Label3: TLabel;
    hostip: TEdit;
    Verbinden: TButton;
    UDPServer: TIdUDPServer;
    UDPClient: TIdUDPClient;
    UDPCServer: TIdUDPServer;
    hcwhite: TRadioButton;
    hcblack: TRadioButton;
    Label1: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure HostOrClientChange(Sender: TObject);
    procedure SpielHostenStartClick(Sender: TObject);
    procedure SpielHostenAbbrechenClick(Sender: TObject);
    procedure UDPServerUDPRead(Sender: TObject; AData: TBytes;
      ABinding: TIdSocketHandle);
    procedure HostSuchenClick(Sender: TObject);
    procedure UDPCServerUDPRead(Sender: TObject; AData: TBytes;
      ABinding: TIdSocketHandle);
    procedure hostlistClick(Sender: TObject);
    procedure VerbindenClick(Sender: TObject);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  FormNetworkConnect: TFormNetworkConnect;
  hostgame: Boolean=false;

implementation

{$R *.dfm}

procedure TFormNetworkConnect.FormCreate(Sender: TObject);
begin
 HostOrClient.ItemIndex := 0;
 HostOrClientChange(Sender);
end;

procedure TFormNetworkConnect.HostOrClientChange(Sender: TObject);
begin
 if HostOrClient.ItemIndex = 0 then
 begin
  gb_host.Enabled := true;
  gb_Client.Enabled := false;
 end
 else
 begin
  gb_host.Enabled := false;
  gb_Client.Enabled := true;
 end;
end;

procedure TFormNetworkConnect.SpielHostenStartClick(Sender: TObject);
begin
  try
   //Host Server Aktivieren
   UDPServer.Active := true;
  except
  end;
 SpielHostenStart.Enabled := false;
 SpielHostenAbbrechen.Enabled := true;
 hoststatus.Caption := 'Status: Warte auf Spieler';
end;

procedure TFormNetworkConnect.SpielHostenAbbrechenClick(Sender: TObject);
begin
 try
  UDPServer.Active := false;
 except
 end;
  SpielHostenStart.Enabled := true;
  SpielHostenAbbrechen.Enabled := false;
  hoststatus.Caption := 'Status: Offline';
end;

procedure TFormNetworkConnect.UDPServerUDPRead(Sender: TObject; AData: TBytes;
  ABinding: TIdSocketHandle);
var
  S: String;
  i: Integer;
begin
  S:='';
  for i:=Low(AData) to High(AData) do
    S:=S + Chr(AData[i]);
  // Umwandeln der Anfrage

  // Wenn Spiel Host is dann
   If S = 'Request Server' then
   begin
    // Dem Clienten Die HostIP Senden
    UDPClient.Host := ABinding.PeerIP;
    UDPClient.Port := 2025;
    UDPClient.Active := true;
    UDPClient.Send('Host ACK');
    UDPClient.Active := false;
   end
   else if s = 'Start Game' then
   begin
    // Dem Clienten Die HostIP Senden
    UDPClient.Host := ABinding.PeerIP;
    UDPClient.Port := 2025;
    UDPClient.Active := true;
    if hcwhite.Checked = true then
    begin
     UDPClient.Send('Game ACK2');
     net.player := 1;
     MessageDlg('Sie sind Spieler 1 (Weiß).', mtInformation, [mbOk], 0);
    end
    else
    begin
     UDPClient.Send('Game ACK1');
     net.player := 2;
     MessageDlg('Sie sind Spieler 2 (Schwarz).', mtInformation, [mbOk], 0);
    end;

    net.AnotherIP := ABinding.PeerIP;
    UDPClient.Active := false;
    FormNetworkConnect.Close;
   end;
end;

procedure TFormNetworkConnect.HostSuchenClick(Sender: TObject);
begin
   UDPClient.Host := '';
   UDPClient.Port := 2024;
   UDPClient.Active := true;
   UDPClient.Broadcast('Request Server', 2024); // hier muss auch der Port angegeben werden
   UDPClient.Active := false;
end;

procedure TFormNetworkConnect.UDPCServerUDPRead(Sender: TObject; AData: TBytes;
  ABinding: TIdSocketHandle);
var
  S: String;
  i: Integer;
begin
  S:='';
  for i:=Low(AData) to High(AData) do
    S:=S + Chr(AData[i]);

  if s = 'Host ACK' then
  begin
   hostlist.Items.Add(ABinding.PeerIP);
  end
  else if AnsiPos('Game ACK', s) > 0 then
  begin
   net.AnotherIP := ABinding.PeerIP;
   net.player := StrToInt(Copy(s, 9, 1));

   if net.player = 1 then MessageDlg('Sie sind Spieler 1 (Weiß).', mtInformation, [mbOk], 0)
   else MessageDlg('Sie sind Spieler 2 (Schwarz).', mtInformation, [mbOk], 0);

   FormNetworkConnect.Close;
  end;
end;

procedure TFormNetworkConnect.hostlistClick(Sender: TObject);
begin
 if hostlist.Count > 0 then
 begin
  hostip.Text := hostlist.Items.Strings[hostlist.itemindex];
 end;
end;

procedure TFormNetworkConnect.VerbindenClick(Sender: TObject);
begin
 UDPClient.Host := hostip.Text;
 UDPClient.Port := 2024;
 UDPClient.Active := true;
 UDPClient.Send('Start Game'); // hier muss auch der Port angegeben werden
 UDPClient.Active := false;
end;

end.
