unit uDrawView;

interface

uses
  uDataCenter, Classes, uDataStruct;

type
  MySpi = class(TThread)
  private
    class var
      ins: MySpi;
  public
    class function instance(): MySpi;
    procedure RunSynchronize(AMethod: TThreadMethod);
    //持仓界面刷新
    procedure DrawPositionListView();
    //行情界面刷新
    procedure DrawQuotationGridView();
  end;

implementation

uses
  ComCtrls, MainWIN, SysUtils, uConstants,uContractsSchedule;

procedure MySpi.RunSynchronize(AMethod: TThreadMethod);
begin
//  MessageBox(0, PChar('[MySpi] run'+string(GetCurrentProcess)), 'Waring', IDOK);
  Self.Synchronize(AMethod);
end;

class function MySpi.instance(): MySpi;
begin
  if (ins = nil) then
  begin
    ins := MySpi.Create(True);
  end;
  Result := ins;
end;

//更新界面的持仓表
procedure MySpi.DrawPositionListView();
var
  p: ^CThostFtdcInvestorPositionField;
  item: TListItem;
  PosiDirection: PChar;
begin
//  MessageBox(0, PChar('[DrawPositionListView] run'), 'Waring', IDOK);
  p := TPositionDataCenter.Instance.Item;
  item := MainWindow.PoinsitionListView.Items.Add;
  item.Caption := p.InstrumentID;
  case p.PosiDirection of
    THOST_FTDC_PD_Net:
      PosiDirection := PChar('净');
    THOST_FTDC_PD_Long:
      PosiDirection := PChar('买');
    THOST_FTDC_PD_Short:
      PosiDirection := PChar('卖');
  end;
  item.SubItems.Add(PosiDirection);
  item.SubItems.Add(FloatToStr(p.Position));
  item.SubItems.Add(FloatToStr(p.Position - p.TodayPosition));
  item.SubItems.Add(FloatToStr(p.TodayPosition));
  //持仓均价
  item.SubItems.Add(FloatToStr(p.SettlementPrice));
  item.SubItems.Add(FloatToStr(p.PositionProfit));
  item.SubItems.Add(FloatToStr(p.UseMargin));
  item.SubItems.Add(p.HedgeFlag);
  item.SubItems.Add(p.ExchangeID);
//  list := tradeProxy.CheckPosition();
end;

procedure MySpi.DrawQuotationGridView();
var
  sid: string;
  index: Integer;
begin
  //将数据中心的当前数据推到界面
  sid := TStrings(TQuotationDataCenter.Instance.Item).Strings[0];
  index := FDataSchedule.FFuturesSeatingList.IndexOf(sid);
  MainWindow.FFuturesQuotationGrid.Rows[index] := TStrings(TQuotationDataCenter.Instance.Item);
end;

end.

