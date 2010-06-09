program misstag;

uses
  Forms,
  mtFormMain in 'mtFormMain.pas' {FormMain},
  mtFormProjectNewEdit in 'mtFormProjectNewEdit.pas' {FormProjectNewEdit},
  mtFormBugNewEdit in 'mtFormBugNewEdit.pas' {FormBugNewEdit},
  mtFormFeatureNewEdit in 'mtFormFeatureNewEdit.pas' {FormFeatureNewEdit};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'misstag';
  Application.CreateForm(TFormMain, FormMain);
  Application.CreateForm(TFormProjectNewEdit, FormProjectNewEdit);
  Application.CreateForm(TFormBugNewEdit, FormBugNewEdit);
  Application.CreateForm(TFormFeatureNewEdit, FormFeatureNewEdit);
  Application.Run;
end.
