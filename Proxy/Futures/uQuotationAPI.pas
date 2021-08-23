unit uQuotationAPI;
(*
  行情API
  对接DLL文件
*)

interface

uses
  uDataStruct, Windows, uConstants, Classes, SysUtils, uDataCenter, IdGlobal,
  Forms;

type
  PPChar = ^PChar;

{创建函数指针}

{期货}
  //创建行情服务
  TCreateQuotationServer = function(psFrontAddress: PChar; mdflowpath: PChar; udp: Boolean = false; bIsMulticast: Boolean = false): Pointer; cdecl;

  //登录
  TSimpleLoginQuotationServer = function(server: Pointer; BrokerID: PChar; userId: PChar; pwd: Pchar): Integer; cdecl;

  //添加订阅
//  TSubscribeContracts = function(server: Pointer; arr: array of PChar; size: Integer): Integer; cdecl;
  TSubscribeContracts = function(server: Pointer; arr: Pointer; size: Integer): Integer; cdecl;

  //移除订阅
  TRemoveContracts = function(server: Pointer; arr: array of PChar; size: Integer): Integer; cdecl;

  //获取数据
  TGetOneTick = function(server: Pointer): TQuotationData; cdecl;

  //销毁获取服务
  TDestroyQuotationServer = procedure(server: Pointer); cdecl;

  //判断是否连接成功
  TIsConnected = function(server: Pointer): Boolean; cdecl;

  //判断是否登录成功
  TLoginSuccess = function(server: Pointer): Boolean; cdecl;

{期权}
  TDF_Create = function(): DF_HANDLE; cdecl;

  TDF_AddServer = function(hDF: DF_HANDLE; const szServer: PChar; nPort: Integer; nLevel: Integer; iProxyType: Integer; const szProxyHost: PChar; iProxyPort: Integer; const szProxyUser: PChar; const szProxyPass: PChar; const szUserName: PChar; szPassword: PChar): Integer; cdecl;

  TDF_SetRecvDataFunc = function(hDF: DF_HANDLE; pRecvData: Pointer): Pointer; cdecl;

  TDF_SetNoticeFunc = function(hDF: DF_HANDLE; pNotice: Pointer): Pointer; cdecl;

  TDF_Begin = function(hDF: DF_HANDLE): Integer; cdecl;

  TDF_SetRequestMarkets = function(hDF: DF_HANDLE; pReqMarkets: PDF_ReqMarkets; nItems: Integer): Integer; cdecl;

  TDF_SetHeartBeat = function(hDF: DF_HANDLE; pHeartbeat: PDF_Heartbeat): Integer; cdecl;

  TDF_SubscribeByCodes = function(hDF: DF_HANDLE; subHead: TDF_SubscriptionHead; pSubscriptionCodes: PDF_SubscriptionCode; nDataType: Integer = 0): Integer; cdecl;


  {期货行情DLL对接类}
  TFuturesQuotationProxy = class
  private
    handle: Integer;
    //通信服务
    server: Pointer;
    //函数指针声明
    CreateQuotationServer: TCreateQuotationServer;
    SimpleLoginQuotationServer: TSimpleLoginQuotationServer;
    SubscribeContracts: TSubscribeContracts;
    RemoveContracts: TRemoveContracts;
    gettick: TGetOneTick;
    DestroyQuotationServer: TDestroyQuotationServer;
    ConnectedResult: TIsConnected;
    LoginResult: TLoginSuccess;
  public
    constructor Create(key: string);
    //映射每个数据的行情接口
    procedure Connected(psFrontAddress: PChar; mdflowpath: PChar; udp: Boolean = false; bIsMulticast: Boolean = false);
    procedure SimpleLogin(BrokerID: PChar; userId: PChar; pwd: Pchar);
//    function Subscribe(arr: array of PChar; size: Integer): Integer;
    function Subscribe(arr: Pointer; size: Integer): Integer;
    function UnSubscribe(arr: array of PChar; size: Integer): Integer;
    function GetOneTick(): TQuotationData;
    procedure Close();
    function IsConnected(): Boolean;
    function LoginSucess(): Boolean;
    destructor Destroy; override;
  end;

  {期权行情DLL对接类}
  TOptionQuotationProxy = class
  private
    handle: Integer;
    //函数声明
    DFCreate: TDF_Create;
    DFAddServer: TDF_AddServer;
    DFSetRecvDataFunc: TDF_SetRecvDataFunc;
    DFSetNoticeFunc: TDF_SetNoticeFunc;
    DFServerBegin: TDF_Begin;
    DFSetRequestMarkets: TDF_SetRequestMarkets;
    DFSetHeartBeat: TDF_SetHeartBeat;
    DFSubscribeByCodes: TDF_SubscribeByCodes;
  public
    server: DF_HANDLE;
    SubQuotationable: Boolean;
    constructor Create(Akey: string);
    //创建句柄，设置市场，设置心跳包
    function Connected(): Integer;
    function AddServer(Aaddr: string; Aport: Integer; Aaccount: string; Apassword: string): Integer;
    function SetResponseFunc(AFunc1: Pointer; AFunc2: Pointer): Integer;
    function ServerBegin(): Integer;
    //这个再begin之后，代码列表返回通知之后调用
    function SubscribeCode(codes: Pointer; size: Integer): Integer;
  end;

//响应函数
procedure OnDfRecvdata(DF: DF_HANDLE; const pHead: PDF_MsgHead; const pAppHead: PDF_AppHead; const pData: Pointer); stdcall;

procedure OnDfNotice(DF: DF_HANDLE; nNoticeType: Integer; nSubType: Integer; const pNoticeData: Pointer); stdcall;


//    format : TFloatFormat;

implementation

uses
  uGlobalInstance, uDrawView;
{ TFuturesQuotationProxy }

constructor TFuturesQuotationProxy.Create(key: string);
begin
  handle := LoadLibrary(PChar(key));
  CreateQuotationServer := GetProcAddress(Self.handle, PChar(CREATE_QUOTATION_SERVER));
  SimpleLoginQuotationServer := GetProcAddress(Self.handle, PChar(SIMPLE_LOGIN_QUOTATION_SERVER));
  SubscribeContracts := GetProcAddress(Self.handle, PChar(SUBSCRIBE_CONTRACTS));
  RemoveContracts := GetProcAddress(Self.handle, PChar(REMOVE_CONTRACTS));
  gettick := GetProcAddress(Self.handle, PChar(GET_ONE_TICK));
  DestroyQuotationServer := GetProcAddress(Self.handle, PChar(DESTROY_QUOTATION_SERVER));
  ConnectedResult := GetProcAddress(Self.handle, PChar(IS_CONNECTED));
  LoginResult := GetProcAddress(Self.handle, PChar(LOGIN_SUCESS));
end;

destructor TFuturesQuotationProxy.Destroy;
begin
//  Close();
  inherited;
end;

procedure TFuturesQuotationProxy.Connected(psFrontAddress: PChar; mdflowpath: PChar; udp: Boolean = false; bIsMulticast: Boolean = false);
begin

  server := CreateQuotationServer(psFrontAddress, mdflowpath, udp, bIsMulticast);
end;

procedure TFuturesQuotationProxy.SimpleLogin(BrokerID: PChar; userId: PChar; pwd: Pchar);
begin
  SimpleLoginQuotationServer(server, BrokerID, userId, pwd);
end;

//function TQuotationProxy.Subscribe(arr: array of PChar; size: Integer): Integer;
function TFuturesQuotationProxy.Subscribe(arr: Pointer; size: Integer): Integer;
//var
//  sContent: string;
begin
//  MessageBox(0, PChar('[pascal 2] size is:' + IntToStr(size)) , 'Waring', IDOK);

  Result := SubscribeContracts(server, arr, size);
end;

function TFuturesQuotationProxy.UnSubscribe(arr: array of PChar; size: Integer): Integer;
begin
  Result := RemoveContracts(server, arr, size);
end;

function TFuturesQuotationProxy.GetOneTick(): TQuotationData;
begin
  Result := gettick(server);
end;

procedure TFuturesQuotationProxy.Close();
begin
  DestroyQuotationServer(server);
end;

function TFuturesQuotationProxy.IsConnected(): Boolean;
begin
  Result := ConnectedResult(server);
end;

function TFuturesQuotationProxy.LoginSucess(): Boolean;
begin
  Result := LoginResult(server);
end;

{ TOptionQuotationProxy }

function TOptionQuotationProxy.AddServer(Aaddr: string; Aport: Integer; Aaccount, Apassword: string): Integer;
var
  I: Integer;
  iItems: Integer;
  arrReqMarkets: array[0..1] of TDF_ReqMarkets;
begin
  Result := DFAddServer(server, PChar(Aaddr), Aport, 1, 0, '', 0, '', '', PChar(Aaccount), PChar(Apassword));
end;

function TOptionQuotationProxy.Connected: Integer;
var
  i1: Integer;
  i2: Integer;
  heartbeat: TDF_Heartbeat;
  nItems: Integer;
  arrReqMarkets: array[0..1] of TDF_ReqMarkets;
  I: Integer;
//  arrReqMarkets: PDF_ReqMarkets;
begin
  heartbeat.nBeatType := 2;
  heartbeat.nBeatFrequency := 20;
  heartbeat.nTimeOut := 60;
    //设置市场属性
//  nItems := 2;
////    FillMemory(arrReqMarkets, 3, TDF_ReqMarkets);
//  arrReqMarkets := GetMemory(2 * SizeOf(TDF_ReqMarkets));
//  arrReqMarkets.nMarketID := DF_MARKET_TYPE_SHOPT;
//  arrReqMarkets.nFlags := arrReqMarkets.nFlags or MARKET_FLAGS_PRESENT;
//  inc(arrReqMarkets);
//  arrReqMarkets.nMarketID := DF_MARKET_TYPE_SZOPT;
//  arrReqMarkets.nFlags := arrReqMarkets.nFlags or MARKET_FLAGS_PRESENT;
//  dec(arrReqMarkets);
////  for I := 0 to nItems - 1 do
////  begin
////    arrReqMarkets[I].nFlags := arrReqMarkets[I].nFlags or MARKET_FLAGS_PRESENT;
////  end;
    //设置市场属性
  nItems := 2;
  ZeroMemory(@arrReqMarkets, 2 * sizeOf(TDF_ReqMarkets));
  arrReqMarkets[0].nMarketID := DF_MARKET_TYPE_SHOPT;
  arrReqMarkets[1].nMarketID := DF_MARKET_TYPE_SZOPT;
  for I := 0 to nItems - 1 do
  begin
    arrReqMarkets[I].nFlags := arrReqMarkets[I].nFlags or MARKET_FLAGS_PRESENT;
  end;
  server := DFCreate();
  i1 := DFSetHeartBeat(server, @heartbeat);
//  i1 := DFAddServer(server, '180.169.63.12', 8201, 1, 0, '', 0, '', '', 'JGkJ', '123456');
  i2 := DFSetRequestMarkets(server, @arrReqMarkets, nItems);
  if ((i1 = 0) and (i2 = 0)) then
  begin
    Result := 0;
  end;
end;

constructor TOptionQuotationProxy.Create(Akey: string);
begin
  SubQuotationable := False;
  handle := LoadLibrary(PChar(Akey));
  DFCreate := GetProcAddress(handle, PChar(DF_CREATE));
  DFAddServer := GetProcAddress(handle, PChar(DF_ADDSERVER));
  DFSetRecvDataFunc := GetProcAddress(handle, PChar(DF_SETRECVDATAFUNC));
  DFSetNoticeFunc := GetProcAddress(handle, PChar(DF_SETNOTICEFUNC));
  DFServerBegin := GetProcAddress(handle, PChar(DF_BEGIN));
  DFSetRequestMarkets := GetProcAddress(handle, PChar(DF_SETREQUESTMARKETS));
  DFSetHeartBeat := GetProcAddress(handle, PChar(DF_SETHEARTBEAT));
  DFSubscribeByCodes := GetProcAddress(handle, PChar(DF_SUBSCRIBEBYCODES));
end;

procedure OnDfNotice(DF: DF_HANDLE; nNoticeType: Integer; nSubType: Integer; const pNoticeData: Pointer);
begin
  if (pNoticeData <> nil) then
  begin
    case nNoticeType of
      DF_NOTICE_RUNINFO:
        begin
       //普通运行
        end;
      DF_NOTICE_CONNECT:
        begin
          //网络已连接
        end;
      DF_NOTICE_DISCONNECT:
        begin
          //网络断开
        end;
      DF_NOTICE_BEATOUTTIME:
        begin
          //心跳应答超时
        end;
      DF_NOTICE_CODETABLE:
        begin
          //代码列表返回通知
//          Writeln('代码列表返回');
          FOptionQuotationProxy.SubQuotationable := True;
        end;

    else
      //其他情况
    end;
  end;
end;

procedure OnDfRecvdata(DF: DF_HANDLE; const pHead: PDF_MsgHead; const pAppHead: PDF_AppHead; const pData: Pointer);
var
  pOptionMarketData: PDF_OptionMarketData;
  pOptionMarketDataTmp: PDF_OptionMarketData;
  I: Integer;
  J: integer;
  key: string;
  pCodeInfo: PChar;
  pCodeInfotmp: PChar;
  Size: Integer;
  Count: Integer;
  pTmpCodeInfo: PDF_CodeInfo;
  pOneData: PDF_CodeInfo;
  nMarketID: Integer;
  nCodeID: Integer;
  str: string;
  dataList: TStringList;
  sBuyPrice: string;
  sSellPrice: string;
  sBuyCount: string;
  sSellCount: string;
begin
  if (TQuotationDataCenter.Instance.OptionQuotationCodeList = nil) then
  begin
    TQuotationDataCenter.Instance.OptionQuotationCodeList := TStringList.Create;
  end;
  case pHead.nDataType of
    DF_HEARTBEAT:
      begin
        //心跳包
        if (DF = FOptionQuotationProxy.server) then
        begin
//          Writeln('[heartbeat]====>' + IntToStr(PDF_HeartbeatAns(pData).nTime));
        end;
      end;
    DF_LOGINANSWER:
      begin
        //登录应答
        if (DF = FOptionQuotationProxy.server) then
        begin
//          Writeln('[loginresponse]====>' + PDF_MarketLoginAnswer(pData).szUserName + IntToStr(PDF_MarketLoginAnswer(pData).nAnswerResult) + PDF_MarketLoginAnswer(pData).szInfo);
        end;
      end;
    DF_REQMARKETS:
      begin
        //设置市场
      end;
    DF_CODETABLE:
      begin
        //代码列表
        if ((DF = FOptionQuotationProxy.server) and (PDF_CodeTableHead(pData).nMarketID <> 0) and (PDF_CodeTableHead(pData).nMarketID <> 1)) then
        begin
          //数据起始地址
          pCodeInfo := PChar(pData);
          Inc(pCodeInfo, pAppHead.arrnAppItemSize[0] * pAppHead.arrnAppItems[0]);
          //代码数据结构大小/数量
          Size := pAppHead.arrnAppItemSize[1];
          Count := pAppHead.arrnAppItems[1];
          //判断数据是否需要更新
          //保存数据
          for I := 0 to pAppHead.arrnAppItems[1] - 1 do
          begin
            key := IntToStr(PDF_CodeTableHead(pData).nMarketID) + string(',') + IntToStr(I);
            pCodeInfotmp := pCodeInfo;
            Inc(pCodeInfotmp, I * Size);
            pTmpCodeInfo := PDF_CodeInfo(pCodeInfotmp);
            New(pOneData);
            Move(pTmpCodeInfo^, pOneData^, SizeOf(TDF_CodeInfo));
            if (TQuotationDataCenter.Instance.OptionQuotationCodeList.IndexOf(key) <> -1) then
            begin
              TQuotationDataCenter.Instance.OptionQuotationCodeList.Delete(TQuotationDataCenter.Instance.OptionQuotationCodeList.IndexOf(key));
            end;
            TQuotationDataCenter.Instance.OptionQuotationCodeList.AddObject(key, Pointer(pOneData));
          end;

//          Writeln('记录数：' + IntToStr(pAppHead.arrnAppItemSize[0]) + '数1：' + IntToStr(pAppHead.arrnAppItems[0]) + '数2:' + IntToStr(pAppHead.arrnAppItems[1]) + '数3:' + IntToStr(pAppHead.arrnAppItems[2]) + '数4:' + IntToStr(pAppHead.arrnAppItems[3]) + '数5:' + IntToStr(pAppHead.arrnAppItems[4]));
//          Writeln('[ContractList]====>市场：' + IntToStr(PDF_CodeTableHead(pData).nMarketID) + '日期：' + IntToStr(PDF_CodeTableHead(pData).nDate) + '代码列表个数：' + IntToStr(pAppHead.arrnAppItems[1]));
        end;
      end;
    DF_OPTIONBASIC:
      begin
        //期权基本信息列表
        if (DF = FOptionQuotationProxy.server) then
        begin
//          Writeln('[OptionMsgList]====>市场：' + IntToStr(PDF_OptionBasicHead(pData).nMarketID) + '日期：' + IntToStr(PDF_OptionBasicHead(pData).nDate) + '期权基本信息列表个数：' + IntToStr(pAppHead.arrnAppItems[1]));
        end;
      end;
    DF_OPTIONDATA:
      begin
        //期权行情快照数据
        pOptionMarketData := PDF_OptionMarketData(pData);
//        Writeln('[行情]：记录表数量：');
//         + IntToStr(pAppHead.nItemAmount) + '数1：' + IntToStr(pAppHead.arrnAppItems[0]) + '数2:' + IntToStr(pAppHead.arrnAppItems[1]) + '数3:' + IntToStr(pAppHead.arrnAppItems[2]) + '数4:' + IntToStr(pAppHead.arrnAppItems[3]) + '数5:' + IntToStr(pAppHead.arrnAppItems[4]));
        for I := 0 to pAppHead.arrnAppItems[0] - 1 do
        begin
          nMarketID := pOptionMarketData.nIdnum mod 100;
          nCodeID := pOptionMarketData.nIdnum div 100;

          str := string(IntToStr(nMarketID) + ',' + IntToStr(nCodeID));
//          Writeln('[' + IntToStr(I) + ']=====>ID:' + PDF_CodeInfo(OptionQuotationCodeList.Objects[codeList.IndexOf(str)]).szID + '未平数:' + IntToStr(pOptionMarketData.iTotalLongPosition) + '总成交数：' + IntToStr(pOptionMarketData.iTradeVolume) + '成交金额：' + FloatToStr(pOptionMarketData.dTotalValueTraded) + '昨结算:' + FloatToStr(pOptionMarketData.unPreSettlPrice) + '涨跌：' + FloatToStr(pOptionMarketData.unSD1));
          TDrawView.instance.log('=====>ID' + PDF_CodeInfo(TQuotationDataCenter.Instance.OptionQuotationCodeList.Objects[TQuotationDataCenter.Instance.OptionQuotationCodeList.IndexOf(str)]).szID + '未平数:' + IntToStr(pOptionMarketData.iTotalLongPosition) + '总成交数：' + IntToStr(pOptionMarketData.iTradeVolume) + '成交金额：' + FloatToStr(pOptionMarketData.dTotalValueTraded) + '昨结算:' + FloatToStr(pOptionMarketData.unPreSettlPrice) + '涨跌：' + FloatToStr(pOptionMarketData.unSD1), $00004080, IntToStr(I));
          dataList := TStringList.Create;
          sBuyPrice := '';
          for J := 0 to 4 do
          begin
            sBuyPrice := sBuyPrice + '|' + IntToStr(pOptionMarketData.arrunBuyPrice_5[J]);
          end;
          sSellPrice := '';
          for J := 0 to 4 do
          begin
            sSellPrice := sSellPrice + '|' + IntToStr(pOptionMarketData.arrunSellPrice_5[J]);
          end;
          sSellCount := '';
          for J := 0 to 4 do
          begin
            sSellCount := sSellCount + '|' + IntToStr(pOptionMarketData.arriSellVolume_5[J]);
          end;
          sBuyCount := '';
          for J := 0 to 4 do
          begin
            sBuyCount := sBuyCount + '|' + IntToStr(pOptionMarketData.arriBuyVolume_5[J]);
          end;

          dataList.DelimitedText := PDF_CodeInfo(TQuotationDataCenter.Instance.OptionQuotationCodeList.Objects[TQuotationDataCenter.Instance.OptionQuotationCodeList.IndexOf(str)]).szID + ',' + IntToStr(pOptionMarketData.unTradePrice) + ',' + IntToStr(pOptionMarketData.unSD1) + ',' + sBuyPrice + ',' + sBuyCount + ',' + sSellPrice + ',' + sSellCount + ',' + IntToStr(pOptionMarketData.unPreSettlPrice) + ',' + IntToStr(pOptionMarketData.unOpenPrice) + ',' + IntToStr(pOptionMarketData.unHighPrice) + ',' + IntToStr(pOptionMarketData.unLowPrice) + ',' + IntToStr(pOptionMarketData.iTradeVolume) + ',' + FloatToStr(pOptionMarketData.dTotalValueTraded) + ',' + IntToStr(pOptionMarketData.nTime);
          TQuotationDataCenter.Instance.addItem(PDF_CodeInfo(TQuotationDataCenter.Instance.OptionQuotationCodeList.Objects[TQuotationDataCenter.Instance.OptionQuotationCodeList.IndexOf(str)]).szID, dataList, OPTION);
          //界面更新
          TDrawView.instance.RunSynchronize(TDrawView.instance.DrawOptionQuotationGridView);

          Inc(pOptionMarketData);
        end;
      end;
    DF_MARKETCLOSE:
      begin
        //收市
      end;
    DF_QUOTATIONDATE_CHANGE:
      begin
        //日期变更
      end;
    DF_SVRCLOSE:
      begin
        //服务器关闭
      end;
    DF_SUBSCRIBE:
      begin
        //订阅应答
      end;
  else
    ///其他情况
  end;
end;

function TOptionQuotationProxy.ServerBegin: Integer;
begin
  Result := DFServerBegin(server);
end;

function TOptionQuotationProxy.SetResponseFunc(AFunc1, AFunc2: Pointer): Integer;
var
  p: Pointer;
begin
  p := DFSetNoticeFunc(server, AFunc2);
  p := DFSetRecvDataFunc(server, AFunc1);
  Result := -1;
  if (p <> nil) then
  begin
    Result := 0;
  end;

end;

function TOptionQuotationProxy.SubscribeCode(codes: Pointer; size: Integer): Integer;
var
  subHead: TDF_SubscriptionHead;
  arr: array of PChar;
  I: Integer;
  ptmp: PDF_SubscriptionCode;
  iStart, iStop: DWORD;
begin
  iStart := GetTickCount;
  while SubQuotationable = False do
  begin
    iStop := GetTickCount;
    Application.ProcessMessages;
    if (iStop - iStart) > 5000 then
    begin
      MessageBox(0, '订阅超时，期权代码列表无返回', '提示', MB_OK);
      Break;
    end;
  end;

  subHead.nSubscriptionType := DF_SUB_TYPE_ALLDEL;
  subHead.nItems := size;
  Result := DFSubscribeByCodes(server, subHead, nil, 1);

  subHead.nItems := size;
  subHead.nSubscriptionType := DF_SUB_TYPE_ADD;
  Result := DFSubscribeByCodes(server, subHead, PDF_SubscriptionCode(codes), 1);
  if (Result = 0) and (FDataSchedule <> nil) then
  begin
    SetLength(arr, subHead.nItems);
    ptmp := PDF_SubscriptionCode(codes);
    for I := 0 to subHead.nItems - 1 do
    begin
      arr[I] := PChar(string(ptmp.szSymbol));
      inc(ptmp);
    end;
    FDataSchedule.AddContracts(arr, Option);
  end;
end;

end.

