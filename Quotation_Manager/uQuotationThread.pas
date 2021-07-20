unit uQuotationThread;
(*
  ������¹����߳�
  ��Ҫ������������ˢ�µ��߳�
*)
interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Menus, Grids;

type
  //����ص�����
  TDataRefreshFunction1 = procedure(window: Pointer);
  TDataRefreshFunction2 = procedure() of object;
  
  //������ʾ�����߳�
  TQuotationThread = class(TThread)
  protected
    main: Pointer;
    fun1: TDataRefreshFunction1;
    fun2: TDataRefreshFunction2;
    procedure Execute; override;
  public
    //window Ϊ��Ҫˢ�����ݵ������ָ��
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
