﻿unit MainWIN;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Menus, Grids, ComCtrls, uQuotationAPI, uQuotationDataStruct,
  uQuotationThread, DB, ADODB, uContractsSchedule, StrUtils, ufrmRemoveConteact;

type
  TMainWindow = class(TForm)
    PageControl1: TPageControl;
    TabSheet2: TTabSheet;
    FFuturesQuotationGrid: TStringGrid;
    TabSheet3: TTabSheet;
    TabSheet4: TTabSheet;
    FOptionQuotationGrid: TStringGrid;
    ActualsQuotationGrid: TStringGrid;
    PopupMenu1: TPopupMenu;
    N1: TMenuItem;
    N2: TMenuItem;

    procedure N1Click(Sender: TObject);
    procedure FFuturesQuotationGridDrawCell(Sender: TObject; ACol, ARow: Integer; Rect: TRect; State: TGridDrawState);
    procedure N2Click(Sender: TObject);
  private
    { Private declarations }

  public
    { Public declarations }
    FDataSchedule: TDataSchedule;
        
    constructor Create(AOwner: TComponent); override;
    procedure Connected();
    procedure updateData();
  end;

procedure AddConteact(list: TStringList);

var
  MainWindow: TMainWindow;
  str: string;
  smdflowpath: string = 'D:\Projects\C++\CTPHQProject\CTPHQProject\CTPHQProject';
  smdfornt: string = 'tcp://180.168.146.187:10211';
  pserver: Pointer;
  ilogin: Integer;
  isubscribe: Integer;
  iremove: Integer;
  pget: Pointer;
  nChar: PChar = PChar('');
  myapi: TQuotationProxy;


implementation

uses
  ufrmAddConteact;

{$R *.dfm}
constructor TMainWindow.Create(AOwner: TComponent);
var
  title: TStrings;
begin
  inherited;
//  Self.Height := Screen.WorkAreaHeight;
//  Self.Width := Screen.WorkAreaWidth;
  WindowState :=  wsMaximized;  
  title := TStringList.Create;
  title.DelimitedText := '合约,合约名,最新价,涨跌,买价,买量,卖价,卖量,成交量,持仓量,涨停价,跌停价,今开盘,昨结算,最高价,最低价,现量,涨跌幅,昨收盘,成交额,交易所,行情更新时间';
  FFuturesQuotationGrid.Rows[0] := title;
  FOptionQuotationGrid.Rows[0] := title;
  ActualsQuotationGrid.Rows[0] := title;
  FDataSchedule := TDataSchedule.Create(@FFuturesQuotationGrid, @FOptionQuotationGrid, @ActualsQuotationGrid);
  Connected();
end;

procedure TMainWindow.N1Click(Sender: TObject);
begin
  AddConteactForm.Show;
end;

procedure TMainWindow.N2Click(Sender: TObject);
begin
  //rmoveConteactForm.Show;

end;

procedure TMainWindow.FFuturesQuotationGridDrawCell(Sender: TObject; ACol, ARow: Integer; Rect: TRect; State: TGridDrawState);
var
  str: string;
  format: TTextFormat;
  pgrid: ^TStringGrid;
  snewstr: string;
  Bold: TFontStyles;
begin
  pgrid := @Sender;
  str := pgrid.Cells[ACol, ARow];
  snewstr := MidStr(str, 2, Length(str));
  Bold := [fsBold];
  format := [tfSingleLine, tfVerticalCenter];
  //三列颜色定义
  if (ARow > 0) and ((ACol = 2) or (ACol = 4) or (ACol = 6)) then
  begin
    pgrid.Canvas.Font.Style := Bold;
    pgrid.Canvas.FillRect(Rect);
    if (LeftStr(str, 1) = '-') then
    begin

      pgrid.Canvas.Font.Color := TColor($00e500); //绿色
      pgrid.Canvas.TextRect(Rect, snewstr, format);
    end
    else
    begin
      pgrid.Canvas.Font.Color := TColor($0000ff); //大红
      pgrid.Canvas.TextRect(Rect, str, format);
    end;
  end  //涨跌颜色定义
  else if (ARow > 0) and (ACol = 3) then
  begin
    pgrid.Canvas.FillRect(Rect);
    if (LeftStr(str, 1) = '-') then
    begin
      pgrid.Canvas.Font.Color := TColor($00e500); //绿色
    end
    else if (str <> '')and(StrToFloat(str) > 0) then
    begin
      pgrid.Canvas.Font.Color := TColor($0000ff); //大红
    end;
    pgrid.Canvas.TextRect(Rect, str, format);
  end;

end;

//
procedure TMainWindow.Connected();
var
  tmp: Integer;
  arr: array of PChar;
begin
  myapi := TQuotationProxy.Create('QuotationCTP.dll');
  myapi.Connected(PChar(smdfornt), PChar(smdflowpath));
  while myapi.IsConnected <> True do
  begin
    Sleep(1000);
//    Writeln('[delphi]: waiting for connected ...');
  end;
  myapi.SimpleLogin(nChar, nChar, nChar);
  while myapi.LoginSucess <> True do
  begin
    Sleep(1000);
//    Writeln('[delphi]: waiting for login ...');
  end;
  SetLength(arr, 2);
  arr[0] := Pchar('IF2108');
  arr[1] := Pchar('c2109');
  tmp := myapi.Subscribe(Pointer(arr), 2);
  if tmp = 0 then
  begin
    FDataSchedule.AddContracts(arr);
  end;
  TQuotationThread.Create(updateData);
end;

procedure TMainWindow.updateData();
var
  tick: TQuotationData;
begin
  while true do
  begin
    Sleep(300);
    tick := myapi.GetOneTick();
    if (tick.InstrumentID <> '') then
    begin
      FDataSchedule.ScheduleTick(tick);
    end;
//    Total_Quotation.Rows[1] := fQuotationView(tick);

  end;
end;

procedure AddConteact(list: TStringList);
var
  arr: array of PChar;
  I: Integer;
  tmp: Integer;
begin
  SetLength(arr, list.Count);
  for I := 0 to list.Count - 1 do
  begin
    arr[I] := PChar(list[I]);
  end;
  tmp := myapi.Subscribe(Pointer(arr), list.Count);
  if tmp = 0 then
  begin
    MainWindow.FDataSchedule.AddContracts(arr);
  end
  else
  begin
    MessageBox(0, '合约不存在或输入格式错误!', '提示', MB_OKCANCEL);
  end;
end;

end.

