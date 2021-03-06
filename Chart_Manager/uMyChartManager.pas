unit uMyChartManager;
(*
  定制化的Chart图管理器，一个Chart，三条线 —— 今开盘，成交价，今均线
*)

interface

uses
  ChartManager, Series, Classes;

type
  TmySeriesManager = class(TSeriesManager)
  public
    constructor Create(AbindChart: PChart; const ACacheSize: Integer = 12);
    procedure CurrentSeriesBindChart(); override;
    procedure CreateSeries(const Akey: string); override;
    function GetAveragePrice(const Aid: string; const AcurrentPrice: Double): Double;
    procedure LoadPriceParam(const Aid: string; Avalue: Double; Acount: Integer);
  end;

  TmySeriesGroup = class(TThreeSeriesGroup)
  public
    TotalValue: double;
    TotalCount: Integer;
  end;

  PmySeriesGroup = ^TmySeriesGroup;

implementation

uses
  Math;

constructor TmySeriesManager.Create(AbindChart: PChart; const ACacheSize: Integer = 12);
begin
  inherited Create(AbindChart, ACacheSize);
end;

procedure TmySeriesManager.CurrentSeriesBindChart();
var
  pCurrentSeries: Pointer;
begin
  pCurrentSeries := GetCurrentSeries();
  PbindChart.RemoveAllSeries();
  PbindChart.AddSeries(TTwoSeriesGroup(pCurrentSeries).ValueSeries1);
  PbindChart.AddSeries(TTwoSeriesGroup(pCurrentSeries).ValueSeries2);
  PbindChart.AddSeries(TThreeSeriesGroup(pCurrentSeries).ValueSeries3);
end;

procedure TmySeriesManager.CreateSeries(const Akey: string);
var
  SeriesGroup: TmySeriesGroup;
begin
  SeriesGroup := TmySeriesGroup.Create();
  SeriesGroup.ValueSeries1 := TFastLineSeries.Create(nil);
  SeriesGroup.ValueSeries2 := TFastLineSeries.Create(nil);
  SeriesGroup.ValueSeries3 := TFastLineSeries.Create(nil);
  SeriesGroup.ValueSeries1.Title := '成交价';
  SeriesGroup.ValueSeries2.Title := '开盘价';
  SeriesGroup.ValueSeries3.Title := '今日均价';
  SeriesGroup.ValueSeries1.Color := $0000ff;
  SeriesGroup.ValueSeries2.Color := $00400080;
  SeriesGroup.ValueSeries3.Color := $FF0000;
  SeriesGroup.ValueSeries1.Stairs := True;
  SeriesGroup.TotalValue := 0;
  SeriesGroup.TotalCount := 0;
  AddSeries(Akey, TObject(SeriesGroup));
end;

function TmySeriesManager.GetAveragePrice(const Aid: string; const AcurrentPrice: Double): Double;
var
  SeriesGroup: TmySeriesGroup;
  value: double;
begin
  SeriesGroup := TmySeriesGroup(GetObjPionter(Aid));
  if SeriesGroup <> nil then
  begin
    value := SeriesGroup.Totalvalue + AcurrentPrice;
    SeriesGroup.Totalvalue := value;
    SeriesGroup.TotalCount := SeriesGroup.TotalCount + 1;
    Result := RoundTo(SeriesGroup.Totalvalue / SeriesGroup.TotalCount, -1);

  end;
end;

procedure TmySeriesManager.LoadPriceParam(const Aid: string; Avalue: Double; Acount: Integer);
var
  SeriesGroup: TmySeriesGroup;
begin
  SeriesGroup := TmySeriesGroup(GetObjPionter(Aid));
  SeriesGroup.Totalvalue := Avalue;
  SeriesGroup.TotalCount := Acount;
end;

end.

