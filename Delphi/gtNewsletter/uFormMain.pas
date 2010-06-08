unit uFormMain;

interface

// Kürzel im Quelltext
// OPTI77 = An dieser Stelle besteht Optimierungsbedarf
// WARC99 = An diesen Stellen müssen bei Erweiterrungen
//          wartungen vorgenommen werden
// DEBUG44 = Dieser Code ist nur zum Debugen
// BUILD88 = Hier muss noch Code eingebaut werden

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus, ToolWin, ComCtrls, ImgList, ExtCtrls, StdCtrls, Globals,
  StrUtils, Buttons, ShlObj, bigini, IdMessage, hh, hh_funcs, D6OnHelpFix;

type
  TFormMain = class(TForm)
    mainmenu: TMainMenu;
    Datei1: TMenuItem;
    Beenden1: TMenuItem;
    Hilfe1: TMenuItem;
    Inhalt1: TMenuItem;
    N1: TMenuItem;
    HilfezurHilfe1: TMenuItem;
    N2: TMenuItem;
    ber1: TMenuItem;
    mainpanel: TPanel;
    toolbarimagelist: TImageList;
    rightpanel: TPanel;
    leftpanel: TPanel;
    Splitter1: TSplitter;
    rightpaneltop: TPanel;
    rightpanelbuttom: TPanel;
    Splitter2: TSplitter;
    treeview: TTreeView;
    maillist: TListView;
    NeuesKontoanlegen1: TMenuItem;
    N3: TMenuItem;
    maintimer: TTimer;
    elist: TListBox;
    N4: TMenuItem;
    Verfassen1: TMenuItem;
    Bearbeiten1: TMenuItem;
    toolbarpanel: TPanel;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    mailbetreffpanel: TPanel;
    mailbetreff: TEdit;
    anhangview: TListBox;
    Optionen1: TMenuItem;
    N5: TMenuItem;
    anhangpopup: TPopupMenu;
    Anhangspeichernunter1: TMenuItem;
    kontoinfobox: TListBox;
    Kontolschen1: TMenuItem;
    mailview: TRichEdit;
    procedure reloaddata();
    procedure ber1Click(Sender: TObject);
    procedure NeuesKontoanlegen1Click(Sender: TObject);
    procedure Beenden1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure treeviewClick(Sender: TObject);
    procedure maintimerTimer(Sender: TObject);
    procedure Bearbeiten1Click(Sender: TObject);
    procedure Verfassen1Click(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure FormPaint(Sender: TObject);
    procedure maillistClick(Sender: TObject);
    procedure Anhangspeichernunter1Click(Sender: TObject);
    procedure Kontolschen1Click(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure Inhalt1Click(Sender: TObject);
    procedure HilfezurHilfe1Click(Sender: TObject);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  FormMain: TFormMain;
  treelist: TStrings;
  mHHelp: THookHelpSystem;

implementation

uses uFormAbout, gtnewsletter01, gtnewsletter02, gtnewsletter03;

{$R *.dfm}

procedure TFormMain.reloaddata();
var inifile: TBiggerIniFile;
    sectionlist: TStrings;
    i: Integer;
    treenode : TTreeNode;
begin
 sectionlist := TStringlist.Create;
 inifile := TBiggerIniFile.Create(ExtractFilePath(Application.ExeName) + 'konten.ini');
 
 inifile.ReadSections(sectionlist);

 treeview.Items.Clear;
 mailview.Clear;
 maillist.Clear;
 anhangview.Clear;
 elist.clear;

 if sectionlist.Count > 0 then
 begin
  for i := 0 to sectionlist.Count-1 do //TTreeview generieren
  begin
   treenode := treeview.Items.AddFirst(nil, inifile.ReadString(sectionlist.Strings[i], 'kontoname', 'Kontoname'));
   treelist.Add(inifile.ReadString(sectionlist.Strings[i], 'kontoname', 'Kontoname')
                +'|'+ sectionlist.Strings[i]);

   treeview.items[0].imageindex := 0;
   treeview.items[0].SelectedIndex := 0;

   treeview.Items.AddChild(treenode, 'Empfänger');
   treeview.items[1].imageindex := 1;
   treeview.items[1].SelectedIndex := 1;
   treeview.Items.AddChild(treenode, 'Entwürfe');
   treeview.items[2].imageindex := 2;
   treeview.items[2].SelectedIndex := 2;
   treeview.Items.AddChild(treenode, 'Gesendet');
   treeview.items[3].imageindex := 3;
   treeview.items[3].SelectedIndex := 3;
   {
   treeview.Items.AddChild(treenode, 'Papierkorb');
   treeview.items[4].imageindex := 4;
   treeview.items[4].SelectedIndex := 4;
   }
  end;
 end;

 treeview.FullExpand; //Treeview wird komplett ausgeklappt

 inifile.Free;
 sectionlist.Free;
end;

procedure TFormMain.ber1Click(Sender: TObject);
begin
  FormAbout.ShowModal;
end;

procedure TFormMain.NeuesKontoanlegen1Click(Sender: TObject);
begin
 createkontoform.showmodal;
end;

procedure TFormMain.Beenden1Click(Sender: TObject);
begin
 FormMain.Close;
end;

procedure TFormMain.FormCreate(Sender: TObject);
var chmFile: string;
begin
  chmFile := ExtractFilePath(ParamStr(0))+'gtnewsletter.chm';

  mHHelp := nil;

  if not FileExists(chmFile) then
    ShowMessage('Hilfe-Datei nicht gefunden'#13+chmFile);

  {HH 1.2 oder höher Versionskontrolle}
  if (hh.HHCtrlHandle = 0)
    or (hh_funcs._hhMajVer < 4)
    or ((hh_funcs._hhMajVer = 4) and (hh_funcs._hhMinVer < 73)) then
      ShowMessage('Diese Anwendung erfordert die Installation der '+
      'MS HTML Help 1.2 oder höher');

  {Hook - verwendet HH_FUNCS.pas}
  mHHelp := hh_funcs.THookHelpSystem.Create(chmFile, '', htHHAPI);
  
 smtpmessage := TIdMessage.Create(smtpmessage);
 treelist := TStringlist.Create;
 dellistanhang := TStringList.Create;
 reloaddata();
 if treeview.Items.Count > 0 then
 begin
  treeview.items.getfirstnode.selected := true;
 end;
 treeviewClick(Sender);
end;

procedure TFormMain.FormClose(Sender: TObject; var Action: TCloseAction);
begin
 smtpmessage.Free;
 treelist.free;
 dellistanhang.Free;
end;

procedure TFormMain.treeviewClick(Sender: TObject);
var treepath, kontoname, folder: string;
    //foldername: string;
    inifile: TBiggerIniFile;
    readfile: TBiggerIniFile;
    sectionlist: TStrings;
    filelist: TStrings;
    anhangfilelist: TStrings;
    anhangsize: int64;
    i, j, k: Integer;
    section: string;
    ListItem: TListItem;
begin
 //DEBUG44
 //mainform.Caption := GetNodePath(treeView.Selected);
 treepath := GetNodePath(treeView.Selected);
 kontoname := leftstr(treepath, Ansipos('|', treepath)-1);

 // Wenn selected eine Wurzel dann lösche felder rechts
 if ansipos('|', treepath) = 0 then
 begin
  elist.Visible:= false;
  maillist.Visible := false;
  kontoinfobox.Visible := true;
  kontoinfobox.clear;
  maillist.Items.Clear;
  mailview.Lines.Clear;
  mailbetreff.Text := '';
  kontoname := treepath;
  //Exit;
 end
 else
 begin
  kontoinfobox.clear;
  kontoinfobox.Visible := false;
 end;

 folder := rightstr(treepath, Length(treepath)-Ansipos('|', treepath));
 folderglobal := folder;

 //DEBUG44
 //mainform.Caption := folder;

 inifile := TBiggerIniFile.Create(ExtractFilePath(Application.ExeName) + 'konten.ini');
 sectionlist := TStringlist.Create;
 inifile.ReadSections(sectionlist);

 for i := 0 to sectionlist.Count-1 do
 begin
  if inifile.ReadString(sectionlist.Strings[i], 'kontoname', '') = kontoname then
  begin
   // Quelltext für laden der Mailliste
   section := sectionlist.Strings[i];
   sectionglobal := section;

   //kontoinfos anzeigen
   if ansipos('|', treepath) = 0 then
   begin
    kontoinfobox.Items.Add('Kontoname: ' + treepath);
    kontoinfobox.Items.Add('Absenderadresse: ' + inifile.ReadString(section, 'abs', ''));
    kontoinfobox.Items.Add('SMTP Server: ' + inifile.ReadString(section, 'smtpserver', ''));
    kontoinfobox.Items.Add('SMTP Port: ' + inifile.ReadString(section, 'smtpport', ''));
    kontoinfobox.Items.Add('Benutzername: ' + inifile.ReadString(section, 'benutzername', ''));
    //BUILD88
    //kontoinfobox.Items.Add('Passwort: ' + xorstring(inifile.ReadString(section, 'password', ''), 'nethanolove'));
    kontoinfobox.Items.Add('Passwort: ' + inifile.ReadString(section, 'password', ''));
   end;

   if folder = 'Empfänger' then
   begin
    mailview.Lines.Clear;
    mailbetreff.Text := '';

    elist.Visible:= true;
    maillist.Visible := false;
    if fileexists(ExtractFilePath(Application.ExeName) + 'konten\'+section+'\receivers.gtl') then
    begin
     elist.Items.LoadFromFile(ExtractFilePath(Application.ExeName) + 'konten\'+section+'\receivers.gtl');
    end
    else elist.Items.Clear;
   end

   else if folder = 'Entwürfe' then
   begin
    mailview.Lines.Clear;
    mailbetreff.Text := '';
    elist.Visible:= false;
    maillist.Clear;
    maillist.Visible := true;

    filelist := TStringlist.Create;

    GetFilesInDirectory(ExtractFilePath(Application.ExeName) +
                        'konten\'+section+ '\Entwurf\', '*.ini', filelist, false);

    for j := 0 to filelist.Count-1 do
    begin
     readfile := TBiggerIniFile.Create(filelist.Strings[j]);

     with  maillist do begin
      ListItem := Items.Add;
      ListItem.Caption := readfile.ReadString('message', 'betreff', '');

      anhangfilelist := TStringList.Create;
      anhangfilelist.CommaText := readfile.ReadString('message', 'anhang', '');
      anhangsize := 0;
      if anhangfilelist.Count > 0 then
      begin
       for k := 0 to anhangfilelist.Count-1 do
       begin
        anhangsize := anhangsize + MyGetFileSize(anhangfilelist.Strings[k]);
       end;
      end;
      anhangfilelist.Free;

      ListItem.SubItems.Add( IntToStr(MyGetFileSize(filelist.Strings[j])+anhangsize) + ' Byte' );
      ListItem.SubItems.Add(readfile.ReadString('message', 'datum', ''));
    end;

     readfile.Free;
    end;

    filelist.Free;
   end

   else if folder = 'Gesendet' then
   begin
    mailview.Lines.Clear;
    mailbetreff.Text := '';

    elist.Visible:= false;
    maillist.Clear;
    maillist.Visible := true;

    filelist := TStringlist.Create;

    GetFilesInDirectory(ExtractFilePath(Application.ExeName) +
                        'konten\'+section+ '\Gesendet\', '*.ini', filelist, false);

    for j := 0 to filelist.Count-1 do
    begin
     readfile := TBiggerIniFile.Create(filelist.Strings[j]);

     with  maillist do begin
      ListItem := Items.Add;
      ListItem.Caption := readfile.ReadString('message', 'betreff', '');

      anhangfilelist := TStringList.Create;
      anhangfilelist.CommaText := readfile.ReadString('message', 'anhang', '');
      anhangsize := 0;
      if anhangfilelist.Count > 0 then
      begin
       for k := 0 to anhangfilelist.Count-1 do
       begin
        anhangsize := anhangsize + MyGetFileSize(anhangfilelist.Strings[k]);
       end;
      end;
      anhangfilelist.Free;

      ListItem.SubItems.Add( IntToStr(MyGetFileSize(filelist.Strings[j])+anhangsize) + ' Byte' );
      ListItem.SubItems.Add(readfile.ReadString('message', 'datum', ''));
     end
    end
   end
   
   else if folder = 'Papierkorb' then
   begin
    mailview.Lines.Clear;
    mailbetreff.Text := '';

    elist.Visible:= false;
    maillist.Clear;
    maillist.Visible := true;
   end;
  end;
 end;

 sectionlist.Free;
 inifile.Free;
end;

procedure TFormMain.maintimerTimer(Sender: TObject);
begin
 if reload = true then
 begin
  reloaddata();
  reload := false;
 end;

 if reload2 = true then
 begin
  if fileexists(ExtractFilePath(Application.ExeName) + 'konten\' + sectionglobal + '\receivers.gtl') then
  begin
   elist.Items.LoadFromFile(ExtractFilePath(Application.ExeName) + 'konten\'+sectionglobal+'\receivers.gtl');
  end;
  reload2 := false;
 end;

 if reload3 = true then
 begin
  treeviewClick(Sender);
  reload3 := false;
 end;

end;

procedure TFormMain.Bearbeiten1Click(Sender: TObject);
begin
 if folderglobal = 'Empfänger' then
 begin
   editrecievers.showmodal;
 end
 else if folderglobal = 'Entwürfe' then
 begin
  if maillist.Selected = nil then
  begin
   MessageDlg('Es ist kein Entwurf zum Bearbeiten ausgewählt!', mtInformation, [mbOk], 0);
   exit;
  end;
  bearbeiten := true;
  listindex := maillist.Selected.Index;
  createnewmail.showmodal;
 end
 else if folderglobal = 'Gesendet' then
 begin
  if maillist.Selected = nil then
  begin
   MessageDlg('Es ist keine Mail zum Bearbeiten ausgewählt!', mtInformation, [mbOk], 0);
   exit;
  end;
  bearbeiten := true;
  bearbeitenges := true;
  listindex := maillist.Selected.Index;
  createnewmail.showmodal;
  bearbeitenges := false;
 end
 else
 begin
  kontoedit := true;
  createkontoform.showmodal;
 end;
end;

procedure TFormMain.Verfassen1Click(Sender: TObject);
begin
 smtpmessage.Clear;
 createnewmail.showmodal;
end;

procedure TFormMain.SpeedButton1Click(Sender: TObject);
begin
 Verfassen1Click(Sender);
end;

procedure TFormMain.SpeedButton2Click(Sender: TObject);
begin
 Bearbeiten1Click(Sender);
end;

procedure TFormMain.FormPaint(Sender: TObject);
begin
 mailbetreff.Width := mailbetreffpanel.Width-4;
end;

procedure TFormMain.maillistClick(Sender: TObject);
var vfilelist: TStrings;
    //vinifile: TIniFile;
    vinifile: TBiggerIniFile;
    test: string;
begin
if folderglobal = 'Entwürfe' then
begin
 // Verhindert eine Schutzverletzung
 if maillist.Selected = nil then exit;

 vfilelist := TStringList.Create;

 GetFilesInDirectory(ExtractFilePath(Application.ExeName) +
                     'konten\'+sectionglobal+ '\Entwurf\', '*.ini', vfilelist, false);

 mailglobal := vfilelist.Strings[maillist.Selected.Index];
 vinifile := TBiggerIniFile.Create(vfilelist.Strings[maillist.Selected.Index]);

 mailbetreff.Text := vinifile.ReadString('message', 'betreff', '');

 mailview.Lines.Delimiter := #254;
 mailview.Lines.quotechar := #255;
 mailview.Lines.DelimitedText := vinifile.ReadString('message', 'body', '');

  // Anhang adden
 anhangview.Items.CommaText := vinifile.ReadString('message', 'anhang', '');

 {
 if file exists in anhang ordner dann
 }


 vinifile.Free;
 vfilelist.Free;
end
else if folderglobal = 'Gesendet' then
begin
 // Verhindert eine Schutzverletzung
 if maillist.Selected = nil then exit;

 vfilelist := TStringList.Create;

 GetFilesInDirectory(ExtractFilePath(Application.ExeName) +
                     'konten\'+sectionglobal+ '\Gesendet\', '*.ini', vfilelist, false);

 mailglobal := vfilelist.Strings[maillist.Selected.Index];
 vinifile := TBiggerIniFile.Create(vfilelist.Strings[maillist.Selected.Index]);

 mailbetreff.Text := vinifile.ReadString('message', 'betreff', '');

 mailview.Lines.Delimiter := #254;
 mailview.Lines.quotechar := #255;
 test := vinifile.ReadString('message', 'body', '');
 mailview.Lines.DelimitedText := vinifile.ReadString('message', 'body', '');

  // Anhang adden
 anhangview.Items.CommaText := vinifile.ReadString('message', 'anhang', '');

 {
 if file exists in anhang ordner dann
 }


 vinifile.Free;
 vfilelist.Free;
end;

end;

procedure TFormMain.Anhangspeichernunter1Click(Sender: TObject);
var
 zielfolder : string;
 mailfolder: string;
begin
 if anhangview.Items.count = 0 then
  begin
  MessageDlg('Keine Einträge in der Liste.', mtInformation, [mbOk], 0);
  exit;
  end;

 if anhangview.ItemIndex = -1 then
  begin
  MessageDlg('Keine Eintrag ausgewählt.', mtInformation, [mbOk], 0);
  exit;
  end;

 zielfolder := GetFolder(CSIDL_DRIVES, 'Zielverzeichnis wählen');
 mailfolder := LeftStr(mailglobal, ansipos('.ini', mailglobal)-1);

 if folderglobal = 'Entwürfe' then
 begin
  CopyFile(PChar(mailfolder + '\' + anhangview.Items[anhangview.ItemIndex]),
  PChar(zielfolder + ExtractFileName(anhangview.Items[anhangview.ItemIndex])), true);
 end
 else if folderglobal = 'Gesendet' then
 begin
  CopyFile(PChar(mailfolder + '\' + anhangview.Items[anhangview.ItemIndex]),
  PChar(zielfolder + ExtractFileName(anhangview.Items[anhangview.ItemIndex])), true);
 end;
end;

procedure TFormMain.Kontolschen1Click(Sender: TObject);
var inifile: TBiggerIniFile;
begin
if MessageDlg('Möchten Sie das markierte Konto wirklich löschen?',
   mtConfirmation, [mbNo, mbYes], 0) = mrYes then
   begin
    DelDir(ExtractFilePath(Application.ExeName) + 'Konten\' + sectionglobal);
    //+ '\');
    inifile := TBiggerIniFile.Create(ExtractFilePath(Application.ExeName) + 'konten.ini');
    inifile.EraseSection(sectionglobal);
    inifile.Free;
    reload := true;
   end;
end;

procedure TFormMain.FormDestroy(Sender: TObject);
begin
  HHCloseAll; // Schließt alle Hilfe-Fenster
  if Assigned(mHHelp) then
    mHHelp.Free;
end;

procedure TFormMain.Inhalt1Click(Sender: TObject);
begin
 Application.HelpContext(10);
end;

procedure TFormMain.HilfezurHilfe1Click(Sender: TObject);
begin
 Application.HelpFile := ExtractFilePath(Application.ExeName) + 'gtnewsletter.chm';
 Application.HelpCommand(HELP_HELPONHELP, 0);
end;

end.
