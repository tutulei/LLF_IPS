﻿unit MainWIN;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Menus, ComCtrls, uQuotationAPI, uTradeAPI,
  uQuotationDataStruct, uManagerThread, DB, ADODB, uContractsSchedule, StrUtils,
  uConstants, Grids, ExtCtrls, TeeProcs, TeEngine, Chart, Series, TeeFunci,
  SyncObjs, uMyChartManager, uConfigUnit;

type
  PMainWindow = ^TMainWindow;

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
    GridPanel: TPanel;
    Splitter1: TSplitter;
    FutureChart: TChart;
    PriceSeries: TFastLineSeries;
    ConstantSeries: TFastLineSeries;
    PopupMenu2: TPopupMenu;
    PopupCloseChart: TMenuItem;
    ChartPanel: TPanel;
    middlePanel: TPanel;
    middlerightPanel: TPanel;
    Splitter2: TSplitter;
    Splitter3: TSplitter;
    Panel2: TPanel;
    PriceGrid: TStringGrid;
    InputOrderRadioGroup: TRadioGroup;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    GroupBox1: TGroupBox;
    PosistionListView: TListView;
    procedure PopupAddContractClick(Sender: TObject);
    procedure FFuturesQuotationGridDrawCell(Sender: TObject; ACol, ARow: Integer; Rect: TRect; State: TGridDrawState);
    procedure PopupDeleteContractClick(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure FFuturesQuotationGridClick(Sender: TObject);
    procedure FutureChartDblClick(Sender: TObject);
    procedure InputOrderRadioGroupClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure PriceGridDrawCell(Sender: TObject; ACol, ARow: Integer; Rect: TRect; State: TGridDrawState);
    procedure Button4Click(Sender: TObject);
  private
    { Private declarations }
    Owner: TComponent;
  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
    procedure InitWidgets();
    procedure Connected();
    procedure TradeConnect();
    procedure updateData();
  end;

procedure AddConteact(list: TStringList);

var
  MainWindow: TMainWindow;
  nChar: PChar = PChar('');
  quotationProxy: TQuotationProxy;
  tradeProxy: TTradeProxy;
  FDataSchedule: TDataSchedule;
  FSeriesManager: TmySeriesManager;
  TotalValue: double;

implementation

uses
  ufrmAddConteact, uTradeUnit;

{$R *.dfm}
constructor TMainWindow.Create(AOwner: TComponent);
begin
  inherited;
  Owner := AOwner;
  WindowState := wsMaximized;
  InitConfiguration();
//  Self.Height := Screen.WorkAreaHeight;
//  Self.Width := Screen.WorkAreaWidth;

  InitWidgets();
  //数据调度器新建
  FDataSchedule := TDataSchedule.Create(@Self);
  //走势图管理器新建
  FSeriesManager := TmySeriesManager.Create(@FutureChart);
  Connected();
  TradeConnect();
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

procedure TMainWindow.InitWidgets();
var
  title: TStrings;
  rect: TGridRect;
begin
  title := TStringList.Create;
  title.DelimitedText := '合约,合约名,最新价,涨跌,买价,买量,卖价,卖量,成交量,持仓量,涨停价,跌停价,今开盘,昨结算,最高价,最低价,现量,涨跌幅,昨收盘,成交额,交易所,行情更新时间';
  FFuturesQuotationGrid.Rows[0] := title;
  FOptionQuotationGrid.Rows[0] := title;
  ActualsQuotationGrid.Rows[0] := title;
  PriceGrid.ColCount := 2;
  PriceGrid.RowCount := 10;
  PriceGrid.ColWidths[1] := 15;
  PriceGrid.Height := PriceGrid.DefaultRowHeight * PriceGrid.RowCount + 10;
  PriceGrid.Width := PriceGrid.DefaultColWidth + PriceGrid.ColWidths[1] + 10;
//  PriceGrid.Row := -1;
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

procedure TMainWindow.PriceGridDrawCell(Sender: TObject; ACol, ARow: Integer; Rect: TRect; State: TGridDrawState);
var
  grid: TStringGrid;
  format: Graphics.TTextFormat;
  snewstr: string;
begin

  if (gdSelected in State) then
  begin
    grid := TStringGrid(Sender);
    format := [tfSingleLine, tfVerticalCenter];
    snewstr := grid.Cells[ACol, ARow];
    grid.Canvas.Brush.Color := clBtnFace;
    grid.Canvas.FillRect(Rect);
    grid.Canvas.Font.Color := clBlack;
    grid.Canvas.TextRect(Rect, snewstr, format);
  end;
end;

procedure TMainWindow.InputOrderRadioGroupClick(Sender: TObject);
begin

end;

////显示走势图
//procedure TMainWindow.PopupTurnToChartClick(Sender: TObject);
//var
//  sid: string;
//  p: Pointer;
//begin
//  //隐藏Grid
//  FFuturesQuotationGrid.Visible := false;
//  //获取选中的合约ID
//  sid := FDataSchedule.FFuturesSeatingList[FFuturesQuotationGrid.Row - 1];
//  //管理器切换当前数据
//  FSeriesManager.SetCurrentSeries(sid);
//  //显示走势图
//  FutureChart.Visible := True;
//  ComboBox1.Text := sid;
//
//end;

////关闭走势图
//procedure TMainWindow.PopupCloseChartClick(Sender: TObject);
//var
//  I: Integer;
//begin
//  FutureChart.Visible := False;
//  FutureChart.RemoveAllSeries;
//  FFuturesQuotationGrid.Visible := True;
//end;

procedure TMainWindow.FFuturesQuotationGridClick(Sender: TObject);
var
  sid: string;
begin
    //获取选中的合约ID
  sid := FDataSchedule.FFuturesSeatingList[FFuturesQuotationGrid.Row - 1];
    //管理器切换当前数据
  FSeriesManager.SetCurrentSeries(sid);
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
  //各个panel的比例
  GridPanel.Height := Trunc(Self.Height * 0.15);
  middlePanel.Height := Trunc(Self.Height * 0.35);
  ChartPanel.Width := Trunc(Self.Width * 0.7);
  PriceGrid.Top := (middlerightPanel.Height - PriceGrid.Height) div 2;
end;

procedure TMainWindow.FutureChartDblClick(Sender: TObject);
begin
  TChart(Sender).Legend.Visible := not TChart(Sender).Legend.Visible;
end;

procedure TMainWindow.Button1Click(Sender: TObject);
var
  sid: string;
  dprice: double;
  cdir: Char;
  coffset: Char;
  i: Integer;
begin
  cdir := '0';
  coffset := '0';
  sid := FDataSchedule.FFuturesSeatingList[FFuturesQuotationGrid.Row - 1];
  if (InputOrderRadioGroup.ItemIndex = 1) then
  begin
    //输入的价格
    dprice := StrToFloat(PriceGrid.Cells[0, 4]);
  end;
  tradeProxy.AddLimitPriceOrder(PChar(sid), cdir, coffset, dprice, 1);
end;

procedure TMainWindow.Button4Click(Sender: TObject);
var
  sid: string;
  dprice: double;
  cdir: Char;
  coffset: Char;
  i: Integer;
begin
  cdir := '1';
  coffset := '1';
  dprice := StrToFloat(PriceGrid.Cells[0, 4]);
  sid := FDataSchedule.FFuturesSeatingList[FFuturesQuotationGrid.Row - 1];
  if (true) then
  begin
    dprice := StrToFloat(PriceGrid.Cells[0, 5]);
  end;
  tradeProxy.AddLimitPriceOrder(PChar(sid), cdir, coffset, dprice, 1);
end;

procedure TMainWindow.Connected();
var
  tmp: Integer;
  arr: array of PChar;
begin
  quotationProxy := TQuotationProxy.Create(dllName);
  quotationProxy.Connected(PChar(quotationserver), PChar(quotationflowpath));
  while quotationProxy.IsConnected <> True do
  begin
    Sleep(1000);
//    Writeln('[delphi]: waiting for connected ...');
  end;
  quotationProxy.SimpleLogin(nChar, nChar, nChar);
  while quotationProxy.LoginSucess <> True do
  begin
    Sleep(1000);
//    Writeln('[delphi]: waiting for login ...');
  end;
  SetLength(arr, 3);
  arr[0] := Pchar('IF2108');
  arr[1] := Pchar('IH2108');
  arr[2] := Pchar('IC2108');
  tmp := quotationProxy.Subscribe(Pointer(arr), 3);
  if tmp = 0 then                                        
  begin
    FDataSchedule.AddContracts(arr);
    FSeriesManager.SetCurrentSeries(FDataSchedule.FFuturesSeatingList[2]);
    FSeriesManager.SetCurrentSeries(FDataSchedule.FFuturesSeatingList[1]);
    FSeriesManager.SetCurrentSeries(FDataSchedule.FFuturesSeatingList[0]);
  end;
  TManagerThread.Create(updateData);
end;

procedure TMainWindow.TradeConnect();
begin
  tradeProxy := TTradeProxy.Create(dllName);
  tradeProxy.Connected(PChar(tradeserver), PChar(tradeflowpath));
  tradeProxy.AuthAndLogin(PChar(tradebrokerid), PChar(tradeaccount), PChar(tradepassword), PChar(tradeauthcode), PChar(tradeappid));
end;

procedure TMainWindow.updateData();
var
  tick: TQuotationData;
  id: string;
begin
  while true do
  begin
    Sleep(500 div 3);
    tick := quotationProxy.GetOneTick();
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
  itmp := quotationProxy.Subscribe(Pointer(arr), list.Count);
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

