unit Clxu17;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, clxu3, clxu2;

type
  Tnintendo = class(TForm)
    ListBox1: TListBox;
    Edit1: TEdit;
    procedure ListBox1DblClick(Sender: TObject);
    procedure Edit1Change(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure Edit1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  nintendo: Tnintendo;

implementation

{$R *.DFM}

procedure Tnintendo.ListBox1DblClick(Sender: TObject);
begin
 augs := 'data\nintendo\' + ListBox1.Items[ListBox1.ItemIndex] + '.clx';
 augs := LowerCase(augs);

 slrd := ExtractFilePath(Application.ExeName) + 'data\nintendo\' + ListBox1.Items[ListBox1.ItemIndex] + '.clx';
 slrd := LowerCase(slrd);
 Tviewer.Create(Self);

 nintendo.close;
end;

procedure Tnintendo.Edit1Change(Sender: TObject);
begin
   Listbox1.Itemindex := Search(Listbox1.items, edit1.text);
end;


procedure Tnintendo.FormClose(Sender: TObject; var Action: TCloseAction);
begin
edit1.Text := '';
end;

procedure Tnintendo.FormShow(Sender: TObject);
begin
edit1.SetFocus;
end;

procedure Tnintendo.Edit1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
if edit1.text <> '' then
begin
 if Key = VK_RETURN then ListBox1DblClick(Sender);
end;
end;

end.
