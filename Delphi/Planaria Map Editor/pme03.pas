unit pme03;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, gtcl_FileSystem, XMLLib;

type
  TFormNewTileset = class(TForm)
    EditTilesetName: TEdit;
    btn_OK: TButton;
    Label1: TLabel;
    btn_Cancel: TButton;
    cbTilesetTileSize: TComboBox;
    Label2: TLabel;
    procedure btn_OKClick(Sender: TObject);
    procedure btn_CancelClick(Sender: TObject);
    procedure EditTilesetNameKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  FormNewTileset: TFormNewTileset;

implementation

{$R *.dfm}

uses pmeGlobals;

procedure TFormNewTileset.btn_OKClick(Sender: TObject);
var Node : TXMLNode;
    fXML : TXMLLib;
    nameOfTileset: string;
begin
  nameOfTileset := EditTileSetName.Text;

  if EditTileSetName.Text = '' then
  begin
    MessageDlg('Es wurde nichts eingegeben!', mtInformation, [mbOk], 0);
    EditTileSetName.SetFocus;
    Exit;
  end;

  EditTileSetName.Text := Lowercase(EditTileSetName.Text);
  tileSetFileName := EditTileSetName.Text + '\' + EditTileSetName.Text + '.pts';
  tileSetFileName := gtFileSystem.GetApplicationPath + 'tilesets\' + tileSetFileName;

  if ForceDirectories(ExtractFilePath(tileSetFileName)) = false then
  begin
    MessageDlg('Es wurden ungültige Zeichen benutzt!', mtInformation, [mbOk], 0);
    EditTileSetName.Text := '';
    tileSetFileName := '';
    EditTileSetName.SetFocus;
    Exit;
  end;

  tilesetTileSize := StrToInt(cbTilesetTileSize.Items[cbTilesetTileSize.ItemIndex]);

  //Speichern der Informationen
  fXML := TXMLLib.Create;
  If ( fXML.CreatePathAndNode('xml.meta.tilesetName', Node, 0) ) Then Node.Value.AsString := nameOfTileset;
  If ( fXML.CreatePathAndNode('xml.meta.tilesetTileSize', Node, 0) ) Then Node.Value.AsInteger := tilesetTileSize;
  fXML.SaveToFile(tileSetFileName);
  fXML.Free;

  //Beenden des Formulares
  EditTileSetName.Text := '';
  FormNewTileset.Close;
end;

procedure TFormNewTileset.btn_CancelClick(Sender: TObject);
begin
  tileSetFileName := '';
  EditTileSetName.Text := '';
  FormNewTileset.Close;
end;

procedure TFormNewTileset.EditTilesetNameKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if key = vk_Return then
  begin
    btn_OKClick(Sender);
  end;
end;

end.
