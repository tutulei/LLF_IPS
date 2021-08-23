unit uGlobalInstance;

interface

uses
  uQuotationAPI, uTradeAPI, Classes, uContractsSchedule, uDataStruct,
  uManagerThread;

var
  //存活界面
  WindowList: TList;
  {期货行情交易接口实例}
  FFuturesQuotationProxy: TFuturesQuotationProxy;
  FFuturesTradeProxy: TTradeProxy;
  {期权行情交易接口实例}
  FOptionQuotationProxy: TOptionQuotationProxy;
  FQuotationThread: TThread;
  FDataSchedule: TDataSchedule;
  QuotationServerStatus: TQuotationServerStatus;
  TradeServerStatus: TTradeAccountStatus;
  nChar: PChar = PChar('');

implementation

end.

