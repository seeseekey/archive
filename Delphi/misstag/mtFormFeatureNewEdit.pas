unit mtFormFeatureNewEdit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, gtcl_TStrings;

type
  TFormFeatureNewEdit = class(TForm)
    Label1: TLabel;
    edPriority: TComboBox;
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
    procedure ShowView(id, priority, status, summary, description: string);
    procedure ShowEdit(id, priority, status, summary, description: string; ixdKey: LongWord);
  end;

type tpFormState = (View, New, Edit);

var
  FormFeatureNewEdit: TFormFeatureNewEdit;
  FormStateX: tpFormState;
  ID: string;
  xdKey: Longword;

implementation

uses mtFormMain;

{$R *.dfm}

procedure TFormFeatureNewEdit.Button1Click(Sender: TObject);
begin
  if FormStateX = New then FormMain.CreateFeature(edSummary.Text, edDescription.Text, edPriority.Text,edState.Text)
  else if FormStateX = Edit then FormMain.EditFeature(xdKey, ID, edSummary.Text, edDescription.Text, edPriority.Text, edState.Text);

  Button2Click(Sender);
end;

procedure TFormFeatureNewEdit.ShowView(id, priority, status, summary, description: string);
begin
  edSummary.Enabled := false;
  edDescription.Readonly := true;
  edPriority.Enabled := false;;
  edState.Enabled :=  false;

  edSummary.Text := summary;
  edDescription.Text := description;
  
  edPriority.ItemIndex := gtTStrings.SearchStringInTStrings(edPriority.Items, priority);
  edState.ItemIndex := gtTStrings.SearchStringInTStrings(edState.Items, status);

  FormStateX := View;

  FormFeatureNewEdit.Caption := 'Feature anzeigen...';

  FormFeatureNewEdit.Show;
end;

procedure TFormFeatureNewEdit.ShowNew;
begin
  edSummary.Enabled := true;
  edDescription.Readonly := false;
  edDescription.Enabled := true;
  edPriority.Enabled := true;
  edState.Enabled :=  true;

  FormStateX := New;

  FormFeatureNewEdit.Caption := 'Neues Feature...';

  FormFeatureNewEdit.Show;
end;

procedure TFormFeatureNewEdit.ShowEdit(id, priority, status, summary, description: string; ixdKey: LongWord);
begin
  edSummary.Enabled := true;
  edDescription.Readonly := false;
  edDescription.Enabled := true;
  edPriority.Enabled := true;
  edState.Enabled :=  true;

  edSummary.Text := summary;
  edDescription.Text := description;

  edPriority.ItemIndex := gtTStrings.SearchStringInTStrings(edPriority.Items, priority);
  edState.ItemIndex := gtTStrings.SearchStringInTStrings(edState.Items, status);

  ID := id;
  xdKey := ixdKey;

  FormStateX := Edit;

  FormFeatureNewEdit.Caption := 'Feature editieren...';

  FormFeatureNewEdit.Show;
end;

procedure TFormFeatureNewEdit.Button2Click(Sender: TObject);
begin
  edSummary.Text := '';
  edDescription.Text := '';

  Close;
end;

end.
