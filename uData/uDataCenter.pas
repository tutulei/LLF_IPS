unit uDataCenter;

interface

uses
  Classes, uDataStruct, IdGlobal;

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
    class var
      ins: Pointer;
  public
    constructor Create();
    procedure addItem(key: string; Apdata: Pointer);
    function getList(): Pointer;
    property Item: Pointer read GetItem write SetItem;
  end;
  
  //持仓数据类 key = id-dir
  TPositionDataCenter = class(TDataList)
  public
    currentIndex:Integer;
    class function Instance(): TPositionDataCenter;
  end;

  //行情数据类 key = id
  TQuotationDataCenter = class(TDataList)
  public
    //用于存储以订阅的合约以及顺序信息
    FFuturesSeatingList: TStringList;
    FOptionSeatingList: TStringList;
    FActualsSeatingList: TStringList;
    class function Instance(): TQuotationDataCenter;
  end;

implementation

constructor TDataList.Create();
begin
  list := TStringList.Create();
  CriticalSection := TCriticalSection.Create();
end;

function TDataList.getList(): Pointer;
begin
  Result := @list;
end;

procedure TDataList.addItem(key: string; Apdata: Pointer);
var
  I: Integer;
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

end.

