unit uGlobals;

interface

uses Classes, bigini, gtcl_FileSystem;

const
  gtmpPROTOKOLDESCRIPTOR = 'gtmp';
  gtmpVERSION = '0001';
  gtmpSEPERATOR = ';';

  gtmpCmdMEMBERREQUEST = 'MRQ';
  gtmpCmdMEMBERREQUESTREPLY = 'MRR';
  gtmpCmdMEMBERDISCONNECT = 'MDC';
  gtmpCmdMESSAGE = 'MSG';
  gtmpCmdREFRESHPROFILE = 'RFP';

var
  Ini: TBiggerIniFile;
  //GID: string; // Globale Identifikations Nummer
  Xclose: boolean=false;

  // Verwaltungsluste der Fenster
  // List auf TObjectList oder TList umstellen
  // Inizialisation in der unit vornehmen
  MessageWindowList: TStringList;
  GiDToClearList: TStringList;

  dbgProtocolList: TStringList;

implementation

 // Dummy

initialization
  GiDToClearList := TStringList.Create;
  Ini := TBiggerIniFile.Create(gtFileSystem.GetApplicationPath + 'options.ini');
  { initialization-Abschnitt }
  dbgProtocolList := TStringList.Create;

finalization
  { finalization-Abschnitt }
  GiDToClearList.Free;
  Ini.Free;
  dbgProtocolList.Free;

end.
