unit uTradeResponse;
(*������Ӧ������Ԫ*)
(*
�ڻ�
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

{��Ӧ���Ⱥ��������}
procedure OnResponseFunction(ASgin: Integer; AData: Pointer; AIsLast: Boolean); stdcall;

 //��Ȩ
procedure OptionOnResponseFunction(ASgin: Integer; AData: Pointer; ACount: Integer); stdcall;

 //�ֻ�
procedure ActualsOnResponseFunction(ASgin: Integer; AData: Pointer; ACount: Integer); stdcall;


//type
//  PThostFtdcInvestorPositionField = ^CThostFtdcInvestorPositionField;
{�ڻ�������Ӧ}

procedure OnRspQryInvestorPosition(Adata: PThostFtdcInvestorPositionField);

procedure OnRspQryTradingAccount(Adata: PThostFtdcTradingAccountField);

procedure OnRspOrderInsert(Adata: PThostFtdcInputOrderField);

procedure OnRspOrderAction(Adata: PThostFtdcRspInfoField);

procedure OnRtnOrder(Adata: PThostFtdcOrderField);

procedure OnRtnTrade(Adata: PThostFtdcTradeField);

procedure OnRspQryOrder(Adata: PThostFtdcOrderField);

procedure OnRspQryTrade(Adata: PThostFtdcTradeField);

{��Ȩ����}
//procedure OptionOnFrontConnected();
//
//procedure OptionOnFrontDisConnected();
//
//procedure OptionOnRspError(const strError: PChar);
//
//procedure OptionOnRspOptionUserLogin(pRspUserLogin: PCJGtdcRspUserLogin; pRspInfo: PCJGtdcRspInfoField; nRequestID: Integer);
//
//procedure OptionOnRspOptionUserLogout(pRspUserLogout: PCJGtdcRspUserLogout; pRspInfo: PCJGtdcRspInfoField; nRequestID: Integer);
//
//procedure OptionOnRspOptionEntrust(pRspEntrust: PCJGtdcOptionRspEntrust; pRspInfo: PCJGtdcRspInfoField; nRequestID: Integer);
//
//procedure OptionOnRspOptionCancel(pRspCancel: PCJGtdcOptionRspCancel; pRspInfo: PCJGtdcRspInfoField; nRequestID: Integer);
//
//procedure OptionOnRtnOptionOrder(pRspQryEntrust: PCJGtdcOptionRspQryEntrust; nItems: Integer);
//
//procedure OptionOnRtnOptionTrade(pRspQryBusByPos: PCJGtdcOptionRspQryBusByPos; nItems: Integer);
//
//procedure OptionOnRspOptionQryEntrust(pRspQryEntrust: PCJGtdcOptionRspQryEntrust; pRspInfo: PCJGtdcRspInfoField; nRequestID: Integer);
//
//procedure OptionOnRspOptionQryBusByPos(pRspQryBusByPos: PCJGtdcOptionRspQryBusByPos; pRspInfo: PCJGtdcRspInfoField; nRequestID: Integer);
//
//procedure OptionOnRspOptionQryHold(pRspQryQryHold: PCJGtdcOptionRspQryHold; pRspInfo: PCJGtdcRspInfoField; nRequestID: Integer);
//
//procedure OptionOnRspOptionQryFund(pRspQryFund: PCJGtdcOptionRspQryFund; pRspInfo: PCJGtdcRspInfoField; nRequestID: Integer);
//
//procedure OptionOnRspOptionQryRevocEnt(pRspQryRevocEnt: PCJGtdcOptionRspQryRevocEnt; pRspInfo: PCJGtdcRspInfoField; nRequestID: Integer);
procedure OnRspOptionEntrust(pRspEntrust: PCJGtdcOptionRspEntrust; ACount: Integer);

procedure OnRspOptionCancel(pRspCancel: PCJGtdcOptionRspCancel; ACount: Integer);

procedure OnRtnOptionOrder(pRspQryEntrust: PCJGtdcOptionRspQryEntrust; ACount: Integer);

procedure OnRtnOptionTrade(pRspQryBusByPos: PCJGtdcOptionRspQryBusByPos; ACount: Integer);

procedure OnRspOptionQryEntrust(pRspQryEntrust: PCJGtdcOptionRspQryEntrust; ACount: Integer);

procedure OnRspOptionQryBusByPos(pRspQryBusByPos: PCJGtdcOptionRspQryBusByPos; ACount: Integer);

procedure OnRspOptionQryHold(pRspQryQryHold: PCJGtdcOptionRspQryHold; ACount: Integer);

procedure OnRspOptionQryFund(pRspQryFund: PCJGtdcOptionRspQryFund; ACount: Integer);

procedure OnRspOptionQryRevocEnt(pRspQryRevocEnt: PCJGtdcOptionRspQryRevocEnt; ACount: Integer);
{�ֻ�����}
//procedure ActualsOnFrontConnected();
//
//procedure ActualsOnFrontDisConnected();
//
//procedure ActualsOnRspError(const pErrMsg: PChar);
//
//procedure ActualsOnRspUserLogin(pRspUserLogin: PCJGtdcRspUserLogin; pRspInfo: PCJGtdcRspInfoField; nRequestID: Integer);
//
//procedure ActualsOnRspUserLogout(pRspUserLogout: PCJGtdcRspUserLogout; pRspInfo: PCJGtdcRspInfoField; nRequestID: Integer);
//
//procedure ActualsOnRspOrderInsert(pRspOrderInsert: PCJGtdcRspOrderInsert; pRspInfo: PCJGtdcRspInfoField; nRequestID: Integer);
//
//procedure ActualsOnRspOrderCancel(pRspOrderCancel: PCJGtdcRspOrderCancel; pRspInfo: PCJGtdcRspInfoField; nRequestID: Integer);
//
//procedure ActualsOnRtnOrder(pOrder: PCJGtdcRspQryOrder; nItems: Integer);
//
//procedure ActualsOnRtnTrade(pTrade: PCJGtdcRspQryTrade; nItems: Integer);
//
//procedure ActualsOnRspQryOrder(pRspQryOrder: PCJGtdcRspQryOrder; pRspInfo: PCJGtdcRspInfoField; nRequestID: Integer);
//
//procedure ActualsOnRspQryTrade(pRspQryTrade: PCJGtdcRspQryTrade; pRspInfo: PCJGtdcRspInfoField; nRequestID: Integer);
//
//procedure ActualsOnRspQryHold(pRspQryHold: PCJGtdcRspQryHold; pRspInfo: PCJGtdcRspInfoField; nRequestID: Integer);
//
//procedure ActualsOnRspQryFund(pRspQryFund: PCJGtdcRspQryFund; pRspInfo: PCJGtdcRspInfoField; nRequestID: Integer);
//
//procedure ActualsOnRspQryCancel(pRspQryCancel: PCJGtdcRspQryCancel; pRspInfo: PCJGtdcRspInfoField; nRequestID: Integer);

procedure OnRspActualsOrderInsert(pRspOrderInsert: PCJGtdcRspOrderInsert; ACount: Integer);

procedure OnRspActualsOrderCancel(pRspOrderCancel: PCJGtdcRspOrderCancel; ACount: Integer);

procedure OnRtnActualsOrder(pOrder: PCJGtdcRspQryOrder; ACount: Integer);

procedure OnRtnActualsTrade(pTrade: PCJGtdcRspQryTrade; ACount: Integer);

procedure OnRspActualsQryOrder(pRspQryOrder: PCJGtdcRspQryOrder; ACount: Integer);

procedure OnRspActualsQryTrade(pRspQryTrade: PCJGtdcRspQryTrade; ACount: Integer);

procedure OnRspActualsQryHold(pRspQryHold: PCJGtdcRspQryHold; ACount: Integer);

procedure OnRspActualsQryFund(pRspQryFund: PCJGtdcRspQryFund; ACount: Integer);

procedure OnRspActualsQryCancel(pRspQryCancel: PCJGtdcRspQryCancel; ACount: Integer);

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

function GetStrOffsetType(OffsetType: Char): string;

function GetStrTradeType(TradeType: Integer): string;

implementation

uses
  uDataCenter, uDrawView, uGlobalInstance, SysUtils, uConstants, DateUtils,
  MainWIN, Graphics;


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
    Sleep(1000);
    FFuturesTradeProxy.free := True;
  end;
end;


 (*
 0	Ͷ������Ȩί���µ�Ӧ��	OnRspOptionEntrust
 1	Ͷ������Ȩί�г���Ӧ��	OnRspOptionCancel
 2	Ͷ����ί��֪ͨ OnRtnOptionOrder
 3	Ͷ���߳ɽ�֪ͨ	OnRtnOptionTrade
 4	Ͷ������Ȩί�в�ѯӦ��	OnRspOptionQryEntrust
 5	Ͷ������Ȩ�����ɽ���ѯӦ��	 OnRspOptionQryBusByPos
 6	Ͷ������Ȩ�ֲֲ�ѯӦ��	OnRspOptionQryHold
 7	Ͷ������Ȩ�ʽ��ѯӦ��	OnRspOptionQryFund
 8 	Ͷ������Ȩ�ɳ�����ѯӦ��	OnRspOptionQryRevocEnt
 *)
procedure OptionOnResponseFunction(ASgin: Integer; AData: Pointer; ACount: Integer);
begin
  case ASgin of
    0:
      OnRspOptionEntrust(AData, ACount);
    1:
      OnRspOptionCancel(AData, ACount);
    2:
      OnRtnOptionOrder(AData, ACount);
    3:
      OnRtnOptionTrade(AData, ACount);
    4:
      OnRspOptionQryEntrust(AData, ACount);
    5:
      OnRspOptionQryBusByPos(AData, ACount);
    6:
      OnRspOptionQryHold(AData, ACount);
    7:
      OnRspOptionQryFund(AData, ACount);
    8:
      OnRspOptionQryRevocEnt(AData, ACount);
  end;
end;

procedure ActualsOnResponseFunction(ASgin: Integer; AData: Pointer; ACount: Integer);
begin
  case ASgin of
    0:
      OnRspActualsOrderInsert(AData, ACount);
    1:
      OnRspActualsOrderCancel(AData, ACount);
    2:
      OnRtnActualsOrder(AData, ACount);
    3:
      OnRtnActualsTrade(AData, ACount);
    4:
      OnRspActualsQryOrder(AData, ACount);
    5:
      OnRspActualsQryTrade(AData, ACount);
    6:
      OnRspActualsQryHold(AData, ACount);
    7:
      OnRspActualsQryFund(AData, ACount);
    8:
      OnRspActualsQryCancel(AData, ACount);
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
  TPositionDataCenter.Instance.addItem(newData.InstrumentID + '-' + newData.PosiDirection, newData, FUTURES);
  //�������
  if (MainWindow.PageControl1.ActivePageIndex = 0) then
  begin
    TDrawView.instance.RunSynchronize(TDrawView.instance.DrawPositionListView);
  end;
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
  TradingAccountField[0] := newData;
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
  TOrderLogDataCenter.instance.addLog(newData, FUTURES);
//  //��־�������
  if (MainWindow.PageControl1.ActivePageIndex = 0) then
  begin
    TDrawView.instance.RunSynchronize(TDrawView.instance.DrawLogView);
  end;
//  TDrawView.instance.RunSynchronize(TDrawView.instance.PushOrderToCommandWindows);
  {����������Ӧ}
  if (Adata.OrderStatus <> THOST_FTDC_OST_Unknown) then
  begin
    //�ύ��ˢ��
    TOrderDataCenter.instance.addItem(newData.OrderSysID + '-' + newData.ExchangeID + '&' + newData.InsertTime, newData, FUTURES);
    TDrawView.instance.RunSynchronize(TDrawView.instance.DrawOrderView);
    //�ֲ�ˢ�£�ƽ�֣�
    if (newData.CombOffsetFlag[0] <> '0') then
    begin
      //�ź���
    end;
  end;
//  TRequestMessenger.instance.Request(TRequestMessenger��ʵ��ʵ.instance.Order);
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
  TSuccessOrderDataCenter.instance.addItem(newData.TradeID, newData, FUTURES);
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
  TOrderDataCenter.instance.addItem(newData.OrderSysID + '-' + newData.ExchangeID + '&' + newData.InsertTime, newData, FUTURES);
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
  TSuccessOrderDataCenter.instance.addItem(newData.TradeID, newData, FUTURES);
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

{��Ȩ������Ӧ}

procedure OnRspOptionEntrust(pRspEntrust: PCJGtdcOptionRspEntrust; ACount: Integer);
var
  str: string;
  sOffsetType: string;
begin
  if (pRspEntrust.ResultType = 0) then
  begin
    sOffsetType := GetStrOffsetType(pRspEntrust.OffsetType);
    str := '[Option]' + pRspEntrust.EntrustNo + ';�µ��ɹ�����Լ:' + pRspEntrust.ContractNumber + ';';
    //+ sOffsetType + ';����:' + IntToStr(Integer(pRspEntrust.EntrustAmount)) + ';�۸�:' + FloatToStr(pRspEntrust.EntrustPrice / 10000)
  end
  else
  begin
    str := '[Option]' + pRspEntrust.EntrustNo + ';�µ�����,' + '��Լ:' + pRspEntrust.ContractNumber + ';' + pRspEntrust.ErrorInfo;
  end;
  TDrawView.instance.log(str, InfoColor, 'INFO');
end;

procedure OnRspOptionCancel(pRspCancel: PCJGtdcOptionRspCancel; ACount: Integer);
var
  str: string;
begin
  if (pRspCancel.ResultType = 0) then
  begin
    str := '[Option]' + pRspCancel.EntrustNo + '�����ɹ�;' + pRspCancel.NewEntrustNo;
  end
  else
  begin
    str := '[Option]' + pRspCancel.EntrustNo + '��������:' + pRspCancel.ErrorInfo;
  end;
  TDrawView.instance.log(str, InfoColor, 'INFO');
end;

//ί��֪ͨ
procedure OnRtnOptionOrder(pRspQryEntrust: PCJGtdcOptionRspQryEntrust; ACount: Integer);
var
  sTradeType: string;
  sOffsetType: string;
  sEntrustStatus: string;
  str: string;
  ptmp: PCJGtdcOptionRspQryEntrust;
  I: Integer;
begin
  for I := 0 to ACount - 1 do
  begin
    ptmp := pRspQryEntrust;
    Inc(ptmp, I);
    sTradeType := GetStrTradeType(ptmp.TradeType);
    sOffsetType := GetStrOffsetType(ptmp.OffsetType);
    case ptmp.EntrustStatus of
      '0':
        sEntrustStatus := 'δ��';
      '1':
        sEntrustStatus := '����';
      '2':
        sEntrustStatus := '�ѱ�';
      '3':
        sEntrustStatus := '�ѱ�����';
      '4':
        sEntrustStatus := '���ɴ���';
      '5':
        sEntrustStatus := '����';
      '6':
        sEntrustStatus := '�ѳ�';
      '7':
        sEntrustStatus := '����';
      '8':
        sEntrustStatus := '�ѳ�';
      '9':
        sEntrustStatus := '�ϵ�';
      'a':
        sEntrustStatus := '����';
      'b':
        sEntrustStatus := '���ھܾ�';
    end;
    str := '[Option]' + 'ί�гɹ�' + ptmp.EntrustNo + '��Լ:' + ptmp.ContractNumber + '/' + ptmp.ContractCode + '(' + ptmp.ContractName + ')' + ptmp.EntrustStatus + ';' + sTradeType + ';' + sOffsetType + ';����:' + IntToStr(ptmp.EntrustAmount) + ';�۸�:' + FloatToStr(ptmp.EntrustPrice / 10000) + ';ʱ��:' + IntToStr(ptmp.EntrustTime);
    TDrawView.instance.log(str, InfoColor, 'INFO');
  end;
  //���³ֲ�,ί�е�,�ɽ���,�ʽ�
end;

procedure OnRtnOptionTrade(pRspQryBusByPos: PCJGtdcOptionRspQryBusByPos; ACount: Integer);
var
  str: string;
  sBusinessStatus: string;
  sOffsetType: string;
  sTradeType: string;
  I: Integer;
  ptmp: PCJGtdcOptionRspQryBusByPos;
begin
  for I := 0 to ACount - 1 do
  begin
    ptmp := pRspQryBusByPos;
    Inc(ptmp, I);
    sTradeType := GetStrTradeType(ptmp.TradeType);
    sOffsetType := GetStrOffsetType(ptmp.OffsetType);
    case ptmp.BusinessStatus of
      '0':
        sBusinessStatus := '��ͨ�ɽ�';
      '1':
        sBusinessStatus := '�����ɹ�';
      '2':
        sBusinessStatus := '�ϵ��ɽ�';
    end;
    str := '[Option]' + '�ɽ�֪ͨ' + ptmp.EntrustNo + '��Լ:' + ptmp.ContractNumber + '/' + ptmp.ContractCode + '(' + ptmp.ContractName + ')' + sBusinessStatus + ';' + sTradeType + ';' + sOffsetType + ';����:' + IntToStr(ptmp.EntrustAmount) + ';�۸�:' + FloatToStr(ptmp.EntrustPrice / 10000) + ';ʱ��:' + IntToStr(ptmp.BusinessTime);
    TDrawView.instance.log(str, InfoColor, 'INFO');
  end;
  //���³ֲ�,ί�е����ɽ���,�ʽ�
end;

procedure OnRspOptionQryEntrust(pRspQryEntrust: PCJGtdcOptionRspQryEntrust; ACount: Integer);
var
  newData: PCJGtdcOptionRspQryEntrust;
begin
  TDrawView.instance.log('��Ȩί�в�ѯ��Ӧ' + InttoStr(ACount), clRed, '[DEBUG]');
//  New(newData);
//  Move(pRspQryEntrust^, newData^, SizeOf(TCJGtdcOptionRspQryEntrust));
//  TOrderDataCenter.instance.addItem(newData.EntrustNo, newData, OPTION);
//
//  //�������
//  if (MainWindow.PageControl1.ActivePageIndex = Integer(OPTION)) then
//  begin
//    TDrawView.instance.RunSynchronize(TDrawView.instance.DrawOrderView);
//  end;
end;

procedure OnRspOptionQryBusByPos(pRspQryBusByPos: PCJGtdcOptionRspQryBusByPos; ACount: Integer);
var
  newData: PCJGtdcOptionRspQryBusByPos;
begin
  TDrawView.instance.log('��Ȩ�����ɽ���ѯ��Ӧ' + InttoStr(ACount), clRed, '[DEBUG]');
//  New(newData);
//  Move(pRspQryBusByPos^, newData^, SizeOf(TCJGtdcOptionRspQryBusByPos));
//  TOrderDataCenter.instance.addItem(newData.BusinessNo, newData, OPTION);
//
//  //�������
//  if (MainWindow.PageControl1.ActivePageIndex = Integer(OPTION)) then
//  begin
//    TDrawView.instance.RunSynchronize(TDrawView.instance.DrawSuccessOrderView);
//  end;
end;

procedure OnRspOptionQryHold(pRspQryQryHold: PCJGtdcOptionRspQryHold; ACount: Integer);
var
  newData: PCJGtdcOptionRspQryHold;
begin
  TDrawView.instance.log('��Ȩ�ֲֲ�ѯ��Ӧ' + InttoStr(ACount), clRed, '[DEBUG]');
//  New(newData);
//  Move(pRspQryQryHold^, newData^, SizeOf(TCJGtdcOptionRspQryHold));
//  TPositionDataCenter.instance.addItem(newData.ContractCode + '-' + newData.OptionType, newData, OPTION);
//
//  //�������
//  if (MainWindow.PageControl1.ActivePageIndex = Integer(OPTION)) then
//  begin
//    TDrawView.instance.RunSynchronize(TDrawView.instance.DrawPositionListView);
//  end;
end;

procedure OnRspOptionQryFund(pRspQryFund: PCJGtdcOptionRspQryFund; ACount: Integer);
var
  newData: PCJGtdcOptionRspQryFund;
begin
  TDrawView.instance.log('��Ȩ�ʽ��ѯ��Ӧ' + InttoStr(ACount), clRed, '[DEBUG]');
//  New(newData);
//  Move(pRspQryFund^, newData^, SizeOf(TCJGtdcOptionRspQryHold));
//  TradingAccountField[1] := newData;
//  //�������
//  if (MainWindow.PageControl1.ActivePageIndex = Integer(OPTION)) then
//  begin
//    TDrawView.instance.RunSynchronize(TDrawView.instance.DrawAccountCapital);
//  end;
end;

procedure OnRspOptionQryRevocEnt(pRspQryRevocEnt: PCJGtdcOptionRspQryRevocEnt; ACount: Integer);
var
  newData: PCJGtdcOptionRspQryRevocEnt;
begin
  TDrawView.instance.log('��Ȩ�ɳ�����ѯ��Ӧ' + InttoStr(ACount), clRed, '[DEBUG]');
//  New(newData);
//  Move(pRspQryRevocEnt^, newData^, SizeOf(TCJGtdcOptionRspQryRevocEnt));
//  TOrderDataCenter.instance.addNoDealItem(newData.EntrustNo, newData, OPTION);
//
//  //�������
//  if (MainWindow.PageControl1.ActivePageIndex = Integer(OPTION)) then
//  begin
////    TDrawView.instance.RunSynchronize(TDrawView.instance.{��Ҫʵ�ֿɳ����������});
//  end;
end;  

{�ֻ�������Ӧ}
procedure OnRspActualsOrderInsert(pRspOrderInsert: PCJGtdcRspOrderInsert; ACount: Integer);
var
  str: string;
  sTradeType: string;
  I: Integer;
  ptmp: PCJGtdcRspOrderInsert;
begin
  for I := 0 to ACount - 1 do
  begin
    ptmp := pRspOrderInsert;
    Inc(ptmp, I);
    sTradeType := GetStrTradeType(ptmp.TradeType);
    str := '[Option]' + '�ɽ�֪ͨ' + ptmp.EntrustNo + '��Լ:' + ptmp.StockCode + ';' + sTradeType + ';' + ';����:' + IntToStr(ptmp.OrderVolume) + ';�۸�:' + FloatToStr(ptmp.OrderPrice / 10000);
    TDrawView.instance.log(str, InfoColor, 'INFO');
  end;
end;

procedure OnRspActualsOrderCancel(pRspOrderCancel: PCJGtdcRspOrderCancel; ACount: Integer);
begin

end;

procedure OnRtnActualsOrder(pOrder: PCJGtdcRspQryOrder; ACount: Integer);
var
  sTradeType: string;
  sEntrustStatus: string;
  str: string;
  ptmp: PCJGtdcRspQryOrder;
  I: Integer;
begin
  for I := 0 to ACount - 1 do
  begin
    ptmp := pOrder;
    Inc(ptmp, I);
    sTradeType := GetStrTradeType(ptmp.TradeType);
    case ptmp.EntrustStatus of
      '0':
        sEntrustStatus := 'δ��';
      '1':
        sEntrustStatus := '����';
      '2':
        sEntrustStatus := '�ѱ�';
      '3':
        sEntrustStatus := '�ѱ�����';
      '4':
        sEntrustStatus := '���ɴ���';
      '5':
        sEntrustStatus := '����';
      '6':
        sEntrustStatus := '�ѳ�';
      '7':
        sEntrustStatus := '����';
      '8':
        sEntrustStatus := '�ѳ�';
      '9':
        sEntrustStatus := '�ϵ�';
      'a':
        sEntrustStatus := '����';
      'b':
        sEntrustStatus := '���ھܾ�';
    end;
    str := '[Option]' + 'ί�гɹ�' + ptmp.EntrustNo + '��Լ:' + ptmp.StockCode + '(' + ptmp.StockName + ')' + ptmp.EntrustStatus + ';' + sTradeType + ';����:' + IntToStr(ptmp.BusinessVolume) + ';�۸�:' + FloatToStr(ptmp.BusinessPrice / 10000) + ';ʱ��:' + IntToStr(ptmp.EntrustTime);
    TDrawView.instance.log(str, InfoColor, 'INFO');
  end;
end;

procedure OnRtnActualsTrade(pTrade: PCJGtdcRspQryTrade; ACount: Integer);
var
  str: string;
  sBusinessStatus: string;
  sOffsetType: string;
  sTradeType: string;
  I: Integer;
  ptmp: PCJGtdcRspQryTrade;
begin
  for I := 0 to ACount - 1 do
  begin
    ptmp := pTrade;
    Inc(ptmp, I);
    sTradeType := GetStrTradeType(ptmp.TradeType);
    case ptmp.BusinessStatus of
      '0':
        sBusinessStatus := '��ͨ�ɽ�';
      '1':
        sBusinessStatus := '�����ɹ�';
      '2':
        sBusinessStatus := '�ϵ��ɽ�';
    end;
    str := '[Option]' + '�ɽ�֪ͨ' + ptmp.EntrustNo + '��Լ:' + ptmp.StockCode + '(' + ptmp.StockName + ')' + sBusinessStatus + ';' + sTradeType + ';����:' + IntToStr(ptmp.BusinessVolume) + ';�۸�:' + FloatToStr(ptmp.BusinessPrice / 10000) + ';ʱ��:' + IntToStr(ptmp.BusinessTime);
    TDrawView.instance.log(str, InfoColor, 'INFO');
  end;
end;

procedure OnRspActualsQryOrder(pRspQryOrder: PCJGtdcRspQryOrder; ACount: Integer);
begin
  TDrawView.instance.log('�ֻ�������ѯ��Ӧ' + InttoStr(ACount), clRed, '[DEBUG]');
end;

procedure OnRspActualsQryTrade(pRspQryTrade: PCJGtdcRspQryTrade; ACount: Integer);
begin
  TDrawView.instance.log('�ֻ��ɽ���ѯ��Ӧ' + InttoStr(ACount), clRed, '[DEBUG]');
end;

procedure OnRspActualsQryHold(pRspQryHold: PCJGtdcRspQryHold; ACount: Integer);
begin
  TDrawView.instance.log('�ֻ��ֲֲ�ѯ��Ӧ' + InttoStr(ACount), clRed, '[DEBUG]');
end;

procedure OnRspActualsQryFund(pRspQryFund: PCJGtdcRspQryFund; ACount: Integer);
begin
  TDrawView.instance.log('�ֻ��ʽ��ѯ��Ӧ' + InttoStr(ACount), clRed, '[DEBUG]');
end;

procedure OnRspActualsQryCancel(pRspQryCancel: PCJGtdcRspQryCancel; ACount: Integer);
begin

end;

function GetStrOffsetType(OffsetType: Char): string;
begin
  case OffsetType of
    '0':
      Result := '����';
    '1':
      Result := 'ƽ��';
    '2':
      Result := 'ƽ���';
  else
    Result := 'δ֪����';
  end;
end;

function GetStrTradeType(TradeType: Integer): string;
begin
  case TradeType of
    1:
      Result := '��';
    2:
      Result := '��';
  else
    Result := '��������' + IntToStr(TradeType);
  end;
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
