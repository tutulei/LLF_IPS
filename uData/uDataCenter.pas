unit uDataCenter;

interface

uses
  Classes, uDataStruct, IdGlobal, Graphics;

type
  PCThostFtdcInvestorPositionField = ^CThostFtdcInvestorPositionField;

  PStringList = ^TStringList;  
  //数据类基类

  TDataList = class
  private
    CriticalSection: TCriticalSection;
    list: TStringList;
    lastItem: Pointer;
    function GetItem(): Pointer;
    procedure SetItem(const item: Pointer);
  public
    constructor Create();
    procedure addItem(key: string; Apdata: Pointer); virtual;
    function getList(): TStringList;
    property Item: Pointer read GetItem write SetItem;
  end;
  
  //持仓数据类 key = id-dir
  TPositionDataCenter = class(TDataList)
  private
    class var
      ins: TPositionDataCenter;
  public
    currentIndex: Integer;
    class function Instance(): TPositionDataCenter;
  end;

  //行情数据类 key = id
  TQuotationDataCenter = class(TDataList)
  private
    class var
      ins: TQuotationDataCenter;
  public
    //用于存储以订阅的合约以及顺序信息
    FFuturesSeatingList: TStringList;
    FOptionSeatingList: TStringList;
    FActualsSeatingList: TStringList;
    class function Instance(): TQuotationDataCenter;
  end;

  //命令窗口数据推送
  TCommandWindowsDataCenter = class(TDataList)
  private
    class var
      ins: TCommandWindowsDataCenter;
  public
    lastColor: Integer;
    class function instance(): TCommandWindowsDataCenter;
//    procedure addString(Astr:string);
    procedure addStrings(Astrs: TStrings; color: Integer = clBlack);
//    procedure addItem(key: string; Apdata: Pointer); override;
  end;

  //日志数据
  TOrderLogDataCenter = class(TDataList)
  private
    class var
      ins: TOrderLogDataCenter;
  public
    logData: string;
    logColor: Integer;
    logView: TComponent;
    class function instance(): TOrderLogDataCenter;
    procedure addLog(Adata: Pointer);
  end;

  //已提交订单数据类
  TOrderDataCenter = class(TDataList)
  private
    class var
      ins: TOrderDataCenter;
      nodealList: TStringList;
  public
    ideleteIndex: Integer;
    class function instance(): TOrderDataCenter;
    function getNoDealList(): TStringList;
    procedure addItem(key: string; Apdata: Pointer); override;
  end;

  //已成交订单数据类
  TSuccessOrderDataCenter = class(TDataList)
  private
    class var
      ins: TSuccessOrderDataCenter;
  public
    class function instance(): TSuccessOrderDataCenter;
  end;

var
  //交易账户持仓数据
  TradingAccountField: CThostFtdcTradingAccountField;

implementation

uses
  DateUtils, SysUtils, MainWIN, uConstants;

constructor TDataList.Create();
begin
  list := TStringList.Create();
  CriticalSection := TCriticalSection.Create();
end;

function TDataList.getList(): TStringList;
begin
  Result := list;
end;

procedure TDataList.addItem(key: string; Apdata: Pointer);
var
  I: Integer;
  str: string;
  l: TStrings;
begin
  CriticalSection.Enter;
  I := list.IndexOf(key);
  if (I = -1) then
  begin
    list.AddObject(key, Apdata);
  end
  else
  begin
    Dispose(Pointer(list.Objects[I]));
    list.Objects[I] := Apdata;
  end;
  lastItem := Apdata;
  CriticalSection.Leave;
end;

function TDataList.GetItem(): Pointer;
begin
  Result := lastItem;
end;

procedure TDataList.SetItem(const item: Pointer);
begin
//  Dispose(lastItem);
  lastItem := item;
end;

//procedure TCommandWindowsDataCenter.addString(Astr:string);
//begin
//  CriticalSection.Enter;
//  list.Add(Astr);
//  lastItem := PChar(list.Strings[list.Count-1]);
//  CriticalSection.Leave;
//end;

procedure TCommandWindowsDataCenter.addStrings(Astrs: TStrings; color: Integer = clBlack);
begin
  CriticalSection.Enter;
  list.AddStrings(Astrs);
  TStrings(lastItem).Free;
  lastItem := Astrs;
  lastColor := color;
  CriticalSection.Leave;
end;

procedure TOrderLogDataCenter.addLog(Adata: Pointer);
begin
  CriticalSection.Enter;
  list.AddObject(timetostr(now), Adata);
  lastItem := list.Objects[list.Count - 1];
  CriticalSection.Leave;
end;

class function TPositionDataCenter.Instance(): TPositionDataCenter;
begin
  if (ins = nil) then
  begin
    ins := TPositionDataCenter.Create();
  end;
  Result := ins;
end;

class function TQuotationDataCenter.Instance(): TQuotationDataCenter;
begin
  if (ins = nil) then
  begin
    ins := TQuotationDataCenter.Create();
  end;
  Result := ins;
end;

class function TCommandWindowsDataCenter.instance(): TCommandWindowsDataCenter;
begin
  if (ins = nil) then
  begin
    ins := TCommandWindowsDataCenter.Create();
  end;
  Result := ins;
end;

procedure TOrderDataCenter.addItem(key: string; Apdata: Pointer);
var
  p: PThostFtdcOrderField;
  index: Integer;
begin
  inherited;
  p := Apdata;
  index := nodealList.IndexOf(IntToStr(p.BrokerOrderSeq));
  //添加未成交记录
  if ((p.OrderStatus = THOST_FTDC_OST_PartTradedQueueing) or (p.OrderStatus = THOST_FTDC_OST_PartTradedNotQueueing) or (p.OrderStatus = THOST_FTDC_OST_NoTradeQueueing) or (p.OrderStatus = THOST_FTDC_OST_NoTradeNotQueueing)) then
  begin
    //数据没记录，添加记录
    if (index = -1) then
    begin
      //添加订单表中的序号记录，刷新界面时，取该记录的值
      nodealList.InsertObject(0, IntToStr(p.BrokerOrderSeq), TObject(list.indexof(key)));
    end;
  end
  else
  begin
    //记录需要删除，删除记录
    if (index <> -1) then
    begin
      nodealList.Delete(index);
      ideleteIndex := index;
    end;
  end;

end;

function TOrderDataCenter.getNoDealList(): TStringList;
begin
  Result := nodealList;
end;

class function TOrderDataCenter.instance(): TOrderDataCenter;
begin
  if (ins = nil) then
  begin
    ins := TOrderDataCenter.Create();
    nodealList := TStringList.Create;
  end;
  Result := ins;
end;

class function TSuccessOrderDataCenter.instance(): TSuccessOrderDataCenter;
begin
  if (ins = nil) then
  begin
    ins := TSuccessOrderDataCenter.Create();
  end;
  Result := ins;
end;

class function TOrderLogDataCenter.instance(): TOrderLogDataCenter;
begin
  if (ins = nil) then
  begin
    ins := TOrderLogDataCenter.Create();
    TOrderLogDataCenter.instance.logView := MainWindow.RichEdit2;
  end;
  Result := ins;
end;

end.

