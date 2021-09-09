unit uDataStruct;
(*
  �����õ������ݽṹ
*)

interface

uses
  Classes, Series, uConstants;

type
  {������������ͺ���������ݽṹ}
  {ӳ��C++ʱ��array��0..8 ��Ӧ����C++��9����Ϊ0Ҳ���ȥ��}


{typedef}
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

  TThostFtdcOrderActionRefType = Integer;

  TThostFtdcActionFlagType = Char;

  TThostFtdcErrorIDType = Integer;

  TJGtdcClientIDType = array[0..15] of Char;

  TJGtdcFundAccountType = array[0..15] of Char;

  TJGtdcSupportSubType = Integer;

  TJGtdcResultType = Integer;

  TJGtdcErrorInfoType = array[0..127] of Char;

  TJGtdcEntrustNoType = array[0..23] of Char;

  TJGtdcBatchNoType = array[0..23] of Char;

  TJGtdcExchangeType = Integer;

  TJGtdcStockAccountType = array[0..15] of Char;

  TJGtdcContractNumber = array[0..15] of Char;

  TJGtdcTradeType = Integer;

  TJGtdcOffsetType = Char;

  TJGtdcCoveredType = Char;

  TJGtdcPriceType = Integer;

  TJGtdcOrderVolume = Int64;

  TJGtdcOrderPrice = Int64;

  TJGtdcNewEntrustNoType = array[0..23] of Char;

  TJGtdcBranchNoType = array[0..7] of Char;

  TJGtdcSeatNoType = array[0..31] of Char;

  TJGtdcContractCodeType = array[0..23] of Char;

  TJGtdcContractNameType = array[0..39] of Char;

  TJGtdcStockCodeType = array[0..23] of Char;

  TJGtdcStockNameType = array[0..23] of Char;

  TJGtdcPositionStrType = array[0..39] of Char;

  TJGtdcReportNoType = array[0..23] of Char;

  TJGtdcMoneyType = Char;

  TJGtdcEntrustStatus = Char;

  TJGtdcDate = Integer;

  TJGtdcTime = Integer;

  TJGtdcBuinessVolume = Int64;

  TJGtdcBusinessPrice = Int64;

  TJGtdcCancelVolume = Int64;

  TJGtdcBusinessBalance = Double;

  TJGtdcInvalidReason = array[0..63] of Char;

  TJGtdcBusinessNoType = array[0..23] of Char;

  TJGtdcBusinessStatus = Char;

  TJGtdcOptionType = Char;

  TJGtdcOptionHoldType = Char;

  TJGtdcOptionYDAmount = Int64;

  TJGtdcOptionAmount = Int64;

  TJGtdcEnableAmount = Int64;

  TJGtdcPossessAmount = Int64;

  TJGtdcFrozenAmount = Int64;

  TJGtdcUnFrozenAmount = Int64;

  TJGtdcTransitAmount = Int64;

  TJGtdcTodayOpenAmount = Int64;

  TJGtdcTodayPayoffAmount = Int64;

  TJGtdcPremiumBalance = double;

  TJGtdcBailBalance = Double;

  TJGtdcCostPrice = Int64;

  TJGtdcBuyCost = Double;

  TJGtdcOptionBalance = Double;

  TJGtdcHoldIncome = Double;

  TJGtdcPayoffIncome = Double;

  TJGtdcMainFlag = Char;

  TJGtdcEnableBalance = Double;

  TJGtdcFetchBalance = Double;

  TJGtdcFrozenBalance = Double;

  TJGtdcStockBalance = Double;

  TJGtdcFundBalance = Double;

  TJGtdcAssetBalance = double;

  TJGtdcIncome = double;

  TJGtdcEnableBail = Double;

  TJGtdcUsedBail = Double;

  TJGtdcAgreeAssureRatio = Double;

  TJGtdcRiskRatio = Double;

  TJGtdcRiskRatio1 = double;

  TJGtdcServiceType = Integer;

  TJGtdcYdAmount = Int64;

  TJGtdcStockAmount = Int64;

  TJGtdcPurchaseAmount = Int64;

  TJGtdcYStoreAmount = Int64;

  TJGtdcKeepCostPrice = Int64;

  TJGtdcFloatIncome = Double;

  TJGtdcProIncome = Double;

  TJGtdcEnableBalanceHK = Double;
  {CTP�ڻ�������ݽṹ}
  //Ͷ���ֲ߳�

  PThostFtdcInvestorPositionField = ^CThostFtdcInvestorPositionField;

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
  PThostFtdcTradeField = ^CThostFtdcTradeField;

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
  PThostFtdcOrderField = ^CThostFtdcOrderField;

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
  PThostFtdcTradingAccountField = ^CThostFtdcTradingAccountField;

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


  //���뱨��
  PThostFtdcInputOrderField = ^CThostFtdcInputOrderField;

  CThostFtdcInputOrderField = record
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
  	///�û�ǿ����־
    UserForceClose: TThostFtdcBoolType;
  	///��������־
    IsSwapOrder: TThostFtdcBoolType;
  	///����������
    ExchangeID: TThostFtdcExchangeIDType;
  	///Ͷ�ʵ�Ԫ����
    InvestUnitID: TThostFtdcInvestUnitIDType;
  	///�ʽ��˺�
    AccountID: TThostFtdcAccountIDType;
  	///���ִ���
    CurrencyID: TThostFtdcCurrencyIDType;
  	///���ױ���
    ClientID: TThostFtdcClientIDType;
  	///IP��ַ
    IPAddress: TThostFtdcIPAddressType;
  	///Mac��ַ
    MacAddress: TThostFtdcMacAddressType;
  end;

  PThostFtdcInputOrderActionField = ^CThostFtdcInputOrderActionField;

  CThostFtdcInputOrderActionField = record
    BrokerID: TThostFtdcBrokerIDType;
  	///Ͷ���ߴ���
    InvestorID: TThostFtdcInvestorIDType;
  	///������������
    OrderActionRef: TThostFtdcOrderActionRefType;
  	///��������
    OrderRef: TThostFtdcOrderRefType;
  	///������
    RequestID: TThostFtdcRequestIDType;
  	///ǰ�ñ��
    FrontID: TThostFtdcFrontIDType;
  	///�Ự���
    SessionID: TThostFtdcSessionIDType;
  	///����������
    ExchangeID: TThostFtdcExchangeIDType;
  	///�������
    OrderSysID: TThostFtdcOrderSysIDType;
  	///������־
    ActionFlag: TThostFtdcActionFlagType;
  	///�۸�
    LimitPrice: TThostFtdcPriceType;
  	///�����仯
    VolumeChange: TThostFtdcVolumeType;
  	///�û�����
    UserID: TThostFtdcUserIDType;
  	///��Լ����
    InstrumentID: TThostFtdcInstrumentIDType;
  	///Ͷ�ʵ�Ԫ����
    InvestUnitID: TThostFtdcInvestUnitIDType;
  	///IP��ַ
    IPAddress: TThostFtdcIPAddressType;
  	///Mac��ַ
    MacAddress: TThostFtdcMacAddressType;
  end;

  PThostFtdcRspInfoField = ^CThostFtdcRspInfoField;

  CThostFtdcRspInfoField = record
  	///�������
    ErrorID: TThostFtdcErrorIDType;
  	///������Ϣ
    ErrorMsg: TThostFtdcErrorMsgType;
  end;


  {DF��Ȩ������ݽṹ}
  DF_HANDLE = Pointer;

  PDF_MsgHead = ^TDF_MsgHead;

  PDF_AppHead = ^TDF_AppHead;

  PDF_ReqMarkets = ^TDF_ReqMarkets;

  PDF_Heartbeat = ^TDF_Heartbeat;

  PDF_MarketLoginAnswer = ^TDF_MarketLoginAnswer;

  PDF_HeartbeatAns = ^TDF_HeartbeatAns;

  PDF_CodeTableHead = ^TDF_CodeTableHead;

  PDF_OptionBasicHead = ^TDF_OptionBasicHead;

  PDF_OptionBasicInfo = ^TDF_OptionBasicInfo;

  PDF_SubscriptionHead = ^TDF_SubscriptionHead;

  PDF_SubscriptionCode = ^TDF_SubscriptionCode;

  PDF_OptionMarketData = ^TDF_OptionMarketData;

  PDF_CodeInfo = ^TDF_CodeInfo;  
  {$A1+}

  ///��Ϣ��ͷ.

  TDF_MsgHead = record
    sFlags: Word;							///< �汾��ʶ��.
    nDataType: Integer;						///< ��������.
    nDataLen: Integer;   					///< ���ݳ���.
    nDate: Integer;							///< ����[YYYYMMDD].
    nTime: Integer;							///< ʱ���[��ȷ������HHMMSSmmm].
    iOrder: Int64;							///< ��ˮ��.
  end;
  
  ///Ӧ�ð�ͷ.
  TDF_AppHead = record
    nRequestID: Integer;						///< �����ʶ���������أ�.
    nAnsResult: Integer;						///< Ӧ����.
    szInfo: array[0..127] of Char;					///< ������Ϣ.
    nItemAmount: Integer;					///< ��¼������ ���5������.
    arrnAppItems: array[0..4] of Integer;					///< ���������ݵĸ���.
    arrnAppItemSize: array[0..4] of Integer;				///< ���������ݵĽṹ��С.
  end;
  
  ///���鶩��ͷ���ṹ��Ϣ.
  TDF_SubscriptionHead = record
    nSubscriptionType: Integer;				///< ����:[0-���� 1-���� 2-ɾ�� 3-ȡ�����ж���].		///< �ɲμ�  DF_SUB_TYPE .
    nItems: Integer;							///< ָʾ���ı��ձ����Ŀ.
  end;

  TDF_ReqMarkets = record
    nMarketID: Integer;						///< �г�����ID(DF_MARKET_TYPE).
    nFlags: Integer;							///< ��MARKET_FLAGS_����.
    nTime: Integer;							///< ����ָ��ʱ���ط����ݣ�ʱ���ʽ��HHMMSS���������������[�����г�����]���Զ�ʧЧ��.
  end;

  TDF_Heartbeat = record
    nBeatType: Integer;						///< �������ͣ�DF_HEARTBEAT_TYPE��.
    nBeatFrequency: Integer;					///< ����Ƶ�ʣ�nBeatTypeΪ1��2ʱ��Ч,���ʱ�䣨��),ֵ���Ʊ������3 С��1000��.
    nTimeOut: Integer;						///< ����ʱ��nBeatTypeΪ1��2ʱ��Ч,���ʱ�䣨��),ֵ���Ʊ������5,�Ҵ���nBeatFrequency��.
  end;
  
  ///�����¼����Ӧ��.
  TDF_MarketLoginAnswer = record
    szInfo: array[0..127] of Char;					///< Ӧ����Ϣ.
    szUserName: array[0..15] of Char;					///< �û��˺�.
    szPassword: array[0..15] of Char;					///< �û�����.
    nAnswerResult: Integer;					///< Ӧ���� 0��ʾ��¼�ɹ�,������ʾʧ��.
    nMarketAmount: Integer;					///< ��ǰ�ṩ�����г�����.
    arrnMarketID: array[0..MAX_MARKET_NUM - 1] of Integer;		///< �����г���־[ϵͳԤ��32���г�].
    arrnMarketDate: array[0..MAX_MARKET_NUM - 1] of Integer;	///< ��Ӧ�г���������[ϵͳԤ��32���г�].
  end;
  
  ///����Ӧ��.
  TDF_HeartbeatAns = record
    nTime: Integer;							///< Ӧ��ʱ��(HHMMSSmmm).
  end;
  
  
  ///��������б�������ͷ��.
  TDF_CodeTableHead = record
    nMarketID: Integer;						///< �г�����ID.
    nDate: Integer;							///< ����.
    nItems: Integer;							///< ������������.
  end;
  
  
  ///��Ȩ������ϢӦ��ͷ���ṹ��Ϣ.
  TDF_OptionBasicHead = record
    nMarketID: Integer;						///< �г���־ID(DF_MARKET_TYPE).
    nDate: Integer;							///< ������Ϣ����.
    nItems: Integer;							///< ������Ϣ����.
  end;
  
  ///���Ĵ������.
  TDF_SubscriptionCode = record
    szMarketFlag: array[0..3] of Char;					///< �г���־("SZS","SHS","CFF","SCE","ZCE","DCE","SHO","SZO"��
    szSymbol: array[0..23] of Char;					///< ����Ψһ��ʶ(��Ʊ����/�ڻ���Լ���״���/��Ȩ��Լ��Ȩ��Լ��).
  end;
  
  //��Ȩ������Ϣ
  TDF_OptionBasicInfo = record
    nDate: Integer;	///<	����.
    szSecurityID: array[0..15] of Char;	///<	��Լ����	C8	(��Ȩ��Լ�ĺ�Լ����).
    szContractID: array[0..23] of Char;	///<	��Լ���״���	C19.
    szContractSymbol: array[0..23] of Char;	///<	��Ȩ��Լ���	C20.
    szUnderlyingSecurityID: array[0..7] of Char;	///<	���֤ȯ����	C6.
    szUnderlyingSymbol: array[0..15] of Char;	///<	����֤ȯ֤ȯ����	C8	.
    szUnderlyingType: array[0..3] of Char;	///<	���֤ȯ����	C3	(EBS�CETF��	ASH�CA��).
    chOptionType: Char;	///<	ŷʽ��ʽ	C1	(��Ϊŷʽ��Ȩ�����ֶ�Ϊ��E������Ϊ��ʽ��Ȩ�����ֶ�Ϊ��A��).
    chCallOrPut: Char;	///<	�Ϲ��Ϲ�	C1	�Ϲ������ֶ�Ϊ��C������Ϊ�Ϲ������ֶ�Ϊ��P��.
    iContractMultiplierUnit: Int64;	///<	��Լ��λ	N11	(������Ȩ��Ϣ������ĺ�Լ��λ).
    unExercisePrice: Cardinal;	///<	��Ȩ��Ȩ��	N11(4)	(������Ȩ��Ϣ���������Ȩ��Ȩ�ۣ���ȷ��0.1��).
    nStartDate: Integer;	///<	�׸�������(YYYYMMDD)	C8.
    nEndDate: Integer;	///<	�������(YYYYMMDD)	C8.
    nExerciseDate: Integer;	///<	��Ȩ��Ȩ��(YYYYMMDD)	C8.
    nDeliveryDate: Integer;	///<	��Ȩ������(YYYYMMDD)	C8.
    nExpireDate: Integer;	///<	��Ȩ������(YYYYMMDD)	C8.
    chUpdateVersion: Char;	///<	��Լ�汾��	C1.
    iTotalLongPosition: Int64;	///<	��ǰ��Լδƽ����	N12	(��λ��	���ţ�).
    unSecurityClosePx: Cardinal;	///<	��Լǰ���̼�	N11(4)	(�������̼ۣ��Ҷ��룬��ȷ����).
    unSettlPrice: Cardinal;	///<	��Լǰ�����	N11(4)	(���ս���ۣ�������Ȩ��Ϣ��Ϊ������Ľ���ۣ���Լ����������д�ο��ۣ����Ҷ��룬��ȷ��0.1��).
    unUnderlyingClosePx: Cardinal;	///<	���֤ȯǰ���̼�	N11(4)	(��Ȩ���֤ȯ��Ȩ��Ϣ�������ǰ���̼۸��Ҷ��룬��ȷ��0.1��).
    chPriceLimitType: Char;	///<	�ǵ�����������	C1	(��N�����ǵ�����������).
    unUpLimitDailyPrice: Cardinal;	///<	�Ƿ����޼۸�	N11(4)	(������Ȩ��ͣ�۸񣬾�ȷ��0.1��).
    unDownLimitDailyPrice: Cardinal;	///<	�������޼۸�	N11(4)	(������Ȩ��ͣ�۸񣬾�ȷ��0.1��).
    dMarginUnit: Double;	///<	��λ��֤��	N16(2)	(���ճ���һ�ź�Լ����Ҫ�ı�֤����������ȷ����).
    nMarginRatioParam1: Integer;	///<	��֤������������һ	N3	(��֤������������λ��%).
    nMarginRatioParam2: Integer;	///<	��֤��������������	N3	(��֤������������λ��%).
    iRoundLot: Int64;	///<	������	N12	һ�ֶ�Ӧ�ĺ�Լ��.
    iLmtOrdMinFloor: Int64;	///<	�����޼��걨����	N12	(�����޼��걨���걨�������ޡ�).
    iLmtOrdMaxFloor: Int64;	///<	�����޼��걨����	N12	(�����޼��걨���걨�������ޡ�).
    iMktOrdMinFloor: Int64;	///<	�����м��걨����	N12	(�����м��걨���걨�������ޡ�).
    iMktOrdMaxFloor: Int64;	///<	�����м��걨����	N12	(�����м��걨���걨�������ޡ�).
    szSecurityStatusFlag: array[0..7] of Char;	///<	��Ȩ��Լ״̬��Ϣ��ǩ	C8	(���ֶ�Ϊ8λ�ַ���������ÿλ��ʾ�ض��ĺ��壬�޶�������ո�).
  	///��1λ����0����ʾ�ɿ��֣���1����ʾ�����������֣��������ҿ��֣������뿪�֡�
  	///��2λ����0����ʾδ����ͣ�ƣ���1����ʾ����ͣ�ơ�
  	///��3λ����0����ʾδ�ٽ������գ���1����ʾ���뵽���ղ���10�������ա�
  	///��4λ����0����ʾ����δ����������1����ʾ���10���������ں�Լ������������
  	///��5λ����A����ʾ�����¹��Ƶĺ�Լ����E����ʾ�����ĺ�Լ����D����ʾ����ժ�Ƶĺ�Լ��
    unTickSize:Cardinal		///<	��С���۵�λ	N11(4)	��λ��Ԫ����ȷ��0.1��(����ͨѶ���۸����ʹ���)	.
  end;

  TDF_OptionMarketData = record
    nIdnum: Integer;	///<	���ձ��(�����������г��ı��*100	+	�г����(��DF_MARKET_TYPEö��Ϊ׼)).
  	//�磺1201�����㷽ʽ��	;
  	//1201%100	;	1��ʾ��������ţ�1��Ϊ�Ϻ���Ʊ��
  	//1201/100	;	12��ʾ��ֻ֤ȯ�������г��ı�ţ�
    nDate: Integer;	///<	��������.
    nTime: Integer;	///<	����ʱ��(HHMMSSmmm)
    iTotalLongPosition: Int64;	///<	��ǰ��Լδƽ����	N12	����λ��	���ţ���.
    iTradeVolume: Int64;	///<	�ܳɽ�����	N16.
    dTotalValueTraded: Double;	///<	�ɽ����	N16(2)	����ȷ���֣�.
    unPreSettlPrice: Cardinal;	///<	���ս����	N11(4)	����ȷ��0.1�壩.
    unOpenPrice: Cardinal;	///<	���տ��̼�	N11(4)	����ȷ��0.1�壩.
    unAuctionPrice: Cardinal;	///<	��̬�ο��۸�	N11(4)	���������жϲο��ۣ���ȷ��0.1�壩.
    iAuctionQty: Int64;	///<	����ƥ������	N12.
    unHighPrice: Cardinal;	///<	��߼�	N11(4)	����ȷ��0.1�壩.
    unLowPrice: Cardinal;	///<	��ͼ�	N11(4)	����ȷ��0.1�壩.
    unTradePrice: Cardinal;	///<	���¼�	N11(4)	�����³ɽ��ۣ���ȷ��0.1�壩.
    arrunBuyPrice_5: array[0..4] of Cardinal;	///<	�����	N11(4)	����ǰ����ۣ���ǰ���żۣ�����ȷ��0.1�壩.
    arriBuyVolume_5: array[0..4] of Int64;	///<	������	N12.
    arrunSellPrice_5: array[0..4] of Cardinal;	///<	������	N11(4)	(��ǰ�����ۣ���ǰ���żۣ�����ȷ��0.1��).
    arriSellVolume_5: array[0..4] of Int64;	///<	������	N12.
    unSettlPrice: Cardinal;	///<	���ս����	N11(4)	***��������Ȩ����Ŀǰȡ���˽���۵ķ���***.
    szTradingPhaseCode: array[0..3] of Char;	///<	��Ʒʵʱ�׶μ���־	C4	(���ֶ�Ϊ4λ�ַ���������ÿλ��ʾ�ض��ĺ��壬�޶�������ո�).
  	//��1λ����S����ʾ����������ǰ��ʱ�Σ���C����ʾ���Ͼ���ʱ�Σ���T����ʾ��������ʱ�Σ���B����ʾ����ʱ�Σ���E����ʾ����ʱ�Σ���V����ʾ�������жϣ���P����ʾ��ʱͣ�ơ���U����ʾ���̼��Ͼ��ۡ�	;
  	//��2λ����0����ʾδ����ͣ�ƣ���1����ʾ����ͣ�ơ���Ԥ��������ո�	;
  	//��3λ����0����ʾ�����ƿ��֣���1����ʾ���Ʊ��ҿ��֣���2����ʾ�������֣���3����ʾ�����������֡����ҿ��֣���4����ʾ�������뿪�֣���5����ʾ�������뿪�֡����ҿ��֣���6����ʾ�������뿪�֡��������֣���7����ʾ�������뿪�֡��������֡����ҿ���	;
    unSD1: Cardinal;	///<	����1�����¼۶Աȼ���һ���۸񣩣���ȷ��0.1�壩.
  end;

  TDF_CodeInfo = record
    nIdnum: Integer;							///< ���ձ��(�����������г��ı��*100 + �г����(��DF_MARKET_TYPEö��Ϊ׼)).
  	//�磺1201�����㷽ʽ��
  	//1201%100 = 1��ʾ��������ţ�1��Ϊ�Ϻ���Ʊ��
  	//1201/100 = 12��ʾ��ֻ֤ȯ�������г��ı�ţ�
    nType: Integer;							///< ��������(��ע���ĵ�).
    szID: array[0..15] of Char;						///< ��Ȩ��Լ����.
    szCode: array[0..23] of Char;						///< ��Ʊ����/�ڻ�����Ȩ��Լ���״���.
    szName: array[0..31] of Char;						///< ��Ʊ����/�ڻ�����Ȩ��Լ���.
  end;
  
  {$A1-}

  
  {DF�ֻ�����������ݽṹ}
  PDFDAPI_OPEN_CONNECT_SET = ^DFDAPI_OPEN_CONNECT_SET;

  PDFDAPI_SET_ENVIRONMENT = ^DFDAPI_SET_ENVIRONMENT;

  PDFDAPI_ERR_CODE = ^DFDAPI_ERR_CODE;

  PSUBSCRIPTION_STYLE = ^SUBSCRIPTION_STYLE;

  PDFDAPI_CODEINFO = ^DFDAPI_CODEINFO;

  PDFDAPI_APP_HEAD = ^DFDAPI_APP_HEAD;

  PDFDAPI_CALLBACK_MSG = ^DFDAPI_CALLBACK_MSG;

  PDFDAPI_INDEX_DATA = ^DFDAPI_INDEX_DATA;

  PDFDAPI_MARKET_DATA = ^DFDAPI_MARKET_DATA;

  PDFDAPI_CODE_RESULT = ^DFDAPI_CODE_RESULT;

  PDFDAPI_CONNECT_RESULT = ^DFDAPI_CONNECT_RESULT;  

  {$A1+}
  {$Z4+}
  {�ֻ�}

  DFDAPI_MSG_ID = (MSG_INVALID = -100,
  	
  	///< ϵͳ��Ϣ
    MSG_SYS_DISCONNECT_NETWORK,							///< ����Ͽ��¼�, ��Ӧ�Ľṹ��ΪNULL
    MSG_SYS_CONNECT_RESULT,								///< �����������ӵĽ��
    MSG_SYS_LOGIN_RESULT,								///< ��½Ӧ��
    MSG_SYS_CODETABLE_RESULT,							///< ����������յ�����Ϣ��ɻ�ȡ��Ӧ�����,����Ϣ��ʾ������Ȩ�г�������ȡ
    MSG_SYS_QUOTATIONDATE_CHANGE,						///< �������ڱ��֪ͨ����ȡ����
    MSG_SYS_MARKET_CLOSE,								///< ���У���ȡ����
    MSG_SYS_HEART_BEAT,									///< ������������Ϣ, ��Ӧ�Ľṹ��ΪNULL
    MSG_SYS_MARKET_EVENT,								///< �г��¼�֪ͨ��Ϣ(���г����̣�ת����),�յ����¼������̻��߿��պ�ɻ�ȡ���պ���Ȩ��Ϣ
  	
  	//�����г������֪ͨ.����ĳЩ��С�г����ݻص�ʱ��ͬʱ����������г��Ŵ����������������ݽ�MSG_SYS_CODETABLE_RESULT�ȵ���
  	//���Ӹ���Ϣ��֪ͨÿһ�г�������������ͻ��ɾݴ�ѡ���ʱ��������
    MSG_SYS_SINGLE_CODETABLE_RESULT,					///< �����г�����������յ�����Ϣ��ɻ�ȡ��Ӧ�ĵ����г������
    MSG_SYS_QUOTEUNIT_CHANGE,							///< �۲�仯
    MSG_SYS_PACK_OVER,									///< ��ǰ������������
  
  	///< ������Ϣ
    MSG_DATA_INDEX,										///< ָ������
    MSG_DATA_MARKET,									///< ��������
    MSG_DATA_FUTURE,									///< �ڻ�����
    MSG_DATA_HKEX,										///< �۹�����
    MSG_DATA_TRANSACTION,								///< ��ʳɽ�
    MSG_DATA_ORDERQUEUE,								///< ί�ж���
    MSG_DATA_ORDER,										///< ���ί��
    MSG_DATA_BBQTRANSACTION,							///< BBQ��ȯ�ɽ�����
    MSG_DATA_BBQBID,									///< BBQ��ȯ��������
    MSG_DATA_NON_MD,									///< ��������Ϣ
    MSG_DATA_OTC_OPTION,								///< ������Ȩ
    MSG_DATA_BROKERQUEUE,								///< �����̶���(�۹�)
    MSG_SH_ETF_LIST,									///< �յ�����ETF�嵥��Ϣ.
    MSG_SZ_ETF_LIST,									///< �յ�����ETF�嵥��Ϣ.
    MSG_UPDATE_ETFLIST,									///< ETF�嵥�и���,���������������»�ȡ.
    MSG_HKEX_BASICINFO,									///< �۹ɻ�����Ϣ����,���ȡ.
    MSG_DATA_OPTION,									///< ��Ȩ����
    MSG_OPTION_BASICINFO								///< ��Ȩ������Ϣ����,���ȡ.
);

  DFDAPI_SET_ENVIRONMENT = (DFDAPI_ENVIRON_HEART_BEAT_INTERVAL,					///< Heart Beat�����������, ��ֵΪ0���ʾĬ��ֵ10����
  	//DFDAPI_ENVIRON_MISSED_BEAT_COUNT,					///< ���û���յ����������������ֵ����û�յ������κ����ݣ����ж�Ϊ���ߣ���ֵ0ΪĬ�ϴ���2��
    DFDAPI_ENVIRON_OPEN_TIME_OUT,						///< �ڵ�DFDAPI_Open�ڼ䣬����ÿһ�����ݰ��ĳ�ʱʱ�䣨����������DFDAPI_Open�����ܵ����ȴ�ʱ�䣩����ֵΪ0��Ĭ��30��
    DFDAPI_ENVIRON_USE_PACK_OVER, DFDAPI_ENVIRON_HEART_BEAT_FLAG,						///< �������ݷ��ͷ�ʽ��0: ȡ������������ 1��û�����ݷ��͵�ʱ�����������ݣ�2���й��ɷ����������ݣ�
    DFDAPI_ENVIRON_SOURCE_MODE,							///< ˫������Դģʽ,ֵ�ο�DFDAPI_SOURCE_SETTINGö����
    DFDAPI_ENVIRON_SOURCE_MODE_VALUE,					///< ˫������Դģʽ�²�����ֵ
    DFDAPI_ENVIRON_OUT_LOG,								///< 1����ǰĿ¼�´���log�������ڵ�ǰ·����log�ļ���ʱ������log�ļ�����
    DFDAPI_ENVIRON_SNAPSHOT_ENENT,						///< 1�����Ϳ����¼�������֪ͨ�����ղ����͵��ص�����������ֱ�ӷ��Ϳ��յ��ص��������޿���֪ͨ
    DFDAPI_ENVIRON_ORIGINAL_VOL,						///< ԭʼ�ṹ��Ч��1��ָ���ɽ����ͳɽ���ĵ�λΪ�ɺ�Ԫ��Ĭ��Ϊ100�ɺ�100Ԫ
    DFDAPI_ENVIRON_BREAKPOINT,							///< 1.����Ͽ���ϵ�������else.�������¿���
    DFDAPI_ENVIRON_PUSHMODE							///< 0:����Ĭ�϶������ͣ�1:����Ĭ�϶������͡�
);

  DFDAPI_ERR_CODE = (DFDAPI_ERR_UNKOWN = -400,							///< δ֪����
    DFDAPI_ERR_UNINITIALIZE = -399,						///< �ӿڻ���δ��ʼ��
    DFDAPI_ERR_INITIALIZE_FAILURE = -200,				///< ��ʼ��socket����ʧ��
    DFDAPI_ERR_NETWORK_ERROR,							///< �������ӳ�������
    DFDAPI_ERR_INVALID_PARAMS,							///< ���������Ч
    DFDAPI_ERR_VERIFY_FAILURE,							///< ��½��֤ʧ�ܣ�ԭ��Ϊ�û�������������󣻳�����½����
    DFDAPI_ERR_NO_AUTHORIZED_MARKET,					///< ����������г���û����Ȩ
    DFDAPI_ERR_NO_CODE_TABLE,							///< ����������г����춼û�д����
    DFDAPI_ERR_NO_BASICINFO,							///< ����������г�������Ϣ����Ϊ��.
    DFDAPI_ERR_SUCCESS = 0								///< �ɹ�
);

  SUBSCRIPTION_STYLE = (SUBSCRIPTION_SET = 0,								///< ���ö������飬�ٴ����ö���ʱ���Զ�ȡ��֮ǰ���ж��Ĵ���.
    SUBSCRIPTION_ADD = 1,								///< ���Ӷ��Ĵ���
    SUBSCRIPTION_DEL = 2								///< ɾ�����Ĵ���
);

  {$Z4-}
  ///< ������գ�MSG_DATA_MARKET.
  DFDAPI_MARKET_DATA = record
    szWindCode: array[0..31] of Char;								///< 600001.SH
    szCode: array[0..31] of Char;									///< ԭʼCode
    nActionDay: Integer;									///< ҵ������(��Ȼ��)
    nTradingDay: Integer;								///< ������
    nTime: Integer;										///< ʱ��(HHMMSSmmm)
    nStatus: Integer;									///< ״̬
    nPreClose: Int64;									///< ǰ���̼�
    nOpen: Int64;										///< ���̼�
    nHigh: Int64;										///< ��߼�
    nLow: Int64;										///< ��ͼ�
    nMatch: Int64;										///< ���¼�
    nAskPrice: array[0..9] of Int64;								///< ������
    nAskVol: array[0..9] of Int64;								///< ������
    nBidPrice: array[0..9] of Int64;								///< �����
    nBidVol: array[0..9] of Int64;								///< ������
    nNumTrades: Integer;									///< �ɽ�����
    iVolume: Int64;									///< �ɽ�����
    iTurnover: Int64;									///< �ɽ��ܽ��
    nTotalBidVol: Int64;								///< ί����������
    nTotalAskVol: Int64;								///< ί����������
    nWeightedAvgBidPrice: Int64;						///< ��Ȩƽ��ί��۸�
    nWeightedAvgAskPrice: Int64;						///< ��Ȩƽ��ί���۸�
    nIOPV: Integer;										///< IOPV��ֵ��ֵ
    nYieldToMaturity: Integer;							///< ����������
    nHighLimited: Int64;								///< ��ͣ��
    nLowLimited: Int64;								///< ��ͣ��
    chPrefix: array[0..3] of Char;								///< ֤ȯ��Ϣǰ׺
    nSyl1: Integer;										///< ��ӯ��1
    nSyl2: Integer;										///< ��ӯ��2
    nSD2: Integer;										///< ����2���Ա���һ�ʣ�
    	//const DFDAPI_CODE_INFO *  pCodeInfo;					///< ������Ϣ�� DFDAPI_Close�����������󣬴�ָ����Ч
  end;
  
  
  
    ///< ָ��������գ�MSG_DATA_INDEX.
  DFDAPI_INDEX_DATA = record
    szWindCode: array[0..31] of Char;								///< 600001.SH
    szCode: array[0..31] of Char;									///< ԭʼCode
    nActionDay: Integer;									///< ҵ������(��Ȼ��)
    nTradingDay: Integer;								///< ������
    nTime: Integer;										///< ʱ��(HHMMSSmmm)
    nStatus: Integer;									///< ״̬��20151223����
    nOpenIndex: Int64;									///< ����ָ��
    nHighIndex: Int64;									///< ���ָ��
    nLowIndex: Int64;									///< ���ָ��
    nLastIndex: Int64;									///< ����ָ��
    iTotalVolume: Int64;								///< ���������Ӧָ���Ľ�������
    iTurnover: Int64;									///< ���������Ӧָ���ĳɽ����
    nPreCloseIndex: Int64;								///< ǰ��ָ��
    	//const DFDAPI_CODE_INFO *  pCodeInfo;					///< ������Ϣ�� DFDAPI_Close�����������󣬴�ָ����Ч
  end;
  
  
    ///< Ӧ��ͷ
  DFDAPI_APP_HEAD = record
    nHeadSize: Integer;										///< ����¼�ṹ��С
    nItemCount: Integer;										///< ��¼����
    nItemSize: Integer;										///< ��¼��С
  end;
  
    ///< ������Ϣ�ṹ
  DFDAPI_CALLBACK_MSG = record
    nDataType: Integer;					///< ��������
    nDataLen: Integer;					///< ���ݳ��ȣ�������DFDAPI_APP_HEAD�ĳ��ȣ�
    nServerTime: Integer;				///< ����������ʱ�������ȷ������HHMMSSmmm��
    nConnectId: Integer;					///< ����ID
    pAppHead: PDFDAPI_APP_HEAD;					///< Ӧ��ͷ
    pData: Pointer;						///< ����ָ��
  end;
  
  
    ///< �������Ϣ.
  DFDAPI_CODEINFO = record
    szWindCode: array[0..31] of Char;									///< 000001.SZ;600000.SH;IH1711.CFF;
    szSecurityID: array[0..15] of Char;									///< �������֤ȯ����.
    szSecurityCode: array[0..23] of Char;								///< ������ԭʼ֤ȯ����.
    szMarket: array[0..7] of Char;										///< SZ;SH;CFF;SHO;SZO;
    szENName: array[0..31] of Char;										///< Ӣ������.
    szCNName: array[0..31] of Char;										///< ֤ȯ����.
    nType: Integer;												///< ֤ȯ����.
  end;
  
  
  //������������Ϣ
  DFDAPI_SERVER_INFO = record
    szIp: array[0..31] of char;											///< IP
    nPort: SmallInt;											///< �˿�
    szUser: array[0..63] of Char;										///< �û���
    szPwd: array[0..63] of Char;											///< ����
    bDoMain: Boolean;											///< �Ƿ�ʹ������
  end;

  DFDAPI_OPEN_CONNECT_SET = record
    ServerInfo: array[0..JGAPI_SERVERINFO_MAX - 1] of DFDAPI_SERVER_INFO;	///< ��������Ϣ
    unServerNum: Cardinal;								///< ����������
    data_fun: Pointer;							///< ������Ϣ����ص�
    notice_fun: Pointer;						///< ϵͳ��Ϣ֪ͨ�ص�
      	///< �������� ע�⣺�������г������ģ�����ÿ���г����붩���г�����룬ֻ�����г������ʹ��г�ȫ������
    szMarkets: PChar;									///< �г����ģ�����"SZ;SH;CF;SHF;DCE;SHF"����Ҫ���ĵ��г��б��ԡ�;���ָ�.
    szSubScriptions: PChar;							///< ���붩�ģ�����"600000.sh;IH1711.cf;000001.sz"����Ҫ���ĵĹ�Ʊ���ԡ�;���ָ�.
    szTypeFlags: PChar;								///< �������Ͷ��ģ�֧�ֶ���3������TRANSACTION;ORDER;ORDERQUEUE����ע�⣺���������κ�ʱ�򶼷��ͣ�����Ҫ����! �μ�enum DATA_TYPE_FLAG.
    nTime: Cardinal;										///< Ϊ0������ʵʱ���飬Ϊ0xffffffff��ͷ����.
    nConnectionID: Cardinal;								///< ����ID�����ӻص���Ϣ�ĸ��ӽṹ DFDAPI_CONNECT_RESULT�� ��������ID����ϢͷҲ�������ID.
  end;
    {�ֻ�}

  
    ///< ϵͳ��Ϣ��MSG_SYS_CODETABLE_RESULT ��Ӧ�Ľṹ

  DFDAPI_CODE_RESULT = record
    szInfo: array[0..127] of Char;										///< ��������ı�
    nMarkets: Integer;											///< �г�����
    szMarket: array[0..255, 0..7] of Char;									///< �г�����
    nCodeCount: array[0..255] of Integer;									///< ���������
    nCodeDate: array[0..255] of Integer;										///< ���������
  end;

  ///< ���ӽ����MSG_SYS_CONNECT_RESULT
  DFDAPI_CONNECT_RESULT = record
    szIp: array[0..31] of Char;
    szPort: array[0..7] of Char;
    szUser: array[0..63] of Char;
    szPwd: array[0..63] of Char;
    nConnResult: Cardinal;								///< Ϊ0���ʾ���ӳɹ�����0���ʾ����ʧ��
    nConnectionID: Integer;										///< ����ID
  end;

  {$A1-}

  {$A8+}
  {��Ȩ����}
  ///< �û���½Ӧ��
  PCJGtdcRspUserLogin = ^TCJGtdcRspUserLogin;

  TCJGtdcRspUserLogin = record
    ClientID: TJGtdcClientIDType;                    ///< �ͻ���
    FundAccount: TJGtdcFundAccountType;              ///< �ʽ��˺�
    SupportSubType: TJGtdcSupportSubType;			///< ֧�ֵĶ�������
  end;

  ///< ��Ӧ��Ϣ
  PCJGtdcRspInfoField = ^TCJGtdcRspInfoField;

  TCJGtdcRspInfoField = record
    ResultType: TJGtdcResultType;                   ///< Ӧ����
    ErrorInfo: TJGtdcErrorInfoType;                  ///< ������Ϣ
    nFieldItem: Integer;                                 ///< Ӧ�����ݸ���
  end;

  ///< �û��ǳ�Ӧ��
  PCJGtdcRspUserLogout = ^TCJGtdcRspUserLogout;

  TCJGtdcRspUserLogout = record
    ClientID: TJGtdcClientIDType;                    ///< �ͻ���
    FundAccount: TJGtdcFundAccountType;              ///< �ʽ��˺�
  end;


 ///< Ͷ������Ȩί���µ�Ӧ��
  PCJGtdcOptionRspEntrust = ^TCJGtdcOptionRspEntrust;

  TCJGtdcOptionRspEntrust = record
    ResultType: TJGtdcResultType;	    ///< Ӧ����
    ErrorInfo: TJGtdcErrorInfoType;		///< ������Ϣ
    EntrustNo: TJGtdcEntrustNoType;		///< ��ͬ��
    BatchNo: TJGtdcBatchNoType;			///< ����
    ExchangeType: TJGtdcExchangeType;	///< �г�����
    StockAccount: TJGtdcStockAccountType;
    ContractNumber: TJGtdcContractNumber;
    TradeType: TJGtdcTradeType;			///< ��������
    OffsetType: TJGtdcOffsetType;		///< ��ƽ������
    CoveredType: TJGtdcCoveredType;		///< ���ұ�ʶ
    PriceType: TJGtdcPriceType;			///< �۸�����
    EntrustAmount: TJGtdcOrderVolume;	///< ί������
    EntrustPrice: TJGtdcOrderPrice;		///< ί�м۸�
  end;

  ///< Ͷ������Ȩί�г���Ӧ��
  PCJGtdcOptionRspCancel = ^TCJGtdcOptionRspCancel;

  TCJGtdcOptionRspCancel = record
    ResultType: TJGtdcResultType;	///<	Ӧ����
    ErrorInfo: TJGtdcErrorInfoType;	///<	������Ϣ
    EntrustNo: TJGtdcEntrustNoType;	///<	��ͬ��
    NewEntrustNo: TJGtdcNewEntrustNoType;	///<	�º�ͬ��
    BatchNo: TJGtdcBatchNoType;	///<	����
  end;

  ///< Ͷ������Ȩί�в�ѯӦ��
  PCJGtdcOptionRspQryEntrust = ^TCJGtdcOptionRspQryEntrust;

  TCJGtdcOptionRspQryEntrust = record
    BranchNo: TJGtdcBranchNoType;	///<	Ӫҵ����
    ClientID: TJGtdcClientIDType;	///<	�ͻ���
    FundAccount: TJGtdcFundAccountType;	///<	�ʽ��˺�
    ExchangeType: TJGtdcExchangeType;	///<	�г�����
    StockAccount: TJGtdcStockAccountType;	///<	�ɶ�����
    SeatNo: TJGtdcSeatNoType;	///<	ϯλ��
    ContractNumber: TJGtdcContractNumber;	///<	��Լ����
    ContractCode: TJGtdcContractCodeType;	///<	��Լ����
    ContractName: TJGtdcContractNameType;	///<	��Լ����
    StockCode: TJGtdcStockCodeType;	///<	֤ȯ����
    StockName: TJGtdcStockNameType;	///<	֤ȯ����
    PositionStr: TJGtdcPositionStrType;	///<	��λ��
    EntrustNo: TJGtdcEntrustNoType;	///<	��ͬ��
    ReportNo: TJGtdcReportNoType;	///<	�걨��
    BatchNo: TJGtdcBatchNoType;	///<	����
    MoneyType: TJGtdcMoneyType;	///<	����
    EntrustStatus: TJGtdcEntrustStatus;	///<	ί��״̬
    TradeType: TJGtdcTradeType;	///<	��������
    OffsetType: TJGtdcOffsetType;	///<	��ƽ������
    CoveredType: TJGtdcCoveredType;	///<	���ұ�ʶ
    PriceType: TJGtdcPriceType;	///<	�۸�����
    EntrustDate: TJGtdcDate;	///<	ί������
    EntrustTime: TJGtdcTime;	///<	ί��ʱ��
    EntrustAmount: TJGtdcOrderVolume;	///<	ί������
    EntrustPrice: TJGtdcOrderPrice;	///<	ί�м۸�
    BusinessAmount: TJGtdcBuinessVolume;	///<	�ɽ�����
    BusinessPrice: TJGtdcBusinessPrice;	///<	�ɽ��۸�
    CancelAmount: TJGtdcCancelVolume;	///<	��������
    BusinessBalance: TJGtdcBusinessBalance;	///<	�ɽ����
    InvalidReason: TJGtdcInvalidReason;	///<	�ϵ�ԭ��
  end;

  ///< Ͷ������Ȩ�����ɽ���ѯӦ��
  PCJGtdcOptionRspQryBusByPos = ^TCJGtdcOptionRspQryBusByPos;

  TCJGtdcOptionRspQryBusByPos = record
    BranchNo: TJGtdcBranchNoType;	///<	Ӫҵ����
    ClientID: TJGtdcClientIDType;	///<	�ͻ���
    FundAccount: TJGtdcFundAccountType;	///<	�ʽ��˺�
    ExchangeType: TJGtdcExchangeType;	///<	�г�����
    StockAccount: TJGtdcStockAccountType;	///<	�ɶ�����
    SeatNo: TJGtdcSeatNoType;	///<	ϯλ��
    ContractNumber: TJGtdcContractNumber;	///<	��Լ����
    ContractCode: TJGtdcContractCodeType;	///<	��Լ����
    ContractName: TJGtdcContractNameType;	///<	��Լ����
    StockCode: TJGtdcStockCodeType;	///<	֤ȯ����
    StockName: TJGtdcStockNameType;	///<	֤ȯ����
    PositionStr: TJGtdcPositionStrType;	///<	��λ��
    EntrustNo: TJGtdcEntrustNoType;	///<	��ͬ��
    ReportNo: TJGtdcReportNoType;	///<	�걨��
    BatchNo: TJGtdcBatchNoType;	///<	����
    BusinessNo: TJGtdcBusinessNoType;	///<	�ɽ���
    MoneyType: TJGtdcMoneyType;	///<	����
    BusinessStatus: TJGtdcBusinessStatus;	///<	�ɽ�״̬
    TradeType: TJGtdcTradeType;	///<	��������
    OffsetType: TJGtdcOffsetType;	///<	��ƽ������
    CoveredType: TJGtdcCoveredType;	///<	���ұ�ʶ
    PriceType: TJGtdcPriceType;	///<	�۸�����
    BusinessDate: TJGtdcDate;	///<	�ɽ�����
    BusinessTime: TJGtdcTime;	///<	�ɽ�ʱ��
    EntrustAmount: TJGtdcOrderVolume;	///<	ί������
    EntrustPrice: TJGtdcOrderPrice;	///<	ί�м۸�
    BusinessAmount: TJGtdcBuinessVolume;	///<	�ɽ�����
    BusinessPrice: TJGtdcBusinessPrice;	///<	�ɽ��۸�
    CancelAmount: TJGtdcCancelVolume;	///<	��������
    BusinessBalance: TJGtdcBusinessBalance;	///<	�ɽ����
  end;

  ///< Ͷ������Ȩ�ֲֲ�ѯӦ��
  PCJGtdcOptionRspQryHold = ^TCJGtdcOptionRspQryHold;

  TCJGtdcOptionRspQryHold = record
    BranchNo: TJGtdcBranchNoType;	///<	Ӫҵ����
    ClientID: TJGtdcClientIDType;	///<	�ͻ���
    FundAccount: TJGtdcFundAccountType;	///<	�ʽ��˺�
    ExchangeType: TJGtdcExchangeType;	///<	�г�����
    StockAccount: TJGtdcStockAccountType;	///<	�ɶ�����
    ContractNumber: TJGtdcContractNumber;	///<	��Լ����
    ContractCode: TJGtdcContractCodeType;	///<	��Լ����
    ContractName: TJGtdcContractNameType;	///<	��Լ����
    StockCode: TJGtdcStockCodeType;	///<	֤ȯ����
    StockName: TJGtdcStockNameType;	///<	֤ȯ����
    PositionStr: TJGtdcPositionStrType;	///<	��λ��
    MoneyType: TJGtdcMoneyType;	///<	����
    OptionType: TJGtdcOptionType;	///<	��Ȩ���
    OptionHoldType: TJGtdcOptionHoldType;	///<	��Ȩ�ֲ����
    OptionYDAmount: TJGtdcOptionYDAmount;	///<	��Ȩ�������
    OptionAmount: TJGtdcOptionAmount;	///<	��Ȩ���
    EnableAmount: TJGtdcEnableAmount;	///<	��������
    PossessAmount: TJGtdcPossessAmount;	///<	��ǰӵ������
    FrozenAmount: TJGtdcFrozenAmount;	///<	��������
    UnFrozenAmount: TJGtdcUnFrozenAmount;	///<	�ⶳ����
    TransitAmount: TJGtdcTransitAmount;	///<	��;����
    TodayOpenAmount: TJGtdcTodayOpenAmount;	///<	���տ�����
    TodayPayoffAmount: TJGtdcTodayPayoffAmount;	///<	����ƽ����
    PremiumBalance: TJGtdcPremiumBalance;	///<	Ȩ����
    BailBalance: TJGtdcBailBalance;	///<	��֤��
    CostPrice: TJGtdcCostPrice;	///<	�ɱ��۸�
    BuyCost: TJGtdcBuyCost;	///<	��ǰ�ɱ�
    OptionBalance: TJGtdcOptionBalance;	///<	��Ȩ��ֵ
    HoldIncome: TJGtdcHoldIncome;	///<	�ֲ�ӯ��
    PayoffIncome: TJGtdcPayoffIncome;	///<	ƽ��ӯ��
  end;

  ///< Ͷ������Ȩ�ʽ��ѯӦ��
  PCJGtdcOptionRspQryFund = ^TCJGtdcOptionRspQryFund;

  TCJGtdcOptionRspQryFund = record
    BranchNo: TJGtdcBranchNoType;	///<	Ӫҵ����
    ClientID: TJGtdcClientIDType;	///<	�ͻ���
    FundAccount: TJGtdcFundAccountType;	///<	�ʽ��˺�
    MoneyType: TJGtdcMoneyType;	///<	����
    MainFlag: TJGtdcMainFlag;	///<	������־
    EnableBalance: TJGtdcEnableBalance;	///<	�������
    FetchBalance: TJGtdcFetchBalance;	///<	��ȡ���
    FrozenBalance: TJGtdcFrozenBalance;	///<	������
    StockBalance: TJGtdcStockBalance;	///<	֤ȯ��ֵ
    FundBalance: TJGtdcFundBalance;	///<	�ʽ����
    AssetBalance: TJGtdcAssetBalance;	///<	�ʲ���ֵ
    Income: TJGtdcIncome;	///<	��ӯ��
    EnableBail: TJGtdcEnableBail;	///<	���ñ�֤��
    UsedBail: TJGtdcUsedBail;	///<	���ñ�֤��
    AgreeAssureRatio: TJGtdcAgreeAssureRatio;	///<	��Լ��������
    RiskRatio: TJGtdcRiskRatio;	///<	���ն�
    RiskRatio1: TJGtdcRiskRatio1;	///<	���ն�1

  end;

   ///< Ͷ������Ȩ�ɳ�����ѯӦ��
  PCJGtdcOptionRspQryRevocEnt = ^TCJGtdcOptionRspQryRevocEnt;

  TCJGtdcOptionRspQryRevocEnt = record
    BranchNo: TJGtdcBranchNoType;	///<	Ӫҵ����
    ClientID: TJGtdcClientIDType;	///<	�ͻ���
    FundAccount: TJGtdcFundAccountType;	///<	�ʽ��˺�
    ExchangeType: TJGtdcExchangeType;	///<	�г�����
    StockAccount: TJGtdcStockAccountType;	///<	�ɶ�����
    SeatNo: TJGtdcSeatNoType;	///<	ϯλ��
    ContractNumber: TJGtdcContractNumber;	///<	��Լ����
    ContractCode: TJGtdcContractCodeType;	///<	��Լ����
    ContractName: TJGtdcContractNameType;	///<	��Լ����
    StockCode: TJGtdcStockCodeType;	///<	֤ȯ����
    StockName: TJGtdcStockNameType;	///<	֤ȯ����
    PositionStr: TJGtdcPositionStrType;	///<	��λ��
    EntrustNo: TJGtdcEntrustNoType;	///<	��ͬ��
    ReportNo: TJGtdcReportNoType;	///<	�걨��
    BatchNo: TJGtdcBatchNoType;	///<	����
    MoneyType: TJGtdcMoneyType;	///<	����
    EntrustStatus: TJGtdcEntrustStatus;	///<	ί��״̬
    TradeType: TJGtdcTradeType;	///<	��������
    OffsetType: TJGtdcOffsetType;	///<	��ƽ������
    CoveredType: TJGtdcCoveredType;	///<	���ұ�ʶ
    PriceType: TJGtdcPriceType;	///<	�۸�����
    EntrustDate: TJGtdcDate;	///<	ί������
    EntrustTime: TJGtdcTime;	///<	ί��ʱ��
    EntrustAmount: TJGtdcOrderVolume;	///<	ί������
    EntrustPrice: TJGtdcOrderPrice;	///<	ί�м۸�
    BusinessAmount: TJGtdcBuinessVolume;	///<	�ɽ�����
    BusinessPrice: TJGtdcBusinessPrice;	///<	�ɽ��۸�
    CancelAmount: TJGtdcCancelVolume;	///<	��������
    BusinessBalance: TJGtdcBusinessBalance;	///<	�ɽ����
    InvalidReason: TJGtdcInvalidReason;	///<	�ϵ�ԭ��
  end;

  ///< �û�����Ӧ��
  PCJGtdcRspOrderInsert = ^TCJGtdcRspOrderInsert;

  TCJGtdcRspOrderInsert = record
    ResultType: TJGtdcResultType;	///<	Ӧ����
    ErrorInfo: TJGtdcErrorInfoType;	///<	������Ϣ
    EntrustNo: TJGtdcEntrustNoType;	///<	��ͬ��
    BatchNo: TJGtdcBatchNoType;	///<	����
    StockAccount: TJGtdcStockAccountType;	///<	�ɶ�����
    StockCode: TJGtdcStockCodeType;	///<	֤ȯ����
    ExchangeType: TJGtdcExchangeType;	///<	�г�����
    TradeType: TJGtdcTradeType;	///<	��������
    PriceType: TJGtdcPriceType;	///<	�۸�����
    OrderVolume: TJGtdcOrderVolume;	///<	ί������
    OrderPrice: TJGtdcOrderPrice;	///<	ί�м۸�
  end;

  ///< �û�����Ӧ��
  PCJGtdcRspOrderCancel = ^TCJGtdcRspOrderCancel;

  TCJGtdcRspOrderCancel = record
    ResultType: TJGtdcResultType;	///<	Ӧ����
    ErrorInfo: TJGtdcErrorInfoType;	///<	������Ϣ
    EntrustNo: TJGtdcEntrustNoType;	///<	��ͬ��
    NewEntrustNo: TJGtdcEntrustNoType;	///<	�º�ͬ��
    BatchNo: TJGtdcBatchNoType;	///<	����
  end;

  ///< Ͷ���ߵ���ί�в�ѯӦ��
  PCJGtdcRspQryOrder = ^TCJGtdcRspQryOrder;

  TCJGtdcRspQryOrder = record
    BranchNo: TJGtdcBranchNoType;	///<	Ӫҵ����
    ClientID: TJGtdcClientIDType;	///<	�ͻ���
    FundAccount: TJGtdcFundAccountType;	///<	�ʽ��˺�
    ExchangeType: TJGtdcExchangeType;	///<	�г�����
    StockAccount: TJGtdcStockAccountType;	///<	�ɶ�����
    SeatNo: TJGtdcSeatNoType;	///<	ϯλ��
    StockCode: TJGtdcStockCodeType;	///<	֤ȯ����
    StockName: TJGtdcStockNameType;	///<	֤ȯ����
    PositionStr: TJGtdcPositionStrType;	///<	��λ��
    EntrustNo: TJGtdcEntrustNoType;	///<	��ͬ��
    MoneyType: TJGtdcMoneyType;	///<	����
    EntrustStatus: TJGtdcEntrustStatus;	///<	ί��״̬
    TradeType: TJGtdcTradeType;	///<	��������
    PriceType: TJGtdcPriceType;	///<	�۸�����
    EntrustDate: TJGtdcDate;	///<	ί������
    EntrustTime: TJGtdcTime;	///<	ί��ʱ��
    OrderVolume: TJGtdcOrderVolume;	///<	ί������
    OrderPrice: TJGtdcOrderPrice;	///<	ί�м۸�
    BusinessVolume: TJGtdcBuinessVolume;	///<	�ɽ�����
    BusinessPrice: TJGtdcBusinessPrice;	///<	�ɽ��۸�
    CancelVolume: TJGtdcCancelVolume;	///<	��������
    BusinessBalance: TJGtdcBusinessBalance;	///<	�ɽ����
    ServiceType: TJGtdcServiceType;	///<	ҵ������
  end;

  ///< Ͷ���߳ɽ�����ѯӦ��
  PCJGtdcRspQryTrade = ^TCJGtdcRspQryTrade;

  TCJGtdcRspQryTrade = record
    BranchNo: TJGtdcBranchNoType;	///<	Ӫҵ����
    ClientID: TJGtdcClientIDType;	///<	�ͻ���
    FundAccount: TJGtdcFundAccountType;	///<	�ʽ��˺�
    ExchangeType: TJGtdcExchangeType;	///<	�г�����
    StockAccount: TJGtdcStockAccountType;	///<	�ɶ�����
    SeatNo: TJGtdcSeatNoType;	///<	ϯλ��
    StockCode: TJGtdcStockCodeType;	///<	֤ȯ����
    StockName: TJGtdcStockNameType;	///<	֤ȯ����
    PositionStr: TJGtdcPositionStrType;	///<	��λ��
    EntrustNo: TJGtdcEntrustNoType;	///<	��ͬ��
    BusinessNo: TJGtdcBusinessNoType;	///<	�ɽ����
    MoneyType: TJGtdcMoneyType;	///<	����
    BusinessStatus: TJGtdcBusinessStatus;	///<	�ɽ�״̬
    TradeType: TJGtdcTradeType;	///<	��������
    PriceType: TJGtdcPriceType;	///<	�۸�����
    BusinessDate: TJGtdcDate;	///<	�ɽ�����
    BusinessTime: TJGtdcTime;	///<	�ɽ�ʱ��
    OrderVolume: TJGtdcOrderVolume;	///<	ί������
    OrderPrice: TJGtdcOrderPrice;	///<	ί�м۸�
    BusinessVolume: TJGtdcBuinessVolume;	///<	�ɽ�����
    BusinessPrice: TJGtdcBusinessPrice;	///<	�ɽ��۸�
    CancelVolume: TJGtdcCancelVolume;	///<	��������
    BusinessBalance: TJGtdcBusinessBalance;	///<	�ɽ����
  end;

  ///< Ͷ���ֲֲ߳�ѯӦ��
  PCJGtdcRspQryHold = ^TCJGtdcRspQryHold;

  TCJGtdcRspQryHold = record
    BranchNo: TJGtdcBranchNoType;	///<	Ӫҵ����
    ClientID: TJGtdcClientIDType;	///<	�ͻ���
    FundAccount: TJGtdcFundAccountType;	///<	�ʽ��˺�
    StockAccount: TJGtdcStockAccountType;	///<	�ɶ�����
    StockCode: TJGtdcStockCodeType;	///<	֤ȯ����
    StockName: TJGtdcStockNameType;	///<	֤ȯ����
    ExchangeType: TJGtdcExchangeType;	///<	�г�����
    MoneyType: TJGtdcMoneyType;	///<	����
    YdAmount: TJGtdcYdAmount;	///<	���ճֲ���
    StockAmount: TJGtdcStockAmount;	///<	�ɷ����
    EnableAmount: TJGtdcEnableAmount;	///<	��������
    PurchaseAmount: TJGtdcPurchaseAmount;	///<	���깺����
    PossessAmount: TJGtdcPossessAmount;	///<	��ǰӵ������
    FrozenAmount: TJGtdcFrozenAmount;	///<	��������
    YStoreAmount: TJGtdcYStoreAmount;	///<	���տ������
    CostPrice: TJGtdcCostPrice;	///<	�ɱ��۸�
    KeepCostPrice: TJGtdcKeepCostPrice;	///<	�����۸�
    BuyCost: TJGtdcBuyCost;	///<	��ǰ�ɱ�
    StockBalance: TJGtdcStockBalance;	///<	֤ȯ��ֵ
    FloatIncome: TJGtdcFloatIncome;	///<	����ӯ��
    ProIncome: TJGtdcProIncome;	///<	�ۼ�ӯ��
  end;

  ///< Ͷ�����ʽ��ѯӦ��
  PCJGtdcRspQryFund = ^TCJGtdcRspQryFund;

  TCJGtdcRspQryFund = record
    BranchNo: TJGtdcBranchNoType;	///<	Ӫҵ����
    ClientID: TJGtdcClientIDType;	///<	�ͻ���
    FundAccount: TJGtdcFundAccountType;	///<	�ʽ��˺�
    MoneyType: TJGtdcMoneyType;	///<	����
    MainFlag: TJGtdcMainFlag;	///<	������־
    EnableBalance: TJGtdcEnableBalance;	///<	�������
    FetchBalance: TJGtdcFetchBalance;	///<	��ȡ���
    FrozenBalance: TJGtdcFrozenBalance;	///<	������
    StockBalance: TJGtdcStockBalance;	///<	֤ȯ��ֵ
    FundBalance: TJGtdcFundBalance;	///<	�ʽ����
    AssetBalance: TJGtdcAssetBalance;	///<	�ʲ���ֵ
    InCome: TJGtdcIncome;	///<	��ӯ��
    EnableBalanceHK: TJGtdcEnableBalanceHK;	///<	�۹ɿ������
  end;

  ///< Ͷ���߿ɳ�����ѯӦ��
  PCJGtdcRspQryCancel = ^TCJGtdcRspQryCancel;

  TCJGtdcRspQryCancel = record
    BranchNo: TJGtdcBranchNoType;	///<	Ӫҵ����
    ClientID: TJGtdcClientIDType;	///<	�ͻ���
    FundAccount: TJGtdcFundAccountType;	///<	�ʽ��˺�
    ExchangeType: TJGtdcExchangeType;	///<	�г�����
    StockAccount: TJGtdcStockAccountType;	///<	�ɶ�����
    SeatNo: TJGtdcSeatNoType;	///<	ϯλ��
    StockCode: TJGtdcStockCodeType;	///<	֤ȯ����
    StockName: TJGtdcStockNameType;	///<	֤ȯ����
    PositionStr: TJGtdcPositionStrType;	///<	��λ��
    EntrustNo: TJGtdcEntrustNoType;	///<	��ͬ��
    MoneyType: TJGtdcMoneyType;	///<	����
    EntrustStatus: TJGtdcEntrustStatus;	///<	ί��״̬
    TradeType: TJGtdcTradeType;	///<	��������
    PriceType: TJGtdcPriceType;	///<	�۸�����
    EntrustDate: TJGtdcDate;	///<	ί������
    EntrustTime: TJGtdcTime;	///<	ί��ʱ��
    OrderVolume: TJGtdcOrderVolume;	///<	ί������
    OrderPrice: TJGtdcOrderPrice;	///<	ί�м۸�
    BusinessVolume: TJGtdcBuinessVolume;	///<	�ɽ�����
    BusinessPrice: TJGtdcBusinessPrice;	///<	�ɽ��۸�
    CancelVolume: TJGtdcCancelVolume;	///<	��������
    BusinessBalance: TJGtdcBusinessBalance;	///<	�ɽ����
    ServiceType: TJGtdcServiceType;	///<	ҵ������
  end;
  {$A8-}

  //����ͼ-����

  ThreeSeriesChart = record
    ValueSeries1: TFastLineSeries;
    ValueSeries2: TFastLineSeries;
    ConstantSeries: TFastLineSeries;
  end;

  TQuotationServerStatus = record
    FuturesIsLogin: Boolean;
    FuturesServer: string;
    OptionIsLogin: Boolean;
    OptionServer: string;
    ActualsIsLogin: Boolean;
    ActualsServer: string;
  end;

  TTradeAccountStatus = record
    FuturesIsLogin: Boolean;
    FuturesAccount: string;
    OptionIsLogin: Boolean;
    OptionAccount: string;
    ActualsIsLogin: Boolean;
    ActualsAccount: string;
  end;

implementation

end.

