unit uConfigUnit;

interface

uses
  XMLIntf, XMLDoc, uConstants, SysUtils, Forms;

type
  AccountStruct = record
    sTradeServer: string;
    sQuotationServer: string;
    sAccount: string;
    sPassword: string;
    sBrokerID: string;
    sAuthCode: string;
    sAppid: string;
  end;

var
  iXMLAreaFile: IXMLDocument;
  account: AccountStruct;
  account1: AccountStruct;
  account2: AccountStruct;
  account3: AccountStruct;
  dllName: string;

procedure InitConfiguration();

implementation

procedure InitConfiguration();
var
  RootNode: IXMLNode;
  tempnode: IXMLNode;
begin
  dllName := 'QuotationAndTraderCTP.dll';

  iXMLAreaFile := TXMLDocument.Create(nil);
  WorkPath := ExtractFilePath(application.exename);
  iXMLAreaFile.FileName := WorkPath + 'config\config.xml';
//  iXMLAreaFile.Encoding := 'UTF-8';
  iXMLAreaFile.active := True;

  RootNode := iXMLAreaFile.DocumentElement;
  tempnode := RootNode.ChildNodes[0];
  account1.sAccount := tempnode.ChildNodes['item'].Attributes['Account'];
  account1.sPassword := tempnode.ChildNodes['item'].Attributes['PassWord'];
  account1.sBrokerID := tempnode.ChildNodes['item'].Attributes['BrokerID'];
  account1.sAuthCode := tempnode.ChildNodes['item'].Attributes['AuthCode'];
  account1.sAppid := tempnode.ChildNodes['item'].Attributes['AppID'];
  account1.sTradeServer := tempnode.ChildNodes['server'].ChildValues['trade'];
  account1.sQuotationServer := tempnode.ChildNodes['server'].ChildValues['quotation'];

  account := account1;
end;

end.

