unit mtFormBugNewEdit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, gtcl_TStrings;

type
  TFormBugNewEdit = class(TForm)
    Label1: TLabel;
    edPriority: TComboBox;
    Label2: TLabel;
    edEffect: TComboBox;
    Label3: TLabel;
    edState: TComboBox;
    Label4: TLabel;
    edSummary: TEdit;
    Label5: TLabel;
    edDescription: TMemo;
    Button1: TButton;
    Button2: TButton;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
    procedure ShowNew;
    procedure ShowView(id, priority, effect, status, summary, description: string);
    procedure ShowEdit(id, priority, effect, status, summary, description: string; ixdKey: LongWord);
  end;

type tpFormState = (View, New, Edit);

var
  FormBugNewEdit: TFormBugNewEdit;
  FormStateX: tpFormState;
  ID: string;
  xdKey: Longword;

implementation

uses mtFormMain;

{$R *.dfm}

procedure TFormBugNewEdit.Button1Click(Sender: TObject);
begin
  if FormStateX = New then FormMain.CreateBug(edSummary.Text, edDescription.Text, edPriority.Text, edEffect.Text, edState.Text)
  else if FormStateX = Edit then FormMain.EditBug(xdKey, ID, edSummary.Text, edDescription.Text, edPriority.Text, edEffect.Text, edState.Text);

  Button2Click(Sender);
end;

procedure TFormBugNewEdit.ShowView(id, priority, effect, status, summary, description: string);
begin
  edSummary.Enabled := false;
  edDescription.Readonly := true;
  edPriority.Enabled := false;
  edEffect.Enabled := false;
  edState.Enabled :=  false;

  edSummary.Text := summary;
  edDescription.Text := description;
  
  edPriority.ItemIndex := gtTStrings.SearchStringInTStrings(edPriority.Items, priority);
  edEffect.ItemIndex := gtTStrings.SearchStringInTStrings(edEffect.Items, effect);
  edState.ItemIndex := gtTStrings.SearchStringInTStrings(edState.Items, status);

  FormStateX := View;

  FormBugNewEdit.Caption := 'Bug anzeigen...';

  FormBugNewEdit.Show;
end;

procedure TFormBugNewEdit.ShowNew;
begin
  edSummary.Enabled := true;
  edDescription.Readonly := false;
  edDescription.Enabled := true;
  edPriority.Enabled := true;
  edEffect.Enabled := true;
  edState.Enabled :=  true;

  FormStateX := New;

  FormBugNewEdit.Caption := 'Neuer Bug...';

  FormBugNewEdit.Show;
end;

procedure TFormBugNewEdit.ShowEdit(id, priority, effect, status, summary, description: string; ixdKey: LongWord);
begin
  edSummary.Enabled := true;
  edDescription.Readonly := false;
  edDescription.Enabled := true;
  edPriority.Enabled := true;
  edEffect.Enabled := true;
  edState.Enabled :=  true;

  edSummary.Text := summary;
  edDescription.Text := description;

  edPriority.ItemIndex := gtTStrings.SearchStringInTStrings(edPriority.Items, priority);
  edEffect.ItemIndex := gtTStrings.SearchStringInTStrings(edEffect.Items, effect);
  edState.ItemIndex := gtTStrings.SearchStringInTStrings(edState.Items, status);

  ID := id;
  xdKey := ixdKey;

  FormStateX := Edit;

  FormBugNewEdit.Caption := 'Bug editieren...';

  FormBugNewEdit.Show;
end;

procedure TFormBugNewEdit.Button2Click(Sender: TObject);
begin
  edSummary.Text := '';
  edDescription.Text := '';

  Close;
end;

end.
