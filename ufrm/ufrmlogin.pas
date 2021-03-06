unit ufrmlogin;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, uConstants;

type
  TLoginTradeFrom = class(TForm)
    accountlabel: TLabel;
    accountedit: TEdit;
    pwdlabel: TLabel;
    passwordedit: TEdit;
    Button1: TButton;
    ComboBox1: TComboBox;
    Label1: TLabel;
    Button2: TButton;
    AddrLabel: TLabel;
    Label2: TLabel;
    procedure KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure Button1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure ComboBox1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    mytype: ContractType;
  end;

var
  LoginTradeFrom: TLoginTradeFrom;

implementation

{$R *.dfm}

uses
  ComCtrls, MainWIN, uTradeAPI, uConfigUnit, uDrawView, uGlobalInstance,
  ufrmConfigForm, uLoginFunctions, uMainFunctions, uManagerThread;

procedure TLoginTradeFrom.Button1Click(Sender: TObject);
begin

  if ((accountedit.Text <> '') and (passwordedit.Text <> '')) then
  begin
    case mytype of
      FUTURES:
        ConnectedFuturesTrade(accountedit.Text, passwordedit.Text);
      OPTION:
        ConnectedOptionTrade(accountedit.Text, passwordedit.Text);
      ACTUALS:
        ConnectedActualsTrade(accountedit.Text, passwordedit.Text);
    end;
    LoginTradeFrom.Close;
    TManagerThread.ThreadList.Add(TManagerThread.Create(1, InitTradeData));
  end
  else
  begin
    MessageBox(Handle, '请输入账户和密码', '无法登录', MB_OK);
  end;

end;

procedure TLoginTradeFrom.Button2Click(Sender: TObject);
begin
  ConfigForm.PageControl1.ActivePageIndex := 1;
  ConfigForm.Show;
end;

procedure TLoginTradeFrom.ComboBox1Click(Sender: TObject);
var
  I: Integer;
  pAccount: PAccountStruct;
begin
  I := ComboBox1.ItemIndex;
  pAccount := PAccountStruct(FuturesAccountList.Objects[I]);
  LoginTradeFrom.accountedit.Text := pAccount.sAccount;
end;

procedure TLoginTradeFrom.FormShow(Sender: TObject);
var
  I: Integer;
  tmplist: TStringList;
begin
  //界面数据更新

  for I := 0 to ComboBox1.Items.Count do
  begin
    ComboBox1.Items.Delete(0);
  end;

  Self.Caption := TypeStr(mytype) + '登录';
  case mytype of
    FUTURES:
      begin
        Self.AddrLabel.Caption := FutureTradeServerList[DefaultFutureTradeServerIndex] + ':' + PTradeServerStruct(FutureTradeServerList.Objects[DefaultFutureTradeServerIndex]).sServer;
        tmplist := FuturesAccountList;
      end;
    OPTION:
      begin
        Self.AddrLabel.Caption := OptionTradeServerList[DefaultOptionTradeServerIndex] + ':' + PTradeServerStruct(OptionTradeServerList.Objects[DefaultOptionTradeServerIndex]).sServer;
        tmplist := OptionAccountList;
      end;
    ACTUALS:
      begin
        Self.AddrLabel.Caption := ActualsTradeServerList[DefaultActualsTradeServerIndex] + ':' + PTradeServerStruct(ActualsTradeServerList.Objects[DefaultActualsTradeServerIndex]).sServer;
        tmplist := ActualsAccountList;
      end;
  end;

  for I := 0 to tmplist.Count - 1 do
  begin
    ComboBox1.AddItem(tmplist[I], tmplist.Objects[I]);
  end;
  ComboBox1.ItemIndex := 0;
  accountedit.Text := PAccountStruct(tmplist.Objects[0]).sAccount;
  ShowWindow(handle, sw_ShowNormal);
  SetWindowPos(Self.Handle, HWND_TOPMOST, 0, 0, 0, 0, SWP_NOMOVE or SWP_NOSIZE);
end;

procedure TLoginTradeFrom.KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if (Key = VK_RETURN) then
    Button1.SetFocus;
  if (Key = vk_Tab) then
    SelectNext(TwinControl(Sender), not (ssShift in Shift), True);
  if (Key = Vk_Up) then
    SelectNext(TwinControl(Sender), false, true);
  if (Key = Vk_Down) then
    SelectNext(TwinControl(Sender), True, True);
  if (Key = Vk_Up) or (Key = Vk_Down) then
    Key := 0;
end;

end.

