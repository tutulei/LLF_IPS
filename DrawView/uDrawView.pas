unit uDrawView;

interface

uses
  uDataCenter, Classes, uDataStruct, IdGlobal, Graphics, ComCtrls, uConstants;

type
  TDrawView = class(TThread)
  private
    CriticalSection: TCriticalSection;
    logData: string;
    logView: TComponent;
    logColor: Integer;
    class var
      ins: TDrawView;
    procedure PrintLog();
  public
    class function instance(): TDrawView;
    constructor Create(CreateSuspended: Boolean = False);
    procedure RunSynchronize(AMethod: TThreadMethod);
    //持仓界面刷新
    procedure DrawPositionListView();
    //行情界面刷新
    procedure DrawQuotationGridView();
    procedure DrawOptionQuotationGridView();
//    procedure DrawFuturesQuotationGridView();
    //订单响应更新至文本窗口
    procedure PushOrderToCommandWindows();
    //资金状况刷新
    procedure DrawAccountCapital();
    //已提交订单界面刷新
    procedure DrawOrderView();
    //成交订单界面更新
    procedure DrawSuccessOrderView();
    //日志更新
    procedure DrawLogView();
    procedure initQuotationView(arr: array of PChar; Atype: ContractType);
    //打印debug日志
    procedure log(log: string; color: Integer; logType: string);
  end;

procedure addRichText(edit: TRichEdit; text: TStrings; color: Integer);

implementation

uses
  MainWIN, SysUtils, uContractsSchedule, MATH, StrUtils, Windows, Messages,
  RichEdit, uGlobalInstance;

constructor TDrawView.Create(CreateSuspended: Boolean = False);
begin
  inherited Create(CreateSuspended);
  logView := MainWindow.RichEdit2;
  CriticalSection := TCriticalSection.Create();
end;

procedure TDrawView.RunSynchronize(AMethod: TThreadMethod);
begin
  CriticalSection.Enter;
//  MessageBox(0, PChar('[MySpi] run'+string(GetCurrentProcess)), 'Waring', IDOK);
  Synchronize(AMethod);
  CriticalSection.Leave;
end;

class function TDrawView.instance(): TDrawView;
begin
  if (ins = nil) then
  begin
    ins := TDrawView.Create(True);
  end;
  Result := ins;
end;

//更新界面的持仓表
procedure TDrawView.DrawAccountCapital;
begin
  MainWindow.TopGrid.Cells[0, 1] := FloatToStr(RoundTo(TradingAccountField.Available, 2));
  MainWindow.TopGrid.Cells[1, 1] := FloatToStr(RoundTo(TradingAccountField.CloseProfit, 2));
  MainWindow.TopGrid.Cells[2, 1] := FloatToStr(RoundTo(TradingAccountField.PositionProfit, 2));
end;

procedure TDrawView.DrawPositionListView();
var
  p: PThostFtdcInvestorPositionField;
  item: TListItem;
  PosiDirection: PChar;
  index: Integer;
  skey: string;
begin
  index := -1;
//  MessageBox(0, PChar('[DrawPositionListView] run'), 'Waring', IDOK);
  p := TPositionDataCenter.Instance.Item;
  skey := p.InstrumentID + '-' + p.PosiDirection;
  index := TPositionDataCenter.Instance.getList.IndexOf(skey);
  if (p.Position = 0) then
  begin
    Exit;
  end;

  //尝试获取item
  if (index <> -1) then
  begin
    item := MainWindow.PoinsitionListView.Items.Item[index];
//    TDrawView.instance.log('正在绘制：第' + IntToStr(index) + '条记录', DebugColor, 'DEUBG');
//    TOrderLogDataCenter.instance.logData := '[DEBUG]' + TimeToStr(now) + '正在绘制：第' + IntToStr(index) + '条记录';
//    PrintLog;
  end;

  //不存在就添加，已经存在就清空
  if (item = nil) then
  begin
    item := MainWindow.PoinsitionListView.Items.Add;
  end
  else
  begin
    item.SubItems.Clear;
  end;

  item.Caption := p.InstrumentID;
  case p.PosiDirection of
    THOST_FTDC_PD_Net:
      PosiDirection := PChar('  净');
    THOST_FTDC_PD_Long:
      PosiDirection := PChar('买');
    THOST_FTDC_PD_Short:
      PosiDirection := PChar('     卖');
  end;
  item.SubItems.Add(PosiDirection);
  item.SubItems.Add(FloatToStr(p.Position));
  item.SubItems.Add(FloatToStr(p.Position - p.TodayPosition));
  item.SubItems.Add(FloatToStr(p.TodayPosition));
  item.SubItems.Add(FloatToStr(RoundTo(p.PositionProfit, -2)));
  item.SubItems.Add(FloatToStr(p.UseMargin));
//  list := tradeProxy.CheckPosition();
end;

procedure TDrawView.DrawQuotationGridView();
var
  sid: string;
  index: Integer;
  item: TStrings;
begin
//  MessageBox(0, PChar(GetCurrentThreadId()), '提示', MB_OK);
  //将数据中心的当前数据推到界面
  sid := TQuotationDataCenter.Instance.GetLastItemKey(FUTURES);
  index := TQuotationDataCenter.Instance.FFuturesSeatingList.IndexOf(sid);
  MainWindow.FFuturesQuotationGrid.Rows[index + 1] := TStrings(TQuotationDataCenter.Instance.GetItem(sid, FUTURES));
  if (sid = MainWindow.ContractIdComboBox.Text) then
  begin
    MainWindow.SellPriceLabel.Caption := TStrings(TQuotationDataCenter.Instance.GetItem(sid, FUTURES))[5];
    MainWindow.BuyPriceLabel.Caption := TStrings(TQuotationDataCenter.Instance.GetItem(sid, FUTURES))[3];
  end;

end;

procedure TDrawView.DrawOptionQuotationGridView;
var
  sid: string;
  index: Integer;
  item: TStrings;
begin
  sid := TQuotationDataCenter.Instance.GetLastItemKey(OPTION);
  index := TQuotationDataCenter.Instance.FOptionSeatingList.IndexOf(sid);
  if (index = -1) then
  begin
    raise Exception.Create('期权Grid绘图取空');
  end;
  MainWindow.FOptionQuotationGrid.Rows[index + 1] := TStrings(TQuotationDataCenter.Instance.GetItem(sid, OPTION));
end;

procedure TDrawView.PushOrderToCommandWindows();
var
  iLine: Integer;
  color: Integer;
  temp: Integer;
//  fmt : TCharFormat2;
begin
  temp := MainWindow.RichEdit1.SelStart;
  MainWindow.RichEdit1.Lines.Add('');
  addRichText(MainWindow.RichEdit1, TStrings(TCommandWindowsDataCenter.instance.Item), clBlue);
//  iLine := SendMessage(MainWindow.RichEdit1.Handle, EM_LINEFROMCHAR, MainWindow.RichEdit1.SelStart, 0);
//
//  fmt.cbSize := SizeOf(fmt);
//  fmt.dwMask := CFM_COLOR or CFM_BACKCOLOR;
//  fmt.crTextColor := clWhite;
//  fmt.crBackColor := $004B9700;
//  MainWindow.RichEdit1.Perform(EM_SETCHARFORMAT, SCF_SELECTION, integer(@Fmt))

end;

procedure addRichText(edit: TRichEdit; text: TStrings; color: Integer);
var
  temp: Integer;
begin
  temp := edit.SelStart;
  edit.Lines.AddStrings(text);
  edit.SelStart := temp;
  edit.SelLength := Length(text.Text);
  edit.SelAttributes.Color := color;
  edit.SelStart := temp + Length(text.Text);
  edit.SelLength := 0;
  edit.SelAttributes.Color := clBlack;
  edit.lines.Delete(edit.Lines.Count - 1);
//  text.Free;
end;

procedure TDrawView.initQuotationView(arr: array of PChar; Atype: ContractType);
begin
  FDataSchedule.AddContracts(arr, Atype);
  MainWindow.ContractIdComboBox.Items := TQuotationDataCenter.Instance.FFuturesSeatingList;
  MainWindow.ContractIdComboBox.ItemIndex := 0;
  FSeriesManager.SetCurrentSeries(TQuotationDataCenter.Instance.FFuturesSeatingList[2]);
  FSeriesManager.SetCurrentSeries(TQuotationDataCenter.Instance.FFuturesSeatingList[1]);
  FSeriesManager.SetCurrentSeries(TQuotationDataCenter.Instance.FFuturesSeatingList[0]);
end;

procedure TDrawView.DrawOrderView();
var
  item: TListItem;
  nodealItem: TListItem;
  index: Integer;
  inodealIndex: Integer;
  p: PThostFtdcOrderField;
  skey: string;
  sPosiDirection: string;
  sOffsetFlag: string;
  sOrderStatus: string;
begin
  p := TOrderDataCenter.Instance.Item;
  skey := p.OrderSysID + '-' + p.ExchangeID + '&' + p.InsertTime;
  index := TOrderDataCenter.Instance.getList.IndexOf(skey);

  //尝试获取item
  if (index <> -1) then
  begin
    item := MainWindow.OrderListView.Items.Item[index];
  end;

  //不存在就添加，已经存在就清空
  if (item = nil) then
  begin
    item := MainWindow.OrderListView.Items.Add;
  end
  else
  begin
    item.SubItems.Clear;
  end;

  item.Caption := Trim(string(p.OrderSysID));
  item.SubItems.Add(p.InstrumentID);
  case p.Direction of
    '0':
      sPosiDirection := string('买');
    '1':
      sPosiDirection := string('  卖');
  end;
  item.SubItems.Add(sPosiDirection);

  case p.CombOffsetFlag[0] of
  ///开仓
    THOST_FTDC_OF_Open:
      sOffsetFlag := PChar('开');
  ///平仓
    THOST_FTDC_OF_Close:
      sOffsetFlag := PChar('平');
  ///强平
    THOST_FTDC_OF_ForceClose:
      sOffsetFlag := PChar('强平');
  ///平今
    THOST_FTDC_OF_CloseToday:
      sOffsetFlag := PChar('平今');
  ///平昨
    THOST_FTDC_OF_CloseYesterday:
      sOffsetFlag := PChar('平昨');
  ///强减
    THOST_FTDC_OF_ForceOff:
      sOffsetFlag := PChar('强减');
  ///本地强平
    THOST_FTDC_OF_LocalForceClose:
      sOffsetFlag := PChar('本地强平');
  end;
  item.SubItems.Add(sOffsetFlag);

  case p.OrderStatus of
  ///全部成交
    THOST_FTDC_OST_AllTraded:
      sOrderStatus := string('全部成交');
  ///部分成交还在队列中
    THOST_FTDC_OST_PartTradedQueueing:
      sOrderStatus := string('部分成交还在队列中');
  ///部分成交不在队列中
    THOST_FTDC_OST_PartTradedNotQueueing:
      sOrderStatus := string('部分成交不在队列中');
  ///未成交还在队列中
    THOST_FTDC_OST_NoTradeQueueing:
      sOrderStatus := string('未成交还在队列中');
  ///未成交不在队列中
    THOST_FTDC_OST_NoTradeNotQueueing:
      sOrderStatus := string('未成交不在队列中');
  ///撤单
    THOST_FTDC_OST_Canceled:
      sOrderStatus := string('撤单');
  ///未知
    THOST_FTDC_OST_Unknown:
      sOrderStatus := string('未知');
  ///尚未触发
    THOST_FTDC_OST_NotTouched:
      sOrderStatus := string('尚未触发');
  ///已触发
    THOST_FTDC_OST_Touched:
      sOrderStatus := string('已触发');
  end;
  item.SubItems.Add(sOrderStatus);
  item.SubItems.Add(FloatToStr(p.LimitPrice));
  item.SubItems.Add(IntToStr(p.VolumeTotalOriginal));
  item.SubItems.Add(IntToStr(p.VolumeTotal));
  item.SubItems.Add(IntToStr(p.VolumeTraded));
  item.SubItems.Add(p.OrderRef);
  item.SubItems.Add(p.StatusMsg);
  item.SubItems.Add(p.InsertTime);

  if (TOrderDataCenter.Instance.getNoDealList.Count = MainWindow.noDealListView.Items.Count) then
  begin
    inodealIndex := TOrderDataCenter.Instance.getNoDealList.IndexOf(IntToStr(p.BrokerOrderSeq));
    if (inodealIndex = -1) then
      exit;
    nodealItem := MainWindow.noDealListView.Items.Item[inodealIndex];
    nodealItem.SubItems.Clear;
  end
  else if (TOrderDataCenter.Instance.getNoDealList.Count > MainWindow.noDealListView.Items.Count) then
  begin
    nodealItem := MainWindow.noDealListView.Items.Insert(0);
  end
  else
  begin
    MainWindow.noDealListView.Items.Delete(TOrderDataCenter.Instance.ideleteIndex);
    Exit;
  end;
  nodealItem.Caption := Trim(string(p.InstrumentID));
  nodealItem.SubItems.Add(sPosiDirection);
  nodealItem.SubItems.Add(sOffsetFlag);
  nodealItem.SubItems.Add(FloatToStr(p.LimitPrice));
  nodealItem.SubItems.Add(IntToStr(p.VolumeTotalOriginal));
  nodealItem.SubItems.Add(IntToStr(p.VolumeTotal));
  nodealItem.SubItems.Add(IntToStr(p.BrokerOrderSeq));
  nodealItem.SubItems.Add(p.InsertTime);

//  data.InstrumentID; //合约
//  data.Direction; //买卖
//  data.OrderRef; //报单号
//  data.CombOffsetFlag; //组合开平标志
//  data.LimitPrice; //价格
//  data.VolumeTotalOriginal; //数量
//  data.VolumeTotal; //剩余数量
//  data.VolumeTraded; //今成交量
//  data.InsertTime; //委托时间

end;

procedure TDrawView.DrawSuccessOrderView();
var
  p: PThostFtdcTradeField;
  skey: string;
  index: Integer;
  item: TListItem;
  sPosiDirection: string;
  sOffsetFlag: string;
begin
  p := TSuccessOrderDataCenter.Instance.Item;
  skey := p.TradeID;
  index := TSuccessOrderDataCenter.Instance.getList.IndexOf(skey);
  
  //尝试获取item
  if (index <> -1) then
  begin
    item := MainWindow.SuccessOrderListView.Items.Item[index];
  end;
  
  //不存在就添加，已经存在就清空
  if (item = nil) then
  begin
    item := MainWindow.SuccessOrderListView.Items.Add;
  end
  else
  begin
    item.SubItems.Clear;
  end;

  item.Caption := Trim(string(p.TradeID));
  item.SubItems.Add(p.InstrumentID);
  case p.Direction of
    '0':
      sPosiDirection := string('买');
    '1':
      sPosiDirection := string('卖');
  end;
  item.SubItems.Add(sPosiDirection);

  case p.OffsetFlag of
  ///开仓
    THOST_FTDC_OF_Open:
      sOffsetFlag := PChar('开');
  ///平仓
    THOST_FTDC_OF_Close:
      sOffsetFlag := PChar('平');
  ///强平
    THOST_FTDC_OF_ForceClose:
      sOffsetFlag := PChar('强平');
  ///平今
    THOST_FTDC_OF_CloseToday:
      sOffsetFlag := PChar('平今');
  ///平昨
    THOST_FTDC_OF_CloseYesterday:
      sOffsetFlag := PChar('平昨');
  ///强减
    THOST_FTDC_OF_ForceOff:
      sOffsetFlag := PChar('强减');
  ///本地强平
    THOST_FTDC_OF_LocalForceClose:
      sOffsetFlag := PChar('本地强平');
  end;
  item.SubItems.Add(sOffsetFlag);
  item.SubItems.Add(FloatToStr(p.Volume));
  item.SubItems.Add(FloatToStr(p.Price));

end;

procedure TDrawView.DrawLogView();
var
  p: PThostFtdcOrderField;
  slog: string;
  slogType: string;
  sPosiDirection: string;
  sOffsetFlag: string;
  sStatus: string;
  sCount: string;
begin
  p := TOrderLogDataCenter.instance.Item;
  case p.Direction of
    '0':
      sPosiDirection := string('买');
    '1':
      sPosiDirection := string('卖');
  end;
  case p.CombOffsetFlag[0] of
  ///开仓
    THOST_FTDC_OF_Open:
      sOffsetFlag := PChar('开');
  ///平仓
    THOST_FTDC_OF_Close:
      sOffsetFlag := PChar('平');
  ///强平
    THOST_FTDC_OF_ForceClose:
      sOffsetFlag := PChar('强平');
  ///平今
    THOST_FTDC_OF_CloseToday:
      sOffsetFlag := PChar('平今');
  ///平昨
    THOST_FTDC_OF_CloseYesterday:
      sOffsetFlag := PChar('平昨');
  ///强减
    THOST_FTDC_OF_ForceOff:
      sOffsetFlag := PChar('强减');
  ///本地强平
    THOST_FTDC_OF_LocalForceClose:
      sOffsetFlag := PChar('本地强平');
  end;

  case p.OrderStatus of
  ///全部成交
    THOST_FTDC_OST_AllTraded:
      sStatus := '成交';
  ///部分成交还在队列中
    THOST_FTDC_OST_PartTradedQueueing:
      sStatus := '部成';
  ///部分成交不在队列中
    THOST_FTDC_OST_PartTradedNotQueueing:
      sStatus := '部成*';
  ///未成交还在队列中
    THOST_FTDC_OST_NoTradeQueueing:
      sStatus := '未成';
  ///未成交不在队列中
    THOST_FTDC_OST_NoTradeNotQueueing:
      sStatus := '未成*';
  ///撤单
    THOST_FTDC_OST_Canceled:
      sStatus := '撤单';
  ///未知
    THOST_FTDC_OST_Unknown:
      sStatus := '未知';
  ///尚未触发
    THOST_FTDC_OST_NotTouched:
      sStatus := '未触';
  ///已触发
    THOST_FTDC_OST_Touched:
      sStatus := '已触';
  end;

  if ((p.OrderSubmitStatus = '4') or (p.OrderSubmitStatus = '5') or (p.OrderSubmitStatus = '6')) then
  begin
    slogType := '[WARN]';
  end
  else
  begin
    slogType := '[INFO]';
  end;

  slog := slogType + TOrderLogDataCenter.instance.getList[TOrderLogDataCenter.instance.getList.Count - 1] + ':' + '(' + p.OrderSysID + ')' + p.InstrumentID;
  if (p.VolumeTraded > 0) then
  begin
    sCount := '(' + IntToStr(p.VolumeTraded) + ')';
  end;

  slog := slog + sPosiDirection + sOffsetFlag + ':' + sStatus + sCount + '///' + p.StatusMsg;
  MainWindow.RichEdit2.Lines.Add(slog);

end;

procedure TDrawView.log(log: string; color: Integer; logType: string);
begin
  TOrderLogDataCenter.instance.logData := '[' + logType + ']' + timetostr(now) + ':' + log;
//  view := TRichEdit(edit);
  TOrderLogDataCenter.instance.logColor := color;
  RunSynchronize(PrintLog);
end;

procedure TDrawView.PrintLog();
var
  view: TRichEdit;
  temp: Integer;
begin
  view := TRichEdit(TOrderLogDataCenter.instance.logView);
  view.Enabled := False;

  temp := Length(view.Text);
  view.Lines.Add(TOrderLogDataCenter.instance.logData);
  view.SelStart := temp;
  view.SelLength := Length(TOrderLogDataCenter.instance.logData) + 2;
  view.SelAttributes.Color := TOrderLogDataCenter.instance.logColor;
//  view.SelStart := temp + view.SelLength;
//  view.SelLength := 0;
//  view.SelAttributes.Color := clBlack;

  view.Enabled := True;
end;

end.

