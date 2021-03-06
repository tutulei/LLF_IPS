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
    procedure ComboBox2Change(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    tmpDefaultIndex: array[0..2, 0..2] of Integer;
  end;

var
  ConfigForm: TConfigForm;

implementation

uses
  ufrmLoginForm, XMLIntf, ufrmChangeForm;
{$R *.dfm}

procedure TConfigForm.ComboBox2Change(Sender: TObject);
var
  I: Integer;
  tmp: Pointer;
  datalist: Tstrings;
begin
  QuotationAddrGrid.DefaultColWidth := 40;
  datalist := TStringList.Create;

  case TComboBox(Sender).ItemIndex of
    0:      //?ڻ?
      begin
      //????
        QuotationAddrGrid.RowCount := FutureQuotationServerList.Count;
        for I := 0 to FutureQuotationServerList.Count - 1 do
        begin
          QuotationAddrGrid.Rows[I].Clear;
          tmp := PQuotationServerStruct(FutureQuotationServerList.Objects[I]);
          datalist.DelimitedText := ' ,' + PQuotationServerStruct(tmp).sName + ',' + PQuotationServerStruct(tmp).sServer;
          QuotationAddrGrid.Rows[I].Clear;
          QuotationAddrGrid.Rows[I] := datalist;
        end;
        QuotationAddrGrid.Row := DefaultFutureQuotationServerIndex;
        //????
        TradeGrid.RowCount := FutureTradeServerList.Count;
        for I := 0 to FutureTradeServerList.Count - 1 do
        begin
          TradeGrid.Rows[I].Clear;
          tmp := PTradeServerStruct(FutureTradeServerList.Objects[I]);
          datalist.DelimitedText := ' ,' + PTradeServerStruct(tmp).sName + ',' + PTradeServerStruct(tmp).sServer + ',' + PTradeServerStruct(tmp).sBrokerID;
          TradeGrid.Rows[I].Clear;
          TradeGrid.Rows[I] := datalist;
        end;
        TradeGrid.Row := DefaultFutureTradeServerIndex;
        //?˻?
        AccountGrid.RowCount := FuturesAccountList.Count;
        for I := 0 to FuturesAccountList.Count - 1 do
        begin
          AccountGrid.Rows[I].Clear;
          tmp := PAccountStruct(FuturesAccountList.Objects[I]);
          datalist.DelimitedText := ' ,' + PAccountStruct(tmp).sName + ',' + PAccountStruct(tmp).sAccount + ',' + PAccountStruct(tmp).sAuthCode + ',' + PAccountStruct(tmp).sAppid;
          AccountGrid.Rows[I].Clear;
          AccountGrid.Rows[I] := datalist;
        end;
        AccountGrid.Row := DefaultFuturesAccountIndex;
      end;
    1:      //??Ȩ
      begin
        //????
        QuotationAddrGrid.RowCount := OptionQuotationServerList.Count;
        for I := 0 to OptionQuotationServerList.Count - 1 do
        begin
          tmp := PQuotationServerStruct(OptionQuotationServerList.Objects[I]);
          datalist.DelimitedText := ' ,' + PQuotationServerStruct(tmp).sName + ',' + PQuotationServerStruct(tmp).sServer + ',' + IntToStr(PQuotationServerStruct(tmp).iPort) + ',' + PQuotationServerStruct(tmp).sAccount + ',' + PQuotationServerStruct(tmp).sPassword;
          QuotationAddrGrid.Rows[I].Clear;
          QuotationAddrGrid.Rows[I] := datalist;
        end;
        QuotationAddrGrid.Row := DefaultOptionQuotationServerIndex;
        //????
        TradeGrid.RowCount := OptionTradeServerList.Count;
        for I := 0 to OptionTradeServerList.Count - 1 do
        begin
          TradeGrid.Rows[I].Clear;
          tmp := PTradeServerStruct(OptionTradeServerList.Objects[I]);
          datalist.DelimitedText := ' ,' + PTradeServerStruct(tmp).sName + ',' + PTradeServerStruct(tmp).sServer + ',' + IntToStr(PTradeServerStruct(tmp).iPort);
          TradeGrid.Rows[I].Clear;
          TradeGrid.Rows[I] := datalist;
        end;
        TradeGrid.Row := DefaultOptionTradeServerIndex;
        //?˻?
        AccountGrid.RowCount := OptionAccountList.Count;
        for I := 0 to OptionAccountList.Count - 1 do
        begin
          AccountGrid.Rows[I].Clear;
          tmp := PAccountStruct(OptionAccountList.Objects[I]);
          datalist.DelimitedText := ' ,' + PAccountStruct(tmp).sName + ',' + PAccountStruct(tmp).sAccount;
          AccountGrid.Rows[I].Clear;
          AccountGrid.Rows[I] := datalist;
        end;
        AccountGrid.Row := DefaultOptionAccountIndex;

      end;
    2: //?ֻ?
      begin
        //????
        QuotationAddrGrid.RowCount := ActualsQuotationServerList.Count;
        for I := 0 to ActualsQuotationServerList.Count - 1 do
        begin
          tmp := PQuotationServerStruct(ActualsQuotationServerList.Objects[I]);
          datalist.DelimitedText := ' ,' + PQuotationServerStruct(tmp).sName + ',' + PQuotationServerStruct(tmp).sServer + ',' + IntToStr(PQuotationServerStruct(tmp).iPort);
          QuotationAddrGrid.Rows[I].Clear;
          QuotationAddrGrid.Rows[I] := datalist;
        end;
        QuotationAddrGrid.Row := DefaultActualsQuotationServerIndex;
        //????
        TradeGrid.RowCount := ActualsTradeServerList.Count;
        for I := 0 to ActualsTradeServerList.Count - 1 do
        begin
          TradeGrid.Rows[I].Clear;
          tmp := PTradeServerStruct(ActualsTradeServerList.Objects[I]);
          datalist.DelimitedText := ' ,' + PTradeServerStruct(tmp).sName + ',' + PTradeServerStruct(tmp).sServer + ',' + IntToStr(PTradeServerStruct(tmp).iPort);
          TradeGrid.Rows[I].Clear;
          TradeGrid.Rows[I] := datalist;
        end;
        TradeGrid.Row := DefaultOptionTradeServerIndex;
        //?˻?
        AccountGrid.RowCount := ActualsAccountList.Count;
        for I := 0 to ActualsAccountList.Count - 1 do
        begin
          AccountGrid.Rows[I].Clear;
          tmp := PAccountStruct(ActualsAccountList.Objects[I]);
          datalist.DelimitedText := ' ,' + PAccountStruct(tmp).sName + ',' + PAccountStruct(tmp).sAccount;
          AccountGrid.Rows[I].Clear;
          AccountGrid.Rows[I] := datalist;
        end;
        AccountGrid.Row := DefaultActualsAccountIndex;

      end;

  end;
  tmpDefaultIndex[TComboBox(Sender).ItemIndex][0] := QuotationAddrGrid.Row;
  tmpDefaultIndex[TComboBox(Sender).ItemIndex][1] := TradeGrid.Row;
  tmpDefaultIndex[TComboBox(Sender).ItemIndex][2] := AccountGrid.Row;
end;

procedure TConfigForm.FormShow(Sender: TObject);
var
  datalist: TStrings;
  I: Integer;
  tmp: Pointer;
begin
  datalist := TStringList.Create;
  //??????????ʼ??
  QuotationAddrGrid.RowCount := FutureQuotationServerList.Count;
//  QuotationAddrGrid.DefaultColWidth := (PageControl1.Width div 2) - 40;
  QuotationAddrGrid.ColWidths[0] := 50;

  //?ڻ????????õ???
  for I := 0 to FutureQuotationServerList.Count - 1 do
  begin
    tmp := PQuotationServerStruct(FutureQuotationServerList.Objects[I]);
    datalist.DelimitedText := ' ,' + PQuotationServerStruct(tmp).sName + ',' + PQuotationServerStruct(tmp).sServer;
    QuotationAddrGrid.Rows[I] := datalist;
  end;
  QuotationAddrGrid.Row := DefaultFutureQuotationServerIndex;
  //?????ڻ???????ʼ??
  TradeGrid.RowCount := FutureTradeServerList.Count;
//  TradeGrid.DefaultColWidth := (PageControl1.Width div 3) - 30;
  TradeGrid.ColWidths[0] := 50;
  //?ڻ????????õ???
  for I := 0 to FutureTradeServerList.Count - 1 do
  begin
    tmp := PTradeServerStruct(FutureTradeServerList.Objects[I]);
    datalist.DelimitedText := ' ,' + PTradeServerStruct(tmp).sName + ',' + PTradeServerStruct(tmp).sServer + ',' + PTradeServerStruct(tmp).sBrokerID;
    TradeGrid.Rows[I] := datalist;
  end;
  TradeGrid.Row := DefaultFutureTradeServerIndex;

  //?˻????ڻ?????????ʼ??
  AccountGrid.RowCount := FuturesAccountList.Count;
//  AccountGrid.DefaultColWidth := (PageControl1.Width div 4) - 30;
  AccountGrid.ColWidths[0] := 50;
  //?˻????ڻ??????õ???
  for I := 0 to FuturesAccountList.Count - 1 do
  begin
    tmp := PAccountStruct(FuturesAccountList.Objects[I]);
    datalist.DelimitedText := ' ,' + PAccountStruct(tmp).sName + ',' + PAccountStruct(tmp).sAccount + ',' + PAccountStruct(tmp).sAuthCode + ',' + PAccountStruct(tmp).sAppid;
    AccountGrid.Rows[I] := datalist;
  end;
  AccountGrid.Row := DefaultFuturesAccountIndex;


//
//  datalist.DelimitedText := ' ,Simnow[????],tcp://180.168.146.187:10211';
//  QuotationAddrGrid.Rows[0] := datalist;
//  datalist.DelimitedText := ' ,Simnow[7x24],tcp://180.168.146.187:10131';
//  QuotationAddrGrid.Rows[1] := datalist;
//  datalist.DelimitedText := ' ,?ϻ??ڻ?????,tcp://218.202.237.33:10213';
//  QuotationAddrGrid.Rows[2] := datalist;

  ShowWindow(handle, sw_ShowNormal);
  SetWindowPos(Self.Handle, HWND_TOPMOST, 0, 0, 0, 0, SWP_NOMOVE or SWP_NOSIZE);
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
  TStringGrid(Sender).Canvas.FillRect(Rect);
  DrawText(TStringGrid(Sender).Canvas.Handle, PChar(TStringGrid(Sender).Cells[ACol, ARow]), Length(TStringGrid(Sender).Cells[ACol, ARow]), Rect, DT_CENTER or DT_SINGLELINE or DT_VCENTER);
  if (gdSelected in State) then
  begin
    format := [tfSingleLine, tfVerticalCenter, tfCenter];
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
  if (Length(TStringGrid(Sender).Cells[ACol, ARow]) * (TStringGrid(Sender).Font.SIZE) > TStringGrid(Sender).ColWidths[ACol]) then
  begin
    TStringGrid(Sender).ColWidths[ACol] := Length(TStringGrid(Sender).Cells[ACol, ARow]) * (TStringGrid(Sender).Font.SIZE)
  end;
end;

procedure TConfigForm.SaveButtonClick(Sender: TObject);
var
  RootNode: IXMLNode;
begin
  tmpDefaultIndex[ComboBox2.ItemIndex][0] := QuotationAddrGrid.Row;
  tmpDefaultIndex[ComboBox2.ItemIndex][1] := TradeGrid.Row;
  tmpDefaultIndex[ComboBox2.ItemIndex][2] := AccountGrid.Row;

  DefaultFutureQuotationServerIndex := tmpDefaultIndex[0][0];
  DefaultFutureTradeServerIndex := tmpDefaultIndex[0][1];
  DefaultFuturesAccountIndex := tmpDefaultIndex[0][2];

  DefaultOptionQuotationServerIndex := tmpDefaultIndex[1][0];
  DefaultOptionTradeServerIndex := tmpDefaultIndex[1][1];
  DefaultOptionAccountIndex := tmpDefaultIndex[1][2];

  DefaultActualsQuotationServerIndex := tmpDefaultIndex[2][0];
  DefaultActualsTradeServerIndex := tmpDefaultIndex[2][1];
  DefaultActualsAccountIndex := tmpDefaultIndex[2][2];

  LoginForm.RefreshView();
  QuotationChangeForm.RefreshView();
  ConfigForm.Visible := False;

  iXMLAreaFile.active := True;
  RootNode := iXMLAreaFile.DocumentElement;

  RootNode.ChildNodes['account'].ChildNodes['FuturesAccount'].Attributes['Default'] := DefaultFuturesAccountIndex;
  RootNode.ChildNodes['quotation'].ChildNodes['FuturesServer'].Attributes['Default'] := DefaultFutureQuotationServerIndex;
  RootNode.ChildNodes['trade'].ChildNodes['FuturesServer'].Attributes['Default'] := DefaultFutureTradeServerIndex;

  RootNode.ChildNodes['account'].ChildNodes['OptionAccount'].Attributes['Default'] := DefaultOptionAccountIndex;
  RootNode.ChildNodes['quotation'].ChildNodes['OptionServer'].Attributes['Default'] := DefaultOptionQuotationServerIndex;
  RootNode.ChildNodes['trade'].ChildNodes['OptionServer'].Attributes['Default'] := DefaultOptionTradeServerIndex;

  RootNode.ChildNodes['account'].ChildNodes['ActualsAccount'].Attributes['Default'] := DefaultActualsAccountIndex;
  RootNode.ChildNodes['quotation'].ChildNodes['ActualsServer'].Attributes['Default'] := DefaultActualsQuotationServerIndex;
  RootNode.ChildNodes['trade'].ChildNodes['ActualsServer'].Attributes['Default'] := DefaultActualsTradeServerIndex;

  iXMLAreaFile.SaveToFile(ExtractFilePath(application.exename) + 'config\config.xml');
end;

end.

