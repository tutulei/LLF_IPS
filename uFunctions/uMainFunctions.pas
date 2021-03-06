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
  //????????
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
///??????Ȩ??A
//	JG_TDC_EXCHANGETYPE_OPTSZA	11
///??????Ȩ??A
//	JG_TDC_EXCHANGETYPE_OPTSHA	12
  if ((TQuotationDataCenter.Instance.OptionQuotationCodeList = nil) or (TQuotationDataCenter.Instance.OptionQuotationCodeList.Count <= 0)) then
  begin
    MessageBox(0, '??Ȩ??????δ????', '??ʾ', MB_OK);
    exit;
  end;
  for I := 0 to TQuotationDataCenter.Instance.OptionQuotationCodeList.Count - 1 do
  begin
    tmpdata := PDF_CodeInfo(TQuotationDataCenter.Instance.OptionQuotationCodeList.Objects[I]);
    if (tmpdata.szID = code) then
    begin
      //?????г? ?Ͻ?6 ?7
      //???׽ӿ? ??A 12 ??A11
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
    MainWindow.Button1.Caption := '??';
    MainWindow.Button2.Caption := '??';
  end
  else
  begin
    MainWindow.Button3.Visible := True;
    MainWindow.Button4.Visible := True;
    MainWindow.Button1.Caption := '????';
    MainWindow.Button2.Caption := '????';
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

