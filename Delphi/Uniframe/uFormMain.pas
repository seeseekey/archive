unit uFormMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus, uFormAbout, ExtCtrls, ComCtrls, uGlobals, ABSMain,
  DB, gtcl_FileSystem, StdCtrls, gtcl_Strings, ImgList, gtcl_Math,
  VirtualTrees;

type
  TFormMain = class(TForm)
    mainmenu: TMainMenu;
    Datei1: TMenuItem;
    Beenden1: TMenuItem;
    Hilfe1: TMenuItem;
    Inhalt1: TMenuItem;
    N1: TMenuItem;
    ber1: TMenuItem;
    mainpanel: TPanel;
    ListView: TListView;
    Splitter1: TSplitter;
    Mediumauslesen1: TMenuItem;
    N3: TMenuItem;
    Suchen1: TMenuItem;
    ABSDatabase: TABSDatabase;
    ABSTable: TABSTable;
    ABSQuery: TABSQuery;
    uniMediaTable: TABSTable;
    ImageList: TImageList;
    N2: TMenuItem;
    ImgLstGenIcons: TImageList;
    TreeViewPopUp: TPopupMenu;
    EigenschaftendesDatentrgers1: TMenuItem;
    N4: TMenuItem;
    Mediumlschen1: TMenuItem;
    N5: TMenuItem;
    Mediumaktualisieren1: TMenuItem;
    TreeView: TVirtualStringTree;
    ABSTableSek: TABSTable;
    N6: TMenuItem;
    Optionen1: TMenuItem;
    N7: TMenuItem;
    Datanbankbereinigung1: TMenuItem;
    procedure ber1Click(Sender: TObject);
    procedure Beenden1Click(Sender: TObject);
    procedure Mediumauslesen1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    //procedure BuildUniPath(xPath: string; var Tree: TVirtualStringTree; Start: PVirtualNode; target:string );
    procedure BuildUniPath(xPath: string; var Tree: TVirtualStringTree; Start: PVirtualNode; target: string; cPath: string; counter: Integer);
    //procedure BuildUniPath(xPath: string; var Tree: TTreeView; Start: TTreeNode);
    procedure BuildUniTree;
    procedure TreeViewClick(Sender: TObject);
    procedure EigenschaftendesDatentrgers1Click(Sender: TObject);
    procedure Mediumlschen1Click(Sender: TObject);
    procedure TreeViewGetText(Sender: TBaseVirtualTree; Node: PVirtualNode;
      Column: TColumnIndex; TextType: TVSTTextType;
      var CellText: WideString);
    procedure TreeViewGetImageIndex(Sender: TBaseVirtualTree;
      Node: PVirtualNode; Kind: TVTImageKind; Column: TColumnIndex;
      var Ghosted: Boolean; var ImageIndex: Integer);
    function GetTreenodeValue(Start: PVirtualNode; checkString: string): PVirtualNode;
    procedure Datanbankbereinigung1Click(Sender: TObject);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  FormMain: TFormMain;
  DatabaseFileName: string='';
  TableList: TStringList;

implementation

uses uFormSelectDrive, uFormDriveProperties;

{$R *.dfm}

procedure TFormMain.ber1Click(Sender: TObject);
begin
  FormAbout.ShowModal();
end;

procedure TFormMain.Beenden1Click(Sender: TObject);
begin
 FormMain.close;
end;

procedure TFormMain.Mediumauslesen1Click(Sender: TObject);
begin
  FormSelectDrive.ShowModal();
end;

procedure TFormMain.FormCreate(Sender: TObject);
begin
  //VirtualTreeview
  Treeview.NodeDataSize := SizeOf(TMyRec);

//Datenbank anlegen wenn noch nicht existiert
  DatabaseFileName := gtFileSystem.GetApplicationPath + 'uniframe.abs';

  //Database
  ABSDatabase.DatabaseFileName := DatabaseFileName;
  ABSTable.TableName := 'xUniMaster';

  if (not ABSDatabase.Exists) then
  begin
    ABSDatabase.CreateDatabase;

    //Tabelle erzeugen ( xUniMaster )
    ABSTable.FieldDefs.Clear;
    ABSTable.FieldDefs.Add('xdKey',ftAutoInc,0,False);
    ABSTable.FieldDefs.Add('UniInternalMediaTyp',ftString,32,False); //Interner medientyp
    ABSTable.FieldDefs.Add('UniMediaTyp',ftString,32,False); //medientyp
    ABSTable.FieldDefs.Add('UniIdOfMedia',ftString,8,False); //serienNummer
    ABSTable.FieldDefs.Add('UniBezeichnungOfMedia',ftString,256,False); //Bezeichnung
    ABSTable.FieldDefs.Add('UniBeschreibungOfMedia',ftString,1024,False); //Bezeichnung
    ABSTable.FieldDefs.Add('UniArchivNummer',ftString,32,False); //ArchivNummer
    ABSTable.FieldDefs.Add('UniFolderCount',ftInteger,0,False);  // Datum des einlesevorgangs
    ABSTable.FieldDefs.Add('UniFileCount',ftInteger,0,False);  // Datum des einlesevorgangs
    ABSTable.FieldDefs.Add('UniSizeInBytes',ftLargeint ,0,False);  // Datum des einlesevorgangs
    ABSTable.FieldDefs.Add('UniDateOfRead',ftDateTime,0,False);  // Datum des einlesevorgangs
    ABSTable.FieldDefs.Add('UniTableOfMedia',ftString,32,False);

    ABSTable.IndexDefs.Clear;
    ABSTable.IndexDefs.Add('idxPrimary','xdKey',[ixPrimary]);

    ABSTable.CreateTable;
  end;

  // mit der Datenbank verbinden
  ABSDatabase.Open;

  //Tabele öffnen und auf schreibbar stellen
  ABSTable.Active := true;

  //Ini
  TableList := TStringList.Create;

  // Tree aufbauen
  BuildUniTree;
end;

procedure TFormMain.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  ABSTable.Active := false;
  ABSDatabase.Connected := false;
  ABSDatabase.Close;

  TableList.Free;
end;

// Gibt die Position eines Elementes an wenn es schon existiert (z.B SUPPORT existiert gibt er dann den zeiger darauf zurück)
function TFormMain.GetTreenodeValue(Start: PVirtualNode; checkString: string): PVirtualNode;
var i: Integer;
    node: PVirtualNode;
    NodeData: PMyRec;
begin
  Result := nil;

  if(checkstring = 'BNET') then
  begin
    Result := nil;
  end;

  if TreeView.HasChildren[Start] = true then
  begin
    node := TreeView.GetFirstChild(Start);

    while(true) do
    begin
      NodeData := TreeView.GetNodeData(node);

      if NodeData.Caption = checkstring then
      begin
        Result := node;
        Exit;
       end;

       node := node.NextSibling;

       if node = nil then Break;
    end;
  end;
end;

procedure TFormMain.BuildUniPath(xPath: string; var Tree: TVirtualStringTree; Start: PVirtualNode; target: string; cPath: string; counter: Integer);
var NewNode, node: PVirtualNode;
    newPath: string;
    TmpInt: Integer;
    NodeData: PMyRec;
begin
  if Length(xPath) = 0 then Exit;
  if AnsiLastChar(xPath)^ = '\' then xPath := Copy(xpath, 1, Length(xPath)-1);
  if Copy(xPath, 1, 1) = '\' then xPath := Copy(xPath, 2, Length(xPath)-1);
  if Length(xPath) = 0 then Exit;

  TmpInt := Ansipos('\', xPath);
  if (TmpInt = 0) then
  begin
    if GetTreenodeValue(Start, xpath) = nil then
    begin
      node := TreeView.AddChild(Start);

      NodeData := TreeView.GetNodeData(node);
      NodeData.Caption := xPath;
      NodeData.ImageIndex := 2;
      NodeData.TableListEntry := target;
      NodeData.RelativePath := cPath;

      {
     node := Tree.Items.AddChild(, xPath);
     node.ImageIndex := 2;
     node.SelectedIndex := 2;
     }
    end;
    Exit;
  end;

  newPath := Copy(xPath, TmpInt+1, Length(xPath)-TmpInt);
  xPath := Copy(xPath, 1, TmpInt-1);

  if GetTreenodeValue(Start, xpath) = nil then
  begin

        NewNode := TreeView.AddChild(Start);

      NodeData := TreeView.GetNodeData(NewNode);
      NodeData.Caption := xPath;
      NodeData.ImageIndex := 2;

      NodeData.TableListEntry := target;

      NodeData.RelativePath := cPath;


{    NewNode:=Tree.Items.AddChild(Start, xPath);
     NewNode.ImageIndex := 2;
     NewNode.SelectedIndex := 2;   }
  end
  else NewNode := GetTreenodeValue(Start, xpath);

  if counter = 0 then Exit;

  Dec(counter);
  BuildUniPath(newPath, Tree, NewNode, target, cPath, counter);
  
end;

procedure TFormMain.BuildUniTree;
var i, j: Integer;
    node, node2: PVirtualNode;
    sysSwitch: Boolean;
    NodeData: PMyRec;
begin
  TreeView.BeginUpdate;
  TreeView.Clear;
  node := TreeView.AddChild(nil); //Globaler Node
  NodeData := TreeView.GetNodeData(node);
  NodeData.Caption := 'Uniframe';
  NodeData.ImageIndex := 0;

  //TODOVT
  //node.SelectedIndex := 0;

  TableList.Clear;

  ABSTable.First;
  //Liste der Tabellen anlegen
  while not ABSTable.Eof do // Cycle until Eof is True
  begin
    TableList.Add(ABSTable.FieldByName('UniTableOfMedia').AsString);
    ABSTable.Next; //Eof False on success; Eof True when Next fails on last record 
  end;

  //Alle Tabellen durchgehen
  for i:=0 to TableList.Count-1 do
  begin
    uniMediaTable.Active := false;
    uniMediaTable.TableName := TableList.Strings[i];
    uniMediaTable.Active := true;

    node2 := TreeView.AddChild(node);

    NodeData := TreeView.GetNodeData(node2);
    NodeData.Caption := Copy(TableList.Strings[i], 0, AnsiPos('|', TableList.Strings[i])-1);
    NodeData.ImageIndex := 1;
    NodeData.TableListEntry := TableList.Strings[i];
    NodeData.RelativePath := '\';
   //   CompleteMediaCode := NodeData.TableListEntry

    //node2.SelectedIndex := 1;

    // Bauen der untersectionen
    while not uniMediaTable.Eof do //ycle until Eof is True
    begin
      BuildUniPath(uniMediaTable.FieldByName('xctPfad').AsString, TreeView, node2, TableList.Strings[i], uniMediaTable.FieldByName('xctPfad').AsString, 500);
      uniMediaTable.Next; //Eof False on success; Eof True when Next fails on last record
    end;
  end;
  

  TreeView.EndUpdate;
  //treeview.AlphaSort(true);
end;

procedure TFormMain.TreeViewClick(Sender: TObject);
var CuttedMediaCode: string;
    CompleteMediaCode: string;
    SearchString: string;
    NodePath: string;
    RelativePath: string;
    TmpListItem: TListItem;

    AttributeStr: string;
    AttributeInt: Integer;
    TmpFileName: string;

        NodeData: PMyRec;
begin
  NodeData := TreeView.GetNodeData(TreeView.FocusedNode);

  if NodeData = nil then Exit;

 //if NodeData <> nil then FormMain.Caption := NodeData.TableListEntry;

  CompleteMediaCode := NodeData.TableListEntry;

  {
  CuttedMediaCode := Copy(GetTreeNodeData(TreeView.Selected), 1, AnsiPos('|', GetTreeNodeData(TreeView.Selected))-1);
  CompleteMediaCode := GetTreeNodeData(TreeView.Selected);
  SearchString := 'Uniframe\' + CuttedMediaCode + '\';
  NodePath := GetTreeNodePath(TreeView.Selected, '\');
  RelativePath := Copy(NodePath, Length(SearchString), Length(NodePath)-Length(SearchString)+1) + '\';
                                                                                                            
  if SearchString = 'Uniframe\\' then Exit;   }

  CuttedMediaCode := Copy(CompleteMediaCode, 1, AnsiPos('|', CompleteMediaCode)-1);
  SearchString := 'Uniframe\' + CuttedMediaCode + '\';
  //NodePath := GetTreeNodePath(TreeView.Selected, '\');
  Nodepath := NodeData.RelativePath;

  RelativePath := Copy(NodePath, Length(SearchString), Length(NodePath)-Length(SearchString)+1) + '\';

  if CompleteMediaCode = '' then Exit;

  CompleteMediaCode := CompleteMediaCode + '|' + Nodepath;
  //Query durchführen
  ABSQuery.Close;
  {
  ABSQuery.SQL.Text := 'SELECT xctFilename, xctAttribute, xctSize, xctTimeStamp FROM "' +
                       CompleteMediaCode +
                       '" WHERE LOWER(xctPfad) = ' + QuotedStr(Nodepath);
                       }
  ABSQuery.SQL.Text := 'SELECT xctFilename, xctAttribute, xctSize, xctTimeStamp FROM "' +
                       CompleteMediaCode + '"';
                   //    '" WHERE LOWER(xctPfad) = ' + QuotedStr(Nodepath);
  ABSQuery.Open;

  ListView.Clear;

  while not AbsQuery.Eof do // Cycle until Eof is True
  begin
    // Process each record here
    TmpListItem := ListView.Items.Add;
    TmpFileName := AbsQuery.FieldByName('xctFilename').AsString;
    TmpListItem.Caption := TmpFileName;

    AttributeStr := '';
    AttributeInt := AbsQuery.FieldByName('xctAttribute').AsInteger;
    if (AttributeInt and 1) <> 0 then AttributeStr := AttributeStr + 'R ' else AttributeStr := AttributeStr + '  ';
    if (AttributeInt and faHidden) <> 0 then AttributeStr := AttributeStr + 'H ' else AttributeStr := AttributeStr + '  ';
    if (AttributeInt and faSysFile) <> 0 then AttributeStr := AttributeStr + 'S ' else AttributeStr := AttributeStr + '  ';
    if (AttributeInt and faArchive) <> 0 then AttributeStr := AttributeStr + 'A ' else AttributeStr := AttributeStr + '  ';
    if (AttributeInt and faSymLink) <> 0 then AttributeStr := AttributeStr + 'SymLink ' else AttributeStr := AttributeStr + '        ';
    //if (AttributeInt and faAnyFile) <> 0 then AttributeStr := AttributeStr + 'Any ' else AttributeStr := AttributeStr + '    ';
    TmpListItem.SubItems.Add(AttributeStr);

    TmpFileName := LowerCase(ExtractFileExt(TmpFileName));

    //Generische Icons
    if TmpFileName = '.ace' then TmpListItem.ImageIndex := giAce
    else if TmpFileName = '.blend' then TmpListItem.ImageIndex := giBlend
    else if TmpFileName = '.pdf' then TmpListItem.ImageIndex := giPdf
    else if TmpFileName = '.txt' then TmpListItem.ImageIndex := giTxt
    else if TmpFileName = '.zip' then TmpListItem.ImageIndex := giZip
    else if TmpFileName = '.rar' then TmpListItem.ImageIndex := giRar
    else TmpListItem.ImageIndex := giAnyFile;
    //Generische Icons ENDE

    TmpListItem.SubItems.Add(AbsQuery.FieldByName('xctSize').AsString + ' Byte');
    TmpListItem.SubItems.Add(AbsQuery.FieldByName('xctTimeStamp').AsString);

    AbsQuery.Next; // Eof False on success; Eof True when Next fails on last record
  end;

  ListView.AlphaSort;     
end;

procedure TFormMain.EigenschaftendesDatentrgers1Click(Sender: TObject);
var CompleteMediaCode: string;
    TmpInternalMediaTyp: string;
    TmpMediaTyp: string;
    TmpIdOfMedia: string;
    TmpBezeichnungOfMedia: string;
    TmpBeschreibungOfMedia: string;
    TmpArchivNummer: string;
    TmpDateOfRead: string;
    TmpSizeInBytes: Int64;
            NodeData: PMyRec;
begin
  NodeData := TreeView.GetNodeData(TreeView.FocusedNode);

  if NodeData = nil then Exit;

 //if NodeData <> nil then FormMain.Caption := NodeData.TableListEntry;

  CompleteMediaCode := NodeData.TableListEntry;
  if CompleteMediaCode = '' then Exit;

  if ABSTable.Locate('UniTableOfMedia', CompleteMediaCode, []) = false then
  begin
    Exit;
  end;

  TmpInternalMediaTyp := ABSTable.fieldByname('UniInternalMediaTyp').AsString;
  TmpMediaTyp := ABSTable.fieldByname('UniMediaTyp').AsString;
  TmpIdOfMedia := ABSTable.fieldByname('UniIdOfMedia').AsString;
  TmpBezeichnungOfMedia := ABSTable.fieldByname('UniBezeichnungOfMedia').AsString;
  TmpBeschreibungOfMedia := ABSTable.fieldByname('UniBeschreibungOfMedia').AsString;
  TmpArchivNummer := ABSTable.fieldByname('UniArchivNummer').AsString;
  TmpDateOfRead := ABSTable.fieldByname('UniDateOfRead').AsString;

  if TmpInternalMediaTyp = '' then TmpInternalMediaTyp := '-';
  if TmpMediaTyp = '' then TmpMediaTyp := '-';
  if TmpIdOfMedia = '' then TmpIdOfMedia := '-';
  if TmpBezeichnungOfMedia = '' then TmpBezeichnungOfMedia := '-';
  if TmpBeschreibungOfMedia = '' then TmpBeschreibungOfMedia := '-';
  if TmpArchivNummer = '' then TmpArchivNummer := '-';
  if TmpDateOfRead = '' then TmpDateOfRead := '-';

  uFormDriveProperties.FormDriveProperties.MemoProperty.Clear;
  uFormDriveProperties.FormDriveProperties.MemoProperty.Lines.Add('Interner Medientyp: ' + TmpInternalMediaTyp);
  uFormDriveProperties.FormDriveProperties.MemoProperty.Lines.Add('Medientyp: ' + TmpMediaTyp);
  uFormDriveProperties.FormDriveProperties.MemoProperty.Lines.Add('Seriennummer: ' + TmpIdOfMedia);
  uFormDriveProperties.FormDriveProperties.MemoProperty.Lines.Add('Bezeichnung: ' + TmpBezeichnungOfMedia);
  uFormDriveProperties.FormDriveProperties.MemoProperty.Lines.Add('Beschreibung: ' + TmpBeschreibungOfMedia);
  uFormDriveProperties.FormDriveProperties.MemoProperty.Lines.Add('Archivnummer: ' + TmpArchivNummer);
  uFormDriveProperties.FormDriveProperties.MemoProperty.Lines.Add('Datum des Lesevorganges: ' + TmpDateOfRead);
  uFormDriveProperties.FormDriveProperties.MemoProperty.Lines.Add('');
  uFormDriveProperties.FormDriveProperties.MemoProperty.Lines.Add('Gelesende Verzeichnisse: ' + ABSTable.FieldByName('UniFolderCount').AsString);
  uFormDriveProperties.FormDriveProperties.MemoProperty.Lines.Add('Gelesende Dateien: ' + ABSTable.FieldByName('UniFileCount').AsString);

  TmpSizeInBytes := ABSTable.FieldByName('UniSizeInBytes').AsInteger;
  uFormDriveProperties.FormDriveProperties.MemoProperty.Lines.Add('Gesamtgröße der Dateien: ' + IntToStr(TmpSizeInBytes) + ' Byte / ' +
  FloattoStr(gtMath.RoundToPointPosition(TmpSizeInBytes/1024,2)) + ' KB / ' +
  FloattoStr(gtMath.RoundToPointPosition(TmpSizeInBytes/1024/1024,2)) + ' MB / ' +
  FloattoStr(gtMath.RoundToPointPosition(TmpSizeInBytes/1024/1024/1024,2)) + ' GB');

  uFormDriveProperties.FormDriveProperties.ShowModal;
end;

procedure TFormMain.Mediumlschen1Click(Sender: TObject);
var CompleteMediaCode: string;
            NodeData: PMyRec;
begin
  NodeData := TreeView.GetNodeData(TreeView.FocusedNode);

  if NodeData = nil then Exit;

 //if NodeData <> nil then FormMain.Caption := NodeData.TableListEntry;

  CompleteMediaCode := NodeData.TableListEntry;
  if CompleteMediaCode = '' then Exit;

  if MessageDlg('Möchten Sie das aktuelle Medium wirklich löschen?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
  begin
    if ABSTable.Locate('UniTableOfMedia', CompleteMediaCode, []) = false then
    begin
      MessageDlg('Das Löschen ist fehlgeschlagen!', mtConfirmation, [mbOk], 0);
      Exit;
    end;

    ABSTable.Delete;

    //subtabellen     //sub tabellen löschen
      ABSQuery.Close;
  ABSQuery.SQL.Text := 'SELECT xctPfad FROM "' + CompleteMediaCode + '"';
  ABSQuery.Open;

  while not AbsQuery.Eof do // Cycle until Eof is True
  begin
    uniMediaTable.Active := false;
    uniMediaTable.TableName := CompleteMediaCode + '|' + AbsQuery.FieldByName('xctPfad').AsString;
    uniMediaTable.DeleteTable;

    AbsQuery.Next; // Eof False on success; Eof True when Next fails on last record
  end;

  //rest

    uniMediaTable.Active := false;
    uniMediaTable.TableName := CompleteMediaCode;
    uniMediaTable.DeleteTable;

    //build
    BuildUniTree;
  end;
end;

procedure TFormMain.TreeViewGetText(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType;
  var CellText: WideString);
var NodeData: PMyRec;
begin
  NodeData := Sender.GetNodeData(Node);
  CellText := NodeData.Caption;
end;

procedure TFormMain.TreeViewGetImageIndex(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Kind: TVTImageKind; Column: TColumnIndex;
  var Ghosted: Boolean; var ImageIndex: Integer);
var NodeData: PMyRec;
begin
  NodeData := Sender.GetNodeData(Node);
  ImageIndex := NodeData.ImageIndex;
end;

procedure TFormMain.Datanbankbereinigung1Click(Sender: TObject);
begin
    if MessageDlg('Mochten Sie die Datenbankbereinigung wirklich starten (Vorgang bei großen Datenmengen langwierig)?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
    begin
     ABSDatabase.Close;
     ABSDatabase.CompactDatabase;
     ABSDatabase.Open;
     MessageDlg('Die Datenbankbereinigung wurde erfolgreich abgeschlossen.', mtConfirmation, [mbOk], 0);
    end;
end;

end.
