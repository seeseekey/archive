unit Expu0;

interface

uses
  SysUtils, WinTypes, WinProcs, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, StdCtrls, ExtCtrls, Menus, expu1, expu2, expu17, expu23;

type
  Tstartwindow = class(TForm)
    Image1: TImage;
    Button1: TButton;
    Button2: TButton;
    Label1: TLabel;
    Label2: TLabel;
    MainMenu1: TMainMenu;
    Datei1: TMenuItem;
    DasExperimentbeenden1: TMenuItem;
    N2: TMenuItem;
    Spielladen1: TMenuItem;
    N1: TMenuItem;
    Information1: TMenuItem;
    Spielstarten1: TMenuItem;
    OpenDialog: TOpenDialog;
    procedure Button2Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Spielbeenden1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure DasExperimentbeenden1Click(Sender: TObject);
    procedure Information1Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Spielstarten1Click(Sender: TObject);
    procedure Spielladen1Click(Sender: TObject);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  startwindow: Tstartwindow;
  F: TextFile;
  zeile: string[1];
  spielstand: string;

implementation

{$R *.DFM}

procedure Tstartwindow.Button2Click(Sender: TObject);
begin
close;
end;

procedure Tstartwindow.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if MessageDlg('Möchten sie das Spiel wirklich beenden?',
     mtConfirmation,
    [mbYes, mbNo], 0) = mrYes then
    Action := caFree
  else
    Action := caNone;
end;

procedure Tstartwindow.Spielbeenden1Click(Sender: TObject);
begin
close;
expu0.startwindow.show;
end;

procedure Tstartwindow.FormCreate(Sender: TObject);
begin
{spielbeenden1.Visible := False; }
{spielbeenden1.Enabled:= False;}
end;

procedure Tstartwindow.DasExperimentbeenden1Click(Sender: TObject);
begin
close;
end;

procedure Tstartwindow.Information1Click(Sender: TObject);
begin
infobox.ShowModal;
end;

procedure Tstartwindow.Button1Click(Sender: TObject);
begin
expu2.gamestart.show;
end;

procedure Tstartwindow.Spielstarten1Click(Sender: TObject);
begin
expu2.gamestart.show;
end;

procedure Tstartwindow.Spielladen1Click(Sender: TObject);
begin
expu23.fnv.show;
{ opendialog.FileName := '*.egf';
  if opendialog.Execute then

  AssignFile(F, opendialog.FileName);
     if (opendialog.Filename = '') then exit;
  FileMode := 0;
 Memo1.Lines.LoadFromFile(opendialog.Filename);
  if (spielstand = '0') then expu17.terminal.show;
    CloseFile(F); }
end;

end.
