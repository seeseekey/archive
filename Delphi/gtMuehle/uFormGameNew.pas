unit uFormGameNew;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, muehle, gtmuehle04, gtvcl_ComboBox;

type
  TFormGameNew = class(TForm)
    RadioGroup1: TRadioGroup;
    mode1: TRadioButton;
    mode2: TRadioButton;
    mode4: TRadioButton;
    Label1: TLabel;
    Label2: TLabel;
    GroupBox1: TGroupBox;
    ai1level: TLabel;
    GroupBox2: TGroupBox;
    ai2level: TLabel;
    confirm: TButton;
    cancel: TButton;
    aip2mb: TButton;
    aip1mb: TButton;
    aip1: TGT_ComboValueBox;
    aip2: TGT_ComboValueBox;
    mode3: TRadioButton;
    mode5: TRadioButton;
    procedure cancelClick(Sender: TObject);
    procedure confirmClick(Sender: TObject);
    procedure mode1Click(Sender: TObject);
    procedure mode2Click(Sender: TObject);
    procedure mode4Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormPaint(Sender: TObject);
    procedure aip1mbClick(Sender: TObject);
    procedure aip2mbClick(Sender: TObject);
    procedure mode3Click(Sender: TObject);
    procedure mode5Click(Sender: TObject);
    procedure mode6Click(Sender: TObject);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  FormGameNew: TFormGameNew;

implementation

uses uFormMain, uFormNetworkConnect;

{$R *.DFM}

procedure TFormGameNew.cancelClick(Sender: TObject);
begin
  FormGameNew.close;
end;

procedure TFormGameNew.confirmClick(Sender: TObject);
begin
aidllname1 := aip1.ValueList.Strings[aip1.itemindex];
aidllname2 := aip2.ValueList.Strings[aip2.itemindex];

FormMain.resetgamefield;
if mode1.Checked = true then global_gamestatus.gamemodus := 1
else if mode2.Checked = true then global_gamestatus.gamemodus := 2
else if mode3.Checked = true then global_gamestatus.gamemodus := 3
else if mode4.Checked = true then global_gamestatus.gamemodus := 4
else if mode5.Checked = true then global_gamestatus.gamemodus := 5;

 //netzwerkdialog aufrufen
 if (global_gamestatus.gamemodus = 5) then
 begin
   FormNetworkConnect.ShowModal;
 end;

  FormGameNew.Close;
end;

procedure TFormGameNew.mode1Click(Sender: TObject);
begin
  aip1.Enabled := false;
  aip2.Enabled := false;
  aip1mb.enabled := false;
  aip2mb.enabled := false;
end;

procedure TFormGameNew.mode2Click(Sender: TObject);
begin
  aip1.Enabled := true;
  aip2.Enabled := false;
  aip1mb.enabled := true;
  aip2mb.enabled := false;
end;

procedure TFormGameNew.mode4Click(Sender: TObject);
begin
  aip1.Enabled := true;
  aip2.Enabled := true;
  aip1mb.enabled := true;
  aip2mb.enabled := true;
end;

procedure TFormGameNew.FormCreate(Sender: TObject);
var
 ailist: TStrings;
 i: integer;
begin
  mode1.Checked := true;
  aip1.Enabled := false;
  aip2.Enabled := false;
  aip1mb.enabled := false;
  aip2mb.enabled := false;

 ailist := TStringlist.Create;

// Verfügbare AI's laden
GetFilesInDirectory(ExtractFilePath(Application.ExeName)+'aifiles\',
                    '*.dll', ailist, false);

// Überprüfen ob ai auch ai ist(:
// hier doppelte kombobvox einbauen (2listen)

for i := 0 to ailist.Count-1 do
begin
 aidllname := ailist.Strings[i];
 try
  if SSFGetAIInfo(7) = 'GT Muehle' then
  begin
   aip1.Items.Add(SSFGetAIInfo(1));
   aip1.ValueList.Add(ailist.Strings[i]);
   aip2.Items.Add(SSFGetAIInfo(1));
   aip2.ValueList.Add(ailist.Strings[i]);
   aip1.ItemIndex := 0;
   aip2.ItemIndex := 0;
  end;
 except
 end; //ecept ende
end;


// Freigeben der Resourcen
 ailist.Free;

end;

procedure TFormGameNew.FormPaint(Sender: TObject);
begin


aidllname1 := aip1.ValueList.Strings[aip1.itemindex];
aidllname2 := aip2.ValueList.Strings[aip2.itemindex];

aidllname := aidllname1;
ai1level.Caption := 'Schwierigkeitslevel: ' + String(SSFGetAIInfo(4));

aidllname := aidllname2;
ai2level.Caption := 'Schwierigkeitslevel: ' + String(SSFGetAIInfo(4));
end;

procedure TFormGameNew.aip1mbClick(Sender: TObject);
begin
aidllname1 := aip1.ValueList.Strings[aip1.itemindex];

aidllname := aidllname1;

MessageDlg(String(SSFGetAIInfo(1)) + #10#13 +
           'Version: ' + String(SSFGetAIInfo(2)) + #10#13+
           'Autor: ' + String(SSFGetAIInfo(3)) + #10#13+
           String(SSFGetAIInfo(5)), mtInformation,[mbOk], 0);
end;

procedure TFormGameNew.aip2mbClick(Sender: TObject);
begin
aidllname2 := aip2.ValueList.Strings[aip2.itemindex];

aidllname := aidllname2;

MessageDlg(String(SSFGetAIInfo(1)) + #10#13 +
           'Version: ' + String(SSFGetAIInfo(2)) + #10#13+
           'Autor: ' + String(SSFGetAIInfo(3)) + #10#13+
           String(SSFGetAIInfo(5)), mtInformation,[mbOk], 0);
end;

procedure TFormGameNew.mode3Click(Sender: TObject);
begin
  aip1.Enabled := true;
  aip2.Enabled := false;
  aip1mb.enabled := true;
  aip2mb.enabled := false;
end;

procedure TFormGameNew.mode5Click(Sender: TObject);
begin
  aip1.Enabled := false;
  aip2.Enabled := false;
  aip1mb.enabled := false;
  aip2mb.enabled := false;
end;

procedure TFormGameNew.mode6Click(Sender: TObject);
begin
  aip1.Enabled := false;
  aip2.Enabled := false;
  aip1mb.enabled := false;
  aip2mb.enabled := false;
end;

end.
