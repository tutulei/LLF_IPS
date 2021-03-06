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
    constructor Create(bindChart: PChart; const ACacheSize: Integer = 12);
    procedure RemoveSeries(const Akey: string = '');
    function GetCurrentSeries(): Pointer;
    procedure SetCurrentSeries(const Akey: string);
    procedure CurrentSeriesBindChart(); virtual;abstract;
    procedure AddDataToCurrentSeries(Adata: TObject);
    procedure CreateSeries(const Akey: string); virtual;abstract;
    function Find(const Akey: string): Integer;
    function GetObjPionter(const Akey: string): Pointer;
    destructor Destroy(); override;
  end;



//var
//  AvaibleChartId: string;

procedure CloseChart(APChart: PChart);

implementation

constructor TSeriesManager.Create(bindChart: PChart; const ACacheSize: Integer = 12);
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
  text: TStrings;
  index: Integer;
begin
  index := SeriesList.IndexOf(Akey);
  if (index = -1) then
  begin
    CreateSeries(Akey);
  end;
  SeriesList.Move(SeriesList.IndexOf(Akey), 0);
  CurrentSeriesBindChart();
  text := TStringList.Create;
  text.Add(Akey);
  PbindChart.Title.Text := text;
  text.Free;
end;

procedure TSeriesManager.AddDataToCurrentSeries(Adata: TObject);
begin
  SeriesList.Objects[0] := Adata;
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

procedure CloseChart(APChart: PChart);
begin
  APChart.Visible := False;
  APChart.RemoveAllSeries;
end;

end.

