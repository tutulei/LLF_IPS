program LLF_IPS;

uses
  Forms,
  uDataStruct in 'CommonUnits\uDataStruct.pas',
  uManagerThread in 'CommonUnits\uManagerThread.pas',
  uContractsSchedule in 'Quotation_Manager\uContractsSchedule.pas',
  MainWIN in 'MainWIN.pas' {MainWindow},
  uConstants in 'CommonUnits\uConstants.pas',
  ufrmAddConteact in 'ufrm\ufrmAddConteact.pas' {AddConteactForm},
  ChartManager in 'CommonUnits\ChartManager.pas',
  uMyChartManager in 'Chart_Manager\uMyChartManager.pas',
  uDBManager in 'uDBManager\uDBManager.pas',
  uConfigUnit in 'CommonUnits\uConfigUnit.pas',
  uTradeUnit in 'uTradeUnit\uTradeUnit.pas',
  uDataCenter in 'uData\uDataCenter.pas',
  uTimer in 'CommonUnits\uTimer.pas',
  uDrawView in 'DrawView\uDrawView.pas',
  ufrmlogin in 'ufrm\ufrmlogin.pas' {LoginTradeFrom},
  Glass in 'CommonUnits\Glass.pas',
  ufrmConfigForm in 'ufrm\ufrmConfigForm.pas' {ConfigForm},
  ufrmLoginForm in 'ufrm\ufrmLoginForm.pas' {LoginForm},
  uGlobalInstance in 'CommonUnits\uGlobalInstance.pas',
  ufrmChangeForm in 'ufrm\ufrmChangeForm.pas' {QuotationChangeForm},
  uQuotationAPI in 'Proxy\uQuotationAPI.pas',
  uTradeAPI in 'Proxy\uTradeAPI.pas',
  uTradeResponse in 'Proxy\uTradeResponse.pas',
  uLoginFunctions in 'uFunctions\uLoginFunctions.pas',
  uMainFunctions in 'uFunctions\uMainFunctions.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TLoginForm, LoginForm);
  Application.CreateForm(TConfigForm, ConfigForm);
  Application.CreateForm(TMainWindow, MainWindow);
  Application.CreateForm(TAddConteactForm, AddConteactForm);
  Application.CreateForm(TLoginTradeFrom, LoginTradeFrom);
  Application.CreateForm(TQuotationChangeForm, QuotationChangeForm);
  Application.Run;

end.

