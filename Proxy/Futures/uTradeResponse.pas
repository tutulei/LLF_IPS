unit uTradeResponse;
(*������Ӧ������Ԫ*)
(*
0	�ֲֻص�	OnRspQryInvestorPosition
1	�ʽ�����ص�	OnRspQryTradingAccount
2	����¼��������Ӧ OnRspOrderInsert
3	��������������Ӧ	OnRspOrderAction
4	�����䶯�ص�	OnRtnOrder
5	�����ɽ��ص�	 OnRtnTrade
6	������ѯ�ص�	OnRspQryOrder
7	�ɽ���ѯ�ص�	OnRspQryTrade
//���ܺ�23һ�����ݲ�ʵ��
8 	����CTP�ܾ���Ӧ	OnErrRtnOrderInsert
9	����CTP�ܾ���Ӧ	 OnErrRtnOrderAction

��Ӧ�ɹ���ֱ�ӵ���Painter���½���
*)

interface

uses
  uTradeAPI, uDataStruct, Windows, Classes;


//type
//  PThostFtdcInvestorPositionField = ^CThostFtdcInvestorPositionField;

procedure OnResponseFunction(ASgin: Integer; AData: Pointer; AIsLast: Boolean); stdcall;

procedure OnRspQryInvestorPosition(Adata: PThostFtdcInvestorPositionField);

procedure OnRspQryTradingAccount(Adata: PThostFtdcTradingAccountField);

procedure OnRspOrderInsert(Adata: PThostFtdcInputOrderField);

procedure OnRspOrderAction(Adata: PThostFtdcRspInfoField);

procedure OnRtnOrder(Adata: PThostFtdcOrderField);

procedure OnRtnTrade(Adata: PThostFtdcTradeField);

procedure OnRspQryOrder(Adata: PThostFtdcOrderField);

procedure OnRspQryTrade(Adata: PThostFtdcTradeField);

//type
//  TRequestMessenger = class(TThread)
//  private
//    class var
//      ins: TRequestMessenger;
//  public
//    class function instance(): TRequestMessenger;
//    constructor Create(CreateSuspended: Boolean = False);
//    procedure Request(AMethod: TThreadMethod);
//    procedure Position();
//    procedure Capital();
//    procedure Order();
//    procedure SuccessOrder();
//  end;


//�����Ժ���
function OrderTurnToTextString(Adata: PThostFtdcOrderField): TStrings;

implementation

uses
  uDataCenter, uDrawView, uGlobalInstance, SysUtils, uConstants, DateUtils,
  MainWIN,Graphics;


(*
0	�ֲֻص�	OnRspQryInvestorPosition
1	�ʽ�����ص�	OnRspQryTradingAccount
2	����¼��������Ӧ OnRspOrderInsert
3	��������������Ӧ	OnRspOrderAction
4	�����䶯�ص�	OnRtnOrder
5	�����ɽ��ص�	 OnRtnTrade
6	������ѯ�ص�	OnRspQryOrder
7	�ɽ���ѯ�ص�	OnRspQryTrade
//���ܺ�23һ�����ݲ�ʵ��
8 	����CTP�ܾ���Ӧ	OnErrRtnOrderInsert
9	����CTP�ܾ���Ӧ	 OnErrRtnOrderAction
*)
procedure OnResponseFunction(ASgin: Integer; AData: Pointer; AIsLast: Boolean);
begin
  case ASgin of
    0:
      OnRspQryInvestorPosition(AData);
    1:
      OnRspQryTradingAccount(AData);
    2:
      OnRspOrderInsert(AData);
    3:
      OnRspOrderAction(AData);
    4:
      OnRtnOrder(AData);
    5:
      OnRtnTrade(AData);
    6:
      OnRspQryOrder(AData);
    7:
      OnRspQryTrade(AData);
  end;
  if ((AIsLast) and ((ASgin < 2) or (ASgin > 5))) then
  begin
    Delay(1000);
    FFuturesTradeProxy.free := True;
  end;
end;

//�ֲֻص�
procedure OnRspQryInvestorPosition(Adata: PThostFtdcInvestorPositionField);
var
  newData: PThostFtdcInvestorPositionField;
begin
  New(newData);
  Move(Adata^, newData^, Sizeof(CThostFtdcInvestorPositionField));
  //���ݸ���
//  TDrawView.instance.log('Position:' + newData.InstrumentID + '-' + newData.PosiDirection, DebugColor, 'DEUBG');
  TPositionDataCenter.Instance.addItem(newData.InstrumentID + '-' + newData.PosiDirection, newData);
  //�������
  TDrawView.instance.RunSynchronize(TDrawView.instance.DrawPositionListView);
//    MessageBox(0, PChar('[OnfillingPositionData] run'+string(GetCurrentProcess)), 'Waring', IDOK);
end;

//�ʽ�����ص�
procedure OnRspQryTradingAccount(Adata: PThostFtdcTradingAccountField);
var
  newData: PThostFtdcTradingAccountField;
begin
  New(newData);
  Move(Adata^, newData^, Sizeof(CThostFtdcTradingAccountField));
  //���ݸ���
  Move(newData^, TradingAccountField, Sizeof(CThostFtdcTradingAccountField));
//  TradingAccountField := newData;
  //�������
  TDrawView.instance.RunSynchronize(TDrawView.instance.DrawAccountCapital);
end;

//����¼��������Ӧ
procedure OnRspOrderInsert(Adata: PThostFtdcInputOrderField);
var
  newData: PThostFtdcInputOrderField;
begin
//  New(newData);
//  Move(Adata^, newData^, Sizeof(CThostFtdcInputOrderField));
//  TOrderLogDataCenter.instance.addError('[ERROR]'+ TimeToStr(Now) + ':' + Adata.InstrumentID + '//'+Adata.);
//  TDrawView.instance.RunSynchronize(TDrawView.instance.DrawErroLogView);
end;

//��������������Ӧ
procedure OnRspOrderAction(Adata: PThostFtdcRspInfoField);
var
  newData: PThostFtdcInputOrderActionField;
begin
//  New(newData);
//  Move(Adata^, newData^, Sizeof(CThostFtdcInputOrderActionField));
  TDrawView.instance.log('OnRspOrderAction:' + Adata.ErrorMsg, clRed, 'ERROE');
end;

//�����䶯�ص�
procedure OnRtnOrder(Adata: PThostFtdcOrderField);
var
  newData: PThostFtdcOrderField;
  index: Integer;
begin
  New(newData);
  Move(Adata^, newData^, Sizeof(CThostFtdcOrderField));

//  //��־���ݸ���
//  TCommandWindowsDataCenter.instance.addStrings(OrderTurnToTextString(newData));
  TOrderLogDataCenter.instance.addLog(newData);
//  //��־�������
  TDrawView.instance.RunSynchronize(TDrawView.instance.DrawLogView);
//  TDrawView.instance.RunSynchronize(TDrawView.instance.PushOrderToCommandWindows);
  {����������Ӧ}
  if (Adata.OrderStatus <> THOST_FTDC_OST_Unknown) then
  begin
    //�ύ��ˢ��
    TOrderDataCenter.instance.addItem(newData.OrderSysID + '-' + newData.ExchangeID + '&' + newData.InsertTime, newData);
    TDrawView.instance.RunSynchronize(TDrawView.instance.DrawOrderView);
    //�ֲ�ˢ�£�ƽ�֣�
    if (newData.CombOffsetFlag[0] <> '0') then
    begin
      //�ź���
    end;
  end;
//  TRequestMessenger.instance.Request(TRequestMessenger.instance.Order);
  {����}
  //���ύˢ�£����������汨�����
  //ƽ�ֵ�����ˢ�£�����Ҳ�����棩

end;

//�����ɽ��ص�
procedure OnRtnTrade(Adata: PThostFtdcTradeField);
var
  newData: PThostFtdcTradeField;
begin
  New(newData);
  Move(Adata^, newData^, Sizeof(CThostFtdcTradeField));
  {���Ż�}
  //�ֲָ��£�����ʱ��
  if (newData.OffsetFlag = '0') then
  begin
    //�ź���
  end;
  //���ݸ���
  TSuccessOrderDataCenter.instance.addItem(newData.TradeID, newData);
  //�������
  TDrawView.instance.RunSynchronize(TDrawView.instance.DrawSuccessOrderView);
end;

//������ѯ�ص�
procedure OnRspQryOrder(Adata: PThostFtdcOrderField);
var
  newData: PThostFtdcOrderField;
begin
  New(newData);
  Move(Adata^, newData^, Sizeof(CThostFtdcOrderField));
  //���ݸ���
  TOrderDataCenter.instance.addItem(newData.OrderSysID + '-' + newData.ExchangeID + '&' + newData.InsertTime, newData);
  //�������
  TDrawView.instance.RunSynchronize(TDrawView.instance.DrawOrderView);
end;

//�ɽ���ѯ�ص�
procedure OnRspQryTrade(Adata: PThostFtdcTradeField);
var
  newData: PThostFtdcTradeField;
begin
  New(newData);
  Move(Adata^, newData^, Sizeof(CThostFtdcTradeField));
  //���ݸ���
  TSuccessOrderDataCenter.instance.addItem(newData.TradeID, newData);
  //�������
  TDrawView.instance.RunSynchronize(TDrawView.instance.DrawSuccessOrderView);
end;

function OrderTurnToTextString(Adata: PThostFtdcOrderField): TStrings;
var
  list: TStrings;
begin
  list := TStringList.Create();
  list.Add('[�����ص���Ӧ' + FloatToStr(Adata.SequenceNo) + ']: ');
  list.Add('    �û���');
  list.Add('    ���룺' + Adata.InstrumentID);
  list.Add('    ��գ�' + getOrderDirectionString(Adata.Direction));
  list.Add('    ��ƽ��' + getOrderOffsetFlag(Adata.CombOffsetFlag[0]));
  list.Add('    �۸�' + FloatToStr(Adata.LimitPrice));
  list.Add('    ����' + FloatToStr(Adata.VolumeTotalOriginal));
  list.Add('    ״̬��' + getOrderStatusMsg(Adata.OrderSubmitStatus, Adata.StatusMsg));
  list.Add('    ����ʱ�䣺' + Adata.InsertDate + ' ' + Adata.InsertTime);
  list.Add('    �����۸�������' + Adata.OrderPriceType);
  list.Add('    ��Ч������' + Adata.TimeCondition);
  list.Add('    ��С�ɽ���' + FloatToStr(Adata.MinVolume));
  list.Add('    ����ɽ�������' + FloatToStr(Adata.VolumeTraded));
  list.Add('    �����գ�' + Adata.TradingDay);
  list.Add('    ������ţ�' + Adata.OrderSysID);
  Result := list;
end;

{ TRequestMessenger }
//
//class function TRequestMessenger.instance: TRequestMessenger;
//begin
//  if (ins = nil) then
//  begin
//    ins := TRequestMessenger.Create(True);
//  end;
//  Result := ins;
//end;
//
//constructor TRequestMessenger.Create(CreateSuspended: Boolean = False);
//begin
//  inherited Create(CreateSuspended);
//end;
//
//procedure TRequestMessenger.Request(AMethod: TThreadMethod);
//begin
//  TDrawView.instance.log('Queue:' + ':before', nil);
//  Queue(nil, AMethod);
////  Synchronize(AMethod);
//  TDrawView.instance.log('Queue:' + ':after', nil);
//end;
//
//procedure TRequestMessenger.Capital;
//begin
//  FTradeProxy.CheckCapital();
//end;
//
//procedure TRequestMessenger.Order;
//begin
//  TDrawView.instance.log('QueueOrder:' + ':before', nil);
//  FTradeProxy.RequestCheckOrder();
//  TDrawView.instance.log('QueueOrder:' + ':after', nil);
//end;
//
//procedure TRequestMessenger.Position;
//begin
//  FTradeProxy.RequestCheckPosition();
//end;
//
//procedure TRequestMessenger.SuccessOrder;
//begin
//  FTradeProxy.RequestSucessedOrder();
//end;

end.

