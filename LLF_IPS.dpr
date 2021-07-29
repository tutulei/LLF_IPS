program LLF_IPS;

uses
  Forms,
  uQuotationAPI in 'CTPProxy\uQuotationAPI.pas',
  uDataStruct in 'CommonUnits\uDataStruct.pas',
  uManagerThread in 'Quotation_Manager\uManagerThread.pas',
  uContractsSchedule in 'Quotation_Manager\uContractsSchedule.pas',
  MainWIN in 'MainWIN.pas' {MainWindow},
  uConstants in 'CommonUnits\uConstants.pas',
  ufrmAddConteact in 'ufrmContract\ufrmAddConteact.pas' {AddConteactForm},
  ChartManager in 'CommonUnits\ChartManager.pas',
  uMyChartManager in 'Chart_Manager\uMyChartManager.pas',
  uDBManager in 'uDBManager\uDBManager.pas',
  uTradeAPI in 'CTPProxy\uTradeAPI.pas',
  uConfigUnit in 'CommonUnits\uConfigUnit.pas',
  uTradeUnit in 'uTradeUnit\uTradeUnit.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TMainWindow, MainWindow);
  Application.CreateForm(TAddConteactForm, AddConteactForm);
  Application.Run;


end.
