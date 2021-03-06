unit uDBManager;

interface

uses
  ADODB;

type
  TDataBaseManager = class
  private
    myconnection: TADOConnection;
    mycommand: TADOCommand;
    myquery: TADOQuery;
  public
    constructor Create();
    procedure Connect(const AServerIp: string; const ADbName: string; const ADbPwd: string);
    function Query(const Asql: string; AList: Pointer): Pointer;
    procedure Modify(const Asql: string);
    procedure Close();
    procedure Open();
    procedure Clear();
    destructor Destroy();
  end;

implementation

constructor TDataBaseManager.Create();
begin
  myconnection := TADOConnection.Create(nil);
  mycommand := TADOCommand.Create(nil);
  myquery := TADOQuery.Create(nil);
  mycommand.Connection := myconnection;
  myquery.Connection := myconnection;
end;

procedure TDataBaseManager.Connect(const AServerIp: string; const ADbName: string; const ADbPwd: string);
begin
  myconnection.ConnectionString := 'Provider=MSOLEDBSQL.1;Password=' + ADbPwd + ';Persist Security Info=True;User ID=' + ADbName + ';Initial Catalog="";Data Source=' + AServerIp + ';Initial File Name="";Server SPN="";Authentication="";Access Token=""';
  myconnection.Open;
end;

function TDataBaseManager.Query(const Asql: string; AList: Pointer): Pointer;
begin
  myquery.Close;
  myquery.SQL.Clear;
  myquery.SQL.Add(Asql);
  myquery.ExecSQL;
  myquery.Open;
end;

procedure TDataBaseManager.Modify(const Asql: string);
begin

end;

procedure TDataBaseManager.Close();
begin
  myconnection.Close;
end;

procedure TDataBaseManager.Open();
begin
  myconnection.Open;
end;

procedure TDataBaseManager.Clear();
begin
  myconnection.Close;
  myquery.Close;
  myquery.SQL.Clear;
  myconnection.ConnectionString := '';
  myquery.ClearFields;
end;

destructor TDataBaseManager.Destroy();
begin
  Clear();
  myconnection.Free;
  myquery.Free;
  mycommand.Free;
  inherited;
end;

end.

