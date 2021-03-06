unit ufrmChangeForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls;

type
  TQuotationChangeForm = class(TForm)
    Label1: TLabel;
    QuotationAddrLabel: TLabel;
    Label2: TLabel;
    NewQuotationAddrLabel: TLabel;
    ChangeButton: TButton;
    Button1: TButton;
    procedure FormShow(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure ChangeButtonClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure RefreshView();
  end;

var
  QuotationChangeForm: TQuotationChangeForm;

implementation

uses
  uConfigUnit, ufrmConfigForm, uGlobalInstance, uContractsSchedule,
  ufrmLoginForm, MainWIN, uQuotationAPI, uDrawView, uManagerThread, uLoginFunctions;

{$R *.dfm}

procedure TQuotationChangeForm.Button1Click(Sender: TObject);
begin
  ConfigForm.PageControl1.ActivePageIndex := 0;
  ConfigForm.Show;
end;

procedure TQuotationChangeForm.ChangeButtonClick(Sender: TObject);
var
  oldServer: TFuturesQuotationProxy;
  middletmpServer: TFuturesQuotationProxy;
  pQuotationServer: PQuotationServerStruct;
  arr: array of PChar;
  tmp: Integer;
  I: Integer;
begin
  if ((NewQuotationAddrLabel.Caption <> '---') or (NewQuotationAddrLabel.Caption <> QuotationAddrLabel.Caption)) then
  begin
    //创建新的proxy
    oldServer := TFuturesQuotationProxy.Create(FuturesdllName);
    pQuotationServer := PQuotationServerStruct(FutureQuotationServerList.Objects[DefaultFutureQuotationServerIndex]);
    oldServer.Connected(PChar(pQuotationServer.sServer), Pchar(''));
    tmp := 0;
    while oldServer.IsConnected <> True do
    begin
      Sleep(1000);
      tmp := tmp + 1;
      if (tmp > 5) then
      begin
        oldServer.Destroy;
        MessageBox(TQuotationChangeForm(Sender).handle, '行情自动登录失败', '提示', MB_OK);
        Exit;
      end;
//    Writeln('[delphi]: waiting for connected ...');
    end;
    oldServer.SimpleLogin(nChar, nChar, nChar);
    while oldServer.LoginSucess <> True do
    begin
      Sleep(500);
//    Writeln('[delphi]: waiting for login ...');
    end;
    TManagerThread.ThreadList.Remove(FQuotationThread);
    FQuotationThread.Terminate;
    FQuotationThread.WaitFor;
//    //登录成功后移除原来proxy
////    SuspendThread(FQuotationThread.Handle);
    middletmpServer := FFuturesQuotationProxy;
    FFuturesQuotationProxy := oldServer;
    middletmpServer.Destroy;
    //更新界面当前行情
    QuotationServerStatus.FuturesServer := pQuotationServer.sServer;
    MainWindow.StatusBar1.Panels[0].Text := '当前行情:' + QuotationServerStatus.FuturesServer;
    QuotationChangeForm.QuotationAddrLabel.Caption := QuotationChangeForm.NewQuotationAddrLabel.Caption;
    //行情初始化订阅
    SetLength(arr, MainWindow.FFuturesQuotationGrid.RowCount - 1);
    for I := 0 to MainWindow.FFuturesQuotationGrid.RowCount - 2 do
    begin
      arr[I] := Pchar(MainWindow.FFuturesQuotationGrid.Cells[0, I + 1]);
    end;
    FFuturesQuotationProxy.Subscribe(Pointer(arr), MainWindow.FFuturesQuotationGrid.RowCount - 1);
////    ResumeThread(FQuotationThread.Handle);
    FQuotationThread := TManagerThread.Create(updateData);
    TManagerThread.ThreadList.Add(FQuotationThread);
    MessageBox(TQuotationChangeForm(Sender).Handle, '切换成功', '提示', MB_OK);
  end
  else
  begin
    MessageBox(TQuotationChangeForm(Sender).Handle, '请选择一个不同的行情地址', '提示', MB_OK);
  end;
end;

procedure TQuotationChangeForm.FormShow(Sender: TObject);
begin
  QuotationAddrLabel.Caption := FutureQuotationServerList[DefaultFutureQuotationServerIndex] + ':' + PQuotationServerStruct(FutureQuotationServerList.Objects[DefaultFutureQuotationServerIndex]).sServer;

  ShowWindow(handle, sw_ShowNormal);
  SetWindowPos(Self.Handle, HWND_TOPMOST, 0, 0, 0, 0, SWP_NOMOVE or SWP_NOSIZE);
end;

procedure TQuotationChangeForm.RefreshView;
begin
  NewQuotationAddrLabel.Caption := FutureQuotationServerList[DefaultFutureQuotationServerIndex] + ':' + PQuotationServerStruct(FutureQuotationServerList.Objects[DefaultFutureQuotationServerIndex]).sServer;
end;

end.

