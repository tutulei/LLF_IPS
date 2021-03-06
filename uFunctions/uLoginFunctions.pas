unit uLoginFunctions;

interface

procedure ConnectedFuturesTrade(account: string; pwd: string);

procedure ConnectedOptionTrade(account: string; pwd: string);

procedure ConnectedActualsTrade(account: string; pwd: string);

procedure ConnectedQuotation();

procedure ConnectedFutures();

procedure ConnectedOption();

procedure ConnectedActuals();

procedure updateData();

implementation

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, jpeg, ExtCtrls, uConfigUnit, uGlobalInstance, uQuotationAPI,
  uTradeAPI, uDrawView, uManagerThread, uDataStruct, uContractsSchedule, MainWIN,
  ComCtrls, ufrmLoginForm, uDataCenter, uConstants;

procedure ConnectedFuturesTrade(account: string; pwd: string);
var
  item: TListItem;
  pTradeFuturesServer: PTradeServerStruct;
  pAccount: PAccountStruct;
begin
  //期货交易账户登录
  if (FFuturesTradeProxy <> nil) then
    FFuturesTradeProxy.Destroy;
  FFuturesTradeProxy := TFuturesTradeProxy.Create(FuturesdllName);
  pTradeFuturesServer := PTradeServerStruct(FutureTradeServerList.Objects[DefaultFutureTradeServerIndex]);
  pAccount := PAccountStruct(FuturesAccountList.Objects[DefaultFuturesAccountIndex]);
  FFuturesTradeProxy.Connected(PChar(pTradeFuturesServer.sServer), PChar(''));
  FFuturesTradeProxy.AuthAndLogin(PChar(pTradeFuturesServer.sBrokerID), PChar(account), PChar(pwd), PChar(pAccount.sAuthCode), PChar(pAccount.sAppid));
  if (FFuturesTradeProxy.isLogin) then
  begin
    pAccount.sAccount := account;
    TradeServerStatus.FuturesIsLogin := true;
    TradeServerStatus.FuturesAccount := account;
  end;
  //  pAccount.sPassword := LoginTradeFrom.passwordedit.Text;
//    LgoinForm.Close;
//    MainWindow.InitTradeData;

end;

procedure ConnectedOptionTrade(account: string; pwd: string);
var
  pTmp: Pointer;
  iret: Integer;
  pTradeOptionServer: PTradeServerStruct;
  iStart, iStop: DWORD;
begin
  //期权交易账户登录
  if (FOptionTradeProxy <> nil) then
    FOptionTradeProxy.Destroy;
  FOptionTradeProxy := TOptionTradeProxy.Create(OptionsTradeDllName);
  pTradeOptionServer := PTradeServerStruct(OptionTradeServerList.Objects[DefaultOptionTradeServerIndex]);
  //    pAccount := PAccountStruct(OptionAccountList.Objects[DefaultOptionAccountIndex]);
  pTmp := FOptionTradeProxy.CreateTradeServer();
  if (pTmp <> nil) then
  begin
        //连接
    iret := FOptionTradeProxy.Connnect(Pchar(pTradeOptionServer.sServer), SmallInt(pTradeOptionServer.iPort));
    if (iret = 1) then
    begin
      iStart := GetTickCount;
      repeat
        iStop := GetTickCount;
        Sleep(100);
        Application.ProcessMessages;
      until ((iStop - iStart) >= 2000) or FOptionTradeProxy.isConnected;
      if (FOptionTradeProxy.isConnected = False) then
      begin
        MessageBox(0, '期权账户连接柜台超时', '提示', MB_OK);
        FOptionTradeProxy.Destroy;
      end;
    end;
    if (FOptionTradeProxy.isConnected) then
    begin
          //登录
      iret := FOptionTradeProxy.Login(PChar(account), PChar(pwd));
      if (iret = 0) then
      begin
        iStart := GetTickCount;
        repeat
          iStop := GetTickCount;
          Sleep(100);
          Application.ProcessMessages;
        until ((iStop - iStart) >= 2000) or FOptionTradeProxy.isLogin;
        if (FOptionTradeProxy.isLogin = False) then
        begin
          MessageBox(0, '期权账户登录超时', '提示', MB_OK);
          FOptionTradeProxy.Destroy;
        end;
      end;
    end;
  end;
  if (FOptionTradeProxy.isLogin) then
  begin
  //      pAccount.sAccount := LoginForm.OptionAccountEdit.Text;
    TradeServerStatus.OptionIsLogin := true;
    TradeServerStatus.OptionAccount := account;
  end;

end;

procedure ConnectedActualsTrade(account: string; pwd: string);
var
  PTradeActualsServer: PTradeServerStruct;
  pTmp: Pointer;
  iret: Integer;
  iStart, iStop: DWORD;
begin
         //现货交易账户登录
  if (FActualsTradeProxy <> nil) then
    FActualsTradeProxy.Destroy;
  FActualsTradeProxy := TActualsTradeProxy.Create(ActualsTradeDllName);
  PTradeActualsServer := PTradeServerStruct(ActualsTradeServerList.Objects[DefaultActualsTradeServerIndex]);
//    pAccount := PAccountStruct(ActualsAccountList.Objects[DefaultActualsAccountIndex]);
  pTmp := FActualsTradeProxy.CreateTradeServer();
  if (pTmp <> nil) then
  begin
    iret := FActualsTradeProxy.Connnect(Pchar(PTradeActualsServer.sServer), SmallInt(PTradeActualsServer.iPort));
    if (iret = 1) then
    begin
      iStart := GetTickCount;
      repeat
        iStop := GetTickCount;
        Sleep(100);
        Application.ProcessMessages;
      until ((iStop - iStart) >= 2000) or FActualsTradeProxy.isConnected;
      if (FActualsTradeProxy.isConnected = False) then
      begin
        MessageBox(0, '现货账户连接柜台超时', '提示', MB_OK);
        FActualsTradeProxy.Destroy;
      end;
    end;

    if (FActualsTradeProxy.isConnected) then
    begin
      iret := FActualsTradeProxy.Login(PChar(account), PChar(pwd));
      if (iret >= 0) then
      begin
        iStart := GetTickCount;
        repeat
          iStop := GetTickCount;
          Sleep(100);
          Application.ProcessMessages;
        until ((iStop - iStart) >= 2000) or FActualsTradeProxy.isLogin;
        if (FActualsTradeProxy.isLogin = False) then
        begin
          MessageBox(0, '现货账户登录超时', '提示', MB_OK);
          FActualsTradeProxy.Destroy;
        end;
      end;
    end;
  end;
  if (FActualsTradeProxy.isLogin) then
  begin
//      pAccount.sAccount := LoginForm.ActualsAccountEdit.Text;
    TradeServerStatus.ActualsIsLogin := true;
    TradeServerStatus.ActualsAccount := account;
  end;
end;

procedure ConnectedFutures();
var
  tmp: Integer;
  pQuotationServer: PQuotationServerStruct;
begin
   //期货行情
  FFuturesQuotationProxy := TFuturesQuotationProxy.Create(FuturesdllName);
  pQuotationServer := PQuotationServerStruct(FutureQuotationServerList.Objects[DefaultFutureQuotationServerIndex]);
  FFuturesQuotationProxy.Connected(PChar(pQuotationServer.sServer), Pchar(FuturesquotationPath));
  tmp := 0;
  while FFuturesQuotationProxy.IsConnected <> True do
  begin
    Sleep(1000);
    tmp := tmp + 1;
    if (tmp > 5) then
    begin
      FFuturesQuotationProxy.Destroy;
      MessageBox(0, '期货行情自动登录失败', '提示', MB_OK);
      Exit;
    end;
//    Writeln('[delphi]: waiting for connected ...');
  end;
  FFuturesQuotationProxy.SimpleLogin(nChar, nChar, nChar);
  while FFuturesQuotationProxy.LoginSucess <> True do
  begin
    Sleep(500);
//    Writeln('[delphi]: waiting for login ...');
  end;
  QuotationServerStatus.FuturesIsLogin := True;
  QuotationServerStatus.FuturesServer := pQuotationServer.sServer;
end;

procedure ConnectedOption();
var
  pQuotationServer: PQuotationServerStruct;
  ret: Integer;
begin
  //期权行情
  FOptionQuotationProxy := TOptionQuotationProxy.Create(OptiondllName);
  pQuotationServer := PQuotationServerStruct(OptionQuotationServerList.Objects[DefaultOptionQuotationServerIndex]);
  ret := FOptionQuotationProxy.Connected();
  if (ret <> 0) then
  begin
    MessageBox(0, '期权连接错误', '错误', MB_OK);
    exit;
  end;
  ret := FOptionQuotationProxy.AddServer(pQuotationServer.sServer, pQuotationServer.iPort, pQuotationServer.sAccount, pQuotationServer.sPassword);
  if (ret <> 0) then
  begin
    MessageBox(0, '期权地址配置误', '错误', MB_OK);
    exit;
  end;
  ret := FOptionQuotationProxy.SetResponseFunc(@OnDfRecvdata, @OnDfNotice);
  if (ret <> 0) then
  begin
    MessageBox(0, '期权绑定回调错误', '错误', MB_OK);
    exit;
  end;
  ret := FOptionQuotationProxy.ServerBegin();
  if (ret <> 0) then
  begin
    MessageBox(0, '期权行情连接请求', '错误', MB_OK);
    exit;
  end;
  QuotationServerStatus.OptionIsLogin := True;
  QuotationServerStatus.OptionServer := pQuotationServer.sServer;
end;

procedure ConnectedActuals();
var
  pQuotationServer: PQuotationServerStruct;
  ret: Integer;
  pTmp: Pointer;
begin
  FActualsQuotationProxy := TActualsQuotationProxy.Create(ActualsdllName);
  pQuotationServer := PQuotationServerStruct(ActualsQuotationServerList.Objects[DefaultActualsQuotationServerIndex]);
  ret := FActualsQuotationProxy.Init();
  if (ret <> 0) then
  begin
    MessageBox(0, '现货行情初始化错误', '错误', MB_OK);
    exit;
  end;
  ret := FActualsQuotationProxy.SetEnv(5, 1);
  if (ret <> 0) then
  begin
    MessageBox(0, '现货行情环境变量设置错误', '错误', MB_OK);
    exit;
  end;
  pTmp := FActualsQuotationProxy.Connected(PChar(pQuotationServer.sServer), pQuotationServer.iPort, @OnDfRecvdataActuals, @OnDfNoticeActuals, Pchar('600331.sh;000025.sz;000931.sz;399300.sz'));
  if (pTmp = nil) then
  begin
    MessageBox(0, '现货行情环境变量设置错误', '错误', MB_OK);
    exit;
  end;
  QuotationServerStatus.ActualsIsLogin := True;
  QuotationServerStatus.ActualsServer := pQuotationServer.sServer;
end;

procedure ConnectedQuotation();
var
  tmp: Integer;
  arr: array of PChar;
  times: Integer;
  pQuotationServer: PQuotationServerStruct;
  ret: Integer;
  pSubscriptionCode: PDF_SubscriptionCode;
  pTmp: Pointer;
begin
  Application.ProcessMessages;
  ConnectedFutures();
  Application.ProcessMessages;
  ConnectedOption();
  Application.ProcessMessages;  
  //空
  ConnectedActuals();
  Application.ProcessMessages;
  


//  //行情初始化订阅
//  SetLength(arr, 3);
//  arr[0] := Pchar('IF2108');
//  arr[1] := Pchar('IH2108');
//  arr[2] := Pchar('IC2108');
//  tmp := FQuotationProxy.Subscribe(Pointer(arr), 3);
//
//  //订阅成功界面初始化
//  if tmp = 0 then
//  begin
//    TDrawView.Instance().initQuotationView(arr);
//
//  end;
//  FQuotationThread := TManagerThread.Create(updateData);
end;

procedure updateData();
var
  tick: TQuotationData;
  icount: integer;
  pdata: PQuotationData;
  skey: string;
begin
  icount := TQuotationDataCenter.instance.FFuturesSeatingList.Count;
  if icount <= 0 then
    icount := 1;
  Sleep(500 div icount);
  tick := FFuturesQuotationProxy.GetOneTick();
  skey := tick.InstrumentID;
  if (skey <> '') then
  begin
    New(pdata);
    Move(tick, pdata^, SizeOf(TQuotationdata));
    TQuotationDataCenter.Instance.addItem(pdata.InstrumentID, pdata, FUTURES);

    //界面更新
    TDrawView.instance.RunSynchronize(TDrawView.instance.DrawQuotationGridView);
    //    FDataSchedule.ScheduleTick(tick);
  end;
//    Total_Quotation.Rows[1] := fQuotationView(tick);
end;

end.

