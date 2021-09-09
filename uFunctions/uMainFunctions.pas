unit uMainFunctions;

interface

uses
  uConstants, MainWIN, Classes, Windows;

procedure ChangeTradeView(AType: ContractType);

function getCurrentType(): ContractType;

function getOptionMarket(code: string): Integer;

procedure ShowButtomsView(show: Boolean);

procedure InitTradeData();

implementation

uses
  uDataCenter, uDataStruct, uDrawView, ComCtrls, uGlobalInstance, Graphics;

procedure ChangeTradeView(AType: ContractType);
var
  dataList: TStringlist;
  I: Integer;
  item: TListItem;
begin
  //清空数据
  MainWindow.PoinsitionListView.Clear;
  MainWindow.OrderListView.Clear;
  MainWindow.SuccessOrderListView.Clear;
  MainWindow.noDealListView.Clear;
  if (AType = ACTUALSINDEX) then
  begin
    MainWindow.ButtomPanel.Enabled := False;
    MainWindow.middlerightPanel.Enabled := False;
    MainWindow.middlemiddlePanel.Enabled := False;
    exit;
  end
  else
  begin
    MainWindow.ButtomPanel.Enabled := True;
    MainWindow.middlerightPanel.Enabled := True;
    MainWindow.middlemiddlePanel.Enabled := True;
  end;

  dataList := TPositionDataCenter.Instance.getList(AType);
  for I := 0 to dataList.Count - 1 do
  begin
    TDrawView.instance.DrawFuturesPositionItem(MainWindow.PoinsitionListView.Items.Add, PThostFtdcInvestorPositionField(dataList.Objects[I]));
  end;
  dataList := TOrderDataCenter.Instance.getList(AType);
  for I := 0 to dataList.Count - 1 do
  begin
    TDrawView.instance.DrawFuturesOrderItem(MainWindow.OrderListView.Items.Add, PThostFtdcOrderField(dataList.Objects[I]));
  end;
  dataList := TSuccessOrderDataCenter.Instance.getList(AType);
  for I := 0 to dataList.Count - 1 do
  begin
    TDrawView.instance.DrawFuturesSuccessOrderItem(MainWindow.SuccessOrderListView.Items.Add, PThostFtdcTradeField(dataList.Objects[I]));
  end;
  TDrawView.instance.DrawAccountCapital;
end;

function getCurrentType(): ContractType;
begin
  case MainWindow.PageControl1.ActivePageIndex of
    0:
      Result := FUTURES;
    1:
      Result := OPTION;
    2:
      Result := ACTUALS;
    3:
      Result := ACTUALSINDEX;
  end;
end;

function getOptionMarket(code: string): Integer;
var
  I: Integer;
  tmpdata: PDF_CodeInfo;
begin
///个股期权深A
//	JG_TDC_EXCHANGETYPE_OPTSZA	11
///个股期权沪A
//	JG_TDC_EXCHANGETYPE_OPTSHA	12
  if ((TQuotationDataCenter.Instance.OptionQuotationCodeList = nil) or (TQuotationDataCenter.Instance.OptionQuotationCodeList.Count <= 0)) then
  begin
    MessageBox(0, '期权代码表未接收', '提示', MB_OK);
    exit;
  end;
  for I := 0 to TQuotationDataCenter.Instance.OptionQuotationCodeList.Count - 1 do
  begin
    tmpdata := PDF_CodeInfo(TQuotationDataCenter.Instance.OptionQuotationCodeList.Objects[I]);
    if (tmpdata.szID = code) then
    begin
      //行情市场 上交6 深交7
      //交易接口 沪A 12 深A11
      case (tmpdata.nIdnum mod 100) of
        6:
          Result := 12;
        7:
          Result := 11;
      end;
      Break;
    end;
  end;

end;

procedure ShowButtomsView(show: Boolean);
begin
  if (show) then
  begin
    MainWindow.Button3.Visible := False;
    MainWindow.Button4.Visible := False;
    MainWindow.Button1.Caption := '买';
    MainWindow.Button2.Caption := '卖';
  end
  else
  begin
    MainWindow.Button3.Visible := True;
    MainWindow.Button4.Visible := True;
    MainWindow.Button1.Caption := '买开';
    MainWindow.Button2.Caption := '卖开';
  end;
end;

procedure InitTradeData();
begin
  if (TradeServerStatus.FuturesIsLogin) then
  begin
    FFuturesTradeProxy.CheckCapital();
    FFuturesTradeProxy.RequestCheckPosition();
    FFuturesTradeProxy.RequestCheckOrder();
    FFuturesTradeProxy.RequestSucessedOrder();

    MainWindow.GroupBox.Enabled := True;
    MainWindow.LoginStatus.Color := clGreen;
  end;
  if (TradeServerStatus.OptionIsLogin) then
  begin
    FOptionTradeProxy.QryOrder();
    Delay(1000);
    FOptionTradeProxy.QryTrader();
    Delay(1000);
    FOptionTradeProxy.QryHold();
    Delay(1000);
    FOptionTradeProxy.QryFund();
  end;
  if (TradeServerStatus.ActualsIsLogin) then
  begin
    FActualsTradeProxy.QryOrder();
    Delay(1000);
    FActualsTradeProxy.QryTrader();
    Delay(1000);
    FActualsTradeProxy.QryHold();
    Delay(1000);
    FActualsTradeProxy.QryFund();
  end;

end;

end.

