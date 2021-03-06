unit uQuotationAPI;
(*
  行情API
  对接DLL文件
*)
interface

uses
  uQuotationDataStruct, Windows, uConstants, Classes, SysUtils;

type
  PPChar = ^PChar;

  {创建函数指针}
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
  TLoginSucess = function(server: Pointer): Boolean; cdecl;


  //调用DLL封装类
  TQuotationProxy = class
  private
    handle: Integer;
    //通信服务
    server: Pointer;
    {函数指针声明}
    cqs: TCreateQuotationServer;
    sqs: TSimpleLoginQuotationServer;
    sc: TSubscribeContracts;
    rc: TRemoveContracts;
    got: TGetOneTick;
    dqs: TDestroyQuotationServer;
    ic: TIsConnected;
    ls: TLoginSucess;
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
  end;




//    format : TFloatFormat;
    
implementation

{ TQuotationFactory }

constructor TQuotationProxy.Create(key: string);
begin
  handle := LoadLibrary(PChar(key));
  cqs := GetProcAddress(Self.handle, PChar(CREATE_QUOTATION_SERVER));
  sqs := GetProcAddress(Self.handle, PChar(SIMPLE_LOGIN_QUOTATION_SERVER));
  sc := GetProcAddress(Self.handle, PChar(SUBSCRIBE_CONTRACTS));
  rc := GetProcAddress(Self.handle, PChar(REMOVE_CONTRACTS));
  got := GetProcAddress(Self.handle, PChar(GET_ONE_TICK));
  dqs := GetProcAddress(Self.handle, PChar(DESTROY_QUOTATION_SERVER));
  ic := GetProcAddress(Self.handle, PChar(IS_CONNECTED));
  ls := GetProcAddress(Self.handle, PChar(LOGIN_SUCESS));
end;

procedure TQuotationProxy.Connected(psFrontAddress: PChar; mdflowpath: PChar; udp: Boolean = false; bIsMulticast: Boolean = false);
begin

  server := cqs(psFrontAddress, mdflowpath, udp, bIsMulticast);
end;

procedure TQuotationProxy.SimpleLogin(BrokerID: PChar; userId: PChar; pwd: Pchar);
begin
  sqs(server, BrokerID, userId, pwd);
end;

//function TQuotationProxy.Subscribe(arr: array of PChar; size: Integer): Integer;
function TQuotationProxy.Subscribe(arr: Pointer; size: Integer): Integer;
//var
//  sContent: string;
begin
//  MessageBox(0, PChar('[pascal 2] size is:' + IntToStr(size)) , 'Waring', IDOK);

  Result := sc(server, arr, size);
end;

function TQuotationProxy.UnSubscribe(arr: array of PChar; size: Integer): Integer;
begin
  Result := rc(server, arr, size);
end;

function TQuotationProxy.GetOneTick(): TQuotationData;
begin
  Result := got(server);
end;

procedure TQuotationProxy.Close();
begin
  dqs(server);
end;

function TQuotationProxy.IsConnected(): Boolean;
begin
  Result := ic(server);
end;

function TQuotationProxy.LoginSucess(): Boolean;
begin
  Result := ls(server);
end;



end.


