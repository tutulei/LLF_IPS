unit uConstants;
(*
  常量单元
*)

interface

uses
  Grids, Classes, SysUtils, Forms;

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
  CREATE_TRADE_SERVER = 'CreateTradeServer';
  AUTO_AUTH_AND_LOGINTRADE_SERVER = 'AutoAuthAndLoginTradeServer';
  INPUT_LIMIT_PRICE_ORDER = 'InputLimitPriceOrder';
  QUERY_POSITION = 'QueryPosition';
  CANCEL_ORDER = 'CancelOrder';
  CHECKA_CCOUNT_FIELD = 'CheckAccountField';
  QUERY_ORDER = 'QueryOrder';
  QUERY_TRADE_SUCCESS = 'QueryTradeSuccess';

type
//  PTFastLineSeries = ^TFastLineSeries;

  TmyTStringGrid = class(TStringGrid)
  public
    procedure DeleteRow(ARow: Longint);override;
  end;

var
  WorkPath: string;

implementation

procedure TmyTStringGrid.DeleteRow(ARow: Longint);
begin
  inherited;
end;

end.

