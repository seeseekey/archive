program gtEdit;

uses
  Forms,
  Windows,
  Sysutils,
  gtcl_MemoryMappedFile,
  uFormMain in 'uFormMain.pas' {FormMain},
  uFormAbout in 'uFormAbout.pas' {FormAbout},
  uFormPrintPreview in 'uFormPrintPreview.pas' {FormPrintPreview},
  uFormJumpToLine in 'uFormJumpToLine.pas' {FormJumpToLine},
  uFormSearch in 'uFormSearch.pas' {FormSearch},
  uFormReplace in 'uFormReplace.pas' {FormReplace},
  uFormReplaceConfirm in 'uFormReplaceConfirm.pas' {FormReplaceConfirm},
  uFormOptions in 'uFormOptions.pas' {FormOptions},
  uGlobals in 'uGlobals.pas',
  uTestForm in 'uTestForm.pas' {Form1};

{$R *.res}
const
  MyGUID = '{EABD7162-08E5-4C68-96E1-434A89729895}';
  
var hMutex, hWndFirst, hWndApp: THandle;

begin
  Application.Initialize;
  Application.Title := 'gtEdit';

  ActivationMessage := RegisterWindowMessage(PChar(MyGUID));

    // Mehrfachstart unterbinden
  hMutex := CreateMutex(NIL, TRUE, MyGUID);
  if (GetLastError() = ERROR_ALREADY_EXISTS) then
  begin
    hWndFirst := FindWindow('TMeinProg', NIL);
    if (hWndFirst <> 0) then
    begin
      hWndApp := GetWindow(hWndFirst, GW_OWNER); // Owner-Handle holen (Handle des TApplication-Fensters)
      if IsIconic(hWndApp) then
        ShowWindow(hWndApp, SW_RESTORE); // restoren wenn minimiert
      // Hauptfenster in den Vordergrund holen
      SetForegroundWindow(hWndFirst);
      BringWindowToTop(hWndFirst);
    end;
    CloseHandle(hMutex);

    //Randomize;
    gtMemoryMappedFile.WriteStringToMMF(MyGUID + 'MMF', ParamStr(1));
    PostMessage(StrToInt(gtMemoryMappedFile.ReadStringFromMMF(myGUID + 'FHI')), ActivationMessage, 0, 0);
    
    Exit;
  end;

  Application.CreateForm(TFormMain, FormMain);
  Application.CreateForm(TFormAbout, FormAbout);
  Application.CreateForm(TFormPrintPreview, FormPrintPreview);
  Application.CreateForm(TFormJumpToLine, FormJumpToLine);
  Application.CreateForm(TFormReplaceConfirm, FormReplaceConfirm);
  Application.CreateForm(TFormOptions, FormOptions);
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
