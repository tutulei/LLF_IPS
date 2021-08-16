unit uGlobalInstance;

interface

uses
  uQuotationAPI, uTradeAPI, Classes, uContractsSchedule, uDataStruct;

var
  //������
  WindowList: TList;
  FQuotationProxy: TQuotationProxy;
  FTradeProxy: TTradeProxy;
  FQuotationThread: TThread;
  FDataSchedule: TDataSchedule;
  QuotationServerStatus: TQuotationServerStatus;
  TradeServerStatus: TTradeAccountStatus;
  nChar: PChar = PChar('');
implementation

end.

