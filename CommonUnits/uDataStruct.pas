unit uDataStruct;
(*
  行情用到的数据结构
*)

interface

uses
  Classes, Series;

type
  {定义的数据类型和行情的数据结构}
  {映射C++时，array中0..8 对应的是C++的9，因为0也算进去了}
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

  //投资者持仓
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

  //折线图-三线
  ThreeSeriesChart = record
    ValueSeries1: TFastLineSeries;
    ValueSeries2: TFastLineSeries;
    ConstantSeries: TFastLineSeries;
  end;

implementation

end.

