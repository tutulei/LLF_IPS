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
    SharesIsLogin: Boolean;
    SharesServer: string;
  end;

  TTradeAccountStatus = record
    FuturesIsLogin: Boolean;
    FuturesAccount: string;
    OptionIsLogin: Boolean;
    OptionAccount: string;
    SharesIsLogin: Boolean;
    SharesAccount: string;
  end;

implementation

end.

