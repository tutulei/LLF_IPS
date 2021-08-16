﻿unit MainWIN;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Menus, ComCtrls, uQuotationAPI, uTradeAPI, uManagerThread,
  DB, ADODB, uContractsSchedule, StrUtils, uConstants, Grids, ExtCtrls, TeeProcs,
  TeEngine, Chart, Series, TeeFunci, SyncObjs, uMyChartManager, uConfigUnit,
  uDataStruct, uCommand, uDrawView, ufrmlogin, Glass, ButtonGroup;

const
  WM_BEGIN = WM_USER + 1;

type
  PMainWindow = ^TMainWindow;

  TMainWindow = class(TForm)
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
    GroupBox: TGroupBox;
    PoinsitionListView: TListView;
    Splitter1: TSplitter;
    Splitter2: TSplitter;
    Splitter3: TSplitter;
    TopGrid: TStringGrid;
    ButtomPanel: TPanel;
    PositionPanel: TPanel;
    HistoryOrderPanel: TPanel;
    Splitter4: TSplitter;
    countEdit: TEdit;
    Label2: TLabel;
    Label1: TLabel;
    priceEdit: TEdit;
    RichEdit1: TRichEdit;
    MainMenu1: TMainMenu;
    N1: TMenuItem;
    N2: TMenuItem;
    ContractIdComboBox: TComboBox;
    PriceBaseLabel: TLabel;
    PriceGroup: TGroupBox;
    BuyPriceLabel: TLabel;
    SellPriceLabel: TLabel;
    middlemiddlePanel: TPanel;
    SuccessOrderPanel: TPanel;
    OrderListView: TListView;
    SuccessOrderListView: TListView;
    RichEdit2: TRichEdit;
    OrderPageControl: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet5: TTabSheet;
    noDealListView: TListView;
    RecallGroupBox: TGroupBox;
    RecallButton: TButton;
    RecallAllButton: TButton;
    StatusBar1: TStatusBar;
    FFuturesQuotationGrid: TStringGrid;
    PageControl1: TPageControl;
    TabSheet2: TTabSheet;
    TabSheet3: TTabSheet;
    TabSheet4: TTabSheet;
    ActualsQuotationGrid: TStringGrid;
    FOptionQuotationGrid: TStringGrid;
    N3: TMenuItem;
    N4: TMenuItem;
    N5: TMenuItem;
    N6: TMenuItem;
    N7: TMenuItem;
    N8: TMenuItem;
    N9: TMenuItem;
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
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure RichEdit1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure RichEdit1Click(Sender: TObject);
    procedure RichEditMouseWheel(Sender: TObject; Shift: TShiftState; WheelDelta: Integer; MousePos: TPoint; var Handled: Boolean);
    procedure N2Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure ContractIdComboBoxKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure ContractIdComboBoxClick(Sender: TObject);
    procedure RichEdit2Change(Sender: TObject);
    procedure RecallButtonClick(Sender: TObject);
    procedure RecallAllButtonClick(Sender: TObject);
    procedure noDealListViewColumnClick(Sender: TObject; Column: TListColumn);
    procedure priceEditKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure BuyPriceLabelClick(Sender: TObject);
    procedure SellPriceLabelClick(Sender: TObject);
    procedure N1Click(Sender: TObject);
    procedure N4Click(Sender: TObject);
    procedure N5Click(Sender: TObject);
    procedure N6Click(Sender: TObject);
    procedure N7Click(Sender: TObject);
    procedure N8Click(Sender: TObject);
    procedure N9Click(Sender: TObject);
  private
    { Private declarations }
    Glass: TGlass;
    procedure InitMainFrom(var msg: TMessage); message WM_BEGIN;
  protected //重载此函数
    procedure CreateParams(var Params: TCreateParams); override;
  public

    { Public declarations }
    procedure InitWidgets();
    procedure Connected();
    procedure updateData();
//    procedure DrawPositionListView();
    procedure InitTradeData();
    procedure PushOneOrder(Adir: Char; Aoffset: Char);
  end;

procedure AddConteact(list: TStringList);

procedure FuturesLoginInit();

function CustomSortProc(Item1, Item2: TListItem; Index: integer): integer; stdcall;

var
  MainWindow: TMainWindow;
  nChar: PChar = PChar('');
//  quotationProxy: TQuotationProxy;
//  tradeProxy: TTradeProxy;
//  FDataSchedule: TDataSchedule;
  FSeriesManager: TmySeriesManager;
  TotalValue: double;
  QuotationThread: TThread;
  m_bSort: boolean = false;

implementation

uses
  ufrmAddConteact, uTradeUnit, Math, uGlobalInstance, ufrmLoginForm,
  uTradeResponse, uDataCenter;

{$R *.dfm}
procedure TMainWindow.InitMainFrom(var msg: TMessage);
var
  arr: array of PChar;
  tmp: Integer;
begin
  Glass := TGlass.Create(nil);

  TManagerThread.ThreadList := TList.Create;
  WindowState := wsMaximized;
  MainWindow := Self;
//  InitConfiguration();
  //  Self.Height := Screen.WorkAreaHeight;
  //  Self.Width := Screen.WorkAreaWidth;
  InitWidgets();
    //数据调度器新建
  FDataSchedule := TDataSchedule.Create(@Self);
    //走势图管理器新建
  FSeriesManager := TmySeriesManager.Create(@FutureChart);
//  TManagerThread.Create(1, Connected);
    //  FutureChart.LeftAxis.SetMinMax(0, 100);
    //  FutureChart.BottomAxis.SetMinMax(0, 100);
    //  FutureChart.RightAxis.SetMinMax(0, 100);
    //FutureChart.LeftAxis.SetMinMax(-100, 100);
  //    for I := 0 to 100 do
  //    begin
  //      Value := I;
  //      PriceSeries.Add(Value, IntToStr(I));
  //    end;

  if (QuotationServerStatus.FuturesIsLogin) then
  begin
     //行情初始化订阅
    SetLength(arr, 3);
    arr[0] := Pchar('IF2108');
    arr[1] := Pchar('IH2108');
    arr[2] := Pchar('IC2108');
    tmp := FQuotationProxy.Subscribe(Pointer(arr), 3);
    if (tmp = 0) then
    begin
      TDrawView.Instance().initQuotationView(arr);
    end;
  end;
  QuotationThread := TManagerThread.Create(updateData);

  if (TradeServerStatus.FuturesIsLogin) then
  begin
    InitTradeData();
  end;

end;

procedure TMainWindow.InitWidgets();
var
  title: TStrings;
begin
  Glass := TGlass.Create(Owner);
  title := TStringList.Create;
  if (QuotationServerStatus.FuturesIsLogin) then
  begin
    FuturesLoginInit();
  end;
  title.DelimitedText := '合约,最新价,涨跌,买价,买量,卖价,卖量,成交量,持仓量,涨停价,跌停价,今开盘,昨结算,最高价,最低价,现量,涨跌幅,昨收盘,成交额,行情更新时间';
  FFuturesQuotationGrid.Rows[0] := title;
  FOptionQuotationGrid.Rows[0] := title;
  ActualsQuotationGrid.Rows[0] := title;
  title.DelimitedText := '可用资金,持仓盈亏,平仓盈亏';
  TopGrid.Rows[0] := title;
  TopGrid.ColCount := 3;

  //报单看板中的卖5~买1价表
  PriceGrid.ColCount := 2;
  PriceGrid.RowCount := 10;
  PriceGrid.ColWidths[1] := 15;
  PriceGrid.Height := PriceGrid.DefaultRowHeight * PriceGrid.RowCount + 10;
  PriceGrid.Width := PriceGrid.DefaultColWidth + PriceGrid.ColWidths[1] + 10;

  title.Free;
//  PriceGrid.Row := -1;
end;

procedure TMainWindow.CreateParams(var Params: TCreateParams);
begin
  inherited;
  with Params do
  begin
    WndParent := 0;
  end;
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
    MainWindow.ContractIdComboBox.Items := FDataSchedule.FFuturesSeatingList;
    MainWindow.ContractIdComboBox.ItemIndex := FFuturesQuotationGrid.Row - 1;
  end;

end;

procedure TMainWindow.priceEditKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if (Key = VK_RETURN) then
  begin
    Button1.SetFocus;
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
  if (TradeServerStatus.FuturesIsLogin) then
  begin
    GroupBox.Enabled := True;
  end;
  if (InputOrderRadioGroup.ItemIndex = 0) then
  begin
    priceEdit.Enabled := False;
    priceEdit.Color := clSilver;
  end
  else
  begin
    priceEdit.Enabled := True;
    priceEdit.Color := clWhite;
  end;
end;

procedure TMainWindow.N1Click(Sender: TObject);
begin
  if (QuotationServerStatus.FuturesIsLogin) then
  begin
    N7.Caption := '期货(' + QuotationServerStatus.FuturesServer + ')';
  end;
  if (QuotationServerStatus.OptionIsLogin) then
  begin
    N7.Caption := '期权(' + QuotationServerStatus.OptionServer + ')';
  end;
  if (QuotationServerStatus.SharesIsLogin) then
  begin
    N7.Caption := '现货(' + QuotationServerStatus.SharesServer + ')';
  end;
  if (TradeServerStatus.FuturesIsLogin) then
  begin
    N7.Caption := '期货(' + TradeServerStatus.FuturesAccount + ')';
  end;
  if (TradeServerStatus.OptionIsLogin) then
  begin
    N7.Caption := '期权(' + TradeServerStatus.OptionAccount + ')';
  end;
  if (TradeServerStatus.FuturesIsLogin) then
  begin
    N7.Caption := '现货(' + TradeServerStatus.SharesAccount + ')';
  end;

end;

procedure TMainWindow.N2Click(Sender: TObject);
var
  p: PAccountStruct;
begin

  p := PAccountStruct(AccountList.Objects[DefaultAccountIndex]);
  LoginTradeFrom.accountedit.Text := p.sAccount;
  LoginTradeFrom.passwordedit.Text := '';
end;

{交易期货}
procedure TMainWindow.N4Click(Sender: TObject);
begin
  if (TradeServerStatus.FuturesIsLogin) then
  begin
    //切换界面
  end
  else
  begin
    //登录界面
    LoginTradeFrom.Show;
  end;
end;

{交易期权}
procedure TMainWindow.N5Click(Sender: TObject);
begin
  if (TradeServerStatus.OptionIsLogin) then
  begin
    //切换界面
  end
  else
  begin
    //登录界面
    LoginTradeFrom.Show;
  end;
end;

{交易现货}
procedure TMainWindow.N6Click(Sender: TObject);
begin
  if (TradeServerStatus.SharesIsLogin) then
  begin
    //切换界面
  end
  else
  begin
    //登录界面
    LoginTradeFrom.Show;
  end;
end;

{行情期货}
procedure TMainWindow.N7Click(Sender: TObject);
begin
  if (QuotationServerStatus.FuturesIsLogin) then
  begin
    //切换界面
  end
  else
  begin
    //登录界面

  end;
end;

{行情期权}
procedure TMainWindow.N8Click(Sender: TObject);
begin
  if (QuotationServerStatus.OptionIsLogin) then
  begin
    //切换界面
  end
  else
  begin
    //登录界面

  end;
end;

{行情现货}
procedure TMainWindow.N9Click(Sender: TObject);
begin
  if (QuotationServerStatus.SharesIsLogin) then
  begin
    //切换界面
  end
  else
  begin
    //登录界面

  end;
end;

procedure TMainWindow.noDealListViewColumnClick(Sender: TObject; Column: TListColumn);
begin
  TListView(Sender).CustomSort(@CustomSortProc, Column.Index);
  m_bSort := not m_bSort;
end;

function CustomSortProc(Item1, Item2: TListItem; Index: integer): integer; stdcall;
var
  c1, c2: string;
  v1, v2: Double;
begin

  if Index <> 0 then
  begin

    c1 := Item1.SubItems.Strings[Index - 1];

    c2 := Item2.SubItems.Strings[Index - 1];

    if m_bSort then
    begin
      if ((TryStrToFloat(c1, v1)) and (TryStrToFloat(c2, v2))) then
      begin
        Result := CompareValue(v1, v2);
      end
      else
      begin
        Result := CompareText(c1, c2);
      end;

    end
    else

    begin
      if ((TryStrToFloat(c1, v2)) and (TryStrToFloat(c1, v2))) then
      begin
        Result := -CompareValue(v1, v2);
      end
      else
      begin
        Result := -CompareText(c1, c2);
      end;

    end;

  end
  else

  begin

    if m_bSort then
    begin

      Result := CompareText(Item1.Caption, Item2.Caption);
    end
    else

    begin

      Result := -CompareText(Item1.Caption, Item2.Caption);

    end;

  end;

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
    //下拉框选择当前合约
    ContractIdComboBox.Text := sid;
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
  if (ARow > 0) and ((ACol = 1) or (ACol = 3) or (ACol = 5)) then
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

//关闭窗体
procedure TMainWindow.FormClose(Sender: TObject; var Action: TCloseAction);
var
  p: Pointer;
begin
//  Self.Close;
  for p in TManagerThread.ThreadList do
  begin
    TManagerThread(p).Terminate;
    TManagerThread(p).WaitFor();
  end;

  WindowList.Remove(Self);
  if (WindowList.Count = 0) then
  begin
    LoginForm.Close;
  end;
end;

procedure TMainWindow.FormResize(Sender: TObject);
begin
  FFuturesQuotationGrid.DefaultColWidth := width div 20;
  FFuturesQuotationGrid.ColWidths[4] := 50;
  FFuturesQuotationGrid.ColWidths[6] := 50;
  FFuturesQuotationGrid.ColWidths[18] := FFuturesQuotationGrid.ColWidths[18] + 30;
  //各个panel的比例
  GridPanel.Height := Trunc(Self.Height * 0.2);
  middlePanel.Height := Trunc(Self.Height * 0.4);
  ChartPanel.Width := Trunc(Self.Width * 0.33);
  middlemiddlePanel.Width := Trunc(Self.Width * 0.37);
  PositionPanel.Width := Trunc(Self.Width * 0.4);
  SuccessOrderPanel.Width := Trunc(Self.Width * 0.35);

  TopGrid.DefaultColWidth := (middlerightPanel.Width div 3) - 3;
  TopGrid.Height := TopGrid.DefaultRowHeight * 2 + 10;

  //已经隐藏了
  PriceGrid.Top := (middlerightPanel.Height - PriceGrid.Height) div 2;
  PriceGrid.Left := Trunc(middlerightPanel.Width * 0.08);

  PriceGroup.Left := Trunc(middlerightPanel.Width * 0.05);
  PriceGroup.Top := (middlerightPanel.Height - PriceGrid.Height) div 2;

  GroupBox.Top := ((middlerightPanel.Height - TopGrid.Height - GroupBox.Height) div 2) + TopGrid.Height;
  GroupBox.Left := PriceGroup.Left + PriceGroup.Width + 20;
end;

procedure TMainWindow.FormShow(Sender: TObject);
begin
  WindowList.Add(Self);
  PostMessage(handle, WM_BEGIN, 0, 0);
  LoginForm.Visible := False;
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
  PushOneOrder(cdir, coffset);
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
  PushOneOrder(cdir, coffset);
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
  PushOneOrder(cdir, coffset);
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
  PushOneOrder(cdir, coffset);
end;

procedure TMainWindow.BuyPriceLabelClick(Sender: TObject);
begin
  if (InputOrderRadioGroup.ItemIndex = 1) then
  begin
    priceEdit.Text := BuyPriceLabel.Caption;
  end;
end;

procedure TMainWindow.PushOneOrder(Adir: Char; Aoffset: Char);
var
  sid: string;
  index: Integer;
  dprice: double;
  icount: Integer;
  stemp: string;
begin
  if Adir = '0' then
  begin
    index := 5;
  end
  else
  begin
    index := 3;
  end;
  if TryStrToInt(countEdit.Text, icount) = False then
  begin
    MessageBox(0, '手数内请输入整数', '提示', MB_OK);
    Exit;
  end;
  if (ContractIdComboBox.ItemIndex >= 0) then
  begin
    sid := ContractIdComboBox.Text;
  end
  else
  begin
    MessageBox(0, '请在下拉框中选择合约', '提示', MB_OK);
    Exit;
  end;
  if (InputOrderRadioGroup.ItemIndex = 1) then
  begin
    if TryStrToFloat(priceEdit.Text, dprice) = False then
    begin
      MessageBox(0, '价格栏内请输入数字', '提示', MB_OK);
      Exit;
    end;
  end
  else
  begin
    stemp := FFuturesQuotationGrid.Cells[index, FDataSchedule.FFuturesSeatingList.IndexOf(sid) + 1];
    if ((stemp = '') or (not TryStrToFloat(stemp, dprice))) then
    begin
      MessageBox(0, '暂无对手价', '下单失败', MB_OK);
      Exit;
    end
    else
    begin
      dprice := StrToFloat(stemp);
    end;
  end;
  FTradeProxy.AddLimitPriceOrder(PChar(sid), Adir, Aoffset, dprice, icount);

end;

procedure TMainWindow.RecallAllButtonClick(Sender: TObject);
var
  iret: Integer;
  I: Integer;
  index: Integer;
  pdata: PThostFtdcOrderField;
  tempList: TList;
begin
  iret := MessageBox(Self.Handle, '确认要撤回所有未成交单？', '确认', MB_OKCANCEL);
  if (iret = 1) then
  begin
    tempList := TList.Create();
    for I := 0 to TOrderDataCenter.instance.getNoDealList.Count - 1 do
    begin
      index := Integer(TOrderDataCenter.instance.getNoDealList.Objects[I]);
      tempList.Add(TOrderDataCenter.instance.getList.Objects[index]);
    end;
    for pdata in tempList do
    begin
      FTradeProxy.DeleteOrder(pdata.InstrumentID, pdata.ExchangeID, pdata.OrderSysID);
    end;
    tempList.Destroy;
    tempList := nil;
  end;
end;

procedure TMainWindow.RecallButtonClick(Sender: TObject);
var
  p: TListItem;
  index: Integer;
  pdata: PThostFtdcOrderField;
  iret: Integer;
  str: PChar;
begin
  if (noDealListView.ItemIndex = -1) then
  begin
    MessageBox(Self.Handle, '请选择要指定的订单！', '提示', MB_OK);
  end
  else
  begin
    iret := MessageBox(Self.Handle, PChar('确定撤单？委托号：' + noDealListView.Items[noDealListView.ItemIndex].SubItems.Strings[5]), '确认', MB_OKCANCEL);
    if (iret = 1) then
    begin
      index := Integer(TOrderDataCenter.instance.getNoDealList.Objects[noDealListView.ItemIndex]);
      pdata := PThostFtdcOrderField(TOrderDataCenter.instance.getList.Objects[index]);
      FTradeProxy.DeleteOrder(pdata.InstrumentID, pdata.ExchangeID, pdata.OrderSysID);
    end;
  end;
end;

procedure TMainWindow.RichEdit1Click(Sender: TObject);
begin
  RichEdit1.SelStart := Length(RichEdit1.Text);
end;

procedure TMainWindow.RichEdit1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
var
  iIndex, iLine: Integer;
  str: string;
begin
  if ((Key = Vk_Up) or (Key = Vk_Down)) then
  begin
    Key := 0;
    Exit;
  end;

  if ((Key = VK_LEFT) or (Key = VK_BACK)) then
  begin
    iLine := SendMessage(RichEdit1.Handle, EM_LINEFROMCHAR, RichEdit1.SelStart, 0);
    iIndex := RichEdit1.SelStart - SendMessage(RichEdit1.Handle, EM_LINEINDEX, iLine, 0);
    if (iIndex = Length(userName) + 5) then
    begin
      Key := 0;
      Exit;
    end;

  end;
  if (Key = VK_RETURN) then
  begin
    //换行打印
    RichEdit1.Lines.Add('');
    iLine := SendMessage(RichEdit1.Handle, EM_LINEFROMCHAR, RichEdit1.SelStart, 0);
    str := '[' + userName + ']:$ ';
    RichEdit1.Lines.Strings[iLine] := RichEdit1.Lines.Strings[iLine] + str;
    RichEdit1.SelStart := Length(RichEdit1.Text) - Length(str);
    RichEdit1.SelLength := Length(str);
    Richedit1.SelAttributes.Color := clRed;
    RichEdit1.SelStart := Length(RichEdit1.Text);
    RichEdit1.SelLength := 0;
    Richedit1.SelAttributes.Color := clBlack;
    Exit;
  end;

end;

procedure TMainWindow.RichEdit2Change(Sender: TObject);
begin
  inherited;
  SendMessage(TRichEdit(Sender).Handle, WM_VSCROLL, SB_BOTTOM, 0);
end;

procedure TMainWindow.RichEditMouseWheel(Sender: TObject; Shift: TShiftState; WheelDelta: Integer; MousePos: TPoint; var Handled: Boolean);
var
  I: Integer;
begin
  if (WheelDelta > 0) then
  begin
    TRichEdit(Sender).Perform(EM_SCROLL, SB_LINEUP, 0);
  end
  else
  begin
    TRichEdit(Sender).Perform(EM_SCROLL, SB_LINEDOWN, 0);
  end;
end;

procedure TMainWindow.SellPriceLabelClick(Sender: TObject);
begin
  if (InputOrderRadioGroup.ItemIndex = 1) then
  begin
    priceEdit.Text := SellPriceLabel.Caption;
  end;
end;

procedure TMainWindow.Connected();
var
  tmp: Integer;
  arr: array of PChar;
  times: Integer;
  pQuotationServer: PQuotationServerStruct;
begin
  FQuotationProxy := TQuotationProxy.Create(dllName);
  pQuotationServer := PQuotationServerStruct(FutureQuotationServerList.Objects[DefaultFutureQuotationServerIndex]);
  FQuotationProxy.Connected(PChar(pQuotationServer.sServer), Pchar(''));
  tmp := 0;
  while FQuotationProxy.IsConnected <> True do
  begin
    Sleep(1000);
    tmp := tmp + 1;
    if (tmp > 10) then
    begin
      MessageBox(0, '行情自动登录失败', '提示', MB_OK);
      Exit;
    end;
//    Writeln('[delphi]: waiting for connected ...');
  end;
  FQuotationProxy.SimpleLogin(nChar, nChar, nChar);
  while FQuotationProxy.LoginSucess <> True do
  begin

    Sleep(1000);
//    Writeln('[delphi]: waiting for login ...');
  end;
  SetLength(arr, 3);
  arr[0] := Pchar('IF2108');
  arr[1] := Pchar('IH2108');
  arr[2] := Pchar('IC2108');
  tmp := FQuotationProxy.Subscribe(Pointer(arr), 3);
  if tmp = 0 then
  begin
    FDataSchedule.AddContracts(arr);
    ContractIdComboBox.Items := FDataSchedule.FFuturesSeatingList;
    ContractIdComboBox.ItemIndex := 0;
    FSeriesManager.SetCurrentSeries(FDataSchedule.FFuturesSeatingList[2]);
    FSeriesManager.SetCurrentSeries(FDataSchedule.FFuturesSeatingList[1]);
    FSeriesManager.SetCurrentSeries(FDataSchedule.FFuturesSeatingList[0]);
  end;
//  QuotationThread := TManagerThread.Create(updateData);
end;

procedure TMainWindow.ContractIdComboBoxClick(Sender: TObject);
var
  index: Integer;
begin
  index := MainWindow.ContractIdComboBox.ItemIndex;
  if (index >= 0) then
  begin
    FFuturesQuotationGrid.Row := index + 1;
    //管理器切换当前数据
    FSeriesManager.SetCurrentSeries(FDataSchedule.FFuturesSeatingList[FFuturesQuotationGrid.Row - 1]);
  end;

end;

procedure TMainWindow.ContractIdComboBoxKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
var
  arr: array of PChar;
  str: string;
  itmp: Integer;
  index: Integer;
begin
  if (Key = VK_RETURN) then
  begin
    str := ContractIdComboBox.Text;
    SetLength(arr, 1);
    arr[0] := Pchar(str);
    index := MainWindow.ContractIdComboBox.Items.IndexOf(str);
    //如果输入的合约ID不存在。
    if (index = -1) then
    begin
      itmp := FQuotationProxy.Subscribe(Pointer(arr), 1);
      if itmp = 0 then
      begin
        FDataSchedule.AddContracts(arr);
        MainWindow.ContractIdComboBox.Items := FDataSchedule.FFuturesSeatingList;
      end
      else
      begin
        MessageBox(0, '合约不存在或输入格式错误!', '提示', MB_OKCANCEL);
      end;
    end;
    index := MainWindow.ContractIdComboBox.Items.IndexOf(str);
    ContractIdComboBox.ItemIndex := index;
    FFuturesQuotationGrid.Row := index + 1;
    //管理器切换当前数据
    FSeriesManager.SetCurrentSeries(FDataSchedule.FFuturesSeatingList[FFuturesQuotationGrid.Row - 1]);

  end;

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

procedure TMainWindow.InitTradeData();
begin
////
  //资金情况初始化
  FTradeProxy.CheckCapital();
  //持仓初始化
  FTradeProxy.RequestCheckPosition();

  //订单初始化
  FTradeProxy.RequestCheckOrder();
//  TRequestMessenger.instance.Request(TRequestMessenger.instance.Order);
  //已成交订单初始化
  FTradeProxy.RequestSucessedOrder();
////  TopGrid.Cells[0, 1] := FloatToStr(RoundTo(data.Available, 2));
////  TopGrid.Cells[1, 1] := FloatToStr(RoundTo(data.WithdrawQuota, 2));
////  TopGrid.Cells[2, 1] := FloatToStr(data.Reserve);
////  TopGrid.Cells[3, 1] := FloatToStr(data.Mortgage);
////  TopGrid.Cells[4, 1] := FloatToStr(data.Credit);
////  TopGrid.Cells[5, 1] := FloatToStr(RoundTo(data.PositionProfit, 2));
////  TopGrid.Cells[6, 1] := FloatToStr(RoundTo(data.CloseProfit, 2));
////  TopGrid.Cells[7, 1] := FloatToStr(RoundTo(data.CurrMargin, 2));
////  TopGrid.Cells[8, 1] := FloatToStr(data.Interest);
////  TopGrid.Cells[9, 1] := FloatToStr(data.CloseProfit);
  if (FtradeProxy.isLogin) then
  begin
    GroupBox.Enabled := True;
  end;
end;

procedure TMainWindow.updateData();
var
  tick: TQuotationData;
  id: string;
  icount: integer;
begin
  icount := FDataSchedule.FFuturesSeatingList.Count;
  if icount <= 0 then
    icount := 1;
  Sleep(500 div icount);
  tick := FQuotationProxy.GetOneTick();
  if (tick.InstrumentID <> '') then
  begin
    FDataSchedule.ScheduleTick(tick);
  end;
//    Total_Quotation.Rows[1] := fQuotationView(tick);
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
  itmp := FquotationProxy.Subscribe(Pointer(arr), list.Count);
  if itmp = 0 then
  begin
    FDataSchedule.AddContracts(arr);
  end
  else
  begin
    MessageBox(0, '合约不存在或输入格式错误!', '提示', MB_OKCANCEL);
  end;
end;

procedure ContractBoxChange(Aid: string);
var
  arr: array of PChar;
  itmp: integer;
  I: Integer;
  str: string;
begin
  MainWindow.ContractIdComboBox.ItemIndex;
  SetLength(arr, 1);
  arr[0] := Pchar(Aid);

end;

procedure FuturesLoginInit();
begin
  MainWindow.StatusBar1.Panels[0].text := '行情地址：' + QuotationServerStatus.FuturesServer;
end;

end.

