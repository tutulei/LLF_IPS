unit uTradeUnit;

interface

implementation

uses
  MainWIN, uManagerThread;

//生成线程提交订单
procedure AddOneOrder(AInstrumentID: PChar; ADirection: Char; AOffsetFlag: Char; ALimitPrice: Double);
begin
//  TManagerThread.Create(AInstrumentID, ADirection, AOffsetFlag, ALimitPrice,tradeProxy.AddLimitPriceOrder);
end;

end.

