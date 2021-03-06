unit uTradeResponse;
(*交易响应函数单元*)
(*
期货
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

{响应调度函数，需绑定}
procedure OnResponseFunction(ASgin: Integer; AData: Pointer; AIsLast: Boolean); stdcall;

 //期权
procedure OptionOnResponseFunction(ASgin: Integer; AData: Pointer; ACount: Integer); stdcall;

 //现货
procedure ActualsOnResponseFunction(ASgin: Integer; AData: Pointer; ACount: Integer); stdcall;


//type
//  PThostFtdcInvestorPositionField = ^CThostFtdcInvestorPositionField;
{期货交易响应}

procedure OnRspQryInvestorPosition(Adata: PThostFtdcInvestorPositionField);

procedure OnRspQryTradingAccount(Adata: PThostFtdcTradingAccountField);

procedure OnRspOrderInsert(Adata: PThostFtdcInputOrderField);

procedure OnRspOrderAction(Adata: PThostFtdcRspInfoField);

procedure OnRtnOrder(Adata: PThostFtdcOrderField);

procedure OnRtnTrade(Adata: PThostFtdcTradeField);

procedure OnRspQryOrder(Adata: PThostFtdcOrderField);

procedure OnRspQryTrade(Adata: PThostFtdcTradeField);

{期权交易}
//procedure OptionOnFrontConnected();
//
//procedure OptionOnFrontDisConnected();
//
//procedure OptionOnRspError(const strError: PChar);
//
//procedure OptionOnRspOptionUserLogin(pRspUserLogin: PCJGtdcRspUserLogin; pRspInfo: PCJGtdcRspInfoField; nRequestID: Integer);
//
//procedure OptionOnRspOptionUserLogout(pRspUserLogout: PCJGtdcRspUserLogout; pRspInfo: PCJGtdcRspInfoField; nRequestID: Integer);
//
//procedure OptionOnRspOptionEntrust(pRspEntrust: PCJGtdcOptionRspEntrust; pRspInfo: PCJGtdcRspInfoField; nRequestID: Integer);
//
//procedure OptionOnRspOptionCancel(pRspCancel: PCJGtdcOptionRspCancel; pRspInfo: PCJGtdcRspInfoField; nRequestID: Integer);
//
//procedure OptionOnRtnOptionOrder(pRspQryEntrust: PCJGtdcOptionRspQryEntrust; nItems: Integer);
//
//procedure OptionOnRtnOptionTrade(pRspQryBusByPos: PCJGtdcOptionRspQryBusByPos; nItems: Integer);
//
//procedure OptionOnRspOptionQryEntrust(pRspQryEntrust: PCJGtdcOptionRspQryEntrust; pRspInfo: PCJGtdcRspInfoField; nRequestID: Integer);
//
//procedure OptionOnRspOptionQryBusByPos(pRspQryBusByPos: PCJGtdcOptionRspQryBusByPos; pRspInfo: PCJGtdcRspInfoField; nRequestID: Integer);
//
//procedure OptionOnRspOptionQryHold(pRspQryQryHold: PCJGtdcOptionRspQryHold; pRspInfo: PCJGtdcRspInfoField; nRequestID: Integer);
//
//procedure OptionOnRspOptionQryFund(pRspQryFund: PCJGtdcOptionRspQryFund; pRspInfo: PCJGtdcRspInfoField; nRequestID: Integer);
//
//procedure OptionOnRspOptionQryRevocEnt(pRspQryRevocEnt: PCJGtdcOptionRspQryRevocEnt; pRspInfo: PCJGtdcRspInfoField; nRequestID: Integer);
procedure OnRspOptionEntrust(pRspEntrust: PCJGtdcOptionRspEntrust; ACount: Integer);

procedure OnRspOptionCancel(pRspCancel: PCJGtdcOptionRspCancel; ACount: Integer);

procedure OnRtnOptionOrder(pRspQryEntrust: PCJGtdcOptionRspQryEntrust; ACount: Integer);

procedure OnRtnOptionTrade(pRspQryBusByPos: PCJGtdcOptionRspQryBusByPos; ACount: Integer);

procedure OnRspOptionQryEntrust(pRspQryEntrust: PCJGtdcOptionRspQryEntrust; ACount: Integer);

procedure OnRspOptionQryBusByPos(pRspQryBusByPos: PCJGtdcOptionRspQryBusByPos; ACount: Integer);

procedure OnRspOptionQryHold(pRspQryQryHold: PCJGtdcOptionRspQryHold; ACount: Integer);

procedure OnRspOptionQryFund(pRspQryFund: PCJGtdcOptionRspQryFund; ACount: Integer);

procedure OnRspOptionQryRevocEnt(pRspQryRevocEnt: PCJGtdcOptionRspQryRevocEnt; ACount: Integer);
{现货交易}
//procedure ActualsOnFrontConnected();
//
//procedure ActualsOnFrontDisConnected();
//
//procedure ActualsOnRspError(const pErrMsg: PChar);
//
//procedure ActualsOnRspUserLogin(pRspUserLogin: PCJGtdcRspUserLogin; pRspInfo: PCJGtdcRspInfoField; nRequestID: Integer);
//
//procedure ActualsOnRspUserLogout(pRspUserLogout: PCJGtdcRspUserLogout; pRspInfo: PCJGtdcRspInfoField; nRequestID: Integer);
//
//procedure ActualsOnRspOrderInsert(pRspOrderInsert: PCJGtdcRspOrderInsert; pRspInfo: PCJGtdcRspInfoField; nRequestID: Integer);
//
//procedure ActualsOnRspOrderCancel(pRspOrderCancel: PCJGtdcRspOrderCancel; pRspInfo: PCJGtdcRspInfoField; nRequestID: Integer);
//
//procedure ActualsOnRtnOrder(pOrder: PCJGtdcRspQryOrder; nItems: Integer);
//
//procedure ActualsOnRtnTrade(pTrade: PCJGtdcRspQryTrade; nItems: Integer);
//
//procedure ActualsOnRspQryOrder(pRspQryOrder: PCJGtdcRspQryOrder; pRspInfo: PCJGtdcRspInfoField; nRequestID: Integer);
//
//procedure ActualsOnRspQryTrade(pRspQryTrade: PCJGtdcRspQryTrade; pRspInfo: PCJGtdcRspInfoField; nRequestID: Integer);
//
//procedure ActualsOnRspQryHold(pRspQryHold: PCJGtdcRspQryHold; pRspInfo: PCJGtdcRspInfoField; nRequestID: Integer);
//
//procedure ActualsOnRspQryFund(pRspQryFund: PCJGtdcRspQryFund; pRspInfo: PCJGtdcRspInfoField; nRequestID: Integer);
//
//procedure ActualsOnRspQryCancel(pRspQryCancel: PCJGtdcRspQryCancel; pRspInfo: PCJGtdcRspInfoField; nRequestID: Integer);

procedure OnRspActualsOrderInsert(pRspOrderInsert: PCJGtdcRspOrderInsert; ACount: Integer);

procedure OnRspActualsOrderCancel(pRspOrderCancel: PCJGtdcRspOrderCancel; ACount: Integer);

procedure OnRtnActualsOrder(pOrder: PCJGtdcRspQryOrder; ACount: Integer);

procedure OnRtnActualsTrade(pTrade: PCJGtdcRspQryTrade; ACount: Integer);

procedure OnRspActualsQryOrder(pRspQryOrder: PCJGtdcRspQryOrder; ACount: Integer);

procedure OnRspActualsQryTrade(pRspQryTrade: PCJGtdcRspQryTrade; ACount: Integer);

procedure OnRspActualsQryHold(pRspQryHold: PCJGtdcRspQryHold; ACount: Integer);

procedure OnRspActualsQryFund(pRspQryFund: PCJGtdcRspQryFund; ACount: Integer);

procedure OnRspActualsQryCancel(pRspQryCancel: PCJGtdcRspQryCancel; ACount: Integer);

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

function GetStrOffsetType(OffsetType: Char): string;

function GetStrTradeType(TradeType: Integer): string;

implementation

uses
  uDataCenter, uDrawView, uGlobalInstance, SysUtils, uConstants, DateUtils,
  MainWIN, Graphics;


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
    Sleep(1000);
    FFuturesTradeProxy.free := True;
  end;
end;


 (*
 0	投资者期权委托下单应答	OnRspOptionEntrust
 1	投资者期权委托撤单应答	OnRspOptionCancel
 2	投资者委托通知 OnRtnOptionOrder
 3	投资者成交通知	OnRtnOptionTrade
 4	投资者期权委托查询应答	OnRspOptionQryEntrust
 5	投资者期权增量成交查询应答	 OnRspOptionQryBusByPos
 6	投资者期权持仓查询应答	OnRspOptionQryHold
 7	投资者期权资金查询应答	OnRspOptionQryFund
 8 	投资者期权可撤单查询应答	OnRspOptionQryRevocEnt
 *)
procedure OptionOnResponseFunction(ASgin: Integer; AData: Pointer; ACount: Integer);
begin
  case ASgin of
    0:
      OnRspOptionEntrust(AData, ACount);
    1:
      OnRspOptionCancel(AData, ACount);
    2:
      OnRtnOptionOrder(AData, ACount);
    3:
      OnRtnOptionTrade(AData, ACount);
    4:
      OnRspOptionQryEntrust(AData, ACount);
    5:
      OnRspOptionQryBusByPos(AData, ACount);
    6:
      OnRspOptionQryHold(AData, ACount);
    7:
      OnRspOptionQryFund(AData, ACount);
    8:
      OnRspOptionQryRevocEnt(AData, ACount);
  end;
end;

procedure ActualsOnResponseFunction(ASgin: Integer; AData: Pointer; ACount: Integer);
begin
  case ASgin of
    0:
      OnRspActualsOrderInsert(AData, ACount);
    1:
      OnRspActualsOrderCancel(AData, ACount);
    2:
      OnRtnActualsOrder(AData, ACount);
    3:
      OnRtnActualsTrade(AData, ACount);
    4:
      OnRspActualsQryOrder(AData, ACount);
    5:
      OnRspActualsQryTrade(AData, ACount);
    6:
      OnRspActualsQryHold(AData, ACount);
    7:
      OnRspActualsQryFund(AData, ACount);
    8:
      OnRspActualsQryCancel(AData, ACount);
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
  TPositionDataCenter.Instance.addItem(newData.InstrumentID + '-' + newData.PosiDirection, newData, FUTURES);
  //界面更新
  if (MainWindow.PageControl1.ActivePageIndex = 0) then
  begin
    TDrawView.instance.RunSynchronize(TDrawView.instance.DrawPositionListView);
  end;
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
  TradingAccountField[0] := newData;
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
  TOrderLogDataCenter.instance.addLog(newData, FUTURES);
//  //日志界面更新
  if (MainWindow.PageControl1.ActivePageIndex = 0) then
  begin
    TDrawView.instance.RunSynchronize(TDrawView.instance.DrawLogView);
  end;
//  TDrawView.instance.RunSynchronize(TDrawView.instance.PushOrderToCommandWindows);
  {报单界面响应}
  if (Adata.OrderStatus <> THOST_FTDC_OST_Unknown) then
  begin
    //提交表刷新
    TOrderDataCenter.instance.addItem(newData.OrderSysID + '-' + newData.ExchangeID + '&' + newData.InsertTime, newData, FUTURES);
    TDrawView.instance.RunSynchronize(TDrawView.instance.DrawOrderView);
    //持仓刷新（平仓）
    if (newData.CombOffsetFlag[0] <> '0') then
    begin
      //信号量
    end;
  end;
//  TRequestMessenger.instance.Request(TRequestMessenger啊实打实.instance.Order);
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
  TSuccessOrderDataCenter.instance.addItem(newData.TradeID, newData, FUTURES);
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
  TOrderDataCenter.instance.addItem(newData.OrderSysID + '-' + newData.ExchangeID + '&' + newData.InsertTime, newData, FUTURES);
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
  TSuccessOrderDataCenter.instance.addItem(newData.TradeID, newData, FUTURES);
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

{期权交易响应}

procedure OnRspOptionEntrust(pRspEntrust: PCJGtdcOptionRspEntrust; ACount: Integer);
var
  str: string;
  sOffsetType: string;
begin
  if (pRspEntrust.ResultType = 0) then
  begin
    sOffsetType := GetStrOffsetType(pRspEntrust.OffsetType);
    str := '[Option]' + pRspEntrust.EntrustNo + ';下单成功，合约:' + pRspEntrust.ContractNumber + ';';
    //+ sOffsetType + ';数量:' + IntToStr(Integer(pRspEntrust.EntrustAmount)) + ';价格:' + FloatToStr(pRspEntrust.EntrustPrice / 10000)
  end
  else
  begin
    str := '[Option]' + pRspEntrust.EntrustNo + ';下单出错,' + '合约:' + pRspEntrust.ContractNumber + ';' + pRspEntrust.ErrorInfo;
  end;
  TDrawView.instance.log(str, InfoColor, 'INFO');
end;

procedure OnRspOptionCancel(pRspCancel: PCJGtdcOptionRspCancel; ACount: Integer);
var
  str: string;
begin
  if (pRspCancel.ResultType = 0) then
  begin
    str := '[Option]' + pRspCancel.EntrustNo + '撤单成功;' + pRspCancel.NewEntrustNo;
  end
  else
  begin
    str := '[Option]' + pRspCancel.EntrustNo + '撤单出错:' + pRspCancel.ErrorInfo;
  end;
  TDrawView.instance.log(str, InfoColor, 'INFO');
end;

//委托通知
procedure OnRtnOptionOrder(pRspQryEntrust: PCJGtdcOptionRspQryEntrust; ACount: Integer);
var
  sTradeType: string;
  sOffsetType: string;
  sEntrustStatus: string;
  str: string;
  ptmp: PCJGtdcOptionRspQryEntrust;
  I: Integer;
begin
  for I := 0 to ACount - 1 do
  begin
    ptmp := pRspQryEntrust;
    Inc(ptmp, I);
    sTradeType := GetStrTradeType(ptmp.TradeType);
    sOffsetType := GetStrOffsetType(ptmp.OffsetType);
    case ptmp.EntrustStatus of
      '0':
        sEntrustStatus := '未报';
      '1':
        sEntrustStatus := '正报';
      '2':
        sEntrustStatus := '已报';
      '3':
        sEntrustStatus := '已报待撤';
      '4':
        sEntrustStatus := '部成待撤';
      '5':
        sEntrustStatus := '部撤';
      '6':
        sEntrustStatus := '已撤';
      '7':
        sEntrustStatus := '部成';
      '8':
        sEntrustStatus := '已成';
      '9':
        sEntrustStatus := '废单';
      'a':
        sEntrustStatus := '待报';
      'b':
        sEntrustStatus := '场内拒绝';
    end;
    str := '[Option]' + '委托成功' + ptmp.EntrustNo + '合约:' + ptmp.ContractNumber + '/' + ptmp.ContractCode + '(' + ptmp.ContractName + ')' + ptmp.EntrustStatus + ';' + sTradeType + ';' + sOffsetType + ';数量:' + IntToStr(ptmp.EntrustAmount) + ';价格:' + FloatToStr(ptmp.EntrustPrice / 10000) + ';时间:' + IntToStr(ptmp.EntrustTime);
    TDrawView.instance.log(str, InfoColor, 'INFO');
  end;
  //更新持仓,委托单,成交单,资金
end;

procedure OnRtnOptionTrade(pRspQryBusByPos: PCJGtdcOptionRspQryBusByPos; ACount: Integer);
var
  str: string;
  sBusinessStatus: string;
  sOffsetType: string;
  sTradeType: string;
  I: Integer;
  ptmp: PCJGtdcOptionRspQryBusByPos;
begin
  for I := 0 to ACount - 1 do
  begin
    ptmp := pRspQryBusByPos;
    Inc(ptmp, I);
    sTradeType := GetStrTradeType(ptmp.TradeType);
    sOffsetType := GetStrOffsetType(ptmp.OffsetType);
    case ptmp.BusinessStatus of
      '0':
        sBusinessStatus := '普通成交';
      '1':
        sBusinessStatus := '撤单成功';
      '2':
        sBusinessStatus := '废单成交';
    end;
    str := '[Option]' + '成交通知' + ptmp.EntrustNo + '合约:' + ptmp.ContractNumber + '/' + ptmp.ContractCode + '(' + ptmp.ContractName + ')' + sBusinessStatus + ';' + sTradeType + ';' + sOffsetType + ';数量:' + IntToStr(ptmp.EntrustAmount) + ';价格:' + FloatToStr(ptmp.EntrustPrice / 10000) + ';时间:' + IntToStr(ptmp.BusinessTime);
    TDrawView.instance.log(str, InfoColor, 'INFO');
  end;
  //更新持仓,委托单，成交单,资金
end;

procedure OnRspOptionQryEntrust(pRspQryEntrust: PCJGtdcOptionRspQryEntrust; ACount: Integer);
var
  newData: PCJGtdcOptionRspQryEntrust;
begin
  TDrawView.instance.log('期权委托查询响应' + InttoStr(ACount), clRed, '[DEBUG]');
//  New(newData);
//  Move(pRspQryEntrust^, newData^, SizeOf(TCJGtdcOptionRspQryEntrust));
//  TOrderDataCenter.instance.addItem(newData.EntrustNo, newData, OPTION);
//
//  //界面更新
//  if (MainWindow.PageControl1.ActivePageIndex = Integer(OPTION)) then
//  begin
//    TDrawView.instance.RunSynchronize(TDrawView.instance.DrawOrderView);
//  end;
end;

procedure OnRspOptionQryBusByPos(pRspQryBusByPos: PCJGtdcOptionRspQryBusByPos; ACount: Integer);
var
  newData: PCJGtdcOptionRspQryBusByPos;
begin
  TDrawView.instance.log('期权增量成交查询响应' + InttoStr(ACount), clRed, '[DEBUG]');
//  New(newData);
//  Move(pRspQryBusByPos^, newData^, SizeOf(TCJGtdcOptionRspQryBusByPos));
//  TOrderDataCenter.instance.addItem(newData.BusinessNo, newData, OPTION);
//
//  //界面更新
//  if (MainWindow.PageControl1.ActivePageIndex = Integer(OPTION)) then
//  begin
//    TDrawView.instance.RunSynchronize(TDrawView.instance.DrawSuccessOrderView);
//  end;
end;

procedure OnRspOptionQryHold(pRspQryQryHold: PCJGtdcOptionRspQryHold; ACount: Integer);
var
  newData: PCJGtdcOptionRspQryHold;
begin
  TDrawView.instance.log('期权持仓查询响应' + InttoStr(ACount), clRed, '[DEBUG]');
//  New(newData);
//  Move(pRspQryQryHold^, newData^, SizeOf(TCJGtdcOptionRspQryHold));
//  TPositionDataCenter.instance.addItem(newData.ContractCode + '-' + newData.OptionType, newData, OPTION);
//
//  //界面更新
//  if (MainWindow.PageControl1.ActivePageIndex = Integer(OPTION)) then
//  begin
//    TDrawView.instance.RunSynchronize(TDrawView.instance.DrawPositionListView);
//  end;
end;

procedure OnRspOptionQryFund(pRspQryFund: PCJGtdcOptionRspQryFund; ACount: Integer);
var
  newData: PCJGtdcOptionRspQryFund;
begin
  TDrawView.instance.log('期权资金查询响应' + InttoStr(ACount), clRed, '[DEBUG]');
//  New(newData);
//  Move(pRspQryFund^, newData^, SizeOf(TCJGtdcOptionRspQryHold));
//  TradingAccountField[1] := newData;
//  //界面更新
//  if (MainWindow.PageControl1.ActivePageIndex = Integer(OPTION)) then
//  begin
//    TDrawView.instance.RunSynchronize(TDrawView.instance.DrawAccountCapital);
//  end;
end;

procedure OnRspOptionQryRevocEnt(pRspQryRevocEnt: PCJGtdcOptionRspQryRevocEnt; ACount: Integer);
var
  newData: PCJGtdcOptionRspQryRevocEnt;
begin
  TDrawView.instance.log('期权可撤单查询响应' + InttoStr(ACount), clRed, '[DEBUG]');
//  New(newData);
//  Move(pRspQryRevocEnt^, newData^, SizeOf(TCJGtdcOptionRspQryRevocEnt));
//  TOrderDataCenter.instance.addNoDealItem(newData.EntrustNo, newData, OPTION);
//
//  //界面更新
//  if (MainWindow.PageControl1.ActivePageIndex = Integer(OPTION)) then
//  begin
////    TDrawView.instance.RunSynchronize(TDrawView.instance.{需要实现可撤单界面更新});
//  end;
end;  

{现货交易响应}
procedure OnRspActualsOrderInsert(pRspOrderInsert: PCJGtdcRspOrderInsert; ACount: Integer);
var
  str: string;
  sTradeType: string;
  I: Integer;
  ptmp: PCJGtdcRspOrderInsert;
begin
  for I := 0 to ACount - 1 do
  begin
    ptmp := pRspOrderInsert;
    Inc(ptmp, I);
    sTradeType := GetStrTradeType(ptmp.TradeType);
    str := '[Option]' + '成交通知' + ptmp.EntrustNo + '合约:' + ptmp.StockCode + ';' + sTradeType + ';' + ';数量:' + IntToStr(ptmp.OrderVolume) + ';价格:' + FloatToStr(ptmp.OrderPrice / 10000);
    TDrawView.instance.log(str, InfoColor, 'INFO');
  end;
end;

procedure OnRspActualsOrderCancel(pRspOrderCancel: PCJGtdcRspOrderCancel; ACount: Integer);
begin

end;

procedure OnRtnActualsOrder(pOrder: PCJGtdcRspQryOrder; ACount: Integer);
var
  sTradeType: string;
  sEntrustStatus: string;
  str: string;
  ptmp: PCJGtdcRspQryOrder;
  I: Integer;
begin
  for I := 0 to ACount - 1 do
  begin
    ptmp := pOrder;
    Inc(ptmp, I);
    sTradeType := GetStrTradeType(ptmp.TradeType);
    case ptmp.EntrustStatus of
      '0':
        sEntrustStatus := '未报';
      '1':
        sEntrustStatus := '正报';
      '2':
        sEntrustStatus := '已报';
      '3':
        sEntrustStatus := '已报待撤';
      '4':
        sEntrustStatus := '部成待撤';
      '5':
        sEntrustStatus := '部撤';
      '6':
        sEntrustStatus := '已撤';
      '7':
        sEntrustStatus := '部成';
      '8':
        sEntrustStatus := '已成';
      '9':
        sEntrustStatus := '废单';
      'a':
        sEntrustStatus := '待报';
      'b':
        sEntrustStatus := '场内拒绝';
    end;
    str := '[Option]' + '委托成功' + ptmp.EntrustNo + '合约:' + ptmp.StockCode + '(' + ptmp.StockName + ')' + ptmp.EntrustStatus + ';' + sTradeType + ';数量:' + IntToStr(ptmp.BusinessVolume) + ';价格:' + FloatToStr(ptmp.BusinessPrice / 10000) + ';时间:' + IntToStr(ptmp.EntrustTime);
    TDrawView.instance.log(str, InfoColor, 'INFO');
  end;
end;

procedure OnRtnActualsTrade(pTrade: PCJGtdcRspQryTrade; ACount: Integer);
var
  str: string;
  sBusinessStatus: string;
  sOffsetType: string;
  sTradeType: string;
  I: Integer;
  ptmp: PCJGtdcRspQryTrade;
begin
  for I := 0 to ACount - 1 do
  begin
    ptmp := pTrade;
    Inc(ptmp, I);
    sTradeType := GetStrTradeType(ptmp.TradeType);
    case ptmp.BusinessStatus of
      '0':
        sBusinessStatus := '普通成交';
      '1':
        sBusinessStatus := '撤单成功';
      '2':
        sBusinessStatus := '废单成交';
    end;
    str := '[Option]' + '成交通知' + ptmp.EntrustNo + '合约:' + ptmp.StockCode + '(' + ptmp.StockName + ')' + sBusinessStatus + ';' + sTradeType + ';数量:' + IntToStr(ptmp.BusinessVolume) + ';价格:' + FloatToStr(ptmp.BusinessPrice / 10000) + ';时间:' + IntToStr(ptmp.BusinessTime);
    TDrawView.instance.log(str, InfoColor, 'INFO');
  end;
end;

procedure OnRspActualsQryOrder(pRspQryOrder: PCJGtdcRspQryOrder; ACount: Integer);
begin
  TDrawView.instance.log('现货报单查询响应' + InttoStr(ACount), clRed, '[DEBUG]');
end;

procedure OnRspActualsQryTrade(pRspQryTrade: PCJGtdcRspQryTrade; ACount: Integer);
begin
  TDrawView.instance.log('现货成交查询响应' + InttoStr(ACount), clRed, '[DEBUG]');
end;

procedure OnRspActualsQryHold(pRspQryHold: PCJGtdcRspQryHold; ACount: Integer);
begin
  TDrawView.instance.log('现货持仓查询响应' + InttoStr(ACount), clRed, '[DEBUG]');
end;

procedure OnRspActualsQryFund(pRspQryFund: PCJGtdcRspQryFund; ACount: Integer);
begin
  TDrawView.instance.log('现货资金查询响应' + InttoStr(ACount), clRed, '[DEBUG]');
end;

procedure OnRspActualsQryCancel(pRspQryCancel: PCJGtdcRspQryCancel; ACount: Integer);
begin

end;

function GetStrOffsetType(OffsetType: Char): string;
begin
  case OffsetType of
    '0':
      Result := '开仓';
    '1':
      Result := '平仓';
    '2':
      Result := '平今仓';
  else
    Result := '未知错误';
  end;
end;

function GetStrTradeType(TradeType: Integer): string;
begin
  case TradeType of
    1:
      Result := '买';
    2:
      Result := '卖';
  else
    Result := '其他类型' + IntToStr(TradeType);
  end;
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

