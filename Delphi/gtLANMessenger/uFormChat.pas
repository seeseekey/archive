unit uFormChat;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, IdBaseComponent, IdComponent, IdUDPBase,
  IdUDPClient, globals, ComCtrls, gtcl_Strings, gtcl_Network, Menus, gtcl_System;

type
  TFormChat = class(TForm)
    GroupBox1: TGroupBox;
    Lname: TLabel;
    Panel1: TPanel;
    Send: TButton;
    UDPSenderClient: TIdUDPClient;
    Label2: TLabel;
    Lip: TLabel;
    zeichen: TLabel;
    text: TMemo;
    msgbox: TRichEdit;
    StatusBar: TStatusBar;
    btnAdditionalSends: TButton;
    ppmSendTo: TPopupMenu;
    Alle1: TMenuItem;
    procedure SendClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure textKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure textKeyPress(Sender: TObject; var Key: Char);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnAdditionalSendsClick(Sender: TObject);
    procedure Alle1Click(Sender: TObject);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  protected
    procedure CreateParams(var Params: TCreateParams); override;
  end;

var
  FormChat: TFormChat;
  notReact: Boolean=false;
  allowSend: Boolean=false;

implementation

{$R *.dfm}

uses uFormMain;

procedure TFormChat.CreateParams(var Params: TCreateParams);
begin
  inherited CreateParams(Params);
  Params.ExStyle   := Params.ExStyle or WS_EX_APPWINDOW;
  Params.WndParent := GetDesktopWindow;
end;

procedure TFormChat.SendClick(Sender: TObject);
var trimed: string;
    DateTime : TDateTime;
begin
 if FormMain.ContactList.ValueList.IndexOf(UDPSenderClient.Host) = - 1 then
 begin
   MessageDlg('Der Kontakt ist nicht mehr online!', mtInformation, [mbOk], 0);
   Exit;
 end;

 if allowSend = false then Exit;

 trimed := Trim(text.Text);

 MsgBox.SelAttributes.Color := clBlue;

 DateTime := Now;
 if Ini.ReadString('profil', 'name', '') <> '' then MsgBox.lines.add(Ini.ReadString('profil', 'name', '') + ' (' + DateTimeToStr(DateTime) +'):')
 else MsgBox.lines.add(gtNetwork.GetFirstLocalIP + ':');

 MsgBox.lines.add(trimed);
 MsgBox.lines.add('');

 UDPSenderClient.Active := true;

 UDPSenderClient.Send( gtStrings.StrToHex(gtmpPROTOKOLDESCRIPTOR)  + gtmpSEPERATOR +
                       gtStrings.StrToHex(gtmpVERSION)  + gtmpSEPERATOR +
                       gtStrings.StrToHeX(gtmpCmdMESSAGE) + gtmpSEPERATOR +
                       gtStrings.StrToHeX(gtNetwork.GetFirstLocalIP) + gtmpSEPERATOR +
                       gtStrings.StrToHex(trimed)
                       + gtmpSEPERATOR);

 UDPSenderClient.Active := false;

 msgbox.Perform(WM_VSCROLL,SB_BOTTOM,0);

 text.Clear;
 text.SetFocus;
end;

procedure TFormChat.FormShow(Sender: TObject);
begin
  Self.Width := Ini.ReadInteger('formmessage', 'width', 579);
  Self.Height := Ini.ReadInteger('formmessage', 'height', 316);

  if(Ini.ReadInteger('messagewindow', 'keysend', 1)=0) then StatusBar.Panels[0].Text :=  'Senden (Enter)'
  else if(Ini.ReadInteger('messagewindow', 'keysend', 1)=1) then StatusBar.Panels[0].Text :=  'Senden (Strg + Enter)'
  else if(Ini.ReadInteger('messagewindow', 'keysend', 1)=2) then StatusBar.Panels[0].Text :=  'Senden (Alt + S)'
  else if(Ini.ReadInteger('messagewindow', 'keysend', 1)=3) then StatusBar.Panels[0].Text :=  'Senden (Strg + Alt)';

  text.SetFocus;
end;

procedure TFormChat.FormClose(Sender: TObject; var Action: TCloseAction);
begin
 Ini.WriteInteger('formmessage', 'width', Self.Width);
 Ini.WriteInteger('formmessage', 'height', Self.Height);

 GiDToClearList.Add(LIp.Caption);
end;

procedure TFormChat.textKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
 zeichen.Caption := 'Zeichen: ' + IntToStr(Length(text.Text)) + ' / 32768';
 if Length(text.Text) > 0 then begin allowSend := true; Send.Enabled := true; end
 else begin allowSend := false; Send.Enabled := false; end
end;

procedure TFormChat.textKeyPress(Sender: TObject; var Key: Char);
begin
  if notReact = true then
  begin
    key:=#0;
    notReact := false;
  end;
end;

procedure TFormChat.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin

  //An Alle Senden Shortcut (Alt + A)
  if (ssAlt in Shift) and (Key = Ord('A')) then
  begin
    Alle1Click(Sender);
    notReact := true;
  end;

  //Message Abfrage
  if(Ini.ReadInteger('messagewindow', 'keysend', 1)=0) then //Enter
  begin
    if (Key = VK_RETURN) then
    begin
      SendClick(Sender);
      notReact := true;
    end;
  end
  else if(Ini.ReadInteger('messagewindow', 'keysend', 1)=1) then //Strg + Enter
  begin
    if (ssCtrl in Shift) and (Key = VK_RETURN) then
    begin
      SendClick(Sender);
      notReact := true;
   end;
  end
  else if(Ini.ReadInteger('messagewindow', 'keysend', 1)=2) then //Alt + S
  begin
    if (ssAlt in Shift) and (Key = Ord('S')) then
    begin
      SendClick(Sender);
      notReact := true;
   end;
  end
  else if(Ini.ReadInteger('messagewindow', 'keysend', 1)=3) then //Strg + Alt
  begin
    if (ssAlt in Shift) and (ssCtrl in Shift) then
    begin
      SendClick(Sender);
      notReact := true;
   end;
  end;
end;

procedure TFormChat.btnAdditionalSendsClick(Sender: TObject);
begin
  ppmSendTo.Popup(Mouse.CursorPos.X, Mouse.CursorPos.Y);
end;

procedure TFormChat.Alle1Click(Sender: TObject);
var trimed: string;
    DateTime : TDateTime;
    oldIP: string;
    i: Integer;
begin

 if allowSend = false then Exit;

 trimed := Trim(text.Text);
 MsgBox.SelAttributes.Color := clBlue;
 DateTime := Now;

 if Ini.ReadString('profil', 'name', '') <> '' then MsgBox.lines.add(Ini.ReadString('profil', 'name', '') + ' (' + DateTimeToStr(DateTime) +'):')
 else MsgBox.lines.add(gtNetwork.GetFirstLocalIP + ':');

 MsgBox.lines.add(trimed);
 MsgBox.lines.add('');

 UDPSenderClient.Active := true;

 oldIP := UDPSenderClient.Host;

 for i := 0 to FormMain.ContactList.ValueList.Count-1 do
 begin
  UDPSenderClient.Host := FormMain.ContactList.ValueList.Strings[i];

  UDPSenderClient.Send( gtStrings.StrToHex(gtmpPROTOKOLDESCRIPTOR)  + gtmpSEPERATOR +
                        gtStrings.StrToHex(gtmpVERSION)  + gtmpSEPERATOR +
                        gtStrings.StrToHeX(gtmpCmdMESSAGE) + gtmpSEPERATOR +
                        gtStrings.StrToHeX(gtNetwork.GetFirstLocalIP) + gtmpSEPERATOR +
                        gtStrings.StrToHex(trimed)
                        + gtmpSEPERATOR);
  end;

 UDPSenderClient.Host := oldIP;

 UDPSenderClient.Active := false;

 msgbox.Perform(WM_VSCROLL,SB_BOTTOM,0);

 text.Clear;
 text.SetFocus;
end;

end.
