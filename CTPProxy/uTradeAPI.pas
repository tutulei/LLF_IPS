unit uTradeAPI;

interface

uses
  uDataStruct, Windows, uConstants, Classes, SysUtils, SyncObjs, uDrawView,
  Forms;

type

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

  //DLL封装类
  TTradeProxy = class(TThread)
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

//procedure OnfillingPositionData(Adata: CThostFtdcInvestorPositionField); stdcall;
//
//procedure OnOrderChange(Adata: CThostFtdcOrderField); stdcall;
//
//
//procedure OnAccountCapital(Adata: CThostFtdcTradingAccountField); stdcall;

//var
//  criticalsection: TCriticalSection;

implementation

uses
  MainWIN, ComCtrls, uDataCenter, uGlobalInstance, uTradeResponse;

procedure TTradeProxy.waitFree(dwMilliseconds: DWORD);//Longint
var
  iStart, iStop: DWORD;
begin
  iStart := GetTickCount;
  repeat
    iStop := GetTickCount;
    Application.ProcessMessages;
  until free or ((iStop - iStart) >= dwMilliseconds);
end;

constructor TTradeProxy.Create(key: string);
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
end;

procedure TTradeProxy.Connected(psFrontAddress: PChar; mdflowpath: PChar);
begin
  server := createtradeserver(psFrontAddress, mdflowpath);
  BindFun(@OnResponseFunction);
end;

procedure TTradeProxy.AuthAndLogin(BrokerID: PChar; UserID: PChar; Password: PChar; AuthCode: PChar; AppID: PChar);
begin
  autoauthandlogintradeserver(server, BrokerID, UserID, Password, AuthCode, AppID);
  Delay(1000);
end;

procedure TTradeProxy.AddLimitPriceOrder(InstrumentID: PChar; Direction: Char; OffsetFlag: Char; LimitPrice: Double; count: Integer);
begin
  inputlimitpriceorder(server, InstrumentID, Direction, OffsetFlag, LimitPrice, count);
end;

function TTradeProxy.DeleteOrder(InstrumentID: PChar; ExchangeID: PChar; OrderSysID: PChar): Integer;
begin
  Result := cancelorder(server, InstrumentID, ExchangeID, OrderSysID);
  TDrawView.instance.log('DeleteOrder:Return' + IntToStr(Result), $001AFF00, '[DEBUG]');
end;

function TTradeProxy.RequestCheckPosition(): Integer;
begin
  waitFree(5000);
  free := False;
  Result := queryposition(server);
//  TDrawView.instance.log('RequestCheckPosition:Return' + IntToStr(Result), $001AFF00, '[DEBUG]');

end;

function TTradeProxy.CheckCapital(): Integer;
begin

//  TDrawView.instance.log('CheckCapital:' + ':waitBefor', MainWindow.Richedit1);
  waitFree(5000);
//  TDrawView.instance.log('CheckCapital:' + ':waitAfter', MainWindow.Richedit1);

  free := False;
  Result := checkaccountfield(server);
//  TDrawView.instance.log('CheckCapital:Return' + IntToStr(Result));

end;

function TTradeProxy.RequestCheckOrder(): Integer;
begin
  waitFree(5000);
  free := False;
  Result := queryorder(server);
//  TDrawView.instance.log('RequestCheckOrder:Return' + IntToStr(Result));

end;

function TTradeProxy.RequestSucessedOrder(): Integer;
begin
  waitFree(5000);
  free := False;
  Result := querytradesuccess(server);
//  TDrawView.instance.log('RequestSucessedOrder:Return' + IntToStr(Result));
end;

function TTradeProxy.isLogin: Boolean;
begin
  Result := False;
  if (server <> nil) then
    Result := True;
end;

procedure TTradeProxy.BindFun(fun: Pointer);
begin
  bindfunstions(server, fun);
end;

//线程运行
procedure TTradeProxy.Execute;
begin
  inherited;
  repeat
    Sleep(5000);
//    TDrawView.instance.log('reflash:' + ':before', nil);
    Self.CheckCapital;
//    Self.RequestCheckPosition;
//    Self.RequestCheckOrder;
//    Self.RequestSucessedOrder;
//    TDrawView.instance.log('reflash:' + ':after', nil);
//    TDrawView.instance.log('交易数据同步', InfoColor, 'PAT');
  until Terminated;

end;

end.

