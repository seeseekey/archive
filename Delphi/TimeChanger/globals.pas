unit globals;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs;

var Reload: Boolean=false;

function SetPCSystemTime(dDateTime: TDateTime): Boolean;   

implementation

// Hiermit setze ich die Zeit auf dem lokalen Rechner:
function SetPCSystemTime(dDateTime: TDateTime): Boolean;                // SwissDelphiCenter: Tip #90
const
  SE_SYSTEMTIME_NAME = 'SeSystemtimePrivilege'; 
var
  hToken: THandle;
  ReturnLength: DWORD; 
  tkp, PrevTokenPriv: TTokenPrivileges; 
  luid: TLargeInteger; 
  dSysTime: TSystemTime; 
begin 
  Result := False;
  if (Win32Platform = VER_PLATFORM_WIN32_NT) then 
  begin 
    if OpenProcessToken(GetCurrentProcess, 
      TOKEN_ADJUST_PRIVILEGES or TOKEN_QUERY, hToken) then 
    begin 
      try 
        if not LookupPrivilegeValue(nil, SE_SYSTEMTIME_NAME, luid) then
Exit; 
        tkp.PrivilegeCount := 1; 
        tkp.Privileges[0].luid := luid; 
        tkp.Privileges[0].Attributes := SE_PRIVILEGE_ENABLED; 
        if not AdjustTokenPrivileges(hToken, False, tkp,
SizeOf(TTOKENPRIVILEGES), 
          PrevTokenPriv, ReturnLength) then 
          Exit; 
        if (GetLastError <> ERROR_SUCCESS) then 
        begin 
          raise Exception.Create(SysErrorMessage(GetLastError)); 
          Exit; 
        end; 
      finally 
        CloseHandle(hToken); 
      end; 
    end; 
  end; 
  DateTimeToSystemTime(dDateTime, dSysTime); 
  Result := Windows.SetLocalTime(dSysTime); 
end;

end.

