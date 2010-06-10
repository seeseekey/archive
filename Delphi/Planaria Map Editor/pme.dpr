program pme;

uses
  Forms,
  pme01 in 'pme01.pas' {FormMain},
  infodialog in 'infodialog.pas' {aboutform},
  pmeGlobals in 'pmeGlobals.pas',
  pme02 in 'pme02.pas' {FormTilesetEditor},
  pme03 in 'pme03.pas' {FormNewTileset},
  pme04 in 'pme04.pas' {FormNewMap};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'Planaria Map Editor';
  Application.CreateForm(TFormMain, FormMain);
  Application.CreateForm(Taboutform, aboutform);
  Application.CreateForm(TFormTilesetEditor, FormTilesetEditor);
  Application.CreateForm(TFormNewTileset, FormNewTileset);
  Application.CreateForm(TFormNewMap, FormNewMap);
  Application.Run;
end.
