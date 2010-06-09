unit Expu18;

interface

uses
  SysUtils, WinTypes, WinProcs, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, StdCtrls, ExtCtrls, Menus, expu1, FMXUtils;

type
  Tgameterminal = class(TForm)
    Image1: TImage;
    aufgabentext: TLabel;
    antwortc: TButton;
    antwortb: TButton;
    antworta: TButton;
    ende: TButton;
    procedure Button2Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure DasExperimentbeenden1Click(Sender: TObject);
    procedure Information1Click(Sender: TObject);
    procedure endeClick(Sender: TObject);
    procedure antwortaClick(Sender: TObject);
    procedure antwortbClick(Sender: TObject);
    procedure antwortcClick(Sender: TObject);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  gameterminal: Tgameterminal;

implementation

{$R *.DFM}

procedure Tgameterminal.Button2Click(Sender: TObject);
begin
close;
end;

procedure Tgameterminal.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if MessageDlg('Möchten sie das Spiel wirklich beenden?',
     mtConfirmation,
    [mbYes, mbNo], 0) = mrYes then
    Action := caFree
  else
    Action := caNone;
end;

procedure Tgameterminal.FormCreate(Sender: TObject);
begin
{spielbeenden1.Visible := False; }
{spielbeenden1.Enabled:= False;}
end;

procedure Tgameterminal.DasExperimentbeenden1Click(Sender: TObject);
begin
close;
end;

procedure Tgameterminal.Information1Click(Sender: TObject);
begin
infobox.ShowModal;
end;

procedure Tgameterminal.endeClick(Sender: TObject);
begin
close;
end;

procedure Tgameterminal.antwortaClick(Sender: TObject);
begin
ExecuteFile('TG1.EXE','','', SW_SHOW);
end;

procedure Tgameterminal.antwortbClick(Sender: TObject);
begin
ExecuteFile('TG2.EXE','','', SW_SHOW);
end;

procedure Tgameterminal.antwortcClick(Sender: TObject);
begin
ExecuteFile('TG3.EXE','','', SW_SHOW);
end;

end.
