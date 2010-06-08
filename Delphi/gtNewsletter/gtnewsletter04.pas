unit gtnewsletter04;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls;

type
  Tsendmails = class(TForm)
    fortschritt: TProgressBar;
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  sendmails: Tsendmails;

implementation

{$R *.dfm}

end.
