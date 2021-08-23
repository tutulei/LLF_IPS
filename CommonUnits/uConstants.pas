unit uConstants;
(*
  常量单元
*)

interface

uses
  Grids, Classes, SysUtils, Forms, Windows, Graphics;

type
//  PTFastLineSeries = ^TFastLineSeries;

  TmyTStringGrid = class(TStringGrid)
  public
    procedure DeleteRow(ARow: Longint); override;
  end;

  ContractType = (FUTURES, OPTION, ACTUALS);

const
  {color}
  DebugColor = $001AFF00;
  InfoColor = clBlue;
  ErrorColor = clRed;

const


  {函数名常量}
  {期货行情&交易}
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
  {期权行情&交易}
  DF_CREATE = 'DF_Create';
  DF_ADDSERVER = 'DF_AddServer';
  DF_SETRECVDATAFUNC = 'DF_SetRecvDataFunc';
  DF_SETNOTICEFUNC = 'DF_SetNoticeFunc';
  DF_BEGIN = 'DF_Begin';
  DF_SETREQUESTMARKETS = 'DF_SetRequestMarkets';
  DF_SETHEARTBEAT = 'DF_SetHeartBeat';
  DF_SUBSCRIBEBYCODES = 'DF_SubscribeByCodes';
//  DF_CREATE = 'DF_Create';
//  DF_CREATE = 'DF_Create';
//  DF_CREATE = 'DF_Create';
//  DF_CREATE = 'DF_Create';

  {期货相关常量}
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

  {期权行情相关常量}
  MAX_MARKET_NUM = 32;
  g_szMarketFlag: array[0..7, 0..3] of Char = ('SZS', 'SHS', 'CFF', 'SCE', 'ZCE', 'DCE', 'SHO', 'SZO');
  MARKET_FLAGS_PRESENT = $00000001;
  DF_MARKET_TYPE_SZSTK = 0;				///< 深交所股票（带指数）.
  DF_MARKET_TYPE_SHSTK = 1;				///< 上交所股票（带指数）.
  DF_MARKET_TYPE_CFFEX = 2;				///< 金融期货.
  DF_MARKET_TYPE_SHOPT = 6;				///< 上交所期权.
  DF_MARKET_TYPE_SZOPT = 7; 			///< 深交所期权.
  
  ///回调通知消息类型类型.
  DF_NOTICE_RUNINFO = 0;			///< 普通运行信息.
  DF_NOTICE_CONNECT = 100;		///< 网络已连接.
  DF_NOTICE_DISCONNECT = 101;		///< 网络断开.
  DF_NOTICE_BEATOUTTIME = 102;		///< 心跳应答超时.
  DF_NOTICE_CODETABLE = 103;	    ///< 代码列表返回通知.
  
  ///数据类型列表.
  DF_HEARTBEAT = 2;			///> 心跳.
  DF_OPTIONDATA = 20;				///> 期权行情快照数据.
  DF_STOCKDATA = 21;				///> 现货行情快照数据.
  DF_INDEXDATA = 22;			///> 指数行情快照数据.
  DF_FUTUREDATA = 23;				///> 期货行情快照数据.
  DF_TRANSACTDATA = 24;				///> 现货逐笔成交数据.
  DF_LOGIN = 2000;			///> 登录.
  DF_LOGINANSWER = 2001;				///> 登录应答.
  DF_LOGOUT = 2002;			///> 登出.
  DF_LOGOUTANSWER = 2003;				///> 登出应答.
  DF_REQMARKETS = 2100;				///> 设置市场.
  DF_CODETABLE = 2101;				///> 代码表.
  DF_OPTIONBASIC = 2102;			///> 期权基本信息.
  DF_ETFCODETABLE = 2103;			///> ETF证券代码清单.
  DF_ETFCOMPONT = 2104;				///> ETF清单成分股.
  DF_ETFLIST_BATCH = 2105;				///> 批量请求ETF清单.
  DF_SUBSCRIBE = 2200;				///> 数据订阅.
  DF_MARKETCLOSE = 2300;				///> 收市.
  DF_QUOTATIONDATE_CHANGE = 2301;		///> 日期变更.
  DF_SVRCLOSE = 2302;				///> 服务关闭.

  DF_SUB_TYPE_SET = 0;						///< 订阅设置.
  DF_SUB_TYPE_ADD = 1;						///< 订阅增加.
  DF_SUB_TYPE_DEL = 2;						///< 订阅删除.
  DF_SUB_TYPE_ALLDEL = 3;					///< 取消所有订阅.



//0买 1 卖

function getOrderDirectionString(A: Char): string;

function getOrderStatusMsg(OrderSubmitStatus: Char; statusMsg: string): string;

function getOrderOffsetFlag(OffsetFlag: Char): string;

procedure Delay(dwMilliseconds: DWORD);

function TypeStr(typeName: ContractType): string;

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

function TypeStr(typeName: ContractType): string;
begin
  if typeName = FUTURES then
  begin
    Result := '期货';
  end
  else if typeName = OPTION then
  begin
    Result := '期权';
  end
  else if typeName = ACTUALS then
  begin
    Result := '现货';
  end;
end;

end.

