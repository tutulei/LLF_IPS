unit uDataCenter;

interface

uses
  Classes, uDataStruct, IdGlobal, Graphics, uConstants, SyncObjs;

type
  PCThostFtdcInvestorPositionField = ^CThostFtdcInvestorPositionField;

  PStringList = ^TStringList;

  //数据类基类
  TDataList = class
  private
    CriticalSection: TCriticalSection;
    sFuturesLastItem: string;
    sOptionLastItem: string;
    sActualsLastItem: string;
    FuturesList: TStringList;
    OptionList: TStringList;
    ActualsList: TStringList;
  public
    constructor Create(); virtual;
    procedure addItem(key: string; Apdata: Pointer; Atype: ContractType); virtual;
    function getList(Atype: ContractType): TStringList;
    function getLastItem(Atype: ContractType): string; virtual;
    function Item(Atype: ContractType): Pointer;
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

  {行情数据类 key = id}
  TQuotationDataCenter = class(TDataList)
  private
    IndexLastItem: string;
    IndexCodeList: TStringList;
    class var
      ins: TQuotationDataCenter;
  public
    //用于存储以订阅的合约以及顺序信息
    FFuturesSeatingList: TStringList;
    FOptionSeatingList: TStringList;
    FActualsSeatingList: TStringList;
    FIndexSeatingList: TStringList;
    //行情代码信息列表
    OptionQuotationCodeList: TStringList;
    ActualsQuotationCodeList: TStringList;
    class function Instance(): TQuotationDataCenter;
    function GetItem(Akey: string; Atype: ContractType): Pointer;
    procedure addItem(key: string; Apdata: Pointer; Atype: ContractType); overload;
    constructor Create(); override;
    function GetLastItemKeyIndex(): string;
  end;

  {命令窗口数据推送}
  TCommandWindowsDataCenter = class(TDataList)
  private
    class var
      ins: TCommandWindowsDataCenter;
  public
    lastColor: Integer;
    class function instance(): TCommandWindowsDataCenter;
//    procedure addString(Astr:string);
    procedure addStrings(Astrs: TStrings; Atype: ContractType; color: Integer = clBlack);
//    procedure addItem(key: string; Apdata: Pointer); override;
  end;

  {日志数据}
  TOrderLogDataCenter = class(TDataList)
  private
    class var
      ins: TOrderLogDataCenter;
  public
    logData: string;
    logColor: Integer;
    logView: TComponent;
    class function instance(): TOrderLogDataCenter;
    procedure addLog(Adata: Pointer; Atype: ContractType);
  end;

  {已提交订单数据类}
  TOrderDataCenter = class(TDataList)
  private
    class var
      ins: TOrderDataCenter;
      FuturesnodealList: TStringList;
      OptionnodealList: TStringList;
      ActualsnodealList: TStringList;
      sOptionNodealLastItem: string;
      sActualsNodealLastItem: string;
  public
    ideleteIndex: Integer;
    class function instance(): TOrderDataCenter;
    function getNoDealList(): TStringList;
    procedure addItem(key: string; Apdata: Pointer; Atype: ContractType); override;
    procedure addNoDealItem(Akey: string; Apdata: Pointer; Atype: ContractType);
    function NodealItem(Atype: ContractType): Pointer;
    function getNodealLastItem(Atype: ContractType): string;
  end;

  {已成交订单数据类}
  TSuccessOrderDataCenter = class(TDataList)
  private
    class var
      ins: TSuccessOrderDataCenter;
  public
    class function instance(): TSuccessOrderDataCenter;
  end;

var
  {交易账户持仓数据}
  TradingAccountField: array[0..2] of Pointer;

implementation

uses
  DateUtils, SysUtils, MainWIN;

constructor TDataList.Create();
begin
  FuturesList := TStringList.Create();
  OptionList := TStringList.Create();
  ActualsList := TStringList.Create();
  CriticalSection := TCriticalSection.Create();
end;

function TDataList.getList(Atype: ContractType): TStringList;
begin
  case Atype of
    FUTURES:
      Result := FuturesList;
    OPTION:
      Result := OptionList;
    ACTUALS:
      Result := ActualsList;
  else
    Result := nil;
  end;
end;

function TDataList.Item(Atype: ContractType): Pointer;
var
  mylist: TStringList;
begin
  mylist := getList(Atype);
  if ((mylist = nil) or (mylist.Count <= 0)) then
  begin
    Result := nil;
    Exit;
  end;

  Result := mylist.Objects[mylist.IndexOf(getLastItem(Atype))];
end;

procedure TDataList.addItem(key: string; Apdata: Pointer; Atype: ContractType);
var
  I: Integer;
  str: string;
  tmpList: TStringList;
begin
  CriticalSection.Enter;
  tmpList := getList(Atype);

  I := tmpList.IndexOf(key);
  if (I = -1) then
  begin
    tmpList.AddObject(key, Apdata);
  end
  else
  begin
    Dispose(Pointer(tmpList.Objects[I]));
    tmpList.Objects[I] := Apdata;
  end;
  case Atype of
    FUTURES:
      sFuturesLastItem := key;
    OPTION:
      sOptionLastItem := key;
    ACTUALS:
      sActualsLastItem := key;
  end;
  CriticalSection.Leave;
end;

function TDataList.GetLastItem(Atype: ContractType): string;
begin
  case Atype of
    FUTURES:
      Result := sFuturesLastItem;
    OPTION:
      Result := sOptionLastItem;
    ACTUALS:
      Result := sActualsLastItem;
  end;
end;

//procedure TCommandWindowsDataCenter.addString(Astr:string);
//begin
//  CriticalSection.Enter;
//  list.Add(Astr);
//  lastItem := PChar(list.Strings[list.Count-1]);
//  CriticalSection.Leave;
//end;

procedure TCommandWindowsDataCenter.addStrings(Astrs: TStrings; Atype: ContractType; color: Integer = clBlack);
var
  tmpList: TStringList;
begin
  CriticalSection.Enter;
  tmpList := getList(Atype);
  tmpList.AddStrings(Astrs);
  lastColor := color;
  CriticalSection.Leave;
end;

procedure TOrderLogDataCenter.addLog(Adata: Pointer; Atype: ContractType);
var
  tmpList: TStringList;
  pstr: PString;
begin
  CriticalSection.Enter;
  tmpList := getList(Atype);
  case Atype of
    FUTURES:
      pstr := @sFuturesLastItem;
    OPTION:
      pstr := @sOptionLastItem;
    ACTUALS:
      pstr := @sActualsLastItem;
  end;
  pstr^ := timetostr(now);
  tmpList.AddObject(pstr^, Adata);
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

procedure TQuotationDataCenter.addItem(key: string; Apdata: Pointer; Atype: ContractType);
var
  I: Integer;
  tmplist: TStringList;
begin
  CriticalSection.Enter;
  case Atype of
    FUTURES:
      begin
        sFuturesLastItem := key;
        tmplist := FuturesList;
      end;
    OPTION:
      begin
        sOptionLastItem := key;
        tmplist := OptionList;
      end;

    ACTUALS:
      begin
        sActualsLastItem := key;
        tmplist := ActualsList;
      end;
    ACTUALSINDEX:
      begin
        IndexLastItem := key;
        tmplist := IndexCodeList;
      end;

  end;

  I := tmplist.IndexOf(key);
  if (I = -1) then
  begin
    tmplist.AddObject(key, Apdata);
  end
  else
  begin
    Dispose(Pointer(tmplist.Objects[I]));
    tmplist.Objects[I] := Apdata;
  end;
  CriticalSection.Leave;
end;

constructor TQuotationDataCenter.Create();
begin
  inherited;

  IndexCodeList := TStringList.Create();

  FFuturesSeatingList := TStringList.Create();
  FOptionSeatingList := TStringList.Create();
  FActualsSeatingList := TStringList.Create();
  FIndexSeatingList := TStringList.Create();

  OptionQuotationCodeList := TStringList.Create();
  ActualsQuotationCodeList := TStringList.Create();

end;

function TQuotationDataCenter.GetItem(Akey: string; Atype: ContractType): Pointer;
var
  tmpList: TStringList;
  I: Integer;
begin
  case Atype of
    FUTURES:
      tmpList := FuturesList;
    OPTION:
      tmpList := OptionList;
    ACTUALS:
      tmpList := ActualsList;
    ACTUALSINDEX:
      tmpList := IndexCodeList;
  end;
  I := tmpList.IndexOf(Akey);
  if (I = -1) then
    raise Exception.Create('行情数据getItem取空');
  Result := tmpList.Objects[I];
end;

function TQuotationDataCenter.GetLastItemKeyIndex: string;
begin
  Result := IndexLastItem;
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

procedure TOrderDataCenter.addItem(key: string; Apdata: Pointer; Atype: ContractType);
var
  p: PThostFtdcOrderField;
  index: Integer;
  tmpList: TStringList;
begin
  inherited;
  if (Atype = FUTURES) then
  begin
    p := Apdata;
    tmpList := getList(Atype);
    index := FuturesnodealList.IndexOf(IntToStr(p.BrokerOrderSeq));
    //添加未成交记录
    if ((p.OrderStatus = THOST_FTDC_OST_PartTradedQueueing) or (p.OrderStatus = THOST_FTDC_OST_PartTradedNotQueueing) or (p.OrderStatus = THOST_FTDC_OST_NoTradeQueueing) or (p.OrderStatus = THOST_FTDC_OST_NoTradeNotQueueing)) then
    begin
      //数据没记录，添加记录
      if (index = -1) then
      begin
        //添加订单表中的序号记录，刷新界面时，取该记录的值
        FuturesnodealList.InsertObject(0, IntToStr(p.BrokerOrderSeq), TObject(tmpList.indexof(key)));
      end;
    end
    else
    begin
      //记录需要删除，删除记录
      if (index <> -1) then
      begin
        FuturesnodealList.Delete(index);
        ideleteIndex := index;
      end;
    end;
  end;
end;

procedure TOrderDataCenter.addNoDealItem(Akey: string; Apdata: Pointer; Atype: ContractType);
var
  tmplist: TStringList;
  I: Integer;
begin
  case Atype of
    OPTION:
      begin
        sOptionLastItem := Akey;
        tmplist := OptionnodealList;
      end;
    ACTUALS:
      begin
        sActualsLastItem := Akey;
        tmplist := ActualsnodealList;
      end;
  else
    exit;
  end;

  I := tmplist.IndexOf(Akey);
  if (I = -1) then
  begin
    tmplist.AddObject(Akey, Apdata);
  end
  else
  begin
    Dispose(Pointer(tmplist.Objects[I]));
    tmplist.Objects[I] := Apdata;
  end;
end;

function TOrderDataCenter.getNodealLastItem(Atype: ContractType): string;
begin
  case Atype of
    OPTION:
      Result := sOptionNodealLastItem;
    ACTUALS:
      Result := sActualsNodealLastItem;
  else
    Result := '';
  end;
end;

function TOrderDataCenter.getNoDealList(): TStringList;
begin
  Result := FuturesnodealList;
end;

class function TOrderDataCenter.instance(): TOrderDataCenter;
begin
  if (ins = nil) then
  begin
    ins := TOrderDataCenter.Create();
    FuturesnodealList := TStringList.Create;
    OptionnodealList := TStringList.Create;
    ActualsnodealList := TStringList.Create;
  end;
  Result := ins;
end;

function TOrderDataCenter.NodealItem(Atype: ContractType): Pointer;
var
  mylist: TStringList;
  skey: string;
begin
  try
    mylist := getList(Atype);
    if ((mylist = nil) or (mylist.Count <= 0)) then
    begin
      Result := nil;
      Exit;
    end;
    Result := mylist.Objects[mylist.IndexOf(getNodealLastItem(Atype))];
  except
    on E: Exception do
      Writeln(E.Message);
  end;

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

