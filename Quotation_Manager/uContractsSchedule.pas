unit uContractsSchedule;
(*
  行情合约调度器
  主要进行合约分配和更新
*)

interface

uses
  uQuotationDataStruct, Grids, Classes, uConstants, SysUtils, Math, Windows,
  ChartManager;

type
  PStringGrid = ^TStringGrid;

  PStringList = ^TStringList;

  TDataSchedule = class(TObject)
    type
      ContractType = (FUTURES, OPTION, ACTUALS);
  private
    pwindow: Pointer;
    pFuturesGrid: PStringGrid;
    pOptionGrid: PStringGrid;
    pActualsGrid: PStringGrid;
    pPriceGrid: PStringgrid;
  public
    //用于存储以订阅的合约以及顺序信息
    FFuturesSeatingList: TStringList;
    FOptionSeatingList: TStringList;
    FActualsSeatingList: TStringList;
        
      //输入 总，期货，期权，现货的grid指针，
//    constructor Create(QHGrid: PStringGrid = nil; QQGrid: PStringGrid = nil; XHGrid: PStringGrid = nil);
    constructor Create(pwin: Pointer);
    destructor Destroy(); override;
      //添加合约记录
    procedure AddContracts(arr: array of PChar);

      //删除合约记录
    procedure RemoveContracts(arr: array of PChar);

      //tick调度
    procedure ScheduleTick(tick: TQuotationData);

      //根据ID判断此合约属于期货、期权还是现货
    function AnalysisType(id: string): ContractType;

      //根据参数返回不同类型的grid
    function getGrid(myType: ContractType): PStringGrid;

    //根据参数返回不同类型的TList
    function getList(myType: ContractType): PStringList;

    //返回类型名称
    function TypeToString(t: ContractType): string;

    procedure updatePriceGrid(tick:TQuotationData);    
  end;

procedure DrawChartTimely(Axvalue: string; Ayvalue: Double; AFastLineSeries: Pointer);

function fQuotationDataTurnToTStrings(data: TQuotationData; change: string; changeRate: string): TStrings;


implementation

uses
  MainWIN, Series;

procedure TDataSchedule.AddContracts(arr: array of PChar);
var
  PID: string;
  grid: PStringGrid;
  pList: PStringList;
  ctype: ContractType;
  tmp: Integer;
begin
  for PID in arr do
  begin
    //判断该合约属于何种类型（期货，期权，现货）
    ctype := AnalysisType(PID);
    grid := getGrid(ctype);
    pList := getList(ctype);
    //可视组件生成行
    tmp := Length(grid.Cells[0, grid.RowCount - 1]);
    if tmp > 0 then
    begin
      grid.RowCount := grid.RowCount + 1;
    end;
    //添加列表中
    pList.Add(string(PID));
    grid.Cells[0, grid.RowCount - 1] := PID;
  end;

end;

procedure TDataSchedule.RemoveContracts(arr: array of PChar);
begin

end;

//tick调度
//tick数据收到之后全部会通过此方法进行数据分发调度到各个需要的地方
(*
数据推送区：
1.Grid行情展示 √
2.Chart走势图展示 √
3.下单面板买卖12345价展示 ×
*)
procedure TDataSchedule.ScheduleTick(tick: TQuotationData);
var
  dataList: TStrings;
  pID: PChar;
  pGrid: PStringGrid;
  pChart: PStringList;
  ctype: ContractType;
  index: Integer;
  sChange: string;
  dChange: Double;
  dChangeRate: Double;
  sChangeRate: string;
begin
  //获取相关组件和变量
  pID := tick.InstrumentID;
  ctype := AnalysisType(strPas(pID));
  pChart := getList(ctype);
  pGrid := getGrid(ctype);
  //打包数据，并且推到组件上刷新
  index := pChart.IndexOf(string(pID));
  if (index = -1) then
  begin
//    MessageBox(0, tick.InstrumentID, '错误ID不存在', MB_OKCANCEL);
    Exit;
  end;

  //1确定涨跌和涨跌幅
  if (pGrid.Cells[2, index + 1] = '') then
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
    if (FFuturesSeatingList[pGrid.Row - 1] = tick.InstrumentID) then
    begin
      updatePriceGrid(tick);
    end;

    //2走势图绘制
    if (FSeriesManager.Find(tick.InstrumentID) <> -1) then
    begin
      DrawChartTimely(string(tick.UpdateTime), tick.LastPrice, TThreeSeriesGroup(FSeriesManager.GetObjPionter(tick.InstrumentID)).ValueSeries1);
      DrawChartTimely(string(tick.UpdateTime), tick.OpenPrice, TThreeSeriesGroup(FSeriesManager.GetObjPionter(tick.InstrumentID)).ValueSeries2);
      DrawChartTimely(string(tick.UpdateTime), FSeriesManager.GetAveragePrice(tick.InstrumentID, tick.LastPrice), TThreeSeriesGroup(FSeriesManager.GetObjPionter(tick.InstrumentID)).ValueSeries3);
    end;
//
//    if (tick.InstrumentID = AvaibleChartId) then
//    begin
//      DrawChartTimely(string(tick.UpdateTime), Abs(tick.LastPrice), TwoSeriesChart(FSeriesManager.GetCurrentSeries).ValueSeries1);
//      DrawChartTimely(string(tick.UpdateTime), tick.OpenPrice, TwoSeriesChart(FSeriesManager.GetCurrentSeries).ValueSeries2);
//    end;
    //1添加变动信息为变色显示提供依据，数据变小就变成负数，Grid响应事件中会对负数做处理
    if (StrToFloat(pGrid.Cells[2, index + 1]) > tick.LastPrice) then
    begin
      tick.LastPrice := -1.0 * tick.LastPrice;
    end;
    if (StrToFloat(pGrid.Cells[4, index + 1]) > tick.BidPrice1) then
    begin
      tick.BidPrice1 := -1.0 * tick.BidPrice1;
    end;
    if (StrToFloat(pGrid.Cells[6, index + 1]) > tick.AskPrice1) then
    begin
      tick.AskPrice1 := -1.0 * tick.AskPrice1;
    end;
  end;

  //1Grid列表数据刷新
  dataList := fQuotationDataTurnToTStrings(tick, sChange, sChangeRate);
  pGrid.Rows[index + 1] := dataList;



end;

procedure TDataSchedule.updatePriceGrid(tick:TQuotationData);
begin

  pPriceGrid.Cells[1, 0] := FloatToStr(tick.AskVolume5);
  pPriceGrid.Cells[1, 1] := FloatToStr(tick.AskVolume4);
  pPriceGrid.Cells[1, 2] := FloatToStr(tick.AskVolume3);
  pPriceGrid.Cells[1, 3] := FloatToStr(tick.AskVolume2);
  pPriceGrid.Cells[1, 4] := FloatToStr(tick.AskVolume1);
  
  pPriceGrid.Cells[1, 5] := FloatToStr(tick.BidVolume1);
  pPriceGrid.Cells[1, 6] := FloatToStr(tick.BidVolume2);
  pPriceGrid.Cells[1, 7] := FloatToStr(tick.BidVolume3);
  pPriceGrid.Cells[1, 8] := FloatToStr(tick.BidVolume4);
  pPriceGrid.Cells[1, 9] := FloatToStr(tick.BidVolume5);
  
  if tick.AskVolume5 <> 0 then
    pPriceGrid.Cells[0, 0] := FloatToStr(tick.AskPrice5)
  else
    pPriceGrid.Cells[0, 0] := '-';
  if tick.AskVolume4 <> 0 then
    pPriceGrid.Cells[0, 1] := FloatToStr(tick.AskPrice4)
  else
    pPriceGrid.Cells[0, 1] := '-';
  if tick.AskVolume3 <> 0 then
    pPriceGrid.Cells[0, 2] := FloatToStr(tick.AskPrice3)
  else
    pPriceGrid.Cells[0, 2] := '-';
  if tick.AskVolume2 <> 0 then
    pPriceGrid.Cells[0, 3] := FloatToStr(tick.AskPrice2)
  else
    pPriceGrid.Cells[0, 3] := '-';
  if tick.AskVolume1 <> 0 then
    pPriceGrid.Cells[0, 4] := FloatToStr(tick.AskPrice1)
  else
    pPriceGrid.Cells[0, 4] := '-';
  if tick.BidVolume1 <> 0 then
    pPriceGrid.Cells[0, 5] := FloatToStr(tick.BidPrice1)
  else
    pPriceGrid.Cells[0, 5] := '-';
  if tick.BidVolume2 <> 0 then
    pPriceGrid.Cells[0, 6] := FloatToStr(tick.BidPrice2)
  else
    pPriceGrid.Cells[0, 6] := '-';
  if tick.BidVolume3 <> 0 then
    pPriceGrid.Cells[0, 7] := FloatToStr(tick.BidPrice3)
  else
    pPriceGrid.Cells[0, 7] := '-';
  if tick.BidVolume4 <> 0 then
    pPriceGrid.Cells[0, 8] := FloatToStr(tick.BidPrice4)
  else
    pPriceGrid.Cells[0, 8] := '-';
  if tick.BidVolume5 <> 0 then
    pPriceGrid.Cells[0, 9] := FloatToStr(tick.BidPrice5)
  else
    pPriceGrid.Cells[0, 9] := '-';
end;  

constructor TDataSchedule.Create(pwin: Pointer);
begin
  pwindow := pwin;
  pFuturesGrid := @(PMainWindow(pwindow).FFuturesQuotationGrid);
  pActualsGrid := @(PMainWindow(pwindow).FOptionQuotationGrid);
  pOptionGrid := @(PMainWindow(pwindow).ActualsQuotationGrid);
  pPriceGrid := @(PMainWindow(pwindow).PriceGrid);  
  FFuturesSeatingList := TStringList.Create();
  FOptionSeatingList := TStringList.Create();
  FActualsSeatingList := TStringList.Create();
end;

destructor TDataSchedule.Destroy();
begin
  FFuturesSeatingList.Free;
  FOptionSeatingList.Free;
  FActualsSeatingList.Free;
  inherited;
end;

function TDataSchedule.AnalysisType(id: string): ContractType;
begin
  Result := FUTURES;
end;

function fQuotationDataTurnToTStrings(data: TQuotationData; change: string; changeRate: string): TStrings;
var
  tmp: TStrings;
begin
  tmp := TStringList.Create;
  tmp.DelimitedText := data.InstrumentID + ',' + data.ExchangeInstID + ',' + FloatToStr(data.LastPrice) + ',' + change + ',' + FloatToStr(data.BidPrice1) + ',' + IntToStr(data.BidVolume1) + ',' + FloatToStr(data.AskPrice1) + ',' + IntToStr(data.AskVolume1) + ',' + '成交量' + ',' + FloatToStr(data.OpenInterest) + ',' + FloatToStr(data.UpperLimitPrice) + ',' + FloatToStr(data.LowerLimitPrice) + ',' + FloatToStr(data.OpenPrice) + ',' + FloatToStr(data.PreSettlementPrice) + ',' + FloatToStr(data.HighestPrice) + ',' + FloatToStr(data.LowestPrice) + ',' + IntToStr(data.Volume) + ',' + changeRate + ',' + FloatToStr(data.PreClosePrice) + ',' + FloatToStr(data.Turnover) + ',' + 'jys' + ',' + data.UpdateTime;
  Result := tmp;

end;

function TDataSchedule.getGrid(myType: ContractType): PStringGrid;
begin
  if myType = FUTURES then
  begin
    Result := pFuturesGrid;
  end
  else if myType = OPTION then
  begin
    Result := pOptionGrid;
  end
  else if myType = ACTUALS then
  begin
    Result := pActualsGrid;
  end;
end;

function TDataSchedule.getList(myType: ContractType): PStringList;
begin
  if myType = FUTURES then
  begin
    Result := @FFuturesSeatingList;
  end
  else if myType = OPTION then
  begin
    Result := @FOptionSeatingList;
  end
  else if myType = ACTUALS then
  begin
    Result := @FActualsSeatingList;
  end;
end;

function TDataSchedule.TypeToString(t: ContractType): string;
begin
  if t = FUTURES then
  begin
    Result := '期货';
  end
  else if t = OPTION then
  begin
    Result := '期权';
  end
  else if t = ACTUALS then
  begin
    Result := '现货';
  end;
end;

procedure DrawChartTimely(Axvalue: string; Ayvalue: Double; AFastLineSeries: Pointer);
begin
  TFastLineSeries(AFastLineSeries).Add(Ayvalue, Axvalue);
end;

end.

