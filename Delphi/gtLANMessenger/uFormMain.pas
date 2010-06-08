unit uFormMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, JvComponent, JvTrayIcon, StdCtrls, Menus, IdUDPClient,
  IdBaseComponent, IdComponent, IdUDPBase, IdUDPServer, ExtCtrls,
  JvComponentBase, ComCtrls, gtvcl_ListValueBox, globals,
  bigini, IdSocketHandle, gtcl_Strings, gtcl_Network,
  hh, hh_funcs, D6OnHelpFix, JvExStdCtrls, JvCheckBox, IdStack,
  gtcl_FileSystem;

type TBytes = array of byte;

type
  TFormMain = class(TForm)
    TrayIcon: TJvTrayIcon;
    Label1: TLabel;
    ContactList: TGT_ListValueBox;
    cbStayOnTop: TCheckBox;
    BroadcastTimer: TTimer;
    UDPServer: TIdUDPServer;
    UDPClient: TIdUDPClient;
    PopUpMenu: TPopupMenu;
    Beenden1: TMenuItem;
    ber1: TMenuItem;
    N1: TMenuItem;
    N2: TMenuItem;
    Hilfe1: TMenuItem;
    Optionen1: TMenuItem;
    N3: TMenuItem;
    sbMain: TStatusBar;
    procedure TrayIconClick(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure MemberRequest;
    procedure UDPServerUDPRead(Sender: TObject; AData: TBytes;
      ABinding: TIdSocketHandle);
    procedure BroadcastTimerTimer(Sender: TObject); // Sendet einen Broadcast mit einer GID Anfrage
    function ExistsGIDinContactList(input: string) : Boolean;
    procedure ClearGIDinContactList(input: string);
    procedure ContactListDblClick(Sender: TObject);
    procedure CreateMsgWindow(ip, name: string);
    function GetIndexOfGID(input: string) : Integer;
    procedure ber1Click(Sender: TObject);
    procedure Beenden1Click(Sender: TObject);
    procedure Optionen1Click(Sender: TObject);
    procedure Hilfe1Click(Sender: TObject);
    procedure cbStayOnTopClick(Sender: TObject);
    procedure RefreshProfile;
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  FormMain: TFormMain;
  mHHelp : THookHelpSystem; //Chm Hilfe Unterstüzung

implementation

{$R *.dfm}

uses uFormChat, uFormOptions, uFormAbout;

//Send Funktionen
procedure KillGidClearWindows;
var i: Integer;
    index: Integer;
begin
  for i := 0 to GiDToClearList.Count-1 do
  begin
   index := MessageWindowList.IndexOf( GiDToClearList.Strings[i] );
   TFormChat(MessageWindowList.Objects[index]).Close;
   TFormChat(MessageWindowList.Objects[index]).Free;
   MessageWindowList.Delete(index);
  end;
  GiDToClearList.Clear;
end;

procedure TFormMain.RefreshProfile;
begin
    //Member Request an alle verschicken
 UDPClient.Broadcast( gtStrings.StrToHex(gtmpPROTOKOLDESCRIPTOR)  + gtmpSEPERATOR +
                      gtStrings.StrToHex(gtmpVERSION)  + gtmpSEPERATOR +
                      gtStrings.StrToHeX(gtmpCmdREFRESHPROFILE) + gtmpSEPERATOR +
                      gtStrings.StrToHeX(gtNetwork.GetFirstLocalIP) + gtmpSEPERATOR +
                      gtStrings.StrToHex(Ini.ReadString('profil', 'name', ''))
                     + gtmpSEPERATOR , 2401);
end;

// Sendet einen Broadcast
procedure TFormMain.MemberRequest;
begin
 //Kontaktliste löschen
 ContactList.Items.Clear;
 ContactList.ValueList.Clear;

 //UDP Client aktivieren
 UDPClient.Active := true;

 try
 //Member Request an alle verschicken
 UDPClient.Broadcast( gtStrings.StrToHex(gtmpPROTOKOLDESCRIPTOR)  + gtmpSEPERATOR +
                      gtStrings.StrToHex(gtmpVERSION)  + gtmpSEPERATOR +
                      gtStrings.StrToHeX(gtmpCmdMEMBERREQUEST) + gtmpSEPERATOR +
                      gtStrings.StrToHeX(gtNetwork.GetFirstLocalIP) + gtmpSEPERATOR +
                      gtStrings.StrToHex(Ini.ReadString('profil', 'name', ''))
                      + gtmpSEPERATOR , 2401);
 except
   on EIdSocketError do
   begin
     MessageDlg('No Route to Host (Fehlernummer: 10065): Kein angeschlossendes LAN gefunden. Die Anwendung beendet sich!', mtInformation, [mbOk], 0);
     Application.Terminate;
   end;
 end;

 //UDP Client deaktivieren
 UDPClient.Active := false;
end;

function TFormMain.GetIndexOfGID(input: string) : Integer;
var i: Integer;
begin
 for i := 0 to contactlist.ValueList.Count-1 do
 begin
  if AnsiPos(input, contactlist.ValueList.Strings[i]) > 0 then
  begin
   Result := i;
   Exit;
  end;
 end;
 Result := -1;
end;

// Überprüft ob GID in der Liste schon da ist
function TFormMain.ExistsGIDinContactList(input: string) : Boolean;
var i: Integer;
begin
 for i := 0 to contactlist.ValueList.Count-1 do
 begin
  if AnsiPos(input, contactlist.ValueList.Strings[i]) > 0 then
  begin
   Result := True;
   Exit;
  end;
 end;
 Result := False;
end;

procedure TFormMain.ClearGIDinContactList(input: string);
var i: Integer;
begin
 try
   for i := 0 to contactlist.Count-1 do
   begin
    if AnsiPos(input, contactlist.ValueList.Strings[i]) > 0 then
    begin
     contactlist.Items.Delete(i);
     contactlist.ValueList.Delete(i);
     Exit;
    end;
   end;
 except
   //Fehler
   MessageDlg('Fehler in ClearGIDinContactList (x4). Bitte Meldung an bugs@global-technology.de erstatten. Danke.', mtInformation, [mbOk], 0);
 end;
end;

procedure TFormMain.TrayIconClick(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
 FormMain.Show;
 SetForegroundWindow(FormMain.Handle);
end;

procedure TFormMain.FormShow(Sender: TObject);
begin
 ShowWindow(GetWindow(Handle, GW_OWNER), SW_HIDE); //Taskbutton deaktivieren
end;

procedure TFormMain.FormCreate(Sender: TObject);
var chmFile: string;
begin
  //cbStayOnTop.ParentBackground := false;
  // Hilfe CHM Init
 chmFile := ExtractFilePath(Application.ExeName) + 'gtLANMessenger.chm';

 mHHelp := nil;

 if not FileExists(chmFile) then
  begin ShowMessage('Hilfe-Datei nicht gefunden'#13 + chmFile) end;

 {HH 1.2 oder höher Versionskontrolle}
 if (hh.HHCtrlHandle = 0)
  or (hh_funcs._hhMajVer < 4)
  or ((hh_funcs._hhMajVer = 4) and (hh_funcs._hhMinVer < 73)) then
  begin ShowMessage('Diese Anwendung erfordert die Installation der ' +
   'MS HTML Help 1.2 oder höher') end;

 {Hook - verwendet HH_FUNCS.pas}
 mHHelp := hh_funcs.THookHelpSystem.Create(chmFile, '', htHHAPI);

 // Hilfe CHM Init Ende

 //Stay on top
 cbStayOnTop.Checked := Ini.ReadBool('formmain', 'stayontop', false);

 if Ini.ReadBool('formmain', 'normalsize', true) = true then
 begin
    // Position des Fensters anpassen
   FormMain.Left := Screen.Width - FormMain.Width;
   FormMain.Top := Screen.Height - (FormMain.Height+30);
 end
 else
 begin
 FormMain.Left := Ini.ReadInteger('formmain', 'left', Screen.Width - FormMain.Width);
 FormMain.Top := Ini.ReadInteger('formmain', 'top', Screen.Height - (FormMain.Height+30));
 FormMain.Width := Ini.ReadInteger('formmain', 'width', 151);
 FormMain.Height := Ini.ReadInteger('formmain', 'height', 382);
  end;

 FormMain.DoubleBuffered := true;

 //Andere Mitglieder holen
 MemberRequest;

 //Liste der Messagefenster
 MessageWindowList := TStringList.Create;
end;

procedure TFormMain.FormClose(Sender: TObject; var Action: TCloseAction);
var
  i : Integer;
begin
 if Xclose = false then
 begin
  Action := caNone;
  FormMain.Hide;
 end
 else
 begin
  UDPClient.Active := true;

   //Member Disconnect verschicken
   UDPClient.Broadcast( gtStrings.StrToHex(gtmpPROTOKOLDESCRIPTOR)  + gtmpSEPERATOR +
                      gtStrings.StrToHex(gtmpVERSION)  + gtmpSEPERATOR +
                      gtStrings.StrToHeX(gtmpCmdMEMBERDISCONNECT) + gtmpSEPERATOR +
                      gtStrings.StrToHeX(gtNetwork.GetFirstLocalIP) + gtmpSEPERATOR, 2401);

  UDPClient.Active := false;

  for i := 0 to MessageWindowList.Count-1 do
  begin
     TFormChat(MessageWindowList.Objects[i]).Close;
     TFormChat(MessageWindowList.Objects[i]).Free;
  end;

  TrayIcon.Free;

  Ini.WriteInteger('formmain', 'left', FormMain.Left);
  Ini.WriteInteger('formmain', 'top', FormMain.Top);
  Ini.WriteInteger('formmain', 'width', FormMain.Width);
  Ini.WriteInteger('formmain', 'height', FormMain.Height);
 end;
end;

// Message Paket empfang
procedure TFormMain.UDPServerUDPRead(Sender: TObject; AData: TBytes;
  ABinding: TIdSocketHandle);
var mySplitList: TStringList;
    myIncomingData: String;

    i: LongWord;

    tmpindex: Integer; //Index für Kommando MSG
    myContent, myIP: string; //Variablen für Kommando MSG
    DateTime : TDateTime;

    myChangeIndex: Integer;
begin
  mySplitList := TStringList.Create;

  //Decodierung der Bytes
  myIncomingData:='';
  for i:=Low(AData) to High(AData) do myIncomingData:=myIncomingData + Chr(AData[i]);

  //Message Paket empfangen
  mySplitList := gtStrings.Split(myIncomingData, gtmpSEPERATOR);

  dbgProtocolList.Add('------------------------');

  for i := 0 to mySplitList.Count-1 do
  begin
    mySplitList[i] := gtStrings.HexToStr(mySplitList[i]);
    dbgProtocolList.Add(mySplitList[i]);
  end;

  //Protokolinterpretation
  if mySplitList[0] = gtmpPROTOKOLDESCRIPTOR then
  begin
    if mySplitList[1] = gtmpVERSION then
    begin
      //Commands überprüfen
      if mySplitList[2] = gtmpCmdMEMBERREQUEST then //MemberRequest Anfrage
      begin
        if mySplitList[3] <> gtNetwork.GetFirstLocalIP then
        begin
          // Informiere Client
          UDPClient.Active := true;

          // Wenn Profilname leer dann schicke GID als Name
          UDPClient.Send(ABinding.PeerIP, 2401,
                               gtStrings.StrToHex(gtmpPROTOKOLDESCRIPTOR)  + gtmpSEPERATOR +
                               gtStrings.StrToHex(gtmpVERSION)  + gtmpSEPERATOR +
                               gtStrings.StrToHeX(gtmpCmdMEMBERREQUESTREPLY) + gtmpSEPERATOR +
                               gtStrings.StrToHeX(gtNetwork.GetFirstLocalIP) + gtmpSEPERATOR +
                               gtStrings.StrToHex(Ini.ReadString('profil', 'name', ''))
                               + gtmpSEPERATOR);

          UDPClient.Active := false;

          if mySplitList[4] <> '' then contactlist.Items.Add(mySplitList[4])
          else contactlist.Items.Add(mySplitList[3]);

          contactlist.ValueList.Add(mySplitList[3]); //IP Adresse
          sbMain.Panels[0].Text := IntToStr(ContactList.Count) + ' Kontakt(e) online';

          contactlist.Sort;
        end;
      end //gtmpCmdMEMBERREQUEST
      else if mySplitList[2] = gtmpCmdMEMBERREQUESTREPLY then
      begin
        if mySplitList[4] <> '' then contactlist.Items.Add(mySplitList[4]) //Name wird angezeigt
        else contactlist.Items.Add(mySplitList[3]); //Wenn Name gleich '' dann wird IP Adresse angezeigt
        contactlist.ValueList.Add(mySplitList[3]); //IP Adresse
        contactlist.Sort;
        sbMain.Panels[0].Text := IntToStr(ContactList.Count) + ' Kontakt(e) online';
      end //gtmpCmdMEMBERREQUESTREPLY
      else if mySplitList[2] = gtmpCmdMEMBERDISCONNECT then
      begin
        ClearGIDinContactList(mySplitList[3]);
        ContactList.Sort;
        sbMain.Panels[0].Text := IntToStr(ContactList.Count) + ' Kontakt(e) online';
      end //gtmpCmdMEMBERDISCONNECT
      else if mySplitList[2] = gtmpCmdMESSAGE then
      begin
        KillGidClearWindows; // Clearen der geschlossenden fenster

        myIP := mySplitList[3];
        myContent := mySplitList[4];

       //MSG Abarbeitung

       tmpindex := 0;

       DateTime := Now;

       if MessageWindowList.IndexOf(myIP) = -1 then
       begin
         // Fenster existiert nicht
         tmpindex := GetIndexOfGID(myIP);
         CreateMSGWindow(myIP, ContactList.Items.Strings[tmpindex]);
          
         TFormChat(MessageWindowList.Objects[MessageWindowList.IndexOf(myIP)]).msgbox.SelAttributes.Color := clRed;
         TFormChat(MessageWindowList.Objects[MessageWindowList.IndexOf(myIP)]).msgbox.lines.Add(ContactList.Items.Strings[tmpindex] + ' (' + DateTimeToStr(DateTime) +'):');
         TFormChat(MessageWindowList.Objects[MessageWindowList.IndexOf(myIP)]).msgbox.lines.Add(myContent);
         TFormChat(MessageWindowList.Objects[MessageWindowList.IndexOf(myIP)]).msgbox.lines.Add('');

         flashwindow(TFormChat(MessageWindowList.Objects[MessageWindowList.IndexOf(myIP)]).Handle,true);
       end
       else
       begin
         // Fenster existiert
         TFormChat(MessageWindowList.Objects[MessageWindowList.IndexOf(myIP)]).msgbox.SelAttributes.Color := clRed;
         TFormChat(MessageWindowList.Objects[MessageWindowList.IndexOf(myIP)]).msgbox.lines.Add(ContactList.Items.Strings[tmpindex] + ' (' + DateTimeToStr(DateTime) +'):');
         TFormChat(MessageWindowList.Objects[MessageWindowList.IndexOf(myIP)]).msgbox.lines.Add(myContent);
         TFormChat(MessageWindowList.Objects[MessageWindowList.IndexOf(myIP)]).msgbox.lines.Add('');

         flashwindow(TFormChat(MessageWindowList.Objects[MessageWindowList.IndexOf(myIP)]).Handle,true);
       end;
      end //gtmpCmdMESSAGE
      else if mySplitList[2] = gtmpCmdREFRESHPROFILE then
      begin
        myChangeIndex := ContactList.ValueList.IndexOf(mySplitList[3]);
        if myChangeIndex <> -1 then
        begin
          ContactList.Items[myChangeIndex] := mySplitList[4];
          //ContactList.Items[0] := 'Hallo';
        end;
      end; //gtmpCmdREFRESHPROFILE
    end;
  end;

  mySplitList.Free;
end;

procedure TFormMain.BroadcastTimerTimer(Sender: TObject);
begin
 ContactList.Items.BeginUpdate;
 ContactList.Clear;
 MemberRequest;
 ContactList.Items.EndUpdate;
end;

procedure TFormMain.CreateMsgWindow(ip, name: string);
var msgwindow: TFormChat;
begin
 msgwindow := TFormChat.Create(self);

 msgwindow.Show;              // Weiß net ob das nötig ist, aber schaden kanns net

 MessageWindowList.AddObject(ip ,msgwindow);

 msgwindow.Caption := 'Unterhaltung - ' + name;

 msgwindow.Lip.Caption := ip;
 msgwindow.Lname.Caption := 'Name: ' + name;

 msgwindow.UDPSenderClient.Host := ip;
end;

procedure TFormMain.ContactListDblClick(Sender: TObject);
var name: string;
    IP: string;
    ConString: string;
begin
 if (ContactList.ItemIndex < 0) or (ContactList.Count <= 0) then Exit;
 
 ConString := ContactList.ValueList.Strings[ContactList.ItemIndex];
 IP := ContactList.ValueList.Strings[ContactList.ItemIndex];

 KillGidClearWindows; // Clearen der geschlossenden fenster

 if MessageWindowList.IndexOf(IP) = -1 then
 begin
  name := ContactList.items.Strings[ContactList.ItemIndex];
  CreateMsgWindow(ContactList.ValueList.Strings[ContactList.ItemIndex], name);
 end
 else SetForegroundWindow(TFormChat(MessageWindowList.Objects[MessageWindowList.IndexOf(IP)]).Handle);
end;

procedure TFormMain.ber1Click(Sender: TObject);
begin
 FormAbout.ShowModal();
end;

procedure TFormMain.Beenden1Click(Sender: TObject);
begin
 Xclose := true;
 FormMain.Close;
end;

procedure TFormMain.Optionen1Click(Sender: TObject);
begin
   FormOptions.showmodal();
end;

procedure TFormMain.Hilfe1Click(Sender: TObject);
begin
 Application.HelpFile := gtFileSystem.GetApplicationPath + 'gtLANMessenger.chm';
 Application.HelpContext(10);
end;

procedure TFormMain.cbStayOnTopClick(Sender: TObject);
begin
 if cbStayOnTop.Checked = false then
 begin
   FormMain.FormStyle := fsNormal;
   Ini.WriteBool('formmain', 'stayontop', cbStayOnTop.Checked);
 end
 else
 begin
   FormMain.FormStyle := fsStayOnTop;
   Ini.WriteBool('formmain', 'stayontop', cbStayOnTop.Checked);
 end;
end;

end.
