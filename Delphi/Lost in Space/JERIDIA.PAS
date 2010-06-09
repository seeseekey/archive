unit Jeridia;

interface

uses WinTypes, WinProcs, Classes, Graphics, Forms, Controls, StdCtrls, Tabs,
  Buttons, Lissgv, ExtCtrls,  SysUtils, Messages,  Dialogs;

type
  TMultPageDlg = class(TForm)
    ButtonPanel: TPanel;
    TabSet: TTabSet;
    Notebook: TNotebook;
    OKBtn: TBitBtn;
    CancelBtn: TBitBtn;
    HelpBtn: TBitBtn;
    GroupBox3: TGroupBox;
    GroupBox4: TGroupBox;
    GroupBox5: TGroupBox;
    GroupBox6: TGroupBox;
    GroupBox7: TGroupBox;
    GroupBox8: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label4: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    Label19: TLabel;
    Label20: TLabel;
    Label21: TLabel;
    Label22: TLabel;
    Label23: TLabel;
    Label24: TLabel;
    Label25: TLabel;
    Label26: TLabel;
    Label27: TLabel;
    Label28: TLabel;
    Label29: TLabel;
    Label30: TLabel;
    Label31: TLabel;
    Label32: TLabel;
    Label33: TLabel;
    Label34: TLabel;
    Label35: TLabel;
    Label36: TLabel;
    GroupBox1: TGroupBox;
    Label37: TLabel;
    Label38: TLabel;
    Label39: TLabel;
    Label40: TLabel;
    Label41: TLabel;
    Label42: TLabel;
    Label43: TLabel;
    Label44: TLabel;
    Label45: TLabel;
    Label46: TLabel;
    Label47: TLabel;
    Label48: TLabel;
    Label49: TLabel;
    Label50: TLabel;
    Label51: TLabel;
    Label52: TLabel;
    Label53: TLabel;
    Label54: TLabel;
    Label55: TLabel;
    Label56: TLabel;
    Label57: TLabel;
    Label58: TLabel;
    Label59: TLabel;
    Label60: TLabel;
    Label61: TLabel;
    Label62: TLabel;
    Label63: TLabel;
    Label64: TLabel;
    Label65: TLabel;
    Label66: TLabel;
    Label67: TLabel;
    Label68: TLabel;
    Label69: TLabel;
    label70: TLabel;
    Label71: TLabel;
    Label72: TLabel;
    Label73: TLabel;
    Label74: TLabel;
    Label75: TLabel;
    Label76: TLabel;
    Label77: TLabel;
    Label78: TLabel;
    Label79: TLabel;
    Label80: TLabel;
    Label81: TLabel;
    Label82: TLabel;
    Edit1: TEdit;
    Button1: TButton;
    Label83: TLabel;
    Edit2: TEdit;
    Button2: TButton;
    Edit3: TEdit;
    Button3: TButton;
    Edit4: TEdit;
    Button4: TButton;
    Edit5: TEdit;
    Button5: TButton;
    Edit6: TEdit;
    Button6: TButton;
    Edit7: TEdit;
    Button7: TButton;
    Edit8: TEdit;
    Button8: TButton;
    Edit9: TEdit;
    Button9: TButton;
    Edit10: TEdit;
    Button10: TButton;
    Edit11: TEdit;
    Button11: TButton;
    Edit12: TEdit;
    Button12: TButton;
    Edit13: TEdit;
    Button13: TButton;
    GroupBox2: TGroupBox;
    Label84: TLabel;
    Label85: TLabel;
    Label86: TLabel;
    Label87: TLabel;
    Label88: TLabel;
    Label89: TLabel;
    Label90: TLabel;
    Label91: TLabel;
    Label92: TLabel;
    Label93: TLabel;
    Label94: TLabel;
    Label95: TLabel;
    Label96: TLabel;
    Label97: TLabel;
    Label98: TLabel;
    Label99: TLabel;
    Label100: TLabel;
    Label101: TLabel;
    Label102: TLabel;
    Label103: TLabel;
    Label104: TLabel;
    Label105: TLabel;
    Label106: TLabel;
    Label107: TLabel;
    Label108: TLabel;
    Label109: TLabel;
    Label110: TLabel;
    Label111: TLabel;
    Label112: TLabel;
    Label113: TLabel;
    Label114: TLabel;
    Label115: TLabel;
    Label116: TLabel;
    Label117: TLabel;
    Label118: TLabel;
    Label119: TLabel;
    Label120: TLabel;
    Label121: TLabel;
    Label122: TLabel;
    Label123: TLabel;
    Label124: TLabel;
    Label125: TLabel;
    Label126: TLabel;
    Label127: TLabel;
    Label128: TLabel;
    Label129: TLabel;
    Label130: TLabel;
    Edit14: TEdit;
    Button14: TButton;
    Edit15: TEdit;
    Button15: TButton;
    Edit16: TEdit;
    Button16: TButton;
    Edit17: TEdit;
    Button17: TButton;
    Edit18: TEdit;
    Button18: TButton;
    Edit19: TEdit;
    Button19: TButton;
    Edit20: TEdit;
    Button20: TButton;
    Edit21: TEdit;
    Button21: TButton;
    Edit22: TEdit;
    Button22: TButton;
    Edit23: TEdit;
    Button23: TButton;
    Edit24: TEdit;
    Button24: TButton;
    Edit25: TEdit;
    Button25: TButton;
    Edit26: TEdit;
    Button26: TButton;
    Label131: TLabel;
    Label132: TLabel;
    Label133: TLabel;
    Label134: TLabel;
    Label135: TLabel;
    Label136: TLabel;
    Label137: TLabel;
    Label138: TLabel;
    Label139: TLabel;
    Label140: TLabel;
    Label141: TLabel;
    Label142: TLabel;
    Label143: TLabel;
    Label144: TLabel;
    Label145: TLabel;
    Label146: TLabel;
    Label147: TLabel;
    Label148: TLabel;
    Label149: TLabel;
    Label150: TLabel;
    Button27: TButton;
    Button28: TButton;
    Button29: TButton;
    Button30: TButton;
    Edit27: TEdit;
    Button31: TButton;
    Edit28: TEdit;
    Edit29: TEdit;
    Edit30: TEdit;
    Edit31: TEdit;
    Button32: TButton;
    Button33: TButton;
    Button34: TButton;
    Button35: TButton;
    Label151: TLabel;
    Label152: TLabel;
    Button36: TButton;
    Label153: TLabel;
    Label154: TLabel;
    Label155: TLabel;
    Label156: TLabel;
    Label157: TLabel;
    Label158: TLabel;
    Label159: TLabel;
    Label160: TLabel;
    Label161: TLabel;
    Label162: TLabel;
    Label163: TLabel;
    Label164: TLabel;
    Label165: TLabel;
    Label166: TLabel;
    Label167: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure TabSetClick(Sender: TObject);
    procedure CancelBtnClick(Sender: TObject);
    procedure OKBtnClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure Button7Click(Sender: TObject);
    procedure Button8Click(Sender: TObject);
    procedure Button9Click(Sender: TObject);
    procedure Button10Click(Sender: TObject);
    procedure Button11Click(Sender: TObject);
    procedure Button12Click(Sender: TObject);
    procedure Button13Click(Sender: TObject);
    procedure Button14Click(Sender: TObject);
    procedure Button15Click(Sender: TObject);
    procedure Button16Click(Sender: TObject);
    procedure Button17Click(Sender: TObject);
    procedure Button18Click(Sender: TObject);
    procedure Button19Click(Sender: TObject);
    procedure Button20Click(Sender: TObject);
    procedure Button21Click(Sender: TObject);
    procedure Button22Click(Sender: TObject);
    procedure Button23Click(Sender: TObject);
    procedure Button24Click(Sender: TObject);
    procedure Button25Click(Sender: TObject);
    procedure Button26Click(Sender: TObject);
    procedure Button27Click(Sender: TObject);
    procedure Button28Click(Sender: TObject);
    procedure Button29Click(Sender: TObject);
    procedure Button30Click(Sender: TObject);
    procedure Button36Click(Sender: TObject);
    procedure Button31Click(Sender: TObject);
    procedure Button32Click(Sender: TObject);
    procedure Button33Click(Sender: TObject);
    procedure Button34Click(Sender: TObject);
    procedure Button35Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  MultPageDlg: TMultPageDlg;

  implementation

{$R *.DFM}

procedure TMultPageDlg.FormCreate(Sender: TObject);
begin
  { make the number of Tabs = number of Pages,
    and have the same names }
  TabSet.Tabs := Notebook.Pages;
end;

procedure TMultPageDlg.TabSetClick(Sender: TObject);
begin
  { set visible Page to which Tab was clicked }
  Notebook.PageIndex := TabSet.TabIndex;
end;

procedure TMultPageDlg.CancelBtnClick(Sender: TObject);
begin
close;
end;

procedure TMultPageDlg.OKBtnClick(Sender: TObject);
begin
close;
end;

procedure TMultPageDlg.FormShow(Sender: TObject);
begin
  label167.caption := inttostr(fusionszellen);
  label166.caption := inttostr(neutronenemiterbombe);
  label165.caption := inttostr(multiphasentorpedos);
  label164.caption := inttostr(photonentorpedos);
  label163.caption := inttostr(raumbomben);
  label155.caption := inttostr(mschild) + ' von ' + inttostr(maxschild);
  label153.caption := inttostr(credits);
  label101.caption := inttostr(laderaum) + ' t, davon sind ' +
                     inttostr(mladeraum) + ' t belegt';
  label54.caption := inttostr(laderaum) + ' t, davon sind ' +
                     inttostr(mladeraum) + ' t belegt';
  label7.caption := inttostr(credits);
  label23.caption := inttostr(laderaum) + ' t, davon sind ' +
                     inttostr(mladeraum) + ' t belegt';
  label24.caption := inttostr(chemikalien) + ' t';
  label25.caption := inttostr(computer) + ' t';
  label26.caption := inttostr(energiezellen) + ' t';
  label27.caption := inttostr(kunststoffe) + ' t';
  label28.caption := inttostr(luxusgueter) + ' t';
  label29.caption := inttostr(metalle) + ' t';
  label30.caption := inttostr(nahrungsmittel) + ' t';
  label31.caption := inttostr(papier) + ' t';
  label32.caption := inttostr(rauschgifte) + ' t';
  label33.caption := inttostr(sklaven) + ' t';
  label34.caption := inttostr(sprengstoff) + ' t';
  label35.caption := inttostr(waffen) + ' t';
  label36.caption := inttostr(wasser) + ' t';
  label38.caption := inttostr(credits);
  label85.caption := inttostr(credits);

  chemikalienmenge := chemikalienmenge+random(25);
  label55.caption := inttostr(chemikalienmenge) + ' t';
  label102.caption := inttostr(chemikalienmenge) + ' t';
  chemikalienpreis := chemikalienpreis-random(50);
  label70.caption := inttostr(chemikalienpreis) + ' Credits';
  label117.caption := inttostr(chemikalienpreis) + ' Credits';

  computermenge := computermenge+random(30);
  label56.caption := inttostr(computermenge) + ' t';
  label103.caption := inttostr(computermenge) + ' t';
  computerpreis := computerpreis-random(100);
  label71.caption := inttostr(computerpreis) + ' Credits';
  label118.caption := inttostr(computerpreis) + ' Credits';

  energiezellenmenge := energiezellenmenge+random(30);
  label57.caption := inttostr(energiezellenmenge) + ' t';
  label104.caption := inttostr(energiezellenmenge) + ' t';
  energiezellenpreis := energiezellenpreis-random(100);
  label72.caption := inttostr(energiezellenpreis) + ' Credits';
  label119.caption := inttostr(energiezellenpreis) + ' Credits';

  kunststoffemenge :=  kunststoffemenge+random(30);
  label58.caption := inttostr(kunststoffemenge) + ' t';
  label105.caption := inttostr(kunststoffemenge) + ' t';
  kunststoffepreis := kunststoffepreis-random(70);
  label73.caption := inttostr(kunststoffepreis) + ' Credits';
  label120.caption := inttostr(kunststoffepreis) + ' Credits';

  luxusguetermenge := luxusguetermenge+random(30);
  label59.caption := inttostr(luxusguetermenge) + ' t';
  label106.caption := inttostr(luxusguetermenge) + ' t';
  luxusgueterpreis := luxusgueterpreis-random(60);
  label74.caption := inttostr(luxusgueterpreis) + ' Credits';
  label121.caption := inttostr(luxusgueterpreis) + ' Credits';

  metallemenge := metallemenge+random(30);
  label60.caption := inttostr(metallemenge) + ' t';
  label107.caption := inttostr(metallemenge) + ' t';
  metallepreis := metallepreis-random(50);
  label75.caption := inttostr(metallepreis) + ' Credits';
  label122.caption := inttostr(metallepreis) + ' Credits';

  nahrungsmittelmenge := nahrungsmittelmenge-random(30);
  label61.caption := inttostr(nahrungsmittelmenge) + ' t';
  label108.caption := inttostr(nahrungsmittelmenge) + ' t';
  nahrungsmittelpreis :=  nahrungsmittelpreis+random(50);
  label76.caption := inttostr(nahrungsmittelpreis) + ' Credits';
  label123.caption := inttostr(nahrungsmittelpreis) + ' Credits';

  papiermenge := papiermenge+random(30);
  label62.caption := inttostr(papiermenge) + ' t';
  label109.caption := inttostr(papiermenge) + ' t';
  papierpreis := papierpreis-random(50);
  label77.caption := inttostr(papierpreis) + ' Credits';
  label124.caption := inttostr(papierpreis) + ' Credits';

  rauschgiftemenge := rauschgiftemenge-random(30);
  label63.caption := inttostr(rauschgiftemenge) + ' t';
  label110.caption := inttostr(rauschgiftemenge) + ' t';
  rauschgiftepreis := rauschgiftepreis+random(50);
  label78.caption := inttostr(rauschgiftepreis) + ' Credits';
  label125.caption := inttostr(rauschgiftepreis) + ' Credits';

  sklavenmenge := sklavenmenge-random(30);
  label64.caption := inttostr(sklavenmenge) + ' t';
  label111.caption := inttostr(sklavenmenge) + ' t';
  sklavenpreis := sklavenpreis+random(50);
  label79.caption := inttostr(sklavenpreis) + ' Credits';
  label126.caption := inttostr(sklavenpreis) + ' Credits';

  sprengstoffmenge := sprengstoffmenge+random(30);
  label65.caption := inttostr(sprengstoffmenge) + ' t';
  label112.caption := inttostr(sprengstoffmenge) + ' t';
  sprengstoffpreis := sprengstoffpreis-random(50);
  label80.caption := inttostr(sprengstoffpreis) + ' Credits';
  label127.caption := inttostr(sprengstoffpreis) + ' Credits';

  waffenmenge := waffenmenge+random(30);
  label66.caption := inttostr(waffenmenge) + ' t';
  label113.caption := inttostr(waffenmenge) + ' t';
  waffenpreis := waffenpreis-random(50);
  label81.caption := inttostr(waffenpreis) + ' Credits';
  label128.caption := inttostr(waffenpreis) + ' Credits';

  wassermenge := wassermenge-random(40);
  label67.caption := inttostr(wassermenge) + ' t';
  label114.caption := inttostr(wassermenge) + ' t';
  wasserpreis := wasserpreis+random(50);
  label82.caption := inttostr(wasserpreis) + ' Credits';
  label129.caption := inttostr(wasserpreis) + ' Credits';
end;

procedure TMultPageDlg.Button1Click(Sender: TObject);
begin
 if strtoint(edit1.text)*chemikalienpreis > credits then
  begin
   MessageDlg('Sie besitzen nicht genug Credits um diesen Kauf zu tätigen!',
   mtInformation, [mbOk], 0);
  end
 else
  begin
   if strtoint(edit1.text) > chemikalienmenge then
    begin
     Messagedlg('Sie können nicht mehr Chemikalien kaufen als vorhanden sind!',
     mtInformation, [mbOk], 0);
    end
   else
    begin
     if mladeraum+strtoint(edit1.text) > laderaum then
      begin
       Messagedlg('Sie besitzen nicht genug Laderaum im Schiff!',
       mtInformation, [mbOK],0);
      end
     else
      begin
       credits := credits-strtoint(edit1.text)*chemikalienpreis;
       chemikalienmenge := chemikalienmenge-strtoint(edit1.text);
       label55.caption := inttostr(chemikalienmenge) + ' t';
       chemikalien := chemikalien+strtoint(edit1.text);
       mladeraum := mladeraum+strtoint(edit1.text);
       label24.caption := inttostr(chemikalien) + ' t';
       label23.caption := inttostr(laderaum) + ' t, davon sind ' +
                          inttostr(mladeraum) + ' t belegt';
       label7.caption := inttostr(credits);
       label38.caption := inttostr(Credits);
       label54.caption := inttostr(laderaum) + ' t, davon sind ' +
                          inttostr(mladeraum) + ' t belegt';
       label85.caption := inttostr(credits);
       label101.caption := inttostr(laderaum) + ' t, davon sind ' +
                           inttostr(mladeraum) + ' t belegt';
       label102.caption := inttostr(chemikalienmenge) + ' t';
       label153.caption := inttostr(credits);
      end
    end
  end
end;

procedure TMultPageDlg.Button2Click(Sender: TObject);
begin
 if strtoint(edit2.text)*computerpreis > credits then
  begin
   MessageDlg('Sie besitzen nicht genug Credits um diesen Kauf zu tätigen!',
   mtInformation, [mbOk], 0);
  end
 else
  begin
   if strtoint(edit2.text) > computermenge then
    begin
     Messagedlg('Sie können nicht mehr Computer kaufen als vorhanden sind!',
     mtInformation, [mbOk], 0);
    end
   else
    begin
     if mladeraum+strtoint(edit2.text) > laderaum then
      begin
       Messagedlg('Sie besitzen nicht genug Laderaum im Schiff!',
       mtInformation, [mbOK],0);
      end
     else
      begin
       credits := credits-strtoint(edit2.text)*computerpreis;
       computermenge := computermenge-strtoint(edit2.text);
       label56.caption := inttostr(computermenge) + ' t';
       computer := computer+strtoint(edit2.text);
       mladeraum := mladeraum+strtoint(edit2.text);
       label25.caption := inttostr(computer) + ' t';
       label23.caption := inttostr(laderaum) + ' t, davon sind ' +
                          inttostr(mladeraum) + ' t belegt';
       label7.caption := inttostr(credits);
       label38.caption := inttostr(Credits);
       label54.caption := inttostr(laderaum) + ' t, davon sind ' +
                          inttostr(mladeraum) + ' t belegt';
       label85.caption := inttostr(credits);
       label101.caption := inttostr(laderaum) + ' t, davon sind ' +
                           inttostr(mladeraum) + ' t belegt';
       label103.caption := inttostr(computermenge) + ' t';
       label153.caption := inttostr(credits);
      end
    end
  end
end;

procedure TMultPageDlg.Button3Click(Sender: TObject);
begin
 if strtoint(edit3.text)*energiezellenpreis > credits then
  begin
   MessageDlg('Sie besitzen nicht genug Credits um diesen Kauf zu tätigen!',
   mtInformation, [mbOk], 0);
  end
 else
  begin
   if strtoint(edit3.text) > energiezellenmenge then
    begin
     Messagedlg('Sie können nicht mehr Energiezellen kaufen als vorhanden sind!',
     mtInformation, [mbOk], 0);
    end
   else
    begin
     if mladeraum+strtoint(edit3.text) > laderaum then
      begin
       Messagedlg('Sie besitzen nicht genug Laderaum im Schiff!',
       mtInformation, [mbOK],0);
      end
     else
      begin
       credits := credits-strtoint(edit3.text)*energiezellenpreis;
       energiezellenmenge := energiezellenmenge-strtoint(edit3.text);
       label57.caption := inttostr(energiezellenmenge) + ' t';
       energiezellen := energiezellen+strtoint(edit3.text);
       mladeraum := mladeraum+strtoint(edit3.text);
       label26.caption := inttostr(energiezellen) + ' t';
       label23.caption := inttostr(laderaum) + ' t, davon sind ' +
                          inttostr(mladeraum) + ' t belegt';
       label7.caption := inttostr(credits);
       label38.caption := inttostr(Credits);
       label54.caption := inttostr(laderaum) + ' t, davon sind ' +
                          inttostr(mladeraum) + ' t belegt';
       label85.caption := inttostr(credits);
       label101.caption := inttostr(laderaum) + ' t, davon sind ' +
                           inttostr(mladeraum) + ' t belegt';
       label104.caption := inttostr(energiezellenmenge) + ' t';
       label153.caption := inttostr(credits);
      end
    end
  end
end;

procedure TMultPageDlg.Button4Click(Sender: TObject);
begin
  if strtoint(edit4.text)*kunststoffepreis > credits then
  begin
   MessageDlg('Sie besitzen nicht genug Credits um diesen Kauf zu tätigen!',
   mtInformation, [mbOk], 0);
  end
 else
  begin
   if strtoint(edit4.text) > kunststoffemenge then
    begin
     Messagedlg('Sie können nicht mehr Kunststoffe kaufen als vorhanden sind!',
     mtInformation, [mbOk], 0);
    end
   else
    begin
     if mladeraum+strtoint(edit4.text) > laderaum then
      begin
       Messagedlg('Sie besitzen nicht genug Laderaum im Schiff!',
       mtInformation, [mbOK],0);
      end
     else
      begin
       credits := credits-strtoint(edit4.text)*kunststoffepreis;
       kunststoffemenge := kunststoffemenge-strtoint(edit4.text);
       label58.caption := inttostr(kunststoffemenge) + ' t';
       kunststoffe := kunststoffe+strtoint(edit4.text);
       mladeraum := mladeraum+strtoint(edit4.text);
       label27.caption := inttostr(kunststoffe) + ' t';
       label23.caption := inttostr(laderaum) + ' t, davon sind ' +
                          inttostr(mladeraum) + ' t belegt';
       label7.caption := inttostr(credits);
       label38.caption := inttostr(Credits);
       label54.caption := inttostr(laderaum) + ' t, davon sind ' +
                          inttostr(mladeraum) + ' t belegt';
       label85.caption := inttostr(credits);
       label101.caption := inttostr(laderaum) + ' t, davon sind ' +
                           inttostr(mladeraum) + ' t belegt';
       label105.caption := inttostr(kunststoffemenge) + ' t';
       label153.caption := inttostr(credits);
      end
    end
  end
end;
procedure TMultPageDlg.Button5Click(Sender: TObject);
begin
  if strtoint(edit5.text)*luxusgueterpreis > credits then
  begin
   MessageDlg('Sie besitzen nicht genug Credits um diesen Kauf zu tätigen!',
   mtInformation, [mbOk], 0);
  end
 else
  begin
   if strtoint(edit5.text) > luxusguetermenge then
    begin
     Messagedlg('Sie können nicht mehr Luxusgüter kaufen als vorhanden sind!',
     mtInformation, [mbOk], 0);
    end
   else
    begin
     if mladeraum+strtoint(edit5.text) > laderaum then
      begin
       Messagedlg('Sie besitzen nicht genug Laderaum im Schiff!',
       mtInformation, [mbOK],0);
      end
     else
      begin
       credits := credits-strtoint(edit5.text)*luxusgueterpreis;
       luxusguetermenge := luxusguetermenge-strtoint(edit5.text);
       label59.caption := inttostr(luxusguetermenge) + ' t';
       luxusgueter := luxusgueter+strtoint(edit5.text);
       mladeraum := mladeraum+strtoint(edit5.text);
       label28.caption := inttostr(luxusgueter) + ' t';
       label23.caption := inttostr(laderaum) + ' t, davon sind ' +
                          inttostr(mladeraum) + ' t belegt';
       label7.caption := inttostr(credits);
       label38.caption := inttostr(Credits);
       label54.caption := inttostr(laderaum) + ' t, davon sind ' +
                          inttostr(mladeraum) + ' t belegt';
       label85.caption := inttostr(credits);
       label101.caption := inttostr(laderaum) + ' t, davon sind ' +
                           inttostr(mladeraum) + ' t belegt';
       label106.caption := inttostr(luxusguetermenge) + ' t';
       label153.caption := inttostr(credits);
      end
    end
  end
end;

procedure TMultPageDlg.Button6Click(Sender: TObject);
begin
  if strtoint(edit6.text)*metalle > credits then
  begin
   MessageDlg('Sie besitzen nicht genug Credits um diesen Kauf zu tätigen!',
   mtInformation, [mbOk], 0);
  end
 else
  begin
   if strtoint(edit6.text) > metallemenge then
    begin
     Messagedlg('Sie können nicht mehr Metalle kaufen als vorhanden sind!',
     mtInformation, [mbOk], 0);
    end
   else
    begin
     if mladeraum+strtoint(edit6.text) > laderaum then
      begin
       Messagedlg('Sie besitzen nicht genug Laderaum im Schiff!',
       mtInformation, [mbOK],0);
      end
     else
      begin
       credits := credits-strtoint(edit6.text)*metallepreis;
       metallemenge := metallemenge-strtoint(edit6.text);
       label60.caption := inttostr(metallemenge) + ' t';
       metalle := metalle+strtoint(edit6.text);
       mladeraum := mladeraum+strtoint(edit6.text);
       label29.caption := inttostr(metalle) + ' t';
       label23.caption := inttostr(laderaum) + ' t, davon sind ' +
                          inttostr(mladeraum) + ' t belegt';
       label7.caption := inttostr(credits);
       label38.caption := inttostr(Credits);
       label54.caption := inttostr(laderaum) + ' t, davon sind ' +
                          inttostr(mladeraum) + ' t belegt';
                          label85.caption := inttostr(credits);
       label101.caption := inttostr(laderaum) + ' t, davon sind ' +
                           inttostr(mladeraum) + ' t belegt';
       label107.caption := inttostr(metallemenge) + ' t';
       label153.caption := inttostr(credits);
      end
    end
  end
end;

procedure TMultPageDlg.Button7Click(Sender: TObject);
begin
  if strtoint(edit7.text)*nahrungsmittelpreis > credits then
  begin
   MessageDlg('Sie besitzen nicht genug Credits um diesen Kauf zu tätigen!',
   mtInformation, [mbOk], 0);
  end
 else
  begin
   if strtoint(edit7.text) > nahrungsmittelmenge then
    begin
     Messagedlg('Sie können nicht mehr Nahrungsmittel kaufen als vorhanden sind!',
     mtInformation, [mbOk], 0);
    end
   else
    begin
     if mladeraum+strtoint(edit7.text) > laderaum then
      begin
       Messagedlg('Sie besitzen nicht genug Laderaum im Schiff!',
       mtInformation, [mbOK],0);
      end
     else
      begin
       credits := credits-strtoint(edit7.text)*nahrungsmittelpreis;
       nahrungsmittelmenge := nahrungsmittelmenge-strtoint(edit7.text);
       label61.caption := inttostr(nahrungsmittelmenge) + ' t';
       nahrungsmittel := nahrungsmittel+strtoint(edit7.text);
       mladeraum := mladeraum+strtoint(edit7.text);
       label30.caption := inttostr(nahrungsmittel) + ' t';
       label23.caption := inttostr(laderaum) + ' t, davon sind ' +
                          inttostr(mladeraum) + ' t belegt';
       label7.caption := inttostr(credits);
       label38.caption := inttostr(Credits);
       label54.caption := inttostr(laderaum) + ' t, davon sind ' +
                          inttostr(mladeraum) + ' t belegt';
       label85.caption := inttostr(credits);
       label101.caption := inttostr(laderaum) + ' t, davon sind ' +
                        inttostr(mladeraum) + ' t belegt';
       label108.caption := inttostr(nahrungsmittelmenge) + ' t';
       label153.caption := inttostr(credits);
      end
    end
  end
end;

procedure TMultPageDlg.Button8Click(Sender: TObject);
begin
   if strtoint(edit8.text)*papierpreis > credits then
  begin
   MessageDlg('Sie besitzen nicht genug Credits um diesen Kauf zu tätigen!',
   mtInformation, [mbOk], 0);
  end
 else
  begin
   if strtoint(edit8.text) > papiermenge then
    begin
     Messagedlg('Sie können nicht mehr Papier kaufen als vorhanden sind!',
     mtInformation, [mbOk], 0);
    end
   else
    begin
     if mladeraum+strtoint(edit8.text) > laderaum then
      begin
       Messagedlg('Sie besitzen nicht genug Laderaum im Schiff!',
       mtInformation, [mbOK],0);
      end
     else
      begin
       credits := credits-strtoint(edit8.text)*papierpreis;
       papiermenge := papiermenge-strtoint(edit8.text);
       label62.caption := inttostr(papiermenge) + ' t';
       papier := papier+strtoint(edit8.text);
       mladeraum := mladeraum+strtoint(edit8.text);
       label31.caption := inttostr(papier) + ' t';
       label23.caption := inttostr(laderaum) + ' t, davon sind ' +
                          inttostr(mladeraum) + ' t belegt';
       label7.caption := inttostr(credits);
       label38.caption := inttostr(Credits);
       label54.caption := inttostr(laderaum) + ' t, davon sind ' +
                          inttostr(mladeraum) + ' t belegt';
       label85.caption := inttostr(credits);
       label101.caption := inttostr(laderaum) + ' t, davon sind ' +
                           inttostr(mladeraum) + ' t belegt';
       label109.caption := inttostr(papiermenge) + ' t';
       label153.caption := inttostr(credits);
      end
    end
  end
end;

procedure TMultPageDlg.Button9Click(Sender: TObject);
begin
    if strtoint(edit9.text)*rauschgiftepreis > credits then
  begin
   MessageDlg('Sie besitzen nicht genug Credits um diesen Kauf zu tätigen!',
   mtInformation, [mbOk], 0);
  end
 else
  begin
   if strtoint(edit9.text) > rauschgiftemenge then
    begin
     Messagedlg('Sie können nicht mehr Rauschgift kaufen als vorhanden sind!',
     mtInformation, [mbOk], 0);
    end
   else
    begin
     if mladeraum+strtoint(edit9.text) > laderaum then
      begin
       Messagedlg('Sie besitzen nicht genug Laderaum im Schiff!',
       mtInformation, [mbOK],0);
      end
     else
      begin
       credits := credits-strtoint(edit9.text)*rauschgiftepreis;
       rauschgiftemenge := rauschgiftemenge-strtoint(edit9.text);
       label63.caption := inttostr(rauschgiftemenge) + ' t';
       rauschgifte := rauschgifte+strtoint(edit9.text);
       mladeraum := mladeraum+strtoint(edit9.text);
       label32.caption := inttostr(rauschgifte) + ' t';
       label23.caption := inttostr(laderaum) + ' t, davon sind ' +
                          inttostr(mladeraum) + ' t belegt';
       label7.caption := inttostr(credits);
       label38.caption := inttostr(Credits);
       label54.caption := inttostr(laderaum) + ' t, davon sind ' +
                          inttostr(mladeraum) + ' t belegt';
       label85.caption := inttostr(credits);
       label101.caption := inttostr(laderaum) + ' t, davon sind ' +
                           inttostr(mladeraum) + ' t belegt';
       label110.caption := inttostr(rauschgiftemenge) + ' t';
       label153.caption := inttostr(credits);
      end
    end
  end
end;

procedure TMultPageDlg.Button10Click(Sender: TObject);
begin
   if strtoint(edit10.text)*sklavenpreis > credits then
  begin
   MessageDlg('Sie besitzen nicht genug Credits um diesen Kauf zu tätigen!',
   mtInformation, [mbOk], 0);
  end
 else
  begin
   if strtoint(edit10.text) > sklavenmenge then
    begin
     Messagedlg('Sie können nicht mehr Sklaven kaufen als vorhanden sind!',
     mtInformation, [mbOk], 0);
    end
   else
    begin
     if mladeraum+strtoint(edit10.text) > laderaum then
      begin
       Messagedlg('Sie besitzen nicht genug Laderaum im Schiff!',
       mtInformation, [mbOK],0);
      end
     else
      begin
       credits := credits-strtoint(edit10.text)*sklavenpreis;
       sklavenmenge := sklavenmenge-strtoint(edit10.text);
       label64.caption := inttostr(sklavenmenge) + ' t';
       sklaven := sklaven+strtoint(edit10.text);
       mladeraum := mladeraum+strtoint(edit10.text);
       label33.caption := inttostr(sklaven) + ' t';
       label23.caption := inttostr(laderaum) + ' t, davon sind ' +
                          inttostr(mladeraum) + ' t belegt';
       label7.caption := inttostr(credits);
       label38.caption := inttostr(Credits);
       label54.caption := inttostr(laderaum) + ' t, davon sind ' +
                          inttostr(mladeraum) + ' t belegt';
       label85.caption := inttostr(credits);
       label101.caption := inttostr(laderaum) + ' t, davon sind ' +
                           inttostr(mladeraum) + ' t belegt';
       label111.caption := inttostr(sklavenmenge) + ' t';
       label153.caption := inttostr(credits);
      end
    end
  end
end;


procedure TMultPageDlg.Button11Click(Sender: TObject);
begin
    if strtoint(edit11.text)*sprengstoffpreis > credits then
  begin
   MessageDlg('Sie besitzen nicht genug Credits um diesen Kauf zu tätigen!',
   mtInformation, [mbOk], 0);
  end
 else
  begin
   if strtoint(edit11.text) > sprengstoffmenge then
    begin
     Messagedlg('Sie können nicht mehr Sprengstoff kaufen als vorhanden sind!',
     mtInformation, [mbOk], 0);
    end
   else
    begin
     if mladeraum+strtoint(edit11.text) > laderaum then
      begin
       Messagedlg('Sie besitzen nicht genug Laderaum im Schiff!',
       mtInformation, [mbOK],0);
      end
     else
      begin
       credits := credits-strtoint(edit11.text)*sprengstoffpreis;
       sprengstoffmenge := sprengstoffmenge-strtoint(edit11.text);
       label65.caption := inttostr(sprengstoffmenge) + ' t';
       sprengstoff := sprengstoff+strtoint(edit11.text);
       mladeraum := mladeraum+strtoint(edit11.text);
       label34.caption := inttostr(sprengstoff) + ' t';
       label23.caption := inttostr(laderaum) + ' t, davon sind ' +
                          inttostr(mladeraum) + ' t belegt';
       label7.caption := inttostr(credits);
       label38.caption := inttostr(Credits);
       label54.caption := inttostr(laderaum) + ' t, davon sind ' +
                          inttostr(mladeraum) + ' t belegt';
       label85.caption := inttostr(credits);
       label101.caption := inttostr(laderaum) + ' t, davon sind ' +
                           inttostr(mladeraum) + ' t belegt';
       label112.caption := inttostr(sprengstoffmenge) + ' t';
       label153.caption := inttostr(credits);
      end
    end
  end
end;

procedure TMultPageDlg.Button12Click(Sender: TObject);
begin
     if strtoint(edit12.text)*waffenpreis > credits then
  begin
   MessageDlg('Sie besitzen nicht genug Credits um diesen Kauf zu tätigen!',
   mtInformation, [mbOk], 0);
  end
 else
  begin
   if strtoint(edit12.text) > waffenmenge then
    begin
     Messagedlg('Sie können nicht mehr Waffen kaufen als vorhanden sind!',
     mtInformation, [mbOk], 0);
    end
   else
    begin
     if mladeraum+strtoint(edit12.text) > laderaum then
      begin
       Messagedlg('Sie besitzen nicht genug Laderaum im Schiff!',
       mtInformation, [mbOK],0);
      end
     else
      begin
       credits := credits-strtoint(edit12.text)*waffenpreis;
       waffenmenge := waffenmenge-strtoint(edit12.text);
       label66.caption := inttostr(waffenmenge) + ' t';
       waffen := waffen+strtoint(edit12.text);
       mladeraum := mladeraum+strtoint(edit12.text);
       label35.caption := inttostr(waffen) + ' t';
       label23.caption := inttostr(laderaum) + ' t, davon sind ' +
                          inttostr(mladeraum) + ' t belegt';
       label7.caption := inttostr(credits);
       label38.caption := inttostr(Credits);
       label54.caption := inttostr(laderaum) + ' t, davon sind ' +
                          inttostr(mladeraum) + ' t belegt';
       label85.caption := inttostr(credits);
       label101.caption := inttostr(laderaum) + ' t, davon sind ' +
                           inttostr(mladeraum) + ' t belegt';
       label113.caption := inttostr(waffenmenge) + ' t';
       label153.caption := inttostr(credits);
      end
    end
  end
end;

procedure TMultPageDlg.Button13Click(Sender: TObject);
begin
 if strtoint(edit13.text)*wasserpreis > credits then
  begin
   MessageDlg('Sie besitzen nicht genug Credits um diesen Kauf zu tätigen!',
   mtInformation, [mbOk], 0);
  end
 else
  begin
   if strtoint(edit13.text) > wassermenge then
    begin
     Messagedlg('Sie können nicht mehr Wasser kaufen als vorhanden sind!',
     mtInformation, [mbOk], 0);
    end
   else
    begin
     if mladeraum+strtoint(edit13.text) > laderaum then
      begin
       Messagedlg('Sie besitzen nicht genug Laderaum im Schiff!',
       mtInformation, [mbOK],0);
      end
     else
      begin
       credits := credits-strtoint(edit13.text)*wasserpreis;
       wassermenge := wassermenge-strtoint(edit13.text);
       label67.caption := inttostr(wassermenge) + ' t';
       wasser := wasser+strtoint(edit13.text);
       mladeraum := mladeraum+strtoint(edit13.text);
       label36.caption := inttostr(wasser) + ' t';
       label23.caption := inttostr(laderaum) + ' t, davon sind ' +
                          inttostr(mladeraum) + ' t belegt';
       label7.caption := inttostr(credits);
       label38.caption := inttostr(Credits);
       label54.caption := inttostr(laderaum) + ' t, davon sind ' +
                          inttostr(mladeraum) + ' t belegt';
       label85.caption := inttostr(credits);
       label101.caption := inttostr(laderaum) + ' t, davon sind ' +
                           inttostr(mladeraum) + ' t belegt';
        label114.caption := inttostr(wassermenge) + ' t';
        label153.caption := inttostr(credits);
      end
    end
  end

end;

procedure TMultPageDlg.Button14Click(Sender: TObject);
begin
 if strtoint(edit14.text) > chemikalien then
   begin
    Messagedlg('Sie können nicht mehr Chemikalien verkaufen als vorhanden sind!',
    mtInformation, [mbOk], 0);
   end
  else
   begin
    credits := credits+strtoint(edit14.text)*chemikalienpreis;
    chemikalienmenge := chemikalienmenge+strtoint(edit14.text);
    label55.caption := inttostr(chemikalienmenge) + ' t';
    chemikalien := chemikalien-strtoint(edit14.text);
    mladeraum := mladeraum-strtoint(edit14.text);
    label24.caption := inttostr(chemikalien) + ' t';
    label23.caption := inttostr(laderaum) + ' t, davon sind ' +
                       inttostr(mladeraum) + ' t belegt';
    label7.caption := inttostr(credits);
    label38.caption := inttostr(Credits);
    label54.caption := inttostr(laderaum) + ' t, davon sind ' +
                       inttostr(mladeraum) + ' t belegt';
    label85.caption := inttostr(credits);
    label101.caption := inttostr(laderaum) + ' t, davon sind ' +
                       inttostr(mladeraum) + ' t belegt';
    label102.caption := inttostr(chemikalienmenge) + ' t';
    label153.caption := inttostr(credits);
   end
end;

procedure TMultPageDlg.Button15Click(Sender: TObject);
begin
if strtoint(edit15.text) > computer then
   begin
    Messagedlg('Sie können nicht mehr Computer verkaufen als vorhanden sind!',
    mtInformation, [mbOk], 0);
   end
  else
   begin
    credits := credits+strtoint(edit15.text)*computerpreis;
    computermenge := computermenge+strtoint(edit15.text);
    label56.caption := inttostr(computermenge) + ' t';
    computer := computer-strtoint(edit15.text);
    mladeraum := mladeraum-strtoint(edit15.text);
    label25.caption := inttostr(computer) + ' t';
    label23.caption := inttostr(laderaum) + ' t, davon sind ' +
                       inttostr(mladeraum) + ' t belegt';
    label7.caption := inttostr(credits);
    label38.caption := inttostr(Credits);
    label54.caption := inttostr(laderaum) + ' t, davon sind ' +
                       inttostr(mladeraum) + ' t belegt';
    label85.caption := inttostr(credits);
    label101.caption := inttostr(laderaum) + ' t, davon sind ' +
                       inttostr(mladeraum) + ' t belegt';
    label103.caption := inttostr(computermenge) + ' t';
    label153.caption := inttostr(credits);
   end
end;

procedure TMultPageDlg.Button16Click(Sender: TObject);
begin
if strtoint(edit16.text) > energiezellen then
   begin
    Messagedlg('Sie können nicht mehr Energiezellen verkaufen als vorhanden sind!',
    mtInformation, [mbOk], 0);
   end
  else
   begin
    credits := credits+strtoint(edit16.text)*energiezellenpreis;
    energiezellenmenge := energiezellenmenge+strtoint(edit16.text);
    label57.caption := inttostr(energiezellenmenge) + ' t';
    energiezellen := energiezellen-strtoint(edit16.text);
    mladeraum := mladeraum-strtoint(edit16.text);
    label26.caption := inttostr(energiezellen) + ' t';
    label23.caption := inttostr(laderaum) + ' t, davon sind ' +
                       inttostr(mladeraum) + ' t belegt';
    label7.caption := inttostr(credits);
    label38.caption := inttostr(Credits);
    label54.caption := inttostr(laderaum) + ' t, davon sind ' +
                       inttostr(mladeraum) + ' t belegt';
    label85.caption := inttostr(credits);
    label101.caption := inttostr(laderaum) + ' t, davon sind ' +
                       inttostr(mladeraum) + ' t belegt';
    label104.caption := inttostr(energiezellenmenge) + ' t';
    label153.caption := inttostr(credits);
   end
end;

procedure TMultPageDlg.Button17Click(Sender: TObject);
begin
if strtoint(edit17.text) > kunststoffe then
   begin
    Messagedlg('Sie können nicht mehr Kunststoffe verkaufen als vorhanden sind!',
    mtInformation, [mbOk], 0);
   end
  else
   begin
    credits := credits+strtoint(edit17.text)*kunststoffepreis;
    kunststoffemenge := kunststoffemenge+strtoint(edit17.text);
    label58.caption := inttostr(kunststoffemenge) + ' t';
    kunststoffe := kunststoffe-strtoint(edit17.text);
    mladeraum := mladeraum-strtoint(edit17.text);
    label27.caption := inttostr(kunststoffe) + ' t';
    label23.caption := inttostr(laderaum) + ' t, davon sind ' +
                       inttostr(mladeraum) + ' t belegt';
    label7.caption := inttostr(credits);
    label38.caption := inttostr(Credits);
    label54.caption := inttostr(laderaum) + ' t, davon sind ' +
                       inttostr(mladeraum) + ' t belegt';
    label85.caption := inttostr(credits);
    label101.caption := inttostr(laderaum) + ' t, davon sind ' +
                       inttostr(mladeraum) + ' t belegt';
    label105.caption := inttostr(kunststoffemenge) + ' t';
    label153.caption := inttostr(credits);
   end
end;

procedure TMultPageDlg.Button18Click(Sender: TObject);
begin
if strtoint(edit18.text) > luxusgueter then
   begin
    Messagedlg('Sie können nicht mehr Luxusgüter kaufen als vorhanden sind!',
    mtInformation, [mbOk], 0);
   end
  else
   begin
    credits := credits+strtoint(edit18.text)*luxusgueterpreis;
    luxusguetermenge := luxusguetermenge+strtoint(edit18.text);
    label59.caption := inttostr(luxusguetermenge) + ' t';
    luxusgueter := luxusgueter-strtoint(edit18.text);
    mladeraum := mladeraum-strtoint(edit18.text);
    label28.caption := inttostr(luxusgueter) + ' t';
    label23.caption := inttostr(laderaum) + ' t, davon sind ' +
                       inttostr(mladeraum) + ' t belegt';
    label7.caption := inttostr(credits);
    label38.caption := inttostr(Credits);
    label54.caption := inttostr(laderaum) + ' t, davon sind ' +
                       inttostr(mladeraum) + ' t belegt';
    label85.caption := inttostr(credits);
    label101.caption := inttostr(laderaum) + ' t, davon sind ' +
                        inttostr(mladeraum) + ' t belegt';
    label106.caption := inttostr(luxusguetermenge) + ' t';
    label153.caption := inttostr(credits);
   end
end;

procedure TMultPageDlg.Button19Click(Sender: TObject);
begin
if strtoint(edit19.text) > metalle then
   begin
    Messagedlg('Sie können nicht mehr Metalle kaufen als vorhanden sind!',
    mtInformation, [mbOk], 0);
   end
  else
   begin
    credits := credits+strtoint(edit19.text)*metallepreis;
    metallemenge := metallemenge+strtoint(edit19.text);
    label60.caption := inttostr(metallemenge) + ' t';
    metalle := metalle-strtoint(edit19.text);
    mladeraum := mladeraum-strtoint(edit19.text);
    label29.caption := inttostr(metalle) + ' t';
    label23.caption := inttostr(laderaum) + ' t, davon sind ' +
                       inttostr(mladeraum) + ' t belegt';
    label7.caption := inttostr(credits);
    label38.caption := inttostr(Credits);
    label54.caption := inttostr(laderaum) + ' t, davon sind ' +
                       inttostr(mladeraum) + ' t belegt';
    label85.caption := inttostr(credits);
    label101.caption := inttostr(laderaum) + ' t, davon sind ' +
                        inttostr(mladeraum) + ' t belegt';
    label107.caption := inttostr(metallemenge) + ' t';
    label153.caption := inttostr(credits);
   end
end;

procedure TMultPageDlg.Button20Click(Sender: TObject);
begin
if strtoint(edit20.text) > nahrungsmittel then
   begin
    Messagedlg('Sie können nicht mehr Nahrungsmittel kaufen als vorhanden sind!',
    mtInformation, [mbOk], 0);
   end
  else
   begin
    credits := credits+strtoint(edit20.text)*nahrungsmittelpreis;
    nahrungsmittelmenge := nahrungsmittelmenge+strtoint(edit20.text);
    label61.caption := inttostr(nahrungsmittelmenge) + ' t';
    nahrungsmittel := nahrungsmittel-strtoint(edit20.text);
    mladeraum := mladeraum-strtoint(edit20.text);
    label30.caption := inttostr(nahrungsmittel) + ' t';
    label23.caption := inttostr(laderaum) + ' t, davon sind ' +
                       inttostr(mladeraum) + ' t belegt';
    label7.caption := inttostr(credits);
    label38.caption := inttostr(Credits);
    label54.caption := inttostr(laderaum) + ' t, davon sind ' +
                       inttostr(mladeraum) + ' t belegt';
    label85.caption := inttostr(credits);
    label101.caption := inttostr(laderaum) + ' t, davon sind ' +
                        inttostr(mladeraum) + ' t belegt';
    label108.caption := inttostr(nahrungsmittelmenge) + ' t';
    label153.caption := inttostr(credits);
   end
end;

procedure TMultPageDlg.Button21Click(Sender: TObject);
begin
if strtoint(edit21.text) > papier then
   begin
    Messagedlg('Sie können nicht mehr Papier kaufen als vorhanden sind!',
    mtInformation, [mbOk], 0);
   end
  else
   begin
    credits := credits+strtoint(edit21.text)*papierpreis;
    papiermenge := papiermenge+strtoint(edit21.text);
    label62.caption := inttostr(papiermenge) + ' t';
    papier := papier-strtoint(edit21.text);
    mladeraum := mladeraum-strtoint(edit21.text);
    label31.caption := inttostr(papier) + ' t';
    label23.caption := inttostr(laderaum) + ' t, davon sind ' +
                       inttostr(mladeraum) + ' t belegt';
    label7.caption := inttostr(credits);
    label38.caption := inttostr(Credits);
    label54.caption := inttostr(laderaum) + ' t, davon sind ' +
                       inttostr(mladeraum) + ' t belegt';
    label85.caption := inttostr(credits);
    label101.caption := inttostr(laderaum) + ' t, davon sind ' +
                        inttostr(mladeraum) + ' t belegt';
    label109.caption := inttostr(papiermenge) + ' t';
    label153.caption := inttostr(credits);
   end
end;

procedure TMultPageDlg.Button22Click(Sender: TObject);
begin
if strtoint(edit22.text) > rauschgifte then
   begin
    Messagedlg('Sie können nicht mehr Rauschgifte kaufen als vorhanden sind!',
    mtInformation, [mbOk], 0);
   end
  else
   begin
    credits := credits+strtoint(edit22.text)*rauschgiftepreis;
    rauschgiftemenge := rauschgiftemenge+strtoint(edit22.text);
    label63.caption := inttostr(rauschgiftemenge) + ' t';
    rauschgifte := rauschgifte-strtoint(edit22.text);
    mladeraum := mladeraum-strtoint(edit22.text);
    label32.caption := inttostr(rauschgifte) + ' t';
    label23.caption := inttostr(laderaum) + ' t, davon sind ' +
                       inttostr(mladeraum) + ' t belegt';
    label7.caption := inttostr(credits);
    label38.caption := inttostr(Credits);
    label54.caption := inttostr(laderaum) + ' t, davon sind ' +
                       inttostr(mladeraum) + ' t belegt';
    label85.caption := inttostr(credits);
    label101.caption := inttostr(laderaum) + ' t, davon sind ' +
                        inttostr(mladeraum) + ' t belegt';
    label110.caption := inttostr(rauschgiftemenge) + ' t';
    label153.caption := inttostr(credits);
   end
end;

procedure TMultPageDlg.Button23Click(Sender: TObject);
begin
if strtoint(edit23.text) > sklaven then
   begin
    Messagedlg('Sie können nicht mehr Sklaven kaufen als vorhanden sind!',
    mtInformation, [mbOk], 0);
   end
  else
   begin
    credits := credits+strtoint(edit23.text)*sklavenpreis;
    sklavenmenge := sklavenmenge+strtoint(edit23.text);
    label64.caption := inttostr(sklavenmenge) + ' t';
    sklaven := sklaven-strtoint(edit23.text);
    mladeraum := mladeraum-strtoint(edit23.text);
    label33.caption := inttostr(sklaven) + ' t';
    label23.caption := inttostr(laderaum) + ' t, davon sind ' +
                       inttostr(mladeraum) + ' t belegt';
    label7.caption := inttostr(credits);
    label38.caption := inttostr(Credits);
    label54.caption := inttostr(laderaum) + ' t, davon sind ' +
                       inttostr(mladeraum) + ' t belegt';
    label85.caption := inttostr(credits);
    label101.caption := inttostr(laderaum) + ' t, davon sind ' +
                        inttostr(mladeraum) + ' t belegt';
    label111.caption := inttostr(sklavenmenge) + ' t';
    label153.caption := inttostr(credits);
   end
end;

procedure TMultPageDlg.Button24Click(Sender: TObject);
begin
if strtoint(edit24.text) > sprengstoff then
   begin
    Messagedlg('Sie können nicht mehr Sprengstoff kaufen als vorhanden sind!',
    mtInformation, [mbOk], 0);
   end
  else
   begin
    credits := credits+strtoint(edit24.text)*sprengstoffpreis;
    sprengstoffmenge := sprengstoffmenge+strtoint(edit24.text);
    label65.caption := inttostr(sprengstoffmenge) + ' t';
    sprengstoff := sprengstoff-strtoint(edit24.text);
    mladeraum := mladeraum-strtoint(edit24.text);
    label34.caption := inttostr(sprengstoff) + ' t';
    label23.caption := inttostr(laderaum) + ' t, davon sind ' +
                       inttostr(mladeraum) + ' t belegt';
    label7.caption := inttostr(credits);
    label38.caption := inttostr(Credits);
    label54.caption := inttostr(laderaum) + ' t, davon sind ' +
                       inttostr(mladeraum) + ' t belegt';
    label85.caption := inttostr(credits);
    label101.caption := inttostr(laderaum) + ' t, davon sind ' +
                        inttostr(mladeraum) + ' t belegt';
    label112.caption := inttostr(sprengstoffmenge) + ' t';
    label153.caption := inttostr(credits);
   end
end;

procedure TMultPageDlg.Button25Click(Sender: TObject);
begin
if strtoint(edit25.text) > waffen then
   begin
    Messagedlg('Sie können nicht mehr Waffen kaufen als vorhanden sind!',
    mtInformation, [mbOk], 0);
   end
  else
   begin
    credits := credits+strtoint(edit25.text)*waffenpreis;
    waffenmenge := waffenmenge+strtoint(edit25.text);
    label66.caption := inttostr(waffenmenge) + ' t';
    waffen := waffen-strtoint(edit25.text);
    mladeraum := mladeraum-strtoint(edit25.text);
    label35.caption := inttostr(waffen) + ' t';
    label23.caption := inttostr(laderaum) + ' t, davon sind ' +
                       inttostr(mladeraum) + ' t belegt';
    label7.caption := inttostr(credits);
    label38.caption := inttostr(Credits);
    label54.caption := inttostr(laderaum) + ' t, davon sind ' +
                       inttostr(mladeraum) + ' t belegt';
    label85.caption := inttostr(credits);
    label101.caption := inttostr(laderaum) + ' t, davon sind ' +
                        inttostr(mladeraum) + ' t belegt';
    label113.caption := inttostr(waffenmenge) + ' t';
    label153.caption := inttostr(credits);
   end
end;

procedure TMultPageDlg.Button26Click(Sender: TObject);
begin
if strtoint(edit26.text) > wasser then
   begin
    Messagedlg('Sie können nicht mehr Wasser kaufen als vorhanden sind!',
    mtInformation, [mbOk], 0);
   end
  else
   begin
    credits := credits+strtoint(edit26.text)*wasserpreis;
    wassermenge := wassermenge+strtoint(edit26.text);
    label67.caption := inttostr(wassermenge) + ' t';
    wasser := wasser-strtoint(edit26.text);
    mladeraum := mladeraum-strtoint(edit26.text);
    label36.caption := inttostr(wasser) + ' t';
    label23.caption := inttostr(laderaum) + ' t, davon sind ' +
                       inttostr(mladeraum) + ' t belegt';
    label7.caption := inttostr(credits);
    label38.caption := inttostr(Credits);
    label54.caption := inttostr(laderaum) + ' t, davon sind ' +
                       inttostr(mladeraum) + ' t belegt';
    label85.caption := inttostr(credits);
    label101.caption := inttostr(laderaum) + ' t, davon sind ' +
                        inttostr(mladeraum) + ' t belegt';
    label114.caption := inttostr(wassermenge) + ' t';
    label153.caption := inttostr(credits);
   end
end;

procedure TMultPageDlg.Button27Click(Sender: TObject);
begin
 if 10000 > credits then
  begin
   MessageDlg('Sie besitzen nicht genug Credits um diesen Kauf zu tätigen!',
   mtInformation, [mbOk], 0);
  end
 else
  begin
  if laser >= 1 then
   begin
    MessageDlg('Sie besitzen bereits einen Thermoreaktionslaser!',
    mtInformation, [mbOk], 0);
   end
  else
   begin
   laser := 1;
   credits := credits-10000;
   label7.caption := inttostr(credits);
   label38.caption := inttostr(Credits);
   label85.caption := inttostr(credits);
   label153.caption := inttostr(credits);
   end
  end
end;

procedure TMultPageDlg.Button28Click(Sender: TObject);
begin
 if laser < 1 then
  begin
   MessageDlg('Sie müssen sich erst einen Thermoreaktionslaserkaufen!',
   mtInformation, [mbOk], 0);
  end
 else
  begin
   if 30000 > credits then
    begin
     MessageDlg('Sie besitzen nicht genug Credits um diesen Kauf zu tätigen!',
     mtInformation, [mbOk], 0);
    end
   else
   begin
    if laser >= 2 then
     begin
      MessageDlg('Sie besitzen bereits einen Punktsingularitätslaser!',
      mtInformation, [mbOk], 0);
     end
   else
    begin
     laser := 2;
     credits := credits-30000;
     label7.caption := inttostr(credits);
     label38.caption := inttostr(Credits);
     label85.caption := inttostr(credits);
     label153.caption := inttostr(credits);
   end
   end
  end
end;

procedure TMultPageDlg.Button29Click(Sender: TObject);
begin
 if 5000 > credits then
  begin
   MessageDlg('Sie besitzen nicht genug Credits um diesen Kauf zu tätigen!',
   mtInformation, [mbOk], 0);
  end
 else
  begin
   maxschild := maxschild + 50;
   mschild := maxschild;
   label155.caption := inttostr(mschild) + ' von ' + inttostr(maxschild);
   credits := credits-5000;
   label7.caption := inttostr(credits);
   label38.caption := inttostr(Credits);
   label85.caption := inttostr(credits);
   label153.caption := inttostr(credits);
  end
end;

procedure TMultPageDlg.Button30Click(Sender: TObject);
begin
 if 7000 > credits then
  begin
   MessageDlg('Sie besitzen nicht genug Credits um diesen Kauf zu tätigen!',
   mtInformation, [mbOk], 0);
  end
 else
  begin
  if pixelprozug > 2 then
   begin
    MessageDlg('Sie besitzen bereits einen Nachbrenner!',
    mtInformation, [mbOk], 0);
   end
  else
   begin
   pixelprozug := 4;
   credits := credits-7000;
   label157.caption := 'vorhanden';
   label7.caption := inttostr(credits);
   label38.caption := inttostr(Credits);
   label85.caption := inttostr(credits);
   label153.caption := inttostr(credits);
   end
  end
end;

procedure TMultPageDlg.Button36Click(Sender: TObject);
begin
if 20000 > credits then
  begin
   MessageDlg('Sie besitzen nicht genug Credits um diesen Kauf zu tätigen!',
   mtInformation, [mbOk], 0);
  end
 else
  begin
   credits := credits - 20000;
   laderaum := laderaum + 5;
   label101.caption := inttostr(laderaum) + ' t, davon sind ' +
                       inttostr(mladeraum) + ' t belegt';
   label54.caption := inttostr(laderaum) + ' t, davon sind ' +
                      inttostr(mladeraum) + ' t belegt';
   label23.caption := inttostr(laderaum) + ' t, davon sind ' +
                      inttostr(mladeraum) + ' t belegt';
   label7.caption := inttostr(credits);
   label38.caption := inttostr(Credits);
   label85.caption := inttostr(credits);
   label153.caption := inttostr(credits);
  end
end;

procedure TMultPageDlg.Button31Click(Sender: TObject);
begin
 if 100*strtoint(edit27.text) > credits then
  begin
   MessageDlg('Sie besitzen nicht genug Credits um diesen Kauf zu tätigen!',
   mtInformation, [mbOk], 0);
  end
 else
   begin
   credits := credits-100*strtoint(edit27.text);
   raumbomben := raumbomben + strtoint(edit27.text);
   label7.caption := inttostr(credits);
   label38.caption := inttostr(Credits);
   label85.caption := inttostr(credits);
   label153.caption := inttostr(credits);
   label163.caption := inttostr(raumbomben)
   end
end;

procedure TMultPageDlg.Button32Click(Sender: TObject);
begin
if 500*strtoint(edit28.text) > credits then
  begin
   MessageDlg('Sie besitzen nicht genug Credits um diesen Kauf zu tätigen!',
   mtInformation, [mbOk], 0);
  end
 else
   begin
   credits := credits-500*strtoint(edit28.text);
   photonentorpedos := photonentorpedos + strtoint(edit28.text);
   label7.caption := inttostr(credits);
   label38.caption := inttostr(Credits);
   label85.caption := inttostr(credits);
   label153.caption := inttostr(credits);
   label164.caption := inttostr(photonentorpedos)
   end
end;

procedure TMultPageDlg.Button33Click(Sender: TObject);
begin
if 1500*strtoint(edit29.text) > credits then
  begin
   MessageDlg('Sie besitzen nicht genug Credits um diesen Kauf zu tätigen!',
   mtInformation, [mbOk], 0);
  end
 else
   begin
   credits := credits-1500*strtoint(edit29.text);
   multiphasentorpedos  := multiphasentorpedos + strtoint(edit29.text);
   label7.caption := inttostr(credits);
   label38.caption := inttostr(Credits);
   label85.caption := inttostr(credits);
   label153.caption := inttostr(credits);
   label165.caption := inttostr(multiphasentorpedos)
   end
end;

procedure TMultPageDlg.Button34Click(Sender: TObject);
begin
if 15000*strtoint(edit30.text) > credits then
  begin
   MessageDlg('Sie besitzen nicht genug Credits um diesen Kauf zu tätigen!',
   mtInformation, [mbOk], 0);
  end
 else
   begin
   credits := credits-15000*strtoint(edit30.text);
   neutronenemiterbombe := neutronenemiterbombe + strtoint(edit30.text);
   label7.caption := inttostr(credits);
   label38.caption := inttostr(Credits);
   label85.caption := inttostr(credits);
   label153.caption := inttostr(credits);
   label166.caption := inttostr(neutronenemiterbombe);
   end
end;

procedure TMultPageDlg.Button35Click(Sender: TObject);
begin
if 10*strtoint(edit31.text) > credits then
  begin
   MessageDlg('Sie besitzen nicht genug Credits um diesen Kauf zu tätigen!',
   mtInformation, [mbOk], 0);
  end
 else
   begin
   credits := credits-10*strtoint(edit31.text);
   fusionszellen := fusionszellen+ strtoint(edit31.text);
   label7.caption := inttostr(credits);
   label38.caption := inttostr(Credits);
   label85.caption := inttostr(credits);
   label153.caption := inttostr(credits);
   label167.caption := inttostr(fusionszellen);
   end
end;

end.
