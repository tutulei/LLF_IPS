unit uConstants;
(*
  常量单元
*)

interface

uses
  Grids, Classes, SysUtils, Forms, Windows, Graphics;

const
  {color}
  DebugColor = $001AFF00;
  InfoColor = clBlue;
  ErrorColor = clRed;

const
  //函数名常量
  CREATE_QUOTATION_SERVER = 'CreateQuotationServer';
  SIMPLE_LOGIN_QUOTATION_SERVER = 'SimpleLoginQuotationServer';
  SUBSCRIBE_CONTRACTS = 'SubscribeContracts';
  REMOVE_CONTRACTS = 'RemoveContracts';
  GET_ONE_TICK = 'GetOneTick';
  DESTROY_QUOTATION_SERVER = 'DestroyQuotationServer';
  IS_CONNECTED = 'IsConnected';
  LOGIN_SUCESS = 'LoginSucess';
  CREATE_TRADE_SERVER = 'CreateTradeServer';
  AUTO_AUTH_AND_LOGINTRADE_SERVER = 'AutoAuthAndLoginTradeServer';
  INPUT_LIMIT_PRICE_ORDER = 'InputLimitPriceOrder';
  QUERY_POSITION = 'QueryPosition';
  CANCEL_ORDER = 'CancelOrder';
  CHECKA_CCOUNT_FIELD = 'CheckAccountField';
  QUERY_ORDER = 'QueryOrder';
  QUERY_TRADE_SUCCESS = 'QueryTradeSuccess';
  BIND_FUNCTIONS = 'BindFunctions';

  //净
  THOST_FTDC_PD_Net = '1';
  ///多头
  THOST_FTDC_PD_Long = '2';
  ///空头
  THOST_FTDC_PD_Short = '3';

  //已经提交
  THOST_FTDC_OSS_InsertSubmitted = '0';
  ///撤单已经提交
  THOST_FTDC_OSS_CancelSubmitted = '1';
  ///修改已经提交
  THOST_FTDC_OSS_ModifySubmitted = '2';
  ///已经接受
  THOST_FTDC_OSS_Accepted = '3';
  ///报单已经被拒绝
  THOST_FTDC_OSS_InsertRejected = '4';
  ///撤单已经被拒绝
  THOST_FTDC_OSS_CancelRejected = '5';
  ///改单已经被拒绝
  THOST_FTDC_OSS_ModifyRejected = '6';

  ///全部成交
  THOST_FTDC_OST_AllTraded = '0';
  ///部分成交还在队列中
  THOST_FTDC_OST_PartTradedQueueing = '1';
  ///部分成交不在队列中
  THOST_FTDC_OST_PartTradedNotQueueing = '2';
  ///未成交还在队列中
  THOST_FTDC_OST_NoTradeQueueing = '3';
  ///未成交不在队列中
  THOST_FTDC_OST_NoTradeNotQueueing = '4';
  ///撤单
  THOST_FTDC_OST_Canceled = '5';
  ///未知
  THOST_FTDC_OST_Unknown = 'a';
  ///尚未触发
  THOST_FTDC_OST_NotTouched = 'b';
  ///已触发
  THOST_FTDC_OST_Touched = 'c';

  ///开仓
  THOST_FTDC_OF_Open = '0';
  ///平仓
  THOST_FTDC_OF_Close = '1';
  ///强平
  THOST_FTDC_OF_ForceClose = '2';
  ///平今
  THOST_FTDC_OF_CloseToday = '3';
  ///平昨
  THOST_FTDC_OF_CloseYesterday = '4';
  ///强减
  THOST_FTDC_OF_ForceOff = '5';
  ///本地强平
  THOST_FTDC_OF_LocalForceClose = '6';

  ///买
  THOST_FTDC_D_Buy = '0';
  ///卖
  THOST_FTDC_D_Sell = '1';

//0买 1 卖
function getOrderDirectionString(A: Char): string;

function getOrderStatusMsg(OrderSubmitStatus: Char; statusMsg: string): string;

function getOrderOffsetFlag(OffsetFlag: Char): string;

procedure Delay(dwMilliseconds: DWORD);

type
//  PTFastLineSeries = ^TFastLineSeries;

  TmyTStringGrid = class(TStringGrid)
  public
    procedure DeleteRow(ARow: Longint); override;
  end;

  ContractType = (FUTURES, OPTION, ACTUALS);

var
  WorkPath: string;

implementation

procedure Delay(dwMilliseconds: DWORD);//Longint
var
  iStart, iStop: DWORD;
begin
  iStart := GetTickCount;
  repeat
    iStop := GetTickCount;
    Application.ProcessMessages;
  until (iStop - iStart) >= dwMilliseconds;
end;

procedure TmyTStringGrid.DeleteRow(ARow: Longint);
begin
  inherited;
end;

function getOrderDirectionString(A: Char): string;
begin
  if (A = THOST_FTDC_D_Buy) then
  begin
    Result := '买';
  end
  else if (A = THOST_FTDC_D_Sell) then
  begin
    Result := '卖';
  end;
  Result := '';
end;

function getOrderStatusMsg(OrderSubmitStatus: Char; statusMsg: string): string;
var
  str: string;
begin
  case OrderSubmitStatus of
    THOST_FTDC_OSS_InsertSubmitted:
      str := '已提交';
    THOST_FTDC_OSS_CancelSubmitted:
      str := '撤单已提交';
    THOST_FTDC_OSS_ModifySubmitted:
      str := '修改已提交';
    THOST_FTDC_OSS_Accepted:
      str := '已接受';
    THOST_FTDC_OSS_InsertRejected:
      str := '报单已被拒绝';
    THOST_FTDC_OSS_CancelRejected:
      str := '撤单已被拒绝';
    THOST_FTDC_OSS_ModifyRejected:
      str := '改单已被拒绝';
  end;
  Result := str + ':' + statusMsg;
end;

function getOrderOffsetFlag(OffsetFlag: Char): string;
var
  str: string;
begin
  case OffsetFlag of

    THOST_FTDC_OF_Open:
      str := '开仓';

    THOST_FTDC_OF_Close:
      str := '平仓';

    THOST_FTDC_OF_ForceClose:
      str := '强平';

    THOST_FTDC_OF_CloseToday:
      str := '今平';

    THOST_FTDC_OF_CloseYesterday:
      str := '平昨';

    THOST_FTDC_OF_ForceOff:
      str := '强减';

    THOST_FTDC_OF_LocalForceClose:
      str := '本地强平';
  end;
  Result := str;
end;

end.

