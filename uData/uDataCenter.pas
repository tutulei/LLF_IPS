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
    procedure addItem(key: string; Apdata: Pointer);
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
  end;


var
  TradingAccountField:CThostFtdcTradingAccountField;


implementation

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

end.

