unit uGlobalInstance;

interface

uses
  uQuotationAPI, uTradeAPI, Classes, uContractsSchedule, uDataStruct,
  uManagerThread;

var
  //������
  WindowList: TList;
  {�ڻ����齻�׽ӿ�ʵ��}
  FFuturesQuotationProxy: TFuturesQuotationProxy;
  FFuturesTradeProxy: TTradeProxy;
  {��Ȩ���齻�׽ӿ�ʵ��}
  FOptionQuotationProxy: TOptionQuotationProxy;
  FQuotationThread: TThread;
  FDataSchedule: TDataSchedule;
  QuotationServerStatus: TQuotationServerStatus;
  TradeServerStatus: TTradeAccountStatus;
  nChar: PChar = PChar('');

implementation

end.
