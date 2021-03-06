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
    iPort: Integer;
    sBrokerID: string;
  end;

  FQuotationServerStruct = record
    sName: string;
    sServer: string;
    iPort: Integer;
    sAccount: string;
    sPassword: string;
  end;

  PAccountStruct = ^FAccountStruct;

  PTradeServerStruct = ^FTradeServerStruct;

  PQuotationServerStruct = ^FQuotationServerStruct;

var
  iXMLAreaFile: IXMLDocument;
  TradeDefaultAccount: PAccountStruct;

  //期货交易服务
  FutureTradeServerList: TStringList;
  DefaultFutureTradeServerIndex: Integer;
  //期权交易服务
  OptionTradeServerList: TStringList;
  DefaultOptionTradeServerIndex: Integer;
  //现货交易服务
  ActualsTradeServerList: TStringList;
  DefaultActualsTradeServerIndex: Integer;
  //期货行情服务
  FutureQuotationServerList: TStringList;
  DefaultFutureQuotationServerIndex: Integer;
  //期权行情服务
  OptionQuotationServerList: TStringLIst;
  DefaultOptionQuotationServerIndex: Integer;
  //现货行情服务
  ActualsQuotationServerList: TStringList;
  DefaultActualsQuotationServerIndex: Integer;
  //期货交易账户
  FuturesAccountList: TStringList;
  DefaultFuturesAccountIndex: Integer;
  //期权交易账户
  OptionAccountList: TStringList;
  DefaultOptionAccountIndex: Integer;
  //现货交易账户
  ActualsAccountList: TStringList;
  DefaultActualsAccountIndex: Integer;
  //dllName
  FuturesdllName: string;
  OptiondllName: string;
  OptionsTradeDllName: string;
  ActualsdllName: string;
  ActualsTradeDllName: string;

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
  pQuotationserverData: PQuotationServerStruct;
  temptradeserver: PTradeServerStruct;
begin
  FuturesdllName := 'QuotationAndTraderCTP.dll';
  ActualsTradeDllName := 'QuotationAndTraderCTP.dll';
  OptionsTradeDllName := 'QuotationAndTraderCTP.dll';
  OptiondllName := 'libdfapi.dll';
  ActualsdllName := 'JGDFDAPI.dll';
  iXMLAreaFile := TXMLDocument.Create(nil);
  WorkPath := ExtractFilePath(application.exename);
  iXMLAreaFile.FileName := WorkPath + 'config\config.xml';
  iXMLAreaFile.active := True;
  RootNode := iXMLAreaFile.DocumentElement;
  //创建列表
  FuturesAccountList := TStringList.Create;
  FutureQuotationServerList := TStringList.Create;
  FutureTradeServerList := TStringList.Create;

  OptionAccountList := TStringList.Create;
  OptionQuotationServerList := TStringList.Create;
  OptionTradeServerList := TStringList.Create;

  ActualsAccountList := TStringList.Create;
  ActualsQuotationServerList := TStringList.Create;
  ActualsTradeServerList := TStringList.Create;
  
  //{Trade}导入交易服务列表
  TradeNode := RootNode.ChildNodes['trade'];
  //期货交易服务
  count := TradeNode.ChildNodes['FuturesServer'].ChildNodes.Count;
  DefaultFutureTradeServerIndex := TradeNode.ChildNodes['FuturesServer'].Attributes['Default'];
  for I := 0 to count - 1 do
  begin
    tempnode := TradeNode.ChildNodes['FuturesServer'].ChildNodes[I];
    New(temptradeserver);
    temptradeserver.sName := tempnode.Attributes['Name'];
    temptradeserver.sServer := tempnode.Attributes['Server'];
    temptradeserver.sBrokerID := tempnode.Attributes['BrokerID'];

    FutureTradeServerList.AddObject(temptradeserver.sName, Pointer(temptradeserver));
  end;
  //期权交易
  count := TradeNode.ChildNodes['OptionServer'].ChildNodes.Count;
  DefaultOptionQuotationServerIndex := TradeNode.ChildNodes['OptionServer'].Attributes['Default'];
  for I := 0 to count - 1 do
  begin
    tempnode := TradeNode.ChildNodes['OptionServer'].ChildNodes[I];
    New(temptradeserver);
    temptradeserver.sName := tempnode.Attributes['Name'];
    temptradeserver.sServer := tempnode.Attributes['Server'];
    temptradeserver.iPort := StrToInt(tempnode.Attributes['Port']);

    OptionTradeServerList.AddObject(temptradeserver.sName, Pointer(temptradeserver));
  end;
  //现货交易服务
  count := TradeNode.ChildNodes['ActualsServer'].ChildNodes.Count;
  DefaultActualsQuotationServerIndex := TradeNode.ChildNodes['ActualsServer'].Attributes['Default'];
  for I := 0 to count - 1 do
  begin
    tempnode := TradeNode.ChildNodes['ActualsServer'].ChildNodes[I];
    New(temptradeserver);
    temptradeserver.sName := tempnode.Attributes['Name'];
    temptradeserver.sServer := tempnode.Attributes['Server'];
    temptradeserver.iPort := StrToInt(tempnode.Attributes['Port']);

    ActualsTradeServerList.AddObject(temptradeserver.sName, Pointer(temptradeserver));
  end;

  //{Quotation}导入行情服务列表
  QuotationNode := RootNode.ChildNodes['quotation'];
  //期货行情服务
  count := QuotationNode.ChildNodes['FuturesServer'].ChildNodes.Count;
  DefaultFutureQuotationServerIndex := QuotationNode.ChildNodes['FuturesServer'].Attributes['Default'];
  for I := 0 to count - 1 do
  begin
    tempnode := QuotationNode.ChildNodes['FuturesServer'].ChildNodes[I];
    New(pQuotationserverData);
    pQuotationserverData.sName := tempnode.Attributes['Name'];
    pQuotationserverData.sServer := tempnode.Attributes['Server'];
    FutureQuotationServerList.AddObject(pQuotationserverData.sName, Pointer(pQuotationserverData));
  end;
  //期权行情服务
  count := QuotationNode.ChildNodes['OptionServer'].ChildNodes.Count;
  DefaultOptionQuotationServerIndex := QuotationNode.ChildNodes['OptionServer'].Attributes['Default'];
  for I := 0 to count - 1 do
  begin
    tempnode := QuotationNode.ChildNodes['OptionServer'].ChildNodes[I];
    New(pQuotationserverData);
    pQuotationserverData.sName := tempnode.Attributes['Name'];
    pQuotationserverData.sServer := tempnode.Attributes['Server'];
    pQuotationserverData.iPort := tempnode.Attributes['Port'];
    pQuotationserverData.sAccount := tempnode.Attributes['Account'];
    pQuotationserverData.sPassword := tempnode.Attributes['Password'];
    OptionQuotationServerList.AddObject(pQuotationserverData.sName, Pointer(pQuotationserverData));
  end;
  //现货行情服务
  count := QuotationNode.ChildNodes['ActualsServer'].ChildNodes.Count;
  DefaultActualsQuotationServerIndex := QuotationNode.ChildNodes['ActualsServer'].Attributes['Default'];
  for I := 0 to count - 1 do
  begin
    tempnode := QuotationNode.ChildNodes['ActualsServer'].ChildNodes[I];
    New(pQuotationserverData);
    pQuotationserverData.sName := tempnode.Attributes['Name'];
    pQuotationserverData.sServer := tempnode.Attributes['Server'];
    pQuotationserverData.iPort := tempnode.Attributes['Port'];
    ActualsQuotationServerList.AddObject(pQuotationserverData.sName, Pointer(pQuotationserverData));
  end;

  //{Account}导入账户列表
  AccountNode := RootNode.ChildNodes['account'];
  //期货账户
  count := AccountNode.ChildNodes['FuturesAccount'].ChildNodes.Count;
  DefaultFuturesAccountIndex := AccountNode.ChildNodes['FuturesAccount'].Attributes['Default'];
  for I := 0 to count - 1 do
  begin
    tempnode := AccountNode.ChildNodes['FuturesAccount'].ChildNodes[I];
    New(tempaccount);
    tempaccount.sName := tempnode.Attributes['Name'];
    tempaccount.sAccount := tempnode.Attributes['Account'];
    tempaccount.sPassword := tempnode.Attributes['PassWord'];
    tempaccount.sAuthCode := tempnode.Attributes['AuthCode'];
    tempaccount.sAppid := tempnode.Attributes['AppID'];

    FuturesAccountList.AddObject(tempaccount.sName, Pointer(tempaccount));
  end;
  //期权账户
  count := AccountNode.ChildNodes['OptionAccount'].ChildNodes.Count;
  DefaultOptionAccountIndex := AccountNode.ChildNodes['OptionAccount'].Attributes['Default'];
  for I := 0 to count - 1 do
  begin
    tempnode := AccountNode.ChildNodes['OptionAccount'].ChildNodes[I];
    New(tempaccount);
    tempaccount.sName := tempnode.Attributes['Name'];
    tempaccount.sAccount := tempnode.Attributes['Account'];
    tempaccount.sPassword := tempnode.Attributes['PassWord'];
    OptionAccountList.AddObject(tempaccount.sName, Pointer(tempaccount));
  end;
  //现货账户
  count := AccountNode.ChildNodes['ActualsAccount'].ChildNodes.Count;
  DefaultActualsAccountIndex := AccountNode.ChildNodes['ActualsAccount'].Attributes['Default'];
  for I := 0 to count - 1 do
  begin
    tempnode := AccountNode.ChildNodes['ActualsAccount'].ChildNodes[I];
    New(tempaccount);
    tempaccount.sName := tempnode.Attributes['Name'];
    tempaccount.sAccount := tempnode.Attributes['Account'];
    tempaccount.sPassword := tempnode.Attributes['PassWord'];
    ActualsAccountList.AddObject(tempaccount.sName, Pointer(tempaccount));
  end;

  iXMLAreaFile.Active := False;
end;

procedure DestroyConfiguration();
begin
  FuturesAccountList.Destroy;
  FutureQuotationServerList.Destroy;
  FutureTradeServerList.Destroy;
  OptionAccountList.Destroy;
  OptionQuotationServerList.Destroy;
  OptionTradeServerList.Destroy;
  ActualsAccountList.Destroy;
  ActualsQuotationServerList.Destroy;
  ActualsTradeServerList.Destroy;
end;

end.

