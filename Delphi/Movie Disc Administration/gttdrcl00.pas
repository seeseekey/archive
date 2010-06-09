unit gttdrcl00;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Menus, ExtCtrls, StdCtrls, ComCtrls, gttdrcl01, gtvcl_ListValueBox, bigini, globals,
  gttdrcl02, gttdrcl03, Printers, gtcl_FileSystem;

type
  Tmainform = class(TForm)
    mainmenu: TMainMenu;
    Datei1: TMenuItem;
    Beenden1: TMenuItem;
    leftpanel: TPanel;
    rightpanel: TPanel;
    leftsubpanel: TPanel;
    mainedit: TEdit;
    mainnewbutton: TButton;
    maineditbutton: TButton;
    maintimer: TTimer;
    mainlistbox: TGT_ListValueBox;
    mainsearchbutton: TButton;
    maindeletebutton: TButton;
    NeuerDatensatz1: TMenuItem;
    Datensatzbearbeiten1: TMenuItem;
    Datensatzlschen1: TMenuItem;
    Suchen1: TMenuItem;
    N2: TMenuItem;
    N4: TMenuItem;
    datacount: TLabel;
    printfield: TRichEdit;
    N7: TMenuItem;
    infofield00: TRichEdit;
    platzhalter: TPanel;
    N1: TMenuItem;
    Extras1: TMenuItem;
    Listeinlistetxtspeichern1: TMenuItem;
    procedure printdoc(Sender: TObject);
    procedure reloaddata(Sender: TObject);
    procedure deleteitem;
    procedure maintimerTimer(Sender: TObject);
    procedure mainnewbuttonClick(Sender: TObject);
    procedure maineditChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure listclear1Click(Sender: TObject);
    procedure mainlistboxClick(Sender: TObject);
    procedure maineditKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure maineditbuttonClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure mainlistboxKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure maindeletebuttonClick(Sender: TObject);
    procedure NeuerDatensatz1Click(Sender: TObject);
    procedure Datensatzbearbeiten1Click(Sender: TObject);
    procedure Datensatzlschen1Click(Sender: TObject);
    procedure mainsearchbuttonClick(Sender: TObject);
    procedure Suchen1Click(Sender: TObject);
    procedure Beenden1Click(Sender: TObject);
    procedure Inhalt1Click(Sender: TObject);
    procedure Index1Click(Sender: TObject);
    procedure HilfezurHilfe1Click(Sender: TObject);
    procedure splitterMoved(Sender: TObject);
    procedure Listeinlistetxtspeichern1Click(Sender: TObject);
  private

  public
    { Public-Deklarationen }
  end;

var
  mainform: Tmainform;

{  type
   TFontStyle = (fsBold, fsItalic, fsUnderline, fsStrikeOut);
   TFontStyles = set of TFontStyle;      }

implementation

{$R *.DFM}

// Diese Funktion druckt ein Richedit Feld mit Rand
procedure Tmainform.printdoc(Sender: TObject);
 var
   presX, presY: Integer;
   r: TRect;
begin
  with printfield do begin
    //plaintext := true;
    //lines.loadfromfile( changefileext( application.exename, '.DPR' ));
  end;
  presX := GetDeviceCaps( printer.handle, LOGPIXELSX );
  presY := GetDeviceCaps( printer.handle, LOGPIXELSY );
  with r do begin
    left := presX;  // 1 inch linker Rand
    top  := 3 * presY div 2;  // 1.5 inch oberer Rand
    right := Printer.PageWidth - 3 * presX div 4; // 0.75 inch right margin
    bottom := Printer.PageHeight - presY; // 1 inch unterer Rand
  end;
  with printfield do begin
    Pagerect := r;
    Print('Total Data Recall');
  end;
end;

function Search(ugw00: TStrings; suchtext: string) : Longint;
var
 searchlist: TStringList; //Stringliste in welcher gesucht wird
 vstring: string; //String mit welchem verglichen wird
 stringindexcounter: Cardinal; //Momentane Position innerhalb der Strings
 listindexcounter: Cardinal; //Index zum zählen des momentanen Indizes
 prioty: Cardinal; //Gibt die momentane Suchprirität an
 listjumper: Boolean; //Status für Sprung aus Listendurchlaufsschleife
 stringjumper: Boolean; //Status für Sprung aus der Stringschleife
begin
 result := -1;
 listjumper := false;
 stringjumper := false;
 listindexcounter := 0;
 stringindexcounter := 1;
 prioty := 1;
 suchtext := lowercase(suchtext);

 if suchtext = '' then listjumper := true;
  searchlist := TStringList.Create; //Erstellen der Stringliste
 try
  searchlist.AddStrings(ugw00); //Füllen der Stringliste

  while listjumper = false do //While Schleife für Durchlauf der Stringliste
  begin
   vstring := searchlist.strings[listindexcounter]; //VString den einen Wert aus der Stringliste zuweisen
   vstring := lowercase(vstring);

   while stringjumper = false do
   begin
    if vstring[stringindexcounter] = suchtext[stringindexcounter] then
     begin
      inc(prioty);
      inc(stringindexcounter);
      if stringindexcounter = prioty then result := searchlist.IndexOf(vstring);
      if stringindexcounter > Length(suchtext) then begin listjumper := true; prioty:=1;stringjumper := true; stringindexcounter := 1; end
     end
    else
     begin
      stringindexcounter := 1;
      prioty := 1;
      stringjumper := true;
     end;
   end;

   stringjumper := false;

   inc(listindexcounter);
   if searchlist.count = listindexcounter then listjumper := true;
  end;

 finally
  searchlist.Free; //Freigeben der Stringliste
 end;
end;

procedure Tmainform.reloaddata(Sender: TObject);
 //lädt die Daten neu
var BigIniFile : TBiggerIniFile;
    sectionlist: TStringList;
    i: Cardinal;
    namespacestring: string;
    indexstring: string;
//    sectionkey : string;
begin
if mainlistbox.itemindex <> -1 then indexstring := mainlistbox.Items.Strings[mainlistbox.itemindex];
sectionlist := TStringList.Create;
try
  mainlistbox.Items.BeginUpdate;
  mainlistbox.Clear;
if FileExists(ExtractFilePath(Application.ExeName)+'movie.rcf') = true then
 begin
  BigIniFile := TBiggerIniFile.Create(ExtractFilePath(Application.ExeName)+'movie.rcf');
  BigIniFile.ReadSections(sectionlist);
  //mainlistbox.Items := sectionlist;
  i := 0;
  while(i < sectionlist.count) do
  begin
  // füllen der ListBox
   namespacestring := '';

   namespacestring := BigIniFile.ReadString(sectionlist.Strings[i], 'filmname', '');

   mainlistbox.Items.Add(namespacestring);
   mainlistbox.ValueList.Add(sectionlist.Strings[i]);
   inc(i);
  end;

  datacount.Caption := 'Anzahl der Datensätze: ' + inttostr(mainlistbox.Items.count);
  BigIniFile.Free;
 end;

finally
 mainlistbox.Items.EndUpdate;
 sectionlist.free;
 mainlistbox.Sort;
 reload := false;

  if mainlistbox.Items.Count = 0 then
 begin
  infofield00.clear;
  //exit;
 end;
//if mainlistbox.itemindex <> -1 then
//if mainlistbox.itemindex <> -1 then
//begin
if mainlistbox.Count <> 0 then mainlistbox.Itemindex := Search(mainlistbox.items, indexstring);
//end;
 //mainlistbox.ItemIndex := 0;
//if mainlistbox.itemindex <> -1 then begin  mainlistboxClick(Sender);  end;

if reloadview = true then
 begin
   mainlistbox.Itemindex := Search(mainlistbox.items, createsearch);
   createsearch := '';
  mainlistboxClick(sender);
  reloadview := false;
 end;

if createsearch <> '' then  // new sys
 begin
   mainlistbox.Itemindex := Search(mainlistbox.items, createsearch);
   createsearch := '';
   mainlistboxClick(sender);
 end;

if (delsearch <> '') and (mainlistbox.Count > 0) then  // del sys
 begin
    if deloldindex > 0 then mainlistbox.Itemindex := deloldindex-1
    else  mainlistbox.Itemindex := 0;

    mainlistboxClick(sender);
    delsearch := '';
 end;                                         



                  
end;
end;

procedure Tmainform.deleteitem;
var BigIniFile : TBiggerIniFile;
begin
if mainlistbox.ItemIndex = -1 then exit;
  BigIniFile := TBiggerIniFile.Create(ExtractFilePath(Application.ExeName)+'movie.rcf');
  BigIniFile.EraseSection(mainlistbox.ValueList.Strings[mainlistbox.itemindex]);
  BigIniFile.Free;
  //mainlistbox.Items.Delete(mainlistbox.itemindex);
  infofield00.clear;


  reload := true;
end;

procedure Tmainform.maintimerTimer(Sender: TObject);
var i: integer;
begin
{
//infofield00.SelAttributes
infofield00.Lines.Clear;
  with infofield00.SelAttributes do
  begin
    Color := clBlack;
    //Height := 14;
    Size := 14;
  end;
  infofield00.Lines.Add('Bottke, Florian');
 }
  //listbox1.Items := mainlistbox.ValueList;
// real timer source
//if mainlistbox.ItemIndex = -1 then maineditbutton.Enabled := false Datensatzlschen1.enabled :=
//else maineditbutton.Enabled := true;
if searchswitch = true then
 begin
  searchswitch := false;
  for i:=0 to mainlistbox.count do
  begin
   if mainlistbox.ValueList.Strings[i] = searchkey then
    begin
//     pagecontrol.ActivePageIndex := searchpage;  //enthält fehler bei der anzeige
     mainlistbox.ItemIndex := i;

     mainlistboxClick(Sender);
     break;
    end;
  end;
 end;

if reload = true then reloaddata(Sender);
end;

procedure Tmainform.mainnewbuttonClick(Sender: TObject);
begin
childform00.showmodal;
end;

procedure Tmainform.maineditChange(Sender: TObject);
begin
try
   mainlistbox.Itemindex := Search(mainlistbox.items, mainedit.text);
except
end;
end;

procedure Tmainform.FormCreate(Sender: TObject);
var BigIniFile : TBiggerIniFile;
    sectionlist: TStringList;
    i: Cardinal;
    namespacestring: string;
//    sectionkey : string;
begin
mainform.DoubleBuffered := true;
//PwdEncodeFile(ExtractFilePath(Application.ExeName)+'movie.rcf', 'jessica');
 //TBiggerIniFile.Create(ExtractFilePath(Application.ExeName)+'movie.rcf');
if FileExists(ExtractFilePath(Application.ExeName)+'movie.vcf') = true then
 begin
  xorfile(ExtractFilePath(Application.ExeName)+'movie.vcf',
        ExtractFilePath(Application.ExeName)+'movie.rcf',
        'jessica');
  //decodefile(ExtractFilePath(Application.ExeName)+'movie.rcf');
 end;

creategloballist;
createconvertlist;
sectionlist := TStringList.Create;
try
 mainlistbox.Items.BeginUpdate;
if FileExists(ExtractFilePath(Application.ExeName)+'movie.rcf') = true then
 begin
  BigIniFile := TBiggerIniFile.Create(ExtractFilePath(Application.ExeName)+'movie.rcf');
  BigIniFile.ReadSections(sectionlist);
  //mainlistbox.Items := sectionlist;
  i := 0;
  while(i < sectionlist.count) do
  begin
   namespacestring := '';

   namespacestring := BigIniFile.ReadString(sectionlist.Strings[i], 'filmname', '');

   mainlistbox.Items.Add(namespacestring);
   mainlistbox.ValueList.Add(sectionlist.Strings[i]);
   inc(i);
  end;

  datacount.Caption := 'Anzahl der Datensätze: ' + inttostr(mainlistbox.Items.count);
  BigIniFile.Free;
 end;

finally
 mainlistbox.Items.EndUpdate;
 sectionlist.free;
 mainlistbox.Sort;
 mainlistbox.ItemIndex := 0;
 mainlistboxClick(Sender);
 //if mainlistbox.ItemIndex = -1 then maineditbutton.Enabled := false;
 // reload := false;
end;
end;

procedure Tmainform.listclear1Click(Sender: TObject);
begin
reloaddata(Sender);
end;

procedure Tmainform.mainlistboxClick(Sender: TObject);
var BigIniFile : TBiggerIniFile;
    sectionlist: TStringList;
    tmpstr: string;
    spaceswitch: boolean;
begin
if mainlistbox.Items.Count = 0 then
 begin
  infofield00.clear;

  exit;
 end;

spaceswitch := false;
BigIniFile := TBiggerIniFile.Create(ExtractFilePath(Application.ExeName)+'movie.rcf');
try

  infofield00.Clear;
  infofield00.SelAttributes.Size := 14;

  infofield00.Lines.Add(BigIniFile.ReadString(mainlistbox.ValueList.Strings[mainlistbox.itemindex], 'filmname', ''));

   infofield00.SelAttributes.Size := 10;

if (BigIniFile.ReadString(mainlistbox.ValueList.Strings[mainlistbox.itemindex], 'laenge', '') <> '') then
begin
  infofield00.Lines.Add('Länge: ' +BigIniFile.ReadString(mainlistbox.ValueList.Strings[mainlistbox.itemindex], 'laenge', ''));
end;

if (BigIniFile.ReadString(mainlistbox.ValueList.Strings[mainlistbox.itemindex], 'sprache', '') <> '') then
begin
  infofield00.Lines.Add('Sprache: ' +BigIniFile.ReadString(mainlistbox.ValueList.Strings[mainlistbox.itemindex], 'sprache', ''));
end;

if (BigIniFile.ReadString(mainlistbox.ValueList.Strings[mainlistbox.itemindex], 'md', '') <> '') then
begin
  infofield00.Lines.Add('Movie Disc: ' +BigIniFile.ReadString(mainlistbox.ValueList.Strings[mainlistbox.itemindex], 'md', ''));
end;

    infofield00.Lines.Add('');
    infofield00.Lines.Add('Inhalt: ');

    if BigIniFile.ReadString(mainlistbox.ValueList.Strings[mainlistbox.itemindex],'inhalt', '') <> '' then
    begin
         fillconvertlistwithcommatext(
         BigIniFile.ReadString(mainlistbox.ValueList.Strings[mainlistbox.itemindex],
         'inhalt', ''));
         infofield00.Lines.AddStrings(convertlist);
    end
    else  infofield00.Lines.Add('-');

finally
BigIniFile.Free;
end;

end;

procedure Tmainform.maineditKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
if key = VK_RETURN then
 begin
  try
   mainlistboxClick(Sender);
//   mainedit.text := '';
  except
   mainlistbox.ItemIndex := 0;
   mainlistboxClick(Sender);
  end;
 end
else if key = VK_UP then
 begin
    if mainlistbox.ItemIndex = 0 then mainlistbox.ItemIndex := 0
    else mainlistbox.ItemIndex := mainlistbox.ItemIndex-1;
    mainlistboxClick(Sender);
 end
else if key = VK_DOWN then
 begin
    if mainlistbox.ItemIndex = mainlistbox.Count then mainlistbox.Count
    else mainlistbox.ItemIndex := mainlistbox.ItemIndex+1;
    mainlistboxClick(Sender);
 end;
end;

procedure Tmainform.maineditbuttonClick(Sender: TObject);
begin


if mainlistbox.itemindex = -1 then MessageDlg('Kein Datensatz ausgewählt!', mtInformation,[mbOk], 0)
else
 begin
 //globallist.Strings := mainlistbox.ValueList.Strings;
  globallist.Clear;
  globallist.Assign(mainlistbox.valuelist);
  globallistindex := mainlistbox.ItemIndex;
  childform01.showmodal;
 end;
end;

procedure Tmainform.FormClose(Sender: TObject; var Action: TCloseAction);
begin
deletegloballist;
deleteconvertlist;
if FileExists(ExtractFilePath(Application.ExeName)+'movie.rcf') = true then
 begin
  xorfile(ExtractFilePath(Application.ExeName)+'movie.rcf',
        ExtractFilePath(Application.ExeName)+'movie.vcf',
        'jessica');
  DeleteFile(ExtractFilePath(Application.ExeName)+'movie.rcf');
  //encodefile(ExtractFilePath(Application.ExeName)+'movie.rcf');
 end;
end;

procedure Tmainform.mainlistboxKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
if key = vk_delete then maindeletebuttonClick(Sender);
end;

procedure Tmainform.maindeletebuttonClick(Sender: TObject);
begin
if mainlistbox.itemindex = -1 then MessageDlg('Kein Datensatz ausgewählt!', mtInformation,[mbOk], 0)
else
 begin
  if MessageDlg('Möchten sie den ausgewählten Datensatz wirklich löschen?',
    mtConfirmation, [mbYes, mbNo], 0) = mrYes then
     begin
      deleteitem;
      delsearch:= mainlistbox.Items[mainlistbox.itemindex];
      deloldindex := mainlistbox.itemindex;
    end;
 end;
end;
procedure Tmainform.NeuerDatensatz1Click(Sender: TObject);
begin
mainnewbuttonClick(Sender);
end;

procedure Tmainform.Datensatzbearbeiten1Click(Sender: TObject);
begin
maineditbuttonClick(Sender);
end;

procedure Tmainform.Datensatzlschen1Click(Sender: TObject);
begin
maindeletebuttonClick(Sender);
end;

procedure Tmainform.mainsearchbuttonClick(Sender: TObject);
begin

 //globallist.Strings := mainlistbox.ValueList.Strings;
  globallist.Clear;
  globallist.Assign(mainlistbox.valuelist);
//  globallistindex := mainlistbox.ItemIndex;

mainsearchform.showmodal;
end;

procedure Tmainform.Suchen1Click(Sender: TObject);
begin
mainsearchbuttonClick(Sender);
end;

procedure Tmainform.Beenden1Click(Sender: TObject);
begin
mainform.close;
end;

procedure Tmainform.Inhalt1Click(Sender: TObject);
begin
Application.HelpFile := ExtractFilePath(Application.ExeName) + 'tdr.hlp';
Application.HelpCommand(HELP_SETWINPOS,SW_SHOWMAXIMIZED);
Application.HelpCommand(HELP_FINDER, 0);
{
Application.HelpCommand(HELP_FINDER, 150);
}
end;

procedure Tmainform.Index1Click(Sender: TObject);
begin
Application.HelpFile := ExtractFilePath(Application.ExeName) + 'tdr.hlp';
Application.HelpCommand(HELP_SETWINPOS,SW_SHOWMAXIMIZED);
Application.HelpCommand(HELP_KEY, 0);
end;

procedure Tmainform.HilfezurHilfe1Click(Sender: TObject);
begin
Application.HelpFile := ExtractFilePath(Application.ExeName) + 'tdr.hlp';
Application.HelpCommand(HELP_HELPONHELP, 0);
end;

procedure Tmainform.splitterMoved(Sender: TObject);
begin
mainnewbutton.left := leftsubpanel.width - 88;
maineditbutton.Left := leftsubpanel.width - 169;
mainedit.Width := leftsubpanel.Width - 16;
mainsearchbutton.Width := leftsubpanel.Width - 16;
//mainform.Caption := 'moved';
end;



{
procedure DruckeMemo(aMemo:TMemo);
var
  PrnFile: TextFile;
  i:integer;
begin
  AssignPrn(PrnFile);
  Rewrite(PrnFile);
  for i:=0 to aMemo.Lines.Count-1 do Writeln(PrnFile, aMemo.Lines[i]);
  System.CloseFile(PrnFile);
end; // DruckeMemo
}





procedure Tmainform.Listeinlistetxtspeichern1Click(Sender: TObject);
begin
  mainlistbox.Items.SaveToFile(gtFileSystem.GetApplicationPath + 'liste.txt');
end;

end. // Programmende
