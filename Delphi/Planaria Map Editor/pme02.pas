unit pme02;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, StdCtrls, ExtCtrls, gtcl_FileSystem, gtcl_TStrings,
  pngimage, XMLLib, gtcl_TGrids, gtcl_Strings;

type
  TFormTilesetEditor = class(TForm)
    Panel2: TPanel;
    cbLayers: TComboBox;
    Panel3: TPanel;
    dgTileset: TDrawGrid;
    Button1: TButton;
    lbTilesets: TListBox;
    Panel1: TPanel;
    Button2: TButton;
    OpenDialog: TOpenDialog;
    lbInformationen: TListBox;
    Label1: TLabel;
    Button3: TButton;
    procedure OpenTileset(filename: string);
    procedure DrawTiles;
    procedure FormPaint(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure dgTilesetDrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure cbLayersChange(Sender: TObject);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  FormTilesetEditor: TFormTilesetEditor;
  currentOpenTileset: string='';
  currentTileSetFileName: string='';
  currentTileSetTileSize: Byte=8;
  slL0, slL1, slL2, slL3, slL4, slL5, slL6, slL7: TStringList;

implementation

{$R *.dfm}

uses pmeGlobals, pme03;

//Normale Funktionen
procedure TFormTilesetEditor.OpenTileset(filename: string);
var Node : TXMLNode;
    fXML : TXMLLib;
    cl0, cl1, cl2, cl3, cl4, cl5, cl6, cl7, clGesamt: Integer;
    i, j: Integer;
    tmpNodeNameString: string;
begin
  currentOpenTileset := filename;
  FormTilesetEditor.Caption := 'Tileset Editor - ' + currentOpenTileset;

  //Laden aus der XML
  fXML := TXMLLib.Create;
  fXML.LoadFromFile(currentOpenTileset);
  Node := fXML.GetNodeFromPath('xml.meta.tilesetName', 0);
  currentTileSetFileName := Node.Value.AsString;

  Node := fXML.GetNodeFromPath('xml.meta.tilesetTileSize', 0);
  currentTileSetTileSize := Node.Value.AsInteger;

  //Zählen der Tiles
  cl0 := 0;
  cl1 := 0;
  cl2 := 0;
  cl3 := 0;
  cl4 := 0;
  cl5 := 0;
  cl6 := 0;
  cl7 := 0;

  slL0.Clear;
  slL1.Clear;
  slL2.Clear;
  slL3.Clear;
  slL4.Clear;
  slL5.Clear;
  slL6.Clear;
  slL7.Clear;

  for i:=0 to 7 do
  begin
    tmpNodeNameString := 'xml.layers.' + IntToStr(i);
    Node := fXML.GetNodeFromPath(tmpNodeNameString, 0);

    if Node <> nil then
    begin
      for j := 0 to Node.Nodes.Count -1 do
      begin
        if node.Nodes[j].Name = 'still' then
        begin
          case GetLastChar(node.Nodes[j].Path) of
            '0': begin Inc(cl0); slL0.Add(node.Nodes[j].Value.AsString); end;
            '1': begin Inc(cl1); slL1.Add(node.Nodes[j].Value.AsString); end;
            '2': begin Inc(cl2); slL2.Add(node.Nodes[j].Value.AsString); end;
            '3': begin Inc(cl3); slL3.Add(node.Nodes[j].Value.AsString); end;
            '4': begin Inc(cl4); slL4.Add(node.Nodes[j].Value.AsString); end;
            '5': begin Inc(cl5); slL5.Add(node.Nodes[j].Value.AsString); end;
            '6': begin Inc(cl6); slL6.Add(node.Nodes[j].Value.AsString); end;
            '7': begin Inc(cl7); slL7.Add(node.Nodes[j].Value.AsString); end;
          end; //Case
        end; //Nodes = still
      end; //for j
    end; //Node Nil
  end; //for i

  clGesamt := cl0 + cl1 + cl2 + cl3 + cl4 + cl5 + cl6 + cl7;

  fXML.Free;

  //Drawgrid
  DrawTiles;

  //Füllen der Informationsbox
  lbInformationen.Clear;
  lbInformationen.Items.Add('Tilesetname: ' + currentTileSetFileName);
  lbInformationen.Items.Add('Tilesetkachelgröße: ' + IntToStr(currentTileSetTileSize) + ' Pixel');
  lbInformationen.Items.Add('');
  lbInformationen.Items.Add('Tilestatistik:');
  lbInformationen.Items.Add('Gesamtanzahl der Tiles: ' + IntToStr(clGesamt));
  lbInformationen.Items.Add('Tiles in Layer 0: ' + IntToStr(cl0));
  lbInformationen.Items.Add('Tiles in Layer 1: ' + IntToStr(cl1));
  lbInformationen.Items.Add('Tiles in Layer 2: ' + IntToStr(cl2));
  lbInformationen.Items.Add('Tiles in Layer 3: ' + IntToStr(cl3));
  lbInformationen.Items.Add('Tiles in Layer 4: ' + IntToStr(cl4));
  lbInformationen.Items.Add('Tiles in Layer 5: ' + IntToStr(cl5));
  lbInformationen.Items.Add('Tiles in Layer 6: ' + IntToStr(cl6));
  lbInformationen.Items.Add('Tiles in Layer 7: ' + IntToStr(cl7));
end;

procedure TFormTilesetEditor.DrawTiles;
begin
  dgTileset.Refresh;
end;

function isTilesetOpen: Boolean;
begin
  if currentOpenTileset = '' then
  begin
    Result := false;
    MessageDlg('Es ist kein Tileset geöffnet!', mtInformation, [mbOk], 0)
  end
  else Result := true;
end;

//Eventfunktionen
procedure TFormTilesetEditor.FormPaint(Sender: TObject);
begin
  Panel3.Height := Panel2.Height-Panel3.Top;
end;

procedure TFormTilesetEditor.FormShow(Sender: TObject);
begin
  if tileSetFileName = '' then FormTilesetEditor.Caption := 'Tileset Editor - Kein Tileset geöffnet'
  else
  begin
    currentOpenTileset := tileSetFileName;
    OpenTileset(currentOpenTileset);
    FormTilesetEditor.Caption := 'Tileset Editor - ' + currentOpenTileset;
  end;

  //Tilesetslisten
  lbTilesets.Clear;
  GetFilesInDirectory(GetApplicationPath + 'tilesets\', '*.pts', lbTilesets.Items, true);

  //Current Tileset setzen
  if currentOpenTileset <> '' then
  begin
    try
      lbTilesets.Itemindex := SearchStringInTStrings(lbTilesets.items, currentOpenTileset);
    except
    end;
  end
  else if lbTilesets.Count > 0 then lbTilesets.ItemIndex := 0;
end;

procedure TFormTilesetEditor.Button1Click(Sender: TObject);
begin
  if lbTilesets.ItemIndex = -1 then MessageDlg('Kein Tileset ausgewählt!', mtInformation, [mbOk], 0)
  else
  begin
    OpenTileset(lbTilesets.Items[lbTilesets.ItemIndex]);
  end;
end;

procedure TFormTilesetEditor.Button2Click(Sender: TObject);
var Img: TPNGObject;
    i, j: Integer;
    Node : TXMLNode;
    fXML : TXMLLib;
    countOfTag: Integer;
begin
  if isTilesetOpen = false then Exit;

  if OpenDialog.Execute then
  begin
    Img := TPNGObject.Create;

    fXML := TXMLLib.Create;
    fXML.LoadFromFile(currentOpenTileset);

    countOfTag := 0;

    //Auswerten der Dateiliste
    Node := fXML.GetNodeFromPath('xml.layers.0', 0);

    case cbLayers.ItemIndex of
        0: Node := fXML.GetNodeFromPath('xml.layers.0', 0);
        1: Node := fXML.GetNodeFromPath('xml.layers.1', 0);
        2: Node := fXML.GetNodeFromPath('xml.layers.2', 0);
        3: Node := fXML.GetNodeFromPath('xml.layers.3', 0);
        4: Node := fXML.GetNodeFromPath('xml.layers.4', 0);
        5: Node := fXML.GetNodeFromPath('xml.layers.5', 0);
        6: Node := fXML.GetNodeFromPath('xml.layers.6', 0);
        7: Node := fXML.GetNodeFromPath('xml.layers.7', 0);
    end;

   if Node <> nil then
   begin
     for j := 0 to Node.Nodes.Count -1 do
     begin
      if node.Nodes[j].Name = 'still' then Inc(countOfTag);
     end;
   end;

    for i:=0 to OpenDialog.Files.Count-1 do
    begin
      Img.LoadFromFile(OpenDialog.Files.Strings[i]);

      if (Img.Width = currentTileSetTileSize) and (Img.Height = currentTileSetTileSize) then
      begin
        //Bild kopieren
        CopyFileExc(OpenDialog.Files.Strings[i], ExtractFileDir(currentOpenTileset) + '\' + ExtractFilename(OpenDialog.Files.Strings[i]));

        //Bild in XML eintragen (pts)
        case cbLayers.ItemIndex of
        0: If ( fXML.CreatePathAndNode('xml.layers.0.still', Node, countOfTag) ) Then Node.Value.AsString := ExtractFilename(OpenDialog.Files.Strings[i]);
        1: If ( fXML.CreatePathAndNode('xml.layers.1.still', Node, countOfTag) ) Then Node.Value.AsString := ExtractFilename(OpenDialog.Files.Strings[i]);
        2: If ( fXML.CreatePathAndNode('xml.layers.2.still', Node, countOfTag) ) Then Node.Value.AsString := ExtractFilename(OpenDialog.Files.Strings[i]);
        3: If ( fXML.CreatePathAndNode('xml.layers.3.still', Node, countOfTag) ) Then Node.Value.AsString := ExtractFilename(OpenDialog.Files.Strings[i]);
        4: If ( fXML.CreatePathAndNode('xml.layers.4.still', Node, countOfTag) ) Then Node.Value.AsString := ExtractFilename(OpenDialog.Files.Strings[i]);
        5: If ( fXML.CreatePathAndNode('xml.layers.5.still', Node, countOfTag) ) Then Node.Value.AsString := ExtractFilename(OpenDialog.Files.Strings[i]);
        6: If ( fXML.CreatePathAndNode('xml.layers.6.still', Node, countOfTag) ) Then Node.Value.AsString := ExtractFilename(OpenDialog.Files.Strings[i]);
        7: If ( fXML.CreatePathAndNode('xml.layers.7.still', Node, countOfTag) ) Then Node.Value.AsString := ExtractFilename(OpenDialog.Files.Strings[i]);
        end;

        Inc(countOfTag);
      end
      else
      begin
        //Ereignissbehandlung wenn Bild nicht passt
        MessageDlg('Die Datei ' + ExtractFilename(OpenDialog.Files.Strings[i]) + ' ist nicht zur Kachelgröße des Tilesets kompatibel!', mtInformation, [mbOk], 0);
      end;
    end;

    fXML.SaveToFile(currentOpenTileset);
    fXML.Free;
    Img.Free;

    OpenTileset(currentOpenTileset);
  end;
end;

procedure TFormTilesetEditor.FormCreate(Sender: TObject);
begin
  slL0 := TStringList.Create;
  slL1 := TStringList.Create;
  slL2 := TStringList.Create;
  slL3 := TStringList.Create;
  slL4 := TStringList.Create;
  slL5 := TStringList.Create;
  slL6 := TStringList.Create;
  slL7 := TStringList.Create;
end;

procedure TFormTilesetEditor.FormDestroy(Sender: TObject);
begin
  slL0.Free;
  slL1.Free;
  slL2.Free;
  slL3.Free;
  slL4.Free;
  slL5.Free;
  slL6.Free;
  slL7.Free;
end;

procedure TFormTilesetEditor.dgTilesetDrawCell(Sender: TObject; ACol,
  ARow: Integer; Rect: TRect; State: TGridDrawState);
var tmpStringList: TStringList;
    Img: TPNGObject;
begin
  tmpStringList := TStringList.Create;

  case cbLayers.ItemIndex of
    0: tmpStringList.AddStrings(slL0);
    1: tmpStringList.AddStrings(slL1);
    2: tmpStringList.AddStrings(slL2);
    3: tmpStringList.AddStrings(slL3);
    4: tmpStringList.AddStrings(slL4);
    5: tmpStringList.AddStrings(slL5);
    6: tmpStringList.AddStrings(slL6);
    7: tmpStringList.AddStrings(slL7);
  end; //Case

  if (tmpStringList.Count > 0) then
  begin
    //2*y+x
    if (GetNumberOfField(2, ACol, ARow) > tmpStringList.Count-1) then Exit;
    dgTileset.RowCount := (tmpStringList.Count div 2)+1;
    Img := TPNGObject.Create;
    Img.LoadFromFile(ExtractFileDir(currentOpenTileset) + '\' + tmpStringList[GetNumberOfField(dgTileset.ColCount, ACol, ARow)]);
    dgTileset.Canvas.Draw(Rect.Left, Rect.Top, Img);
    Img.Free;
  end
  else dgTileset.RowCount := 1;

  tmpStringList.Free;
end;

procedure TFormTilesetEditor.cbLayersChange(Sender: TObject);
begin
  DrawTiles;
end;

end.
