unit uTradeAPI;

interface

uses
  uDataStruct, Windows, uConstants, Classes, SysUtils, SyncObjs, uDrawView;

type

  //创建交易服务
  TCreateTradeServer = function(psFrontAddress: PChar; mdflowpath: PChar): Pointer; cdecl;

  //登录交易
  TAutoAuthAndLoginTradeServer = function(server: Pointer; BrokerID: PChar; UserID: PChar; Password: PChar; AuthCode: PChar; AppID: PChar): Integer; cdecl;

  //报单
  TInputLimitPriceOrder = function(server: Pointer; InstrumentID: PChar; Direction: Char; OffsetFlag: Char; LimitPrice: Double; count: Integer): Integer; cdecl;

  //查询持仓
  TQueryPosition = procedure(server: Pointer); cdecl;

  //撤单
  TCancelOrder = function(server: Pointer; FrontID: Integer; SessionID: Integer; OrderRef: PChar): Integer; cdecl;

  //查询账户资金
  TCheckAccountField = procedure(server: Pointer); cdecl;

  //查询已提交报单
  TQueryOrder = function(server: Pointer): Pointer; cdecl;

  //查询以成交
  TQueryTradeSuccess = function(server: Pointer): Pointer; cdecl;

  //回调函数绑定
  TBindFunctions = procedure(server: Pointer; fun1: Pointer; fun2: Pointer; fun3: Pointer); cdecl;

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
    bindfunstions: TBindFunctions;
  public
    constructor Create(key: string);
    procedure Connected(psFrontAddress: PChar; mdflowpath: PChar);
    procedure AuthAndLogin(BrokerID: PChar; UserID: PChar; Password: PChar; AuthCode: PChar; AppID: PChar);
    procedure AddLimitPriceOrder(InstrumentID: PChar; Direction: Char; OffsetFlag: Char; LimitPrice: Double; count: Integer);
    procedure RequestCheckPosition();
    function DeleteOrder(FrontID: Integer; SessionID: Integer; OrderRef: PChar): Integer;
    procedure CheckCapital();
    function RequestCheckOrder(): Pointer;
    function GetSucessedOrder(): Pointer;
    procedure BindFun(fun1: Pointer; fun2: Pointer; fun3: Pointer);
  end;

procedure OnfillingPositionData(data: CThostFtdcInvestorPositionField); stdcall;

procedure OnOrderChange(data: CThostFtdcOrderField); stdcall;

function OrderTurnToTextString(data: CThostFtdcOrderField): TStrings;

procedure OnAccountCapital(data: CThostFtdcTradingAccountField); stdcall;

var
  criticalsection: TCriticalSection;

implementation

uses
  MainWIN, ComCtrls, uDataCenter;

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
  bindfunstions := GetProcAddress(Self.handle, PChar(BIND_FUNCTIONS));
end;

procedure TTradeProxy.Connected(psFrontAddress: PChar; mdflowpath: PChar);
begin
  server := createtradeserver(psFrontAddress, mdflowpath);
  BindFun(@OnfillingPositionData, @OnOrderChange, @OnAccountCapital);
end;

procedure TTradeProxy.AuthAndLogin(BrokerID: PChar; UserID: PChar; Password: PChar; AuthCode: PChar; AppID: PChar);
begin
  autoauthandlogintradeserver(server, BrokerID, UserID, Password, AuthCode, AppID);
end;

procedure TTradeProxy.AddLimitPriceOrder(InstrumentID: PChar; Direction: Char; OffsetFlag: Char; LimitPrice: Double; count: Integer);
begin
  inputlimitpriceorder(server, InstrumentID, Direction, OffsetFlag, LimitPrice, count);
end;

procedure TTradeProxy.RequestCheckPosition();
begin
  queryposition(server);

end;

function TTradeProxy.DeleteOrder(FrontID: Integer; SessionID: Integer; OrderRef: PChar): Integer;
begin
  Result := cancelorder(server, FrontID, SessionID, OrderRef);
end;

procedure TTradeProxy.CheckCapital();
begin
  checkaccountfield(server);
end;

function TTradeProxy.RequestCheckOrder(): Pointer;
begin
  Result := queryorder(server);
end;

function TTradeProxy.GetSucessedOrder(): Pointer;
begin
  Result := querytradesuccess(server);
end;

procedure TTradeProxy.BindFun(fun1: Pointer; fun2: Pointer; fun3: Pointer);
begin
  bindfunstions(server, fun1, fun2, fun3);
end;

procedure OnUIfillingPositionData();
begin
  Writeln('OnUIfillingPositionData');
end;

//回调函数-持仓数据更新
procedure OnfillingPositionData(data: CThostFtdcInvestorPositionField);
var
  hdle: Integer;
begin
  TPositionDataCenter.Instance.addItem(data.InstrumentID + '-' + data.PosiDirection, @data);
  //界面更新
  TDrawView.instance.RunSynchronize(TDrawView.instance.DrawPositionListView);
//    MessageBox(0, PChar('[OnfillingPositionData] run'+string(GetCurrentProcess)), 'Waring', IDOK);
end;

//回调函数 -资金情况
procedure OnAccountCapital(data: CThostFtdcTradingAccountField); stdcall;
var
  d: double;
begin
  TradingAccountField := data;
  d := TradingAccountField.Available;
  TDrawView.instance.RunSynchronize(TDrawView.instance.DrawAccountCapital);
end;


//回调函数-订单变化响应
procedure OnOrderChange(data: CThostFtdcOrderField); stdcall;
var
  topdata: CThostFtdcTradingAccountField;
begin
//  MessageBox(0, PChar(str), 'Waring', IDOK);
  TCommandWindowsDataCenter.instance.addStrings(OrderTurnToTextString(data));
  TDrawView.instance.RunSynchronize(TDrawView.instance.PushOrderToCommandWindows);
  //成交事件发生
  if ((data.OrderStatus = '0') or (data.OrderStatus = '1') or (data.OrderStatus = '2')) then
  begin
    tradeProxy.RequestCheckPosition();
    Sleep(1000);
  end;

//  if ((StrToInt(data.OrderStatus) < 3) then
//  begin
//    //同步初始化资金情况
//    topdata := CThostFtdcTradingAccountField(tradeProxy.CheckCapital()^);
//    MainWindow.TopGrid.Cells[0, 1] := FloatToStr(topdata.Available);
//    MainWindow.TopGrid.Cells[1, 1] := FloatToStr(topdata.WithdrawQuota);
//    MainWindow.TopGrid.Cells[2, 1] := FloatToStr(topdata.Reserve);
//    MainWindow.TopGrid.Cells[3, 1] := FloatToStr(topdata.Mortgage);
//    MainWindow.TopGrid.Cells[4, 1] := FloatToStr(topdata.Credit);
//    MainWindow.TopGrid.Cells[5, 1] := FloatToStr(topdata.PositionProfit);
//    MainWindow.TopGrid.Cells[6, 1] := FloatToStr(topdata.CloseProfit);
//    MainWindow.TopGrid.Cells[7, 1] := FloatToStr(topdata.CurrMargin);
//    MainWindow.TopGrid.Cells[8, 1] := FloatToStr(topdata.Interest);
//    MainWindow.TopGrid.Cells[9, 1] := FloatToStr(topdata.CloseProfit);
//    Sleep(1000);
//    //更新提交界面和持仓界面
//    tradeProxy.RequestCheckPosition();
//    Sleep(1000);
//  end;
//
//  //报单提交状态
//  case data.OrderSubmitStatus of
//    THOST_FTDC_OSS_InsertSubmitted:
//      begin
//      //更新已提交表的界面
//
//      end;
//    THOST_FTDC_OSS_CancelSubmitted:
//      begin
//
//      end;
//    THOST_FTDC_OSS_ModifySubmitted:
//      begin
//
//      end;
//    THOST_FTDC_OSS_Accepted:
//      begin
//
//      end;
//    THOST_FTDC_OSS_InsertRejected:
//      begin
//
//      end;
//    THOST_FTDC_OSS_CancelRejected:
//      begin
//
//      end;
//    THOST_FTDC_OSS_ModifyRejected:
//      begin
//
//      end;
//  end;

end;

function OrderTurnToTextString(data: CThostFtdcOrderField): TStrings;
var
  list: TStrings;
begin
  list := TStringList.Create();
  list.Add('[订单回调响应' + FloatToStr(data.SequenceNo) + ']: ');
  list.Add('    用户：');
  list.Add('    代码：' + data.InstrumentID);
  list.Add('    多空：' + getOrderDirectionString(data.Direction));
  list.Add('    开平：' + getOrderOffsetFlag(data.CombOffsetFlag[0]));
  list.Add('    价格：' + FloatToStr(data.LimitPrice));
  list.Add('    数量' + FloatToStr(data.VolumeTotalOriginal));
  list.Add('    状态：' + getOrderStatusMsg(data.OrderSubmitStatus, data.StatusMsg));
  list.Add('    报单时间：' + data.InsertDate + ' ' + data.InsertTime);
  list.Add('    报单价格条件：' + data.OrderPriceType);
  list.Add('    有效期类型' + data.TimeCondition);
  list.Add('    最小成交量' + FloatToStr(data.MinVolume));
  list.Add('    今天成交数量：' + FloatToStr(data.VolumeTraded));
  list.Add('    交易日：' + data.TradingDay);
  list.Add('    报单编号：' + data.OrderSysID);
  Result := list;
end;

end.

