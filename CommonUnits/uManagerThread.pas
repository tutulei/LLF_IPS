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

  TFunction = procedure() of object;

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
    procedure Execute(); override;
  public
    constructor Create(neededFunction: TFunction; CreateSuspended: Boolean = False); overload;
    constructor Create(count: Integer; neededFunction: TFunction; CreateSuspended: Boolean = False); overload;
  end;

implementation

constructor TManagerThread.Create(neededFunction: TFunction; CreateSuspended: Boolean = False);
begin
  inherited Create(CreateSuspended);
  times := -1;
  noParamFunction := neededFunction;
  ThreadList.Add(Self);
  //添加登录适配线程
end;

constructor TManagerThread.Create(count: Integer; neededFunction: TFunction; CreateSuspended: Boolean);
begin
  inherited Create(CreateSuspended);
  times := count;
  noParamFunction := neededFunction;
  ThreadList.Add(Self);
end;

procedure TManagerThread.Execute();
begin
  if (times > 0) then
  begin
    noParamFunction();
  end
  else
  begin
    while (not Terminated) do
    begin
      noParamFunction();
    end;
  end;
  ThreadList.Remove(Self);
end;

end.

