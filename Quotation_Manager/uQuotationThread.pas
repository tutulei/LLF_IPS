unit uQuotationThread;
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
  TDataRefreshFunction2 = procedure() of object;
  
  //行情显示管理线程
  TQuotationThread = class(TThread)
  protected
    main: Pointer;
    fun1: TDataRefreshFunction1;
    fun2: TDataRefreshFunction2;
    procedure Execute; override;
  public
    //window 为需要刷新数据的组件的指针
    constructor Create(window: Pointer; neededFunction: TDataRefreshFunction1; CreateSuspended: Boolean = False); overload;
    constructor Create(neededFunction: TDataRefreshFunction2; CreateSuspended: Boolean = False); overload;
  end;

implementation

constructor TQuotationThread.Create(window: Pointer; neededFunction: TDataRefreshFunction1; CreateSuspended: Boolean = False);
begin
  inherited Create(CreateSuspended);
  main := window;
  fun1 := neededFunction;
end;

constructor TQuotationThread.Create(neededFunction: TDataRefreshFunction2; CreateSuspended: Boolean = False);
begin
  inherited Create(CreateSuspended);
  fun2 := neededFunction;
end;

procedure TQuotationThread.Execute;
begin
  if (main = nil) then
  begin
    fun2();
  end
  else
  begin
    fun1(main);
  end;

end;

end.

