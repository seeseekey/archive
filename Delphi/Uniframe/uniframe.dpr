program uniframe;

uses
  Forms,
  uFormMain in 'uFormMain.pas' {FormMain},
  uFormAbout in 'uFormAbout.pas' {FormAbout},
  uGlobals in 'uGlobals.pas',
  uFormSelectDrive in 'uFormSelectDrive.pas' {FormSelectDrive},
  uFormReadDrive in 'uFormReadDrive.pas' {FormReadDrive},
  ufto01 in 'ufto01.pas',
  uFormDriveProperties in 'uFormDriveProperties.pas' {FormDriveProperties};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'Uniframe';
  Application.CreateForm(TFormMain, FormMain);
  Application.CreateForm(TFormAbout, FormAbout);
  Application.CreateForm(TFormSelectDrive, FormSelectDrive);
  Application.CreateForm(TFormReadDrive, FormReadDrive);
  Application.CreateForm(TFormDriveProperties, FormDriveProperties);
  Application.Run;
end.
