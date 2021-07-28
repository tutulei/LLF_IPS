unit uConfigUnit;

interface

uses
  IniFiles,uConstants,SysUtils,Forms;

var
  inifile: TIniFile;
    //ÐÐÇéµÇÂ¼ÅäÖÃ
  quotationflowpath: string;
  quotationserver: string;
    //½»Ò×µÇÂ¼ÅäÖÃ
  tradeflowpath: string;
  tradeserver: string;
  tradeaccount: string;
  tradebrokerid: string;
  tradepassword: string;
  tradeauthcode: string;
  tradeappid: string;

  dllName: string;  

procedure InitConfiguration();

implementation


procedure InitConfiguration();
var
  account: string;
begin
  account := 'account1';
  dllName := 'QuotationAndTraderCTP.dll';
  WorkPath := ExtractFilePath(application.exename);
  inifile := TIniFile.Create(WorkPath + 'config.ini');
  quotationflowpath := inifile.ReadString('common', 'flowpath','');
  quotationserver := inifile.ReadString(account, 'quotation.server','');
  tradeflowpath:= inifile.ReadString('common', 'flowpath','');
  tradeserver:= inifile.ReadString(account,'trade.server','');
  tradeaccount:= inifile.ReadString(account,'trade.account','');
  tradebrokerid:= inifile.ReadString(account,'trade.brokerid','');
  tradepassword:= inifile.ReadString(account,'trade.password','');
  tradeauthcode:= inifile.ReadString(account,'trade.authcode','');
  tradeappid:= inifile.ReadString(account,'trade.appid','');
end;  


end.

