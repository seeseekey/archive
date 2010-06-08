// Methoden
// m01 - Veränderung gegeben über erstem Backup
// m02 - Inkrementel

unit uFormMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus, StdCtrls, gtcl_FileSystem, VirtualTrees, ExtCtrls,
  ComCtrls, xmllib, uFormJob, uGlobals, gtcl_Dialogs, uFormBackup;

type
  PMyRecViewport = ^TMyRecViewport;
  TMyRecViewport = record
    Name: WideString;
    Sources: WideString;
    Target: WideString;
    LastTime: WideString;
    JUID: WideString;
  end;

type
  TFormMain = class(TForm)
    MainMenu: TMainMenu;
    Datei1: TMenuItem;
    Beenden1: TMenuItem;
    Optionen1: TMenuItem;
    N1: TMenuItem;
    N2: TMenuItem;
    Hilfe1: TMenuItem;
    Inhalt1: TMenuItem;
    ber1: TMenuItem;
    N3: TMenuItem;
    Panel1: TPanel;
    Viewport: TVirtualStringTree;
    btnStartBackup: TButton;
    StatusBar1: TStatusBar;
    NeueAufgabe1: TMenuItem;
    Aufgabendern1: TMenuItem;
    Aufgabelschen1: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure Beenden1Click(Sender: TObject);
    procedure BuildTree;
    procedure NeueAufgabe1Click(Sender: TObject);
    procedure ViewportGetText(Sender: TBaseVirtualTree; Node: PVirtualNode;
      Column: TColumnIndex; TextType: TVSTTextType;
      var CellText: WideString);
    procedure btnStartBackupClick(Sender: TObject);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  FormMain: TFormMain;
  SelectedJUID: WideString;

implementation

{$R *.dfm}

procedure TFormMain.FormCreate(Sender: TObject);
begin
  Viewport.Header.Columns[0].Width := 200;
  Viewport.Header.Columns[1].Width := 200;
  Viewport.Header.Columns[2].Width := 200;
  Viewport.Header.Columns[3].Width := Viewport.Width - 604;

  fXML.LoadFromFile(gtFileSystem.GetApplicationPath + 'gtBackup.xml');

  FormMain.DoubleBuffered := true;

  Viewport.NodeDataSize := SizeOf(TMyRecViewport);

  BuildTree;
end;

procedure TFormMain.Beenden1Click(Sender: TObject);
begin
  FormMain.Close;
end;

procedure TFormMain.NeueAufgabe1Click(Sender: TObject);
begin
  FormJob.ShowNewJob;
end;

procedure TFormMain.BuildTree;
var i, j: Integer;
    Node : TXMLNode;
    Node2 : TXMLNode;
    JobList: TXMLNodeList;
    JobList2: TXMLNodeList;
    Nodedata: PMyRecViewport;
    treenode: PVirtualNode;
begin
  Viewport.Clear;

  Node := fXML.GetNodeFromPath('xml.jobs');
  if Node = nil then Exit;

  JobList := TXMLNodeList.Create;
  Node.GetChilds(JobList, '*');

  for i := 0 to JobList.Count-1 do
  begin
    //Node hinzufügen
    treenode := Viewport.AddChild(nil); //Globaler Node
    Nodedata := ViewPort.GetNodeData(treenode);

    //Name
    Node2 := fXML.GetNodeFromPath('xml.jobs.' +JobList[i].Name + '.name');
    Nodedata.Name := Node2.Value.AsString;

    //Sources
    Node2 := fXML.GetNodeFromPath('xml.jobs.' +JobList[i].Name + '.sources');
    JobList2 := TXMLNodeList.Create;
    Node2.GetChilds(JobList2, '*');

    for j := 0 to JobList2.Count-1 do
    begin
      Node2 := fXML.GetNodeFromPath('xml.jobs.' +JobList[i].Name + '.sources.' + JobList2[j].Name);
      if Nodedata.Sources = '' then Nodedata.Sources := Node2.Value.AsString
      else Nodedata.Sources := Nodedata.Sources + ';' + Node2.Value.AsString;
    end;

    //target
    Node2 := fXML.GetNodeFromPath('xml.jobs.' +JobList[i].Name + '.target');
    Nodedata.Target := Node2.Value.AsString;

    //lasttime
    Node2 := fXML.GetNodeFromPath('xml.jobs.' +JobList[i].Name + '.lasttime');
    Nodedata.LastTime := Node2.Value.AsString;

    //JUID
    Nodedata.JUID :=  JobList[i].Name;

  end;
end;

procedure TFormMain.ViewportGetText(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType;
  var CellText: WideString);
var NodeData: PMyRecViewport;
begin
 NodeData := Sender.GetNodeData(Node);

 if NodeData = nil then Exit;

 case Column of
  0: CellText := NodeData.Name;
  1: CellText := NodeData.Sources;
  2: CellText := NodeData.Target;
  3: CellText := NodeData.LastTime;
 end;
end;

procedure TFormMain.btnStartBackupClick(Sender: TObject);
  var Nodedata: PMyRecViewPort;
      JUIDList: TStringList;
begin
  //Dummy
  NodeData := ViewPort.GetNodeData(ViewPort.FocusedNode);
  if NodeData = nil then
  begin
    gtDialogs.ShowMessageInfoDialog('Kein Job ausgewählt!');
    Exit;
  end;

  JUIDList := TStringList.Create;
  JUIDList.Add(NodeData.JUID);

  FormBackup.ShowBackupWindow(JUIDList);
end;

end.
