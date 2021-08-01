unit uManagerThread;
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

  //�ύ����
  TPushOneOrder = procedure(InstrumentID: PChar; Direction: Char; OffsetFlag: Char; LimitPrice: Double) of object;

  //������ʾ�����߳�
  TManagerThread = class(TThread)
  protected
    main: Pointer;
    fun1: TDataRefreshFunction1;
    fun2: TDataRefreshFunction2;
    pushoneorder: TPushOneOrder;
    procedure Execute(); override;
  public
    //window Ϊ��Ҫˢ�����ݵ������ָ��
    constructor Create(window: Pointer; neededFunction: TDataRefreshFunction1; CreateSuspended: Boolean = False); overload;
    constructor Create(neededFunction: TDataRefreshFunction2; CreateSuspended: Boolean = False); overload;
    //�����ύ�������߳�
//    constructor Create(InstrumentID: PChar; Direction: Char; OffsetFlag: Char; LimitPrice: Double; neededFunction: TPushOneOrder; CreateSuspended: Boolean = False); overload;
  end;

implementation

constructor TManagerThread.Create(window: Pointer; neededFunction: TDataRefreshFunction1; CreateSuspended: Boolean = False);
begin
  inherited Create(CreateSuspended);
  fun1 := neededFunction;
//  fun1(window);
end;

constructor TManagerThread.Create(neededFunction: TDataRefreshFunction2; CreateSuspended: Boolean = False);
begin
  inherited Create(CreateSuspended);
  fun2 := neededFunction;
//  fun2();
end;

//constructor TManagerThread.Create(InstrumentID: PChar; Direction: Char; OffsetFlag: Char; LimitPrice: Double; neededFunction: TPushOneOrder; CreateSuspended: Boolean = False);
//begin
//  inherited Create(CreateSuspended);
//  pushoneorder := neededFunction;
//  pushoneorder(InstrumentID, Direction, OffsetFlag, LimitPrice);
//end;

procedure TManagerThread.Execute();
begin
  if (main <> nil) then
  begin
    fun1(main);
  end
  else
  begin
    fun2();
  end;
end;

end.
