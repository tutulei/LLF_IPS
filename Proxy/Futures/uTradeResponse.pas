unit uTradeResponse;
(*交易响应函数单元*)
(*
0	持仓回调	OnRspQryInvestorPosition
1	资金情况回调	OnRspQryTradingAccount
2	报单录入请求响应 OnRspOrderInsert
3	撤单操作请求响应	OnRspOrderAction
4	订单变动回调	OnRtnOrder
5	订单成交回调	 OnRtnTrade
6	报单查询回调	OnRspQryOrder
7	成交查询回调	OnRspQryTrade
//功能和23一样，暂不实现
8 	报单CTP拒绝响应	OnErrRtnOrderInsert
9	撤单CTP拒绝响应	 OnErrRtnOrderAction

响应成功后直接调用Painter更新界面
*)

interface

uses
  uTradeAPI, uDataStruct, Windows, Classes;


//type
//  PThostFtdcInvestorPositionField = ^CThostFtdcInvestorPositionField;

procedure OnResponseFunction(ASgin: Integer; AData: Pointer; AIsLast: Boolean); stdcall;

procedure OnRspQryInvestorPosition(Adata: PThostFtdcInvestorPositionField);

procedure OnRspQryTradingAccount(Adata: PThostFtdcTradingAccountField);

procedure OnRspOrderInsert(Adata: PThostFtdcInputOrderField);

procedure OnRspOrderAction(Adata: PThostFtdcRspInfoField);

procedure OnRtnOrder(Adata: PThostFtdcOrderField);

procedure OnRtnTrade(Adata: PThostFtdcTradeField);

procedure OnRspQryOrder(Adata: PThostFtdcOrderField);

procedure OnRspQryTrade(Adata: PThostFtdcTradeField);

//type
//  TRequestMessenger = class(TThread)
//  private
//    class var
//      ins: TRequestMessenger;
//  public
//    class function instance(): TRequestMessenger;
//    constructor Create(CreateSuspended: Boolean = False);
//    procedure Request(AMethod: TThreadMethod);
//    procedure Position();
//    procedure Capital();
//    procedure Order();
//    procedure SuccessOrder();
//  end;


//功能性函数
function OrderTurnToTextString(Adata: PThostFtdcOrderField): TStrings;

implementation

uses
  uDataCenter, uDrawView, uGlobalInstance, SysUtils, uConstants, DateUtils,
  MainWIN,Graphics;


(*
0	持仓回调	OnRspQryInvestorPosition
1	资金情况回调	OnRspQryTradingAccount
2	报单录入请求响应 OnRspOrderInsert
3	撤单操作请求响应	OnRspOrderAction
4	订单变动回调	OnRtnOrder
5	订单成交回调	 OnRtnTrade
6	报单查询回调	OnRspQryOrder
7	成交查询回调	OnRspQryTrade
//功能和23一样，暂不实现
8 	报单CTP拒绝响应	OnErrRtnOrderInsert
9	撤单CTP拒绝响应	 OnErrRtnOrderAction
*)
procedure OnResponseFunction(ASgin: Integer; AData: Pointer; AIsLast: Boolean);
begin
  case ASgin of
    0:
      OnRspQryInvestorPosition(AData);
    1:
      OnRspQryTradingAccount(AData);
    2:
      OnRspOrderInsert(AData);
    3:
      OnRspOrderAction(AData);
    4:
      OnRtnOrder(AData);
    5:
      OnRtnTrade(AData);
    6:
      OnRspQryOrder(AData);
    7:
      OnRspQryTrade(AData);
  end;
  if ((AIsLast) and ((ASgin < 2) or (ASgin > 5))) then
  begin
    Delay(1000);
    FFuturesTradeProxy.free := True;
  end;
end;

//持仓回调
procedure OnRspQryInvestorPosition(Adata: PThostFtdcInvestorPositionField);
var
  newData: PThostFtdcInvestorPositionField;
begin
  New(newData);
  Move(Adata^, newData^, Sizeof(CThostFtdcInvestorPositionField));
  //数据更新
//  TDrawView.instance.log('Position:' + newData.InstrumentID + '-' + newData.PosiDirection, DebugColor, 'DEUBG');
  TPositionDataCenter.Instance.addItem(newData.InstrumentID + '-' + newData.PosiDirection, newData);
  //界面更新
  TDrawView.instance.RunSynchronize(TDrawView.instance.DrawPositionListView);
//    MessageBox(0, PChar('[OnfillingPositionData] run'+string(GetCurrentProcess)), 'Waring', IDOK);
end;

//资金情况回调
procedure OnRspQryTradingAccount(Adata: PThostFtdcTradingAccountField);
var
  newData: PThostFtdcTradingAccountField;
begin
  New(newData);
  Move(Adata^, newData^, Sizeof(CThostFtdcTradingAccountField));
  //数据更新
  Move(newData^, TradingAccountField, Sizeof(CThostFtdcTradingAccountField));
//  TradingAccountField := newData;
  //界面更新
  TDrawView.instance.RunSynchronize(TDrawView.instance.DrawAccountCapital);
end;

//报单录入请求响应
procedure OnRspOrderInsert(Adata: PThostFtdcInputOrderField);
var
  newData: PThostFtdcInputOrderField;
begin
//  New(newData);
//  Move(Adata^, newData^, Sizeof(CThostFtdcInputOrderField));
//  TOrderLogDataCenter.instance.addError('[ERROR]'+ TimeToStr(Now) + ':' + Adata.InstrumentID + '//'+Adata.);
//  TDrawView.instance.RunSynchronize(TDrawView.instance.DrawErroLogView);
end;

//撤单操作请求响应
procedure OnRspOrderAction(Adata: PThostFtdcRspInfoField);
var
  newData: PThostFtdcInputOrderActionField;
begin
//  New(newData);
//  Move(Adata^, newData^, Sizeof(CThostFtdcInputOrderActionField));
  TDrawView.instance.log('OnRspOrderAction:' + Adata.ErrorMsg, clRed, 'ERROE');
end;

//订单变动回调
procedure OnRtnOrder(Adata: PThostFtdcOrderField);
var
  newData: PThostFtdcOrderField;
  index: Integer;
begin
  New(newData);
  Move(Adata^, newData^, Sizeof(CThostFtdcOrderField));

//  //日志数据更新
//  TCommandWindowsDataCenter.instance.addStrings(OrderTurnToTextString(newData));
  TOrderLogDataCenter.instance.addLog(newData);
//  //日志界面更新
  TDrawView.instance.RunSynchronize(TDrawView.instance.DrawLogView);
//  TDrawView.instance.RunSynchronize(TDrawView.instance.PushOrderToCommandWindows);
  {报单界面响应}
  if (Adata.OrderStatus <> THOST_FTDC_OST_Unknown) then
  begin
    //提交表刷新
    TOrderDataCenter.instance.addItem(newData.OrderSysID + '-' + newData.ExchangeID + '&' + newData.InsertTime, newData);
    TDrawView.instance.RunSynchronize(TDrawView.instance.DrawOrderView);
    //持仓刷新（平仓）
    if (newData.CombOffsetFlag[0] <> '0') then
    begin
      //信号量
    end;
  end;
//  TRequestMessenger.instance.Request(TRequestMessenger.instance.Order);
  {撤单}
  //已提交刷新（调用在上面报单那里）
  //平仓单撤单刷新（调用也在上面）

end;

//订单成交回调
procedure OnRtnTrade(Adata: PThostFtdcTradeField);
var
  newData: PThostFtdcTradeField;
begin
  New(newData);
  Move(Adata^, newData^, Sizeof(CThostFtdcTradeField));
  {待优化}
  //持仓更新（开仓时）
  if (newData.OffsetFlag = '0') then
  begin
    //信号量
  end;
  //数据更新
  TSuccessOrderDataCenter.instance.addItem(newData.TradeID, newData);
  //界面更新
  TDrawView.instance.RunSynchronize(TDrawView.instance.DrawSuccessOrderView);
end;

//报单查询回调
procedure OnRspQryOrder(Adata: PThostFtdcOrderField);
var
  newData: PThostFtdcOrderField;
begin
  New(newData);
  Move(Adata^, newData^, Sizeof(CThostFtdcOrderField));
  //数据更新
  TOrderDataCenter.instance.addItem(newData.OrderSysID + '-' + newData.ExchangeID + '&' + newData.InsertTime, newData);
  //界面更新
  TDrawView.instance.RunSynchronize(TDrawView.instance.DrawOrderView);
end;

//成交查询回调
procedure OnRspQryTrade(Adata: PThostFtdcTradeField);
var
  newData: PThostFtdcTradeField;
begin
  New(newData);
  Move(Adata^, newData^, Sizeof(CThostFtdcTradeField));
  //数据更新
  TSuccessOrderDataCenter.instance.addItem(newData.TradeID, newData);
  //界面更新
  TDrawView.instance.RunSynchronize(TDrawView.instance.DrawSuccessOrderView);
end;

function OrderTurnToTextString(Adata: PThostFtdcOrderField): TStrings;
var
  list: TStrings;
begin
  list := TStringList.Create();
  list.Add('[订单回调响应' + FloatToStr(Adata.SequenceNo) + ']: ');
  list.Add('    用户：');
  list.Add('    代码：' + Adata.InstrumentID);
  list.Add('    多空：' + getOrderDirectionString(Adata.Direction));
  list.Add('    开平：' + getOrderOffsetFlag(Adata.CombOffsetFlag[0]));
  list.Add('    价格：' + FloatToStr(Adata.LimitPrice));
  list.Add('    数量' + FloatToStr(Adata.VolumeTotalOriginal));
  list.Add('    状态：' + getOrderStatusMsg(Adata.OrderSubmitStatus, Adata.StatusMsg));
  list.Add('    报单时间：' + Adata.InsertDate + ' ' + Adata.InsertTime);
  list.Add('    报单价格条件：' + Adata.OrderPriceType);
  list.Add('    有效期类型' + Adata.TimeCondition);
  list.Add('    最小成交量' + FloatToStr(Adata.MinVolume));
  list.Add('    今天成交数量：' + FloatToStr(Adata.VolumeTraded));
  list.Add('    交易日：' + Adata.TradingDay);
  list.Add('    报单编号：' + Adata.OrderSysID);
  Result := list;
end;

{ TRequestMessenger }
//
//class function TRequestMessenger.instance: TRequestMessenger;
//begin
//  if (ins = nil) then
//  begin
//    ins := TRequestMessenger.Create(True);
//  end;
//  Result := ins;
//end;
//
//constructor TRequestMessenger.Create(CreateSuspended: Boolean = False);
//begin
//  inherited Create(CreateSuspended);
//end;
//
//procedure TRequestMessenger.Request(AMethod: TThreadMethod);
//begin
//  TDrawView.instance.log('Queue:' + ':before', nil);
//  Queue(nil, AMethod);
////  Synchronize(AMethod);
//  TDrawView.instance.log('Queue:' + ':after', nil);
//end;
//
//procedure TRequestMessenger.Capital;
//begin
//  FTradeProxy.CheckCapital();
//end;
//
//procedure TRequestMessenger.Order;
//begin
//  TDrawView.instance.log('QueueOrder:' + ':before', nil);
//  FTradeProxy.RequestCheckOrder();
//  TDrawView.instance.log('QueueOrder:' + ':after', nil);
//end;
//
//procedure TRequestMessenger.Position;
//begin
//  FTradeProxy.RequestCheckPosition();
//end;
//
//procedure TRequestMessenger.SuccessOrder;
//begin
//  FTradeProxy.RequestSucessedOrder();
//end;

end.

