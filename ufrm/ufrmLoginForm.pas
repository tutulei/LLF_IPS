unit ufrmLoginForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, jpeg, ExtCtrls, ufrmConfigForm, uConfigUnit,
  uGlobalInstance, uQuotationAPI, uTradeAPI, uDrawView, uManagerThread,
  uDataStruct, uContractsSchedule, MainWIN, ComCtrls;

type
  TLoginForm = class(TForm)
    Panel1: TPanel;
    Image1: TImage;
    GroupBox1: TGroupBox;
    FuturesAccountEdit: TEdit;
    Label1: TLabel;
    Button1: TButton;
    FuturesPwdEdit: TEdit;
    Label2: TLabel;
    Edit3: TEdit;
    Label3: TLabel;
    Edit4: TEdit;
    Label4: TLabel;
    Label5: TLabel;
    Edit5: TEdit;
    Edit6: TEdit;
    Label6: TLabel;
    LoginButton: TButton;
    ExitButton: TButton;
    QuotationServerLabel: TLabel;
    QuotationLabel: TLabel;
    procedure FormShow(Sender: TObject);
    procedure Panel1MouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
    procedure Panel1MouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure Panel1MouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure ExitButtonClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure LoginButtonClick(Sender: TObject);
    procedure KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    moveFlag: Boolean;
    moveX: Integer;
    moveY: Integer;
    { Private declarations }
  public
    { Public declarations }
    procedure DoInvisible();
    procedure RefreshView();
  end;

procedure ConnectedQuotation();

procedure ConnectedFutures();

procedure ConnectedOption();

procedure ConnectedActuals();

procedure updateData();

procedure ConnectedTrade();

var
  LoginForm: TLoginForm;

implementation

uses
  uConstants, uDataCenter;

{$R *.dfm}

procedure TLoginForm.ExitButtonClick(Sender: TObject);
begin
  Close;
end;

procedure TLoginForm.Button1Click(Sender: TObject);
begin
  ConfigForm.Show;
end;

procedure TLoginForm.DoInvisible;  //透明
var
  control: TControl;
  index, margin, X, Y, ctlX, ctlY, i: Integer;
  fullRgn, clientRgn, ctlRgn: THandle;
begin
  margin := (Width - ClientWidth) div 2;
  fullRgn := CreateRectRgn(0, 0, Width, Height); //创建总裁剪区域
  X := margin;
  Y := Height - ClientHeight - margin;
  clientRgn := CreateRectRgn(X, Y, X + ClientWidth, Y + ClientHeight);
  CombineRgn(fullRgn, fullRgn, clientRgn, RGN_DIFF); //合并区域，RGN_DIFF差集

  for index := 0 to ControlCount - 1 do   //遍历控件
  begin
    control := Controls[index];
    if (control is TWinControl) or (control is TGraphicControl) then
      with control do
      begin
        if Visible then
        begin
          ctlX := X + Left;
          ctlY := Y + Top;
//          ctlRgn := CreateRectRgn(CtlX, CtlY, CtlX + Width, CtlY + Height);
          ctlRgn := CreateRoundRectRgn(ctlX, ctlY, ctlX + Width, ctlY + Height, 20, 20);
          CombineRgn(fullRgn, fullRgn, ctlRgn, RGN_OR);  //RGN_OR并集

        end;
      end;
  end;
  SetWindowRgn(Handle, fullRgn, True);    //设置重绘窗口
end;

procedure TLoginForm.KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if (Key = VK_RETURN) then
    LoginButton.SetFocus;
  if (Key = vk_Tab) then
    SelectNext(TwinControl(Sender), not (ssShift in Shift), True);
  if (Key = Vk_Up) then
    SelectNext(TwinControl(Sender), false, true);
  if (Key = Vk_Down) then
    SelectNext(TwinControl(Sender), True, True);
  if (Key = Vk_Up) or (Key = Vk_Down) then
    Key := 0;
end;

procedure TLoginForm.FormShow(Sender: TObject);
var
  tradeServer: PAccountStruct;
begin
  DoInvisible();
  InitConfiguration();
  WindowList := TList.Create;
  moveFlag := False;
  RefreshView();
  FuturesPwdEdit.Text := 'xy@12345';
end;

procedure TLoginForm.LoginButtonClick(Sender: TObject);
begin
  //enable其他输入框。
  FuturesAccountEdit.Enabled := False;
  FuturesPwdEdit.Enabled := False;
  Edit3.Enabled := False;
  Edit4.Enabled := False;
  Edit5.Enabled := False;
  Edit6.Enabled := False;
  Button1.Enabled := False;
  //登录行情
  FDataSchedule := TDataSchedule.Create(MainWindow);
  ConnectedQuotation();
  if (QuotationServerStatus.FuturesIsLogin or QuotationServerStatus.OptionIsLogin or QuotationServerStatus.ActualsIsLogin) then
  begin
  //检查有效可登录账户有多少
    if ((FuturesAccountEdit.Text <> '') and (FuturesPwdEdit.Text <> '')) then
    begin
      ConnectedTrade();
      TradeServerStatus.FuturesIsLogin := true;
      TradeServerStatus.FuturesAccount := FuturesAccountEdit.Text;
    end;

    MainWindow.Show;
//  SetWindowLong(Self.Handle,GWL_EXSTYLE,WS_EX_TOOLWINDOW);
    ShowWindow(Application.Handle, SW_HIDE);
  end;
  //enable其他输入框。
  FuturesAccountEdit.Enabled := True;
  FuturesPwdEdit.Enabled := True;
  Edit3.Enabled := True;
  Edit4.Enabled := True;
  Edit5.Enabled := True;
  Edit6.Enabled := True;
  Button1.Enabled := True;

end;

procedure TLoginForm.Panel1MouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  moveFlag := true;
  moveX := X;
  moveY := Y;
end;

procedure TLoginForm.Panel1MouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
begin
  if (moveFlag) then
  begin

    self.Top := Mouse.CursorPos.y - moveY;
    self.Left := Mouse.CursorPos.x - moveX;
  end;
end;

procedure TLoginForm.Panel1MouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  moveFlag := False;
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
  ConnectedFutures();
  ConnectedOption();
  //空
  ConnectedActuals();


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

procedure ConnectedFutures();
var
  tmp: Integer;
  pQuotationServer: PQuotationServerStruct;
begin
   //期货行情
  FFuturesQuotationProxy := TFuturesQuotationProxy.Create(FuturesdllName);
  pQuotationServer := PQuotationServerStruct(FutureQuotationServerList.Objects[DefaultFutureQuotationServerIndex]);
  FFuturesQuotationProxy.Connected(PChar(pQuotationServer.sServer), Pchar(''));
  tmp := 0;
  while FFuturesQuotationProxy.IsConnected <> True do
  begin
    Sleep(1000);
    tmp := tmp + 1;
    if (tmp > 5) then
    begin
      FFuturesQuotationProxy.Destroy;
      MessageBox(0, '行情自动登录失败', '提示', MB_OK);
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
  ret := FOptionQuotationProxy.AddServer(pQuotationServer.sServer, StrToInt(pQuotationServer.iPort), pQuotationServer.sAccount, pQuotationServer.sPassword);
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
begin

end;

procedure ConnectedTrade();
var
  item: TListItem;
  pTradeFuturesServer: PTradeServerStruct;
  pAccount: PAccountStruct;
begin
  FFuturesTradeProxy := TTradeProxy.Create(FuturesdllName);
  pTradeFuturesServer := PTradeServerStruct(FutureTradeServerList.Objects[DefaultFutureTradeServerIndex]);
  pAccount := PAccountStruct(AccountList.Objects[DefaultAccountIndex]);
  FFuturesTradeProxy.Connected(PChar(pTradeFuturesServer.sServer), PChar(''));

  FFuturesTradeProxy.AuthAndLogin(PChar(pTradeFuturesServer.sBrokerID), PChar(LoginForm.FuturesAccountEdit.Text), PChar(LoginForm.FuturesPwdEdit.text), PChar(pAccount.sAuthCode), PChar(pAccount.sAppid));

  pAccount.sAccount := LoginForm.FuturesAccountEdit.Text;
  //  pAccount.sPassword := LoginTradeFrom.passwordedit.Text;
//    LgoinForm.Close;
//    MainWindow.InitTradeData;
end;

procedure updateData();
var
  tick: TQuotationData;
  id: string;
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

procedure TLoginForm.RefreshView();
var
  account: PAccountStruct;
begin
  //初始化可视化组件内容
  QuotationServerLabel.Caption := FutureQuotationServerList[DefaultFutureQuotationServerIndex] + ':' + PQuotationServerStruct(FutureQuotationServerList.Objects[DefaultFutureQuotationServerIndex]).sServer;
  account := PAccountStruct(AccountList.Objects[DefaultAccountIndex]);
  FuturesAccountEdit.Text := account.sAccount;
end;

end.

