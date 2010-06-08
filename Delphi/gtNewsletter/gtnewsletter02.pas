unit gtnewsletter02;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, globals;

type
  Teditrecievers = class(TForm)
    eelist: TListBox;
    delete: TButton;
    edit: TButton;
    new: TButton;
    ok: TButton;
    cancel: TButton;
    procedure FormShow(Sender: TObject);
    procedure newClick(Sender: TObject);
    procedure editClick(Sender: TObject);
    procedure deleteClick(Sender: TObject);
    procedure cancelClick(Sender: TObject);
    procedure okClick(Sender: TObject);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  editrecievers: Teditrecievers;

implementation

{$R *.dfm}

procedure Teditrecievers.FormShow(Sender: TObject);
begin
 eelist.Items.Clear;
 if fileexists(ExtractFilePath(Application.ExeName) + 'konten\'+sectionglobal+'\receivers.gtl') then
 eelist.Items.LoadFromFile(ExtractFilePath(Application.ExeName) + 'konten\'+sectionglobal+'\receivers.gtl');
end;

procedure Teditrecievers.newClick(Sender: TObject);
begin
 if swstatus = true then
 begin
  if eelist.Count > 14 then
  begin
   swswitch := true;
  end
  else swswitch := false;
 end;

  if swswitch = true then
 begin
   MessageDlg('Sie können maximal 15 Empfänger in der Shareware Version anlegen!', mtInformation, [mbOk], 0);
   Exit;
 end;

eelist.Items.Add(InputBox('Neue E-Mail Adresse hinzufügen...', 'Bitte E-Mail Adresse eingeben:', ''));
end;

procedure Teditrecievers.editClick(Sender: TObject);
var addstring: string;
    oldindex: Integer;
begin
if eelist.Count = 0 then
begin
 MessageDlg('Die Liste ist leer!', mtInformation, [mbOk], 0);
 Exit;
end;

if eelist.ItemIndex = -1 then
begin
 MessageDlg('Es ist kein Eintrag markiert!', mtInformation, [mbOk], 0);
 Exit;
end;

oldindex := eelist.itemindex;

addstring := InputBox('E-Mail Adresse bearbeiten...', 'Bitte E-Mail Adresse eingeben:', eelist.Items.Strings[eelist.itemindex]);
eelist.Items.Delete(eelist.itemindex);
eelist.Items.Add(addstring);

eelist.ItemIndex := oldindex;

end;

procedure Teditrecievers.deleteClick(Sender: TObject);
begin
if eelist.Count = 0 then
begin
 MessageDlg('Die Liste ist leer!', mtInformation, [mbOk], 0);
 Exit;
end;

if eelist.ItemIndex = -1 then
begin
 MessageDlg('Es ist kein Eintrag markiert!', mtInformation, [mbOk], 0);
 Exit;
end;

eelist.Items.Delete(eelist.itemindex);
end;

procedure Teditrecievers.cancelClick(Sender: TObject);
begin
editrecievers.Close;
end;

procedure Teditrecievers.okClick(Sender: TObject);
begin
eelist.Items.SavetoFile(ExtractFilePath(Application.ExeName) + 'konten\'+sectionglobal+'\receivers.gtl');
reload2 := true;
editrecievers.Close;
end;

end.
