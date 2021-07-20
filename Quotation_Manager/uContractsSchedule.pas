unit uContractsSchedule;
(*
  �����Լ������
  ��Ҫ���к�Լ����͸���
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
    //���ڴ洢�Զ��ĵĺ�Լ�Լ�˳����Ϣ
    FFuturesSeatingChart: TStringList;
    FOptionSeatingChart: TStringList;
    FActualsSeatingChart: TStringList;
        
      //���� �ܣ��ڻ�����Ȩ���ֻ���gridָ�룬
    constructor Create(QHGrid: PStringGrid = nil; QQGrid: PStringGrid = nil; XHGrid: PStringGrid = nil);
    destructor Destroy(); override;
      //���Ӻ�Լ��¼
    procedure AddContracts(arr: array of PChar);

      //ɾ����Լ��¼
    procedure RemoveContracts(arr: array of PChar);

      //tick����
    procedure ScheduleTick(tick: TQuotationData);

      //����ID�жϴ˺�Լ�����ڻ�����Ȩ�����ֻ�
    function AnalysisType(id: string): ContractType;

      //���ݲ������ز�ͬ���͵�grid
    function getGrid(myType: ContractType): PStringGrid;

    //���ݲ������ز�ͬ���͵�TList
    function getList(myType: ContractType): PStringList;

    //������������
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
    //�жϸú�Լ���ں������ͣ��ڻ�����Ȩ���ֻ���
    ctype := AnalysisType(PID);
    grid := getGrid(ctype);
    chart := getList(ctype);
    //�������������
    tmp := Length(grid.Cells[0, grid.RowCount - 1]);
    if tmp > 0 then
    begin
      grid.RowCount := grid.RowCount + 1;
    end;
    //�����б���
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
  //��ȡ�������ͱ���
  pID := tick.InstrumentID;
  ctype := AnalysisType(strPas(pID));
  pChart := getList(ctype);
  pGrid := getGrid(ctype);

  //������ݣ������Ƶ������ˢ��
  index := pChart.IndexOf(string(pID));
  if (index = -1) then
  begin
    MessageBox(0, tick.InstrumentID, '����', MB_OKCANCEL);
  end;
  //ȷ���ǵ����ǵ���
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
    //���ӱ䶯��ϢΪ��ɫ��ʾ���ź�
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
var
  I: Integer;
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
  tmp.DelimitedText := data.InstrumentID + ',' + data.ExchangeInstID + ',' + FloatToStr(data.LastPrice) + ',' + change + ',' + FloatToStr(data.BidPrice1) + ',' + IntToStr(data.BidVolume1) + ',' + FloatToStr(data.AskPrice1) + ',' + IntToStr(data.AskVolume1) + ',' + '�ɽ���' + ',' + FloatToStr(data.OpenInterest) + ',' + FloatToStr(data.UpperLimitPrice) + ',' + FloatToStr(data.LowerLimitPrice) + ',' + FloatToStr(data.OpenPrice) + ',' + FloatToStr(data.PreSettlementPrice) + ',' + FloatToStr(data.HighestPrice) + ',' + FloatToStr(data.LowestPrice) + ',' + IntToStr(data.Volume) + ',' + changeRate + ',' + FloatToStr(data.PreClosePrice) + ',' + FloatToStr(data.Turnover) + ',' + 'jys' + ',' + data.UpdateTime;
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
    Result := '�ڻ�';
  end
  else if t = OPTION then
  begin
    Result := '��Ȩ';
  end
  else if t = ACTUALS then
  begin
    Result := '�ֻ�';
  end;
end;

end.
