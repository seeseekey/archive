unit gttdrcl03;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, globals, BigIni, gtvcl_ListValueBox, ComCtrls;

type
  Tmainsearchform = class(TForm)
    pagecontrol: TPageControl;
    s_global: TTabSheet;
    Label2: TLabel;
    sf_global: TEdit;
    rb_global: TGT_ListValueBox;
    s_field: TTabSheet;
    sb_global: TButton;
    gz_global: TButton;
    cl_global: TButton;
    Label1: TLabel;
    sf_field: TEdit;
    Label3: TLabel;
    cb_field: TComboBox;
    rb_field: TGT_ListValueBox;
    sb_field: TButton;
    gb_field: TButton;
    cl_fielf: TButton;
    procedure cancelClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure suchenClick(Sender: TObject);
    procedure searchfieldKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure gehezuClick(Sender: TObject);
    procedure resultboxDblClick(Sender: TObject);
    procedure gb_fieldClick(Sender: TObject);
    procedure rb_fieldDblClick(Sender: TObject);
    procedure sb_fieldClick(Sender: TObject);
    procedure sf_fieldKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  mainsearchform: Tmainsearchform;

implementation

{$R *.DFM}

function GiveSearchString(seckey: string) : string;
begin
end;

procedure Tmainsearchform.cancelClick(Sender: TObject);
begin
sf_global.text := '';
sf_field.text := '';
cb_field.Text := '';
rb_global.Clear;
rb_field.clear;
mainsearchform.Close;
end;

procedure Tmainsearchform.FormShow(Sender: TObject);
begin
pagecontrol.ActivePageIndex := 0;
sf_global.SetFocus;
end;

procedure Tmainsearchform.suchenClick(Sender: TObject);
var BigIniFile : TBiggerIniFile;
    i : integer;
    sectionkey: string;
    sectioncomplete: boolean;
    tmpsrclist: TStrings;
begin
  tmpsrclist := TStringList.Create;
// sectioncomplete := false;
 rb_global.clear;
 //globallist
 BigIniFile := TBiggerIniFile.Create(ExtractFilePath(Application.ExeName)+'movie.rcf');
  for i:=0 to globallist.count-1 do
  begin
  sectioncomplete := false;
  // rb_global.items.Assign(globallist);
   sectionkey := globallist.Strings[i];
{
if (BigIniFile.ReadString(sectionkey, 'name', '') <> '') and (BigIniFile.ReadString(sectionkey, 'vorname', '') = '') and  (BigIniFile.ReadString(sectionkey, 'vorname2', '') = '') then
begin rb_global.Items.Add(BigIniFile.ReadString(sectionkey, 'name', '')); end
else if (BigIniFile.ReadString(sectionkey, 'name', '') <> '') then
begin rb_global.Items.Add(BigIniFile.ReadString(sectionkey, 'name', '')+', '+ BigIniFile.ReadString(sectionkey, 'vorname', '')); end
else begin rb_global.Items.Add(BigIniFile.ReadString(sectionkey, 'vorname', '')); end;
 }

   if sectioncomplete = false then begin // wertabfrage start
      if ansipos(lowercase(sf_global.text),
      lowercase(BigIniFile.ReadString(sectionkey, 'filmname', ''))) > 0 then
      begin
           rb_global.Items.Add(BigIniFile.ReadString(sectionkey, 'filmname', ''));
           rb_global.ValueList.Add(sectionkey);
           sectioncomplete := true;
           searchpage := 0;
      end;
   end; // wertabfrage ende

   if sectioncomplete = false then begin // wertabfrage start
      if ansipos(lowercase(sf_global.text),
      lowercase(BigIniFile.ReadString(sectionkey, 'laenge', ''))) > 0 then
      begin
           rb_global.Items.Add(BigIniFile.ReadString(sectionkey, 'filmname', ''));
           rb_global.ValueList.Add(sectionkey);
           sectioncomplete := true;
           searchpage := 0;
      end;
   end; // wertabfrage ende

   if sectioncomplete = false then begin // wertabfrage start
      if ansipos(lowercase(sf_global.text),
      lowercase(BigIniFile.ReadString(sectionkey, 'sprache', ''))) > 0 then
      begin
           rb_global.Items.Add(BigIniFile.ReadString(sectionkey, 'filmname', ''));
           rb_global.ValueList.Add(sectionkey);
           sectioncomplete := true;
           searchpage := 0;
      end;
   end; // wertabfrage ende

   if sectioncomplete = false then begin // wertabfrage start
      if ansipos(lowercase(sf_global.text),
      lowercase(BigIniFile.ReadString(sectionkey, 'md', ''))) > 0 then
      begin
           rb_global.Items.Add(BigIniFile.ReadString(sectionkey, 'filmname', ''));
           rb_global.ValueList.Add(sectionkey);
           sectioncomplete := true;
           searchpage := 0;
      end;
   end; // wertabfrage ende

   if sectioncomplete = false then begin // wertabfrage start //commatextabfrage
      tmpsrclist.CommaText := BigIniFile.ReadString(sectionkey, 'inhalt', '');
      if ansipos(lowercase(sf_global.text),
      lowercase(tmpsrclist.text)) > 0 then
      begin
           rb_global.Items.Add(BigIniFile.ReadString(sectionkey, 'filmname', ''));
           rb_global.ValueList.Add(sectionkey);
           searchpage := 2;
      end;
   end;

   end; // wertabfrage ende


 rb_global.Sort;
 tmpsrclist.free;
 BigIniFile.Free;
end;

procedure Tmainsearchform.searchfieldKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
if key = vk_return then suchenClick(Sender);
end;

procedure Tmainsearchform.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
 rb_global.clear;
 rb_field.clear;
 sf_global.text := '';
 sf_field.text := '';
end;

procedure Tmainsearchform.gehezuClick(Sender: TObject);
begin
if rb_global.itemindex = -1 then MessageDlg('Kein Datensatz ausgewählt!', mtInformation,[mbOk], 0)
else
 begin
  searchkey := rb_global.ValueList.Strings[rb_global.itemindex];
  searchswitch := true;
  mainsearchform.Close;
 end;
end;

procedure Tmainsearchform.resultboxDblClick(Sender: TObject);
begin
gehezuClick(Sender);
end;

procedure Tmainsearchform.gb_fieldClick(Sender: TObject);
begin
if rb_field.itemindex = -1 then MessageDlg('Kein Datensatz ausgewählt!', mtInformation,[mbOk], 0)
else
 begin
  searchkey := rb_field.ValueList.Strings[rb_field.itemindex];
  searchswitch := true;
  mainsearchform.Close;
 end;
end;

procedure Tmainsearchform.rb_fieldDblClick(Sender: TObject);
begin
 gb_fieldClick(Sender);
end;

procedure Tmainsearchform.sb_fieldClick(Sender: TObject);
var BigIniFile : TBiggerIniFile;
    i : integer;
    sectionkey: string;
    keykey: string;
//    sectioncomplete: boolean;
    tmpsrclist: TStrings;
begin
  tmpsrclist := TStringList.Create;
// sectioncomplete := false;
 rb_field.clear;
 //globallist
 BigIniFile := TBiggerIniFile.Create(ExtractFilePath(Application.ExeName)+'movie.rcf');
//########### keykeydefinition

if cb_field.text = 'Filmname' then keykey := 'filmname'
else if cb_field.text = 'Länge' then keykey := 'laenge'
else if cb_field.text = 'Sprache' then keykey := 'sprache'
else if cb_field.text = 'Movie Disc' then keykey := 'md'
else if cb_field.text = 'Inhalt' then keykey := 'inhalt'
else begin cb_field.text := 'Filmname'; keykey := 'filmname'; end;

//########### keykeydefinition ende
if (keykey = 'inhalt') then
begin
  for i:=0 to globallist.count-1 do
      begin
           // sectioncomplete := false;
           // rb_global.items.Assign(globallist);
           sectionkey := globallist.Strings[i];
           //  sectioncomplete = false then begin // wertabfrage start
      if ansipos(lowercase(sf_field.text),
      lowercase(BigIniFile.ReadString(sectionkey, keykey, ''))) > 0 then
      begin
      tmpsrclist.CommaText := BigIniFile.ReadString(sectionkey, keykey, '');
      if ansipos(lowercase(sf_field.text), lowercase(tmpsrclist.text)) > 0 then
      begin
           rb_field.Items.Add(BigIniFile.ReadString(sectionkey, 'filmname', ''));
           rb_field.ValueList.Add(sectionkey);
           //sectioncomplete := true;
           // searchpage := 0; erweiterte searchpageauswertung muss vorgenommen werden
      end;
    // wertabfrage ende
  end; // for schleife ende
//           searchpage := 7;
      end;
end
// lebenslauf
else
begin
  for i:=0 to globallist.count-1 do
  begin
 // sectioncomplete := false;
  // rb_global.items.Assign(globallist);
   sectionkey := globallist.Strings[i];
 //  sectioncomplete = false then begin // wertabfrage start
      if ansipos(lowercase(sf_field.text),
      lowercase(BigIniFile.ReadString(sectionkey, keykey, ''))) > 0 then
      begin
           rb_field.Items.Add(BigIniFile.ReadString(sectionkey, 'filmname', ''));
           rb_field.ValueList.Add(sectionkey);
           //sectioncomplete := true;
           // searchpage := 0; erweiterte searchpageauswertung muss vorgenommen werden
      end;
    // wertabfrage ende
  end; // for schleife ende
end;

 rb_field.Sort;
 tmpsrclist.free;
 BigIniFile.Free;
end;

procedure Tmainsearchform.sf_fieldKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
if key = vk_return then sb_fieldClick(Sender);
end;

procedure Tmainsearchform.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
if key = VK_ESCAPE then
  begin
   cancelClick(Sender);
  end;
end;

end.
