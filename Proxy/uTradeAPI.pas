unit uTradeAPI;

interface

uses
  uDataStruct, Windows, uConstants, Classes, SysUtils, SyncObjs, uDrawView,
  Forms;

type
{期货}
  //创建交易服务
  TCreateTradeServer = function(psFrontAddress: PChar; mdflowpath: PChar): Pointer; cdecl;

  //登录交易
  TAutoAuthAndLoginTradeServer = function(server: Pointer; BrokerID: PChar; UserID: PChar; Password: PChar; AuthCode: PChar; AppID: PChar): Integer; cdecl;

  //报单
  TInputLimitPriceOrder = function(server: Pointer; InstrumentID: PChar; Direction: Char; OffsetFlag: Char; LimitPrice: Double; count: Integer): Integer; cdecl;

  //查询持仓
  TQueryPosition = function(server: Pointer): Integer; cdecl;

  //撤单
  TCancelOrder = function(server: Pointer; InstrumentID: PChar; ExchangeID: PChar; OrderSysID: PChar): Integer; cdecl;

  //查询账户资金
  TCheckAccountField = function(server: Pointer): Integer; cdecl;

  //查询已提交报单
  TQueryOrder = function(server: Pointer): Integer; cdecl;

  //查询以成交
  TQueryTradeSuccess = function(server: Pointer): Integer; cdecl;

  //回调函数绑定
  TBindFunctions = procedure(server: Pointer; fun: Pointer); cdecl;

  TisLogin = function(server: Pointer): Boolean; cdecl;

  {期权}
  //创建
  TOptionCreateTradeServer = function(): Pointer; cdecl;

  	//连接
  TOptionConnnect = function(server: Pointer; const pszAddress: PChar; uPort: SmallInt): Integer; cdecl;

  	//登录
  TOptionLogin = function(server: Pointer; const account: PChar; const strPassword: PChar): Integer; cdecl;

  	//报单
  TOptionOrderInster = function(server: Pointer; code: PChar; ExchangeType: Integer; OffsetType: Char; TradeType: Integer; OrderVolume: Int64; PriceType: Integer; OrderPrice: Int64): Integer; cdecl;

  	//撤单
  TOptionOrderCancel = function(server: Pointer; const strEntrustNo: PChar; nExchangeType: Integer): Integer; cdecl;

  	//绑定回调
  TOptionBindFunctions = procedure(server: Pointer; fun: Pointer); cdecl;

  	//委托查询
  TOptionQryOrder = function(server: Pointer): Integer; cdecl;

  	//成交查询
  TOptionQryTrade = function(server: Pointer): Integer; cdecl;

  	//持仓查询
  TOptionQryHold = function(server: Pointer): Integer; cdecl;

  	//资金查询
  TOptionQryFund = function(server: Pointer): Integer; cdecl;

  	//可撤单查询
  TOptionQryCancel = function(server: Pointer): Integer; cdecl;

  	//释放
  TOptionFreeServer = function(server: Pointer): Integer; cdecl;

  	//连接状态
  TOptionLoginStatus = function(server: Pointer): Boolean; cdecl;

  	//登录状态
  TOptionConnectStatus = function(server: Pointer): Boolean; cdecl;
 
  {现货}
  	//创建
  TActualsCreateTradeServer = function(): Pointer; cdecl;
  	//连接

  TActualsConnnect = function(server: Pointer; const pszAddress: PChar; uPort: SmallInt): Integer; cdecl;
  	//登录

  TActualsLogin = function(server: Pointer; const account: PChar; const strPassword: PChar): Integer; cdecl;
  	//报单

  TActualsOrderInster = function(server: Pointer; code: PChar; ExchangeType: Integer; TradeType: Integer; OrderVolume: Int64; PriceType: Integer; OrderPrice: Int64): Integer; cdecl;
  	//撤单

  TActualsOrderCancel = function(server: Pointer; const strEntrustNo: PChar; nExchangeType: Integer): Integer; cdecl;
  	//绑定回调

  TActualsBindFunctions = procedure(server: Pointer; fun: Pointer); cdecl;
  	//委托查询

  TActualsQryOrder = function(server: Pointer): Integer; cdecl;
  	//成交查询

  TActualsQryTrade = function(server: Pointer): Integer; cdecl;
  	//持仓查询

  TActualsQryHold = function(server: Pointer): Integer; cdecl;
  	//资金查询

  TActualsQryFund = function(server: Pointer): Integer; cdecl;
  	//可撤单查询

  TActualsQryCancel = function(server: Pointer): Integer; cdecl;
  	//释放

  TActualsFreeServer = function(server: Pointer): Integer; cdecl;
  	//连接状态

  TActualsLoginStatus = function(server: Pointer): Boolean; cdecl;
  	//登录状态

  TActualsConnectStatus = function(server: Pointer): Boolean; cdecl;


  //DLL封装类
  TFuturesTradeProxy = class(TThread)
  private
    handle: Integer;
    //通信服务
    server: Pointer;
    //线程安全锁
    CriticalSection: TCriticalSection;
    myMutex: HWND;
    {函数指针声明}
    createtradeserver: TCreateTradeServer;
    autoauthandlogintradeserver: TAutoAuthAndLoginTradeServer;
    inputlimitpriceorder: TInputLimitPriceOrder;
    queryposition: TQueryPosition;
    cancelorder: TCancelOrder;
    checkaccountfield: TCheckAccountField;
    queryorder: TQueryOrder;
    querytradesuccess: TQueryTradeSuccess;
    bindfunstions: TBindFunctions;
    loginstatus: TisLogin;
  public
    free: Boolean;
    function isLogin(): Boolean;
    constructor Create(key: string);
    procedure Connected(psFrontAddress: PChar; mdflowpath: PChar);
    procedure AuthAndLogin(BrokerID: PChar; UserID: PChar; Password: PChar; AuthCode: PChar; AppID: PChar);
    procedure AddLimitPriceOrder(InstrumentID: PChar; Direction: Char; OffsetFlag: Char; LimitPrice: Double; count: Integer);
    function RequestCheckPosition(): Integer;
    function DeleteOrder(InstrumentID: PChar; ExchangeID: PChar; OrderSysID: PChar): Integer;
    function CheckCapital(): Integer;
    function RequestCheckOrder(): Integer;
    function RequestSucessedOrder(): Integer;
    procedure BindFun(fun: Pointer);
    procedure waitFree(dwMilliseconds: DWORD);
    procedure Execute(); override;
  end;

   {期权DLL封装类}
  TOptionTradeProxy = class
  private
    handle: Integer;
     //通信服务
    server: Pointer;
     //线程安全锁
    CriticalSection: TCriticalSection;
    myMutex: HWND;
     {函数指针声明}
    optioncreatetradeserver: TOptionCreateTradeServer;
    optionconnnect: TOptionConnnect;
    optionlogin: TOptionLogin;
    optionorderinster: TOptionOrderInster;
    optionordercancel: TOptionOrderCancel;
    optionbindfunctions: TOptionBindFunctions;
    optionqryorder: TOptionQryOrder;
    optionqrytrade: TOptionQryTrade;
    optionqryhold: TOptionQryHold;
    optionqryfund: TOptionQryFund;
    optionqrycancel: TOptionQryCancel;
    optionfreeserver: TOptionFreeServer;
    optionloginstatus: TOptionLoginStatus;
    optionconnectstatus: TOptionConnectStatus;
  public
    constructor Create(key: string);
    function isLogin(): Boolean;
    function isConnected(): Boolean;
    function CreateTradeServer(): Pointer;
    function Connnect(const pszAddress: PChar; uPort: SmallInt): Integer;
    function Login(const account: PChar; const strPassword: PChar): Integer;
    function OrderInster(code: PChar; ExchangeType: Integer; OffsetType: Char; TradeType: Integer; OrderVolume: Int64; PriceType: Integer; OrderPrice: Int64): Integer;
    function OrderCancel(const strEntrustNo: PChar; nExchangeType: Integer): Integer;
    procedure BindFunctions(fun: Pointer);
    function QryOrder(): Integer;
    function QryTrader(): Integer;
    function QryHold(): Integer;
    function QryFund(): Integer;
    function QryCancel(): Integer;
    function FreeServer(): Integer;
  end;
   {现货DLL封装类}

  TActualsTradeProxy = class
  private
    handle: Integer;
     //通信服务
    server: Pointer;
     //线程安全锁
    CriticalSection: TCriticalSection;
    myMutex: HWND;
     {函数指针声明}
    actualscreatetradeserver: TActualsCreateTradeServer;
    actualsconnnect: TActualsConnnect;
    actualslogin: TActualsLogin;
    actualsorderinster: TActualsOrderInster;
    actualsordercancel: TActualsOrderCancel;
    actualsbindfunctions: TActualsBindFunctions;
    actualsqryorder: TActualsQryOrder;
    actualsqrytrade: TActualsQryTrade;
    actualsqryhold: TActualsQryHold;
    actualsqryfund: TActualsQryFund;
    actualsqrycancel: TActualsQryCancel;
    actualsfreeserver: TActualsFreeServer;
    actualsloginstatus: TActualsLoginStatus;
    actualsconnectstatus: TActualsConnectStatus;
  public
    constructor Create(key: string);
    function isLogin(): Boolean;
    function isConnected(): Boolean;
    function CreateTradeServer(): Pointer;
    function Connnect(const pszAddress: PChar; uPort: SmallInt): Integer;
    function Login(const account: PChar; const strPassword: PChar): Integer;
    function OrderInster(code: PChar; ExchangeType: Integer; TradeType: Integer; OrderVolume: Int64; PriceType: Integer; OrderPrice: Int64): Integer;
    function OrderCancel(const strEntrustNo: PChar; nExchangeType: Integer): Integer;
    procedure BindFunctions(fun: Pointer);
    function QryOrder(): Integer;
    function QryTrader(): Integer;
    function QryHold(): Integer;
    function QryFund(): Integer;
    function QryCancel(): Integer;
    function FreeServer(): Integer;
  end;

//procedure OnfillingPositionData(Adata: CThostFtdcInvestorPositionField); cdecl;
//
//procedure OnOrderChange(Adata: CThostFtdcOrderField); cdecl;
//
//
//procedure OnAccountCapital(Adata: CThostFtdcTradingAccountField); cdecl;

//var
//  criticalsection: TCriticalSection;

implementation

uses
  MainWIN, ComCtrls, uDataCenter, uGlobalInstance, uTradeResponse;

procedure TFuturesTradeProxy.waitFree(dwMilliseconds: DWORD);//Longint
var
  iStart, iStop: DWORD;
begin
  iStart := GetTickCount;
  repeat
    iStop := GetTickCount;
    Application.ProcessMessages;
  until free or ((iStop - iStart) >= dwMilliseconds);
end;

constructor TFuturesTradeProxy.Create(key: string);
begin
  inherited Create(False);
  handle := LoadLibrary(PChar(key));
  free := True;
  CriticalSection := TCriticalSection.Create();
  createtradeserver := GetProcAddress(Self.handle, PChar(CREATE_TRADE_SERVER));
  autoauthandlogintradeserver := GetProcAddress(Self.handle, PChar(AUTO_AUTH_AND_LOGINTRADE_SERVER));
  inputlimitpriceorder := GetProcAddress(Self.handle, PChar(INPUT_LIMIT_PRICE_ORDER));
  queryposition := GetProcAddress(Self.handle, PChar(QUERY_POSITION));
  cancelorder := GetProcAddress(Self.handle, PChar(CANCEL_ORDER));
  checkaccountfield := GetProcAddress(Self.handle, PChar(CHECKA_CCOUNT_FIELD));
  queryorder := GetProcAddress(Self.handle, PChar(QUERY_ORDER));
  querytradesuccess := GetProcAddress(Self.handle, PChar(QUERY_TRADE_SUCCESS));
  bindfunstions := GetProcAddress(Self.handle, PChar(BIND_FUNCTIONS));
  loginstatus := GetProcAddress(Self.handle, PChar('isLogin'));
end;

procedure TFuturesTradeProxy.Connected(psFrontAddress: PChar; mdflowpath: PChar);
begin
  server := createtradeserver(psFrontAddress, mdflowpath);
  BindFun(@OnResponseFunction);
end;

procedure TFuturesTradeProxy.AuthAndLogin(BrokerID: PChar; UserID: PChar; Password: PChar; AuthCode: PChar; AppID: PChar);
begin
  autoauthandlogintradeserver(server, BrokerID, UserID, Password, AuthCode, AppID);
  Delay(1000);
end;

procedure TFuturesTradeProxy.AddLimitPriceOrder(InstrumentID: PChar; Direction: Char; OffsetFlag: Char; LimitPrice: Double; count: Integer);
begin
  inputlimitpriceorder(server, InstrumentID, Direction, OffsetFlag, LimitPrice, count);
end;

function TFuturesTradeProxy.DeleteOrder(InstrumentID: PChar; ExchangeID: PChar; OrderSysID: PChar): Integer;
begin
  Result := cancelorder(server, InstrumentID, ExchangeID, OrderSysID);
  TDrawView.instance.log('DeleteOrder:Return' + IntToStr(Result), $001AFF00, '[DEBUG]');
end;

function TFuturesTradeProxy.RequestCheckPosition(): Integer;
begin
  waitFree(5000);
  free := False;
  Result := queryposition(server);
//  TDrawView.instance.log('RequestCheckPosition:Return' + IntToStr(Result), $001AFF00, '[DEBUG]');

end;

function TFuturesTradeProxy.CheckCapital(): Integer;
begin

//  TDrawView.instance.log('CheckCapital:' + ':waitBefor', MainWindow.Richedit1);
  waitFree(5000);
//  TDrawView.instance.log('CheckCapital:' + ':waitAfter', MainWindow.Richedit1);

  free := False;
  Result := checkaccountfield(server);
//  TDrawView.instance.log('CheckCapital:Return' + IntToStr(Result));

end;

function TFuturesTradeProxy.RequestCheckOrder(): Integer;
begin
  waitFree(5000);
  free := False;
  Result := queryorder(server);
//  TDrawView.instance.log('RequestCheckOrder:Return' + IntToStr(Result));

end;

function TFuturesTradeProxy.RequestSucessedOrder(): Integer;
begin
  waitFree(5000);
  free := False;
  Result := querytradesuccess(server);
//  TDrawView.instance.log('RequestSucessedOrder:Return' + IntToStr(Result));
end;

function TFuturesTradeProxy.isLogin: Boolean;
begin
  Result := loginstatus(server);
end;

procedure TFuturesTradeProxy.BindFun(fun: Pointer);
begin
  bindfunstions(server, fun);
end;

//线程运行
procedure TFuturesTradeProxy.Execute;
begin
  inherited;
  repeat
    Sleep(5000);
//    TDrawView.instance.log('reflash:' + ':before', nil);
    Self.CheckCapital;
    Self.RequestCheckPosition;
//    Self.RequestCheckOrder;
//    Self.RequestSucessedOrder;
//    TDrawView.instance.log('reflash:' + ':after', nil);
//    TDrawView.instance.log('交易数据同步', InfoColor, 'PAT');
  until Terminated;

end;

{ TOptionTradeProxy }

procedure TOptionTradeProxy.BindFunctions(fun: Pointer);
begin
  optionbindfunctions(server, fun);
end;

function TOptionTradeProxy.Connnect(const pszAddress: PChar; uPort: SmallInt): Integer;
begin
  Result := optionconnnect(server, pszAddress, uPort);
end;

constructor TOptionTradeProxy.Create(key: string);
begin
  handle := LoadLibrary(PChar(key));
  CriticalSection := TCriticalSection.Create();
  optioncreatetradeserver := GetProcAddress(Self.handle, PChar('OptionCreateTradeServer'));
  optionconnnect := GetProcAddress(Self.handle, PChar('OptionConnnect'));
  optionlogin := GetProcAddress(Self.handle, PChar('OptionLogin'));
  optionorderinster := GetProcAddress(Self.handle, PChar('OptionOrderInster'));
  optionordercancel := GetProcAddress(Self.handle, PChar('OptionOrderCancel'));
  optionbindfunctions := GetProcAddress(Self.handle, PChar('OptionBindFunctions'));
  optionqryorder := GetProcAddress(Self.handle, PChar('OptionQryOrder'));
  optionqrytrade := GetProcAddress(Self.handle, PChar('OptionQryTrade'));
  optionqryhold := GetProcAddress(Self.handle, PChar('OptionQryHold'));
  optionqryfund := GetProcAddress(Self.handle, PChar('OptionQryFund'));
  optionqrycancel := GetProcAddress(Self.handle, PChar('OptionQryCancel'));
  optionfreeserver := GetProcAddress(Self.handle, PChar('OptionFreeServer'));
  optionloginstatus := GetProcAddress(Self.handle, PChar('OptionLoginStatus'));
  optionconnectstatus := GetProcAddress(Self.handle, PChar('OptionConnectStatus'));
end;

function TOptionTradeProxy.CreateTradeServer: Pointer;
begin
  server := optioncreatetradeserver();
  BindFunctions(@OptionOnResponseFunction);
  Result := server;
end;

function TOptionTradeProxy.FreeServer: Integer;
begin
  Result := optionfreeserver(server);
end;

function TOptionTradeProxy.isConnected: Boolean;
begin
  Result := optionconnectstatus(server);
end;

function TOptionTradeProxy.isLogin: Boolean;
begin
  Result := optionloginstatus(server);
end;

function TOptionTradeProxy.Login(const account, strPassword: PChar): Integer;
begin
  Result := optionlogin(server, account, strPassword);
end;

function TOptionTradeProxy.OrderCancel(const strEntrustNo: PChar; nExchangeType: Integer): Integer;
begin
  Result := optionordercancel(server, strEntrustNo, nExchangeType);
end;

function TOptionTradeProxy.OrderInster(code: PChar; ExchangeType: Integer; OffsetType: Char; TradeType: Integer; OrderVolume: Int64; PriceType: Integer; OrderPrice: Int64): Integer;
begin
  Result := optionorderinster(server, code, ExchangeType, OffsetType, TradeType, OrderVolume, PriceType, OrderPrice);
end;

function TOptionTradeProxy.QryCancel: Integer;
begin
  Result := optionqrycancel(server);
end;

function TOptionTradeProxy.QryFund: Integer;
begin
  result := optionqryfund(server);
end;

function TOptionTradeProxy.QryHold: Integer;
begin
  result := optionqryhold(server);

end;

function TOptionTradeProxy.QryOrder: Integer;
begin
  result := optionqryorder(server);

end;

function TOptionTradeProxy.QryTrader: Integer;
begin
  result := optionqrytrade(server);

end;

{ TActualsTradeProxy }

procedure TActualsTradeProxy.BindFunctions(fun: Pointer);
begin
  actualsbindfunctions(server, fun);
end;

function TActualsTradeProxy.Connnect(const pszAddress: PChar; uPort: SmallInt): Integer;
begin
  Result := actualsconnnect(server, pszAddress, uPort);
end;

constructor TActualsTradeProxy.Create(key: string);
begin
  handle := LoadLibrary(PChar(key));
  CriticalSection := TCriticalSection.Create();
  actualscreatetradeserver := GetProcAddress(Self.handle, PChar('ActualsCreateTradeServer'));
  actualsconnnect := GetProcAddress(Self.handle, PChar('ActualsConnnect'));
  actualslogin := GetProcAddress(Self.handle, PChar('ActualsLogin'));
  actualsorderinster := GetProcAddress(Self.handle, PChar('ActualsOrderInster'));
  actualsordercancel := GetProcAddress(Self.handle, PChar('ActualsOrderCancel'));
  actualsbindfunctions := GetProcAddress(Self.handle, PChar('ActualsBindFunctions'));
  actualsqryorder := GetProcAddress(Self.handle, PChar('ActualsQryOrder'));
  actualsqrytrade := GetProcAddress(Self.handle, PChar('ActualsQryTrade'));
  actualsqryhold := GetProcAddress(Self.handle, PChar('ActualsQryHold'));
  actualsqryfund := GetProcAddress(Self.handle, PChar('ActualsQryFund'));
  actualsqrycancel := GetProcAddress(Self.handle, PChar('ActualsQryCancel'));
  actualsfreeserver := GetProcAddress(Self.handle, PChar('ActualsFreeServer'));
  actualsloginstatus := GetProcAddress(Self.handle, PChar('ActualsLoginStatus'));
  actualsconnectstatus := GetProcAddress(Self.handle, PChar('ActualsConnectStatus'));
end;

function TActualsTradeProxy.CreateTradeServer: Pointer;
begin
  server := actualscreatetradeserver();
  BindFunctions(@ActualsOnResponseFunction);
  Result := server;
end;

function TActualsTradeProxy.FreeServer: Integer;
begin
  Result := actualsfreeserver(server);
end;

function TActualsTradeProxy.isConnected: Boolean;
begin
  Result := actualsconnectstatus(server);
end;

function TActualsTradeProxy.isLogin: Boolean;
begin
  result := actualsloginstatus(server);
end;

function TActualsTradeProxy.Login(const account, strPassword: PChar): Integer;
begin
  result := actualslogin(server, account, strPassword);
end;

function TActualsTradeProxy.OrderCancel(const strEntrustNo: PChar; nExchangeType: Integer): Integer;
begin
  result := actualsordercancel(server, strEntrustNo, nExchangeType);
end;

function TActualsTradeProxy.OrderInster(code: PChar; ExchangeType: Integer; TradeType: Integer; OrderVolume: Int64; PriceType: Integer; OrderPrice: Int64): Integer;
begin
  OrderPrice := OrderPrice - (OrderPrice mod 100);
  result := actualsorderinster(server, code, ExchangeType, TradeType, OrderVolume, PriceType, OrderPrice);
end;

function TActualsTradeProxy.QryCancel: Integer;
begin
  Result := actualsqrycancel(server);
end;

function TActualsTradeProxy.QryFund: Integer;
begin
  Result := actualsqryfund(server);
end;

function TActualsTradeProxy.QryHold: Integer;
begin
  Result := actualsqryhold(server);
end;

function TActualsTradeProxy.QryOrder: Integer;
begin
  Result := actualsqryorder(server);
end;

function TActualsTradeProxy.QryTrader: Integer;
begin
  Result := actualsqrytrade(server);
end;

end.

