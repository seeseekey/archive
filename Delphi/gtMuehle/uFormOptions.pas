unit uFormOptions;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ComCtrls, StdCtrls, inifiles, gtcl_FileSystem, DSPACK;

type
  TFormOptions = class(TForm)
    tabcontrol: TPageControl;
    Audio: TTabSheet;
    system: TTabSheet;
    cancel: TButton;
    okay: TButton;
    backgroundmusic: TCheckBox;
    doublebuffer: TCheckBox;
    SoundLevel: TTrackBar;
    Label2: TLabel;
    procedure cancelClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure okayClick(Sender: TObject);
    procedure SoundLevelChange(Sender: TObject);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  FormOptions: TFormOptions;

implementation

uses uFormMain;

{$R *.DFM}

procedure TFormOptions.cancelClick(Sender: TObject);
begin
  FormOptions.FormCreate(Sender);
  FormOptions.close;
end;

procedure TFormOptions.FormCreate(Sender: TObject);
var
  Ini: TIniFile;
begin
  Ini := TIniFile.Create(gtFileSystem.GetApplicationPath+'gtmuehle.gtc');

  backgroundmusic.Checked := ini.ReadBool('audio', 'backgroundmusic', true);
  SoundLevel.Position := ini.ReadInteger('audio', 'volume', 5000);
  doublebuffer.Checked := ini.ReadBool('system', 'double buffer', true);

  Ini.Free;
end;

procedure TFormOptions.okayClick(Sender: TObject);
var
Ini: tinifile;
begin
  Ini := TIniFile.Create(gtFileSystem.GetApplicationPath+'gtmuehle.gtc');
  Ini.WriteBool('audio', 'backgroundmusic', backgroundmusic.Checked);
  Ini.WriteInteger('audio', 'volume', SoundLevel.Position);
  Ini.WriteBool('system', 'double buffer', doublebuffer.Checked);

  FormMain.MusicVolume := SoundLevel.Position;

  try
   if ini.ReadBool('audio', 'backgroundmusic', true) = true then
   begin
     if FormMain.FilterGraph.State = gsStopped then FormMain.OpenMusicFile(MusicPlayList[MusicListIndex]);
   end
   else FormMain.FilterGraph.Stop;
  except
  end;

if ini.ReadBool('system', 'double buffer', true) = true then FormMain.DoubleBuffered := false
else FormMain.DoubleBuffered := true;

  ini.free;
  FormOptions.Close;
end;

procedure TFormOptions.SoundLevelChange(Sender: TObject);
begin
  FormMain.FilterGraph.Volume := SoundLevel.Position;
end;

end.
