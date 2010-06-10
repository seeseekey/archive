unit pme01;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus, ExtCtrls, Grids, StdCtrls, XMLLib, pngimage, gtcl_TGrids,
  AbBase, AbBrowse, AbZBrows, AbZipper, AbZipKit, gtcl_FileSystem, ToolWin,
  ComCtrls, ImgList, gtcl_Strings;

type TL5Event = record
    EventType: string; //Typ des Eventes
    Year: Integer;
    Month: (Jan, Feb, Mar, Apr, May, Jun, 
            Jul, Aug, Sep, Oct, Nov, Dec);
    Day: 1..31;
  end;

type TL5EventGrid = array of array of TL5Event;

type TMapGrid = array of array of string;

type
  TFormMain = class(TForm)
    MainMenu: TMainMenu;
    Datei1: TMenuItem;
    Beenden1: TMenuItem;
    Hilfe1: TMenuItem;
    ber1: TMenuItem;
    ilesetEditor1: TMenuItem;
    N1: TMenuItem;
    Neu1: TMenuItem;
    ileset1: TMenuItem;
    N2: TMenuItem;
    Map1: TMenuItem;
    N3: TMenuItem;
    Speichern1: TMenuItem;
    Speichernunter1: TMenuItem;
    Editoren1: TMenuItem;
    ffnen1: TMenuItem;
    N4: TMenuItem;
    abZipKit: TAbZipKit;
    SaveDialogMap: TSaveDialog;
    Inhalt1: TMenuItem;
    N5: TMenuItem;
    Panel4: TPanel;
    Panel1: TPanel;
    dgMap: TDrawGrid;
    Panel2: TPanel;
    imgTileView: TImage;
    cbLayers: TComboBox;
    Panel3: TPanel;
    dgTileset: TDrawGrid;
    N6: TMenuItem;
    Compilieren1: TMenuItem;
    StatusBar1: TStatusBar;
    OpenDialogMap: TOpenDialog;
    Ansicht1: TMenuItem;
    Linienanzeigen1: TMenuItem;
    ImageListToolbar: TImageList;
    N7: TMenuItem;
    HintergrundanzeigenLayer01: TMenuItem;
    GraphischeLayeranzeigen1: TMenuItem;
    Panel5: TPanel;
    ToolBar1: TToolBar;
    tbLines: TToolButton;
    ToolButton5: TToolButton;
    tbLayer0View: TToolButton;
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
    tbLayer02View: TToolButton;
    procedure OpenTileset(filename: string);
    procedure DrawTileset;
    procedure DrawMap;
    procedure ClearAll;
    procedure CreateMap(name, tileset: string; width, height: Integer);
    procedure Beenden1Click(Sender: TObject);
    procedure FormPaint(Sender: TObject);
    procedure ber1Click(Sender: TObject);
    procedure ilesetEditor1Click(Sender: TObject);
    procedure ileset1Click(Sender: TObject);
    procedure Map1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure dgTilesetDrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure cbLayersChange(Sender: TObject);
    procedure dgTilesetSelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
    procedure dgMapSelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
    procedure dgMapDrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure Speichernunter1Click(Sender: TObject);
    procedure ffnen1Click(Sender: TObject);
    procedure Linienanzeigen1Click(Sender: TObject);
    procedure tbLinesClick(Sender: TObject);
    procedure HintergrundanzeigenLayer01Click(Sender: TObject);
    procedure tbLayer0ViewClick(Sender: TObject);
    procedure GraphischeLayeranzeigen1Click(Sender: TObject);
    procedure tbLayer02ViewClick(Sender: TObject);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  FormMain: TFormMain;
  mgL0, mgL1, mgL2, mgL3, mgL4, mgL5, mgL6, mgL7: TMapGrid;

  //Erweiterte Grids für sondersachen
  egL5: TL5EventGrid; //Grid für Ereignisse

  slL0, slL1, slL2, slL3, slL4, slL5, slL6, slL7: TStringList;
  showEverLayer0: boolean=false;
  showEverLayer02: boolean=false;

implementation

{$R *.dfm}

uses infodialog, pmeGlobals, pme02, pme03, pme04;

//Normale Funktionen
procedure TFormMain.OpenTileset(filename: string);
var Node : TXMLNode;
    fXML : TXMLLib;
    i, j: Integer;
    tmpNodeNameString: string;
begin
  //Laden aus der XML
  fXML := TXMLLib.Create;
  fXML.LoadFromFile(filename);
  Node := fXML.GetNodeFromPath('xml.meta.tilesetName', 0);
  tileSetName := Node.Value.AsString;

  Node := fXML.GetNodeFromPath('xml.meta.tilesetTileSize', 0);
  tileSetTileSize := Node.Value.AsInteger;

  slL0.Clear;
  slL1.Clear;
  slL2.Clear;
  slL3.Clear;
  slL4.Clear;
  slL5.Clear;
  slL6.Clear;
  slL7.Clear;

  //Layer Pre Config

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
            '0': begin slL0.Add(node.Nodes[j].Value.AsString); end;
            '1': begin slL1.Add(node.Nodes[j].Value.AsString); end;
            '2': begin slL2.Add(node.Nodes[j].Value.AsString); end;
            '3': begin slL3.Add(node.Nodes[j].Value.AsString); end;
            '4': begin slL4.Add(node.Nodes[j].Value.AsString); end;
            '5': begin slL5.Add(node.Nodes[j].Value.AsString); end;
            '6': begin slL6.Add(node.Nodes[j].Value.AsString); end;
            '7': begin slL7.Add(node.Nodes[j].Value.AsString); end;
          end; //Case
        end; //Nodes = still
      end; //for j
    end; //Node Nil
  end; //for i

  fXML.Free;

  //Drawgrid
  DrawTileset;
end;

procedure TFormMain.DrawTileset;
begin
  dgTileset.Refresh;
end;

procedure TFormMain.DrawMap;
begin
  dgMap.Refresh;
end;

procedure TFormMain.ClearAll;
begin
  //Dummy
  slL0.Clear;
  slL1.Clear;
  slL2.Clear;
  slL3.Clear;
  slL4.Clear;
  slL5.Clear;
  slL6.Clear;
  slL7.Clear;

  SetLength(mgL0,0,0);
  SetLength(mgL1,0,0);
  SetLength(mgL2,0,0);
  SetLength(mgL3,0,0);
  SetLength(mgL4,0,0);
  SetLength(mgL5,0,0);
  SetLength(mgL6,0,0);
  SetLength(mgL7,0,0);

  tileSetFileName := '';
  tileSetName := '';
  tileSetTileSize := 8;
  currentSelectedTile := '';
  mapName := '';
  mapWidth := 0;
  mapHeight := 0;

  DrawTileset;
  DrawMap;  
end;

procedure TFormMain.CreateMap(name, tileset: string; width, height: Integer);
begin
  //ClearAll durchführen
  ClearAll;

  //Layer Array auf richtige Größe setzen
  SetLength(mgL0,width,height);
  SetLength(mgL1,width,height);
  SetLength(mgL2,width,height);
  SetLength(mgL3,width,height);
  SetLength(mgL4,width,height);
  SetLength(mgL5,width,height);
  SetLength(mgL6,width,height);
  SetLength(mgL7,width,height);

  tileSetFileName := tileset;

  OpenTileset(tileSetFileName);

  dgMap.ColCount := width;
  dgMap.RowCount := height;
  dgMap.DefaultColWidth := tileSetTileSize;
  dgMap.DefaultRowHeight := tileSetTileSize;

  mapWidth := width;
  mapHeight := height;

  mapName := name;
end;

procedure TFormMain.Beenden1Click(Sender: TObject);
begin
  FormMain.Close;
end;

procedure TFormMain.FormPaint(Sender: TObject);
begin
  Panel3.Height := Panel2.Height-Panel3.Top;
end;

procedure TFormMain.ber1Click(Sender: TObject);
begin
  aboutform.ShowModal;
end;

procedure TFormMain.ilesetEditor1Click(Sender: TObject);
begin
  FormTilesetEditor.ShowModal;
end;

procedure TFormMain.ileset1Click(Sender: TObject);
begin
  FormNewTileset.ShowModal;
end;

procedure TFormMain.Map1Click(Sender: TObject);
begin
  FormNewMap.ShowModal;
end;

procedure TFormMain.FormCreate(Sender: TObject);
begin
  FormMain.DoubleBuffered := true;

  slL0 := TStringList.Create;
  slL1 := TStringList.Create;
  slL2 := TStringList.Create;
  slL3 := TStringList.Create;
  slL4 := TStringList.Create;
  slL5 := TStringList.Create;
  slL6 := TStringList.Create;
  slL7 := TStringList.Create;
end;

procedure TFormMain.FormDestroy(Sender: TObject);
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

procedure TFormMain.dgTilesetDrawCell(Sender: TObject; ACol, ARow: Integer;
  Rect: TRect; State: TGridDrawState);
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

  if cbLayers.ItemIndex = 1 then
  begin
    dgTileset.RowCount := 1;
    if (ACol = 0) and (ARow = 0) then
    begin
      Img := TPNGObject.Create;
      Img.LoadFromFile(GetApplicationPath + 'xdata/l1_k.png');
      dgTileset.Canvas.Draw(Rect.Left, Rect.Top, Img);
      Img.Free;
    end;
  end
  else if cbLayers.ItemIndex = 5 then
  begin
    dgTileset.RowCount := 1;
    if (ACol = 0) and (ARow = 0) then
    begin
      Img := TPNGObject.Create;
      Img.LoadFromFile(GetApplicationPath + 'xdata/l5_e.png');
      dgTileset.Canvas.Draw(Rect.Left, Rect.Top, Img);
      Img.Free;
    end;
  end
  else
  begin
    if (tmpStringList.Count > 0) then
    begin
      //2*y+x
      if (GetNumberOfField(2, ACol, ARow) > tmpStringList.Count-1) then Exit;
      dgTileset.RowCount := (tmpStringList.Count div 2)+1;
      Img := TPNGObject.Create;
      Img.LoadFromFile(ExtractFileDir(tileSetFileName) + '\' + tmpStringList[GetNumberOfField(dgTileset.ColCount, ACol, ARow)]);
      dgTileset.Canvas.Draw(Rect.Left, Rect.Top, Img);
      Img.Free;
    end
    else dgTileset.RowCount := 1;
  end;

  tmpStringList.Free;
end;

procedure TFormMain.cbLayersChange(Sender: TObject);
begin
  currentSelectedTile := '';
  imgTileView.Picture := nil;
  DrawTileset;
  DrawMap;
end;

procedure TFormMain.dgTilesetSelectCell(Sender: TObject; ACol,
  ARow: Integer; var CanSelect: Boolean);
var tmpStringList: TStringList;
begin
  tmpStringList := TStringList.Create;

  case cbLayers.ItemIndex of
    0: begin
         tmpStringList.AddStrings(slL0);
         if (tmpStringList.Count > 0) then
         begin
           currentSelectedTile := ExtractFileDir(tileSetFileName) + '\' + tmpStringList[GetNumberOfField(dgTileset.ColCount, ACol, ARow)];
           imgTileView.Picture.LoadFromFile(currentSelectedTile);
         end;
       end;
    1: begin
         if (ACol = 0) and (ARow = 0) then
         begin
           currentSelectedTile := 'k';
           imgTileView.Picture.LoadFromFile(GetApplicationPath + 'xdata/l1_k.png');
         end;
       end;
    2: begin
         tmpStringList.AddStrings(slL2);
         if (tmpStringList.Count > 0) then
         begin
           currentSelectedTile := ExtractFileDir(tileSetFileName) + '\' + tmpStringList[GetNumberOfField(dgTileset.ColCount, ACol, ARow)];
           imgTileView.Picture.LoadFromFile(currentSelectedTile);
         end;
       end;
    3: tmpStringList.AddStrings(slL3);
    4: tmpStringList.AddStrings(slL4);
    5: begin
         if (ACol = 0) and (ARow = 0) then
         begin
           currentSelectedTile := 'e';
           imgTileView.Picture.LoadFromFile(GetApplicationPath + 'xdata/l5_e.png');
         end;
       end;
    6: tmpStringList.AddStrings(slL6);
    7: tmpStringList.AddStrings(slL7);
  end; //Case

  tmpStringList.Free;
end;

//Zeichnen der Karte
procedure TFormMain.dgMapSelectCell(Sender: TObject; ACol, ARow: Integer;
  var CanSelect: Boolean);
var myState: TGridDrawState;
begin
  //Dummy
   if tileSetFileName = '' then Exit;
   if currentSelectedTile = '' then Exit;

   case cbLayers.ItemIndex of
    0: mgL0[ACol, ARow] := currentSelectedTile;
    1: begin
         if mgL1[ACol, ARow] = 'k' then mgL1[ACol, ARow] := ''
         else mgL1[ACol, ARow] := 'k';
       end;
    2: mgL2[ACol, ARow] := currentSelectedTile;
    3: mgL3[ACol, ARow] := currentSelectedTile;
    4: mgL4[ACol, ARow] := currentSelectedTile;
    5: begin
         if mgL5[ACol, ARow] = 'e' then mgL5[ACol, ARow] := ''
         else mgL5[ACol, ARow] := 'e';
       end;
    6: mgL6[ACol, ARow] := currentSelectedTile;
    7: mgL7[ACol, ARow] := currentSelectedTile;
   end;

   myState := [gdSelected];
   dgMapDrawCell(Sender, ACol, ARow, dgMap.CellRect(ACol, ARow), myState);
end;

procedure TFormMain.dgMapDrawCell(Sender: TObject; ACol, ARow: Integer;
  Rect: TRect; State: TGridDrawState);
var Img: TPNGObject;
    tmpFilename2: string;
begin
  //Feld Clearen
  dgMap.Canvas.Brush.Color := clWhite;
  dgMap.Canvas.FillRect(Rect);

  if (showEverLayer0 = true) and (cbLayers.ItemIndex > 0) then  //Hintergrund anzeigen
  begin
    if High(mgL0) >= 0 then
    begin
      if mgL0[ACol, ARow] <> '' then
      begin
        Img := TPNGObject.Create;
        Img.LoadFromFile(mgL0[ACol, ARow]);
        dgMap.Canvas.Draw(Rect.Left, Rect.Top, Img);
        Img.Free;
      end;
    end;
  end
  else if (showEverLayer02 = true) then //Hintergrund anzeigen
  begin
    if High(mgL0) >= 0 then //Layer null
    begin
      if mgL0[ACol, ARow] <> '' then
      begin
        Img := TPNGObject.Create;
        Img.LoadFromFile(mgL0[ACol, ARow]);
        dgMap.Canvas.Draw(Rect.Left, Rect.Top, Img);
        Img.Free;
      end;
    end;
    if High(mgL2) >= 0 then
    begin
      if mgL2[ACol, ARow] <> '' then
      begin
        Img := TPNGObject.Create;
        Img.LoadFromFile(mgL2[ACol, ARow]);
        dgMap.Canvas.Draw(Rect.Left, Rect.Top, Img);
        Img.Free;
      end;
    end;
  end;

  //Normale Layerabfrage
  case cbLayers.ItemIndex of
    0: begin //Hintergrundebende
         if (High(mgL0) >= 0) and (showEverLayer02 = false) then //Um zuverhindern das l2 elemete überzeichnet werden
         begin
           if mgL0[ACol, ARow] <> '' then
           begin
             Img := TPNGObject.Create;
             Img.LoadFromFile(mgL0[ACol, ARow]);
             dgMap.Canvas.Draw(Rect.Left, Rect.Top, Img);
             Img.Free;
           end;
         end;
       end;
    1: begin //Kollisionsebende
         if High(mgL1) >= 0 then
         begin
           if mgL1[ACol, ARow] = 'k' then
           begin
             dgMap.Canvas.Brush.Color := clRed;
             dgMap.Canvas.FillRect(Rect);
           end
         end;
       end;
    2: begin //Dekorationsebende
         if High(mgL2) >= 0 then
         begin
           if mgL2[ACol, ARow] <> '' then
           begin
             Img := TPNGObject.Create;
             Img.LoadFromFile(mgL2[ACol, ARow]);
             dgMap.Canvas.Draw(Rect.Left, Rect.Top, Img);
             Img.Free;
           end;
         end;
       end;
    3: if High(mgL3) >= 0 then tmpFilename2 := mgL3[ACol, ARow];
    4: if High(mgL4) >= 0 then tmpFilename2 := mgL4[ACol, ARow];
    5: begin //Ereignissebede
         if High(mgL5) >= 0 then
         begin
           if mgL5[ACol, ARow] = 'e' then
           begin
             dgMap.Canvas.Brush.Color := clGreen;
             dgMap.Canvas.FillRect(Rect);
           end
         end;
       end;
    6: if High(mgL6) >= 0 then tmpFilename2 := mgL6[ACol, ARow];
    7: if High(mgL7) >= 0 then tmpFilename2 := mgL7[ACol, ARow];
  end; //Case
end;

procedure TFormMain.Speichernunter1Click(Sender: TObject);
var Node : TXMLNode;
    fXML : TXMLLib;
    i, j: Integer;
begin
  if tileSetFileName = '' then
  begin
    MessageDlg('Es ist keine Karte zum Speichern vorhanden!', mtConfirmation, [mbOk], 0);
    Exit;
  end;

  if SaveDialogMap.Execute then
  begin
    //Laden aus der XML
    fXML := TXMLLib.Create;

    //Map Format
    If ( fXML.CreatePathAndNode('xml.meta.format.version', Node, 0) ) Then Node.Value.AsString := '1.00';
    If ( fXML.CreatePathAndNode('xml.meta.format.compatibility', Node, 0) ) Then Node.Value.AsString := '1.00';

    //Informationen zur Karte
    If ( fXML.CreatePathAndNode('xml.meta.map.name', Node, 0) ) Then Node.Value.AsString := mapName;
    If ( fXML.CreatePathAndNode('xml.meta.map.width', Node, 0) ) Then Node.Value.AsInteger := mapWidth;
    If ( fXML.CreatePathAndNode('xml.meta.map.height', Node, 0) ) Then Node.Value.AsInteger := mapHeight;

    //Informationen zum Tileset
    If ( fXML.CreatePathAndNode('xml.meta.tileset.name', Node, 0) ) Then Node.Value.AsString := tileSetName;
    If ( fXML.CreatePathAndNode('xml.meta.tileset.filename', Node, 0) ) Then Node.Value.AsString := ExtractFilename(tileSetFileName);
    If ( fXML.CreatePathAndNode('xml.meta.tileset.tilesize', Node, 0) ) Then Node.Value.AsInteger := tileSetTileSize;

    for j:=0 to mapHeight-1 do
    begin
      for i:=0 to mapWidth-1 do
      begin
        If ( fXML.CreatePathAndNode('xml.layer.0.' + IntToStr(i) + '.' + IntToStr(j), Node, 0) ) Then Node.Value.AsString := ExtractFileName(mgL0[i, j]);
        If ( fXML.CreatePathAndNode('xml.layer.1.' + IntToStr(i) + '.' + IntToStr(j), Node, 0) ) Then Node.Value.AsString := ExtractFileName(mgL1[i, j]);
        If ( fXML.CreatePathAndNode('xml.layer.2.' + IntToStr(i) + '.' + IntToStr(j), Node, 0) ) Then Node.Value.AsString := ExtractFileName(mgL2[i, j]);
        If ( fXML.CreatePathAndNode('xml.layer.3.' + IntToStr(i) + '.' + IntToStr(j), Node, 0) ) Then Node.Value.AsString := ExtractFileName(mgL3[i, j]);
        If ( fXML.CreatePathAndNode('xml.layer.4.' + IntToStr(i) + '.' + IntToStr(j), Node, 0) ) Then Node.Value.AsString := ExtractFileName(mgL4[i, j]);
        If ( fXML.CreatePathAndNode('xml.layer.5.' + IntToStr(i) + '.' + IntToStr(j), Node, 0) ) Then Node.Value.AsString := ExtractFileName(mgL5[i, j]);
        If ( fXML.CreatePathAndNode('xml.layer.6.' + IntToStr(i) + '.' + IntToStr(j), Node, 0) ) Then Node.Value.AsString := ExtractFileName(mgL6[i, j]);
        If ( fXML.CreatePathAndNode('xml.layer.7.' + IntToStr(i) + '.' + IntToStr(j), Node, 0) ) Then Node.Value.AsString := ExtractFileName(mgL7[i, j]);
      end;
    end;

    fXML.SaveToFile(SaveDialogMap.FileName);
    fXML.Free;
  end;
end;

procedure TFormMain.ffnen1Click(Sender: TObject);
var Node : TXMLNode;
    fXML : TXMLLib;
    tmpStrList: TStringList;
    tmpStr: string;
    i, j: Integer;
begin
  if OpenDialogMap.Execute then
  begin
    ClearAll;

    fXML := TXMLLib.Create;
    fXML.LoadFromFile(OpenDialogMap.FileName);

    //Finden des passenden Tilesets
    tmpStrList := TStringList.Create;
    Node := fXML.GetNodeFromPath('xml.meta.tileset.filename', 0);
    tmpStr := Node.Value.AsString;
    GetFilesInDirectory(GetApplicationPath + 'tilesets\', tmpStr, tmpStrList, true);

    if tmpStrList.Count > 0 then tileSetFileName := tmpStrList.Strings[0]
    else
    begin
      MessageDlg('Das Tileset ' + tmpStr + ' konnte nicht gefunden werden!', mtInformation, [mbOk], 0);
      tmpStrList.Free;
      Exit;
    end;
    tmpStrList.Free;

    //karte erzeugen
    Node := fXML.GetNodeFromPath('xml.meta.map.name', 0);
    mapName := Node.Value.AsString;

    Node := fXML.GetNodeFromPath('xml.meta.map.width', 0);
    mapWidth := Node.Value.AsInteger;

    Node := fXML.GetNodeFromPath('xml.meta.map.height', 0);
    mapHeight := Node.Value.AsInteger;

    CreateMap(mapName, tileSetFileName, mapWidth, mapHeight);

    //kartendaten in karte laden
    for j:=0 to mapHeight-1 do
    begin
      for i:=0 to mapWidth-1 do
      begin
        Node := fXML.GetNodeFromPath('xml.layer.0.' + IntToStr(i) + '.' + IntToStr(j), 0);
        if Node.Value.AsString <> '' then mgL0[i, j] := ExtractFiledir(tileSetFileName) + '\' + Node.Value.AsString;     //Pfad

        Node := fXML.GetNodeFromPath('xml.layer.1.' + IntToStr(i) + '.' + IntToStr(j), 0);
        mgL1[i, j] := Node.Value.AsString;

        Node := fXML.GetNodeFromPath('xml.layer.2.' + IntToStr(i) + '.' + IntToStr(j), 0);
        if Node.Value.AsString <> '' then mgL2[i, j] := ExtractFiledir(tileSetFileName) + '\' + Node.Value.AsString; //Pfad

        Node := fXML.GetNodeFromPath('xml.layer.3.' + IntToStr(i) + '.' + IntToStr(j), 0);
        mgL3[i, j] := Node.Value.AsString;

        Node := fXML.GetNodeFromPath('xml.layer.4.' + IntToStr(i) + '.' + IntToStr(j), 0);
        mgL4[i, j] := Node.Value.AsString;

        Node := fXML.GetNodeFromPath('xml.layer.5.' + IntToStr(i) + '.' + IntToStr(j), 0);
        mgL5[i, j] := Node.Value.AsString;

        Node := fXML.GetNodeFromPath('xml.layer.6.' + IntToStr(i) + '.' + IntToStr(j), 0);
        mgL6[i, j] := Node.Value.AsString;

        Node := fXML.GetNodeFromPath('xml.layer.7.' + IntToStr(i) + '.' + IntToStr(j), 0);
        mgL7[i, j] := Node.Value.AsString;
      end;
    end;

    //Karte neu laden
    DrawMap;

    //xml freigeben
    fXML.Free;
  end;
end;

procedure TFormMain.Linienanzeigen1Click(Sender: TObject);
begin
  if Linienanzeigen1.Checked = true then
  begin
    Linienanzeigen1.Checked := false;
    tbLines.Down := false;
    dgMap.GridLineWidth := 0;
  end
  else
  begin
    Linienanzeigen1.Checked := true;
    tbLines.Down := true;
    dgMap.GridLineWidth := 1;
  end;
end;

procedure TFormMain.tbLinesClick(Sender: TObject);
begin
  Linienanzeigen1Click(Sender);
end;

procedure TFormMain.HintergrundanzeigenLayer01Click(Sender: TObject);
begin
  if showEverLayer0 = false then
  begin
    HintergrundanzeigenLayer01.Checked := true;
    showEverLayer0 := true;
    tbLayer0View.Down := true;
    if showEverLayer02 = true then GraphischeLayeranzeigen1Click(Sender);
  end
  else
  begin
    HintergrundanzeigenLayer01.Checked := false;
    showEverLayer0 := false;
    tbLayer0View.Down := false;
  end;

  DrawMap;
end;

procedure TFormMain.tbLayer0ViewClick(Sender: TObject);
begin
  HintergrundanzeigenLayer01Click(Sender);
end;

procedure TFormMain.GraphischeLayeranzeigen1Click(Sender: TObject);
begin
  if showEverLayer02 = false then
  begin
    GraphischeLayeranzeigen1.Checked := true;
    showEverLayer02 := true;
    if showEverLayer0 = true then HintergrundanzeigenLayer01Click(Sender);
    tbLayer02View.Down := true;
  end
  else
  begin
    GraphischeLayeranzeigen1.Checked := false;
    showEverLayer02 := false;
    tbLayer02View.Down := false;
  end;

  DrawMap;
end;

procedure TFormMain.tbLayer02ViewClick(Sender: TObject);
begin
  GraphischeLayeranzeigen1Click(Sender);
end;

end.
