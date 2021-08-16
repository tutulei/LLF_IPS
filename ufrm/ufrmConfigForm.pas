unit ufrmConfigForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, CheckLst, ComCtrls, ImgList, Grids, uConfigUnit;

type
  TConfigForm = class(TForm)
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    ImageList1: TImageList;
    QuotationAddrGrid: TStringGrid;
    TabSheet4: TTabSheet;
    GroupBox1: TGroupBox;
    SaveButton: TButton;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    TradeGrid: TStringGrid;
    TabSheet5: TTabSheet;
    AccountGrid: TStringGrid;
    ComboBox2: TComboBox;
    Label1: TLabel;
    Label2: TLabel;
    procedure FormShow(Sender: TObject);
    procedure QuotationAddrGridDrawCell(Sender: TObject; ACol, ARow: Integer; Rect: TRect; State: TGridDrawState);
    procedure QuotationAddrGridClick(Sender: TObject);
    procedure SaveButtonClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  ConfigForm: TConfigForm;

implementation

uses
  ufrmLoginForm, XMLIntf;
{$R *.dfm}

procedure TConfigForm.FormShow(Sender: TObject);
var
  datalist: TStrings;
  I: Integer;
  tmp: Pointer;
begin
  datalist := TStringList.Create;
  //行情期货表格初始化
  QuotationAddrGrid.RowCount := FutureQuotationServerList.Count;
  QuotationAddrGrid.DefaultColWidth := (PageControl1.Width div 2) - 40;
  QuotationAddrGrid.ColWidths[0] := 50;
  //期货行情配置导入
  for I := 0 to FutureQuotationServerList.Count - 1 do
  begin
    tmp := PQuotationServerStruct(FutureQuotationServerList.Objects[I]);
    datalist.DelimitedText := ' ,' + PQuotationServerStruct(tmp).sName + ',' + PQuotationServerStruct(tmp).sServer;
    QuotationAddrGrid.Rows[I] := datalist;
  end;
  QuotationAddrGrid.Row := DefaultFutureQuotationServerIndex;
  //交易期货表格初始化
  TradeGrid.RowCount := FutureTradeServerList.Count;
  TradeGrid.DefaultColWidth := (PageControl1.Width div 3) - 30;
  TradeGrid.ColWidths[0] := 50;
  //期货交易配置导入
  for I := 0 to FutureTradeServerList.Count - 1 do
  begin
    tmp := PTradeServerStruct(FutureTradeServerList.Objects[I]);
    datalist.DelimitedText := ' ,' + PTradeServerStruct(tmp).sName + ',' + PTradeServerStruct(tmp).sServer + ',' + PTradeServerStruct(tmp).sBrokerID;
    TradeGrid.Rows[I] := datalist;
  end;
  TradeGrid.Row := DefaultFutureTradeServerIndex;

  //账户（期货）表格初始化
  AccountGrid.RowCount := AccountList.Count;
  AccountGrid.DefaultColWidth := (PageControl1.Width div 4) - 30;
  AccountGrid.ColWidths[0] := 50;
  //账户（期货）配置导入
  for I := 0 to AccountList.Count - 1 do
  begin
    tmp := PAccountStruct(AccountList.Objects[I]);
    datalist.DelimitedText := ' ,' + PAccountStruct(tmp).sName + ',' + PAccountStruct(tmp).sAccount + ',' + PAccountStruct(tmp).sAuthCode + ',' + PAccountStruct(tmp).sAppid;
    AccountGrid.Rows[I] := datalist;
  end;
  AccountGrid.Row := DefaultAccountIndex;


//
//  datalist.DelimitedText := ' ,Simnow[电信],tcp://180.168.146.187:10211';
//  QuotationAddrGrid.Rows[0] := datalist;
//  datalist.DelimitedText := ' ,Simnow[7x24],tcp://180.168.146.187:10131';
//  QuotationAddrGrid.Rows[1] := datalist;
//  datalist.DelimitedText := ' ,南华期货仿真,tcp://218.202.237.33:10213';
//  QuotationAddrGrid.Rows[2] := datalist;

end;

procedure TConfigForm.QuotationAddrGridClick(Sender: TObject);
begin
//  TStringGrid(Sender).Cells[0,TStringGrid(Sender).Row] := '#selected#';
end;

procedure TConfigForm.QuotationAddrGridDrawCell(Sender: TObject; ACol, ARow: Integer; Rect: TRect; State: TGridDrawState);
var
  Bitmap: TBitmap;
  r: TRect;
  width4: Integer;
  heigth4: Integer;
  format: Graphics.TTextFormat;
  text: string;
begin
//  if (TStringGrid(Sender).Cells[ACol,ARow] = '#selected#') then
  if (gdSelected in State) then
  begin
    format := [tfSingleLine, tfVerticalCenter];
    text := TStringGrid(Sender).Cells[ACol, ARow];
    TStringGrid(Sender).Canvas.Brush.Color := clWindow;
    TStringGrid(Sender).Canvas.FillRect(Rect);
    TStringGrid(Sender).Canvas.Font.Color := clBlack;
    TStringGrid(Sender).Canvas.TextRect(Rect, text, format);
    if (ACol = 0) then
    begin
      Bitmap := TBitmap.Create;
      ImageList1.GetBitmap(0, Bitmap);
      r := Classes.Rect(-10, 0, Bitmap.Width + 10, Bitmap.Height);
      TStringGrid(Sender).Canvas.CopyRect(Rect, Bitmap.Canvas, r);
      Bitmap.Free;
    end;
  end;

end;

procedure TConfigForm.SaveButtonClick(Sender: TObject);
var
  RootNode: IXMLNode;
begin
  DefaultFutureQuotationServerIndex := QuotationAddrGrid.Row;
  DefaultFutureTradeServerIndex := TradeGrid.Row;
  DefaultAccountIndex := AccountGrid.Row;
  LoginForm.RefreshView();
  ConfigForm.Visible := False;

  iXMLAreaFile.active := True;
  RootNode := iXMLAreaFile.DocumentElement;

  RootNode.ChildNodes['account'].ChildNodes['FuturesAccount'].Attributes['Default'] := DefaultAccountIndex;
  RootNode.ChildNodes['quotation'].ChildNodes['FuturesServer'].Attributes['Default'] := DefaultFutureQuotationServerIndex;
  RootNode.ChildNodes['trade'].ChildNodes['FuturesServer'].Attributes['Default'] := DefaultFutureTradeServerIndex;
  iXMLAreaFile.SaveToFile(ExtractFilePath(application.exename) + 'config\config.xml');
end;

end.

