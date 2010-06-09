unit mtFormMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus, ComCtrls, VirtualTrees, ABSMain, DB, ImgList, gtcl_Misc, gtcl_WideStrings,
  ExtCtrls, StdCtrls;

type
  TFormMain = class(TForm)
    MainMenu: TMainMenu;
    Datei1: TMenuItem;
    Beenden1: TMenuItem;
    Hilfe1: TMenuItem;
    Inhalt1: TMenuItem;
    N1: TMenuItem;
    ber1: TMenuItem;
    StatusBar1: TStatusBar;
    TreeView: TVirtualStringTree;
    ABSTable: TABSTable;
    ABSDatabase: TABSDatabase;
    ABSQuery: TABSQuery;
    N3: TMenuItem;
    Datenbankffnen1: TMenuItem;
    N4: TMenuItem;
    NeueDatenbankerzeugen1: TMenuItem;
    SaveDialog: TSaveDialog;
    N2: TMenuItem;
    Einstellungen1: TMenuItem;
    ImageList: TImageList;
    OpenDialog: TOpenDialog;
    KontexTreeView: TPopupMenu;
    NeuesProjekterstellen1: TMenuItem;
    N5: TMenuItem;
    Projekteditieren1: TMenuItem;
    N6: TMenuItem;
    Projektlschen1: TMenuItem;
    Panel1: TPanel;
    ViewPort: TVirtualStringTree;
    PageControl: TPageControl;
    tsProject: TTabSheet;
    tsBugs: TTabSheet;
    tsFeature: TTabSheet;
    btnProjectEdit: TButton;
    btnProjectDelete: TButton;
    btnBugNew: TButton;
    btnBugEdit: TButton;
    btnBugDelete: TButton;
    btnFeatureDelete: TButton;
    btnFeatureEdit: TButton;
    btnFeatureNew: TButton;
    btnProjectNew: TButton;
    TimerMain: TTimer;
    btnBugView: TButton;
    btnFeatureView: TButton;
    ilMain: TImageList;
    procedure Beenden1Click(Sender: TObject);
    procedure NeueDatenbankerzeugen1Click(Sender: TObject);
    procedure TreeViewGetImageIndex(Sender: TBaseVirtualTree;
      Node: PVirtualNode; Kind: TVTImageKind; Column: TColumnIndex;
      var Ghosted: Boolean; var ImageIndex: Integer);
    procedure TreeViewGetText(Sender: TBaseVirtualTree;
      Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType;
      var CellText: WideString);
    procedure FormCreate(Sender: TObject);
    procedure Datenbankffnen1Click(Sender: TObject);
    procedure NeuesProjekterstellen1Click(Sender: TObject);
    procedure TreeViewClick(Sender: TObject);
    procedure ViewPortGetText(Sender: TBaseVirtualTree; Node: PVirtualNode;
      Column: TColumnIndex; TextType: TVSTTextType;
      var CellText: WideString);
    procedure btnProjectNewClick(Sender: TObject);
    procedure btnBugNewClick(Sender: TObject);
    procedure TimerMainTimer(Sender: TObject);
    procedure btnBugViewClick(Sender: TObject);
    procedure btnBugEditClick(Sender: TObject);
    procedure btnFeatureNewClick(Sender: TObject);
    procedure btnFeatureViewClick(Sender: TObject);
    procedure btnFeatureEditClick(Sender: TObject);
    procedure TreeViewCompareNodes(Sender: TBaseVirtualTree; Node1,
      Node2: PVirtualNode; Column: TColumnIndex; var Result: Integer);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
    procedure CreateDatabase(fileName: string);
    procedure OpenDatabase(fileName: string);
    procedure BuildTree;
    procedure CreateProject(Name: String; Description: String; Language: String);
    procedure CreateBug(Summary: String; Description: String; Priority: String; Effect: String; Status: String);
    procedure EditBug(xdKey: LongWord; ID, Summary, Description, Priority, Effect, Status: String);
    procedure CreateFeature(Summary: String; Description: String; Priority: String; Status: String);
    procedure EditFeature(xdKey: LongWord; ID, Summary, Description, Priority, Status: String);
  end;

type tpEntryType = (None, Project, Bug, Feature);
type tpFilterType = (All, StateNeu, StateRueckmeldung, StateAnerkannt, StateBestaetigt, StateZugewiesen, StateGeschlossen);

type
  PMyRecTreeView = ^TMyRecTreeView;
  TMyRecTreeView = record
    Caption: WideString;
    ImageIndex: Integer;
    TypeOfEntry: tpEntryType;
    TypeOfFilter: tpFilterType;
    Table: WideString;
    xdKey: LongWord;
  end;

type
  PMyRecViewport = ^TMyRecViewport;
  TMyRecViewport = record
    Column01: WideString;
    Column02: WideString;
    Column03: WideString;
    Column04: WideString;
    Column05: WideString;
    Column06: WideString;
    Column07: WideString;
    Column08: WideString;
    Column09: WideString;
    Column10: WideString;
    TypeOfEntry: tpEntryType;
    Table: WideString;
    xdKey: LongWord;
  end;

var
  FormMain: TFormMain;
  IsDatabaseOpen: Boolean = false;
  ViewState: tpEntryType = None;

const
  cnstReflectionVersion = '1.00';
  cnstFormatName = 'misstag Database Format (mdf)';
  cnstFormatVersion = '1.00';
  cnstFormatVersionCompatibleDown = '1.00';
  cnstCreator = 'misstag v1.00';

implementation

uses mtFormProjectNewEdit, mtFormBugNewEdit, mtFormFeatureNewEdit;

{$R *.dfm}

//Globale Funktionen

//Erzeugt eine neue Datenbank und legt sie an
procedure TFormMain.CreateDatabase(fileName: string);
begin
  //Database
  ABSDatabase.DatabaseFileName := fileName;

  if (not ABSDatabase.Exists) then
  begin
    ABSDatabase.CreateDatabase;

    //Tabelle erzeugen ( xMain )
    ABSTable.TableName := 'xMain';

    ABSTable.Fields.Clear;
    ABSTable.AdvFieldDefs.Clear;
    ABSTable.AdvFieldDefs.Clear;

    ABSTable.FieldDefs.Clear;
    ABSTable.FieldDefs.Add('xdKey',ftAutoInc,0,False);
    ABSTable.FieldDefs.Add('Project',ftString,512,False); //Key
    ABSTable.FieldDefs.Add('Description',ftString,2048,False); //Value
    ABSTable.FieldDefs.Add('Language',ftString,512,False); //Value
    ABSTable.FieldDefs.Add('ProjectTable',ftString,64,False); //Value

    ABSTable.IndexDefs.Clear;
    ABSTable.IndexDefs.Add('idxPrimary','xdKey',[ixPrimary]);

    ABSTable.CreateTable;

   //Tabelle erzeugen ( xReflection )
    //ABSTable.ClearFields;
    ABSTable.TableName := 'xReflection';

    ABSTable.Fields.Clear;
    ABSTable.AdvFieldDefs.Clear;
    ABSTable.AdvFieldDefs.Clear;

    ABSTable.FieldDefs.Clear;
    ABSTable.FieldDefs.Add('xdKey',ftAutoInc,0,False);
    ABSTable.FieldDefs.Add('Key',ftString,256,False); //Key
    ABSTable.FieldDefs.Add('Value',ftString,256,False); //Value

    ABSTable.IndexDefs.Clear;
    ABSTable.IndexDefs.Add('idxPrimary','xdKey',[ixPrimary]);

    ABSTable.CreateTable;

    // mit der Datenbank verbinden
    ABSDatabase.Open;

    //Tabele öffnen und auf schreibbar stellen
    ABSTable.TableName := 'xReflection';
    ABSTable.Active := true;

    //Start Transaction
    ABSDataBase.StartTransaction;

    //Insert einfügen
    ABSTable.Insert;
    ABSTable.FieldByName('Key').AsString := 'ReflectionVersion';
    ABSTable.FieldByName('Value').AsString := cnstReflectionVersion;
    ABSTable.Post;

    ABSTable.Insert;
    ABSTable.FieldByName('Key').AsString := 'FormatDescription';
    ABSTable.FieldByName('Value').AsString := cnstFormatName;
    ABSTable.Post;

    ABSTable.Insert;
    ABSTable.FieldByName('Key').AsString := 'FormatVersion';
    ABSTable.FieldByName('Value').AsString := cnstFormatVersion;
    ABSTable.Post;

    ABSTable.Insert;
    ABSTable.FieldByName('Key').AsString := 'FormatVersionCompatibleDown';
    ABSTable.FieldByName('Value').AsString := cnstFormatVersionCompatibleDown;
    ABSTable.Post;

    ABSTable.Insert;
    ABSTable.FieldByName('Key').AsString := 'Creator';
    ABSTable.FieldByName('Value').AsString := cnstCreator;
    ABSTable.Post;

    ABSDataBase.Commit();

    ABSDatabase.Close;
  end;

  OpenDatabase(FileName);
end;

procedure TFormMain.OpenDatabase(fileName: string);
begin
  //Database
  ABSDatabase.DatabaseFileName := fileName;

  if (not ABSDatabase.Exists) then Exit;

  ABSDatabase.Open;
  IsDatabaseOpen := true;

  BuildTree;
end;

procedure TFormMain.BuildTree;
var node, node2, node3, node4: PVirtualNode;
    NodeData: PMyRecTreeView;
    tmpTableName: String;
begin
  //TreeView.BeginUpdate;
  TreeView.Clear;

  node := TreeView.AddChild(nil); //Globaler Node
  NodeData := TreeView.GetNodeData(node);
  NodeData.Caption := 'misstag';
  NodeData.ImageIndex := 0;
  NodeData.TypeOfEntry := None;

  if IsDatabaseOpen = false then Exit;

  ABSTable.TableName := 'xMain';
  ABSTable.Active := true;

  AbsTable.First;

  while not AbsTable.Eof do //ycle until Eof is True
  begin
   node2 := TreeView.AddChild(node); //Globaler Node
   NodeData := TreeView.GetNodeData(node2);
   NodeData.Caption := ABSTable.FieldByName('Project').AsString;
   NodeData.ImageIndex := 1;
   NodeData.TypeOfEntry := Project;
   NodeData.Table := ABSTable.FieldByName('ProjectTable').AsString;
   NodeData.xdKey := AbsTable.FieldByName('xdKey').AsInteger;

   //Projekttabbelen anlegen
   ABSQuery.Close;
  ABSQuery.SQL.Text := 'SELECT * FROM "'+ABSTable.FieldByName('ProjectTable').AsString+'"';
   ABSQuery.Open;

   ABSQuery.First;

    while not AbsQuery.Eof do // Cycle until Eof is True
    begin

      node3 := TreeView.AddChild(node2); //Globaler Node
      NodeData := TreeView.GetNodeData(node3);

      tmpTableName := AbsQuery.FieldByName('Table').AsString;

      if AbsQuery.FieldByName('Name').AsString = 'Bug' then
      begin
       NodeData.Caption := 'Bugs';
       NodeData.TypeOfEntry := Bug;
       NodeData.ImageIndex := 2;
       NodeData.xdKey := AbsTable.FieldByName('xdKey').AsInteger;

       NodeData.Table := tmpTableName;

       node3 := TreeView.AddChild(node3); //Globaler Node
       NodeData := TreeView.GetNodeData(node3);
       NodeData.Caption := 'nach Status';
       NodeData.TypeOfEntry := Bug;
       NodeData.ImageIndex := 3;
       NodeData.Table := tmpTableName;

       //Stati
       node4 := TreeView.AddChild(node3); //Globaler Node
       NodeData := TreeView.GetNodeData(node4);
       NodeData.TypeOfEntry := Bug;
       NodeData.TypeOfFilter := StateNeu;
       NodeData.Caption := 'neu';
       NodeData.ImageIndex := 2;
       NodeData.Table := tmpTableName;

       node4 := TreeView.AddChild(node3); //Globaler Node
       NodeData := TreeView.GetNodeData(node4);
       NodeData.TypeOfEntry := Bug;
       NodeData.TypeOfFilter := StateRueckmeldung;
       NodeData.Caption := 'Rückmeldung';
       NodeData.ImageIndex := 2;
       NodeData.Table := tmpTableName;

       node4 := TreeView.AddChild(node3); //Globaler Node
       NodeData := TreeView.GetNodeData(node4);
       NodeData.TypeOfEntry := Bug;
       NodeData.TypeOfFilter := StateAnerkannt;
       NodeData.Caption := 'anerkannt';
       NodeData.ImageIndex := 2;
       NodeData.Table := tmpTableName;

       node4 := TreeView.AddChild(node3); //Globaler Node
       NodeData := TreeView.GetNodeData(node4);
       NodeData.TypeOfEntry := Bug;
       NodeData.TypeOfFilter := StateBestaetigt;
       NodeData.Caption := 'bestätigt';
       NodeData.ImageIndex := 2;
       NodeData.Table := tmpTableName;

       node4 := TreeView.AddChild(node3); //Globaler Node
       NodeData := TreeView.GetNodeData(node4);
       NodeData.TypeOfEntry := Bug;
       NodeData.TypeOfFilter := StateZugewiesen;
       NodeData.Caption := 'zugewiesen';
       NodeData.ImageIndex := 2;
       NodeData.Table := tmpTableName;

       node4 := TreeView.AddChild(node3); //Globaler Node
       NodeData := TreeView.GetNodeData(node4);
       NodeData.TypeOfEntry := Bug;
       NodeData.TypeOfFilter := StateGeschlossen;
       NodeData.Caption := 'geschlossen';
       NodeData.ImageIndex := 2;
       NodeData.Table := tmpTableName;

      end
      else if AbsQuery.FieldByName('Name').AsString = 'Feature' then
      begin
       NodeData.Caption := 'Features';
       NodeData.TypeOfEntry := Feature;
       NodeData.ImageIndex := 2;
       NodeData.xdKey := AbsTable.FieldByName('xdKey').AsInteger;

       NodeData.Table := tmpTableName;

       node3 := TreeView.AddChild(node3); //Globaler Node
       NodeData := TreeView.GetNodeData(node3);
       NodeData.Caption := 'nach Status';
       NodeData.TypeOfEntry := Feature;
       NodeData.ImageIndex := 3;
       NodeData.Table := tmpTableName;

       //Stati
       node4 := TreeView.AddChild(node3); //Globaler Node
       NodeData := TreeView.GetNodeData(node4);
       NodeData.TypeOfEntry := Feature;
       NodeData.TypeOfFilter := StateNeu;
       NodeData.Caption := 'neu';
       NodeData.ImageIndex := 2;
       NodeData.Table := tmpTableName;

       node4 := TreeView.AddChild(node3); //Globaler Node
       NodeData := TreeView.GetNodeData(node4);
       NodeData.TypeOfEntry := Feature;
       NodeData.TypeOfFilter := StateRueckmeldung;
       NodeData.Caption := 'Rückmeldung';
       NodeData.ImageIndex := 2;
       NodeData.Table := tmpTableName;

       node4 := TreeView.AddChild(node3); //Globaler Node
       NodeData := TreeView.GetNodeData(node4);
       NodeData.TypeOfEntry := Feature;
       NodeData.TypeOfFilter := StateAnerkannt;
       NodeData.Caption := 'anerkannt';
       NodeData.ImageIndex := 2;
       NodeData.Table := tmpTableName;

       node4 := TreeView.AddChild(node3); //Globaler Node
       NodeData := TreeView.GetNodeData(node4);
       NodeData.TypeOfEntry := Feature;
       NodeData.TypeOfFilter := StateBestaetigt;
       NodeData.Caption := 'bestätigt';
       NodeData.ImageIndex := 2;
       NodeData.Table := tmpTableName;

       node4 := TreeView.AddChild(node3); //Globaler Node
       NodeData := TreeView.GetNodeData(node4);
       NodeData.TypeOfEntry := Feature;
       NodeData.TypeOfFilter := StateZugewiesen;
       NodeData.Caption := 'zugewiesen';
       NodeData.ImageIndex := 2;
       NodeData.Table := tmpTableName;

       node4 := TreeView.AddChild(node3); //Globaler Node
       NodeData := TreeView.GetNodeData(node4);
       NodeData.TypeOfEntry := Feature;
       NodeData.TypeOfFilter := StateGeschlossen;
       NodeData.Caption := 'geschlossen';
       NodeData.ImageIndex := 2;
       NodeData.Table := tmpTableName;
      end;

      AbsQuery.Next; // Eof False on success; Eof True when Next fails on last record
    end;


    AbsTable.Next; //Eof False on success; Eof True when Next fails on last record
  end;

 // TreeView.EndUpdate;

 TreeView.SortTree(0, sdAscending, True);
end;

procedure TFormMain.CreateProject(Name: String; Description: String; Language: String);
var ProjectTableName: String;
    ProjectBugTableName: String;
    ProjectFeatureTableName: String;
begin
    //Pretrim
    Description := TrimRight(Description);

    //Main
    ProjectTableName := 'xProject|' + gtMisc.GetUniqueID;

    //Tabele öffnen und auf schreibbar stellen
    ABSTable.Active := false;
    ABSTable.TableName := 'xMain';
    ABSTable.Active := true;

    //Start Transaction
    ABSDataBase.StartTransaction;

    //Insert einfügen
    ABSTable.Insert;
    ABSTable.FieldByName('Project').AsString := Name;
    ABSTable.FieldByName('Description').AsString := Description;
    ABSTable.FieldByName('Language').AsString := Language;
    ABSTable.FieldByName('ProjectTable').AsString := ProjectTableName;
    ABSTable.Post;

    ABSDataBase.Commit();

    //projekttabelle generieren

    ABSTable.Close;

    //Tabelle erzeugen ( xMain )
    ABSTable.TableName := ProjectTableName;

    ABSTable.Fields.Clear;
    ABSTable.AdvFieldDefs.Clear;
    ABSTable.AdvFieldDefs.Clear;

    ABSTable.FieldDefs.Clear;
    ABSTable.FieldDefs.Add('xdKey',ftAutoInc,0,False);
    ABSTable.FieldDefs.Add('Name',ftString,128,False); //Key
    ABSTable.FieldDefs.Add('Table',ftString,64,False);

    ABSTable.CreateTable;
    // mit der Datenbank verbinden
   // ABSDatabase.Open;
   //ABSTable.Open;

    //Tabele öffnen und auf schreibbar stellen
    ABSTable.TableName := ProjectTableName;
    ABSTable.Active := true;

    //Start Transaction
    ABSDataBase.StartTransaction;

    //Defi
    ProjectBugTableName := 'xProject|Bug|' + gtMisc.GetUniqueID;
    ProjectFeatureTableName := 'xProject|Feature|' + gtMisc.GetUniqueID;

    //Insert einfügen
    ABSTable.Insert;
    ABSTable.FieldByName('Name').AsString := 'Bug';
    ABSTable.FieldByName('Table').AsString := ProjectBugTableName;
    ABSTable.Post;

    ABSTable.Insert;
    ABSTable.FieldByName('Name').AsString := 'Feature';
    ABSTable.FieldByName('Table').AsString := ProjectFeatureTableName;
    ABSTable.Post;

    ABSDataBase.Commit();

    //Bugtable
ABSTable.Close;

    //Tabelle erzeugen ( ProjectBugTableName )
    ABSTable.TableName := ProjectBugTableName;

    ABSTable.Fields.Clear;
    ABSTable.AdvFieldDefs.Clear;
    ABSTable.AdvFieldDefs.Clear;

    ABSTable.FieldDefs.Clear;
    ABSTable.FieldDefs.Add('xdKey',ftAutoInc,0,False);
    ABSTable.FieldDefs.Add('ID',ftString,32,False); //Key
    ABSTable.FieldDefs.Add('Priority',ftString,32,False);
    ABSTable.FieldDefs.Add('Effect',ftString,64,False);
    ABSTable.FieldDefs.Add('Status',ftString,64,False);
    ABSTable.FieldDefs.Add('Summary',ftString,512,False);
    ABSTable.FieldDefs.Add('Description',ftString,2048,False);

    ABSTable.CreateTable;

    //Tabelle erzeugen ( ProjectFeatureTableName )
    ABSTable.TableName := ProjectFeatureTableName;

    ABSTable.Fields.Clear;
    ABSTable.AdvFieldDefs.Clear;
    ABSTable.AdvFieldDefs.Clear;

    ABSTable.FieldDefs.Clear;
    ABSTable.FieldDefs.Add('xdKey',ftAutoInc,0,False);
    ABSTable.FieldDefs.Add('ID',ftString,32,False); //Key
    ABSTable.FieldDefs.Add('Priority',ftString,32,False);
    ABSTable.FieldDefs.Add('Status',ftString,64,False);
    ABSTable.FieldDefs.Add('Summary',ftString,512,False);
    ABSTable.FieldDefs.Add('Description',ftString,2048,False);

    ABSTable.CreateTable;

   BuildTree;
end;

procedure TFormMain.CreateBug(Summary: String; Description: String; Priority: String; Effect: String; Status: String);
var Nodedata: PMyRecTreeview;
begin
    //Pretrim
    Description := TrimRight(Description);

    //Main
    NodeData := TreeView.GetNodeData(TreeView.FocusedNode);

    //Tabele öffnen und auf schreibbar stellen
    ABSTable.Active := false;
    ABSTable.TableName := NodeData.Table;
    ABSTable.Active := true;

    //Start Transaction
    ABSDataBase.StartTransaction;

    //Insert einfügen
    ABSTable.Insert;
    ABSTable.FieldByName('ID').AsString := 'BG|' + gtMisc.GetUniqueID;
    ABSTable.FieldByName('Priority').AsString := Priority;
    ABSTable.FieldByName('Effect').AsString := Effect;
    ABSTable.FieldByName('Status').AsString := Status;
    ABSTable.FieldByName('Summary').AsString := Summary;
    ABSTable.FieldByName('Description').AsString := Description;
    ABSTable.Post;

    ABSDataBase.Commit();

    //Reload Bugtable
    TreeViewClick(nil);
end;

procedure TFormMain.EditBug(xdKey: LongWord; ID, Summary, Description, Priority, Effect, Status: String);
var Nodedata: PMyRecTreeview;
begin
    //Pretrim
    Description := TrimRight(Description);

    //Main
    NodeData := TreeView.GetNodeData(TreeView.FocusedNode);

    //Tabele öffnen und auf schreibbar stellen
    ABSTable.Active := false;
    ABSTable.TableName := NodeData.Table;
    ABSTable.Active := true;

    // Zu passendem Index springen
    ABSTable.IndexName:='idxPrimary';
    ABSTable.SetKey;
    ABSTable.Fields[0].AsString := IntToStr(xdKey);
    if not ABSTable.GotoKey then ShowMessage('Record not found');

    //Start Transaction
    ABSDataBase.StartTransaction;

    //Insert einfügen
    ABSTable.Edit;
    ABSTable.FieldByName('Priority').AsString := Priority;
    ABSTable.FieldByName('Effect').AsString := Effect;
    ABSTable.FieldByName('Status').AsString := Status;
    ABSTable.FieldByName('Summary').AsString := Summary;
    ABSTable.FieldByName('Description').AsString := Description;
    ABSTable.Post;

    ABSDataBase.Commit();

    //Reload Bugtable
    TreeViewClick(nil);
end;

procedure TFormMain.CreateFeature(Summary: String; Description: String; Priority: String; Status: String);
var Nodedata: PMyRecTreeview;
begin
    //Pretrim
    Description := TrimRight(Description);

    //Main
    NodeData := TreeView.GetNodeData(TreeView.FocusedNode);

    //Tabele öffnen und auf schreibbar stellen
    ABSTable.Active := false;
    ABSTable.TableName := NodeData.Table;
    ABSTable.Active := true;

    //Start Transaction
    ABSDataBase.StartTransaction;

    //Insert einfügen
    ABSTable.Insert;
    ABSTable.FieldByName('ID').AsString := 'FT|' + gtMisc.GetUniqueID;
    ABSTable.FieldByName('Priority').AsString := Priority;
    ABSTable.FieldByName('Status').AsString := Status;
    ABSTable.FieldByName('Summary').AsString := Summary;
    ABSTable.FieldByName('Description').AsString := Description;
    ABSTable.Post;

    ABSDataBase.Commit();

    //Reload Bugtable
    TreeViewClick(nil);
end;

procedure TFormMain.EditFeature(xdKey: LongWord; ID, Summary, Description, Priority, Status: String);
var Nodedata: PMyRecTreeview;
begin
    //Pretrim
    Description := TrimRight(Description);

    //Main
    NodeData := TreeView.GetNodeData(TreeView.FocusedNode);

    //Tabele öffnen und auf schreibbar stellen
    ABSTable.Active := false;
    ABSTable.TableName := NodeData.Table;
    ABSTable.Active := true;

    // Zu passendem Index springen
    ABSTable.IndexName:='idxPrimary';
    ABSTable.SetKey;
    ABSTable.Fields[0].AsString := IntToStr(xdKey);
    if not ABSTable.GotoKey then ShowMessage('Record not found');

    //Start Transaction
    ABSDataBase.StartTransaction;

    //Insert einfügen
    ABSTable.Edit;
    ABSTable.FieldByName('Priority').AsString := Priority;
    ABSTable.FieldByName('Status').AsString := Status;
    ABSTable.FieldByName('Summary').AsString := Summary;
    ABSTable.FieldByName('Description').AsString := Description;
    ABSTable.Post;

    ABSDataBase.Commit();

    //Reload Bugtable
    TreeViewClick(nil);
end;


//#######################################

procedure TFormMain.Beenden1Click(Sender: TObject);
begin
  FormMain.Close;
end;

procedure TFormMain.NeueDatenbankerzeugen1Click(Sender: TObject);
begin
  if SaveDialog.Execute then
  begin
    CreateDatabase(SaveDialog.FileName);
  end;
end;

procedure TFormMain.TreeViewGetImageIndex(
  Sender: TBaseVirtualTree; Node: PVirtualNode; Kind: TVTImageKind;
  Column: TColumnIndex; var Ghosted: Boolean; var ImageIndex: Integer);
var NodeData: PMyRecTreeView;
begin
  NodeData := Sender.GetNodeData(Node);
  ImageIndex := NodeData.ImageIndex;
end;

procedure TFormMain.TreeViewGetText(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType;
  var CellText: WideString);
var NodeData: PMyRecTreeView;
begin
  NodeData := Sender.GetNodeData(Node);
  CellText := NodeData.Caption;
end;

procedure TFormMain.FormCreate(Sender: TObject);
begin
  FormMain.DoubleBuffered := true;

  Treeview.NodeDataSize := SizeOf(TMyRecTreeView);
  Viewport.NodeDataSize := SizeOf(TMyRecViewport);

  BuildTree;
end;

procedure TFormMain.Datenbankffnen1Click(Sender: TObject);
begin
  if OpenDialog.Execute then
  begin
    OpenDatabase(OpenDialog.FileName);
  end;
end;

procedure TFormMain.NeuesProjekterstellen1Click(Sender: TObject);
begin
  FormProjectNewEdit.Show;
end;

procedure TFormMain.TreeViewClick(Sender: TObject);
var Nodedata: PMyRecTreeview;
    NodedataVP: PMyRecViewPort;
    node: PVirtualNode;
begin
  //Dummy
  NodeData := TreeView.GetNodeData(TreeView.FocusedNode);

  if NodeData = nil then Exit;

  ViewState := NodeData.TypeOfEntry;

  ViewPort.Clear;
  ViewPort.Header.Columns.Clear;

  if NodeData.TypeOfEntry = None then Exit;

  //FormMain.Caption := IntToStr(NodeData.ImageIndex);

  if Nodedata.TypeOfEntry = Project then
  begin
    PageControl.ActivePageIndex := 0;

    ViewPort.Header.Columns.Add;
    ViewPort.Header.Columns.Add;

    ViewPort.Header.Columns[0].Width := Viewport.Width div 2 - 3;
    ViewPort.Header.Columns[1].Width := Viewport.Width div 2;

    ViewPort.Header.Columns[0].Text := 'Name';
    ViewPort.Header.Columns[1].Text := 'Beschreibung';

    //Abfrage der Daten
    ABSQuery.Close;
    ABSQuery.SQL.Text := 'SELECT * FROM "xMain" WHERE xdKey = ' + IntToStr(NodeData.xdKey);
    ABSQuery.Open;

    //Node hinzufügen
    node := Viewport.AddChild(nil); //Globaler Node
    //NodedataVP := TreeView.GetNodeData(node);
    NodedataVP := ViewPort.GetNodeData(node);
    NodedataVP.Column01 := 'Projektname';
    NodedataVP.Column02 := ABSQuery.FieldByName('Project').AsString;

    node := Viewport.AddChild(nil); //Globaler Node
    NodedataVP := ViewPort.GetNodeData(node);
    NodedataVP.Column01 := 'Beschreibung';
    NodedataVP.Column02 := ABSQuery.FieldByName('Description').AsString;

    node := Viewport.AddChild(nil); //Globaler Node
    NodedataVP := ViewPort.GetNodeData(node);
    NodedataVP.Column01 := 'Programmiersprache';
    NodedataVP.Column02 := ABSQuery.FieldByName('Language').AsString;
  end
  else if Nodedata.TypeOfEntry = Bug then
  begin
    PageControl.ActivePageIndex := 1;

    ViewPort.Header.Columns.Add;
    ViewPort.Header.Columns.Add;
    ViewPort.Header.Columns.Add;
    ViewPort.Header.Columns.Add;
    ViewPort.Header.Columns.Add;

    ViewPort.Header.Columns[0].Width := 170;
    ViewPort.Header.Columns[1].Width := 70;
    ViewPort.Header.Columns[2].Width := 100;
    ViewPort.Header.Columns[3].Width := 80;
    ViewPort.Header.Columns[4].Width := Viewport.Width - 423;

    ViewPort.Header.Columns[0].Text := 'ID';
    ViewPort.Header.Columns[1].Text := 'Priorität';
    ViewPort.Header.Columns[2].Text := 'Effekt';
    ViewPort.Header.Columns[3].Text := 'Status';
    ViewPort.Header.Columns[4].Text := 'Zusammenfassung';
    //ViewPort.Header.Columns[5].Text := 'Beschreibung';

    //Abfrage der Daten
    ABSQuery.Close;
    if NodeData.TypeOfFilter = StateNeu then ABSQuery.SQL.Text := 'SELECT * FROM "' + Nodedata.Table + '" WHERE Status = "neu"'
    else if NodeData.TypeOfFilter = StateRueckmeldung then ABSQuery.SQL.Text := 'SELECT * FROM "' + Nodedata.Table + '" WHERE Status = "Rückmeldung"'
    else if NodeData.TypeOfFilter = StateAnerkannt then ABSQuery.SQL.Text := 'SELECT * FROM "' + Nodedata.Table + '" WHERE Status = "anerkannt"'
    else if NodeData.TypeOfFilter = StateBestaetigt then ABSQuery.SQL.Text := 'SELECT * FROM "' + Nodedata.Table + '" WHERE Status = "bestätigt"'
    else if NodeData.TypeOfFilter = StateZugewiesen then ABSQuery.SQL.Text := 'SELECT * FROM "' + Nodedata.Table + '" WHERE Status = "zugewiesen"'
    else if NodeData.TypeOfFilter = StateGeschlossen then ABSQuery.SQL.Text := 'SELECT * FROM "' + Nodedata.Table + '" WHERE Status = "geschlossen"'
    else ABSQuery.SQL.Text := 'SELECT * FROM "' + Nodedata.Table + '"';
    ABSQuery.Open;

    while not ABSQuery.Eof do // Cycle until Eof is True
    begin
       node := Viewport.AddChild(nil); //Globaler Node
       NodedataVP := TreeView.GetNodeData(node);
       NodedataVP.Column01 := ABSQuery.FieldByName('ID').AsString;
       NodedataVP.Column02 := ABSQuery.FieldByName('Priority').AsString;
       NodedataVP.Column03 := ABSQuery.FieldByName('Effect').AsString;
       NodedataVP.Column04 := ABSQuery.FieldByName('Status').AsString;
       NodedataVP.Column05 := ABSQuery.FieldByName('Summary').AsString;

       NodedataVP.TypeOfEntry := Nodedata.TypeOfEntry;
       NodedataVP.Table := Nodedata.Table;
       NodedataVP.xdKey := ABSQuery.FieldByName('xdKey').AsInteger;

       AbsQuery.Next; // Eof False on success; Eof True when Next fails on last record
    end;
  end
  else if Nodedata.TypeOfEntry = Feature then
  begin
    PageControl.ActivePageIndex := 2;

    ViewPort.Header.Columns.Add;
    ViewPort.Header.Columns.Add;
    ViewPort.Header.Columns.Add;
    ViewPort.Header.Columns.Add;

    ViewPort.Header.Columns[0].Width := 170;
    ViewPort.Header.Columns[1].Width := 70;
    ViewPort.Header.Columns[2].Width := 80;
    ViewPort.Header.Columns[3].Width := Viewport.Width - 323;

    ViewPort.Header.Columns[0].Text := 'ID';
    ViewPort.Header.Columns[1].Text := 'Priorität';
    ViewPort.Header.Columns[2].Text := 'Status';
    ViewPort.Header.Columns[3].Text := 'Zusammenfassung';
    //ViewPort.Header.Columns[5].Text := 'Beschreibung';

    //Abfrage der Daten
    ABSQuery.Close;
    if NodeData.TypeOfFilter = StateNeu then ABSQuery.SQL.Text := 'SELECT * FROM "' + Nodedata.Table + '" WHERE Status = "neu"'
    else if NodeData.TypeOfFilter = StateRueckmeldung then ABSQuery.SQL.Text := 'SELECT * FROM "' + Nodedata.Table + '" WHERE Status = "Rückmeldung"'
    else if NodeData.TypeOfFilter = StateAnerkannt then ABSQuery.SQL.Text := 'SELECT * FROM "' + Nodedata.Table + '" WHERE Status = "anerkannt"'
    else if NodeData.TypeOfFilter = StateBestaetigt then ABSQuery.SQL.Text := 'SELECT * FROM "' + Nodedata.Table + '" WHERE Status = "bestätigt"'
    else if NodeData.TypeOfFilter = StateZugewiesen then ABSQuery.SQL.Text := 'SELECT * FROM "' + Nodedata.Table + '" WHERE Status = "zugewiesen"'
    else if NodeData.TypeOfFilter = StateGeschlossen then ABSQuery.SQL.Text := 'SELECT * FROM "' + Nodedata.Table + '" WHERE Status = "geschlossen"'
    else ABSQuery.SQL.Text := 'SELECT * FROM "' + Nodedata.Table + '"';
    ABSQuery.Open;

    while not ABSQuery.Eof do // Cycle until Eof is True
    begin
       node := Viewport.AddChild(nil); //Globaler Node
       NodedataVP := TreeView.GetNodeData(node);
       NodedataVP.Column01 := ABSQuery.FieldByName('ID').AsString;
       NodedataVP.Column02 := ABSQuery.FieldByName('Priority').AsString;
       NodedataVP.Column03 := ABSQuery.FieldByName('Status').AsString;
       NodedataVP.Column04 := ABSQuery.FieldByName('Summary').AsString;

       NodedataVP.TypeOfEntry := Nodedata.TypeOfEntry;
       NodedataVP.Table := Nodedata.Table;
       NodedataVP.xdKey := ABSQuery.FieldByName('xdKey').AsInteger;

       AbsQuery.Next; // Eof False on success; Eof True when Next fails on last record
    end;
  end;

end;

procedure TFormMain.ViewPortGetText(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType;
  var CellText: WideString);
var NodeData: PMyRecViewport;
begin
 NodeData := Sender.GetNodeData(Node);

 if NodeData = nil then Exit;

 if ViewState = Project then
 begin
   case Column of
    0: CellText := NodeData.Column01;
    1: CellText := NodeData.Column02;
    end;
  end
 else if ViewState = Bug then
 begin
   case Column of
    0: CellText := NodeData.Column01;
    1: CellText := NodeData.Column02;
    2: CellText := NodeData.Column03;
    3: CellText := NodeData.Column04;
    4: CellText := NodeData.Column05;
    end;
  end
 else if ViewState = Feature then
 begin
   case Column of
    0: CellText := NodeData.Column01;
    1: CellText := NodeData.Column02;
    2: CellText := NodeData.Column03;
    3: CellText := NodeData.Column04;
    end;
  end;
end;

procedure TFormMain.btnProjectNewClick(Sender: TObject);
begin
  NeuesProjekterstellen1Click(Sender);
end;

procedure TFormMain.btnBugNewClick(Sender: TObject);
begin
  FormBugNewEdit.ShowNew;
end;

procedure TFormMain.TimerMainTimer(Sender: TObject);
begin
  if IsDatabaseOpen = true then btnProjectNew.Enabled := true
  else btnProjectNew.Enabled := false;

  case ViewState of
  None:
    begin
      btnProjectEdit.Enabled := false;
      btnProjectDelete.Enabled := false;

      btnBugView.Enabled := false;
      btnBugNew.Enabled := false;
      btnBugEdit.Enabled := false;
      btnBugDelete.Enabled := false;

      btnFeatureView.Enabled := false;
      btnFeatureNew.Enabled := false;
      btnFeatureEdit.Enabled := false;
      btnFeatureDelete.Enabled := false;
    end;
  Project:
    begin
      btnProjectEdit.Enabled := true;
      btnProjectDelete.Enabled := true;

      btnBugView.Enabled := false;
      btnBugNew.Enabled := false;
      btnBugEdit.Enabled := false;
      btnBugDelete.Enabled := false;

      btnFeatureView.Enabled := false;
      btnFeatureNew.Enabled := false;
      btnFeatureEdit.Enabled := false;
      btnFeatureDelete.Enabled := false;
    end;
  Bug:
    begin
      btnProjectEdit.Enabled := false;
      btnProjectDelete.Enabled := false;

      btnBugView.Enabled := true;
      btnBugNew.Enabled := true;
      btnBugEdit.Enabled := true;
      btnBugDelete.Enabled := true;

      btnFeatureView.Enabled := false;
      btnFeatureNew.Enabled := false;
      btnFeatureEdit.Enabled := false;
      btnFeatureDelete.Enabled := false;
    end;
  Feature:
    begin
      btnProjectEdit.Enabled := false;
      btnProjectDelete.Enabled := false;

      btnBugView.Enabled := false;
      btnBugNew.Enabled := false;
      btnBugEdit.Enabled := false;
      btnBugDelete.Enabled := false;

      btnFeatureView.Enabled := true;
      btnFeatureNew.Enabled := true;
      btnFeatureEdit.Enabled := true;
      btnFeatureDelete.Enabled := true;
    end;
  end;
end;

procedure TFormMain.btnBugViewClick(Sender: TObject);
var
    NodedataVP: PMyRecViewPort;
    node: PVirtualNode;
begin
  NodedataVP := ViewPort.GetNodeData(ViewPort.FocusedNode);

  if NodedataVP = nil then Exit;

  //Abfrage der Daten
  ABSQuery.Close;
  ABSQuery.SQL.Text := 'SELECT * FROM "' + NodedataVP.Table +'" WHERE xdKey = ' + IntToStr(NodedataVP.xdKey);
  ABSQuery.Open;

  FormBugNewEdit.ShowView(ABSQuery.FieldByName('ID').AsString, //ID
                          ABSQuery.FieldByName('Priority').AsString, //Priorität
                          ABSQuery.FieldByName('Effect').AsString, //Effekt
                          ABSQuery.FieldByName('Status').AsString, //Status
                          ABSQuery.FieldByName('Summary').AsString, //Zusammenfassung
                          ABSQuery.FieldByName('Description').AsString); //Beschreibung
end;

procedure TFormMain.btnBugEditClick(Sender: TObject);
var
    NodedataVP: PMyRecViewPort;
    node: PVirtualNode;
begin
  NodedataVP := ViewPort.GetNodeData(ViewPort.FocusedNode);

  if NodedataVP = nil then Exit;

  //Abfrage der Daten
  ABSQuery.Close;
  ABSQuery.SQL.Text := 'SELECT * FROM "' + NodedataVP.Table +'" WHERE xdKey = ' + IntToStr(NodedataVP.xdKey);
  ABSQuery.Open;

  FormBugNewEdit.ShowEdit(ABSQuery.FieldByName('ID').AsString, //ID
                          ABSQuery.FieldByName('Priority').AsString, //Priorität
                          ABSQuery.FieldByName('Effect').AsString, //Effekt
                          ABSQuery.FieldByName('Status').AsString, //Status
                          ABSQuery.FieldByName('Summary').AsString, //Zusammenfassung
                          ABSQuery.FieldByName('Description').AsString,//Beschreibung
                          ABSQuery.FieldByName('xdKey').AsInteger); //xdKEy

end;

procedure TFormMain.btnFeatureNewClick(Sender: TObject);
begin
  FormFeatureNewEdit.ShowNew;
end;

procedure TFormMain.btnFeatureViewClick(Sender: TObject);
var
    NodedataVP: PMyRecViewPort;
    node: PVirtualNode;
begin
  NodedataVP := ViewPort.GetNodeData(ViewPort.FocusedNode);

  if NodedataVP = nil then Exit;

  //Abfrage der Daten
  ABSQuery.Close;
  ABSQuery.SQL.Text := 'SELECT * FROM "' + NodedataVP.Table +'" WHERE xdKey = ' + IntToStr(NodedataVP.xdKey);
  ABSQuery.Open;

  FormFeatureNewEdit.ShowView(ABSQuery.FieldByName('ID').AsString, //ID
                          ABSQuery.FieldByName('Priority').AsString, //Priorität
                          ABSQuery.FieldByName('Status').AsString, //Status
                          ABSQuery.FieldByName('Summary').AsString, //Zusammenfassung
                          ABSQuery.FieldByName('Description').AsString); //Beschreibung
end;

procedure TFormMain.btnFeatureEditClick(Sender: TObject);
var
    NodedataVP: PMyRecViewPort;
    node: PVirtualNode;
begin
  NodedataVP := ViewPort.GetNodeData(ViewPort.FocusedNode);

  if NodedataVP = nil then Exit;

  //Abfrage der Daten
  ABSQuery.Close;
  ABSQuery.SQL.Text := 'SELECT * FROM "' + NodedataVP.Table +'" WHERE xdKey = ' + IntToStr(NodedataVP.xdKey);
  ABSQuery.Open;

  FormFeatureNewEdit.ShowEdit(ABSQuery.FieldByName('ID').AsString, //ID
                          ABSQuery.FieldByName('Priority').AsString, //Priorität
                          ABSQuery.FieldByName('Status').AsString, //Status
                          ABSQuery.FieldByName('Summary').AsString, //Zusammenfassung
                          ABSQuery.FieldByName('Description').AsString,//Beschreibung
                          ABSQuery.FieldByName('xdKey').AsInteger); //xdKEy
end;

procedure TFormMain.TreeViewCompareNodes(Sender: TBaseVirtualTree; Node1,
  Node2: PVirtualNode; Column: TColumnIndex; var Result: Integer);
var
  Data1: PMyRecTreeView;
  Data2: PMyRecTreeView;
begin
  Data1:=Treeview.GetNodeData(Node1);
  Data2:=Treeview.GetNodeData(Node2);

  if (not Assigned(Data1)) or (not Assigned(Data2)) then
    Result:=0
  else
  begin
    if (Data1.TypeOfEntry = Project) and (Data2.TypeOfEntry = Project) then Result:=CompareText(Data1.Caption, Data2.Caption);
  end;
end;

end.
