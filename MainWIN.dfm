object MainWindow: TMainWindow
  Left = 780
  Top = 312
  BiDiMode = bdRightToLeftNoAlign
  Caption = 'MainWindow'
  ClientHeight = 610
  ClientWidth = 1128
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Comic Sans MS'
  Font.Style = []
  OldCreateOrder = False
  ParentBiDiMode = False
  Position = poDesigned
  OnResize = FormResize
  PixelsPerInch = 96
  TextHeight = 15
  object Splitter1: TSplitter
    Left = 0
    Top = 161
    Width = 1128
    Height = 3
    Cursor = crVSplit
    Align = alTop
    ExplicitLeft = -1
    ExplicitTop = 215
    ExplicitWidth = 771
  end
  object Splitter3: TSplitter
    Left = 0
    Top = 457
    Width = 1128
    Height = 3
    Cursor = crVSplit
    Align = alTop
    ExplicitTop = 377
    ExplicitWidth = 772
  end
  object GridPanel: TPanel
    Left = 0
    Top = 0
    Width = 1128
    Height = 161
    Align = alTop
    Caption = 'GridPanel'
    TabOrder = 0
    object PageControl1: TPageControl
      Left = 1
      Top = 1
      Width = 1126
      Height = 159
      ActivePage = TabSheet2
      Align = alClient
      BiDiMode = bdLeftToRight
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Comic Sans MS'
      Font.Style = []
      ParentBiDiMode = False
      ParentFont = False
      TabOrder = 0
      object TabSheet2: TTabSheet
        Caption = #26399#36135#34892#24773
        ImageIndex = 1
        object FFuturesQuotationGrid: TStringGrid
          Left = 0
          Top = 0
          Width = 1118
          Height = 129
          Align = alClient
          BevelInner = bvNone
          BevelOuter = bvNone
          BorderStyle = bsNone
          Color = clBtnHighlight
          ColCount = 22
          Ctl3D = False
          DefaultColWidth = 70
          FixedColor = clSilver
          FixedCols = 0
          RowCount = 2
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Comic Sans MS'
          Font.Style = []
          Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goRowSizing, goRowSelect]
          ParentCtl3D = False
          ParentFont = False
          PopupMenu = PopupMenu1
          TabOrder = 0
          OnClick = FFuturesQuotationGridClick
          OnDrawCell = FFuturesQuotationGridDrawCell
          ColWidths = (
            70
            70
            70
            70
            70
            70
            70
            70
            70
            70
            70
            70
            70
            70
            70
            70
            70
            70
            70
            70
            70
            70)
        end
      end
      object TabSheet3: TTabSheet
        Caption = #26399#26435#34892#24773
        ImageIndex = 2
        object FOptionQuotationGrid: TStringGrid
          Left = 0
          Top = 0
          Width = 1118
          Height = 129
          Align = alClient
          BevelInner = bvNone
          BevelOuter = bvNone
          BorderStyle = bsNone
          Color = clBtnHighlight
          ColCount = 23
          Ctl3D = False
          DefaultColWidth = 70
          FixedColor = clSilver
          FixedCols = 0
          RowCount = 2
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Comic Sans MS'
          Font.Style = []
          Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goRowSizing, goRowSelect]
          ParentCtl3D = False
          ParentFont = False
          TabOrder = 0
          ColWidths = (
            70
            70
            70
            70
            70
            70
            70
            70
            70
            70
            70
            70
            70
            70
            70
            70
            70
            70
            70
            70
            70
            70
            70)
        end
      end
      object TabSheet4: TTabSheet
        Caption = #29616#36135#34892#24773
        ImageIndex = 3
        object ActualsQuotationGrid: TStringGrid
          Left = 0
          Top = 0
          Width = 1118
          Height = 129
          Align = alClient
          BevelInner = bvNone
          BevelOuter = bvNone
          BorderStyle = bsNone
          Color = clBtnHighlight
          ColCount = 23
          Ctl3D = False
          DefaultColWidth = 70
          FixedColor = clSilver
          FixedCols = 0
          RowCount = 2
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Comic Sans MS'
          Font.Style = []
          Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goRowSizing, goRowSelect]
          ParentCtl3D = False
          ParentFont = False
          TabOrder = 0
          ColWidths = (
            70
            70
            70
            70
            70
            70
            70
            70
            70
            70
            70
            70
            70
            70
            70
            70
            70
            70
            70
            70
            70
            70
            70)
        end
      end
    end
  end
  object middlePanel: TPanel
    Left = 0
    Top = 164
    Width = 1128
    Height = 293
    Align = alTop
    Caption = 'middlePanel'
    TabOrder = 1
    object Splitter2: TSplitter
      Left = 753
      Top = 1
      Height = 291
      ExplicitLeft = 560
      ExplicitTop = 160
      ExplicitHeight = 100
    end
    object ChartPanel: TPanel
      Left = 1
      Top = 1
      Width = 752
      Height = 291
      Align = alLeft
      Caption = 'ChartPanel'
      TabOrder = 0
      ExplicitHeight = 235
      object FutureChart: TChart
        Left = 1
        Top = 1
        Width = 750
        Height = 289
        Title.Text.Strings = (
          'TChart'
          'Tsha'
          'waooo')
        DepthAxis.Automatic = False
        DepthAxis.AutomaticMaximum = False
        DepthAxis.AutomaticMinimum = False
        DepthAxis.Maximum = 0.620000000000000100
        DepthAxis.Minimum = -0.380000000000000100
        DepthTopAxis.Automatic = False
        DepthTopAxis.AutomaticMaximum = False
        DepthTopAxis.AutomaticMinimum = False
        DepthTopAxis.Maximum = 0.620000000000000100
        DepthTopAxis.Minimum = -0.380000000000000100
        View3D = False
        View3DWalls = False
        Align = alClient
        PopupMenu = PopupMenu2
        TabOrder = 0
        OnDblClick = FutureChartDblClick
        ExplicitHeight = 233
        PrintMargins = (
          15
          34
          15
          34)
        object PriceSeries: TFastLineSeries
          Marks.Callout.Brush.Color = clBlack
          Marks.Visible = False
          Title = #25104#20132#20215
          LinePen.Color = clRed
          Stairs = True
          XValues.Name = 'X'
          XValues.Order = loAscending
          YValues.Name = 'Y'
          YValues.Order = loNone
        end
        object ConstantSeries: TFastLineSeries
          Marks.Callout.Brush.Color = clBlack
          Marks.Visible = False
          LinePen.Color = clYellow
          XValues.Name = 'X'
          XValues.Order = loAscending
          YValues.Name = 'Y'
          YValues.Order = loNone
        end
      end
    end
    object middlerightPanel: TPanel
      Left = 756
      Top = 1
      Width = 371
      Height = 291
      Align = alClient
      Caption = 'middlerightPanel'
      TabOrder = 1
      ExplicitHeight = 235
      object PriceGrid: TStringGrid
        Left = 72
        Top = 50
        Width = 169
        Height = 201
        TabStop = False
        BiDiMode = bdRightToLeftReadingOnly
        Color = clBtnFace
        ColCount = 1
        Ctl3D = False
        DefaultColWidth = 150
        DefaultRowHeight = 18
        Enabled = False
        FixedCols = 0
        RowCount = 10
        FixedRows = 0
        Options = []
        ParentBiDiMode = False
        ParentCtl3D = False
        ParentShowHint = False
        ShowHint = False
        TabOrder = 0
        OnDrawCell = PriceGridDrawCell
      end
      object InputOrderRadioGroup: TRadioGroup
        Left = 335
        Top = 50
        Width = 185
        Height = 105
        Caption = #25253#21333#27169#24335
        ItemIndex = 0
        Items.Strings = (
          #24555#36895#25104#20132
          #33258#23450#20041#20215#26684)
        TabOrder = 1
        OnClick = InputOrderRadioGroupClick
      end
      object GroupBox1: TGroupBox
        Left = 334
        Top = 219
        Width = 185
        Height = 70
        Ctl3D = False
        ParentCtl3D = False
        TabOrder = 2
        object Button1: TButton
          Left = 3
          Top = 3
          Width = 75
          Height = 25
          Caption = #20080#24320
          TabOrder = 0
          OnClick = Button1Click
        end
        object Button2: TButton
          Left = 107
          Top = 34
          Width = 75
          Height = 25
          Caption = #21334#24320
          TabOrder = 1
        end
        object Button3: TButton
          Left = 3
          Top = 34
          Width = 75
          Height = 25
          Caption = #20080#24179
          TabOrder = 2
        end
        object Button4: TButton
          Left = 107
          Top = 3
          Width = 75
          Height = 25
          Caption = #21334#24179
          TabOrder = 3
          OnClick = Button4Click
        end
      end
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 460
    Width = 1128
    Height = 150
    Align = alClient
    Caption = 'Panel2'
    Enabled = False
    TabOrder = 2
    ExplicitTop = 404
    ExplicitHeight = 206
  end
  object PosistionListView: TListView
    Left = 42
    Top = 502
    Width = 609
    Height = 191
    Columns = <
      item
        AutoSize = True
        Caption = #21512#32422
      end
      item
        AutoSize = True
        Caption = #20080#21334
      end
      item
        AutoSize = True
        Caption = #24635#25345#20179
      end
      item
        AutoSize = True
        Caption = #26152#20179
      end
      item
        AutoSize = True
        Caption = #20170#20179
      end
      item
        AutoSize = True
        Caption = #21487#24179#37327
      end
      item
        AutoSize = True
        Caption = #25345#20179#22343#20215
      end
      item
        AutoSize = True
        Caption = #25345#20179#30408#20111
      end
      item
        AutoSize = True
        Caption = #21344#29992#20445#35777#37329
      end
      item
        AutoSize = True
        Caption = #25237#20445
      end
      item
        AutoSize = True
        Caption = #20132#26131#25152
      end>
    Items.ItemData = {
      01180000000100000000000000FFFFFFFFFFFFFFFF0000000000000000013100}
    ReadOnly = True
    TabOrder = 3
    ViewStyle = vsReport
  end
  object PopupMenu1: TPopupMenu
    Left = 712
    Top = 144
    object PopupAddContract: TMenuItem
      Caption = #35746#38405#21512#32422
      OnClick = PopupAddContractClick
    end
    object PopupDeleteContract: TMenuItem
      Caption = #21024#38500#21512#32422
    end
  end
  object PopupMenu2: TPopupMenu
    Left = 672
    Top = 144
    object PopupCloseChart: TMenuItem
      Caption = #20851#38381#36208#21183#22270
    end
  end
end
