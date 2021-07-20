unit uContractsSchedule;
(*
  行情合约调度器
  主要进行合约分配和更新
*)

interface

uses
  uQuotationDataStruct, Grids, Classes, uConstants, SysUtils, Math, Windows;

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
    FFuturesSeatingChart: TStringList;
    FOptionSeatingChart: TStringList;
    FActualsSeatingChart: TStringList;
        
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

function fQuotationDataTurnToTStrings(data: TQuotationData; change: string; changeRate: string): TStrings;

implementation

procedure TDataSchedule.AddContracts(arr: array of PChar);
var
  PID: string;
  grid: PStringGrid;
  chart: PStringList;
  ctype: ContractType;
  tmp: Integer;
begin
  for PID in arr do
  begin
    //判断该合约属于何种类型（期货，期权，现货）
    ctype := AnalysisType(PID);
    grid := getGrid(ctype);
    chart := getList(ctype);
    //可视组件生成行
    tmp := Length(grid.Cells[0, grid.RowCount - 1]);
    if tmp > 0 then
    begin
      grid.RowCount := grid.RowCount + 1;
    end;
    //添加列表中
    chart.Add(string(PID));
    grid.Cells[0, grid.RowCount - 1] := PID;
  end;

end;

procedure TDataSchedule.RemoveContracts(arr: array of PChar);
begin

end;

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
    dChange := tick.LastPrice - tick.OpenPrice;
    sChange := FloatToStr(RoundTo(dChange, -2));
    sChangeRate := FloatTostr(RoundTo(dChange / tick.OpenPrice, -4) * 100) + '%';
    //添加变动信息为变色显示做信号
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

  dataList := fQuotationDataTurnToTStrings(tick, sChange, sChangeRate);
  pGrid.Rows[index + 1] := dataList;

//  _XHGrid.RowCount := _XHGrid.RowCount +1;
//  _XHGrid.Rows[_XHGrid.RowCount-1] := dataList;

end;

constructor TDataSchedule.Create(QHGrid: PStringGrid; QQGrid: PStringGrid; XHGrid: PStringGrid);
begin
  FFuturesGrid := QHGrid;
  FActualsGrid := XHGrid;
  FOptionGrid := QQGrid;
  FFuturesSeatingChart := TStringList.Create();
  FOptionSeatingChart := TStringList.Create();
  FActualsSeatingChart := TStringList.Create();
end;

destructor TDataSchedule.Destroy();
begin
  FFuturesSeatingChart.Free;
  FOptionSeatingChart.Free;
  FActualsSeatingChart.Free;
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
    Result := @FFuturesSeatingChart;
  end
  else if myType = OPTION then
  begin
    Result := @FOptionSeatingChart;
  end
  else if myType = ACTUALS then
  begin
    Result := @FActualsSeatingChart;
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

end.

