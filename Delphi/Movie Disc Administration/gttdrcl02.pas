unit gttdrcl02;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, ComCtrls, bigini, globals;

type
  Tchildform01 = class(TForm)
    panel: TPanel;
    OK: TButton;
    cancel: TButton;
    Label25: TLabel;
    Label26: TLabel;
    Label27: TLabel;
    Label29: TLabel;
    filmname: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    laenge: TEdit;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    inhalt: TMemo;
    sprache: TComboBox;
    md: TComboBox;
    procedure OKClick(Sender: TObject);
    procedure cancelClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  childform01: Tchildform01;
  oldsectionkey: string;

implementation

{$R *.DFM}

procedure Tchildform01.OKClick(Sender: TObject);
var BigIniFile : TBiggerIniFile;
    sectionkey : string;
    DateTime : TDateTime;
//  buffer: byte;
begin
if (filmname.text = '') then
begin
 MessageDlg('Der Filmname muss eingegeben werden.', mtInformation,[mbOk], 0);
 exit;
end;

reload := true;

  randomize;
  DateTime := Time;
  sectionkey :=   '#'+filmname.Text+'#'+laenge.Text+sprache.text+md.text+
                  inttostr(random(100000000))+TimeToStr(DateTime);

  BigIniFile := TBiggerIniFile.Create(ExtractFilePath(Application.ExeName)+'movie.rcf');
    BigIniFile.EraseSection(oldsectionkey);

  BigIniFile.WriteString(sectionkey,'filmname', filmname.text);
  BigIniFile.WriteString(sectionkey,'inhalt', inhalt.Lines.CommaText);
  BigIniFile.WriteString(sectionkey,'laenge', laenge.text);
  BigIniFile.WriteString(sectionkey,'sprache', sprache.text);
  BigIniFile.WriteString(sectionkey,'md', md.text);

  BigIniFile.Free;

  createsearch := filmname.text;

  filmname.text := '';
  inhalt.text := '';
  laenge.text := '';
  sprache.Text := '';
  md.text := '';

cancelClick(Sender);
end;

procedure Tchildform01.cancelClick(Sender: TObject);
begin
  filmname.text := '';
  inhalt.text := '';
  laenge.text := '';
  md.text := '';
childform01.close;
end;

procedure Tchildform01.FormShow(Sender: TObject);
var BigIniFile : TBiggerIniFile;
    sectionkey : string;
//  buffer: byte;
begin
filmname.SetFocus;
//reload := true;
  BigIniFile := TBiggerIniFile.Create(ExtractFilePath(Application.ExeName)+'movie.rcf');

 { sectionkey :=   name.Text+vorname.Text+vorname2.text+rufname.text+
                  geburtstag.text+geborenals.text+geschlecht.text+
                  naturhaarfarbe.text+muttersprache.text+schulabschluss.text;     }

  sectionkey := globallist.Strings[globallistindex];
  oldsectionkey := sectionkey;

filmname.text := BigIniFile.ReadString(sectionkey, 'filmname', '');
laenge.text := BigIniFile.ReadString(sectionkey, 'laenge', '');
sprache.text := BigIniFile.ReadString(sectionkey, 'sprache', '');
md.text := BigIniFile.ReadString(sectionkey, 'md', '');

inhalt.lines.CommaText := BigIniFile.ReadString(sectionkey, 'inhalt', '');

BigIniFile.Free;

end;

procedure Tchildform01.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
 cancelClick(Sender);
end;

procedure Tchildform01.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
 if key = VK_F12 then
  begin
   OKClick(Sender);
  end
 else if key = VK_ESCAPE then
  begin
   cancelClick(Sender);
  end
end;

end.
