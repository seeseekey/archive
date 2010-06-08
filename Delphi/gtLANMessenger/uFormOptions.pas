unit uFormOptions;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, globals, bigini, ComCtrls, ExtCtrls, gtcl_FileSystem;

type
  TFormOptions = class(TForm)
    PageControl: TPageControl;
    TabSheet1: TTabSheet;
    name: TEdit;
    Label1: TLabel;
    okay: TButton;
    abbrechen: TButton;
    TabSheet2: TTabSheet;
    cbNormalSizeAndPosition: TCheckBox;
    TabSheet3: TTabSheet;
    rgTkSend: TRadioGroup;
    CheckBox1: TCheckBox;
    procedure abbrechenClick(Sender: TObject);
    procedure okayClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  FormOptions: TFormOptions;

implementation

{$R *.dfm}

uses uFormMain;

procedure TFormOptions.abbrechenClick(Sender: TObject);
begin
 FormOptions.Close;
end;

procedure TFormOptions.okayClick(Sender: TObject);
begin
 //Anwendung
 Ini.WriteBool('formmain', 'normalsize', cbNormalSizeAndPosition.Checked);

 //Nachrichtenfenster
 Ini.WriteInteger('messagewindow', 'keysend', rgTkSend.ItemIndex);

 //Profil
 Ini.WriteString('profil', 'name', name.Text);

 //Save
 Ini.Free;
 Ini := TBiggerIniFile.Create(gtFileSystem.GetApplicationPath + 'options.ini');
 //EndSave

 FormMain.RefreshProfile;

 FormOptions.Close;
end;

procedure TFormOptions.FormShow(Sender: TObject);
begin
 name.Text := Ini.ReadString('profil', 'name', '');
 cbNormalSizeAndPosition.Checked := Ini.ReadBool('formmain', 'normalsize', true);
 rgTkSend.ItemIndex := Ini.ReadInteger('messagewindow', 'keysend', 1);
end;

end.
