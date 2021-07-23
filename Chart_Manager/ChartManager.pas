unit ChartManager;
(*
  ����ͼ������Ԫ
*)

interface

uses
  Series, Classes, Chart;

type
  PChart = ^TChart;

  //����ͼ-����
  ThreeSeriesChart = record
    ValueSeries1: TFastLineSeries;
    ValueSeries2: TFastLineSeries;
    ValueSeries3: TFastLineSeries;
  end;

  //����ͼ-˫��
  TwoSeriesGroup = class
    ValueSeries1: TFastLineSeries;
    ValueSeries2: TFastLineSeries;
  end;

  //�ṩseries���ݸ��¹��ܣ�����ά��һ��Series�������滺��series����
  TSeriesManager = class
  private
    PbindChart: PChart;
    SeriesList: TStringList;
    CacheSize: Integer;
  public
    constructor Create(bindChart: PChart; const ACacheSize: Integer = 3);
    procedure AddSeries(const Akey: string; Aseries: TObject);
    procedure RemoveSeries(const Akey: string = '');
    function GetCurrentSeries(): Pointer;
    procedure SetCurrentSeries(const Akey: string);
    procedure AddDataToCurrentSeries(Adata: TObject);
    function Find(const Akey: string): Integer;
    function GetObjPionter(const Akey: string): Pointer;
    destructor Destroy(); override;
  end;

var
  AvaibleChartId: string;
//  TwoSeriesManager = Class(SeriesManager)
//    procedure AddDataToCurrentSeries(Adata:TwoSeriesChart);
//  end;

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
  SeriesGroup: TwoSeriesGroup;
  currentSeries: Pointer;
  text: TStrings;
begin
  index := SeriesList.IndexOf(Akey);
  if (index = -1) then
  begin
    SeriesGroup := TwoSeriesGroup.Create();
    SeriesGroup.ValueSeries1 := TFastLineSeries.Create(nil);
    SeriesGroup.ValueSeries2 := TFastLineSeries.Create(nil);
    SeriesGroup.ValueSeries1.Title := '�ɽ���';
    SeriesGroup.ValueSeries2.Title := '���̼�';
    SeriesGroup.ValueSeries1.Color := $0000ff;
    SeriesGroup.ValueSeries2.Color := $00400080;
    AddSeries(Akey, TObject(SeriesGroup));
    index := SeriesList.IndexOf(Akey);
  end;
  SeriesList.Move(index, 0);
  //���ϸ���CurrentsSeries����������Chart�󶨵�Series
  currentSeries := GetCurrentSeries();
  PbindChart.RemoveAllSeries();
  PbindChart.AddSeries(TwoSeriesGroup(currentSeries).ValueSeries1);
  PbindChart.AddSeries(TwoSeriesGroup(currentSeries).ValueSeries2);
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
