unit Clxu15;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, clxu3, clxu2;

type
  Txbox = class(TForm)
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
  xbox: Txbox;

implementation

{$R *.DFM}

procedure Txbox.ListBox1DblClick(Sender: TObject);
begin
 augs := 'data\x-box\' + ListBox1.Items[ListBox1.ItemIndex] + '.clx';
 augs := LowerCase(augs);

 slrd := ExtractFilePath(Application.ExeName) + 'data\x-box\' + ListBox1.Items[ListBox1.ItemIndex] + '.clx';
 slrd := LowerCase(slrd);
   Tviewer.Create(Self);

 xbox.close;
end;

procedure Txbox.Edit1Change(Sender: TObject);
begin
   Listbox1.Itemindex := Search(Listbox1.items, edit1.text);
end;


procedure Txbox.FormClose(Sender: TObject; var Action: TCloseAction);
begin
edit1.text := '';
end;

procedure Txbox.FormShow(Sender: TObject);
begin
edit1.SetFocus;
end;

procedure Txbox.Edit1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
if edit1.text <> '' then
begin
 if Key = VK_RETURN then ListBox1DblClick(Sender);
end;
end;

end.
