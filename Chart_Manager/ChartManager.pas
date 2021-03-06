unit ChartManager;
(*
  走势图管理单元
*)

interface

uses
  Series, Classes, Chart;

type
  PChart = ^TChart;

  //折线图-双线
  TTwoSeriesGroup = class
  public
    ValueSeries1: TFastLineSeries;
    ValueSeries2: TFastLineSeries;
  end;
  
  //折线图-三线
  TThreeSeriesGroup = class(TTwoSeriesGroup)
  public
    ValueSeries3: TFastLineSeries;
  end;

  //提供series数据更新功能，并且维护一个Series表，里面缓存series数据
  TSeriesManager = class
  protected
    PbindChart: PChart;
    SeriesList: TStringList;
    CacheSize: Integer;
    procedure AddSeries(const Akey: string; Aseries: TObject);
  public
    constructor Create(bindChart: PChart; const ACacheSize: Integer = 3);
    procedure RemoveSeries(const Akey: string = '');
    function GetCurrentSeries(): Pointer;
    procedure SetCurrentSeries(const Akey: string); virtual;
    procedure AddDataToCurrentSeries(Adata: TObject);
    procedure CreateSeries(const Akey: string); virtual;
    function Find(const Akey: string): Integer;
    function GetObjPionter(const Akey: string): Pointer;
    destructor Destroy(); override;
  end;

  TThreeSeriesManager = class(TSeriesManager)
  public
    procedure SetCurrentSeries(const Akey: string); virtual;
    procedure CreateSeries(const Akey: string); virtual;
  end;

//var
//  AvaibleChartId: string;

procedure CloseChart(APChart: PChart);

implementation

constructor TSeriesManager.Create(bindChart: PChart; const ACacheSize: Integer = 3);
begin
  inherited Create;
  SeriesList := TStringList.Create;
  CacheSize := ACacheSize;
  PbindChart := bindChart;
end;

procedure TSeriesManager.AddSeries(const Akey: string; Aseries: TObject);
begin
  if (SeriesList.Count = CacheSize) then
  begin
    SeriesList.Delete(CacheSize - 1);
  end;
  SeriesList.AddObject(Akey, Aseries);

end;

procedure TSeriesManager.RemoveSeries(const Akey: string = '');
var
  index: Integer;
begin
  if SeriesList.Count = 0 then
  begin
    Exit;
  end;

  if Akey = '' then
  begin
    SeriesList.Delete(SeriesList.Count - 1);
  end
  else
  begin
    index := SeriesList.IndexOf(Akey);
    SeriesList.Delete(index);
  end;

end;

function TSeriesManager.GetCurrentSeries(): Pointer;
begin
  Result := SeriesList.Objects[0];
end;

procedure TSeriesManager.SetCurrentSeries(const Akey: string);
var
  index: Integer;
  currentSeries: Pointer;
  text: TStrings;
begin
  index := SeriesList.IndexOf(Akey);
  if (index = -1) then
  begin
    CreateSeries(Akey);
  end;
  SeriesList.Move(SeriesList.IndexOf(Akey), 0);
  //以上更新CurrentsSeries，以下设置Chart绑定的Series
  currentSeries := GetCurrentSeries();
  PbindChart.RemoveAllSeries();
  PbindChart.AddSeries(TTwoSeriesGroup(currentSeries).ValueSeries1);
  PbindChart.AddSeries(TTwoSeriesGroup(currentSeries).ValueSeries2);
  text := TStringList.Create;
  text.Add(Akey);
  PbindChart.Title.Text := text;
  text.Free;
end;

procedure TSeriesManager.AddDataToCurrentSeries(Adata: TObject);
begin
  SeriesList.Objects[0] := Adata;
end;

procedure TSeriesManager.CreateSeries(const Akey: string);
var
  SeriesGroup: TTwoSeriesGroup;
begin
  SeriesGroup := TTwoSeriesGroup.Create();
  SeriesGroup.ValueSeries1 := TFastLineSeries.Create(nil);
  SeriesGroup.ValueSeries2 := TFastLineSeries.Create(nil);
  SeriesGroup.ValueSeries1.Title := '成交价';
  SeriesGroup.ValueSeries2.Title := '开盘价';
  SeriesGroup.ValueSeries1.Color := $0000ff;
  SeriesGroup.ValueSeries2.Color := $00400080;
  AddSeries(Akey, TObject(SeriesGroup));
end;

function TSeriesManager.Find(const Akey: string): Integer;
begin
  Result := SeriesList.IndexOf(Akey);
end;

function TSeriesManager.GetObjPionter(const Akey: string): Pointer;
var
  index: Integer;
  p: Pointer;
begin
  index := Find(Akey);
  if (index >= 0) then
  begin
    p := SeriesList.Objects[index];
  end
  else
  begin
    p := nil;
  end;
  Result := p;
end;

destructor TSeriesManager.Destroy();
var
  pobj: ^TObject;
  I: Integer;
begin
  for I := 0 to SeriesList.Count do
  begin
    SeriesList.Objects[0];
    pobj^ := SeriesList.Objects[I];
    pobj.Free;
  end;
  SeriesList.Free;

  inherited Destroy;
end;

procedure TThreeSeriesManager.SetCurrentSeries(const Akey: string);
var
  currentSeries: Pointer;
begin
  inherited;
  currentSeries := GetCurrentSeries();
  PbindChart.AddSeries(TThreeSeriesGroup(currentSeries).ValueSeries3);
end;

procedure TThreeSeriesManager.CreateSeries(const Akey: string);
var
  SeriesGroup: TThreeSeriesGroup;
begin
  SeriesGroup := TThreeSeriesGroup.Create();
  SeriesGroup.ValueSeries1 := TFastLineSeries.Create(nil);
  SeriesGroup.ValueSeries2 := TFastLineSeries.Create(nil);
  SeriesGroup.ValueSeries3 := TFastLineSeries.Create(nil);
  SeriesGroup.ValueSeries1.Title := '成交价';
  SeriesGroup.ValueSeries2.Title := '开盘价';
  SeriesGroup.ValueSeries3.Title := '今日均价';
  SeriesGroup.ValueSeries1.Color := $0000ff;
  SeriesGroup.ValueSeries2.Color := $00400080;
  SeriesGroup.ValueSeries3.Color := $FF0000;
  AddSeries(Akey, TObject(SeriesGroup));
end;

procedure CloseChart(APChart: PChart);
begin
  APChart.Visible := False;
  APChart.RemoveAllSeries;
end;

end.

