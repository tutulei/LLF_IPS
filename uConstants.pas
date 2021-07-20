unit uConstants;
(*
  常量单元
*)

interface

uses
  Grids;

const
  //函数名常量
  CREATE_QUOTATION_SERVER = 'CreateQuotationServer';
  SIMPLE_LOGIN_QUOTATION_SERVER = 'SimpleLoginQuotationServer';
  SUBSCRIBE_CONTRACTS = 'SubscribeContracts';
  REMOVE_CONTRACTS = 'RemoveContracts';
  GET_ONE_TICK = 'GetOneTick';
  DESTROY_QUOTATION_SERVER = 'DestroyQuotationServer';
  IS_CONNECTED = 'IsConnected';
  LOGIN_SUCESS = 'LoginSucess';

type
  TmyTStringGrid = class(TStringGrid)
  public
    procedure DeleteRow(ARow: Longint);
  end;

implementation

procedure TmyTStringGrid.DeleteRow(ARow: Longint);
begin
  inherited;
end;

end.

