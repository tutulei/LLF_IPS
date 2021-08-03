﻿unit MainWIN;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Menus, ComCtrls, uQuotationAPI, uTradeAPI, uManagerThread,
  DB, ADODB, uContractsSchedule, StrUtils, uConstants, Grids, ExtCtrls, TeeProcs,
  TeEngine, Chart, Series, TeeFunci, SyncObjs, uMyChartManager, uConfigUnit,
  uDataStruct, uCommand, uDrawView, ufrmlogin;

const
  WM_BEGIN = WM_USER + 1;

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
    N3: TMenuItem;
    N4: TMenuItem;
    N5: TMenuItem;
    N6: TMenuItem;
    N7: TMenuItem;
    ComboBox1: TComboBox;
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
    procedure RichEdit1MouseWheel(Sender: TObject; Shift: TShiftState; WheelDelta: Integer; MousePos: TPoint; var Handled: Boolean);
    procedure N6Click(Sender: TObject);
    procedure N2Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    procedure InitMainFrom(var msg: TMessage); message WM_BEGIN;
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

var
  MainWindow: TMainWindow;
  nChar: PChar = PChar('');
  quotationProxy: TQuotationProxy;
  tradeProxy: TTradeProxy;
  FDataSchedule: TDataSchedule;
  FSeriesManager: TmySeriesManager;
  TotalValue: double;
  QuotationThread: TThread;

implementation

uses
  ufrmAddConteact, uTradeUnit, Math;

{$R *.dfm}
procedure TMainWindow.InitMainFrom(var msg: TMessage);
begin
  TManagerThread.ThreadList := TList.Create;
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
  TManagerThread.Create(1, Connected);
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

procedure TMainWindow.N2Click(Sender: TObject);
begin
  LoginTradeFrom.Show;
  LoginTradeFrom.accountedit.Text := defaultAccount.sAccount;
  LoginTradeFrom.passwordedit.Text := defaultAccount.sPassword;
  LoginTradeFrom.authcodeedit.Text := defaultAccount.sAuthCode;
  LoginTradeFrom.brokeridedit.Text := defaultAccount.sBrokerID;
  LoginTradeFrom.appidedit.Text := defaultAccount.sAppid;
end;

procedure TMainWindow.N6Click(Sender: TObject);
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
end;

procedure TMainWindow.FormResize(Sender: TObject);
begin
  FFuturesQuotationGrid.DefaultColWidth := Width div 20;
  FFuturesQuotationGrid.ColWidths[4] := 50;
  FFuturesQuotationGrid.ColWidths[6] := 50;
  FFuturesQuotationGrid.ColWidths[18] := FFuturesQuotationGrid.ColWidths[18] + 30;
  //各个panel的比例
  GridPanel.Height := Trunc(Self.Height * 0.2);
  middlePanel.Height := Trunc(Self.Height * 0.4);
  ChartPanel.Width := Trunc(Self.Width * 0.7);

  TopGrid.DefaultColWidth := (middlerightPanel.Width div 3) - 3;
  TopGrid.Height :=  TopGrid.DefaultRowHeight * 2 + 10;

  PriceGrid.Top := (middlerightPanel.Height - PriceGrid.Height) div 2;
  PriceGrid.Left := Trunc(middlerightPanel.Width * 0.1);
  GroupBox.Top := ((middlerightPanel.Height - TopGrid.Height - GroupBox.Height) div 2) + TopGrid.Height;
  GroupBox.Left := PriceGrid.Left + PriceGrid.Width + 20;
end;

procedure TMainWindow.FormShow(Sender: TObject);
begin
  PostMessage(handle, WM_BEGIN, 0, 0);
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

  sid := FDataSchedule.FFuturesSeatingList[FFuturesQuotationGrid.Row - 1];
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
    if (stemp = '') then
    begin
      MessageBox(0, '暂无对手价', '下单失败', MB_OK);
      Exit;
    end
    else
    begin
      dprice := StrToFloat(stemp);
    end;
  end;
  tradeProxy.AddLimitPriceOrder(PChar(sid), Adir, Aoffset, dprice, icount);

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

procedure TMainWindow.RichEdit1MouseWheel(Sender: TObject; Shift: TShiftState; WheelDelta: Integer; MousePos: TPoint; var Handled: Boolean);
var
  I: Integer;
begin
  if (WheelDelta > 0) then
  begin
    RichEdit1.Perform(EM_SCROLL, SB_LINEUP, 0);
  end
  else
  begin
    RichEdit1.Perform(EM_SCROLL, SB_LINEDOWN, 0);
  end;
end;

procedure TMainWindow.Connected();
var
  tmp: Integer;
  arr: array of PChar;
  times: Integer;
begin
  quotationProxy := TQuotationProxy.Create(dllName);
  quotationProxy.Connected(PChar(account1.sQuotationServer), Pchar(''));
  tmp := 0;
  while quotationProxy.IsConnected <> True do
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
  QuotationThread := TManagerThread.Create(updateData);
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
//  //同步初始化资金情况
  tradeProxy.CheckCapital();
//  TopGrid.Cells[0, 1] := FloatToStr(RoundTo(data.Available, 2));
//  TopGrid.Cells[1, 1] := FloatToStr(RoundTo(data.WithdrawQuota, 2));
//  TopGrid.Cells[2, 1] := FloatToStr(data.Reserve);
//  TopGrid.Cells[3, 1] := FloatToStr(data.Mortgage);
//  TopGrid.Cells[4, 1] := FloatToStr(data.Credit);
//  TopGrid.Cells[5, 1] := FloatToStr(RoundTo(data.PositionProfit, 2));
//  TopGrid.Cells[6, 1] := FloatToStr(RoundTo(data.CloseProfit, 2));
//  TopGrid.Cells[7, 1] := FloatToStr(RoundTo(data.CurrMargin, 2));
//  TopGrid.Cells[8, 1] := FloatToStr(data.Interest);
//  TopGrid.Cells[9, 1] := FloatToStr(data.CloseProfit);
//  Sleep(1000);
  tradeProxy.RequestCheckPosition();
end;

procedure TMainWindow.updateData();
var
  tick: TQuotationData;
  id: string;
begin
  Sleep(500 div FDataSchedule.FFuturesSeatingList.Count);
  tick := quotationProxy.GetOneTick();
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

