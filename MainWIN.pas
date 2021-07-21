﻿unit MainWIN;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Menus, ComCtrls, uQuotationAPI, uQuotationDataStruct,
  uQuotationThread, DB, ADODB, uContractsSchedule, StrUtils, uConstants, Grids,
  ExtCtrls, TeeProcs, TeEngine, Chart, Series, TeeFunci, SyncObjs, ChartManager;

type
  TMainWindow = class(TForm)
    PageControl1: TPageControl;
    TabSheet2: TTabSheet;
    FFuturesQuotationGrid: TStringGrid;
    TabSheet3: TTabSheet;
    TabSheet4: TTabSheet;
    FOptionQuotationGrid: TStringGrid;
    ActualsQuotationGrid: TStringGrid;
    PopupMenu1: TPopupMenu;
    PopupAddContract: TMenuItem;
    PopupDeleteContract: TMenuItem;
    Panel1: TPanel;
    Splitter1: TSplitter;
    PopupTurnToChart: TMenuItem;
    FutureChart: TChart;
    PriceSeries: TFastLineSeries;
    ConstantSeries: TFastLineSeries;
    PopupMenu2: TPopupMenu;
    PopupCloseChart: TMenuItem;
    procedure PopupAddContractClick(Sender: TObject);
    procedure FFuturesQuotationGridDrawCell(Sender: TObject; ACol, ARow: Integer; Rect: TRect; State: TGridDrawState);
    procedure PopupDeleteContractClick(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure PopupTurnToChartClick(Sender: TObject);
    procedure PopupCloseChartClick(Sender: TObject);
  private
    { Private declarations }
    Owner: TComponent;
  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
    procedure Connected();
    procedure updateData();
  end;

procedure AddConteact(list: TStringList);

var
  MainWindow: TMainWindow;
  str: string;
  smdflowpath: string = 'D:\Projects\C++\CTPHQProject\CTPHQProject\CTPHQProject';
  smdfornt: string = 'tcp://180.168.146.187:10131';
  pserver: Pointer;
  ilogin: Integer;
  isubscribe: Integer;
  iremove: Integer;
  pget: Pointer;
  nChar: PChar = PChar('');
  myapi: TQuotationProxy;
  FDataSchedule: TDataSchedule;
  FSeriesManager: TSeriesManager;

implementation

uses
  ufrmAddConteact;

{$R *.dfm}
constructor TMainWindow.Create(AOwner: TComponent);
var
  title: TStrings;
begin
  inherited;
//  Self.Height := Screen.WorkAreaHeight;
//  Self.Width := Screen.WorkAreaWidth;
  Owner := AOwner;
  WindowState := wsMaximized;
  title := TStringList.Create;
  title.DelimitedText := '合约,合约名,最新价,涨跌,买价,买量,卖价,卖量,成交量,持仓量,涨停价,跌停价,今开盘,昨结算,最高价,最低价,现量,涨跌幅,昨收盘,成交额,交易所,行情更新时间';
  FFuturesQuotationGrid.Rows[0] := title;
  FOptionQuotationGrid.Rows[0] := title;
  ActualsQuotationGrid.Rows[0] := title;

  //数据调度器新建
  FDataSchedule := TDataSchedule.Create(@FFuturesQuotationGrid, @FOptionQuotationGrid, @ActualsQuotationGrid);
  //走势图管理器新建
  FSeriesManager := TSeriesManager.Create();
  Connected();
  FutureChart.SeriesList.Clear;
  //  FutureChart.LeftAxis.SetMinMax(0, 100);
  //  FutureChart.BottomAxis.SetMinMax(0, 100);
  //  FutureChart.RightAxis.SetMinMax(0, 100);
  //FutureChart.LeftAxis.SetMinMax(-100, 100);
//    for I := 0 to 100 do
//    begin
//      Value := I;
//      PriceSeries.Add(Value, IntToStr(I));
//    end;
end;

//添加合约
procedure TMainWindow.PopupAddContractClick(Sender: TObject);
begin
  AddConteactForm.Show;
end;

//删除合约
procedure TMainWindow.PopupDeleteContractClick(Sender: TObject);
var
  str: string;
  iret: Integer;
  I: Integer;
begin
//  RemoveConteactForm.Show;

  str := '确认删除' + IntToStr(FFuturesQuotationGrid.Selection.Top) + '行至' + IntToStr(FFuturesQuotationGrid.Selection.Bottom) + '行？';
  iret := MessageBox(0, Pchar(str), 'tishi', MB_OKCANCEL);

  if iret = 1 then
  begin
    //删除chart中的合约列表记录
    for I := FFuturesQuotationGrid.Selection.Bottom downto FFuturesQuotationGrid.Selection.Top do
    begin
      //删除series
      if (FSeriesManager.Find(FDataSchedule.FFuturesSeatingList[I - 1]) <> -1) then
      begin
        FSeriesManager.RemoveSeries(FDataSchedule.FFuturesSeatingList[I - 1]);
      end;
      
      //删除ListItem
      if (FDataSchedule.FFuturesSeatingList.Count > 0) then
      begin
        FDataSchedule.FFuturesSeatingList.Delete(I - 1);

      end;
      if (FFuturesQuotationGrid.RowCount = 2) then
      begin
        FFuturesQuotationGrid.Rows[1].Clear;
        Break;
      end;
      TmyTStringGrid(FFuturesQuotationGrid).DeleteRow(I);

    end;

  end;

end;

procedure TMainWindow.PopupTurnToChartClick(Sender: TObject);
var
  sid: string;
  SeriesGroup: TwoSeriesGroup;
  p: Pointer;
begin
  //隐藏Grid
  FFuturesQuotationGrid.Visible := false;
  //获取选中的合约ID
  sid := FDataSchedule.FFuturesSeatingList[FFuturesQuotationGrid.Row - 1];
  //管理器切换当前数据
  FSeriesManager.SetCurrentSeries(sid);
  //显示走势图
  TurnToChart(sid, FSeriesManager.GetCurrentSeries, @FutureChart);

end;

procedure TMainWindow.PopupCloseChartClick(Sender: TObject);
var
  I: Integer;
begin
  FutureChart.Visible := False;
  FutureChart.RemoveAllSeries;
  FFuturesQuotationGrid.Visible := True;
end;

procedure TMainWindow.FFuturesQuotationGridDrawCell(Sender: TObject; ACol, ARow: Integer; Rect: TRect; State: TGridDrawState);
var
  str: string;
  format: Graphics.TTextFormat;
  pgrid: ^TStringGrid;
  snewstr: string;
  Bold: TFontStyles;
begin
  pgrid := @Sender;
  str := pgrid.Cells[ACol, ARow];
  snewstr := MidStr(str, 2, Length(str));
  Bold := [fsBold];
  format := [tfSingleLine, tfVerticalCenter];
  //三列颜色定义
  if (ARow > 0) and ((ACol = 2) or (ACol = 4) or (ACol = 6)) then
  begin
    pgrid.Canvas.Font.Style := Bold;
    pgrid.Canvas.FillRect(Rect);
    if (LeftStr(str, 1) = '-') then
    begin
      pgrid.Canvas.Font.Color := TColor($00e500); //绿色
      pgrid.Canvas.TextRect(Rect, snewstr, format);
    end
    else
    begin
      pgrid.Canvas.Font.Color := TColor($0000ff); //大红
      pgrid.Canvas.TextRect(Rect, str, format);
    end;
  end  //涨跌颜色定义
  else if (ARow > 0) and (ACol = 3) then
  begin
    pgrid.Canvas.FillRect(Rect);

    if (LeftStr(str, 1) = '-') then
    begin
      pgrid.Canvas.Font.Color := TColor($00e500); //绿色
    end
    else if (str <> '') and (StrToFloat(str) > 0) then
    begin
      pgrid.Canvas.Font.Color := TColor($0000ff); //大红
    end;

    pgrid.Canvas.TextRect(Rect, str, format);
  end;

end;

procedure TMainWindow.FormResize(Sender: TObject);
begin
  FFuturesQuotationGrid.DefaultColWidth := Width div 23;
end;



//
procedure TMainWindow.Connected();
var
  tmp: Integer;
  arr: array of PChar;
begin
  myapi := TQuotationProxy.Create('QuotationCTP.dll');
  myapi.Connected(PChar(smdfornt), PChar(smdflowpath));
  while myapi.IsConnected <> True do
  begin
    Sleep(1000);
//    Writeln('[delphi]: waiting for connected ...');
  end;
  myapi.SimpleLogin(nChar, nChar, nChar);
  while myapi.LoginSucess <> True do
  begin
    Sleep(1000);
//    Writeln('[delphi]: waiting for login ...');
  end;
  SetLength(arr, 2);
  arr[0] := Pchar('IF2108');
  arr[1] := Pchar('c2109');
  tmp := myapi.Subscribe(Pointer(arr), 2);
  if tmp = 0 then
  begin
    FDataSchedule.AddContracts(arr);
  end;
  TQuotationThread.Create(updateData);
end;

procedure TMainWindow.updateData();
var
  tick: TQuotationData;
  id: string;
begin
  while true do
  begin
    Sleep(100);
    tick := myapi.GetOneTick();
    if (tick.InstrumentID <> '') then
    begin
      FDataSchedule.ScheduleTick(tick);
    end;
//    Total_Quotation.Rows[1] := fQuotationView(tick);

  end;
end;

procedure AddConteact(list: TStringList);
var
  arr: array of PChar;
  I: Integer;
  itmp: Integer;
begin
  SetLength(arr, list.Count);
  for I := 0 to list.Count - 1 do
  begin
    arr[I] := PChar(list[I]);
  end;
  itmp := myapi.Subscribe(Pointer(arr), list.Count);
  if itmp = 0 then
  begin
    FDataSchedule.AddContracts(arr);
  end
  else
  begin
    MessageBox(0, '合约不存在或输入格式错误!', '提示', MB_OKCANCEL);
  end;
end;

end.

