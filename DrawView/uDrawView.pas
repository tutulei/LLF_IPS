unit uDrawView;

interface

uses
  uDataCenter, Classes, uDataStruct, IdGlobal, Graphics, ComCtrls, uConstants,
  SyncObjs;

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

    //行情界面刷新
    procedure DrawQuotationGridView();
    procedure DrawOptionQuotationGridView();
    procedure DrawActualsQuotationGridView();
    procedure DrawIndexQuotationGridView();

    //持仓界面刷新
    procedure DrawPositionListView();
    //持仓Item更新
    procedure DrawFuturesPositionItem(pitem: TListItem; pdata: PThostFtdcInvestorPositionField);
    procedure DrawOptionPositionItem(pitem: TListItem; pdata: PCJGtdcOptionRspQryHold);
    procedure DrawActualsPositionItem(pitem: TListItem; pdata: PCJGtdcRspQryHold);

    //已提交订单界面刷新
    procedure DrawOrderView();
    //已提交订单item更新
    procedure DrawFuturesOrderItem(pItem: TListItem; pdata: PThostFtdcOrderField);
    procedure DrawOptionOrderItem(pItem: TListItem; pdata: PCJGtdcOptionRspQryEntrust);
    procedure DrawActualsOrderItem(pItem: TListItem; pdata: PCJGtdcRspQryOrder);

    //成交订单界面更新
    procedure DrawSuccessOrderView();
    //成交订单item更新
    procedure DrawFuturesSuccessOrderItem(pItem: TListItem; pdata: PThostFtdcTradeField);
    procedure DrawOptionSuccessOrderItem(pItem: TListItem; pdata: PCJGtdcOptionRspQryBusByPos);
    procedure DrawActualsSuccessOrderItem(pItem: TListItem; pdata: PCJGtdcRspQryTrade);

    //未成交单界面更新 期货的实现在成交单之中了
    procedure DrawNoDealOrderView();
    

    //资金状况刷新
    procedure DrawAccountCapital();

    //    procedure DrawFuturesQuotationGridView();
    //订单响应更新至文本窗口
    procedure PushOrderToCommandWindows();



    //日志更新
    procedure DrawLogView();
    //打印debug日志
    procedure log(log: string; color: Integer; logType: string);
    //买5~卖5界面更新
    procedure DrawPriceGrid(ABuyPriceArray: array of Extended; ABuyVolumeArray: array of Int64; ASellPriceArray: array of Extended; ASellVolumeArray: array of Int64);
  end;

procedure addRichText(edit: TRichEdit; text: TStrings; color: Integer);

implementation

uses
  MainWIN, SysUtils, uContractsSchedule, MATH, StrUtils, Windows, Messages,
  RichEdit, uGlobalInstance, Grids, ChartManager, uMainFunctions;

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

//更新资金界面
procedure TDrawView.DrawAccountCapital;
var
  myType: ContractType;
  pfuturesdata: PThostFtdcTradingAccountField;
  poptiondata: PCJGtdcOptionRspQryFund;
  pactualsdata: PCJGtdcRspQryFund;
  p: Pointer;
begin
  myType := getCurrentType();
  p := TradingAccountField[Integer(myType)];
  if ((myType = ACTUALSINDEX) or (p = nil)) then
    Exit;

  case myType of
    FUTURES:
      begin
        pfuturesdata := TradingAccountField[Integer(myType)];

        MainWindow.TopGrid.Cells[0, 1] := FloatToStr(RoundTo(pfuturesdata.Available, 2));
        MainWindow.TopGrid.Cells[1, 1] := FloatToStr(RoundTo(pfuturesdata.CloseProfit, 2));
        MainWindow.TopGrid.Cells[2, 1] := FloatToStr(RoundTo(pfuturesdata.PositionProfit, 2));
      end;
    OPTION:
      begin
        poptiondata := TradingAccountField[Integer(myType)];

        MainWindow.TopGrid.Cells[0, 1] := FloatToStr(RoundTo(poptiondata.EnableBalance, 2));
        MainWindow.TopGrid.Cells[1, 1] := FloatToStr(RoundTo(poptiondata.Income, 2));
        MainWindow.TopGrid.Cells[2, 1] := FloatToStr(RoundTo(poptiondata.EnableBail, 2));
      end;
    ACTUALS:
      begin
        pactualsdata := TradingAccountField[Integer(myType)];
        MainWindow.TopGrid.Cells[0, 1] := FloatToStr(RoundTo(pactualsdata.EnableBalance, 2));
        MainWindow.TopGrid.Cells[1, 1] := FloatToStr(RoundTo(pactualsdata.Income, 2));
        MainWindow.TopGrid.Cells[2, 1] := FloatToStr(RoundTo(pactualsdata.AssetBalance, 2));
      end;
  end;

end;

procedure TDrawView.DrawActualsQuotationGridView;
var
  skey: string;
  index: Integer;
  pActualsMarketData: PDFDAPI_MARKET_DATA;
  Grid: TStringGrid;
  dataList: TStrings;
  stmp: string;
  sName: string;
  count: Integer;
  codemsg: PDFDAPI_CODEINFO;
  iType: Integer;
  sid: string;
  StrTime: string;
  tmpstr: string;
  newPrice: double;
  openPrice: Double;
  askPrice: array[0..4] of Extended;
  bidPrice: array[0..4] of Extended;
  askVol: array[0..4] of Int64;
  bidVol: array[0..4] of Int64;
  I: Integer;
begin
  Grid := MainWindow.FActualsQuotationGrid;

  skey := TQuotationDataCenter.Instance.getLastItem(ACTUALS);
  index := TQuotationDataCenter.Instance.FActualsSeatingList.IndexOf(skey);
  if (index = -1) then
  begin
    Exit;
  end;

  try
    if (FActualsQuotationProxy.CodeListReceived = False) then
    begin
      exit;
    end;
    New(pActualsMarketData);
    Move(PDFDAPI_MARKET_DATA(TQuotationDataCenter.Instance.GetItem(skey, ACTUALS))^, pActualsMarketData^, SizeOf(DFDAPI_MARKET_DATA));

    sid := skey;
    StrTime := '';
    tmpstr := IntToStr(pActualsMarketData.nTime div 10000000);
    if (Length(tmpstr) = 1) then
    begin
      StrTime := StrTime + '0';
    end;
    StrTime := StrTime + tmpstr;
    tmpstr := IntToStr((pActualsMarketData.nTime mod 10000000) div 100000);
    StrTime := StrTime + ':';
    if (Length(tmpstr) = 1) then
    begin
      StrTime := StrTime + '0';
    end;
    StrTime := StrTime + tmpstr;
    tmpstr := IntToStr((pActualsMarketData.nTime mod 100000) div 1000);
    StrTime := StrTime + ':';
    if (Length(tmpstr) = 1) then
    begin
      StrTime := StrTime + '0';
    end;
    StrTime := StrTime + tmpstr;
    newPrice := pActualsMarketData.nMatch / 10000;
    openPrice := pActualsMarketData.nOpen / 10000;
    //走势图绘制
    if (FActualsSeriesManager.Find(skey) <> -1) then
    begin
      DrawChartTimely(StrTime, newPrice, TThreeSeriesGroup(FActualsSeriesManager.GetObjPionter(sid)).ValueSeries1);
      DrawChartTimely(StrTime, openPrice, TThreeSeriesGroup(FActualsSeriesManager.GetObjPionter(sid)).ValueSeries2);
      DrawChartTimely(StrTime, FActualsSeriesManager.GetAveragePrice(sid, newPrice), TThreeSeriesGroup(FActualsSeriesManager.GetObjPionter(sid)).ValueSeries3);
    end;

    for I := 0 to 4 do
    begin
      askVol[I] := Round(pActualsMarketData.nAskVol[I] / 100);
      askPrice[I] := pActualsMarketData.nAskPrice[I] / 10000;
      bidVol[I] := Round(pActualsMarketData.nBidVol[I] / 100);
      bidPrice[I] := pActualsMarketData.nBidPrice[I] / 10000;
    end;
    //交易看板绘制
    if (MainWindow.PriceGrid.Visible) and (sid = MainWindow.ContractIdComboBox.Text) then
    begin
      DrawPriceGrid(askPrice, askVol, bidPrice, bidVol);
    end;

    dataList := TStringList.Create;
//    count := TQuotationDataCenter.Instance.ActualsQuotationCodeList.Count;
    codemsg := PDFDAPI_CODEINFO(TQuotationDataCenter.Instance.ActualsQuotationCodeList.Objects[TQuotationDataCenter.Instance.ActualsQuotationCodeList.IndexOf(skey)]);
    sName := codemsg.szCNName;
    iType := codemsg.nType;
    stmp := 'sName,' + FloatToStr(pActualsMarketData.nMatch / 10000) + ',' + FloatToStr(pActualsMarketData.nSD2 / 10000) + ',' + FloatToStr(pActualsMarketData.nBidPrice[0] / 10000) + ',' + FloatToStr(pActualsMarketData.nBidVol[0] / 100) + ',' + FloatToStr(pActualsMarketData.nAskPrice[0] / 10000) + ',' + FloatToStr(pActualsMarketData.nAskVol[0] / 100) + ',' + FloatToStr(pActualsMarketData.nPreClose / 10000) + ',' + FloatToStr(pActualsMarketData.nOpen / 10000) + ',' + FloatToStr(pActualsMarketData.nHighLimited / 10000) + ',' + FloatToStr(pActualsMarketData.nLowLimited / 10000) + ',' + FloatToStr(pActualsMarketData.iVolume / 100) + ',' + IntToStr(pActualsMarketData.iTurnover) + ',' + pActualsMarketData.szCode + ',' + StrTime;
    StringReplace(stmp, ' ', '_', [rfReplaceAll]);
    dataList.DelimitedText := stmp;

  finally
    Dispose(pActualsMarketData);
  end;
  Grid.Rows[index + 1] := dataList;
  Grid.Cells[0, index + 1] := sName;
end;

procedure TDrawView.DrawActualsSuccessOrderItem(pItem: TListItem; pdata: PCJGtdcRspQryTrade);
begin

end;

procedure TDrawView.DrawIndexQuotationGridView;
var
  skey: string;
  index: Integer;
  pIndexMarketData: PDFDAPI_INDEX_DATA;
  Grid: TStringGrid;
  dataList: TStrings;
  stmp: string;
  sName: string;
//  count: Integer;
  codemsg: PDFDAPI_CODEINFO;
  iType: Integer;
begin
  Grid := MainWindow.FIndexQuotationGrid;

  skey := TQuotationDataCenter.Instance.GetLastItemKeyIndex();
  index := TQuotationDataCenter.Instance.FIndexSeatingList.IndexOf(skey);
  if (index = -1) then
  begin
    Exit;
  end;

  try
    if (FActualsQuotationProxy.CodeListReceived = False) then
    begin
      exit;
    end;
    New(pIndexMarketData);
    Move(PDFDAPI_MARKET_DATA(TQuotationDataCenter.Instance.GetItem(skey, ACTUALSINDEX))^, pIndexMarketData^, SizeOf(DFDAPI_INDEX_DATA));
    dataList := TStringList.Create;
//    count := TQuotationDataCenter.Instance.ActualsQuotationCodeList.Count;
    codemsg := PDFDAPI_CODEINFO(TQuotationDataCenter.Instance.ActualsQuotationCodeList.Objects[TQuotationDataCenter.Instance.ActualsQuotationCodeList.IndexOf(skey)]);
    sName := codemsg.szCNName;
    iType := codemsg.nType;
    stmp := 'sName,' + FloatToStr(pIndexMarketData.nOpenIndex / 10000) + ',' + FloatToStr(pIndexMarketData.nLastIndex / 10000) + ',' + FloatToStr(pIndexMarketData.nHighIndex / 10000) + ',' + FloatToStr(pIndexMarketData.nLowIndex / 10000) + ',' + FloatToStr(pIndexMarketData.iTotalVolume / 10000) + ',' + FloatToStr(pIndexMarketData.iTurnover / 10000) + ',' + FloatToStr(pIndexMarketData.nPreCloseIndex / 10000) + ',' + string(pIndexMarketData.szCode) + ',' + FloatToStr(pIndexMarketData.nActionDay / 10000);
    dataList.DelimitedText := stmp;
  finally
    Dispose(pIndexMarketData);
  end;
  Grid.Rows[index + 1] := dataList;
  Grid.Cells[0, index + 1] := sName;
end;

procedure TDrawView.DrawPositionListView();
var
  p: Pointer;
  item: TListItem;
  PosiDirection: PChar;
  index: Integer;
  skey: string;
  myType: ContractType;
begin
  index := -1;
  myType := getCurrentType();
//  MessageBox(0, PChar('[DrawPositionListView] run'), 'Waring', IDOK);
  p := TPositionDataCenter.Instance.Item(myType);
  if (p = nil) then
  begin
    Exit;
  end;

  skey := TPositionDataCenter.Instance.getLastItem(myType);
  index := TPositionDataCenter.Instance.getList(myType).IndexOf(skey);


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
  case myType of
    FUTURES:
      DrawFuturesPositionItem(item, p);
    OPTION:
      DrawOptionPositionItem(item, p);
    ACTUALS:
      DrawActualsPositionItem(item, p);
  end;
end;

procedure TDrawView.DrawFuturesPositionItem(pitem: TListItem; pdata: PThostFtdcInvestorPositionField);
var
  PosiDirection: PChar;
begin
  if (pdata.Position = 0) then
  begin
    Exit;
  end;
  pitem.Caption := pdata.InstrumentID;
  case pdata.PosiDirection of
    THOST_FTDC_PD_Net:
      PosiDirection := PChar('  净');
    THOST_FTDC_PD_Long:
      PosiDirection := PChar('买');
    THOST_FTDC_PD_Short:
      PosiDirection := PChar('     卖');
  end;
  pitem.SubItems.Add(PosiDirection);
  pitem.SubItems.Add(FloatToStr(pdata.Position));
  pitem.SubItems.Add(FloatToStr(pdata.Position - pdata.TodayPosition));
  pitem.SubItems.Add(FloatToStr(pdata.TodayPosition));
  pitem.SubItems.Add(FloatToStr(RoundTo(pdata.PositionProfit, -2)));
  pitem.SubItems.Add(FloatToStr(pdata.UseMargin));
//  list := tradeProxy.CheckPosition();
end;

procedure TDrawView.DrawOptionPositionItem(pitem: TListItem; pdata: PCJGtdcOptionRspQryHold);
var
  sOptionType: string;
begin
  if (pdata.OptionAmount = 0) then
  begin
    Exit;
  end;
  pitem.Caption := pdata.ContractCode;
  ///认购
  //	JG_TDC_OPTIONTYPE_Call		'0'
  ///认沽
  // JG_TDC_OPTIONTYPE_Put		'1'
  case pdata.OptionType of
    '0':
      sOptionType := '认购';
    '1':
      sOptionType := '认沽';
  end;
  pitem.SubItems.Add(sOptionType);
  pitem.SubItems.Add(IntToStr(pdata.OptionAmount));
  pitem.SubItems.Add(IntToStr(pdata.OptionYDAmount));
  pitem.SubItems.Add(IntToStr(pdata.OptionAmount - pdata.OptionYDAmount));
  pitem.SubItems.Add(FloatToStr(RoundTo(pdata.HoldIncome, -2)));
  pitem.SubItems.Add(FloatToStr(pdata.BailBalance));
end;

procedure TDrawView.DrawActualsPositionItem(pitem: TListItem; pdata: PCJGtdcRspQryHold);
begin
  if (pdata.StockAmount = 0) then
  begin
    Exit;
  end;
  pitem.Caption := pdata.StockCode;
  pitem.SubItems.Add('-');
  pitem.SubItems.Add(IntToStr(pdata.StockAmount));
  pitem.SubItems.Add(IntToStr(pdata.YdAmount));
  pitem.SubItems.Add(IntToStr(pdata.StockAmount - pdata.YdAmount));
  pitem.SubItems.Add(FloatToStr(RoundTo(pdata.FloatIncome, -2)));
  pitem.SubItems.Add(FloatToStr(pdata.KeepCostPrice));
end;

procedure TDrawView.DrawPriceGrid(ABuyPriceArray: array of Extended; ABuyVolumeArray: array of Int64; ASellPriceArray: array of Extended; ASellVolumeArray: array of Int64);
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
    pPriceGrid.Cells[iPriceIndex, 0] := FloatToStr(ASellPriceArray[4])
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
  sid := TQuotationDataCenter.Instance.getLastItem(FUTURES);
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
  askVol: array[0..4] of Int64;
  askPrice: array[0..4] of Extended;
  bidVol: array[0..4] of Int64;
  bidPrice: array[0..4] of Extended;
  I: Integer;
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
  skey := TQuotationDataCenter.Instance.getLastItem(OPTION);
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
      if (StrTofloat(Grid.Cells[1, index + 1]) * 10000 > pOptionMarketData.unTradePrice) then
      begin
//        Writeln('unTradePrice:' + IntToStr(pOptionMarketData.unTradePrice));
        iNewPrice := -1 * Integer(pOptionMarketData.unTradePrice);
      end;
//      Writeln('iNewPrice:' + IntTosTr(iNewPrice));
      if (StrTofloat(Grid.Cells[3, index + 1]) * 10000 > pOptionMarketData.arrunBuyPrice_5[0]) then
      begin
//        Writeln('arrunBuyPrice_5:' + IntToStr(pOptionMarketData.arrunBuyPrice_5[0]));
        iBuyPrice := -1 * Integer(pOptionMarketData.arrunBuyPrice_5[0]);
      end;
//      Writeln('iBuyPrice:' + IntToStr(iBuyPrice));
      if (StrTofloat(Grid.Cells[5, index + 1]) * 10000 > pOptionMarketData.arrunSellPrice_5[0]) then
      begin
//        Writeln('arrunSellPrice_5:' + IntToStr(pOptionMarketData.arrunSellPrice_5[0]));
        iSellPrice := -1 * Integer(pOptionMarketData.arrunSellPrice_5[0]);
      end;
//      Writeln('iSellPrice:' + IntToStr(iSellPrice));
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

    dataList.DelimitedText := sConteactName + ',' + FloatToStr(iNewPrice / 10000) + ',' + FloatToStr(Integer(pOptionMarketData.unSD1) / 10000) + ',' + FloatToStr(iBuyPrice / 10000) + ',' + IntToStr(pOptionMarketData.arriBuyVolume_5[0]) + ',' + floatToStr(iSellPrice / 10000) + ',' + IntToStr(pOptionMarketData.arriSellVolume_5[0]) + ',' + FloatToStr(pOptionMarketData.unPreSettlPrice / 10000) + ',' + FloatToStr(pOptionMarketData.unOpenPrice / 10000) + ',' + FloatToStr(pOptionMarketData.unHighPrice / 10000) + ',' + floatToStr(pOptionMarketData.unLowPrice / 10000) + ',' + IntToStr(pOptionMarketData.iTradeVolume) + ',' + FloatToStr(pOptionMarketData.dTotalValueTraded) + ',' + sid + ',' + StrTime;

    //交易看板绘制
    if (MainWindow.PriceGrid.Visible) and (sid = MainWindow.ContractIdComboBox.Text) then
    begin
      for I := 0 to 4 do
      begin
        askVol[I] := pOptionMarketData.arriBuyVolume_5[I];
        askPrice[I] := pOptionMarketData.arrunBuyPrice_5[I] / 10000;
        bidVol[I] := pOptionMarketData.arriSellVolume_5[I];
        bidPrice[I] := pOptionMarketData.arrunSellPrice_5[I] / 10000;
      end;
      DrawPriceGrid(askPrice, askVol, bidPrice, bidVol);
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
  myType: ContractType;
begin
  myType := getCurrentType();
  temp := MainWindow.RichEdit1.SelStart;
  MainWindow.RichEdit1.Lines.Add('');
  addRichText(MainWindow.RichEdit1, TStrings(TCommandWindowsDataCenter.instance.Item(myType)), clBlue);
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
  index: Integer;
  p: Pointer;
  skey: string;
  myType: ContractType;
begin
  myType := getCurrentType;
  p := TOrderDataCenter.Instance.Item(myType);
  if (p = nil) then
  begin
    Exit;
  end;
  skey := TOrderDataCenter.instance.getLastItem(myType);
  index := TOrderDataCenter.Instance.getList(myType).IndexOf(skey);

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
  case myType of
    FUTURES:
      DrawFuturesOrderItem(item, p);
    OPTION:
      DrawOptionOrderItem(item, p);
    ACTUALS:
      DrawActualsOrderItem(item, p);
  end;

end;

procedure TDrawView.DrawFuturesOrderItem(pItem: TListItem; pdata: PThostFtdcOrderField);
var
  sPosiDirection: string;
  sOffsetFlag: string;
  sOrderStatus: string;
  inodealIndex: Integer;
  nodealItem: TListItem;
begin

  pItem.Caption := Trim(string(pdata.OrderSysID));
  pItem.SubItems.Add(pdata.InstrumentID);
  case pdata.Direction of
    '0':
      sPosiDirection := string('买');
    '1':
      sPosiDirection := string('  卖');
  end;
  pItem.SubItems.Add(sPosiDirection);

  case pdata.CombOffsetFlag[0] of
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
  pItem.SubItems.Add(sOffsetFlag);

  case pdata.OrderStatus of
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
  pItem.SubItems.Add(sOrderStatus);
  pItem.SubItems.Add(FloatToStr(pdata.LimitPrice));
  pItem.SubItems.Add(IntToStr(pdata.VolumeTotalOriginal));
  pItem.SubItems.Add(IntToStr(pdata.VolumeTotal));
  pItem.SubItems.Add(IntToStr(pdata.VolumeTraded));
//  pItem.SubItems.Add(pdata.OrderRef);
//  pItem.SubItems.Add(pdata.StatusMsg);
  pItem.SubItems.Add(pdata.InsertTime);

  if (TOrderDataCenter.Instance.getNoDealList.Count = MainWindow.noDealListView.Items.Count) then
  begin
    inodealIndex := TOrderDataCenter.Instance.getNoDealList.IndexOf(IntToStr(pdata.BrokerOrderSeq));
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
  nodealItem.Caption := Trim(string(pdata.InstrumentID));
  nodealItem.SubItems.Add(sPosiDirection);
  nodealItem.SubItems.Add(sOffsetFlag);
  nodealItem.SubItems.Add(FloatToStr(pdata.LimitPrice));
  nodealItem.SubItems.Add(IntToStr(pdata.VolumeTotalOriginal));
  nodealItem.SubItems.Add(IntToStr(pdata.VolumeTotal));
  nodealItem.SubItems.Add(IntToStr(pdata.BrokerOrderSeq));
  nodealItem.SubItems.Add(pdata.InsertTime);
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

procedure TDrawView.DrawOptionOrderItem(pItem: TListItem; pdata: PCJGtdcOptionRspQryEntrust);
var
  sTradeType: string;
  sOffsetType: string;
  sEntrustStatus: string;
begin
//  pItem.Caption := Trim(string(pdata.EntrustNo));
  pItem.Caption := string(pdata.EntrustNo);
  pItem.SubItems.Add(pdata.ContractCode);
  case pdata.TradeType of
    1:
      sTradeType := '买';
    2:
      sTradeType := '  卖';
  end;
  pItem.SubItems.Add(sTradeType);
  case pdata.OffsetType of
    '0':
      sOffsetType := '开';
    '1':
      sOffsetType := '平';
  end;
  pItem.SubItems.Add(sOffsetType);
  case pdata.EntrustStatus of
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
  pItem.SubItems.Add(sEntrustStatus);
  pItem.SubItems.Add(FloatToStr(pdata.EntrustPrice / 10000));
  pItem.SubItems.Add(IntToStr(pdata.EntrustAmount));
  pItem.SubItems.Add(IntToStr(pdata.EntrustAmount - pdata.BusinessAmount));
  pItem.SubItems.Add(IntToStr(pdata.BusinessAmount));
  pItem.SubItems.Add(IntToStr(pdata.EntrustTime));
end;

procedure TDrawView.DrawActualsOrderItem(pItem: TListItem; pdata: PCJGtdcRspQryOrder);
var
  sTradeType: string;
  sOffsetType: string;
  sEntrustStatus: string;
begin
  pItem.Caption := string(pdata.EntrustNo);
  pItem.SubItems.Add(pdata.StockCode);
  case pdata.TradeType of
    1:
      sTradeType := '买';
    2:
      sTradeType := '  卖';
  end;
  pItem.SubItems.Add(sTradeType);
  pItem.SubItems.Add('-');
  case pdata.EntrustStatus of
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
  pItem.SubItems.Add(sEntrustStatus);
  pItem.SubItems.Add(FloatToStr(pdata.OrderPrice / 10000));
  pItem.SubItems.Add(IntToStr(pdata.OrderVolume));
  pItem.SubItems.Add(IntToStr(pdata.OrderVolume - pdata.BusinessVolume));
  pItem.SubItems.Add(IntToStr(pdata.BusinessVolume));
  pItem.SubItems.Add(IntToStr(pdata.EntrustTime));
end;

procedure TDrawView.DrawSuccessOrderView();
var
  p: Pointer;
  skey: string;
  index: Integer;
  item: TListItem;
  myType: ContractType;
begin
  myType := getCurrentType;
  p := TSuccessOrderDataCenter.Instance.Item(myType);
  if (p = nil) then
  begin
    Exit;
  end;
  skey := TSuccessOrderDataCenter.instance.getLastItem(myType);
  index := TSuccessOrderDataCenter.Instance.getList(myType).IndexOf(skey);

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
  case myType of
    FUTURES:
      DrawFuturesSuccessOrderItem(item, p);
    OPTION:
      DrawOptionSuccessOrderItem(item, p);
    ACTUALS:
      DrawActualsSuccessOrderItem(item, p);
  end;

end;

procedure TDrawView.DrawFuturesSuccessOrderItem(pItem: TListItem; pdata: PThostFtdcTradeField);
var
  sPosiDirection: string;
  sOffsetFlag: string;
begin
  pItem.Caption := Trim(string(pdata.TradeID));
  pItem.SubItems.Add(pdata.InstrumentID);
  case pdata.Direction of
    '0':
      sPosiDirection := string('买');
    '1':
      sPosiDirection := string('卖');
  end;
  pItem.SubItems.Add(sPosiDirection);

  case pdata.OffsetFlag of
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
  pItem.SubItems.Add(sOffsetFlag);
  pItem.SubItems.Add(FloatToStr(pdata.Volume));
  pItem.SubItems.Add(FloatToStr(pdata.Price));

end;

procedure TDrawView.DrawOptionSuccessOrderItem(pItem: TListItem; pdata: PCJGtdcOptionRspQryBusByPos);
var
  sPosiDirection: string;
  sOffsetFlag: string;
begin
//  pItem.Caption := Trim(string(pdata.BusinessNo));
  pItem.Caption := string(pdata.BusinessNo);
  pItem.SubItems.Add(pdata.ContractCode);
  case pdata.TradeType of
    1:
      sPosiDirection := string('买');
    2:
      sPosiDirection := string('  卖');
  end;
  pItem.SubItems.Add(sPosiDirection);
  case pdata.OffsetType of
    '0':
      sOffsetFlag := string('开');
    '1':
      sOffsetFlag := string('平');
    '2':
      sOffsetFlag := string('平今');
  end;
  pItem.SubItems.Add(sOffsetFlag);
  pItem.SubItems.Add(IntToStr(pdata.BusinessAmount));
  pItem.SubItems.Add(FloatToStr(pdata.BusinessPrice / 10000));
end;

procedure TDrawView.DrawNoDealOrderView;
var
  mytype: ContractType;
  p: Pointer;
  skey: string;
  index: Integer;
  item: TListItem;
begin
  mytype := getCurrentType;
  p := TOrderDataCenter.Instance.NodealItem(mytype);
  if (p = nil) then
  begin
    Exit;
  end;
  skey := TSuccessOrderDataCenter.instance.getLastItem(mytype);
  index := TSuccessOrderDataCenter.Instance.getList(mytype).IndexOf(skey);
  
  //尝试获取item
  if (index <> -1) then
  begin
    item := MainWindow.noDealListView.Items.Item[index];
  end;
  
  //不存在就添加，已经存在就清空
  if (item = nil) then
  begin
    item := MainWindow.noDealListView.Items.Add;
  end
  else
  begin
    item.SubItems.Clear;
  end;
//  case mytype of
//    OPTION:
//     需要实现 DrawNoDealOrderView(item, p);
//    ACTUALS:
//     需要实现  DrawActualsSuccessOrderItem(item, p);
//  end;

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
  myType: ContractType;
begin
  myType := getCurrentType;
  p := TOrderLogDataCenter.instance.Item(myType);
  if (p = nil) then
  begin
    Exit;
  end;
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

  slog := slogType + TOrderLogDataCenter.instance.getList(myType)[TOrderLogDataCenter.instance.getList(myType).count - 1] + ':' + '(' + p.OrderSysID + ')' + p.InstrumentID;
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

