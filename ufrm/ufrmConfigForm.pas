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
    0:      //�ڻ�
      begin
      //����
        QuotationAddrGrid.RowCount := FutureQuotationServerList.Count;
        for I := 0 to FutureQuotationServerList.Count - 1 do
        begin
          QuotationAddrGrid.Rows[I].Clear;
          tmp := PQuotationServerStruct(FutureQuotationServerList.Objects[I]);
          datalist.DelimitedText := ' ,' + PQuotationServerStruct(tmp).sName + ',' + PQuotationServerStruct(tmp).sServer;
          QuotationAddrGrid.Rows[I] := datalist;
        end;
        QuotationAddrGrid.Row := DefaultFutureQuotationServerIndex;
        //����
        TradeGrid.RowCount := FutureTradeServerList.Count;
        for I := 0 to FutureTradeServerList.Count - 1 do
        begin
          TradeGrid.Rows[I].Clear;
          tmp := PTradeServerStruct(FutureTradeServerList.Objects[I]);
          datalist.DelimitedText := ' ,' + PTradeServerStruct(tmp).sName + ',' + PTradeServerStruct(tmp).sServer + ',' + PTradeServerStruct(tmp).sBrokerID;
          TradeGrid.Rows[I] := datalist;
        end;
        TradeGrid.Row := DefaultFutureTradeServerIndex;
        //�˻�
        AccountGrid.RowCount := AccountList.Count;
        for I := 0 to AccountList.Count - 1 do
        begin
          AccountGrid.Rows[I].Clear;
          tmp := PAccountStruct(AccountList.Objects[I]);
          datalist.DelimitedText := ' ,' + PAccountStruct(tmp).sName + ',' + PAccountStruct(tmp).sAccount + ',' + PAccountStruct(tmp).sAuthCode + ',' + PAccountStruct(tmp).sAppid;
          AccountGrid.Rows[I] := datalist;
        end;
        AccountGrid.Row := DefaultAccountIndex;
      end;
    1:      //��Ȩ
      begin
        //����
        QuotationAddrGrid.RowCount := OptionQuotationServerList.Count;
        for I := 0 to OptionQuotationServerList.Count - 1 do
        begin
          tmp := PQuotationServerStruct(OptionQuotationServerList.Objects[I]);
          datalist.DelimitedText := ' ,' + PQuotationServerStruct(tmp).sName + ',' + PQuotationServerStruct(tmp).sServer + ',' + PQuotationServerStruct(tmp).iPort + ',' + PQuotationServerStruct(tmp).sAccount + ',' + PQuotationServerStruct(tmp).sPassword;
          QuotationAddrGrid.Rows[I] := datalist;
        end;
        QuotationAddrGrid.Row := DefaultFutureQuotationServerIndex;
      end;
    2:      //�ֻ�
      begin

      end;
  end;
end;

procedure TConfigForm.FormShow(Sender: TObject);
var
  datalist: TStrings;
  I: Integer;
  tmp: Pointer;
begin
  datalist := TStringList.Create;
  //��������ʼ��
  QuotationAddrGrid.RowCount := FutureQuotationServerList.Count;
//  QuotationAddrGrid.DefaultColWidth := (PageControl1.Width div 2) - 40;
  QuotationAddrGrid.ColWidths[0] := 50;

  //�ڻ��������õ���
  for I := 0 to FutureQuotationServerList.Count - 1 do
  begin
    tmp := PQuotationServerStruct(FutureQuotationServerList.Objects[I]);
    datalist.DelimitedText := ' ,' + PQuotationServerStruct(tmp).sName + ',' + PQuotationServerStruct(tmp).sServer;
    QuotationAddrGrid.Rows[I] := datalist;
  end;
  QuotationAddrGrid.Row := DefaultFutureQuotationServerIndex;
  //�����ڻ������ʼ��
  TradeGrid.RowCount := FutureTradeServerList.Count;
//  TradeGrid.DefaultColWidth := (PageControl1.Width div 3) - 30;
  TradeGrid.ColWidths[0] := 50;
  //�ڻ��������õ���
  for I := 0 to FutureTradeServerList.Count - 1 do
  begin
    tmp := PTradeServerStruct(FutureTradeServerList.Objects[I]);
    datalist.DelimitedText := ' ,' + PTradeServerStruct(tmp).sName + ',' + PTradeServerStruct(tmp).sServer + ',' + PTradeServerStruct(tmp).sBrokerID;
    TradeGrid.Rows[I] := datalist;
  end;
  TradeGrid.Row := DefaultFutureTradeServerIndex;

  //�˻����ڻ��������ʼ��
  AccountGrid.RowCount := AccountList.Count;
//  AccountGrid.DefaultColWidth := (PageControl1.Width div 4) - 30;
  AccountGrid.ColWidths[0] := 50;
  //�˻����ڻ������õ���
  for I := 0 to AccountList.Count - 1 do
  begin
    tmp := PAccountStruct(AccountList.Objects[I]);
    datalist.DelimitedText := ' ,' + PAccountStruct(tmp).sName + ',' + PAccountStruct(tmp).sAccount + ',' + PAccountStruct(tmp).sAuthCode + ',' + PAccountStruct(tmp).sAppid;
    AccountGrid.Rows[I] := datalist;
  end;
  AccountGrid.Row := DefaultAccountIndex;


//
//  datalist.DelimitedText := ' ,Simnow[����],tcp://180.168.146.187:10211';
//  QuotationAddrGrid.Rows[0] := datalist;
//  datalist.DelimitedText := ' ,Simnow[7x24],tcp://180.168.146.187:10131';
//  QuotationAddrGrid.Rows[1] := datalist;
//  datalist.DelimitedText := ' ,�ϻ��ڻ�����,tcp://218.202.237.33:10213';
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
  DefaultFutureQuotationServerIndex := QuotationAddrGrid.Row;
  DefaultFutureTradeServerIndex := TradeGrid.Row;
  DefaultAccountIndex := AccountGrid.Row;
  LoginForm.RefreshView();
  QuotationChangeForm.RefreshView();
  ConfigForm.Visible := False;

  iXMLAreaFile.active := True;
  RootNode := iXMLAreaFile.DocumentElement;

  RootNode.ChildNodes['account'].ChildNodes['FuturesAccount'].Attributes['Default'] := DefaultAccountIndex;
  RootNode.ChildNodes['quotation'].ChildNodes['FuturesServer'].Attributes['Default'] := DefaultFutureQuotationServerIndex;
  RootNode.ChildNodes['trade'].ChildNodes['FuturesServer'].Attributes['Default'] := DefaultFutureTradeServerIndex;
  iXMLAreaFile.SaveToFile(ExtractFilePath(application.exename) + 'config\config.xml');
end;

end.
