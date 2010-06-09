program mdi;

uses
  Forms,
  mdi00 in 'mdi00.pas' {Form1},
  mdi01 in 'mdi01.pas' {Form2};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TForm2, Form2);
  Application.Run;
end.
