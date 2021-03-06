unit uGlobalInstance;

interface

uses
  uQuotationAPI, uTradeAPI, Classes, uContractsSchedule, uDataStruct,
  uManagerThread, uMyChartManager, SysUtils;

var
  //存活界面
  WindowList: TList;
  {期货行情交易接口实例}
  FFuturesQuotationProxy: TFuturesQuotationProxy;
  FFuturesTradeProxy: TFuturesTradeProxy;
  {期权行情交易接口实例}
  FOptionQuotationProxy: TOptionQuotationProxy;
  FOptionTradeProxy: TOptionTradeProxy;
  {现货获取交易接口实例}
  FActualsQuotationProxy: TActualsQuotationProxy;
  FActualsTradeProxy: TActualsTradeProxy;
{走势图管理器}
  FFuturesSeriesManager: TmySeriesManager;
  FOptionSeriesManager: TmySeriesManager;
  FActualsSeriesManager: TmySeriesManager;
  FQuotationThread: TThread;
  FDataSchedule: TDataSchedule;
  QuotationServerStatus: TQuotationServerStatus;
  TradeServerStatus: TTradeAccountStatus;
  nChar: PChar = PChar('');

  {落文件路径}
  FuturesquotationPath: string;
  myFuturesquotationPath: string;
  myFuturestradePath: string;
  myOptionquotationPath: string;
  myOptiontradePath: string;
  myActualsquotationPath: string;
  myActualstradePath: string;

procedure writelog(path: string; str: string; logtype: string = 'INFO');

implementation

procedure writelog(path: string; str: string; logtype: string = 'INFO');
var
  head: string;
begin
  head := '[' + logtype + ']' + TimeToStr(now) + '===> ';
  Writeln(path, head + str);
end;

end.

