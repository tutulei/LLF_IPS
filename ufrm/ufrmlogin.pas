unit ufrmlogin;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TLoginTradeFrom = class(TForm)
    brokeridlabel: TLabel;
    brokeridedit: TEdit;
    accountlabel: TLabel;
    accountedit: TEdit;
    pwdlabel: TLabel;
    passwordedit: TEdit;
    authcodelabel: TLabel;
    authcodeedit: TEdit;
    appidlabel: TLabel;
    appidedit: TEdit;
    Button1: TButton;
    procedure KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  LoginTradeFrom: TLoginTradeFrom;

implementation

{$R *.dfm}

uses
  ComCtrls, MainWIN, uTradeAPI, uConfigUnit, uDrawView;

procedure TLoginTradeFrom.Button1Click(Sender: TObject);
var
  item: TListItem;
begin
  tradeProxy := TTradeProxy.Create(dllName);
  defaultAccount.sAccount := LoginTradeFrom.accountedit.Text;
  defaultAccount.sPassword := LoginTradeFrom.passwordedit.Text;
  defaultAccount.sAuthCode := LoginTradeFrom.authcodeedit.Text;
  defaultAccount.sBrokerID := LoginTradeFrom.brokeridedit.Text;
  defaultAccount.sAppid := LoginTradeFrom.appidedit.Text;

  tradeProxy.Connected(PChar(defaultAccount.sTradeServer), PChar(''));
  tradeProxy.AuthAndLogin(PChar(defaultAccount.sBrokerID), PChar(defaultAccount.sAccount), PChar(defaultAccount.sPassword), PChar(defaultAccount.sAuthCode), PChar(defaultAccount.sAppid));
  LoginTradeFrom.Close;
  MainWindow.InitTradeData;
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
