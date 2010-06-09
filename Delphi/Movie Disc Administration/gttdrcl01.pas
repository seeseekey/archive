unit gttdrcl01;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, ComCtrls, bigini, globals;

type
  Tchildform00 = class(TForm)
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
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormShow(Sender: TObject);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  childform00: Tchildform00;

implementation

{$R *.DFM}

procedure Tchildform00.OKClick(Sender: TObject);
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


childform00.close;
end;

procedure Tchildform00.cancelClick(Sender: TObject);
begin
  filmname.text := '';
  inhalt.text := '';
  laenge.text := '';
  md.text := '';
childform00.close;
end;

procedure Tchildform00.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
 cancelClick(Sender);
end;

procedure Tchildform00.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
// F12 Beenden ubd speichern
// ESC Abbrechen
 if key = VK_F12 then
  begin
   OKClick(Sender);
  end
 else if key = VK_ESCAPE then
  begin
   cancelClick(Sender);
  end
end;

procedure Tchildform00.FormShow(Sender: TObject);
begin
filmname.SetFocus;
end;

end.
