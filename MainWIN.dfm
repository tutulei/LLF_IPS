object MainWindow: TMainWindow
  Left = 0
  Top = 0
  BiDiMode = bdRightToLeftNoAlign
  Caption = 'MainWindow'
  ClientHeight = 496
  ClientWidth = 772
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Comic Sans MS'
  Font.Style = []
  OldCreateOrder = False
  ParentBiDiMode = False
  OnResize = FormResize
  PixelsPerInch = 96
  TextHeight = 15
  object Splitter1: TSplitter
    Left = 0
    Top = 281
    Width = 772
    Height = 3
    Cursor = crVSplit
    Align = alTop
    ExplicitLeft = -1
    ExplicitTop = 215
    ExplicitWidth = 771
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 772
    Height = 281
    Align = alTop
    Caption = #34892#24773'Panel'
    TabOrder = 0
    object PageControl1: TPageControl
      Left = 1
      Top = 1
      Width = 770
      Height = 279
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
          Width = 762
          Height = 249
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
        object FutureChart: TChart
          Left = 0
          Top = 0
          Width = 762
          Height = 249
          Title.Text.Strings = (
            'TChart'
            'Tsha'
            'waooo')
          View3D = False
          View3DWalls = False
          Align = alClient
          PopupMenu = PopupMenu2
          TabOrder = 1
          Visible = False
          DesignSize = (
            762
            249)
          object Label1: TLabel
            Left = 664
            Top = 168
            Width = 48
            Height = 15
            Anchors = [akRight, akBottom]
            Caption = #36873#25321#21512#32422
          end
          object ComboBox1: TComboBox
            Left = 632
            Top = 200
            Width = 113
            Height = 23
            Anchors = [akRight, akBottom]
            Ctl3D = False
            ItemHeight = 15
            ParentCtl3D = False
            TabOrder = 0
            OnDropDown = ComboBox1DropDown
            OnSelect = ComboBox1Select
            Items.Strings = (
              'item'
              'item2'
              'item3')
          end
          object PriceSeries: TFastLineSeries
            Marks.Callout.Brush.Color = clBlack
            Marks.Visible = False
            Title = #25104#20132#20215
            LinePen.Color = clRed
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
      object TabSheet3: TTabSheet
        Caption = #26399#26435#34892#24773
        ImageIndex = 2
        ExplicitLeft = 0
        ExplicitTop = 0
        ExplicitWidth = 761
        ExplicitHeight = 0
        object FOptionQuotationGrid: TStringGrid
          Left = 0
          Top = 0
          Width = 762
          Height = 249
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
          ExplicitWidth = 761
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
        ExplicitLeft = 0
        ExplicitTop = 0
        ExplicitWidth = 761
        ExplicitHeight = 0
        object ActualsQuotationGrid: TStringGrid
          Left = 0
          Top = 0
          Width = 762
          Height = 249
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
          Visible = False
          ExplicitWidth = 761
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
  object PopupMenu1: TPopupMenu
    Left = 712
    Top = 144
    object PopupAddContract: TMenuItem
      Caption = #35746#38405#21512#32422
      OnClick = PopupAddContractClick
    end
    object PopupDeleteContract: TMenuItem
      Caption = #21024#38500#21512#32422
      OnClick = PopupDeleteContractClick
    end
    object PopupTurnToChart: TMenuItem
      Caption = #20999#25442#33267#36208#21183#22270
      OnClick = PopupTurnToChartClick
    end
  end
  object PopupMenu2: TPopupMenu
    Left = 672
    Top = 144
    object PopupCloseChart: TMenuItem
      Caption = #20851#38381#36208#21183#22270
      OnClick = PopupCloseChartClick
    end
  end
end
