unit uTradeAPI;

interface

uses
  uQuotationDataStruct, Windows, uConstants, Classes, SysUtils;

type
  //创建交易服务
  TCreateTradeServer = function(psFrontAddress: PChar; mdflowpath: PChar): Pointer; cdecl;

  //登录交易
  TAutoAuthAndLoginTradeServer = function(server: Pointer; BrokerID: PChar; UserID: PChar; Password: PChar; AuthCode: PChar; AppID: PChar): Integer;

  //报单
  TInputLimitPriceOrder = function(server: Pointer; InstrumentID: PChar; Direction: Char; OffsetFlag: Char; LimitPrice: Double): Integer;

  //查询持仓
  TQueryPosition = function(server: Pointer): Pointer;

  //撤单
  TCancelOrder = function(server: Pointer; FrontID: Integer; SessionID: Integer; OrderRef: PChar): Integer;

  //查询账户资金
  TCheckAccountField = function(server: Pointer): Pointer;

  //查询已提交报单
  TQueryOrder = function(server: Pointer): Pointer;

  //查询以成交
  TQueryTradeSuccess = function(server: Pointer): Pointer;

  //DLL封装类
  TTradeProxy = class
  private
    handle: Integer;
    //通信服务
    server: Pointer;
    {函数指针声明}
    createtradeserver: TCreateTradeServer;
    autoauthandlogintradeserver: TAutoAuthAndLoginTradeServer;
    inputlimitpriceorder: TInputLimitPriceOrder;
    queryposition: TQueryPosition;
    cancelorder: TCancelOrder;
    checkaccountfield: TCheckAccountField;
    queryorder: TQueryOrder;
    querytradesuccess: TQueryTradeSuccess;
  public
    constructor Create(key: string);
    procedure Connected(psFrontAddress: PChar; mdflowpath: PChar);
    procedure AuthAndLogin(BrokerID: PChar; UserID: PChar; Password: PChar; AuthCode: PChar; AppID: PChar);
    procedure AddLimitPriceOrder(InstrumentID: PChar; Direction: Char; OffsetFlag: Char; LimitPrice: Double);
    function CheckPosition(): Pointer;
    function DeleteOrder(FrontID: Integer; SessionID: Integer; OrderRef: PChar): Integer;
    function CheckCapital(): Pointer;
    function GetOrder(): Pointer;
    function GetSucessedOrder(): Pointer;
  end;

implementation

constructor TTradeProxy.Create(key: string);
begin
  handle := LoadLibrary(PChar(key));
  createtradeserver := GetProcAddress(Self.handle, PChar(CREATE_TRADE_SERVER));
  autoauthandlogintradeserver := GetProcAddress(Self.handle, PChar(AUTO_AUTH_AND_LOGINTRADE_SERVER));
  inputlimitpriceorder := GetProcAddress(Self.handle, PChar(INPUT_LIMIT_PRICE_ORDER));
  queryposition := GetProcAddress(Self.handle, PChar(QUERY_POSITION));
  cancelorder := GetProcAddress(Self.handle, PChar(CANCEL_ORDER));
  checkaccountfield := GetProcAddress(Self.handle, PChar(CHECKA_CCOUNT_FIELD));
  queryorder := GetProcAddress(Self.handle, PChar(QUERY_ORDER));
  querytradesuccess := GetProcAddress(Self.handle, PChar(QUERY_TRADE_SUCCESS));
end;

procedure TTradeProxy.Connected(psFrontAddress: PChar; mdflowpath: PChar);
begin
  server := createtradeserver(psFrontAddress, mdflowpath);
end;

procedure TTradeProxy.AuthAndLogin(BrokerID: PChar; UserID: PChar; Password: PChar; AuthCode: PChar; AppID: PChar);
begin
  autoauthandlogintradeserver(server, BrokerID, UserID, Password, AuthCode, AppID);
end;

procedure TTradeProxy.AddLimitPriceOrder(InstrumentID: PChar; Direction: Char; OffsetFlag: Char; LimitPrice: Double);
begin
  inputlimitpriceorder(server, InstrumentID, Direction, OffsetFlag, LimitPrice);
end;

function TTradeProxy.CheckPosition(): Pointer;
begin
  Result := queryposition(server);
end;

function TTradeProxy.DeleteOrder(FrontID: Integer; SessionID: Integer; OrderRef: PChar): Integer;
begin
  Result := cancelorder(server, FrontID, SessionID, OrderRef);
end;

function TTradeProxy.CheckCapital(): Pointer;
begin
  Result := checkaccountfield(server);
end;

function TTradeProxy.GetOrder(): Pointer;
begin
  Result := queryorder(server);
end;

function TTradeProxy.GetSucessedOrder(): Pointer;
begin
  Result := querytradesuccess(server);
end;

end.

