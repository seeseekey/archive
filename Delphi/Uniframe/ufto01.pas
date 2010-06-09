unit ufto01;

interface

uses
  Classes, SysUtils, DB, gtcl_Icons, JclFileUtils, uFormReadDrive;

type
  TReadDataOut = class(TThread)
  private
    { Private-Deklarationen }
  protected
    procedure UpdateVCLWindow;
    procedure Execute; override;
    procedure DoSmoething(ADirectory : string; AMask : String; AList : TStrings; ARekursiv : Boolean);
  public
    varReadFiles: Integer;
    varReadFolders: Integer;
    varSizeOfMediaData: Int64;
    varCurrentFolder: string;

    DirectoryList: TStrings;

    gDirectory: string;
  end;

implementation

uses uGlobals, uFormMain;

{ Wichtig: Methoden und Eigenschaften von Objekten in visuellen Komponenten dürfen 
  nur in einer Methode namens Synchronize aufgerufen werden, z.B.

      Synchronize(UpdateCaption);

  und UpdateCaption könnte folgendermaßen aussehen:

    procedure ReadDataOut.UpdateCaption;
    begin
      Form1.Caption := 'Aktualisiert in einem Thread';
    end; }

{ TReadDataOut }

procedure TReadDataOut.UpdateVCLWindow;
begin
 FormReadDrive.UpdateVCLWindow(varReadFiles, varReadFolders, varCurrentFolder);
end;

procedure CreateVTable(tableName: string);
begin
 if uFormMain.FormMain.ABSDataBase.InTransaction = true then uFormMain.FormMain.ABSDataBase.Commit();

 uFormMain.FormMain.uniMediaTable.Active := false;
 uFormMain.FormMain.uniMediaTable.TableName := tableName;
 uFormMain.FormMain.uniMediaTable.FieldDefs.Clear;

 uFormMain.FormMain.uniMediaTable.FieldDefs.Add('xdKey',ftAutoInc,0,False);
 //uf00.FormMain.uniMediaTable.FieldDefs.Add('xctPfad',ftString,1024,False); //Pfad
 uFormMain.FormMain.uniMediaTable.FieldDefs.Add('xctFilename',ftString,512,False); //Datei
 uFormMain.FormMain.uniMediaTable.FieldDefs.Add('xctAttribute',ftInteger,0,False); //Atribute
 uFormMain.FormMain.uniMediaTable.FieldDefs.Add('xctSize',ftInteger,0,False); //Größe
 uFormMain.FormMain.uniMediaTable.FieldDefs.Add('xctTimeStamp',ftDateTime,0,False); //Zeitstempel
 //uf00.FormMain.uniMediaTable.FieldDefs.Add('xctBytes',ftVarBytes,16,False); //Bytes

 uFormMain.FormMain.uniMediaTable.IndexDefs.Clear;
 uFormMain.FormMain.uniMediaTable.IndexDefs.Add('idxPrimary','xdKey',[ixPrimary]);

 uFormMain.FormMain.uniMediaTable.CreateTable;
 
 uFormMain.FormMain.ABSDataBase.StartTransaction;

 uFormMain.FormMain.uniMediaTable.Active := true;
end;

procedure TReadDataOut.DoSmoething(ADirectory : string; AMask : String; AList : TStrings; ARekursiv : Boolean);
var SR : TSearchRec;
begin
  { Thread-Code hier einfügen }
  Synchronize(UpdateVCLWindow);

  if IsDirectory(ADirectory) = true then
  begin
    CreateVTable(TableName + '|' + Copy(ADirectory, 3, Length(ADirectory)-2));
  //if ExtractFileName(ADirectory) = '' then CreateVTable(TableName + '|' + Copy(ADirectory, 3, Length(ADirectory)-2));

    uFormMain.FormMain.ABSTableSek.Insert;
     uFormMain.FormMain.ABSTableSek.FieldByName('xctPfad').AsString := Copy(ADirectory, 3, Length(ADirectory)-2);
     uFormMain.FormMain.ABSTableSek.Post;
  end;
 if (ADirectory <> '') and (ADirectory[length(ADirectory)] <> '\') then
  begin ADirectory := ADirectory + '\' end;


 if (FindFirst(ADirectory + AMask, faAnyFile - faDirectory, SR) = 0) then
  begin
  repeat
   if (SR.Name <> '.') and (SR.Name <> '..') and (SR.Attr <> faDirectory) then
    begin
     AList.Add(ADirectory + SR.Name);
     // Eintrag in die Datenbank
     Inc(varSizeOfMediaData, SR.Size);
     uFormMain.FormMain.uniMediaTable.Insert;
     //uf00.FormMain.uniMediaTable.FieldByName('xctPfad').AsString := Copy(ADirectory, 3, Length(ADirectory)-2);
     uFormMain.FormMain.uniMediaTable.FieldByName('xctFilename').AsString := SR.Name;
     uFormMain.FormMain.uniMediaTable.FieldByName('xctAttribute').AsInteger := SR.Attr;
     uFormMain.FormMain.uniMediaTable.FieldByName('xctSize').AsInteger := SR.Size;
     uFormMain.FormMain.uniMediaTable.FieldByName('xctTimeStamp').AsDateTime := FileDateToDateTime(SR.Time);
     uFormMain.FormMain.uniMediaTable.Post;
     // Eintrag in die Datenbank
     inc(varReadFiles); //Dateienzähler
     varCurrentFolder := SR.Name;
    end
  until FindNext(SR) <> 0;
  FindClose(SR);
  end;

 if ARekursiv then
  begin if (FindFirst(ADirectory + '*.*', faDirectory, SR) = 0) then
   begin
    inc(varReadFolders);
   repeat
    if (SR.Name <> '.') and (SR.Name <> '..') then
     begin
      DoSmoething(ADirectory + SR.Name, AMask, AList, True)
     end;
   until FindNext(SR) <> 0;
   FindClose(SR);
   end end;
end;

procedure TReadDataOut.Execute;
begin
 DirectoryList := TStringList.Create;
 varReadFolders := -1;
 varSizeOfMediaData := 0;

 //Tabelle erstellen
 //uniMediaTable
      //  ABSTableSek

 //CreateVTable(TableName);

  if uFormMain.FormMain.ABSDataBase.InTransaction = true then uFormMain.FormMain.ABSDataBase.Commit();

 uFormMain.FormMain.ABSTableSek.Active := false;
 uFormMain.FormMain.ABSTableSek.TableName := tableName;
 uFormMain.FormMain.ABSTableSek.FieldDefs.Clear;

 uFormMain.FormMain.ABSTableSek.FieldDefs.Add('xdKey',ftAutoInc,0,False);
 uFormMain.FormMain.ABSTableSek.FieldDefs.Add('xctPfad',ftString,1024,False); //Pfad
 //uf00.FormMain.ABSTableSek.FieldDefs.Add('xctFilename',ftString,512,False); //Datei
 //uf00.FormMain.ABSTableSek.FieldDefs.Add('xctAttribute',ftInteger,0,False); //Atribute
 //uf00.FormMain.ABSTableSek.FieldDefs.Add('xctSize',ftInteger,0,False); //Größe
 //uf00.FormMain.ABSTableSek.FieldDefs.Add('xctTimeStamp',ftDateTime,0,False); //Zeitstempel
 //uf00.FormMain.uniMediaTable.FieldDefs.Add('xctBytes',ftVarBytes,16,False); //Bytes

 uFormMain.FormMain.ABSTableSek.IndexDefs.Clear;
 uFormMain.FormMain.ABSTableSek.IndexDefs.Add('idxPrimary','xdKey',[ixPrimary]);

 uFormMain.FormMain.ABSTableSek.CreateTable;

 uFormMain.FormMain.ABSDataBase.StartTransaction;

 uFormMain.FormMain.ABSTableSek.Active := true;

 //uf00.FormMain.uniMediaTable.Active := true;

 //für Insert vorbereiten
 //Start Transaction
 if uFormMain.FormMain.ABSDataBase.InTransaction = false then uFormMain.FormMain.ABSDataBase.StartTransaction;
 //Datenbank ende

 DoSmoething(gDirectory, '*.*', DirectoryList, true);

 //Werte in Liste schreiben
 uFormMain.FormMain.ABSTable.Edit;
 uFormMain.FormMain.ABSTable.FieldByName('UniFolderCount').AsInteger := varReadFolders;
 uFormMain.FormMain.ABSTable.FieldByName('UniFileCount').AsInteger := varReadFiles;
 uFormMain.FormMain.ABSTable.FieldByName('UniSizeInBytes').AsInteger := varSizeOfMediaData;
 uFormMain.FormMain.ABSTable.Post;
 //End

 // Datenbank Commit
 if uFormMain.FormMain.ABSDataBase.InTransaction = true then uFormMain.FormMain.ABSDataBase.Commit();
 // Datenbank ende

 uFormReadDrive.FormReadDrive.Close;
 uFormMain.FormMain.BuildUniTree;

 DirectoryList.Free;
end;

end.
