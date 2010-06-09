unit uFormSelectDrive;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, uGlobals, gtcl_FileSystem, gtcl_Misc;

type
  TFormSelectDrive = class(TForm)
    DriveBox: TListBox;
    OK: TButton;
    CANCEL: TButton;
    Label1: TLabel;
    EditSerialNumber: TEdit;
    Label2: TLabel;
    EditBezeichnung: TEdit;
    EditBeschreibung: TMemo;
    Label3: TLabel;
    Label4: TLabel;
    EditArchivnummer: TEdit;
    Label5: TLabel;
    cbMediaTyp: TComboBox;
    Label6: TLabel;
    EditInternalMediaTyp: TEdit;
    procedure FormShow(Sender: TObject);
    procedure CANCELClick(Sender: TObject);
    procedure OKClick(Sender: TObject);
    procedure DriveBoxClick(Sender: TObject);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  FormSelectDrive: TFormSelectDrive;
  Drive: Char;

implementation

{$R *.dfm}

uses uFormMain, uFormReadDrive;

procedure TFormSelectDrive.FormShow(Sender: TObject);
begin
 DriveBox.Clear;
 gtFileSystem.GetDrives(DriveBox.Items);
end;

procedure TFormSelectDrive.CANCELClick(Sender: TObject);
begin
 FormSelectDrive.Close;
end;

procedure TFormSelectDrive.OKClick(Sender: TObject);
begin

 //Grunddaten in Datenbank speichern

    //Start Transaction

    uFormMain.FormMain.ABSDataBase.StartTransaction;

    //Insert einfügen
    uFormMain.FormMain.ABSTable.Insert;

    uFormMain.FormMain.ABSTable.FieldByName('UniInternalMediaTyp').AsString := EditInternalMediaTyp.Text;
    uFormMain.FormMain.ABSTable.FieldByName('UniMediaTyp').AsString := cbMediaTyp.Text;
    uFormMain.FormMain.ABSTable.FieldByName('UniIdOfMedia').AsString := EditSerialNumber.Text;
    uFormMain.FormMain.ABSTable.FieldByName('UniBezeichnungOfMedia').AsString := EditBezeichnung.Text;;
    uFormMain.FormMain.ABSTable.FieldByName('UniBeschreibungOfMedia').AsString := EditBeschreibung.Text;;
    uFormMain.FormMain.ABSTable.FieldByName('UniArchivNummer').AsString := EditArchivnummer.Text;
    uFormMain.FormMain.ABSTable.FieldByName('UniDateOfRead').AsDateTime := Now;

    TableName := EditSerialNumber.Text + '|' + gtMisc.GetUniqueID;
    uFormMain.FormMain.ABSTable.FieldByName('UniTableOfMedia').AsString := TableName;

    uFormMain.FormMain.ABSTable.Post;

    uFormMain.FormMain.ABSDataBase.Commit();

 // Grunddaten ENDE

 Laufwerk := Drive;
 CanDriveRead := true;

 FormSelectDrive.Hide;
 FormReadDrive.ShowModal();
 FormSelectDrive.Close;
end;

procedure TFormSelectDrive.DriveBoxClick(Sender: TObject);
var SerienNummer: string;
begin
 Drive := DriveBox.Items.Strings[DriveBox.ItemIndex][1];
 SerienNummer := gtFileSystem.GetSerialNumberOfDrive(Drive);

 If (SerienNummer = 'noMedia') then
 Begin
   MessageDlg('Es ist kein Datenträger eingelegt!', mtInformation, [mbOk], 0);
   Exit;
 End;

 EditSerialNumber.Text := SerienNummer;

 EditInternalMediaTyp.text := gtFileSystem.GetMediaTyp(Drive);
end;

end.
