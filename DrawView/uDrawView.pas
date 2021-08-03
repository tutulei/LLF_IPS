unit uDrawView;

interface

uses
  uDataCenter, Classes, uDataStruct, IdGlobal, Graphics, ComCtrls;

type
  TDrawView = class(TThread)
  private
    CriticalSection: TCriticalSection;
    class var
      ins: TDrawView;
  public
    class function instance(): TDrawView;
    constructor Create(CreateSuspended: Boolean = False);
    procedure RunSynchronize(AMethod: TThreadMethod);
    //持仓界面刷新
    procedure DrawPositionListView();
    //行情界面刷新
    procedure DrawQuotationGridView();
    //订单响应更新至文本窗口
    procedure PushOrderToCommandWindows();
    //资金状况刷新
    procedure DrawAccountCapital();
  end;

procedure addRichText(edit: TRichEdit; text: TStrings; color: Integer);

implementation

uses
  MainWIN, SysUtils, uConstants, uContractsSchedule, MATH, StrUtils,
  Windows, Messages, RichEdit;

constructor TDrawView.Create(CreateSuspended: Boolean = False);
begin
  inherited Create(CreateSuspended);
  CriticalSection := TCriticalSection.Create();
end;

procedure TDrawView.RunSynchronize(AMethod: TThreadMethod);
begin
  CriticalSection.Enter;
//  MessageBox(0, PChar('[MySpi] run'+string(GetCurrentProcess)), 'Waring', IDOK);
  Synchronize(AMethod);
  CriticalSection.Leave;
end;

class function TDrawView.instance(): TDrawView;
begin
  if (ins = nil) then
  begin
    ins := TDrawView.Create(True);
  end;
  Result := ins;
end;

//更新界面的持仓表
procedure TDrawView.DrawAccountCapital;
begin
  MainWindow.TopGrid.Cells[0, 1] := FloatToStr(RoundTo(TradingAccountField.Available, 2));
  MainWindow.TopGrid.Cells[1, 1] := FloatToStr(RoundTo(TradingAccountField.CloseProfit, 2));
  MainWindow.TopGrid.Cells[2, 1] := FloatToStr(TradingAccountField.PositionProfit);
end;

procedure TDrawView.DrawPositionListView();
var
  p: ^CThostFtdcInvestorPositionField;
  item: TListItem;
  PosiDirection: PChar;
  index: Integer;
  skey: string;
begin
  index := -1;
//  MessageBox(0, PChar('[DrawPositionListView] run'), 'Waring', IDOK);
  p := TPositionDataCenter.Instance.Item;
  skey := p.InstrumentID + '-' + p.PosiDirection;
  index := TPositionDataCenter.Instance.getList.IndexOf(skey);
  if (p.Position = 0) then
  begin
    Exit;
  end;

  //尝试获取item
  if (index <> -1) then
  begin
    item := MainWindow.PoinsitionListView.Items.Item[index];
  end;

  //不存在就添加，已经存在就清空
  if (item = nil) then
  begin
    item := MainWindow.PoinsitionListView.Items.Add;
  end
  else
  begin
    item.SubItems.Clear;
  end;

  item.Caption := p.InstrumentID;
  case p.PosiDirection of
    THOST_FTDC_PD_Net:
      PosiDirection := PChar('  净');
    THOST_FTDC_PD_Long:
      PosiDirection := PChar('买');
    THOST_FTDC_PD_Short:
      PosiDirection := PChar('     卖');
  end;
  item.SubItems.Add(PosiDirection);
  item.SubItems.Add(FloatToStr(p.Position));
  item.SubItems.Add(FloatToStr(p.Position - p.TodayPosition));
  item.SubItems.Add(FloatToStr(p.TodayPosition));
  //持仓均价
  item.SubItems.Add(FloatToStr(p.SettlementPrice));
  item.SubItems.Add(FloatToStr(RoundTo(p.PositionProfit, -2)));
  item.SubItems.Add(FloatToStr(p.UseMargin));
  item.SubItems.Add(p.HedgeFlag);
  item.SubItems.Add(p.ExchangeID);
//  list := tradeProxy.CheckPosition();
end;

procedure TDrawView.DrawQuotationGridView();
var
  sid: string;
  index: Integer;
begin
  //将数据中心的当前数据推到界面
  sid := TStrings(TQuotationDataCenter.Instance.Item).Strings[0];
  index := FDataSchedule.FFuturesSeatingList.IndexOf(sid);
  MainWindow.FFuturesQuotationGrid.Rows[index + 1] := TStrings(TQuotationDataCenter.Instance.Item);
end;

procedure TDrawView.PushOrderToCommandWindows();
var
  iLine: Integer;
  color: Integer;
  temp: Integer;
//  fmt : TCharFormat2;
begin
  temp := MainWindow.RichEdit1.SelStart;
  MainWindow.RichEdit1.Lines.Add('');
  addRichText(MainWindow.RichEdit1,TStrings(TCommandWindowsDataCenter.instance.Item),clBlue);
//  iLine := SendMessage(MainWindow.RichEdit1.Handle, EM_LINEFROMCHAR, MainWindow.RichEdit1.SelStart, 0);

//
//  fmt.cbSize := SizeOf(fmt);
//  fmt.dwMask := CFM_COLOR or CFM_BACKCOLOR;
//  fmt.crTextColor := clWhite;
//  fmt.crBackColor := $004B9700;
//  MainWindow.RichEdit1.Perform(EM_SETCHARFORMAT, SCF_SELECTION, integer(@Fmt))

end;

procedure addRichText(edit: TRichEdit; text: TStrings; color: Integer);
var
  temp: Integer;
begin
  temp := edit.SelStart;
  edit.Lines.AddStrings(text);
  edit.SelStart := temp;
  edit.SelLength := Length(text.Text);
  edit.SelAttributes.Color := color;
  edit.SelStart := temp + Length(text.Text);
  edit.SelLength := 0;
  edit.SelAttributes.Color := clBlack;
  edit.lines.Delete(edit.Lines.Count-1);
//  text.Free;
end;

end.

