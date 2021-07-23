program LLF_IPS;

uses
  Forms,
  uQuotationAPI in 'uQuotationAPI.pas',
  uQuotationDataStruct in 'uQuotationDataStruct.pas',
  uQuotationThread in 'Quotation_Manager\uQuotationThread.pas',
  uContractsSchedule in 'Quotation_Manager\uContractsSchedule.pas',
  MainWIN in 'MainWIN.pas' {MainWindow},
  uConstants in 'uConstants.pas',
  ufrmAddConteact in 'ufrmContract\ufrmAddConteact.pas' {AddConteactForm},
  ChartManager in 'CommonUnits\ChartManager.pas',
  uMyChartManager in 'Chart_Manager\uMyChartManager.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TMainWindow, MainWindow);
  Application.CreateForm(TAddConteactForm, AddConteactForm);
  Application.Run;


end.
