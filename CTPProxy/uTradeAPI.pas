unit uTradeAPI;

interface

uses
  uDataStruct, Windows, uConstants, Classes, SysUtils, SyncObjs, uDrawView;

type

  //�������׷���
  TCreateTradeServer = function(psFrontAddress: PChar; mdflowpath: PChar): Pointer; cdecl;

  //��¼����
  TAutoAuthAndLoginTradeServer = function(server: Pointer; BrokerID: PChar; UserID: PChar; Password: PChar; AuthCode: PChar; AppID: PChar): Integer; cdecl;

  //����
  TInputLimitPriceOrder = function(server: Pointer; InstrumentID: PChar; Direction: Char; OffsetFlag: Char; LimitPrice: Double; count: Integer): Integer; cdecl;

  //��ѯ�ֲ�
  TQueryPosition = procedure(server: Pointer); cdecl;

  //����
  TCancelOrder = function(server: Pointer; FrontID: Integer; SessionID: Integer; OrderRef: PChar): Integer; cdecl;

  //��ѯ�˻��ʽ�
  TCheckAccountField = procedure(server: Pointer); cdecl;

  //��ѯ���ύ����
  TQueryOrder = function(server: Pointer): Pointer; cdecl;

  //��ѯ�Գɽ�
  TQueryTradeSuccess = function(server: Pointer): Pointer; cdecl;

  //�ص�������
  TBindFunctions = procedure(server: Pointer; fun1: Pointer; fun2: Pointer; fun3: Pointer); cdecl;

  //DLL��װ��
  TTradeProxy = class
  private
    handle: Integer;
    //ͨ�ŷ���
    server: Pointer;
    {����ָ������}
    createtradeserver: TCreateTradeServer;
    autoauthandlogintradeserver: TAutoAuthAndLoginTradeServer;
    inputlimitpriceorder: TInputLimitPriceOrder;
    queryposition: TQueryPosition;
    cancelorder: TCancelOrder;
    checkaccountfield: TCheckAccountField;
    queryorder: TQueryOrder;
    querytradesuccess: TQueryTradeSuccess;
    bindfunstions: TBindFunctions;
  public
    constructor Create(key: string);
    procedure Connected(psFrontAddress: PChar; mdflowpath: PChar);
    procedure AuthAndLogin(BrokerID: PChar; UserID: PChar; Password: PChar; AuthCode: PChar; AppID: PChar);
    procedure AddLimitPriceOrder(InstrumentID: PChar; Direction: Char; OffsetFlag: Char; LimitPrice: Double; count: Integer);
    procedure RequestCheckPosition();
    function DeleteOrder(FrontID: Integer; SessionID: Integer; OrderRef: PChar): Integer;
    procedure CheckCapital();
    function RequestCheckOrder(): Pointer;
    function GetSucessedOrder(): Pointer;
    procedure BindFun(fun1: Pointer; fun2: Pointer; fun3: Pointer);
  end;

procedure OnfillingPositionData(data: CThostFtdcInvestorPositionField); stdcall;

procedure OnOrderChange(data: CThostFtdcOrderField); stdcall;

function OrderTurnToTextString(data: CThostFtdcOrderField): TStrings;

procedure OnAccountCapital(data: CThostFtdcTradingAccountField); stdcall;

var
  criticalsection: TCriticalSection;

implementation

uses
  MainWIN, ComCtrls, uDataCenter;

constructor TTradeProxy.Create(key: string);
begin
  handle := LoadLibrary(PChar(key));
  createtradeserver := GetProcAddress(Self.handle, PChar(CREATE_TRADE_SERVER));
  autoauthandlogintradeserver := GetProcAddress(Self.handle, PChar(AUTO_AUTH_AND_LOGINTRADE_SERVER));
  inputlimitpriceorder := GetProcAddress(Self.handle, PChar(INPUT_LIMIT_PRICE_ORDER));
  queryposition := GetProcAddress(Self.handle, PChar(QUERY_POSITION));
  cancelorder := GetProcAddress(Self.handle, PChar(CANCEL_ORDER));
  checkaccountfield := GetProcAddress(Self.handle, PChar(CHECKA_CCOUNT_FIELD));
  queryorder := GetProcAddress(Self.handle, PChar(QUERY_ORDER));
  querytradesuccess := GetProcAddress(Self.handle, PChar(QUERY_TRADE_SUCCESS));
  bindfunstions := GetProcAddress(Self.handle, PChar(BIND_FUNCTIONS));
end;

procedure TTradeProxy.Connected(psFrontAddress: PChar; mdflowpath: PChar);
begin
  server := createtradeserver(psFrontAddress, mdflowpath);
  BindFun(@OnfillingPositionData, @OnOrderChange, @OnAccountCapital);
end;

procedure TTradeProxy.AuthAndLogin(BrokerID: PChar; UserID: PChar; Password: PChar; AuthCode: PChar; AppID: PChar);
begin
  autoauthandlogintradeserver(server, BrokerID, UserID, Password, AuthCode, AppID);
end;

procedure TTradeProxy.AddLimitPriceOrder(InstrumentID: PChar; Direction: Char; OffsetFlag: Char; LimitPrice: Double; count: Integer);
begin
  inputlimitpriceorder(server, InstrumentID, Direction, OffsetFlag, LimitPrice, count);
end;

procedure TTradeProxy.RequestCheckPosition();
begin
  queryposition(server);

end;

function TTradeProxy.DeleteOrder(FrontID: Integer; SessionID: Integer; OrderRef: PChar): Integer;
begin
  Result := cancelorder(server, FrontID, SessionID, OrderRef);
end;

procedure TTradeProxy.CheckCapital();
begin
  checkaccountfield(server);
end;

function TTradeProxy.RequestCheckOrder(): Pointer;
begin
  Result := queryorder(server);
end;

function TTradeProxy.GetSucessedOrder(): Pointer;
begin
  Result := querytradesuccess(server);
end;

procedure TTradeProxy.BindFun(fun1: Pointer; fun2: Pointer; fun3: Pointer);
begin
  bindfunstions(server, fun1, fun2, fun3);
end;

procedure OnUIfillingPositionData();
begin
  Writeln('OnUIfillingPositionData');
end;

//�ص�����-�ֲ����ݸ���
procedure OnfillingPositionData(data: CThostFtdcInvestorPositionField);
var
  hdle: Integer;
begin
  TPositionDataCenter.Instance.addItem(data.InstrumentID + '-' + data.PosiDirection, @data);
  //�������
  TDrawView.instance.RunSynchronize(TDrawView.instance.DrawPositionListView);
//    MessageBox(0, PChar('[OnfillingPositionData] run'+string(GetCurrentProcess)), 'Waring', IDOK);
end;

//�ص����� -�ʽ����
procedure OnAccountCapital(data: CThostFtdcTradingAccountField); stdcall;
var
  d: double;
begin
  TradingAccountField := data;
  d := TradingAccountField.Available;
  TDrawView.instance.RunSynchronize(TDrawView.instance.DrawAccountCapital);
end;


//�ص�����-�����仯��Ӧ
procedure OnOrderChange(data: CThostFtdcOrderField); stdcall;
var
  topdata: CThostFtdcTradingAccountField;
begin
//  MessageBox(0, PChar(str), 'Waring', IDOK);
  TCommandWindowsDataCenter.instance.addStrings(OrderTurnToTextString(data));
  TDrawView.instance.RunSynchronize(TDrawView.instance.PushOrderToCommandWindows);
  //�ɽ��¼�����
  if ((data.OrderStatus = '0') or (data.OrderStatus = '1') or (data.OrderStatus = '2')) then
  begin
    tradeProxy.RequestCheckPosition();
    Sleep(1000);
  end;

//  if ((StrToInt(data.OrderStatus) < 3) then
//  begin
//    //ͬ����ʼ���ʽ����
//    topdata := CThostFtdcTradingAccountField(tradeProxy.CheckCapital()^);
//    MainWindow.TopGrid.Cells[0, 1] := FloatToStr(topdata.Available);
//    MainWindow.TopGrid.Cells[1, 1] := FloatToStr(topdata.WithdrawQuota);
//    MainWindow.TopGrid.Cells[2, 1] := FloatToStr(topdata.Reserve);
//    MainWindow.TopGrid.Cells[3, 1] := FloatToStr(topdata.Mortgage);
//    MainWindow.TopGrid.Cells[4, 1] := FloatToStr(topdata.Credit);
//    MainWindow.TopGrid.Cells[5, 1] := FloatToStr(topdata.PositionProfit);
//    MainWindow.TopGrid.Cells[6, 1] := FloatToStr(topdata.CloseProfit);
//    MainWindow.TopGrid.Cells[7, 1] := FloatToStr(topdata.CurrMargin);
//    MainWindow.TopGrid.Cells[8, 1] := FloatToStr(topdata.Interest);
//    MainWindow.TopGrid.Cells[9, 1] := FloatToStr(topdata.CloseProfit);
//    Sleep(1000);
//    //�����ύ����ͳֲֽ���
//    tradeProxy.RequestCheckPosition();
//    Sleep(1000);
//  end;
//
//  //�����ύ״̬
//  case data.OrderSubmitStatus of
//    THOST_FTDC_OSS_InsertSubmitted:
//      begin
//      //�������ύ��Ľ���
//
//      end;
//    THOST_FTDC_OSS_CancelSubmitted:
//      begin
//
//      end;
//    THOST_FTDC_OSS_ModifySubmitted:
//      begin
//
//      end;
//    THOST_FTDC_OSS_Accepted:
//      begin
//
//      end;
//    THOST_FTDC_OSS_InsertRejected:
//      begin
//
//      end;
//    THOST_FTDC_OSS_CancelRejected:
//      begin
//
//      end;
//    THOST_FTDC_OSS_ModifyRejected:
//      begin
//
//      end;
//  end;

end;

function OrderTurnToTextString(data: CThostFtdcOrderField): TStrings;
var
  list: TStrings;
begin
  list := TStringList.Create();
  list.Add('[�����ص���Ӧ' + FloatToStr(data.SequenceNo) + ']: ');
  list.Add('    �û���');
  list.Add('    ���룺' + data.InstrumentID);
  list.Add('    ��գ�' + getOrderDirectionString(data.Direction));
  list.Add('    ��ƽ��' + getOrderOffsetFlag(data.CombOffsetFlag[0]));
  list.Add('    �۸�' + FloatToStr(data.LimitPrice));
  list.Add('    ����' + FloatToStr(data.VolumeTotalOriginal));
  list.Add('    ״̬��' + getOrderStatusMsg(data.OrderSubmitStatus, data.StatusMsg));
  list.Add('    ����ʱ�䣺' + data.InsertDate + ' ' + data.InsertTime);
  list.Add('    �����۸�������' + data.OrderPriceType);
  list.Add('    ��Ч������' + data.TimeCondition);
  list.Add('    ��С�ɽ���' + FloatToStr(data.MinVolume));
  list.Add('    ����ɽ�������' + FloatToStr(data.VolumeTraded));
  list.Add('    �����գ�' + data.TradingDay);
  list.Add('    ������ţ�' + data.OrderSysID);
  Result := list;
end;

end.

