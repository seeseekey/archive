unit uGlobals;

interface

uses xmllib;

type BackupMode = (ReadingFiles, CopyFiles, Ready);

type
  VCLInfo = record
    mode: BackupMode;
    filePosition: LongWord;
    fileSize: LongWord;
    filesCount:LongWord;
    filesPosition: LongWord;
    fileCurrent: String;
    jobsCount: LongWord;
    jobsPosition: LongWord;
  end;

var fXML : TXMLLib;

implementation

initialization
  fXML := TXMLLib.Create;
  fXML.Options.NodePathSeparator := '.';

finalization
 fXML.Free;

end.
