﻿unit MainWIN;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Menus, ComCtrls, uQuotationAPI, uTradeAPI, uManagerThread,
  DB, ADODB, uContractsSchedule, StrUtils, uConstants, Grids, ExtCtrls, TeeProcs,
  TeEngine, Chart, Series, TeeFunci, SyncObjs, uMyChartManager, uConfigUnit,
  uDataStruct;

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
    FutureChart: TChart;
    PriceSeries: TFastLineSeries;
    ConstantSeries: TFastLineSeries;
    ChartPanel: TPanel;
    middlePanel: TPanel;
    middlerightPanel: TPanel;
    PriceGrid: TStringGrid;
    InputOrderRadioGroup: TRadioGroup;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    GroupBox1: TGroupBox;
    PoinsitionListView: TListView;
    Splitter1: TSplitter;
    Splitter2: TSplitter;
    Splitter3: TSplitter;
    TopGrid: TStringGrid;
    ButtomPanel: TPanel;
    PositionPanel: TPanel;
    HistoryOrderPanel: TPanel;
    Splitter4: TSplitter;
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
    procedure Button3Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure TopGridDrawCell(Sender: TObject; ACol, ARow: Integer; Rect: TRect; State: TGridDrawState);
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
//    procedure DrawPositionListView();
    procedure InitTradeData();
    procedure PushOneOrder(Adir: Char; Aoffset: Char);
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
  MainWindow := Self;
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
begin
  title := TStringList.Create;
  title.DelimitedText := '合约,合约名,最新价,涨跌,买价,买量,卖价,卖量,成交量,持仓量,涨停价,跌停价,今开盘,昨结算,最高价,最低价,现量,涨跌幅,昨收盘,成交额,交易所,行情更新时间';
  FFuturesQuotationGrid.Rows[0] := title;
  FOptionQuotationGrid.Rows[0] := title;
  ActualsQuotationGrid.Rows[0] := title;
  title.DelimitedText := '可用资金,可取资金,基本准备金,质押金额,信用额度,持仓盈亏,平仓盈亏,当前保证金总额,利息收入';
  TopGrid.Rows[0] := title;
  TopGrid.ColCount := 9;
  PriceGrid.ColCount := 2;
  PriceGrid.RowCount := 10;
  PriceGrid.ColWidths[1] := 15;
  PriceGrid.Height := PriceGrid.DefaultRowHeight * PriceGrid.RowCount + 10;
  PriceGrid.Width := PriceGrid.DefaultColWidth + PriceGrid.ColWidths[1] + 10;

  title.Free;  
//  PriceGrid.Row := -1;
end;


//添加合约
procedure TMainWindow.PopupAddContractClick(Sender: TObject);
var
  item: TListItem;
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
  if (FDataSchedule.FFuturesSeatingList.Count > 0) then
  begin
    //获取选中的合约ID
    sid := FDataSchedule.FFuturesSeatingList[FFuturesQuotationGrid.Row - 1];
    //管理器切换当前数据
    FSeriesManager.SetCurrentSeries(sid);
  end;

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
  TopGrid.DefaultColWidth := Width div 10;  
  //各个panel的比例
  GridPanel.Height := Trunc(Self.Height * 0.25);
  middlePanel.Height := Trunc(Self.Height * 0.35);
  ChartPanel.Width := Trunc(Self.Width * 0.7);
  PriceGrid.Top := (middlerightPanel.Height - PriceGrid.Height) div 2;
end;

procedure TMainWindow.FutureChartDblClick(Sender: TObject);
begin
  TChart(Sender).Legend.Visible := not TChart(Sender).Legend.Visible;
//  InitTradeData();
end;

procedure TMainWindow.Button1Click(Sender: TObject);
var
  sid: string;
  dprice: double;
  cdir: Char;
  coffset: Char;
begin
  cdir := '0';
  coffset := '0';
  PushOneOrder(cdir,coffset);
end;

procedure TMainWindow.Button2Click(Sender: TObject);
var
  sid: string;
  dprice: double;
  cdir: Char;
  coffset: Char;
begin
  cdir := '1';
  coffset := '0';
  PushOneOrder(cdir,coffset);
end;

procedure TMainWindow.Button3Click(Sender: TObject);
var
  sid: string;
  dprice: double;
  cdir: Char;
  coffset: Char;
begin
  cdir := '0';
  coffset := '1';
  PushOneOrder(cdir,coffset);
end;

procedure TMainWindow.Button4Click(Sender: TObject);
var
  sid: string;
  dprice: double;
  cdir: Char;
  coffset: Char;
begin
  cdir := '1';
  coffset := '1';
  PushOneOrder(cdir,coffset);
end;

procedure TMainWindow.PushOneOrder(Adir: Char; Aoffset: Char);
var
  sid: string;
  index: Integer;
  dprice: double;
  icount:Integer;
begin
  if Adir = '0' then
  begin
    index := 4;
  end
  else
  begin
    index := 5
  end;
  
  icount := 1;

  if (InputOrderRadioGroup.ItemIndex = 1) then
  begin
    //输入的价格
    dprice := StrToFloat(PriceGrid.Cells[0, index]);
  end  //对手价报单
  else if (PriceGrid.Cells[0, index] = '') then
  begin
    MessageBox(0, '暂无对手价', '下单失败', MB_OK);
  end
  else
  begin
    dprice := StrToFloat(PriceGrid.Cells[0, index]);
    tradeProxy.AddLimitPriceOrder(PChar(sid), Adir, Aoffset, dprice, icount);
  end;

end;

procedure TMainWindow.Connected();
var
  tmp: Integer;
  arr: array of PChar;
begin
  quotationProxy := TQuotationProxy.Create(dllName);
  quotationProxy.Connected(PChar(account1.sQuotationServer), Pchar(''));
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

procedure TMainWindow.TopGridDrawCell(Sender: TObject; ACol, ARow: Integer; Rect: TRect; State: TGridDrawState);
var
  grid: TStringGrid;
  text: string;
  format: Graphics.TTextFormat;
begin
  grid := TStringGrid(Sender);
  if (gdSelected in State) then
  begin
    grid.Canvas.Brush.Color := $00737373;
  end;
  format := [tfSingleLine, tfVerticalCenter, tfCenter];
  text := grid.Cells[ACol, ARow];
  grid.Canvas.FillRect(Rect);
  grid.Canvas.Font.Color := clWhite;
  grid.Canvas.TextRect(Rect, text, format);
end;

procedure TMainWindow.TradeConnect();
var
  item: TListItem;
begin
  tradeProxy := TTradeProxy.Create(dllName);
  tradeProxy.Connected(PChar(account.sTradeServer), PChar(''));
  tradeProxy.AuthAndLogin(PChar(account.sBrokerID), PChar(account.sAccount), PChar(account.sPassword), PChar(account.sAuthCode), PChar(account.sAppid));
  InitTradeData();
end;

procedure TMainWindow.InitTradeData();
var
  data: CThostFtdcTradingAccountField;
  text: TStrings;
begin

  //同步初始化资金情况
  data := CThostFtdcTradingAccountField(tradeProxy.CheckCapital()^);
  TopGrid.Cells[0, 1] := FloatToStr(data.Available);
  TopGrid.Cells[1, 1] := FloatToStr(data.WithdrawQuota);
  TopGrid.Cells[2, 1] := FloatToStr(data.Reserve);
  TopGrid.Cells[3, 1] := FloatToStr(data.Mortgage);
  TopGrid.Cells[4, 1] := FloatToStr(data.Credit);
  TopGrid.Cells[5, 1] := FloatToStr(data.PositionProfit);
  TopGrid.Cells[6, 1] := FloatToStr(data.CloseProfit);
  TopGrid.Cells[7, 1] := FloatToStr(data.CurrMargin);
  TopGrid.Cells[8, 1] := FloatToStr(data.Interest);
  TopGrid.Cells[9, 1] := FloatToStr(data.CloseProfit);
  Sleep(1000);
  tradeProxy.RequestCheckPosition();

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

