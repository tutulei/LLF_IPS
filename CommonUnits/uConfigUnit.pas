unit uConfigUnit;

interface

uses
  XMLIntf, XMLDoc, uConstants, SysUtils, Forms, Windows, Classes;

type
  FAccountStruct = record
    sName: string;
    sAccount: string;
    sPassword: string;
    sAuthCode: string;
    sAppid: string;
  end;

  FTradeServerStruct = record
    sName: string;
    sServer: string;
    sBrokerID: string;
  end;

  FQuotationServerStruct = record
    sName: string;
    sServer: string;
  end;

  PAccountStruct = ^FAccountStruct;

  PTradeServerStruct = ^FTradeServerStruct;

  PQuotationServerStruct = ^FQuotationServerStruct;

var
  iXMLAreaFile: IXMLDocument;
  TradeDefaultAccount: PAccountStruct;

  //期货交易服务
  FutureTradeServerList: TStringList;
  DefaultFutureTradeServerIndex:Integer;
  //期货行情服务
  FutureQuotationServerList: TStringList;
  DefaultFutureQuotationServerIndex:Integer;
  //交易账户
  AccountList: TStringList;
  DefaultAccountIndex:Integer;

  dllName: string;

procedure InitConfiguration();

implementation

procedure InitConfiguration();
var
  RootNode: IXMLNode;
  TradeNode: IXMLNode;
  QuotationNode: IXMLNode;
  AccountNode: IXMLNode;
  tempnode: IXMLNode;
  I: Integer;
  count: Integer;
  tempaccount: PAccountStruct;
  tempfuturequotationserver: PQuotationServerStruct;
  tempfuturetradeserver: PTradeServerStruct;
begin
  dllName := 'QuotationAndTraderCTP.dll';
  iXMLAreaFile := TXMLDocument.Create(nil);
  WorkPath := ExtractFilePath(application.exename);
  iXMLAreaFile.FileName := WorkPath + 'config\config.xml';
  iXMLAreaFile.active := True;
  RootNode := iXMLAreaFile.DocumentElement;
  //创建三个列表
  AccountList := TStringList.Create;
  FutureQuotationServerList := TStringList.Create;
  FutureTradeServerList := TStringList.Create;

  //{Trade}导入交易服务列表
  TradeNode := RootNode.ChildNodes['trade'];
  //期货交易服务
  count := TradeNode.ChildNodes['FuturesServer'].ChildNodes.Count;
  DefaultFutureTradeServerIndex := TradeNode.ChildNodes['FuturesServer'].Attributes['Default'];
  for I := 0 to count - 1 do
  begin
    tempnode := TradeNode.ChildNodes['FuturesServer'].ChildNodes[I];
    New(tempfuturetradeserver);
    tempfuturetradeserver.sName := tempnode.Attributes['Name'];
    tempfuturetradeserver.sServer := tempnode.Attributes['Server'];
    tempfuturetradeserver.sBrokerID := tempnode.Attributes['BrokerID'];

    FutureTradeServerList.AddObject(tempfuturetradeserver.sName, Pointer(tempfuturetradeserver));
  end;
  //{Quotation}导入行情服务列表
  QuotationNode := RootNode.ChildNodes['quotation'];
  //期货行情服务
  count := QuotationNode.ChildNodes['FuturesServer'].ChildNodes.Count;
  DefaultFutureQuotationServerIndex := QuotationNode.ChildNodes['FuturesServer'].Attributes['Default'];
  for I := 0 to count - 1 do
  begin
    tempnode := QuotationNode.ChildNodes['FuturesServer'].ChildNodes[I];
    New(tempfuturequotationserver);
    tempfuturequotationserver.sName := tempnode.Attributes['Name'];
    tempfuturequotationserver.sServer := tempnode.Attributes['Server'];

    FutureQuotationServerList.AddObject(tempfuturequotationserver.sName, Pointer(tempfuturequotationserver));
  end;
  //{Account}导入账户列表
  AccountNode := RootNode.ChildNodes['account'];
  //期货账户
  count := AccountNode.ChildNodes['FuturesAccount'].ChildNodes.Count;
  DefaultAccountIndex := AccountNode.ChildNodes['FuturesAccount'].Attributes['Default'];
  for I := 0 to count - 1 do
  begin
    tempnode := AccountNode.ChildNodes['FuturesAccount'].ChildNodes[I];
    New(tempaccount);
    tempaccount.sName := tempnode.Attributes['Name'];
    tempaccount.sAccount := tempnode.Attributes['Account'];
    tempaccount.sPassword := tempnode.Attributes['PassWord'];
    tempaccount.sAuthCode := tempnode.Attributes['AuthCode'];
    tempaccount.sAppid := tempnode.Attributes['AppID'];

    AccountList.AddObject(tempaccount.sName, Pointer(tempaccount));
  end;

  iXMLAreaFile.Active := False;  
end;

end.

