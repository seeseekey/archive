unit mtFormProjectNewEdit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TFormProjectNewEdit = class(TForm)
    edProjectName: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    edLanguage: TEdit;
    Button1: TButton;
    Button2: TButton;
    mmDescription: TMemo;
    procedure Button2Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  FormProjectNewEdit: TFormProjectNewEdit;

implementation

uses mtFormmain;

{$R *.dfm}

procedure TFormProjectNewEdit.Button2Click(Sender: TObject);
begin
  FormMain.CreateProject(edProjectName.text, mmDescription.Text, edLanguage.Text);
  Button1Click(Sender);
end;

procedure TFormProjectNewEdit.Button1Click(Sender: TObject);
begin
  edProjectName.Text := '';
  mmDescription.Text := '';
  edLanguage.Text := '';

  Close;
end;

end.
