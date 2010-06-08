program gtLANMessenger;

uses
  Forms,
  Windows,
  uFormMain in 'uFormMain.pas' {FormMain},
  uFormOptions in 'uFormOptions.pas' {FormOptions},
  uGlobals in 'uGlobals.pas',
  uFormChat in 'uFormChat.pas' {FormChat},
  uFormAbout in 'uFormAbout.pas' {FormAbout};

{$R *.res}
var hMutex, hWndFirst, hWndApp: THandle;

begin
  Application.Initialize;
  Application.Title := 'gtLANMessenger';

  // Mehrfachstart unterbinden
  hMutex := CreateMutex(NIL, TRUE, 'MeinProg gestartet');
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
    Exit;
  end;


  Application.CreateForm(TFormMain, FormMain);
  Application.CreateForm(TFormOptions, FormOptions);
  Application.CreateForm(TFormAbout, FormAbout);
  Application.Run;

  CloseHandle(hMutex);
end.
