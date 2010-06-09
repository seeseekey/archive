program PongPong;

uses
  Forms,
  pongpong01 in 'pongpong01.pas' {mainform};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(Tmainform, mainform);
  Application.Run;
end.
