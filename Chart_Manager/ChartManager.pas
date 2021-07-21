unit ChartManager;
(*
  走势图管理单元
*)

interface

uses
  Series, Classes;

type

  //折线图-三线
  ThreeSeriesChart = record
    ValueSeries1: TFastLineSeries;
    ValueSeries2: TFastLineSeries;
    ConstantSeries: TFastLineSeries;
  end;
  //折线图-双线

  TwoSeriesChart = record
    ValueSeries1: TFastLineSeries;
    ConstantSeries: TFastLineSeries;
  end;

  //提供series数据更新功能，并且维护一个Series表，里面缓存series数据

  SeriesManager = class
  private
    SeriesList: TStringList;
    CacheSize: Integer;
  public
    constructor Create(const ACacheSize: Integer = 3);
    procedure AddSeries(const Akey: string; Aseries: TObject);
    procedure RemoveSeries(const Akey: string);
    function GetCurrentSeries(): Pointer;
    procedure SetCurrentSeries(const Akey: string);
    procedure AddDataToCurrentSeries(Adata: TObject);
  end;

//  TwoSeriesManager = Class(SeriesManager)
//    procedure AddDataToCurrentSeries(Adata:TwoSeriesChart);
//  end;

implementation

constructor SeriesManager.Create(const ACacheSize: Integer = 3);
begin
  SeriesList := TStringList.Create;
  CacheSize := ACacheSize;
end;

procedure SeriesManager.AddSeries(const Akey: string; Aseries: TObject);
begin
  if (SeriesList.Count = CacheSize) then
  begin
    SeriesList.Delete(CacheSize - 1);
  end;
  SeriesList.AddObject(Akey, Aseries);

end;

procedure SeriesManager.RemoveSeries(const Akey: string = '');
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
    SeriesList.Destroy(index);
  end;

end;

function SeriesManager.GetCurrentSeries(): Pointer;
begin
  Result := SeriesList.Objects[0];
end;

procedure SeriesManager.SetCurrentSeries(const Akey: string);
var
  index: Integer;
begin
  index := SeriesList.IndexOf(Akey);
  SeriesList.Move(index, 0);
end;

procedure SeriesManager.AddDataToCurrentSeries(Adata: TObject);
begin
  SeriesList.Objects[0] := Adata;
end;

end.

