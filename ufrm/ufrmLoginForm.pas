unit ufrmLoginForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, jpeg, ExtCtrls, uConfigUnit, uGlobalInstance, uQuotationAPI,
  uTradeAPI, uDrawView, uManagerThread, uDataStruct, uContractsSchedule, MainWIN,
  ComCtrls;

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
    OptionPwdEdit: TEdit;
    Label3: TLabel;
    OptionAccountEdit: TEdit;
    Label4: TLabel;
    Label5: TLabel;
    ActualsPwdEdit: TEdit;
    ActualsAccountEdit: TEdit;
    Label6: TLabel;
    LoginButton: TButton;
    ExitButton: TButton;
    QuotationServerLabel: TLabel;
    QuotationLabel: TLabel;
    loadingLabel: TLabel;
    Timer1: TTimer;
    procedure FormShow(Sender: TObject);
    procedure Panel1MouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
    procedure Panel1MouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure Panel1MouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure ExitButtonClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure LoginButtonClick(Sender: TObject);
    procedure KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure Timer1Timer(Sender: TObject);
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

  myfunction = procedure();

var
  LoginForm: TLoginForm;

implementation

uses
  uConstants, uDataCenter, StrUtils, uLoginFunctions, ufrmConfigForm;

{$R *.dfm}

procedure TLoginForm.ExitButtonClick(Sender: TObject);
begin
  Close;
end;

procedure TLoginForm.Button1Click(Sender: TObject);
begin
  ConfigForm.Show;
end;

procedure TLoginForm.DoInvisible;  //????
var
  control: TControl;
  index, margin, X, Y, ctlX, ctlY, i: Integer;
  fullRgn, clientRgn, ctlRgn: THandle;
begin
  margin := (Width - ClientWidth) div 2;
  fullRgn := CreateRectRgn(0, 0, Width, Height); //??????????????
  X := margin;
  Y := Height - ClientHeight - margin;
  clientRgn := CreateRectRgn(X, Y, X + ClientWidth, Y + ClientHeight);
  CombineRgn(fullRgn, fullRgn, clientRgn, RGN_DIFF); //??????????RGN_DIFF????

  for index := 0 to ControlCount - 1 do   //????????
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
          CombineRgn(fullRgn, fullRgn, ctlRgn, RGN_OR);  //RGN_OR????

        end;
      end;
  end;
  SetWindowRgn(Handle, fullRgn, True);    //????????????
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
  path: string;
begin
  DoInvisible();
  InitConfiguration();
  WindowList := TList.Create;
  moveFlag := False;
  RefreshView();
  FuturesPwdEdit.Text := 'xy@12345';
  //????????????????
  FuturesquotationPath := '.\conlog\' + formatdatetime('yyyymmdd', now);
  if (DirectoryExists(FuturesquotationPath) = false) then
    MkDir(FuturesquotationPath);
  FuturesquotationPath := FuturesquotationPath + '\quotation_';
  //??????????
  path := '.\IPSlog\' + formatdatetime('yyyymmdd', now);
  if (DirectoryExists(path) = false) then
    MkDir(path);
  myFuturesquotationPath := path + '\futures_quotation.txt';
//  FileCreate(myFuturesquotationPath);
  myFuturestradePath := path + '\futures_trade.txt';
  myOptionquotationPath := path + '\option_quotation.txt';
  myOptiontradePath := path + '\option_trade.txt';
  myActualsquotationPath := path + '\actuals_quotation.txt';
  myActualstradePath := path + '\actulas_trade.txt';

end;

procedure TLoginForm.LoginButtonClick(Sender: TObject);
begin
  Timer1.Enabled := True;
  //enable????????????
  FuturesAccountEdit.Enabled := False;
  FuturesPwdEdit.Enabled := False;
  OptionAccountEdit.Enabled := False;
  OptionPwdEdit.Enabled := False;
  ActualsAccountEdit.Enabled := False;
  ActualsPwdEdit.Enabled := False;
  Button1.Enabled := False;
  //????????
  FDataSchedule := TDataSchedule.Create(MainWindow);
  ConnectedQuotation();
  if (QuotationServerStatus.FuturesIsLogin or QuotationServerStatus.OptionIsLogin or QuotationServerStatus.ActualsIsLogin) then
  begin
  //????????????????????????
    if ((FuturesAccountEdit.Text <> '') and (FuturesPwdEdit.Text <> '')) then
    begin
      ConnectedFuturesTrade(FuturesAccountEdit.text, FuturesPwdEdit.text);
    end;
    Application.ProcessMessages;
    if ((OptionAccountEdit.Text <> '') and (OptionPwdEdit.Text <> '')) then
    begin
      ConnectedOptionTrade(OptionAccountEdit.text, OptionPwdEdit.text);
    end;
    Application.ProcessMessages;
    if ((ActualsAccountEdit.Text <> '') and (ActualsPwdEdit.Text <> '')) then
    begin
      ConnectedActualsTrade(ActualsAccountEdit.text, ActualsPwdEdit.text);
    end;
    Application.ProcessMessages;
    if (TradeServerStatus.FuturesIsLogin or TradeServerStatus.OptionIsLogin or TradeServerStatus.ActualsIsLogin) then
    begin
      MainWindow.Show;
//  SetWindowLong(Self.Handle,GWL_EXSTYLE,WS_EX_TOOLWINDOW);
      ShowWindow(Application.Handle, SW_HIDE);
    end;
  end;

  //enable????????????
  FuturesAccountEdit.Enabled := True;
  FuturesPwdEdit.Enabled := True;
  OptionAccountEdit.Enabled := True;
  OptionPwdEdit.Enabled := True;
  ActualsAccountEdit.Enabled := True;
  ActualsPwdEdit.Enabled := True;
  Button1.Enabled := True;
  Timer1.Enabled := False;
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

procedure TLoginForm.RefreshView();
var
  account: PAccountStruct;
begin
  //????????????????????
  QuotationServerLabel.Caption := FutureQuotationServerList[DefaultFutureQuotationServerIndex] + ':' + PQuotationServerStruct(FutureQuotationServerList.Objects[DefaultFutureQuotationServerIndex]).sServer;
  account := PAccountStruct(FuturesAccountList.Objects[DefaultFuturesAccountIndex]);
  FuturesAccountEdit.Text := account.sAccount;
  account := PAccountStruct(OptionAccountList.Objects[DefaultOptionAccountIndex]);
  OptionAccountEdit.Text := account.sAccount;
  account := PAccountStruct(ActualsAccountList.Objects[DefaultActualsAccountIndex]);
  ActualsAccountEdit.Text := account.sAccount;
end;

procedure TLoginForm.Timer1Timer(Sender: TObject);
var
  str: string;
  time: TTimer;
  icount: Integer;
begin
  time := TTimer(Sender);
  if (QuotationServerStatus.FuturesIsLogin = False) then
  begin
    str := '??????????????';
  end
  else if (QuotationServerStatus.OptionIsLogin = False) then
  begin
    str := '??????????????';
  end
  else if (QuotationServerStatus.ActualsIsLogin = False) then
  begin
    str := '??????????????';
  end
  else if (TradeServerStatus.FuturesIsLogin = False) then
  begin
    str := '??????????????????';
  end
  else if (TradeServerStatus.OptionIsLogin = False) then
  begin
    str := '??????????????????';
  end
  else if (TradeServerStatus.ActualsIsLogin = False) then
  begin
    str := '??????????????????';
  end
  else
  begin
    str := '????';
  end;
  icount := 0;
  PosEx('??', str, icount);
  if (icount < 3) then
  begin
    str := str + '??';
  end
  else
  begin
    str := StringReplace(str, '??', '', [rfReplaceAll]);
  end;
  loadingLabel.Caption := str;
end;

end.

