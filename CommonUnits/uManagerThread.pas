unit uManagerThread;
(*
  行情更新管理线程
  主要创建行情数据刷新的线程
*)

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Menus, Grids;

type
  //定义回调函数
  TDataRefreshFunction1 = procedure(window: Pointer);

  TFunction = procedure();

  TClassFunction = procedure() of object;
  //提交订单

  TPushOneOrder = procedure(InstrumentID: PChar; Direction: Char; OffsetFlag: Char; LimitPrice: Double) of object;

  //线程管理器
  TManagerThread = class(TThread)
  public
    class var
      ThreadList: TList;
  protected
    times: Integer;
    noParamFunction: TFunction;
    noParamClassFunction: TClassFunction;
    number: Integer;
    procedure Execute(); override;
  public
    constructor Create(neededFunction: TFunction; CreateSuspended: Boolean = False); overload;
    constructor Create(neededFunction: TClassFunction; CreateSuspended: Boolean = False); overload;
    constructor Create(count: Integer; neededFunction: TFunction; CreateSuspended: Boolean = False); overload;
  end;

implementation

constructor TManagerThread.Create(neededFunction: TFunction; CreateSuspended: Boolean = False);
begin
  inherited Create(CreateSuspended);
  times := -1;
  noParamFunction := neededFunction;
  number := 0;
  ThreadList.Add(Self);
  //添加登录适配线程
end;

constructor TManagerThread.Create(neededFunction: TClassFunction; CreateSuspended: Boolean = False);
begin
  inherited Create(CreateSuspended);
  times := -1;
  noParamClassFunction := neededFunction;
  number := 1;
  ThreadList.Add(Self);
  //添加登录适配线程
end;

constructor TManagerThread.Create(count: Integer; neededFunction: TFunction; CreateSuspended: Boolean = False);
begin
  inherited Create(CreateSuspended);
  times := count;
  noParamFunction := neededFunction;
  number := 2;
  ThreadList.Add(Self);
end;

procedure TManagerThread.Execute();
var
  fun: Pointer;
  I: Integer;
begin
  case number of
    0:
      begin
        while (not Terminated) do
        begin
          noParamFunction();
        end;
      end;

    1:
      begin
        while (not Terminated) do
        begin
          noParamClassFunction();
        end;
      end;

    2:
      begin
        for I := 0 to times - 1 do
        begin
          noParamFunction();
        end;  
      end;
  end;
  ThreadList.Remove(Self);
end;

end.

