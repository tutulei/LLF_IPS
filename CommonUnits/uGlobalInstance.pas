unit uGlobalInstance;

interface

uses
  uQuotationAPI, uTradeAPI, Classes, uContractsSchedule, uDataStruct,
  uManagerThread, uMyChartManager;

var
  //存活界面
  WindowList: TList;
  {期货行情交易接口实例}
  FFuturesQuotationProxy: TFuturesQuotationProxy;
  FFuturesTradeProxy: TTradeProxy;
  {期权行情交易接口实例}
  FOptionQuotationProxy: TOptionQuotationProxy;
  {现货获取交易接口实例}
//  FActualsQuotationProxy: TActualsQuotationProxy;
{走势图管理器}
  FFuturesSeriesManager: TmySeriesManager;
  FOptionSeriesManager: TmySeriesManager;
  FActualsSeriesManager: TmySeriesManager;
  FQuotationThread: TThread;
  FDataSchedule: TDataSchedule;
  QuotationServerStatus: TQuotationServerStatus;
  TradeServerStatus: TTradeAccountStatus;
  nChar: PChar = PChar('');

implementation

end.

