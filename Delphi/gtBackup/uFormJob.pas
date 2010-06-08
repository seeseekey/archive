unit uFormJob;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, gtcl_Dialogs, xmllib, uGlobals, gtcl_FileSystem, gtcl_Misc;

type OpenedTask = (New, Edit, View); 

type
  TFormJob = class(TForm)
    Label1: TLabel;
    edJobname: TEdit;
    lbSourceFolders: TListBox;
    Label2: TLabel;
    btnAddSourceFolder: TButton;
    Label3: TLabel;
    edTargetFolder: TEdit;
    btnBrowsetargetFolder: TButton;
    btnOK: TButton;
    btnCancel: TButton;
    btnRemoveSourceFolder: TButton;
    btnEditSourceFolder: TButton;
    edSourceFolder: TEdit;
    btnBrowseSourceFolder: TButton;
    procedure btnCancelClick(Sender: TObject);
    procedure btnBrowseSourceFolderClick(Sender: TObject);
    procedure btnBrowsetargetFolderClick(Sender: TObject);
    procedure btnAddSourceFolderClick(Sender: TObject);
    procedure btnOKClick(Sender: TObject);
  private
    { Private-Deklarationen }
    myTask: OpenedTask;
  public
    { Public-Deklarationen }
    procedure ShowNewJob;
  end;

var
  FormJob: TFormJob;

implementation

{$R *.dfm}

uses uFormMain;

procedure TFormJob.ShowNewJob;
begin
  //Dummy
  myTask := New;
  FormJob.Caption := 'Neuer Job...';
  ShowModal;
end;

procedure TFormJob.btnCancelClick(Sender: TObject);
begin
  edJobname.Text := '';
  lbSourceFolders.Clear;
  edTargetFolder.Text := '';
  edSourceFolder.Text := '';

  FormJob.Close;
end;

procedure TFormJob.btnBrowseSourceFolderClick(Sender: TObject);
var ret: WideString;
begin
  ret := gtDialogs.GetFolderDialog(CSIDL_DESKTOP, 'Bitte Verzeichnis auswählen...');
  if ret <> '' then edSourceFolder.Text := ret;
end;

procedure TFormJob.btnBrowsetargetFolderClick(Sender: TObject);
var ret: WideString;
begin
  ret := gtDialogs.GetFolderDialog(CSIDL_DESKTOP, 'Bitte Verzeichnis auswählen...');
  if ret <> '' then edTargetFolder.Text := ret;
end;

procedure TFormJob.btnAddSourceFolderClick(Sender: TObject);
begin
  if edSourceFolder.Text = '' then
  begin
    gtDialogs.ShowMessageInfoDialog('Kein Pfad angegeben!');
    Exit;
  end;

  lbSourceFolders.Items.Add(edSourceFolder.Text);
  edSourceFolder.Text := '';
end;

procedure TFormJob.btnOKClick(Sender: TObject);
var Node : TXMLNode;
    JUID: String;
    i: Integer;
begin
  if myTask = New then
  begin
    JUID := gtMisc.GetUniqueID;

    //Name
    fXML.CreatePathAndNode('xml.jobs.JUID' + JUID  + '.name', Node);
    Node.Value.AsString := edJobname.Text;

    //Source Folder
    for i := 0 to lbSourceFolders.Items.Count-1 do
    begin
      fXML.CreatePathAndNode('xml.jobs.JUID' + JUID + '.sources.' + IntToStr(i), Node);
      Node.Value.AsString := lbSourceFolders.Items.Strings[i];
    end;

    //Target
    fXML.CreatePathAndNode('xml.jobs.JUID' + JUID  + '.target', Node);
    Node.Value.AsString := edTargetFolder.Text;

    //Methode
    //ca = copyall
    //cahli = copyall hardlink inkremental
    fXML.CreatePathAndNode('xml.jobs.JUID' + JUID  + '.method', Node);


    Node.Value.AsString := 'm02'; //Hardlink Full Inkremental Copy


    //Zuletzt ausgeführt
    fXML.CreatePathAndNode('xml.jobs.JUID' + JUID  + '.lasttime', Node);
    Node.Value.AsString := 'Nie';

    //log
    fXML.CreatePathAndNode('xml.jobs.JUID' + JUID  + '.log', Node);
    Node.Value.AsString := '';

    fXML.SaveToFile(gtFileSystem.GetApplicationPath + 'gtBackup.xml');
  end;

  FormMain.BuildTree;

  btnCancelClick(Sender);
end;

end.
