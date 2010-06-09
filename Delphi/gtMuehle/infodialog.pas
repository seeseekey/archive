unit infodialog;

interface

uses
 Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
 StdCtrls, ExtCtrls, shellapi;

type
 Taboutform = class(TForm)
  logo : TImage;
  Label1 : TLabel;
  Label2 : TLabel;
  Label3 : TLabel;
  Label4 : TLabel;
  Label5 : TLabel;
  okay : TButton;
  masterlabel : TLabel;
  idlabel : TLabel;
  procedure okayClick(Sender : TObject);
  procedure logoClick(Sender : TObject);
  procedure Label5DblClick(Sender : TObject);
 private
  { Private-Deklarationen }
 public
  { Public-Deklarationen }
 end;

var
 aboutform : Taboutform;
 idclick : integer = 0;

implementation

{$R *.DFM}

procedure Taboutform.okayClick(Sender : TObject);
begin
 aboutform.Close;
end;

procedure Taboutform.logoClick(Sender : TObject);
begin
 inc(idclick);
 if idclick = 30 then
  begin
  masterlabel.visible := true;
  idlabel.Visible := true;
  end;
end;

procedure Taboutform.Label5DblClick(Sender : TObject);
begin
 ShellExecute(0, 'open', 'http://www.global-technology.de', nil, nil, SW_SHOW);
end;

end.
