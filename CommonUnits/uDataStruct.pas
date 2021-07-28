unit uDataStruct;
(*
  �����õ������ݽṹ
*)

interface

uses
  Classes, Series;

type
  {������������ͺ���������ݽṹ}
  {ӳ��C++ʱ��array��0..8 ��Ӧ����C++��9����Ϊ0Ҳ���ȥ��}
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

  TThostFtdcBrokerIDType = array[0..10] of Char;

  TThostFtdcUserIDType = array[0..15] of Char;

  TThostFtdcInvestorIDType = array[0..12] of Char;

  TThostFtdcPosiDirectionType = Char;

  TThostFtdcHedgeFlagType = Char;

  TThostFtdcPositionDateType = Char;

  TThostFtdcSettlementIDType = Integer;

  TThostFtdcInvestUnitIDType = array[0..16] of Char;

  TThostFtdcOrderRefType = array[0..12] of Char;

  TThostFtdcTradeIDType = array[0..20] of Char;

  TThostFtdcDirectionType = Char;

  TThostFtdcOrderSysIDType = array[0..20] of Char;

  TThostFtdcParticipantIDType = array[0..10] of Char;

  TThostFtdcClientIDType = array[0..10] of Char;

  TThostFtdcTradingRoleType = Char;

  TThostFtdcOffsetFlagType = Char;

  TThostFtdcTradeTypeType = Char;

  TThostFtdcPriceSourceType = Char;

  TThostFtdcTraderIDType = array[0..20] of Char;

  TThostFtdcSequenceNoType = Integer;

  TThostFtdcOrderLocalIDType = array[0..12] of Char;

  TThostFtdcBusinessUnitType = array[0..20] of Char;

  TThostFtdcTradeSourceType = Char;

  TThostFtdcOrderPriceTypeType = Char;

  TThostFtdcCombOffsetFlagType = array[0..4] of Char;

  TThostFtdcCombHedgeFlagType = array[0..4] of Char;

  TThostFtdcTimeConditionType = Char;

  TThostFtdcVolumeConditionType = Char;

  TThostFtdcContingentConditionType = Char;

  TThostFtdcForceCloseReasonType = Char;

  TThostFtdcBoolType = Integer;

  TThostFtdcRequestIDType = Integer;

  TThostFtdcInstallIDType = Integer;

  TThostFtdcOrderSubmitStatusType = Char;

  TThostFtdcOrderSourceType = Char;

  TThostFtdcOrderStatusType = Char;

  TThostFtdcOrderTypeType = Char;

  TThostFtdcFrontIDType = Integer;

  TThostFtdcSessionIDType = Integer;

  TThostFtdcProductInfoType = array[0..10] of Char;

  TThostFtdcErrorMsgType = array[0..80] of Char;

  TThostFtdcBranchIDType = array[0..8] of Char;

  TThostFtdcAccountIDType = array[0..12] of Char;

  TThostFtdcCurrencyIDType = array[0..3] of Char;

  TThostFtdcIPAddressType = array[0..15] of Char;

  TThostFtdcMacAddressType = array[0..20] of Char;

  TThostFtdcBizTypeType = Char;

  //Ͷ���ֲ߳�
  CThostFtdcInvestorPositionField = record
    InstrumentID: TThostFtdcInstrumentIDType;
  	///���͹�˾����
    BrokerID: TThostFtdcBrokerIDType;
  	///Ͷ���ߴ���
    InvestorID: TThostFtdcInvestorIDType;
  	///�ֲֶ�շ���
    PosiDirection: TThostFtdcPosiDirectionType;
  	///Ͷ���ױ���־
    HedgeFlag: TThostFtdcHedgeFlagType;
  	///�ֲ�����
    PositionDate: TThostFtdcPositionDateType;
  	///���ճֲ�
    YdPosition: TThostFtdcVolumeType;
  	///���ճֲ�
    Position: TThostFtdcVolumeType;
  	///��ͷ����
    LongFrozen: TThostFtdcVolumeType;
  	///��ͷ����
    ShortFrozen: TThostFtdcVolumeType;
  	///���ֶ�����
    LongFrozenAmount: TThostFtdcMoneyType;
  	///���ֶ�����
    ShortFrozenAmount: TThostFtdcMoneyType;
  	///������
    OpenVolume: TThostFtdcVolumeType;
  	///ƽ����
    CloseVolume: TThostFtdcVolumeType;
  	///���ֽ��
    OpenAmount: TThostFtdcMoneyType;
  	///ƽ�ֽ��
    CloseAmount: TThostFtdcMoneyType;
  	///�ֲֳɱ�
    PositionCost: TThostFtdcMoneyType;
  	///�ϴ�ռ�õı�֤��
    PreMargin: TThostFtdcMoneyType;
  	///ռ�õı�֤��
    UseMargin: TThostFtdcMoneyType;
  	///����ı�֤��
    FrozenMargin: TThostFtdcMoneyType;
  	///������ʽ�
    FrozenCash: TThostFtdcMoneyType;
  	///�����������
    FrozenCommission: TThostFtdcMoneyType;
  	///�ʽ���
    CashIn: TThostFtdcMoneyType;
  	///������
    Commission: TThostFtdcMoneyType;
  	///ƽ��ӯ��
    CloseProfit: TThostFtdcMoneyType;
  	///�ֲ�ӯ��
    PositionProfit: TThostFtdcMoneyType;
  	///�ϴν����
    PreSettlementPrice: TThostFtdcPriceType;
  	///���ν����
    SettlementPrice: TThostFtdcPriceType;
  	///������
    TradingDay: TThostFtdcDateType;
  	///������
    SettlementID: TThostFtdcSettlementIDType;
  	///���ֳɱ�
    OpenCost: TThostFtdcMoneyType;
  	///��������֤��
    ExchangeMargin: TThostFtdcMoneyType;
  	///��ϳɽ��γɵĳֲ�
    CombPosition: TThostFtdcVolumeType;
  	///��϶�ͷ����
    CombLongFrozen: TThostFtdcVolumeType;
  	///��Ͽ�ͷ����
    CombShortFrozen: TThostFtdcVolumeType;
  	///���ն���ƽ��ӯ��
    CloseProfitByDate: TThostFtdcMoneyType;
  	///��ʶԳ�ƽ��ӯ��
    CloseProfitByTrade: TThostFtdcMoneyType;
  	///���ճֲ�
    TodayPosition: TThostFtdcVolumeType;
  	///��֤����
    MarginRateByMoney: TThostFtdcRatioType;
  	///��֤����(������)
    MarginRateByVolume: TThostFtdcRatioType;
  	///ִ�ж���
    StrikeFrozen: TThostFtdcVolumeType;
  	///ִ�ж�����
    StrikeFrozenAmount: TThostFtdcMoneyType;
  	///����ִ�ж���
    AbandonFrozen: TThostFtdcVolumeType;
  	///����������
    ExchangeID: TThostFtdcExchangeIDType;
  	///ִ�ж�������
    YdStrikeFrozen: TThostFtdcVolumeType;
  	///Ͷ�ʵ�Ԫ����
    InvestUnitID: TThostFtdcInvestUnitIDType;
  	///�������ֲֳɱ���ֵ��ֻ�д�����ʹ��
    PositionCostOffset: TThostFtdcMoneyType;
  	///tas�ֲ�����
    TasPosition: TThostFtdcVolumeType;
  	///tas�ֲֳɱ�
    TasPositionCost: TThostFtdcMoneyType;
  end;

  //�ɽ�
  CThostFtdcTradeField = record
  	///���͹�˾����
    BrokerID: TThostFtdcBrokerIDType;
  	///Ͷ���ߴ���
    InvestorID: TThostFtdcInvestorIDType;
  	///��Լ����
    InstrumentID: TThostFtdcInstrumentIDType;
  	///��������
    OrderRef: TThostFtdcOrderRefType;
  	///�û�����
    UserID: TThostFtdcUserIDType;
  	///����������
    ExchangeID: TThostFtdcExchangeIDType;
  	///�ɽ����
    TradeID: TThostFtdcTradeIDType;
  	///��������
    Direction: TThostFtdcDirectionType;
  	///�������
    OrderSysID: TThostFtdcOrderSysIDType;
  	///��Ա����
    ParticipantID: TThostFtdcParticipantIDType;
  	///�ͻ�����
    ClientID: TThostFtdcClientIDType;
  	///���׽�ɫ
    TradingRole: TThostFtdcTradingRoleType;
  	///��Լ�ڽ������Ĵ���
    ExchangeInstID: TThostFtdcExchangeInstIDType;
  	///��ƽ��־
    OffsetFlag: TThostFtdcOffsetFlagType;
  	///Ͷ���ױ���־
    HedgeFlag: TThostFtdcHedgeFlagType;
  	///�۸�
    Price: TThostFtdcPriceType;
  	///����
    Volume: TThostFtdcVolumeType;
  	///�ɽ�ʱ��
    TradeDate: TThostFtdcDateType;
  	///�ɽ�ʱ��
    TradeTime: TThostFtdcTimeType;
  	///�ɽ�����
    TradeType: TThostFtdcTradeTypeType;
  	///�ɽ�����Դ
    PriceSource: TThostFtdcPriceSourceType;
  	///����������Ա����
    TraderID: TThostFtdcTraderIDType;
  	///���ر������
    OrderLocalID: TThostFtdcOrderLocalIDType;
  	///�����Ա���
    ClearingPartID: TThostFtdcParticipantIDType;
  	///ҵ��Ԫ
    BusinessUnit: TThostFtdcBusinessUnitType;
  	///���
    SequenceNo: TThostFtdcSequenceNoType;
  	///������
    TradingDay: TThostFtdcDateType;
  	///������
    SettlementID: TThostFtdcSettlementIDType;
  	///���͹�˾�������
    BrokerOrderSeq: TThostFtdcSequenceNoType;
  	///�ɽ���Դ
    TradeSource: TThostFtdcTradeSourceType;
  	///Ͷ�ʵ�Ԫ����
    InvestUnitID: TThostFtdcInvestUnitIDType;
  end;

  //����
  CThostFtdcOrderField = record
  	///���͹�˾����
    BrokerID: TThostFtdcBrokerIDType;
  	///Ͷ���ߴ���
    InvestorID: TThostFtdcInvestorIDType;
  	///��Լ����
    InstrumentID: TThostFtdcInstrumentIDType;
  	///��������
    OrderRef: TThostFtdcOrderRefType;
  	///�û�����
    UserID: TThostFtdcUserIDType;
  	///�����۸�����
    OrderPriceType: TThostFtdcOrderPriceTypeType;
  	///��������
    Direction: TThostFtdcDirectionType;
  	///��Ͽ�ƽ��־
    CombOffsetFlag: TThostFtdcCombOffsetFlagType;
  	///���Ͷ���ױ���־
    CombHedgeFlag: TThostFtdcCombHedgeFlagType;
  	///�۸�
    LimitPrice: TThostFtdcPriceType;
  	///����
    VolumeTotalOriginal: TThostFtdcVolumeType;
  	///��Ч������
    TimeCondition: TThostFtdcTimeConditionType;
  	///GTD����
    GTDDate: TThostFtdcDateType;
  	///�ɽ�������
    VolumeCondition: TThostFtdcVolumeConditionType;
  	///��С�ɽ���
    MinVolume: TThostFtdcVolumeType;
  	///��������
    ContingentCondition: TThostFtdcContingentConditionType;
  	///ֹ���
    StopPrice: TThostFtdcPriceType;
  	///ǿƽԭ��
    ForceCloseReason: TThostFtdcForceCloseReasonType;
  	///�Զ������־
    IsAutoSuspend: TThostFtdcBoolType;
  	///ҵ��Ԫ
    BusinessUnit: TThostFtdcBusinessUnitType;
  	///������
    RequestID: TThostFtdcRequestIDType;
  	///���ر������
    OrderLocalID: TThostFtdcOrderLocalIDType;
  	///����������
    ExchangeID: TThostFtdcExchangeIDType;
  	///��Ա����
    ParticipantID: TThostFtdcParticipantIDType;
  	///�ͻ�����
    ClientID: TThostFtdcClientIDType;
  	///��Լ�ڽ������Ĵ���
    ExchangeInstID: TThostFtdcExchangeInstIDType;
  	///����������Ա����
    TraderID: TThostFtdcTraderIDType;
  	///��װ���
    InstallID: TThostFtdcInstallIDType;
  	///�����ύ״̬
    OrderSubmitStatus: TThostFtdcOrderSubmitStatusType;
  	///������ʾ���
    NotifySequence: TThostFtdcSequenceNoType;
  	///������
    TradingDay: TThostFtdcDateType;
  	///������
    SettlementID: TThostFtdcSettlementIDType;
  	///�������
    OrderSysID: TThostFtdcOrderSysIDType;
  	///������Դ
    OrderSource: TThostFtdcOrderSourceType;
  	///����״̬
    OrderStatus: TThostFtdcOrderStatusType;
  	///��������
    OrderType: TThostFtdcOrderTypeType;
  	///��ɽ�����
    VolumeTraded: TThostFtdcVolumeType;
  	///ʣ������
    VolumeTotal: TThostFtdcVolumeType;
  	///��������
    InsertDate: TThostFtdcDateType;
  	///ί��ʱ��
    InsertTime: TThostFtdcTimeType;
  	///����ʱ��
    ActiveTime: TThostFtdcTimeType;
  	///����ʱ��
    SuspendTime: TThostFtdcTimeType;
  	///����޸�ʱ��
    UpdateTime: TThostFtdcTimeType;
  	///����ʱ��
    CancelTime: TThostFtdcTimeType;
  	///����޸Ľ���������Ա����
    ActiveTraderID: TThostFtdcTraderIDType;
  	///�����Ա���
    ClearingPartID: TThostFtdcParticipantIDType;
  	///���
    SequenceNo: TThostFtdcSequenceNoType;
  	///ǰ�ñ��
    FrontID: TThostFtdcFrontIDType;
  	///�Ự���
    SessionID: TThostFtdcSessionIDType;
  	///�û��˲�Ʒ��Ϣ
    UserProductInfo: TThostFtdcProductInfoType;
  	///״̬��Ϣ
    StatusMsg: TThostFtdcErrorMsgType;
  	///�û�ǿ����־
    UserForceClose: TThostFtdcBoolType;
  	///�����û�����
    ActiveUserID: TThostFtdcUserIDType;
  	///���͹�˾�������
    BrokerOrderSeq: TThostFtdcSequenceNoType;
  	///��ر���
    RelativeOrderSysID: TThostFtdcOrderSysIDType;
  	///֣�����ɽ�����
    ZCETotalTradedVolume: TThostFtdcVolumeType;
  	///��������־
    IsSwapOrder: TThostFtdcBoolType;
  	///Ӫҵ�����
    BranchID: TThostFtdcBranchIDType;
  	///Ͷ�ʵ�Ԫ����
    InvestUnitID: TThostFtdcInvestUnitIDType;
  	///�ʽ��˺�
    AccountID: TThostFtdcAccountIDType;
  	///���ִ���
    CurrencyID: TThostFtdcCurrencyIDType;
  	///IP��ַ
    IPAddress: TThostFtdcIPAddressType;
  	///Mac��ַ
    MacAddress: TThostFtdcMacAddressType;
  end;

  //�ʽ��˻�
  CThostFtdcTradingAccountField = record
  	///���͹�˾����
    BrokerID: TThostFtdcBrokerIDType;
  	///Ͷ�����ʺ�
    AccountID: TThostFtdcAccountIDType;
  	///�ϴ���Ѻ���
    PreMortgage: TThostFtdcMoneyType;
  	///�ϴ����ö��
    PreCredit: TThostFtdcMoneyType;
  	///�ϴδ���
    PreDeposit: TThostFtdcMoneyType;
  	///�ϴν���׼����
    PreBalance: TThostFtdcMoneyType;
  	///�ϴ�ռ�õı�֤��
    PreMargin: TThostFtdcMoneyType;
  	///��Ϣ����
    InterestBase: TThostFtdcMoneyType;
  	///��Ϣ����
    Interest: TThostFtdcMoneyType;
  	///�����
    Deposit: TThostFtdcMoneyType;
  	///������
    Withdraw: TThostFtdcMoneyType;
  	///����ı�֤��
    FrozenMargin: TThostFtdcMoneyType;
  	///������ʽ�
    FrozenCash: TThostFtdcMoneyType;
  	///�����������
    FrozenCommission: TThostFtdcMoneyType;
  	///��ǰ��֤���ܶ�
    CurrMargin: TThostFtdcMoneyType;
  	///�ʽ���
    CashIn: TThostFtdcMoneyType;
  	///������
    Commission: TThostFtdcMoneyType;
  	///ƽ��ӯ��
    CloseProfit: TThostFtdcMoneyType;
  	///�ֲ�ӯ��
    PositionProfit: TThostFtdcMoneyType;
  	///�ڻ�����׼����
    Balance: TThostFtdcMoneyType;
  	///�����ʽ�
    Available: TThostFtdcMoneyType;
  	///��ȡ�ʽ�
    WithdrawQuota: TThostFtdcMoneyType;
  	///����׼����
    Reserve: TThostFtdcMoneyType;
  	///������
    TradingDay: TThostFtdcDateType;
  	///������
    SettlementID: TThostFtdcSettlementIDType;
  	///���ö��
    Credit: TThostFtdcMoneyType;
  	///��Ѻ���
    Mortgage: TThostFtdcMoneyType;
  	///��������֤��
    ExchangeMargin: TThostFtdcMoneyType;
  	///Ͷ���߽��֤��
    DeliveryMargin: TThostFtdcMoneyType;
  	///���������֤��
    ExchangeDeliveryMargin: TThostFtdcMoneyType;
  	///�����ڻ�����׼����
    ReserveBalance: TThostFtdcMoneyType;
  	///���ִ���
    CurrencyID: TThostFtdcCurrencyIDType;
  	///�ϴλ���������
    PreFundMortgageIn: TThostFtdcMoneyType;
  	///�ϴλ����ʳ����
    PreFundMortgageOut: TThostFtdcMoneyType;
  	///����������
    FundMortgageIn: TThostFtdcMoneyType;
  	///�����ʳ����
    FundMortgageOut: TThostFtdcMoneyType;
  	///������Ѻ���
    FundMortgageAvailable: TThostFtdcMoneyType;
  	///����Ѻ���ҽ��
    MortgageableFund: TThostFtdcMoneyType;
  	///�����Ʒռ�ñ�֤��
    SpecProductMargin: TThostFtdcMoneyType;
  	///�����Ʒ���ᱣ֤��
    SpecProductFrozenMargin: TThostFtdcMoneyType;
  	///�����Ʒ������
    SpecProductCommission: TThostFtdcMoneyType;
  	///�����Ʒ����������
    SpecProductFrozenCommission: TThostFtdcMoneyType;
  	///�����Ʒ�ֲ�ӯ��
    SpecProductPositionProfit: TThostFtdcMoneyType;
  	///�����Ʒƽ��ӯ��
    SpecProductCloseProfit: TThostFtdcMoneyType;
  	///���ݳֲ�ӯ���㷨����������Ʒ�ֲ�ӯ��
    SpecProductPositionProfitByAlg: TThostFtdcMoneyType;
  	///�����Ʒ��������֤��
    SpecProductExchangeMargin: TThostFtdcMoneyType;
  	///ҵ������
    BizType: TThostFtdcBizTypeType;
  	///��ʱ���㶳����
    FrozenSwap: TThostFtdcMoneyType;
  	///ʣ�໻����
    RemainSwap: TThostFtdcMoneyType;
  end;

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

  //����ͼ-����
  ThreeSeriesChart = record
    ValueSeries1: TFastLineSeries;
    ValueSeries2: TFastLineSeries;
    ConstantSeries: TFastLineSeries;
  end;

implementation

end.
