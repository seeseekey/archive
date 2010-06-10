unit pme04;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Spin, gtfl_Files, gtfl_Path;

type
  TFormNewMap = class(TForm)
    btnOk: TButton;
    btCancel: TButton;
    Label1: TLabel;
    edNameOfMap: TEdit;
    seWidthOfMap: TSpinEdit;
    seHeightOfMap: TSpinEdit;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    lbTilesets: TListBox;
    procedure FormShow(Sender: TObject);
    procedure btnOkClick(Sender: TObject);
    procedure btCancelClick(Sender: TObject);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  FormNewMap: TFormNewMap;

implementation

{$R *.dfm}

uses pme01;

procedure TFormNewMap.FormShow(Sender: TObject);
begin
  //Tilesetslisten
  lbTilesets.Clear;
  GetFilesInDirectory(GetApplicationPath + 'tilesets\', '*.pts', lbTilesets.Items, true);

  if lbTilesets.Count > 0 then lbTilesets.ItemIndex := 0; //Ersten Eintrag auswählen

  edNameOfMap.Text := '';
  seWidthOfMap.Value := 5;
  seHeightOfMap.Value := 5;
end;

procedure TFormNewMap.btnOkClick(Sender: TObject);
begin
  if lbTilesets.Count = 0 then
  begin
    MessageDlg('Es sind keine Tilesets vorhanden!', mtInformation, [mbOk], 0);
    Exit;
  end;

  if lbTilesets.ItemIndex = -1 then
  begin
    MessageDlg('Es wurde kein Tileset ausgewählt!', mtInformation, [mbOk], 0);
    Exit;
  end;

  if edNameOfMap.Text = '' then
  begin
    MessageDlg('Sie haben keinen Map Namen angegeben!', mtInformation, [mbOk], 0);
    Exit;
  end;

  FormMain.CreateMap(edNameOfMap.Text, lbTilesets.Items[lbTilesets.Itemindex], seWidthOfMap.Value, seHeightOfMap.Value);

  FormNewMap.Close;
end;

procedure TFormNewMap.btCancelClick(Sender: TObject);
begin
  FormNewMap.Close;
end;

end.
