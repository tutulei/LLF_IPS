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
    //打印debug日志
    procedure log(log: string; color: Integer; logType: string);
    //买5~卖5界面更新
    procedure DrawPriceGrid(ABuyPriceArray: array of Cardinal; ABuyVolumeArray: array of Int64; ASellPriceArray: array of Cardinal; ASellVolumeArray: array of Int64);
  end;

procedure addRichText(edit: TRichEdit; text: TStrings; color: Integer);

implementation

uses
  MainWIN, SysUtils, uContractsSchedule, MATH, StrUtils, Windows, Messages,
  RichEdit, uGlobalInstance, Grids, ChartManager;

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

procedure TDrawView.DrawPriceGrid(ABuyPriceArray: array of Cardinal; ABuyVolumeArray: array of Int64; ASellPriceArray: array of Cardinal; ASellVolumeArray: array of Int64);
var
  pPriceGrid: PStringGrid;
  iCountIndex: Integer;
  iPriceIndex: Integer;
begin
  pPriceGrid := @MainWindow.PriceGrid;
  iCountIndex := 2;
  iPriceIndex := 1;
  pPriceGrid.Cells[0, 0] := '⑤';
  pPriceGrid.Cells[0, 1] := '④';
  pPriceGrid.Cells[0, 2] := '③';
  pPriceGrid.Cells[0, 3] := '②';
  pPriceGrid.Cells[0, 4] := '①';
//  pPriceGrid.Cells[0, 5] := '--------';
  pPriceGrid.Cells[0, 5] := '①';
  pPriceGrid.Cells[0, 6] := '②';
  pPriceGrid.Cells[0, 7] := '③';
  pPriceGrid.Cells[0, 8] := '④';
  pPriceGrid.Cells[0, 9] := '⑤';

  pPriceGrid.Cells[iCountIndex, 0] := FloatToStr(ASellVolumeArray[4]);
  pPriceGrid.Cells[iCountIndex, 1] := FloatToStr(ASellVolumeArray[3]);
  pPriceGrid.Cells[iCountIndex, 2] := FloatToStr(ASellVolumeArray[2]);
  pPriceGrid.Cells[iCountIndex, 3] := FloatToStr(ASellVolumeArray[1]);
  pPriceGrid.Cells[iCountIndex, 4] := FloatToStr(ASellVolumeArray[0]);
//  pPriceGrid.Cells[iCountIndex, 5] := '---------';
  pPriceGrid.Cells[iCountIndex, 5] := FloatToStr(ABuyVolumeArray[0]);
  pPriceGrid.Cells[iCountIndex, 6] := FloatToStr(ABuyVolumeArray[1]);
  pPriceGrid.Cells[iCountIndex, 7] := FloatToStr(ABuyVolumeArray[2]);
  pPriceGrid.Cells[iCountIndex, 8] := FloatToStr(ABuyVolumeArray[3]);
  pPriceGrid.Cells[iCountIndex, 9] := FloatToStr(ABuyVolumeArray[4]);

  if ASellVolumeArray[4] <> 0 then
    pPriceGrid.Cells[iPriceIndex, 0] := IntToStr(ASellPriceArray[4])
  else
    pPriceGrid.Cells[iPriceIndex, 0] := '-';
  if ASellVolumeArray[3] <> 0 then
    pPriceGrid.Cells[iPriceIndex, 1] := FloatToStr(ASellPriceArray[3])
  else
    pPriceGrid.Cells[iPriceIndex, 1] := '-';
  if ASellVolumeArray[2] <> 0 then
    pPriceGrid.Cells[iPriceIndex, 2] := FloatToStr(ASellPriceArray[2])
  else
    pPriceGrid.Cells[iPriceIndex, 2] := '-';
  if ASellVolumeArray[1] <> 0 then
    pPriceGrid.Cells[iPriceIndex, 3] := FloatToStr(ASellPriceArray[1])
  else
    pPriceGrid.Cells[iPriceIndex, 3] := '-';
  if ASellVolumeArray[0] <> 0 then
    pPriceGrid.Cells[iPriceIndex, 4] := FloatToStr(ASellPriceArray[0])
  else
    pPriceGrid.Cells[iPriceIndex, 4] := '-';

//  pPriceGrid.Cells[iPriceIndex, 5] := '-------';

  if ABuyVolumeArray[0] <> 0 then
    pPriceGrid.Cells[iPriceIndex, 5] := FloatToStr(ABuyPriceArray[0])
  else
    pPriceGrid.Cells[iPriceIndex, 5] := '-';
  if ABuyVolumeArray[1] <> 0 then
    pPriceGrid.Cells[iPriceIndex, 6] := FloatToStr(ABuyPriceArray[1])
  else
    pPriceGrid.Cells[iPriceIndex, 6] := '-';
  if ABuyVolumeArray[2] <> 0 then
    pPriceGrid.Cells[iPriceIndex, 7] := FloatToStr(ABuyPriceArray[2])
  else
    pPriceGrid.Cells[iPriceIndex, 7] := '-';
  if ABuyVolumeArray[3] <> 0 then
    pPriceGrid.Cells[iPriceIndex, 8] := FloatToStr(ABuyPriceArray[3])
  else
    pPriceGrid.Cells[iPriceIndex, 8] := '-';
  if ABuyVolumeArray[4] <> 0 then
    pPriceGrid.Cells[iPriceIndex, 9] := FloatToStr(ABuyPriceArray[4])
  else
    pPriceGrid.Cells[iPriceIndex, 9] := '-';
end;

procedure TDrawView.DrawQuotationGridView();
var
  sid: string;
  index: Integer;
  item: TStrings;
  Grid: TStringGrid;
  sChange: string;
  sChangeRate: string;
  dChange: Double;
  dChangeRate: Double;
  tick: PQuotationData;
  dataList: TStrings;
begin
//  MessageBox(0, PChar(GetCurrentThreadId()), '提示', MB_OK);
  //将数据中心的当前数据推到界面
  Grid := MainWindow.FFuturesQuotationGrid;
  sid := TQuotationDataCenter.Instance.GetLastItemKey(FUTURES);
  try
    New(tick);
    Move(PQuotationData(TQuotationDataCenter.Instance.GetItem(sid, FUTURES))^, tick^, SizeOf(TQuotationData));
    index := TQuotationDataCenter.Instance.FFuturesSeatingList.IndexOf(tick.InstrumentID);
    if (index = -1) then
    begin
//      raise Exception.Create('DrawQuotationGridView:无法获取合约index');
      exit;
    end;
      //1确定涨跌和涨跌幅
    if (Grid.Cells[2, index + 1] = '') then
    begin
      sChange := '0';
      sChangeRate := '0%';
    end
    else
    begin
      dChange := tick.LastPrice - tick.PreSettlementPrice;
      sChange := FloatToStr(RoundTo(dChange, -2));
      dChangeRate := RoundTo(dChange / tick.PreSettlementPrice, -4);
      sChangeRate := FloatTostr(dChangeRate * 100) + '%';
    
        //3
    //    if (TQuotationDataCenter.Instance.FFuturesSeatingList[Grid.Row - 1] = tick.InstrumentID) then
    //    begin
    //      updatePriceGrid(tick);
    //    end;
        //2走势图绘制
      if (FFuturesSeriesManager.Find(tick.InstrumentID) <> -1) then
      begin
        DrawChartTimely(string(tick.UpdateTime), tick.LastPrice, TThreeSeriesGroup(FFuturesSeriesManager.GetObjPionter(tick.InstrumentID)).ValueSeries1);
        DrawChartTimely(string(tick.UpdateTime), tick.OpenPrice, TThreeSeriesGroup(FFuturesSeriesManager.GetObjPionter(tick.InstrumentID)).ValueSeries2);
        DrawChartTimely(string(tick.UpdateTime), FFuturesSeriesManager.GetAveragePrice(tick.InstrumentID, tick.LastPrice), TThreeSeriesGroup(FFuturesSeriesManager.GetObjPionter(tick.InstrumentID)).ValueSeries3);
      end;
    //
    //    if (tick.InstrumentID = AvaibleChartId) then
    //    begin
    //      DrawChartTimely(string(tick.UpdateTime), Abs(tick.LastPrice), TwoSeriesChart(FSeriesManager.GetCurrentSeries).ValueSeries1);
    //      DrawChartTimely(string(tick.UpdateTime), tick.OpenPrice, TwoSeriesChart(FSeriesManager.GetCurrentSeries).ValueSeries2);
    //    end;
        //1添加变动信息为变色显示提供依据，数据变小就变成负数，Grid响应事件中会对负数做处理
      if (StrToFloat(Grid.Cells[2, index + 1]) > tick.LastPrice) then
      begin
        tick.LastPrice := -1.0 * tick.LastPrice;
      end;
      if (StrToFloat(Grid.Cells[4, index + 1]) > tick.BidPrice1) then
      begin
        tick.BidPrice1 := -1.0 * tick.BidPrice1;
      end;
      if (StrToFloat(Grid.Cells[6, index + 1]) > tick.AskPrice1) then
      begin
        tick.AskPrice1 := -1.0 * tick.AskPrice1;
      end;
    end;
    
      //1Grid列表数据刷新
    dataList := fQuotationDataTurnToTStrings(tick^, sChange, sChangeRate);
    MainWindow.FFuturesQuotationGrid.Rows[index + 1] := dataList;
  finally
    Dispose(tick);
  end;
//  MessageBox(0, PChar(GetCurrentThreadId()), '提示', MB_OK);
  //将数据中心的当前数据推到界面
//  sid := TQuotationDataCenter.Instance.GetLastItemKey(FUTURES);
//  index := TQuotationDataCenter.Instance.FFuturesSeatingList.IndexOf(sid);
//  MainWindow.FFuturesQuotationGrid.Rows[index + 1] := TStrings(TQuotationDataCenter.Instance.GetItem(sid, FUTURES));
  if (sid = MainWindow.ContractIdComboBox.Text) then
  begin
    MainWindow.SellPriceLabel.Caption := dataList[5];
    MainWindow.BuyPriceLabel.Caption := dataList[3];
  end;

end;

procedure TDrawView.DrawOptionQuotationGridView;
var
  skey: string;
  index: Integer;
  item: TStrings;
  dataList: Tstrings;
  sid: string;
  pOptionMarketData: PDF_OptionMarketData;
  Grid: TStringGrid;
  iNewPrice: Integer;
  iBuyPrice: Integer;
  iSellPrice: Integer;
  StrTime: string;
  tmpstr: string;
  nMarketID: Integer;
  nCodeID: Integer;
  index2: Integer;
  sConteactName: string;
  iStop: Integer;
  iStart: Integer;
begin
  Grid := MainWindow.FOptionQuotationGrid;
//  Writeln('=====>ID:' + PDF_CodeInfo(OptionQuotationCodeList.Objects[codeList.IndexOf(str)]).szID + '未平数:' + IntToStr(pOptionMarketData.iTotalLongPosition) + '总成交数：' + IntToStr(pOptionMarketData.iTradeVolume) + '成交金额：' + FloatToStr(pOptionMarketData.dTotalValueTraded) + '昨结算:' + FloatToStr(pOptionMarketData.unPreSettlPrice) + '涨跌：' + FloatToStr(pOptionMarketData.unSD1));
//  TDrawView.instance.log('=====>ID' + PDF_CodeInfo(TQuotationDataCenter.Instance.OptionQuotationCodeList.Objects[TQuotationDataCenter.Instance.OptionQuotationCodeList.IndexOf(str)]).szID + '未平数:' + IntToStr(pOptionMarketData.iTotalLongPosition) + '总成交数：' + IntToStr(pOptionMarketData.iTradeVolume) + '成交金额：' + FloatToStr(pOptionMarketData.dTotalValueTraded) + '昨结算:' + FloatToStr(pOptionMarketData.unPreSettlPrice) + '涨跌：' + FloatToStr(pOptionMarketData.unSD1), $00004080, IntToStr(I));
//  sBuyPrice := '';
//  for J := 0 to 4 do
//  begin
//    sBuyPrice := sBuyPrice + '|' + IntToStr(pOptionMarketData.arrunBuyPrice_5[J]);
//  end;
//  sSellPrice := '';
//  for J := 0 to 4 do
//  begin
//    sSellPrice := sSellPrice + '|' + IntToStr(pOptionMarketData.arrunSellPrice_5[J]);
//  end;
//  sSellCount := '';
//  for J := 0 to 4 do
//  begin
//    sSellCount := sSellCount + '|' + IntToStr(pOptionMarketData.arriSellVolume_5[J]);
//  end;
//  sBuyCount := '';
//  for J := 0 to 4 do
//  begin
//    sBuyCount := sBuyCount + '|' + IntToStr(pOptionMarketData.arriBuyVolume_5[J]);
//  end;
  skey := TQuotationDataCenter.Instance.GetLastItemKey(OPTION);
  index := TQuotationDataCenter.Instance.FOptionSeatingList.IndexOf(skey);

  if (index = -1) then
  begin
    Exit;
  end;

  try
    New(pOptionMarketData);
    Move(PDF_OptionMarketData(TQuotationDataCenter.Instance.GetItem(skey, OPTION))^, pOptionMarketData^, SizeOf(TDF_OptionMarketData));
    if (Grid.Cells[2, index + 1] <> '') then
    begin
      //1添加变动信息为变色显示提供依据，数据变小就变成负数，Grid响应事件中会对负数做处理
      if (StrToInt(Grid.Cells[1, index + 1]) > pOptionMarketData.unTradePrice) then
      begin
        iNewPrice := -1 * pOptionMarketData.unTradePrice;
      end;
      if (StrToInt(Grid.Cells[3, index + 1]) > pOptionMarketData.arrunBuyPrice_5[0]) then
      begin
        iBuyPrice := -1 * pOptionMarketData.arrunBuyPrice_5[0];
      end;
      if (StrToInt(Grid.Cells[5, index + 1]) > pOptionMarketData.arrunSellPrice_5[0]) then
      begin
        iSellPrice := -1 * pOptionMarketData.arrunSellPrice_5[0];
      end;
    end;
    if (iNewPrice = 0) then
    begin
      iNewPrice := pOptionMarketData.unTradePrice;
      iBuyPrice := pOptionMarketData.arrunBuyPrice_5[0];
      iSellPrice := pOptionMarketData.arrunSellPrice_5[0];
    end;

    sid := skey;
    dataList := TStringList.Create;
    StrTime := '';
    tmpstr := IntToStr(pOptionMarketData.nTime div 10000000);
    if (Length(tmpstr) = 1) then
    begin
      StrTime := StrTime + '0';
    end;
    StrTime := StrTime + tmpstr;
    tmpstr := IntToStr((pOptionMarketData.nTime mod 10000000) div 100000);
    StrTime := StrTime + ':';
    if (Length(tmpstr) = 1) then
    begin
      StrTime := StrTime + '0';
    end;
    StrTime := StrTime + tmpstr;
    tmpstr := IntToStr((pOptionMarketData.nTime mod 100000) div 1000);
    StrTime := StrTime + ':';
    if (Length(tmpstr) = 1) then
    begin
      StrTime := StrTime + '0';
    end;
    StrTime := StrTime + tmpstr;
    //走势图绘制
    if (FOptionSeriesManager.Find(skey) <> -1) then
    begin
      DrawChartTimely(StrTime, pOptionMarketData.unTradePrice, TThreeSeriesGroup(FOptionSeriesManager.GetObjPionter(sid)).ValueSeries1);
      DrawChartTimely(StrTime, pOptionMarketData.unOpenPrice, TThreeSeriesGroup(FOptionSeriesManager.GetObjPionter(sid)).ValueSeries2);
      DrawChartTimely(StrTime, FOptionSeriesManager.GetAveragePrice(sid, pOptionMarketData.unTradePrice), TThreeSeriesGroup(FOptionSeriesManager.GetObjPionter(sid)).ValueSeries3);
    end;

    nMarketID := pOptionMarketData.nIdnum mod 100;
    nCodeID := pOptionMarketData.nIdnum div 100;

    index2 := TQuotationDataCenter.Instance.OptionQuotationCodeList.IndexOf(IntToStr(nMarketID) + ',' + IntToStr(nCodeID));
    sConteactName := PDF_CodeInfo(TQuotationDataCenter.Instance.OptionQuotationCodeList.Objects[index2]).szName;
    dataList.DelimitedText := sConteactName + ',' + IntToStr(iNewPrice) + ',' + IntToStr(Integer(pOptionMarketData.unSD1)) + ',' + IntToStr(iBuyPrice) + ',' + IntToStr(pOptionMarketData.arriBuyVolume_5[0]) + ',' + IntToStr(iSellPrice) + ',' + IntToStr(pOptionMarketData.arriSellVolume_5[0]) + ',' + IntToStr(pOptionMarketData.unPreSettlPrice) + ',' + IntToStr(pOptionMarketData.unOpenPrice) + ',' + IntToStr(pOptionMarketData.unHighPrice) + ',' + IntToStr(pOptionMarketData.unLowPrice) + ',' + IntToStr(pOptionMarketData.iTradeVolume) + ',' + FloatToStr(pOptionMarketData.dTotalValueTraded) + ',' + sid + ',' + StrTime;
    //交易看板绘制
    if (MainWindow.PriceGrid.Visible) and (sid = MainWindow.ContractIdComboBox.Text) then
    begin
      DrawPriceGrid(pOptionMarketData.arrunBuyPrice_5, pOptionMarketData.arriBuyVolume_5, pOptionMarketData.arrunSellPrice_5, pOptionMarketData.arriSellVolume_5);
    end;
  finally
    Dispose(pOptionMarketData);
  end;

//TQuotationDataCenter.Instance.addItem(PDF_CodeInfo(TQuotationDataCenter.Instance.OptionQuotationCodeList.Objects[TQuotationDataCenter.Instance.OptionQuotationCodeList.IndexOf(str)]).szID, dataList, OPTION);
//  Writeln('=====>ID:' + PDF_CodeInfo(OptionQuotationCodeList.Objects[codeList.IndexOf(str)]).szID + '未平数:' + IntToStr(pOptionMarketData.iTotalLongPosition) + '总成交数：' + IntToStr(pOptionMarketData.iTradeVolume) + '成交金额：' + FloatToStr(pOptionMarketData.dTotalValueTraded) + '昨结算:' + FloatToStr(pOptionMarketData.unPreSettlPrice) + '涨跌：' + FloatToStr(pOptionMarketData.unSD1));

  MainWindow.FOptionQuotationGrid.Rows[index + 1] := dataList;
  dataList.Destroy;
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

