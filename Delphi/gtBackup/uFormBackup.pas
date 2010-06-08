unit uFormBackup;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, uThreadBackup, uGlobals, gtcl_Dialogs;

type
  TFormBackup = class(TForm)
    Label1: TLabel;
    pbFile: TProgressBar;
    pbAll: TProgressBar;
    Label2: TLabel;
    lblCurrentFile: TLabel;
    lblStatus: TLabel;
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
    procedure ShowBackupWindow(JUIDList: TStringList);
    procedure UpdateBackupWindow(info: VCLInfo);
  end;

var
  FormBackup: TFormBackup;

implementation

{$R *.dfm}

uses uFormMain;

procedure TFormBackup.UpdateBackupWindow(info: VCLInfo);
begin
  if info.mode = ReadingFiles then
  begin
    lblStatus.Caption := 'Status: Lese Dateien (' + IntToStr(info.filesCount) + ')';
  end
  else if info.mode = CopyFiles then
  begin
    lblStatus.Caption := 'Status: Kopiere Dateien (' + IntToStr(info.filesPosition) + '/' + IntToStr(info.filesCount) + ')';

      pbAll.Max := info.filesCount;
   pbAll.Position := info.filesPosition;

  pbFile.Max := info.fileSize;
  pbFile.Position := info.filePosition;

  lblCurrentFile.Caption := info.fileCurrent;
  end
  else if info.mode = Ready then
  begin
    gtDialogs.ShowMessageInfoDialog('Vorgang abgeschlossen!');
    FormMain.BuildTree;
    FormBackup.Close;
  end;
end;

procedure TFormBackup.ShowBackupWindow(JUIDList: TStringList);
var i: Integer;
    ThreadBackup: TThreadBackup;
begin
  FormBackup.Caption := 'Backup...';

  //ShowModal;
  Show;

  for i := 0 to JUIDList.Count-1 do
  begin
    //ListBox1.Items.Add(JUIDList[i]);
    ThreadBackup := TThreadBackup.Create(True);
    ThreadBackup.FreeOnTerminate := true;
    ThreadBackup.Juid := JUIDList[i];
    ThreadBackup.Resume;
  end;
end;

end.
