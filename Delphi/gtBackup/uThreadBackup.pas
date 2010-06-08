unit uThreadBackup;

interface

uses
 Classes, gtcl_FileSystem, uGlobals, xmllib, gtcl_Misc, SysUtils, hardlinks, gtcl_IntegerList, Windows,
 SynUnicode, gtcl_DateTime;

type
 TThreadBackup = class(TThread)
 private
  { Private-Deklarationen }
  fMode: BackupMode;
  fFilePosition: longword;
  fFileSize: longword;
  fFilesCount: longword;
  fFilesPosition: longword;
  fFileCurrent: widestring;
  fJobsCount: longword;
  fJobsPosition: longword;
 protected
  procedure UpdateVCLWindow;
  procedure Execute; override;
  procedure GetFilesGtBackup(ADirectory: widestring; AMask: widestring; AList: TWideStrings; AIntList: gtIntegerList; AInt: integer; ARekursiv: boolean);
 public
  JUID: widestring;
 end;

implementation

uses uFormBackup;

{ Wichtig: Methoden und Eigenschaften von Objekten in visuellen Komponenten dürfen 
  nur in einer Methode namens Synchronize aufgerufen werden, z.B.

      Synchronize(UpdateCaption);

  und UpdateCaption könnte folgendermaßen aussehen:

    procedure TThreadBackup.UpdateCaption;
    begin
      Form1.Caption := 'Aktualisiert in einem Thread';
    end; }

{ TThreadBackup }

procedure TThreadBackup.UpdateVCLWindow;
var info: VCLInfo;
begin
 info.mode := fMode;
 info.filePosition := fFilePosition;
 info.fileSize := fFileSize;
 info.filesCount := fFilesCount;
 info.filesPosition := fFilesPosition;
 info.fileCurrent := fFileCurrent;
 info.jobsCount := fJobsCount;
 info.jobsPosition := fJobsPosition;

 FormBackUp.UpdateBackupWindow(info);
end;

procedure TThreadBackup.GetFilesGtBackup(ADirectory: widestring; AMask: widestring; AList: TWideStrings; AIntList: gtIntegerList; AInt: integer; ARekursiv: boolean);
var
  hFindFile              : THandle;
  wfd                    : WIN32_FIND_DATAW;
begin
 fFilesCount := AList.Count;
 Synchronize(UpdateVCLWindow);

  if ADirectory[length(ADirectory)] <> '\' then
    ADirectory := ADirectory + '\';
  ZeroMemory(@wfd, sizeof(wfd));
  wfd.dwFileAttributes := FILE_ATTRIBUTE_NORMAL;
  if ARekursiv then
  begin
    hFindFile := FindFirstFileW(PWideChar(ADirectory + '*.*'), wfd);
    if hFindFile <> 0 then
    try
      repeat
        if wfd.dwFileAttributes and FILE_ATTRIBUTE_DIRECTORY = FILE_ATTRIBUTE_DIRECTORY then
        begin
          if (string(wfd.cFileName) <> '.') and (string(wfd.cFileName) <> '..') then
          begin
            GetFilesGtBackup(ADirectory + wfd.cFileName, AMask, AList, AIntList, Aint, ARekursiv);
          end;
        end;
      until FindNextFileW(hFindFile, wfd) = False;
     // Inc(NumFolder);
     // SendMessage(Handle, FFM_ONDIRFOUND, NumFolder, lParam(string(RootFolder)));
    finally
      Windows.FindClose(hFindFile);
    end;
  end;
  hFindFile := FindFirstFileW(PWideChar(ADirectory + AMask), wfd);
  if hFindFile <> INVALID_HANDLE_VALUE then
  try
    repeat
      if (wfd.dwFileAttributes and FILE_ATTRIBUTE_DIRECTORY <> FILE_ATTRIBUTE_DIRECTORY) then
      begin
        //SendMessage(Handle, FFM_ONFILEFOUND, 0, lParam(string(RootFolder + wfd.cFileName)));
        AList.Add(ADirectory + WideString(wfd.cFileName));
        AIntList.Add(AInt);
        fFilesCount := AList.Count;
        Synchronize(UpdateVCLWindow);
      end;
    until FindNextFileW(hFindFile, wfd) = False;
  finally
    Windows.FindClose(hFindFile);
  end;
end;

procedure TThreadBackup.Execute;
var FileList: TWideStringList;
 FileSourceList: gtIntegerList;
 i: longword;
 Node: TXMLNode;
 ErrorNode: TXMLNode;
 ChildNodes: TXMLNodeList;

 jSources: TWideStringList;
 jTarget:  widestring;

 xTargetDirectory: widestring;
 jobUID: widestring;

 FirstBackup: boolean;

 tmp: widestring;
 hashOrginal: widestring;
 hashBackUp: widestring;

 copyResult: boolean;

 logPath: widestring;
 backupFile: widestring;

 lastBackup: WideString;
begin
 { Thread-Code hier einfügen }
 fMode := ReadingFiles;
 Synchronize(UpdateVCLWindow);

 //FileList := TWideStrings.Create;
 FileList := TWideStringList.Create;
 FileSourceList := gtIntegerList.Create;

 //JUID Daten holen
 jSources := TWideStringList.Create;

 Node := fXML.GetNodeFromPath('xml.jobs.' + JUID + '.sources');
 ChildNodes := TXMLNodeList.Create;
 Node.GetChilds(ChildNodes, '*');

 for i := 0 to ChildNodes.Count - 1 do //Sources
 begin
  Node := fXML.GetNodeFromPath('xml.jobs.' + JUID + '.sources.' + ChildNodes[i].Name);
  jSources.Add(Node.value.AsString);
 end;

 Node := fXML.GetNodeFromPath('xml.jobs.' + JUID + '.target'); //target
 jTarget := Node.Value.AsString + '\';

 Node := fXML.GetNodeFromPath('xml.jobs.' + JUID + '.lasttime'); //target
 Node.Value.AsString := gtDateTime.GetDateTimeAsString;

 //backuplog
 jobUID := gtMisc.GetUniqueID;

 //Firstbackup
 Node := fXML.GetNodeFromPath('xml.jobs.' + JUID + '.log');
 if Node.HasChildren = true then FirstBackup := false
 else FirstBackup := true;

 //last Backup pfad
 Node := fXML.GetNodeFromPath('xml.jobs.' + JUID + '.log');
// logPath := 'xml.jobs.' + JUID + '.log.' + IntToStr(Node.Nodes.Count);
 if Node.Nodes.Count >0 then lastBackup := 'xml.jobs.' + JUID + '.log.' + IntToStr(Node.Nodes.Count-1);

 //Logpfad suchen
 Node := fXML.GetNodeFromPath('xml.jobs.' + JUID + '.log');
 logPath := 'xml.jobs.' + JUID + '.log.' + IntToStr(Node.Nodes.Count);

  fXML.CreatePathAndNode(logPath + '.folder', Node);
  Node.Value.AsString := jobUID;

  fXML.CreatePathAndNode(logPath + '.errors', Node);
  Node.Value.AsString := '';

  fXML.SaveToFile(gtFileSystem.GetApplicationPath + 'gtBackup.xml');

// Node := fXML.GetNodeFromPath(logPath);

 xTargetDirectory := jTarget + jobUID + '\';
 gtFileSystem.CreateDirectory(xTargetDirectory);

 //###########################################################################

 //Datein in Dateiliste schreiben
 fMode := ReadingFiles;

 FileList.Clear;
 FileSourceList.Clear;

 for i := 0 to jSources.Count - 1 do
 begin
  GetFilesGtBackup(jSources.Strings[i], '*.*', FileList, FileSourceList, i, true);
 end;

 fFilesCount := FileList.Count;
 fFilesPosition := 0;

 //###########################################################################

 //Dateien kopieren
 fMode := CopyFiles;

 //debug
//FileList.SaveToFile('c:\test.txt');

 for i := 0 to FileList.Count - 1 do
 begin
  copyResult := true;

  if (gtFileSystem.ExistsFile(FileList.Strings[i]) = true) and //Ob Quelldatei existiert
     (gtFileSystem.CheckFileAccess(FileList.Strings[i], fmOpenRead) = true)then //Ob Quelldateilesbar ist
  begin

   if FirstBackup = true then //Full Copy
   begin
    tmp := xTargetDirectory + gtFileSystem.GetRelativePath(FileList.Strings[i], jSources.Strings[FileSourceList[i]]);
    gtFileSystem.CreateDirectory(gtFileSystem.GetPath(tmp), true);

    fFileCurrent := FileList.Strings[i];
    Synchronize(UpdateVCLWindow);

    copyResult := gtFileSystem.CopyFile(FileList.Strings[i], tmp);
   end
   else begin //Inkrementel Hardlink Copy
    //Node := fXML.GetNodeFromPath('xml.jobs.' + JUID + '.log.0.folder');
    Node := fXML.GetNodeFromPath(lastBackup + '.folder');

    tmp := xTargetDirectory + gtFileSystem.GetRelativePath(FileList.Strings[i], jSources.Strings[FileSourceList[i]]);
    hashOrginal := gtFileSystem.GetFileHashMD5(FileList.Strings[i]);

    backupFile := jTarget + Node.Value.AsString + '\' + gtFileSystem.GetRelativePath(FileList.Strings[i], jSources.Strings[FileSourceList[i]]);

    if (gtFileSystem.ExistsFile(backupFile) = true) and
       (gtFileSystem.CheckFileAccess(backupFile, fmOpenRead) = true) then hashBackup := gtFileSystem.GetFileHashMD5(backupFile)
    else hashBackup := 'xxNoneBackup';

    fFileCurrent := FileList.Strings[i];
    Synchronize(UpdateVCLWindow);

    if hashOrginal <> hashBackup then
    begin  //Copy
     gtFileSystem.CreateDirectory(gtFileSystem.GetPath(tmp), true);
     copyResult := gtFileSystem.CopyFile(FileList.Strings[i], tmp);
    end
    else  //Hardlink
    begin
     gtFileSystem.CreateDirectory(gtFileSystem.GetPath(tmp), true);
     gtFileSystem.CreateHardlink(jTarget + Node.Value.AsString + '\' + gtFileSystem.GetRelativePath(FileList.Strings[i], jSources.Strings[FileSourceList[i]]),
      tmp);
    end; //End if hashOrginal <> hashBackup then
   end; // End else begin //Inkrementel Hardlink Copy
  end //End If FileExists and IsFileReadable
  else copyResult := false;

  //Errorlog schreiben
    if copyResult = false then
    begin
     Node := fXML.GetNodeFromPath(logPath + '.errors');
     fXML.CreatePathAndNode(logPath + '.errors.' + IntToStr(Node.Nodes.Count), ErrorNode);
    ErrorNode.Value.AsString := FileList.Strings[i];
    end;

   fFilesPosition := i+1;
   Synchronize(UpdateVCLWindow);

 end; //End For

 //Synchronize(UpdateVCLWindow);

 jSources.Free;
 FileList.Free;
 FileSourceList.Free;

 fXML.SaveToFile(gtFileSystem.GetApplicationPath + 'gtBackup.xml');

 fMode := Ready;
 Synchronize(UpdateVCLWindow);
end;

end.
