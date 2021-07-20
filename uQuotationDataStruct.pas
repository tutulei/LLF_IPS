unit uQuotationDataStruct;
(*
  ���ݽṹ
*)
interface

uses
  Classes;

type
  {������������ͺ���������ݽṹ}
  pQuotationData = ^TQuotationData;

  TThostFtdcDateType = array[0..8] of Char;

  TThostFtdcInstrumentIDType = array[0..30] of Char;

  TThostFtdcExchangeIDType = array[0..8] of Char;

  TThostFtdcExchangeInstIDType = array[0..30] of Char;

  TThostFtdcPriceType = double;

  TThostFtdcLargeVolumeType = double;

  TThostFtdcVolumeType = Integer;

  TThostFtdcMoneyType = Double;

  TThostFtdcRatioType = Double;

  TThostFtdcTimeType = array[0..8] of Char;

  TThostFtdcMillisecType = Integer;

  TQuotationData = record
    ///������
    TradingDay: TThostFtdcDateType;
  	///��Լ����
    InstrumentID: TThostFtdcInstrumentIDType;
  	///����������
    ExchangeID: TThostFtdcExchangeIDType;
  	///��Լ�ڽ������Ĵ���
    ExchangeInstID: TThostFtdcExchangeInstIDType;
  	///���¼�
    LastPrice: TThostFtdcPriceType;
  	///�ϴν����
    PreSettlementPrice: TThostFtdcPriceType;
  	///������
    PreClosePrice: TThostFtdcPriceType;
  	///��ֲ���
    PreOpenInterest: TThostFtdcLargeVolumeType;
  	///����
    OpenPrice: TThostFtdcPriceType;
  	///��߼�
    HighestPrice: TThostFtdcPriceType;
  	///��ͼ�
    LowestPrice: TThostFtdcPriceType;
  	///����
    Volume: TThostFtdcVolumeType;
  	///�ɽ����
    Turnover: TThostFtdcMoneyType;
  	///�ֲ���
    OpenInterest: TThostFtdcLargeVolumeType;
  	///������
    ClosePrice: TThostFtdcPriceType;
  	///���ν����
    SettlementPrice: TThostFtdcPriceType;
  	///��ͣ���
    UpperLimitPrice: TThostFtdcPriceType;
  	///��ͣ���
    LowerLimitPrice: TThostFtdcPriceType;
  	///����ʵ��
    PreDelta: TThostFtdcRatioType;
  	///����ʵ��
    CurrDelta: TThostFtdcRatioType;
  	///����޸�ʱ��
    UpdateTime: TThostFtdcTimeType;
  	///����޸ĺ���
    UpdateMillisec: TThostFtdcMillisecType;
  	///�����һ
    BidPrice1: TThostFtdcPriceType;
  	///������һ
    BidVolume1: TThostFtdcVolumeType;
  	///������һ
    AskPrice1: TThostFtdcPriceType;
  	///������һ
    AskVolume1: TThostFtdcVolumeType;
  	///����۶�
    BidPrice2: TThostFtdcPriceType;
  	///��������
    BidVolume2: TThostFtdcVolumeType;
  	///�����۶�
    AskPrice2: TThostFtdcPriceType;
  	///��������
    AskVolume2: TThostFtdcVolumeType;
  	///�������
    BidPrice3: TThostFtdcPriceType;
  	///��������
    BidVolume3: TThostFtdcVolumeType;
  	///��������
    AskPrice3: TThostFtdcPriceType;
  	///��������
    AskVolume3: TThostFtdcVolumeType;
  	///�������
    BidPrice4: TThostFtdcPriceType;
  	///��������
    BidVolume4: TThostFtdcVolumeType;
  	///��������
    AskPrice4: TThostFtdcPriceType;
  	///��������
    AskVolume4: TThostFtdcVolumeType;
  	///�������
    BidPrice5: TThostFtdcPriceType;
  	///��������
    BidVolume5: TThostFtdcVolumeType;
  	///��������
    AskPrice5: TThostFtdcPriceType;
  	///��������
    AskVolume5: TThostFtdcVolumeType;
  	///���վ���
    AveragePrice: TThostFtdcPriceType;
  	///ҵ������
    ActionDay: TThostFtdcDateType;
  end;

//  rQuotationData = record
//    ///������
//    TradingDay: string;
//  	///��Լ����
//    InstrumentID: string;
//  	///����������
//    ExchangeID: string;
//  	///��Լ�ڽ������Ĵ���
//    ExchangeInstID: string;
//  	///���¼�
//    LastPrice: Double;
//  	///�ϴν����
//    PreSettlementPrice: Double;
//  	///������
//    PreClosePrice: Double;
//  	///��ֲ���
//    PreOpenInterest: Double;
//  	///����
//    OpenPrice: Double;
//  	///��߼�
//    HighestPrice: Double;
//  	///��ͼ�
//    LowestPrice: Double;
//  	///����
//    Volume: Integer;
//  	///�ɽ����
//    Turnover: Double;
//  	///�ֲ���
//    OpenInterest: Double;
//  	///������
//    ClosePrice: Double;
//  	///���ν����
//    SettlementPrice: Double;
//  	///��ͣ���
//    UpperLimitPrice: Double;
//  	///��ͣ���
//    LowerLimitPrice: Double;
//  	///����ʵ��
//    PreDelta: Double;
//  	///����ʵ��
//    CurrDelta: Double;
//  	///����޸�ʱ��
//    UpdateTime: string;
//  	///����޸ĺ���
//    UpdateMillisec: Integer;
//  	///�����һ
//    BidPrice1: Double;
//  	///������һ
//    BidVolume1: Integer;
//  	///������һ
//    AskPrice1: Double;
//  	///������һ
//    AskVolume1: Integer;
//  	///����۶�
//    BidPrice2: Double;
//  	///��������
//    BidVolume2: Integer;
//  	///�����۶�
//    AskPrice2: Double;
//  	///��������
//    AskVolume2: Integer;
//  	///�������
//    BidPrice3: Double;
//  	///��������
//    BidVolume3: Integer;
//  	///��������
//    AskPrice3: Double;
//  	///��������
//    AskVolume3: Integer;
//  	///�������
//    BidPrice4: Double;
//  	///��������
//    BidVolume4: Integer;
//  	///��������
//    AskPrice4: Double;
//  	///��������
//    AskVolume4: Integer;
//  	///�������
//    BidPrice5: Double;
//  	///��������
//    BidVolume5: Integer;
//  	///��������
//    AskPrice5: Double;
//  	///��������
//    AskVolume5: Integer;
//  	///���վ���
//    AveragePrice: Double;
//  	///ҵ������
//    ActionDay: string;
//  end;

implementation

end.
