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
    procedure KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure Button1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure ComboBox1Click(Sender: TObject);
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
  ComCtrls, MainWIN, uTradeAPI, uConfigUnit, uDrawView, uGlobalInstance;

procedure TLoginTradeFrom.Button1Click(Sender: TObject);
var
  item: TListItem;
  pTradeFuturesServer: PTradeServerStruct;
  pAccount: PAccountStruct;
begin
  FtradeProxy := TTradeProxy.Create(dllName);
//  defaultAccount.sAccount := LoginTradeFrom.accountedit.Text;
//  defaultAccount.sPassword := LoginTradeFrom.passwordedit.Text;
//  defaultAccount.sAuthCode := LoginTradeFrom.authcodeedit.Text;
//  defaultAccount.sBrokerID := LoginTradeFrom.brokeridedit.Text;
//  defaultAccount.sAppid := LoginTradeFrom.appidedit.Text;
  pTradeFuturesServer := PTradeServerStruct(FutureTradeServerList.Objects[DefaultFutureTradeServerIndex]);
  pAccount := PAccountStruct(AccountList.Objects[DefaultAccountIndex]);
  FtradeProxy.Connected(PChar(pTradeFuturesServer.sServer), PChar(''));
  FtradeProxy.AuthAndLogin(PChar(pTradeFuturesServer.sBrokerID), PChar(LoginTradeFrom.accountedit.Text), PChar(LoginTradeFrom.passwordedit.Text), PChar(pAccount.sAuthCode), PChar(pAccount.sAppid));
  pAccount.sAccount := LoginTradeFrom.accountedit.Text;
//  pAccount.sPassword := LoginTradeFrom.passwordedit.Text;
  LoginTradeFrom.Close;
  MainWindow.InitTradeData;

end;

procedure TLoginTradeFrom.ComboBox1Click(Sender: TObject);
var
  I: Integer;
  pAccount: PAccountStruct;
begin
  I := ComboBox1.ItemIndex;
  pAccount := PAccountStruct(AccountList.Objects[I]);
  LoginTradeFrom.accountedit.Text := pAccount.sAccount;
end;

procedure TLoginTradeFrom.FormShow(Sender: TObject);
var
  I: Integer;
begin
  for I := 0 to ComboBox1.Items.Count do
  begin
    ComboBox1.Items.Delete(0);
  end;

  for I := 0 to accountList.Count - 1 do
  begin
    ComboBox1.AddItem(accountList[I], accountList.Objects[I]);
  end;
  ComboBox1.ItemIndex := 0;
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

