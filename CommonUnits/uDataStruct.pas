unit uDataStruct;
(*
  行情用到的数据结构
*)

interface

uses
  Classes, Series, uConstants;

type
  {定义的数据类型和行情的数据结构}
  {映射C++时，array中0..8 对应的是C++的9，因为0也算进去了}


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
  {CTP期货相关数据结构}
  //投资者持仓

  PThostFtdcInvestorPositionField = ^CThostFtdcInvestorPositionField;

  CThostFtdcInvestorPositionField = record
    InstrumentID: TThostFtdcInstrumentIDType;
  	///经纪公司代码
    BrokerID: TThostFtdcBrokerIDType;
  	///投资者代码
    InvestorID: TThostFtdcInvestorIDType;
  	///持仓多空方向
    PosiDirection: TThostFtdcPosiDirectionType;
  	///投机套保标志
    HedgeFlag: TThostFtdcHedgeFlagType;
  	///持仓日期
    PositionDate: TThostFtdcPositionDateType;
  	///上日持仓
    YdPosition: TThostFtdcVolumeType;
  	///今日持仓
    Position: TThostFtdcVolumeType;
  	///多头冻结
    LongFrozen: TThostFtdcVolumeType;
  	///空头冻结
    ShortFrozen: TThostFtdcVolumeType;
  	///开仓冻结金额
    LongFrozenAmount: TThostFtdcMoneyType;
  	///开仓冻结金额
    ShortFrozenAmount: TThostFtdcMoneyType;
  	///开仓量
    OpenVolume: TThostFtdcVolumeType;
  	///平仓量
    CloseVolume: TThostFtdcVolumeType;
  	///开仓金额
    OpenAmount: TThostFtdcMoneyType;
  	///平仓金额
    CloseAmount: TThostFtdcMoneyType;
  	///持仓成本
    PositionCost: TThostFtdcMoneyType;
  	///上次占用的保证金
    PreMargin: TThostFtdcMoneyType;
  	///占用的保证金
    UseMargin: TThostFtdcMoneyType;
  	///冻结的保证金
    FrozenMargin: TThostFtdcMoneyType;
  	///冻结的资金
    FrozenCash: TThostFtdcMoneyType;
  	///冻结的手续费
    FrozenCommission: TThostFtdcMoneyType;
  	///资金差额
    CashIn: TThostFtdcMoneyType;
  	///手续费
    Commission: TThostFtdcMoneyType;
  	///平仓盈亏
    CloseProfit: TThostFtdcMoneyType;
  	///持仓盈亏
    PositionProfit: TThostFtdcMoneyType;
  	///上次结算价
    PreSettlementPrice: TThostFtdcPriceType;
  	///本次结算价
    SettlementPrice: TThostFtdcPriceType;
  	///交易日
    TradingDay: TThostFtdcDateType;
  	///结算编号
    SettlementID: TThostFtdcSettlementIDType;
  	///开仓成本
    OpenCost: TThostFtdcMoneyType;
  	///交易所保证金
    ExchangeMargin: TThostFtdcMoneyType;
  	///组合成交形成的持仓
    CombPosition: TThostFtdcVolumeType;
  	///组合多头冻结
    CombLongFrozen: TThostFtdcVolumeType;
  	///组合空头冻结
    CombShortFrozen: TThostFtdcVolumeType;
  	///逐日盯市平仓盈亏
    CloseProfitByDate: TThostFtdcMoneyType;
  	///逐笔对冲平仓盈亏
    CloseProfitByTrade: TThostFtdcMoneyType;
  	///今日持仓
    TodayPosition: TThostFtdcVolumeType;
  	///保证金率
    MarginRateByMoney: TThostFtdcRatioType;
  	///保证金率(按手数)
    MarginRateByVolume: TThostFtdcRatioType;
  	///执行冻结
    StrikeFrozen: TThostFtdcVolumeType;
  	///执行冻结金额
    StrikeFrozenAmount: TThostFtdcMoneyType;
  	///放弃执行冻结
    AbandonFrozen: TThostFtdcVolumeType;
  	///交易所代码
    ExchangeID: TThostFtdcExchangeIDType;
  	///执行冻结的昨仓
    YdStrikeFrozen: TThostFtdcVolumeType;
  	///投资单元代码
    InvestUnitID: TThostFtdcInvestUnitIDType;
  	///大商所持仓成本差值，只有大商所使用
    PositionCostOffset: TThostFtdcMoneyType;
  	///tas持仓手数
    TasPosition: TThostFtdcVolumeType;
  	///tas持仓成本
    TasPositionCost: TThostFtdcMoneyType;
  end;

  //成交
  PThostFtdcTradeField = ^CThostFtdcTradeField;

  CThostFtdcTradeField = record
  	///经纪公司代码
    BrokerID: TThostFtdcBrokerIDType;
  	///投资者代码
    InvestorID: TThostFtdcInvestorIDType;
  	///合约代码
    InstrumentID: TThostFtdcInstrumentIDType;
  	///报单引用
    OrderRef: TThostFtdcOrderRefType;
  	///用户代码
    UserID: TThostFtdcUserIDType;
  	///交易所代码
    ExchangeID: TThostFtdcExchangeIDType;
  	///成交编号
    TradeID: TThostFtdcTradeIDType;
  	///买卖方向
    Direction: TThostFtdcDirectionType;
  	///报单编号
    OrderSysID: TThostFtdcOrderSysIDType;
  	///会员代码
    ParticipantID: TThostFtdcParticipantIDType;
  	///客户代码
    ClientID: TThostFtdcClientIDType;
  	///交易角色
    TradingRole: TThostFtdcTradingRoleType;
  	///合约在交易所的代码
    ExchangeInstID: TThostFtdcExchangeInstIDType;
  	///开平标志
    OffsetFlag: TThostFtdcOffsetFlagType;
  	///投机套保标志
    HedgeFlag: TThostFtdcHedgeFlagType;
  	///价格
    Price: TThostFtdcPriceType;
  	///数量
    Volume: TThostFtdcVolumeType;
  	///成交时期
    TradeDate: TThostFtdcDateType;
  	///成交时间
    TradeTime: TThostFtdcTimeType;
  	///成交类型
    TradeType: TThostFtdcTradeTypeType;
  	///成交价来源
    PriceSource: TThostFtdcPriceSourceType;
  	///交易所交易员代码
    TraderID: TThostFtdcTraderIDType;
  	///本地报单编号
    OrderLocalID: TThostFtdcOrderLocalIDType;
  	///结算会员编号
    ClearingPartID: TThostFtdcParticipantIDType;
  	///业务单元
    BusinessUnit: TThostFtdcBusinessUnitType;
  	///序号
    SequenceNo: TThostFtdcSequenceNoType;
  	///交易日
    TradingDay: TThostFtdcDateType;
  	///结算编号
    SettlementID: TThostFtdcSettlementIDType;
  	///经纪公司报单编号
    BrokerOrderSeq: TThostFtdcSequenceNoType;
  	///成交来源
    TradeSource: TThostFtdcTradeSourceType;
  	///投资单元代码
    InvestUnitID: TThostFtdcInvestUnitIDType;
  end;

  //报单
  PThostFtdcOrderField = ^CThostFtdcOrderField;

  CThostFtdcOrderField = record
  	///经纪公司代码
    BrokerID: TThostFtdcBrokerIDType;
  	///投资者代码
    InvestorID: TThostFtdcInvestorIDType;
  	///合约代码
    InstrumentID: TThostFtdcInstrumentIDType;
  	///报单引用
    OrderRef: TThostFtdcOrderRefType;
  	///用户代码
    UserID: TThostFtdcUserIDType;
  	///报单价格条件
    OrderPriceType: TThostFtdcOrderPriceTypeType;
  	///买卖方向
    Direction: TThostFtdcDirectionType;
  	///组合开平标志
    CombOffsetFlag: TThostFtdcCombOffsetFlagType;
  	///组合投机套保标志
    CombHedgeFlag: TThostFtdcCombHedgeFlagType;
  	///价格
    LimitPrice: TThostFtdcPriceType;
  	///数量
    VolumeTotalOriginal: TThostFtdcVolumeType;
  	///有效期类型
    TimeCondition: TThostFtdcTimeConditionType;
  	///GTD日期
    GTDDate: TThostFtdcDateType;
  	///成交量类型
    VolumeCondition: TThostFtdcVolumeConditionType;
  	///最小成交量
    MinVolume: TThostFtdcVolumeType;
  	///触发条件
    ContingentCondition: TThostFtdcContingentConditionType;
  	///止损价
    StopPrice: TThostFtdcPriceType;
  	///强平原因
    ForceCloseReason: TThostFtdcForceCloseReasonType;
  	///自动挂起标志
    IsAutoSuspend: TThostFtdcBoolType;
  	///业务单元
    BusinessUnit: TThostFtdcBusinessUnitType;
  	///请求编号
    RequestID: TThostFtdcRequestIDType;
  	///本地报单编号
    OrderLocalID: TThostFtdcOrderLocalIDType;
  	///交易所代码
    ExchangeID: TThostFtdcExchangeIDType;
  	///会员代码
    ParticipantID: TThostFtdcParticipantIDType;
  	///客户代码
    ClientID: TThostFtdcClientIDType;
  	///合约在交易所的代码
    ExchangeInstID: TThostFtdcExchangeInstIDType;
  	///交易所交易员代码
    TraderID: TThostFtdcTraderIDType;
  	///安装编号
    InstallID: TThostFtdcInstallIDType;
  	///报单提交状态
    OrderSubmitStatus: TThostFtdcOrderSubmitStatusType;
  	///报单提示序号
    NotifySequence: TThostFtdcSequenceNoType;
  	///交易日
    TradingDay: TThostFtdcDateType;
  	///结算编号
    SettlementID: TThostFtdcSettlementIDType;
  	///报单编号
    OrderSysID: TThostFtdcOrderSysIDType;
  	///报单来源
    OrderSource: TThostFtdcOrderSourceType;
  	///报单状态
    OrderStatus: TThostFtdcOrderStatusType;
  	///报单类型
    OrderType: TThostFtdcOrderTypeType;
  	///今成交数量
    VolumeTraded: TThostFtdcVolumeType;
  	///剩余数量
    VolumeTotal: TThostFtdcVolumeType;
  	///报单日期
    InsertDate: TThostFtdcDateType;
  	///委托时间
    InsertTime: TThostFtdcTimeType;
  	///激活时间
    ActiveTime: TThostFtdcTimeType;
  	///挂起时间
    SuspendTime: TThostFtdcTimeType;
  	///最后修改时间
    UpdateTime: TThostFtdcTimeType;
  	///撤销时间
    CancelTime: TThostFtdcTimeType;
  	///最后修改交易所交易员代码
    ActiveTraderID: TThostFtdcTraderIDType;
  	///结算会员编号
    ClearingPartID: TThostFtdcParticipantIDType;
  	///序号
    SequenceNo: TThostFtdcSequenceNoType;
  	///前置编号
    FrontID: TThostFtdcFrontIDType;
  	///会话编号
    SessionID: TThostFtdcSessionIDType;
  	///用户端产品信息
    UserProductInfo: TThostFtdcProductInfoType;
  	///状态信息
    StatusMsg: TThostFtdcErrorMsgType;
  	///用户强评标志
    UserForceClose: TThostFtdcBoolType;
  	///操作用户代码
    ActiveUserID: TThostFtdcUserIDType;
  	///经纪公司报单编号
    BrokerOrderSeq: TThostFtdcSequenceNoType;
  	///相关报单
    RelativeOrderSysID: TThostFtdcOrderSysIDType;
  	///郑商所成交数量
    ZCETotalTradedVolume: TThostFtdcVolumeType;
  	///互换单标志
    IsSwapOrder: TThostFtdcBoolType;
  	///营业部编号
    BranchID: TThostFtdcBranchIDType;
  	///投资单元代码
    InvestUnitID: TThostFtdcInvestUnitIDType;
  	///资金账号
    AccountID: TThostFtdcAccountIDType;
  	///币种代码
    CurrencyID: TThostFtdcCurrencyIDType;
  	///IP地址
    IPAddress: TThostFtdcIPAddressType;
  	///Mac地址
    MacAddress: TThostFtdcMacAddressType;
  end;

  //资金账户
  PThostFtdcTradingAccountField = ^CThostFtdcTradingAccountField;

  CThostFtdcTradingAccountField = record
  	///经纪公司代码
    BrokerID: TThostFtdcBrokerIDType;
  	///投资者帐号
    AccountID: TThostFtdcAccountIDType;
  	///上次质押金额
    PreMortgage: TThostFtdcMoneyType;
  	///上次信用额度
    PreCredit: TThostFtdcMoneyType;
  	///上次存款额
    PreDeposit: TThostFtdcMoneyType;
  	///上次结算准备金
    PreBalance: TThostFtdcMoneyType;
  	///上次占用的保证金
    PreMargin: TThostFtdcMoneyType;
  	///利息基数
    InterestBase: TThostFtdcMoneyType;
  	///利息收入
    Interest: TThostFtdcMoneyType;
  	///入金金额
    Deposit: TThostFtdcMoneyType;
  	///出金金额
    Withdraw: TThostFtdcMoneyType;
  	///冻结的保证金
    FrozenMargin: TThostFtdcMoneyType;
  	///冻结的资金
    FrozenCash: TThostFtdcMoneyType;
  	///冻结的手续费
    FrozenCommission: TThostFtdcMoneyType;
  	///当前保证金总额
    CurrMargin: TThostFtdcMoneyType;
  	///资金差额
    CashIn: TThostFtdcMoneyType;
  	///手续费
    Commission: TThostFtdcMoneyType;
  	///平仓盈亏
    CloseProfit: TThostFtdcMoneyType;
  	///持仓盈亏
    PositionProfit: TThostFtdcMoneyType;
  	///期货结算准备金
    Balance: TThostFtdcMoneyType;
  	///可用资金
    Available: TThostFtdcMoneyType;
  	///可取资金
    WithdrawQuota: TThostFtdcMoneyType;
  	///基本准备金
    Reserve: TThostFtdcMoneyType;
  	///交易日
    TradingDay: TThostFtdcDateType;
  	///结算编号
    SettlementID: TThostFtdcSettlementIDType;
  	///信用额度
    Credit: TThostFtdcMoneyType;
  	///质押金额
    Mortgage: TThostFtdcMoneyType;
  	///交易所保证金
    ExchangeMargin: TThostFtdcMoneyType;
  	///投资者交割保证金
    DeliveryMargin: TThostFtdcMoneyType;
  	///交易所交割保证金
    ExchangeDeliveryMargin: TThostFtdcMoneyType;
  	///保底期货结算准备金
    ReserveBalance: TThostFtdcMoneyType;
  	///币种代码
    CurrencyID: TThostFtdcCurrencyIDType;
  	///上次货币质入金额
    PreFundMortgageIn: TThostFtdcMoneyType;
  	///上次货币质出金额
    PreFundMortgageOut: TThostFtdcMoneyType;
  	///货币质入金额
    FundMortgageIn: TThostFtdcMoneyType;
  	///货币质出金额
    FundMortgageOut: TThostFtdcMoneyType;
  	///货币质押余额
    FundMortgageAvailable: TThostFtdcMoneyType;
  	///可质押货币金额
    MortgageableFund: TThostFtdcMoneyType;
  	///特殊产品占用保证金
    SpecProductMargin: TThostFtdcMoneyType;
  	///特殊产品冻结保证金
    SpecProductFrozenMargin: TThostFtdcMoneyType;
  	///特殊产品手续费
    SpecProductCommission: TThostFtdcMoneyType;
  	///特殊产品冻结手续费
    SpecProductFrozenCommission: TThostFtdcMoneyType;
  	///特殊产品持仓盈亏
    SpecProductPositionProfit: TThostFtdcMoneyType;
  	///特殊产品平仓盈亏
    SpecProductCloseProfit: TThostFtdcMoneyType;
  	///根据持仓盈亏算法计算的特殊产品持仓盈亏
    SpecProductPositionProfitByAlg: TThostFtdcMoneyType;
  	///特殊产品交易所保证金
    SpecProductExchangeMargin: TThostFtdcMoneyType;
  	///业务类型
    BizType: TThostFtdcBizTypeType;
  	///延时换汇冻结金额
    FrozenSwap: TThostFtdcMoneyType;
  	///剩余换汇额度
    RemainSwap: TThostFtdcMoneyType;
  end;

  TQuotationData = record
    ///交易日
    TradingDay: TThostFtdcDateType;
  	///合约代码
    InstrumentID: TThostFtdcInstrumentIDType;
  	///交易所代码
    ExchangeID: TThostFtdcExchangeIDType;
  	///合约在交易所的代码
    ExchangeInstID: TThostFtdcExchangeInstIDType;
  	///最新价
    LastPrice: TThostFtdcPriceType;
  	///上次结算价
    PreSettlementPrice: TThostFtdcPriceType;
  	///昨收盘
    PreClosePrice: TThostFtdcPriceType;
  	///昨持仓量
    PreOpenInterest: TThostFtdcLargeVolumeType;
  	///今开盘
    OpenPrice: TThostFtdcPriceType;
  	///最高价
    HighestPrice: TThostFtdcPriceType;
  	///最低价
    LowestPrice: TThostFtdcPriceType;
  	///数量
    Volume: TThostFtdcVolumeType;
  	///成交金额
    Turnover: TThostFtdcMoneyType;
  	///持仓量
    OpenInterest: TThostFtdcLargeVolumeType;
  	///今收盘
    ClosePrice: TThostFtdcPriceType;
  	///本次结算价
    SettlementPrice: TThostFtdcPriceType;
  	///涨停板价
    UpperLimitPrice: TThostFtdcPriceType;
  	///跌停板价
    LowerLimitPrice: TThostFtdcPriceType;
  	///昨虚实度
    PreDelta: TThostFtdcRatioType;
  	///今虚实度
    CurrDelta: TThostFtdcRatioType;
  	///最后修改时间
    UpdateTime: TThostFtdcTimeType;
  	///最后修改毫秒
    UpdateMillisec: TThostFtdcMillisecType;
  	///申买价一
    BidPrice1: TThostFtdcPriceType;
  	///申买量一
    BidVolume1: TThostFtdcVolumeType;
  	///申卖价一
    AskPrice1: TThostFtdcPriceType;
  	///申卖量一
    AskVolume1: TThostFtdcVolumeType;
  	///申买价二
    BidPrice2: TThostFtdcPriceType;
  	///申买量二
    BidVolume2: TThostFtdcVolumeType;
  	///申卖价二
    AskPrice2: TThostFtdcPriceType;
  	///申卖量二
    AskVolume2: TThostFtdcVolumeType;
  	///申买价三
    BidPrice3: TThostFtdcPriceType;
  	///申买量三
    BidVolume3: TThostFtdcVolumeType;
  	///申卖价三
    AskPrice3: TThostFtdcPriceType;
  	///申卖量三
    AskVolume3: TThostFtdcVolumeType;
  	///申买价四
    BidPrice4: TThostFtdcPriceType;
  	///申买量四
    BidVolume4: TThostFtdcVolumeType;
  	///申卖价四
    AskPrice4: TThostFtdcPriceType;
  	///申卖量四
    AskVolume4: TThostFtdcVolumeType;
  	///申买价五
    BidPrice5: TThostFtdcPriceType;
  	///申买量五
    BidVolume5: TThostFtdcVolumeType;
  	///申卖价五
    AskPrice5: TThostFtdcPriceType;
  	///申卖量五
    AskVolume5: TThostFtdcVolumeType;
  	///当日均价
    AveragePrice: TThostFtdcPriceType;
  	///业务日期
    ActionDay: TThostFtdcDateType;
  end;


  //输入报单
  PThostFtdcInputOrderField = ^CThostFtdcInputOrderField;

  CThostFtdcInputOrderField = record
  	///经纪公司代码
    BrokerID: TThostFtdcBrokerIDType;
  	///投资者代码
    InvestorID: TThostFtdcInvestorIDType;
  	///合约代码
    InstrumentID: TThostFtdcInstrumentIDType;
  	///报单引用
    OrderRef: TThostFtdcOrderRefType;
  	///用户代码
    UserID: TThostFtdcUserIDType;
  	///报单价格条件
    OrderPriceType: TThostFtdcOrderPriceTypeType;
  	///买卖方向
    Direction: TThostFtdcDirectionType;
  	///组合开平标志
    CombOffsetFlag: TThostFtdcCombOffsetFlagType;
  	///组合投机套保标志
    CombHedgeFlag: TThostFtdcCombHedgeFlagType;
  	///价格
    LimitPrice: TThostFtdcPriceType;
  	///数量
    VolumeTotalOriginal: TThostFtdcVolumeType;
  	///有效期类型
    TimeCondition: TThostFtdcTimeConditionType;
  	///GTD日期
    GTDDate: TThostFtdcDateType;
  	///成交量类型
    VolumeCondition: TThostFtdcVolumeConditionType;
  	///最小成交量
    MinVolume: TThostFtdcVolumeType;
  	///触发条件
    ContingentCondition: TThostFtdcContingentConditionType;
  	///止损价
    StopPrice: TThostFtdcPriceType;
  	///强平原因
    ForceCloseReason: TThostFtdcForceCloseReasonType;
  	///自动挂起标志
    IsAutoSuspend: TThostFtdcBoolType;
  	///业务单元
    BusinessUnit: TThostFtdcBusinessUnitType;
  	///请求编号
    RequestID: TThostFtdcRequestIDType;
  	///用户强评标志
    UserForceClose: TThostFtdcBoolType;
  	///互换单标志
    IsSwapOrder: TThostFtdcBoolType;
  	///交易所代码
    ExchangeID: TThostFtdcExchangeIDType;
  	///投资单元代码
    InvestUnitID: TThostFtdcInvestUnitIDType;
  	///资金账号
    AccountID: TThostFtdcAccountIDType;
  	///币种代码
    CurrencyID: TThostFtdcCurrencyIDType;
  	///交易编码
    ClientID: TThostFtdcClientIDType;
  	///IP地址
    IPAddress: TThostFtdcIPAddressType;
  	///Mac地址
    MacAddress: TThostFtdcMacAddressType;
  end;

  PThostFtdcInputOrderActionField = ^CThostFtdcInputOrderActionField;

  CThostFtdcInputOrderActionField = record
    BrokerID: TThostFtdcBrokerIDType;
  	///投资者代码
    InvestorID: TThostFtdcInvestorIDType;
  	///报单操作引用
    OrderActionRef: TThostFtdcOrderActionRefType;
  	///报单引用
    OrderRef: TThostFtdcOrderRefType;
  	///请求编号
    RequestID: TThostFtdcRequestIDType;
  	///前置编号
    FrontID: TThostFtdcFrontIDType;
  	///会话编号
    SessionID: TThostFtdcSessionIDType;
  	///交易所代码
    ExchangeID: TThostFtdcExchangeIDType;
  	///报单编号
    OrderSysID: TThostFtdcOrderSysIDType;
  	///操作标志
    ActionFlag: TThostFtdcActionFlagType;
  	///价格
    LimitPrice: TThostFtdcPriceType;
  	///数量变化
    VolumeChange: TThostFtdcVolumeType;
  	///用户代码
    UserID: TThostFtdcUserIDType;
  	///合约代码
    InstrumentID: TThostFtdcInstrumentIDType;
  	///投资单元代码
    InvestUnitID: TThostFtdcInvestUnitIDType;
  	///IP地址
    IPAddress: TThostFtdcIPAddressType;
  	///Mac地址
    MacAddress: TThostFtdcMacAddressType;
  end;

  PThostFtdcRspInfoField = ^CThostFtdcRspInfoField;

  CThostFtdcRspInfoField = record
  	///错误代码
    ErrorID: TThostFtdcErrorIDType;
  	///错误信息
    ErrorMsg: TThostFtdcErrorMsgType;
  end;


  {DF期权相关数据结构}
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

  ///消息包头.

  TDF_MsgHead = record
    sFlags: Word;							///< 版本标识符.
    nDataType: Integer;						///< 数据类型.
    nDataLen: Integer;   					///< 数据长度.
    nDate: Integer;							///< 日期[YYYYMMDD].
    nTime: Integer;							///< 时间戳[精确到毫秒HHMMSSmmm].
    iOrder: Int64;							///< 流水号.
  end;
  
  ///应用包头.
  TDF_AppHead = record
    nRequestID: Integer;						///< 请求标识（拷贝返回）.
    nAnsResult: Integer;						///< 应答结果.
    szInfo: array[0..127] of Char;					///< 命令信息.
    nItemAmount: Integer;					///< 记录表数量 最多5项数据.
    arrnAppItems: array[0..4] of Integer;					///< 数据项数据的个数.
    arrnAppItemSize: array[0..4] of Integer;				///< 数据项数据的结构大小.
  end;
  
  ///行情订阅头部结构信息.
  TDF_SubscriptionHead = record
    nSubscriptionType: Integer;				///< 类型:[0-设置 1-增加 2-删除 3-取消所有订阅].		///< 可参见  DF_SUB_TYPE .
    nItems: Integer;							///< 指示其后的本日编号数目.
  end;

  TDF_ReqMarkets = record
    nMarketID: Integer;						///< 市场类型ID(DF_MARKET_TYPE).
    nFlags: Integer;							///< 由MARKET_FLAGS_定义.
    nTime: Integer;							///< 行情指定时间点回放数据（时间格式：HHMMSS，如果该项设置则[设置市场属性]将自动失效）.
  end;

  TDF_Heartbeat = record
    nBeatType: Integer;						///< 心跳类型（DF_HEARTBEAT_TYPE）.
    nBeatFrequency: Integer;					///< 心跳频率（nBeatType为1或2时有效,间隔时间（秒),值限制必须大于3 小于1000）.
    nTimeOut: Integer;						///< 允许超时（nBeatType为1或2时有效,间隔时间（秒),值限制必须大于5,且大于nBeatFrequency）.
  end;
  
  ///行情登录请求应答.
  TDF_MarketLoginAnswer = record
    szInfo: array[0..127] of Char;					///< 应答信息.
    szUserName: array[0..15] of Char;					///< 用户账号.
    szPassword: array[0..15] of Char;					///< 用户密码.
    nAnswerResult: Integer;					///< 应答结果 0表示登录成功,负数表示失败.
    nMarketAmount: Integer;					///< 当前提供行情市场个数.
    arrnMarketID: array[0..MAX_MARKET_NUM - 1] of Integer;		///< 服务市场标志[系统预留32个市场].
    arrnMarketDate: array[0..MAX_MARKET_NUM - 1] of Integer;	///< 对应市场行情日期[系统预留32个市场].
  end;
  
  ///心跳应答.
  TDF_HeartbeatAns = record
    nTime: Integer;							///< 应答时间(HHMMSSmmm).
  end;
  
  
  ///请求代码列表返回数据头部.
  TDF_CodeTableHead = record
    nMarketID: Integer;						///< 市场类型ID.
    nDate: Integer;							///< 日期.
    nItems: Integer;							///< 代码数量数量.
  end;
  
  
  ///期权基本信息应答头部结构信息.
  TDF_OptionBasicHead = record
    nMarketID: Integer;						///< 市场标志ID(DF_MARKET_TYPE).
    nDate: Integer;							///< 基本信息日期.
    nItems: Integer;							///< 基本信息项数.
  end;
  
  ///订阅代码对象.
  TDF_SubscriptionCode = record
    szMarketFlag: array[0..3] of Char;					///< 市场标志("SZS","SHS","CFF","SCE","ZCE","DCE","SHO","SZO"）
    szSymbol: array[0..23] of Char;					///< 代码唯一标识(股票代码/期货合约交易代码/期权合约期权合约编).
  end;
  
  //期权基本信息
  TDF_OptionBasicInfo = record
    nDate: Integer;	///<	日期.
    szSecurityID: array[0..15] of Char;	///<	合约编码	C8	(期权合约的合约编码).
    szContractID: array[0..23] of Char;	///<	合约交易代码	C19.
    szContractSymbol: array[0..23] of Char;	///<	期权合约简称	C20.
    szUnderlyingSecurityID: array[0..7] of Char;	///<	标的证券代码	C6.
    szUnderlyingSymbol: array[0..15] of Char;	///<	基础证券证券名称	C8	.
    szUnderlyingType: array[0..3] of Char;	///<	标的证券类型	C3	(EBS–ETF，	ASH–A股).
    chOptionType: Char;	///<	欧式美式	C1	(若为欧式期权，则本字段为“E”；若为美式期权，则本字段为“A”).
    chCallOrPut: Char;	///<	认购认沽	C1	认购，则本字段为“C”；若为认沽，则本字段为“P”.
    iContractMultiplierUnit: Int64;	///<	合约单位	N11	(经过除权除息调整后的合约单位).
    unExercisePrice: Cardinal;	///<	期权行权价	N11(4)	(经过除权除息调整后的期权行权价，精确到0.1厘).
    nStartDate: Integer;	///<	首个交易日(YYYYMMDD)	C8.
    nEndDate: Integer;	///<	最后交易日(YYYYMMDD)	C8.
    nExerciseDate: Integer;	///<	期权行权日(YYYYMMDD)	C8.
    nDeliveryDate: Integer;	///<	行权交割日(YYYYMMDD)	C8.
    nExpireDate: Integer;	///<	期权到期日(YYYYMMDD)	C8.
    chUpdateVersion: Char;	///<	合约版本号	C1.
    iTotalLongPosition: Int64;	///<	当前合约未平仓数	N12	(单位是	（张）).
    unSecurityClosePx: Cardinal;	///<	合约前收盘价	N11(4)	(昨日收盘价，右对齐，精确到厘).
    unSettlPrice: Cardinal;	///<	合约前结算价	N11(4)	(昨日结算价，如遇除权除息则为调整后的结算价（合约上市首日填写参考价），右对齐，精确到0.1厘).
    unUnderlyingClosePx: Cardinal;	///<	标的证券前收盘价	N11(4)	(期权标的证券除权除息调整后的前收盘价格，右对齐，精确到0.1厘).
    chPriceLimitType: Char;	///<	涨跌幅限制类型	C1	(‘N’有涨跌幅限制类型).
    unUpLimitDailyPrice: Cardinal;	///<	涨幅上限价格	N11(4)	(当日期权涨停价格，精确到0.1厘).
    unDownLimitDailyPrice: Cardinal;	///<	跌幅下限价格	N11(4)	(当日期权跌停价格，精确到0.1厘).
    dMarginUnit: Double;	///<	单位保证金	N16(2)	(当日持有一张合约所需要的保证金数量，精确到分).
    nMarginRatioParam1: Integer;	///<	保证金计算比例参数一	N3	(保证金计算参数，单位：%).
    nMarginRatioParam2: Integer;	///<	保证金计算比例参数二	N3	(保证金计算参数，单位：%).
    iRoundLot: Int64;	///<	整手数	N12	一手对应的合约数.
    iLmtOrdMinFloor: Int64;	///<	单笔限价申报下限	N12	(单笔限价申报的申报张数下限。).
    iLmtOrdMaxFloor: Int64;	///<	单笔限价申报上限	N12	(单笔限价申报的申报张数上限。).
    iMktOrdMinFloor: Int64;	///<	单笔市价申报下限	N12	(单笔市价申报的申报张数下限。).
    iMktOrdMaxFloor: Int64;	///<	单笔市价申报上限	N12	(单笔市价申报的申报张数上限。).
    szSecurityStatusFlag: array[0..7] of Char;	///<	期权合约状态信息标签	C8	(该字段为8位字符串，左起每位表示特定的含义，无定义则填空格。).
  	///第1位：‘0’表示可开仓，‘1’表示限制卖出开仓（包括备兑开仓）和买入开仓。
  	///第2位：‘0’表示未连续停牌，‘1’表示连续停牌。
  	///第3位：‘0’表示未临近到期日，‘1’表示距离到期日不足10个交易日。
  	///第4位：‘0’表示近期未做调整，‘1’表示最近10个交易日内合约发生过调整。
  	///第5位：‘A’表示当日新挂牌的合约，‘E’表示存续的合约，‘D’表示当日摘牌的合约。
    unTickSize:Cardinal		///<	最小报价单位	N11(4)	单位：元，精确到0.1厘(行情通讯按价格类型处理)	.
  end;

  TDF_OptionMarketData = record
    nIdnum: Integer;	///<	本日编号(代码在所属市场的编号*100	+	市场编号(以DF_MARKET_TYPE枚举为准)).
  	//如：1201。计算方式：	;
  	//1201%100	;	1表示交易所编号，1就为上海股票；
  	//1201/100	;	12表示这只证券在所属市场的编号；
    nDate: Integer;	///<	行情日期.
    nTime: Integer;	///<	行情时间(HHMMSSmmm)
    iTotalLongPosition: Int64;	///<	当前合约未平仓数	N12	（单位是	（张））.
    iTradeVolume: Int64;	///<	总成交数量	N16.
    dTotalValueTraded: Double;	///<	成交金额	N16(2)	（精确到分）.
    unPreSettlPrice: Cardinal;	///<	昨日结算价	N11(4)	（精确到0.1厘）.
    unOpenPrice: Cardinal;	///<	今日开盘价	N11(4)	（精确到0.1厘）.
    unAuctionPrice: Cardinal;	///<	动态参考价格	N11(4)	（波动性中断参考价，精确到0.1厘）.
    iAuctionQty: Int64;	///<	虚拟匹配数量	N12.
    unHighPrice: Cardinal;	///<	最高价	N11(4)	（精确到0.1厘）.
    unLowPrice: Cardinal;	///<	最低价	N11(4)	（精确到0.1厘）.
    unTradePrice: Cardinal;	///<	最新价	N11(4)	（最新成交价，精确到0.1厘）.
    arrunBuyPrice_5: array[0..4] of Cardinal;	///<	申买价	N11(4)	（当前买入价（当前最优价），精确到0.1厘）.
    arriBuyVolume_5: array[0..4] of Int64;	///<	申买量	N12.
    arrunSellPrice_5: array[0..4] of Cardinal;	///<	申卖价	N11(4)	(当前卖出价（当前最优价），精确到0.1厘).
    arriSellVolume_5: array[0..4] of Int64;	///<	申卖量	N12.
    unSettlPrice: Cardinal;	///<	今日结算价	N11(4)	***交易所期权行情目前取消了结算价的发布***.
    szTradingPhaseCode: array[0..3] of Char;	///<	产品实时阶段及标志	C4	(该字段为4位字符串，左起每位表示特定的含义，无定义则填空格。).
  	//第1位：‘S’表示启动（开市前）时段，‘C’表示集合竞价时段，‘T’表示连续交易时段，‘B’表示休市时段，‘E’表示闭市时段，‘V’表示波动性中断，‘P’表示临时停牌、‘U’表示收盘集合竞价。	;
  	//第2位：‘0’表示未连续停牌，‘1’表示连续停牌。（预留，暂填空格）	;
  	//第3位：‘0’表示不限制开仓，‘1’表示限制备兑开仓，‘2’表示卖出开仓，‘3’表示限制卖出开仓、备兑开仓，‘4’表示限制买入开仓，‘5’表示限制买入开仓、备兑开仓，‘6’表示限制买入开仓、卖出开仓，‘7’表示限制买入开仓、卖出开仓、备兑开仓	;
    unSD1: Cardinal;	///<	升跌1（最新价对比减上一个价格）（精确到0.1厘）.
  end;

  TDF_CodeInfo = record
    nIdnum: Integer;							///< 本日编号(代码在所属市场的编号*100 + 市场编号(以DF_MARKET_TYPE枚举为准)).
  	//如：1201。计算方式：
  	//1201%100 = 1表示交易所编号，1就为上海股票；
  	//1201/100 = 12表示这只证券在所属市场的编号；
    nType: Integer;							///< 代码类型(见注释文档).
    szID: array[0..15] of Char;						///< 期权合约编码.
    szCode: array[0..23] of Char;						///< 股票代码/期货与期权合约交易代码.
    szName: array[0..31] of Char;						///< 股票名称/期货与期权合约简称.
  end;
  
  {$A1-}

  
  {DF现货行情相关数据结构}
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
  {现货}

  DFDAPI_MSG_ID = (MSG_INVALID = -100,
  	
  	///< 系统消息
    MSG_SYS_DISCONNECT_NETWORK,							///< 网络断开事件, 相应的结构体为NULL
    MSG_SYS_CONNECT_RESULT,								///< 主动发起连接的结果
    MSG_SYS_LOGIN_RESULT,								///< 登陆应答
    MSG_SYS_CODETABLE_RESULT,							///< 代码表结果，收到此消息后可获取对应代码表,此消息表示所有授权市场代码表可取
    MSG_SYS_QUOTATIONDATE_CHANGE,						///< 行情日期变更通知（已取消）
    MSG_SYS_MARKET_CLOSE,								///< 闭市（已取消）
    MSG_SYS_HEART_BEAT,									///< 服务器心跳消息, 相应的结构体为NULL
    MSG_SYS_MARKET_EVENT,								///< 市场事件通知消息(如市场清盘，转数等),收到此事件的清盘或者快照后可获取快照和期权信息
  	
  	//单个市场代码表通知.由于某些较小市场数据回调时，同时请求的其他市场才处理完代码表，行情数据较MSG_SYS_CODETABLE_RESULT先到，
  	//增加该消息，通知每一市场代码表处理结果，客户可据此选择何时请求代码表
    MSG_SYS_SINGLE_CODETABLE_RESULT,					///< 单个市场代码表结果，收到此消息后可获取对应的单个市场代码表
    MSG_SYS_QUOTEUNIT_CHANGE,							///< 价差变化
    MSG_SYS_PACK_OVER,									///< 当前网络包解析完毕
  
  	///< 数据消息
    MSG_DATA_INDEX,										///< 指数数据
    MSG_DATA_MARKET,									///< 行情数据
    MSG_DATA_FUTURE,									///< 期货行情
    MSG_DATA_HKEX,										///< 港股行情
    MSG_DATA_TRANSACTION,								///< 逐笔成交
    MSG_DATA_ORDERQUEUE,								///< 委托队列
    MSG_DATA_ORDER,										///< 逐笔委托
    MSG_DATA_BBQTRANSACTION,							///< BBQ现券成交数据
    MSG_DATA_BBQBID,									///< BBQ现券报价数据
    MSG_DATA_NON_MD,									///< 非行情消息
    MSG_DATA_OTC_OPTION,								///< 场外期权
    MSG_DATA_BROKERQUEUE,								///< 经纪商队列(港股)
    MSG_SH_ETF_LIST,									///< 收到沪市ETF清单信息.
    MSG_SZ_ETF_LIST,									///< 收到深市ETF清单信息.
    MSG_UPDATE_ETFLIST,									///< ETF清单有更新,沪深两市需请重新获取.
    MSG_HKEX_BASICINFO,									///< 港股基本信息更新,请获取.
    MSG_DATA_OPTION,									///< 期权行情
    MSG_OPTION_BASICINFO								///< 期权基本信息更新,请获取.
);

  DFDAPI_SET_ENVIRONMENT = (DFDAPI_ENVIRON_HEART_BEAT_INTERVAL,					///< Heart Beat间隔（秒数）, 若值为0则表示默认值10秒钟
  	//DFDAPI_ENVIRON_MISSED_BEAT_COUNT,					///< 如果没有收到心跳次数超过这个值，且没收到其他任何数据，则判断为掉线，若值0为默认次数2次
    DFDAPI_ENVIRON_OPEN_TIME_OUT,						///< 在调DFDAPI_Open期间，接收每一个数据包的超时时间（秒数，不是DFDAPI_Open调用总的最大等待时间），若值为0则默认30秒
    DFDAPI_ENVIRON_USE_PACK_OVER, DFDAPI_ENVIRON_HEART_BEAT_FLAG,						///< 心跳数据发送方式（0: 取消发送心跳包 1：没有数据发送的时候发送心跳数据，2：有规律发送心跳数据）
    DFDAPI_ENVIRON_SOURCE_MODE,							///< 双活数据源模式,值参考DFDAPI_SOURCE_SETTING枚举类
    DFDAPI_ENVIRON_SOURCE_MODE_VALUE,					///< 双活数据源模式下参数的值
    DFDAPI_ENVIRON_OUT_LOG,								///< 1、当前目录下创建log，否则在当前路径有log文件夹时创建到log文件夹中
    DFDAPI_ENVIRON_SNAPSHOT_ENENT,						///< 1、发送快照事件和清盘通知但快照不发送到回调函数，否则直接发送快照到回调函数，无快照通知
    DFDAPI_ENVIRON_ORIGINAL_VOL,						///< 原始结构有效，1、指数成交量和成交额的单位为股和元，默认为100股和100元
    DFDAPI_ENVIRON_BREAKPOINT,							///< 1.网络断开后断点续传，else.请求最新快照
    DFDAPI_ENVIRON_PUSHMODE							///< 0:启用默认订阅推送；1:禁用默认订阅推送。
);

  DFDAPI_ERR_CODE = (DFDAPI_ERR_UNKOWN = -400,							///< 未知错误
    DFDAPI_ERR_UNINITIALIZE = -399,						///< 接口环境未初始化
    DFDAPI_ERR_INITIALIZE_FAILURE = -200,				///< 初始化socket环境失败
    DFDAPI_ERR_NETWORK_ERROR,							///< 网络连接出现问题
    DFDAPI_ERR_INVALID_PARAMS,							///< 输入参数无效
    DFDAPI_ERR_VERIFY_FAILURE,							///< 登陆验证失败：原因为用户名或者密码错误；超出登陆数量
    DFDAPI_ERR_NO_AUTHORIZED_MARKET,					///< 所有请求的市场都没有授权
    DFDAPI_ERR_NO_CODE_TABLE,							///< 所有请求的市场该天都没有代码表
    DFDAPI_ERR_NO_BASICINFO,							///< 所有请求的市场基本信息数据为空.
    DFDAPI_ERR_SUCCESS = 0								///< 成功
);

  SUBSCRIPTION_STYLE = (SUBSCRIPTION_SET = 0,								///< 设置订阅行情，再次设置订阅时会自动取消之前所有订阅代码.
    SUBSCRIPTION_ADD = 1,								///< 增加订阅代码
    SUBSCRIPTION_DEL = 2								///< 删除订阅代码
);

  {$Z4-}
  ///< 行情快照：MSG_DATA_MARKET.
  DFDAPI_MARKET_DATA = record
    szWindCode: array[0..31] of Char;								///< 600001.SH
    szCode: array[0..31] of Char;									///< 原始Code
    nActionDay: Integer;									///< 业务发生日(自然日)
    nTradingDay: Integer;								///< 交易日
    nTime: Integer;										///< 时间(HHMMSSmmm)
    nStatus: Integer;									///< 状态
    nPreClose: Int64;									///< 前收盘价
    nOpen: Int64;										///< 开盘价
    nHigh: Int64;										///< 最高价
    nLow: Int64;										///< 最低价
    nMatch: Int64;										///< 最新价
    nAskPrice: array[0..9] of Int64;								///< 申卖价
    nAskVol: array[0..9] of Int64;								///< 申卖量
    nBidPrice: array[0..9] of Int64;								///< 申买价
    nBidVol: array[0..9] of Int64;								///< 申买量
    nNumTrades: Integer;									///< 成交笔数
    iVolume: Int64;									///< 成交总量
    iTurnover: Int64;									///< 成交总金额
    nTotalBidVol: Int64;								///< 委托买入总量
    nTotalAskVol: Int64;								///< 委托卖出总量
    nWeightedAvgBidPrice: Int64;						///< 加权平均委买价格
    nWeightedAvgAskPrice: Int64;						///< 加权平均委卖价格
    nIOPV: Integer;										///< IOPV净值估值
    nYieldToMaturity: Integer;							///< 到期收益率
    nHighLimited: Int64;								///< 涨停价
    nLowLimited: Int64;								///< 跌停价
    chPrefix: array[0..3] of Char;								///< 证券信息前缀
    nSyl1: Integer;										///< 市盈率1
    nSyl2: Integer;										///< 市盈率2
    nSD2: Integer;										///< 升跌2（对比上一笔）
    	//const DFDAPI_CODE_INFO *  pCodeInfo;					///< 代码信息， DFDAPI_Close，清盘重连后，此指针无效
  end;
  
  
  
    ///< 指数行情快照：MSG_DATA_INDEX.
  DFDAPI_INDEX_DATA = record
    szWindCode: array[0..31] of Char;								///< 600001.SH
    szCode: array[0..31] of Char;									///< 原始Code
    nActionDay: Integer;									///< 业务发生日(自然日)
    nTradingDay: Integer;								///< 交易日
    nTime: Integer;										///< 时间(HHMMSSmmm)
    nStatus: Integer;									///< 状态，20151223新增
    nOpenIndex: Int64;									///< 今开盘指数
    nHighIndex: Int64;									///< 最高指数
    nLowIndex: Int64;									///< 最低指数
    nLastIndex: Int64;									///< 最新指数
    iTotalVolume: Int64;								///< 参与计算相应指数的交易数量
    iTurnover: Int64;									///< 参与计算相应指数的成交金额
    nPreCloseIndex: Int64;								///< 前盘指数
    	//const DFDAPI_CODE_INFO *  pCodeInfo;					///< 代码信息， DFDAPI_Close，清盘重连后，此指针无效
  end;
  
  
    ///< 应用头
  DFDAPI_APP_HEAD = record
    nHeadSize: Integer;										///< 本记录结构大小
    nItemCount: Integer;										///< 记录条数
    nItemSize: Integer;										///< 记录大小
  end;
  
    ///< 数据消息结构
  DFDAPI_CALLBACK_MSG = record
    nDataType: Integer;					///< 数据类型
    nDataLen: Integer;					///< 数据长度（不包括DFDAPI_APP_HEAD的长度）
    nServerTime: Integer;				///< 服务器本地时间戳（精确到毫秒HHMMSSmmm）
    nConnectId: Integer;					///< 连接ID
    pAppHead: PDFDAPI_APP_HEAD;					///< 应用头
    pData: Pointer;						///< 数据指针
  end;
  
  
    ///< 代码表信息.
  DFDAPI_CODEINFO = record
    szWindCode: array[0..31] of Char;									///< 000001.SZ;600000.SH;IH1711.CFF;
    szSecurityID: array[0..15] of Char;									///< 今古行情证券代码.
    szSecurityCode: array[0..23] of Char;								///< 交易所原始证券代码.
    szMarket: array[0..7] of Char;										///< SZ;SH;CFF;SHO;SZO;
    szENName: array[0..31] of Char;										///< 英文名称.
    szCNName: array[0..31] of Char;										///< 证券名称.
    nType: Integer;												///< 证券类型.
  end;
  
  
  //服务器配置信息
  DFDAPI_SERVER_INFO = record
    szIp: array[0..31] of char;											///< IP
    nPort: SmallInt;											///< 端口
    szUser: array[0..63] of Char;										///< 用户名
    szPwd: array[0..63] of Char;											///< 密码
    bDoMain: Boolean;											///< 是否使用域名
  end;

  DFDAPI_OPEN_CONNECT_SET = record
    ServerInfo: array[0..JGAPI_SERVERINFO_MAX - 1] of DFDAPI_SERVER_INFO;	///< 服务器信息
    unServerNum: Cardinal;								///< 服务器数量
    data_fun: Pointer;							///< 数据消息处理回调
    notice_fun: Pointer;						///< 系统消息通知回调
      	///< 订阅设置 注意：订阅是市场独立的！对于每个市场必须订阅市场或代码，只订阅市场，则发送此市场全部代码
    szMarkets: PChar;									///< 市场订阅！例如"SZ;SH;CF;SHF;DCE;SHF"，需要订阅的市场列表，以“;”分割.
    szSubScriptions: PChar;							///< 代码订阅！例如"600000.sh;IH1711.cf;000001.sz"，需要订阅的股票，以“;”分割.
    szTypeFlags: PChar;								///< 数据类型订阅！支持订阅3种类型TRANSACTION;ORDER;ORDERQUEUE。！注意：行情数据任何时候都发送，不需要订阅! 参见enum DATA_TYPE_FLAG.
    nTime: Cardinal;										///< 为0则请求实时行情，为0xffffffff从头请求.
    nConnectionID: Cardinal;								///< 连接ID，连接回调消息的附加结构 DFDAPI_CONNECT_RESULT中 会包含这个ID，消息头也会包含该ID.
  end;
    {现货}

  
    ///< 系统消息：MSG_SYS_CODETABLE_RESULT 对应的结构

  DFDAPI_CODE_RESULT = record
    szInfo: array[0..127] of Char;										///< 代码表结果文本
    nMarkets: Integer;											///< 市场个数
    szMarket: array[0..255, 0..7] of Char;									///< 市场代码
    nCodeCount: array[0..255] of Integer;									///< 代码表项数
    nCodeDate: array[0..255] of Integer;										///< 代码表日期
  end;

  ///< 连接结果：MSG_SYS_CONNECT_RESULT
  DFDAPI_CONNECT_RESULT = record
    szIp: array[0..31] of Char;
    szPort: array[0..7] of Char;
    szUser: array[0..63] of Char;
    szPwd: array[0..63] of Char;
    nConnResult: Cardinal;								///< 为0则表示连接成功，非0则表示连接失败
    nConnectionID: Integer;										///< 连接ID
  end;

  {$A1-}

  {$A8+}
  {期权交易}
  ///< 用户登陆应答
  PCJGtdcRspUserLogin = ^TCJGtdcRspUserLogin;

  TCJGtdcRspUserLogin = record
    ClientID: TJGtdcClientIDType;                    ///< 客户号
    FundAccount: TJGtdcFundAccountType;              ///< 资金账号
    SupportSubType: TJGtdcSupportSubType;			///< 支持的订阅类型
  end;

  ///< 响应信息
  PCJGtdcRspInfoField = ^TCJGtdcRspInfoField;

  TCJGtdcRspInfoField = record
    ResultType: TJGtdcResultType;                   ///< 应答结果
    ErrorInfo: TJGtdcErrorInfoType;                  ///< 错误信息
    nFieldItem: Integer;                                 ///< 应答数据个数
  end;

  ///< 用户登出应答
  PCJGtdcRspUserLogout = ^TCJGtdcRspUserLogout;

  TCJGtdcRspUserLogout = record
    ClientID: TJGtdcClientIDType;                    ///< 客户号
    FundAccount: TJGtdcFundAccountType;              ///< 资金账号
  end;


 ///< 投资者期权委托下单应答
  PCJGtdcOptionRspEntrust = ^TCJGtdcOptionRspEntrust;

  TCJGtdcOptionRspEntrust = record
    ResultType: TJGtdcResultType;	    ///< 应答结果
    ErrorInfo: TJGtdcErrorInfoType;		///< 错误信息
    EntrustNo: TJGtdcEntrustNoType;		///< 合同号
    BatchNo: TJGtdcBatchNoType;			///< 批号
    ExchangeType: TJGtdcExchangeType;	///< 市场类型
    StockAccount: TJGtdcStockAccountType;
    ContractNumber: TJGtdcContractNumber;
    TradeType: TJGtdcTradeType;			///< 交易类型
    OffsetType: TJGtdcOffsetType;		///< 开平仓类型
    CoveredType: TJGtdcCoveredType;		///< 备兑标识
    PriceType: TJGtdcPriceType;			///< 价格类型
    EntrustAmount: TJGtdcOrderVolume;	///< 委托数量
    EntrustPrice: TJGtdcOrderPrice;		///< 委托价格
  end;

  ///< 投资者期权委托撤单应答
  PCJGtdcOptionRspCancel = ^TCJGtdcOptionRspCancel;

  TCJGtdcOptionRspCancel = record
    ResultType: TJGtdcResultType;	///<	应答结果
    ErrorInfo: TJGtdcErrorInfoType;	///<	错误信息
    EntrustNo: TJGtdcEntrustNoType;	///<	合同号
    NewEntrustNo: TJGtdcNewEntrustNoType;	///<	新合同号
    BatchNo: TJGtdcBatchNoType;	///<	批号
  end;

  ///< 投资者期权委托查询应答
  PCJGtdcOptionRspQryEntrust = ^TCJGtdcOptionRspQryEntrust;

  TCJGtdcOptionRspQryEntrust = record
    BranchNo: TJGtdcBranchNoType;	///<	营业部号
    ClientID: TJGtdcClientIDType;	///<	客户号
    FundAccount: TJGtdcFundAccountType;	///<	资金账号
    ExchangeType: TJGtdcExchangeType;	///<	市场类型
    StockAccount: TJGtdcStockAccountType;	///<	股东代码
    SeatNo: TJGtdcSeatNoType;	///<	席位号
    ContractNumber: TJGtdcContractNumber;	///<	合约编码
    ContractCode: TJGtdcContractCodeType;	///<	合约代码
    ContractName: TJGtdcContractNameType;	///<	合约名称
    StockCode: TJGtdcStockCodeType;	///<	证券代码
    StockName: TJGtdcStockNameType;	///<	证券名称
    PositionStr: TJGtdcPositionStrType;	///<	定位串
    EntrustNo: TJGtdcEntrustNoType;	///<	合同号
    ReportNo: TJGtdcReportNoType;	///<	申报号
    BatchNo: TJGtdcBatchNoType;	///<	批号
    MoneyType: TJGtdcMoneyType;	///<	币种
    EntrustStatus: TJGtdcEntrustStatus;	///<	委托状态
    TradeType: TJGtdcTradeType;	///<	交易类型
    OffsetType: TJGtdcOffsetType;	///<	开平仓类型
    CoveredType: TJGtdcCoveredType;	///<	备兑标识
    PriceType: TJGtdcPriceType;	///<	价格类型
    EntrustDate: TJGtdcDate;	///<	委托日期
    EntrustTime: TJGtdcTime;	///<	委托时间
    EntrustAmount: TJGtdcOrderVolume;	///<	委托数量
    EntrustPrice: TJGtdcOrderPrice;	///<	委托价格
    BusinessAmount: TJGtdcBuinessVolume;	///<	成交数量
    BusinessPrice: TJGtdcBusinessPrice;	///<	成交价格
    CancelAmount: TJGtdcCancelVolume;	///<	撤销数量
    BusinessBalance: TJGtdcBusinessBalance;	///<	成交金额
    InvalidReason: TJGtdcInvalidReason;	///<	废单原因
  end;

  ///< 投资者期权增量成交查询应答
  PCJGtdcOptionRspQryBusByPos = ^TCJGtdcOptionRspQryBusByPos;

  TCJGtdcOptionRspQryBusByPos = record
    BranchNo: TJGtdcBranchNoType;	///<	营业部号
    ClientID: TJGtdcClientIDType;	///<	客户号
    FundAccount: TJGtdcFundAccountType;	///<	资金账号
    ExchangeType: TJGtdcExchangeType;	///<	市场类型
    StockAccount: TJGtdcStockAccountType;	///<	股东代码
    SeatNo: TJGtdcSeatNoType;	///<	席位号
    ContractNumber: TJGtdcContractNumber;	///<	合约编码
    ContractCode: TJGtdcContractCodeType;	///<	合约代码
    ContractName: TJGtdcContractNameType;	///<	合约名称
    StockCode: TJGtdcStockCodeType;	///<	证券代码
    StockName: TJGtdcStockNameType;	///<	证券名称
    PositionStr: TJGtdcPositionStrType;	///<	定位串
    EntrustNo: TJGtdcEntrustNoType;	///<	合同号
    ReportNo: TJGtdcReportNoType;	///<	申报号
    BatchNo: TJGtdcBatchNoType;	///<	批号
    BusinessNo: TJGtdcBusinessNoType;	///<	成交号
    MoneyType: TJGtdcMoneyType;	///<	币种
    BusinessStatus: TJGtdcBusinessStatus;	///<	成交状态
    TradeType: TJGtdcTradeType;	///<	交易类型
    OffsetType: TJGtdcOffsetType;	///<	开平仓类型
    CoveredType: TJGtdcCoveredType;	///<	备兑标识
    PriceType: TJGtdcPriceType;	///<	价格类型
    BusinessDate: TJGtdcDate;	///<	成交日期
    BusinessTime: TJGtdcTime;	///<	成交时间
    EntrustAmount: TJGtdcOrderVolume;	///<	委托数量
    EntrustPrice: TJGtdcOrderPrice;	///<	委托价格
    BusinessAmount: TJGtdcBuinessVolume;	///<	成交数量
    BusinessPrice: TJGtdcBusinessPrice;	///<	成交价格
    CancelAmount: TJGtdcCancelVolume;	///<	撤销数量
    BusinessBalance: TJGtdcBusinessBalance;	///<	成交金额
  end;

  ///< 投资者期权持仓查询应答
  PCJGtdcOptionRspQryHold = ^TCJGtdcOptionRspQryHold;

  TCJGtdcOptionRspQryHold = record
    BranchNo: TJGtdcBranchNoType;	///<	营业部号
    ClientID: TJGtdcClientIDType;	///<	客户号
    FundAccount: TJGtdcFundAccountType;	///<	资金账号
    ExchangeType: TJGtdcExchangeType;	///<	市场类型
    StockAccount: TJGtdcStockAccountType;	///<	股东代码
    ContractNumber: TJGtdcContractNumber;	///<	合约编码
    ContractCode: TJGtdcContractCodeType;	///<	合约代码
    ContractName: TJGtdcContractNameType;	///<	合约名称
    StockCode: TJGtdcStockCodeType;	///<	证券代码
    StockName: TJGtdcStockNameType;	///<	证券名称
    PositionStr: TJGtdcPositionStrType;	///<	定位串
    MoneyType: TJGtdcMoneyType;	///<	币种
    OptionType: TJGtdcOptionType;	///<	期权类别
    OptionHoldType: TJGtdcOptionHoldType;	///<	期权持仓类别
    OptionYDAmount: TJGtdcOptionYDAmount;	///<	期权昨日余额
    OptionAmount: TJGtdcOptionAmount;	///<	期权余额
    EnableAmount: TJGtdcEnableAmount;	///<	可卖数量
    PossessAmount: TJGtdcPossessAmount;	///<	当前拥股数量
    FrozenAmount: TJGtdcFrozenAmount;	///<	冻结数量
    UnFrozenAmount: TJGtdcUnFrozenAmount;	///<	解冻数量
    TransitAmount: TJGtdcTransitAmount;	///<	在途数量
    TodayOpenAmount: TJGtdcTodayOpenAmount;	///<	今日开仓量
    TodayPayoffAmount: TJGtdcTodayPayoffAmount;	///<	今日平仓量
    PremiumBalance: TJGtdcPremiumBalance;	///<	权利金
    BailBalance: TJGtdcBailBalance;	///<	保证金
    CostPrice: TJGtdcCostPrice;	///<	成本价格
    BuyCost: TJGtdcBuyCost;	///<	当前成本
    OptionBalance: TJGtdcOptionBalance;	///<	期权市值
    HoldIncome: TJGtdcHoldIncome;	///<	持仓盈亏
    PayoffIncome: TJGtdcPayoffIncome;	///<	平仓盈亏
  end;

  ///< 投资者期权资金查询应答
  PCJGtdcOptionRspQryFund = ^TCJGtdcOptionRspQryFund;

  TCJGtdcOptionRspQryFund = record
    BranchNo: TJGtdcBranchNoType;	///<	营业部号
    ClientID: TJGtdcClientIDType;	///<	客户号
    FundAccount: TJGtdcFundAccountType;	///<	资金账号
    MoneyType: TJGtdcMoneyType;	///<	币种
    MainFlag: TJGtdcMainFlag;	///<	主副标志
    EnableBalance: TJGtdcEnableBalance;	///<	可用余额
    FetchBalance: TJGtdcFetchBalance;	///<	可取余额
    FrozenBalance: TJGtdcFrozenBalance;	///<	冻结金额
    StockBalance: TJGtdcStockBalance;	///<	证券市值
    FundBalance: TJGtdcFundBalance;	///<	资金余额
    AssetBalance: TJGtdcAssetBalance;	///<	资产总值
    Income: TJGtdcIncome;	///<	总盈亏
    EnableBail: TJGtdcEnableBail;	///<	可用保证金
    UsedBail: TJGtdcUsedBail;	///<	已用保证金
    AgreeAssureRatio: TJGtdcAgreeAssureRatio;	///<	履约担保比例
    RiskRatio: TJGtdcRiskRatio;	///<	风险度
    RiskRatio1: TJGtdcRiskRatio1;	///<	风险度1

  end;

   ///< 投资者期权可撤单查询应答
  PCJGtdcOptionRspQryRevocEnt = ^TCJGtdcOptionRspQryRevocEnt;

  TCJGtdcOptionRspQryRevocEnt = record
    BranchNo: TJGtdcBranchNoType;	///<	营业部号
    ClientID: TJGtdcClientIDType;	///<	客户号
    FundAccount: TJGtdcFundAccountType;	///<	资金账号
    ExchangeType: TJGtdcExchangeType;	///<	市场类型
    StockAccount: TJGtdcStockAccountType;	///<	股东代码
    SeatNo: TJGtdcSeatNoType;	///<	席位号
    ContractNumber: TJGtdcContractNumber;	///<	合约编码
    ContractCode: TJGtdcContractCodeType;	///<	合约代码
    ContractName: TJGtdcContractNameType;	///<	合约名称
    StockCode: TJGtdcStockCodeType;	///<	证券代码
    StockName: TJGtdcStockNameType;	///<	证券名称
    PositionStr: TJGtdcPositionStrType;	///<	定位串
    EntrustNo: TJGtdcEntrustNoType;	///<	合同号
    ReportNo: TJGtdcReportNoType;	///<	申报号
    BatchNo: TJGtdcBatchNoType;	///<	批号
    MoneyType: TJGtdcMoneyType;	///<	币种
    EntrustStatus: TJGtdcEntrustStatus;	///<	委托状态
    TradeType: TJGtdcTradeType;	///<	交易类型
    OffsetType: TJGtdcOffsetType;	///<	开平仓类型
    CoveredType: TJGtdcCoveredType;	///<	备兑标识
    PriceType: TJGtdcPriceType;	///<	价格类型
    EntrustDate: TJGtdcDate;	///<	委托日期
    EntrustTime: TJGtdcTime;	///<	委托时间
    EntrustAmount: TJGtdcOrderVolume;	///<	委托数量
    EntrustPrice: TJGtdcOrderPrice;	///<	委托价格
    BusinessAmount: TJGtdcBuinessVolume;	///<	成交数量
    BusinessPrice: TJGtdcBusinessPrice;	///<	成交价格
    CancelAmount: TJGtdcCancelVolume;	///<	撤销数量
    BusinessBalance: TJGtdcBusinessBalance;	///<	成交金额
    InvalidReason: TJGtdcInvalidReason;	///<	废单原因
  end;

  ///< 用户报单应答
  PCJGtdcRspOrderInsert = ^TCJGtdcRspOrderInsert;

  TCJGtdcRspOrderInsert = record
    ResultType: TJGtdcResultType;	///<	应答结果
    ErrorInfo: TJGtdcErrorInfoType;	///<	错误信息
    EntrustNo: TJGtdcEntrustNoType;	///<	合同号
    BatchNo: TJGtdcBatchNoType;	///<	批号
    StockAccount: TJGtdcStockAccountType;	///<	股东代码
    StockCode: TJGtdcStockCodeType;	///<	证券代码
    ExchangeType: TJGtdcExchangeType;	///<	市场类型
    TradeType: TJGtdcTradeType;	///<	交易类型
    PriceType: TJGtdcPriceType;	///<	价格类型
    OrderVolume: TJGtdcOrderVolume;	///<	委托数量
    OrderPrice: TJGtdcOrderPrice;	///<	委托价格
  end;

  ///< 用户撤单应答
  PCJGtdcRspOrderCancel = ^TCJGtdcRspOrderCancel;

  TCJGtdcRspOrderCancel = record
    ResultType: TJGtdcResultType;	///<	应答结果
    ErrorInfo: TJGtdcErrorInfoType;	///<	错误信息
    EntrustNo: TJGtdcEntrustNoType;	///<	合同号
    NewEntrustNo: TJGtdcEntrustNoType;	///<	新合同号
    BatchNo: TJGtdcBatchNoType;	///<	批号
  end;

  ///< 投资者当日委托查询应答
  PCJGtdcRspQryOrder = ^TCJGtdcRspQryOrder;

  TCJGtdcRspQryOrder = record
    BranchNo: TJGtdcBranchNoType;	///<	营业部号
    ClientID: TJGtdcClientIDType;	///<	客户号
    FundAccount: TJGtdcFundAccountType;	///<	资金账号
    ExchangeType: TJGtdcExchangeType;	///<	市场类型
    StockAccount: TJGtdcStockAccountType;	///<	股东代码
    SeatNo: TJGtdcSeatNoType;	///<	席位号
    StockCode: TJGtdcStockCodeType;	///<	证券代码
    StockName: TJGtdcStockNameType;	///<	证券名称
    PositionStr: TJGtdcPositionStrType;	///<	定位串
    EntrustNo: TJGtdcEntrustNoType;	///<	合同号
    MoneyType: TJGtdcMoneyType;	///<	币种
    EntrustStatus: TJGtdcEntrustStatus;	///<	委托状态
    TradeType: TJGtdcTradeType;	///<	交易类型
    PriceType: TJGtdcPriceType;	///<	价格类型
    EntrustDate: TJGtdcDate;	///<	委托日期
    EntrustTime: TJGtdcTime;	///<	委托时间
    OrderVolume: TJGtdcOrderVolume;	///<	委托数量
    OrderPrice: TJGtdcOrderPrice;	///<	委托价格
    BusinessVolume: TJGtdcBuinessVolume;	///<	成交数量
    BusinessPrice: TJGtdcBusinessPrice;	///<	成交价格
    CancelVolume: TJGtdcCancelVolume;	///<	撤单数量
    BusinessBalance: TJGtdcBusinessBalance;	///<	成交金额
    ServiceType: TJGtdcServiceType;	///<	业务类型
  end;

  ///< 投资者成交单查询应答
  PCJGtdcRspQryTrade = ^TCJGtdcRspQryTrade;

  TCJGtdcRspQryTrade = record
    BranchNo: TJGtdcBranchNoType;	///<	营业部号
    ClientID: TJGtdcClientIDType;	///<	客户号
    FundAccount: TJGtdcFundAccountType;	///<	资金账号
    ExchangeType: TJGtdcExchangeType;	///<	市场类型
    StockAccount: TJGtdcStockAccountType;	///<	股东代码
    SeatNo: TJGtdcSeatNoType;	///<	席位号
    StockCode: TJGtdcStockCodeType;	///<	证券代码
    StockName: TJGtdcStockNameType;	///<	证券名称
    PositionStr: TJGtdcPositionStrType;	///<	定位串
    EntrustNo: TJGtdcEntrustNoType;	///<	合同号
    BusinessNo: TJGtdcBusinessNoType;	///<	成交编号
    MoneyType: TJGtdcMoneyType;	///<	币种
    BusinessStatus: TJGtdcBusinessStatus;	///<	成交状态
    TradeType: TJGtdcTradeType;	///<	交易类型
    PriceType: TJGtdcPriceType;	///<	价格类型
    BusinessDate: TJGtdcDate;	///<	成交日期
    BusinessTime: TJGtdcTime;	///<	成交时间
    OrderVolume: TJGtdcOrderVolume;	///<	委托数量
    OrderPrice: TJGtdcOrderPrice;	///<	委托价格
    BusinessVolume: TJGtdcBuinessVolume;	///<	成交数量
    BusinessPrice: TJGtdcBusinessPrice;	///<	成交价格
    CancelVolume: TJGtdcCancelVolume;	///<	撤单数量
    BusinessBalance: TJGtdcBusinessBalance;	///<	成交金额
  end;

  ///< 投资者持仓查询应答
  PCJGtdcRspQryHold = ^TCJGtdcRspQryHold;

  TCJGtdcRspQryHold = record
    BranchNo: TJGtdcBranchNoType;	///<	营业部号
    ClientID: TJGtdcClientIDType;	///<	客户号
    FundAccount: TJGtdcFundAccountType;	///<	资金账号
    StockAccount: TJGtdcStockAccountType;	///<	股东代码
    StockCode: TJGtdcStockCodeType;	///<	证券代码
    StockName: TJGtdcStockNameType;	///<	证券名称
    ExchangeType: TJGtdcExchangeType;	///<	市场类型
    MoneyType: TJGtdcMoneyType;	///<	币种
    YdAmount: TJGtdcYdAmount;	///<	昨日持仓量
    StockAmount: TJGtdcStockAmount;	///<	股份余额
    EnableAmount: TJGtdcEnableAmount;	///<	可卖数量
    PurchaseAmount: TJGtdcPurchaseAmount;	///<	可申购数量
    PossessAmount: TJGtdcPossessAmount;	///<	当前拥股数量
    FrozenAmount: TJGtdcFrozenAmount;	///<	冻结数量
    YStoreAmount: TJGtdcYStoreAmount;	///<	昨日库存数量
    CostPrice: TJGtdcCostPrice;	///<	成本价格
    KeepCostPrice: TJGtdcKeepCostPrice;	///<	保本价格
    BuyCost: TJGtdcBuyCost;	///<	当前成本
    StockBalance: TJGtdcStockBalance;	///<	证券市值
    FloatIncome: TJGtdcFloatIncome;	///<	浮动盈亏
    ProIncome: TJGtdcProIncome;	///<	累计盈亏
  end;

  ///< 投资者资金查询应答
  PCJGtdcRspQryFund = ^TCJGtdcRspQryFund;

  TCJGtdcRspQryFund = record
    BranchNo: TJGtdcBranchNoType;	///<	营业部号
    ClientID: TJGtdcClientIDType;	///<	客户号
    FundAccount: TJGtdcFundAccountType;	///<	资金账号
    MoneyType: TJGtdcMoneyType;	///<	币种
    MainFlag: TJGtdcMainFlag;	///<	主副标志
    EnableBalance: TJGtdcEnableBalance;	///<	可用余额
    FetchBalance: TJGtdcFetchBalance;	///<	可取余额
    FrozenBalance: TJGtdcFrozenBalance;	///<	冻结金额
    StockBalance: TJGtdcStockBalance;	///<	证券市值
    FundBalance: TJGtdcFundBalance;	///<	资金余额
    AssetBalance: TJGtdcAssetBalance;	///<	资产总值
    InCome: TJGtdcIncome;	///<	总盈亏
    EnableBalanceHK: TJGtdcEnableBalanceHK;	///<	港股可用余额
  end;

  ///< 投资者可撤单查询应答
  PCJGtdcRspQryCancel = ^TCJGtdcRspQryCancel;

  TCJGtdcRspQryCancel = record
    BranchNo: TJGtdcBranchNoType;	///<	营业部号
    ClientID: TJGtdcClientIDType;	///<	客户号
    FundAccount: TJGtdcFundAccountType;	///<	资金账号
    ExchangeType: TJGtdcExchangeType;	///<	市场类型
    StockAccount: TJGtdcStockAccountType;	///<	股东代码
    SeatNo: TJGtdcSeatNoType;	///<	席位号
    StockCode: TJGtdcStockCodeType;	///<	证券代码
    StockName: TJGtdcStockNameType;	///<	证券名称
    PositionStr: TJGtdcPositionStrType;	///<	定位串
    EntrustNo: TJGtdcEntrustNoType;	///<	合同号
    MoneyType: TJGtdcMoneyType;	///<	币种
    EntrustStatus: TJGtdcEntrustStatus;	///<	委托状态
    TradeType: TJGtdcTradeType;	///<	交易类型
    PriceType: TJGtdcPriceType;	///<	价格类型
    EntrustDate: TJGtdcDate;	///<	委托日期
    EntrustTime: TJGtdcTime;	///<	委托时间
    OrderVolume: TJGtdcOrderVolume;	///<	委托数量
    OrderPrice: TJGtdcOrderPrice;	///<	委托价格
    BusinessVolume: TJGtdcBuinessVolume;	///<	成交数量
    BusinessPrice: TJGtdcBusinessPrice;	///<	成交价格
    CancelVolume: TJGtdcCancelVolume;	///<	撤单数量
    BusinessBalance: TJGtdcBusinessBalance;	///<	成交金额
    ServiceType: TJGtdcServiceType;	///<	业务类型
  end;
  {$A8-}

  //折线图-三线

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

