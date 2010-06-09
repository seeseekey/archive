unit uFormReadDrive;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, gtcl_FileSystem;

type
  TFormReadDrive = class(TForm)
    GroupBox1: TGroupBox;
    staReadFiles: TLabel;
    staReadFolders: TLabel;
    staCurrentFolder: TLabel;
    procedure FormShow(Sender: TObject);
    procedure ReadDataOfDrive(value : string);
    procedure UpdateVCLWindow(files, folders: integer; current: string);
    procedure FormCreate(Sender: TObject);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  FormReadDrive: TFormReadDrive;


implementation

uses uGlobals, ufto01;

{$R *.dfm}
procedure TFormReadDrive.UpdateVCLWindow(files, folders: integer; current: string);
begin
 staReadFiles.Caption := Format('Gelesende Dateien: %d', [files]);
 staReadFolders.Caption := Format('Gelesende Verzeichnisse: %d', [folders]);
 staCurrentFolder.Caption := 'Momentane Datei: ' + current;
end;

procedure TFormReadDrive.ReadDataOfDrive(value : string);
var xternThread: TReadDataOut;
    databasename: string;
begin
 // Datenbank öffnen
  databasename := gtFileSystem.GetApplicationPath + 'data\xmaster.fdb';

 // Thread starten
 xternThread := TReadDataOut.Create(True);
 xternThread.FreeOnTerminate := true;
 xternThread.gDirectory := value;
 xternThread.Resume;
end;

procedure TFormReadDrive.FormShow(Sender: TObject);
var   ModLaufwerk: string;
begin
 if CanDriveRead = true then
 begin
  CanDriveRead := false;
  ModLaufwerk := Laufwerk + ':\';
  ReadDataOfDrive(ModLaufwerk);
  FormReadDrive.Close;
 end;
end;

procedure TFormReadDrive.FormCreate(Sender: TObject);
begin
 DoubleBuffered := true;
end;

end.
