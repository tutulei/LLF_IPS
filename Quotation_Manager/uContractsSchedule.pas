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
    FFuturesGrid: PStringGrid;
    FOptionGrid: PStringGrid;
    FActualsGrid: PStringGrid;
  public
    //用于存储以订阅的合约以及顺序信息
    FFuturesSeatingList: TStringList;
    FOptionSeatingList: TStringList;
    FActualsSeatingList: TStringList;
        
      //输入 总，期货，期权，现货的grid指针，
    constructor Create(QHGrid: PStringGrid = nil; QQGrid: PStringGrid = nil; XHGrid: PStringGrid = nil);
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

  //确定涨跌和涨跌幅
  if (pGrid.Cells[2, index + 1] = '') then
  begin
    sChange := '0';
    sChangeRate := '0%'
  end
  else
  begin
    dChange := tick.LastPrice - tick.PreSettlementPrice;
    sChange := FloatToStr(RoundTo(dChange, -2));
    dChangeRate := RoundTo(dChange / tick.PreSettlementPrice, -4);
    sChangeRate := FloatTostr(dChangeRate * 100) + '%';

    //走势图绘制
    if (FSeriesManager.Find(tick.InstrumentID) <> -1) then
    begin
      DrawChartTimely(string(tick.UpdateTime), tick.LastPrice, TThreeSeriesGroup(FSeriesManager.GetObjPionter(tick.InstrumentID)).ValueSeries1);
      DrawChartTimely(string(tick.UpdateTime), tick.OpenPrice, TThreeSeriesGroup(FSeriesManager.GetObjPionter(tick.InstrumentID)).ValueSeries2);
      DrawChartTimely(string(tick.UpdateTime), FSeriesManager.GetAveragePrice(tick.InstrumentID,tick.LastPrice), TThreeSeriesGroup(FSeriesManager.GetObjPionter(tick.InstrumentID)).ValueSeries3);
    end;
//
//    if (tick.InstrumentID = AvaibleChartId) then
//    begin
//      DrawChartTimely(string(tick.UpdateTime), Abs(tick.LastPrice), TwoSeriesChart(FSeriesManager.GetCurrentSeries).ValueSeries1);
//      DrawChartTimely(string(tick.UpdateTime), tick.OpenPrice, TwoSeriesChart(FSeriesManager.GetCurrentSeries).ValueSeries2);
//    end;
    //添加变动信息为变色显示提供依据，数据变小就变成负数，Grid响应事件中会对负数做处理
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

  //Grid列表数据刷新
  dataList := fQuotationDataTurnToTStrings(tick, sChange, sChangeRate);
  pGrid.Rows[index + 1] := dataList;

end;

constructor TDataSchedule.Create(QHGrid: PStringGrid; QQGrid: PStringGrid; XHGrid: PStringGrid);
begin
  FFuturesGrid := QHGrid;
  FActualsGrid := XHGrid;
  FOptionGrid := QQGrid;
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
    Result := FFuturesGrid;
  end
  else if myType = OPTION then
  begin
    Result := FOptionGrid;
  end
  else if myType = ACTUALS then
  begin
    Result := FActualsGrid;
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

