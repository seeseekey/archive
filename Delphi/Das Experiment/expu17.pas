unit Expu17;

interface

uses
  SysUtils, WinTypes, WinProcs, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, StdCtrls, ExtCtrls, Menus, expu1, expu18, expu20, expu19,
  expu23;

type
  Tterminal = class(TForm)
    Image1: TImage;
    aufgabentext: TLabel;
    antwortc: TButton;
    antwortb: TButton;
    antworta: TButton;
    ende: TButton;
    SaveDialog: TSaveDialog;
    procedure Button2Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure DasExperimentbeenden1Click(Sender: TObject);
    procedure Information1Click(Sender: TObject);
    procedure endeClick(Sender: TObject);
    procedure antwortcClick(Sender: TObject);
    procedure antwortaClick(Sender: TObject);
    procedure antwortbClick(Sender: TObject);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  terminal: Tterminal;
  var F: TextFile;

implementation

{$R *.DFM}

procedure Tterminal.Button2Click(Sender: TObject);
begin
close;
end;

procedure Tterminal.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if MessageDlg('Möchten sie das Spiel wirklich beenden?',
     mtConfirmation,
    [mbYes, mbNo], 0) = mrYes then
    Action := caFree
  else
    Action := caNone;
end;

procedure Tterminal.FormCreate(Sender: TObject);
begin
{spielbeenden1.Visible := False; }
{spielbeenden1.Enabled:= False;}
end;

procedure Tterminal.DasExperimentbeenden1Click(Sender: TObject);
begin
close;
end;

procedure Tterminal.Information1Click(Sender: TObject);
begin
infobox.ShowModal;
end;

procedure Tterminal.endeClick(Sender: TObject);
begin
close;
end;

procedure Tterminal.antwortcClick(Sender: TObject);
begin
expu18.gameterminal.show;
end;

procedure Tterminal.antwortaClick(Sender: TObject);
begin
expu23.fnv.show;
{savedialog.FileName := 'noname.egf';
  if savedialog.Execute then
   if (savedialog.Filename = '') then exit;
  AssignFile(F, savedialog.FileName);
  Rewrite(F);
  Writeln(F, '0');
  CloseFile(F);    }
end;

procedure Tterminal.antwortbClick(Sender: TObject);
begin
expu20.verschwommen.show;
expu19.heftigerschlag.show;
close;
end;

end.
