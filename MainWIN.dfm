object MainWindow: TMainWindow
  Left = 0
  Top = 0
  BiDiMode = bdRightToLeftNoAlign
  Caption = 'MainWindow'
  ClientHeight = 409
  ClientWidth = 771
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Comic Sans MS'
  Font.Style = []
  OldCreateOrder = False
  ParentBiDiMode = False
  PixelsPerInch = 96
  TextHeight = 15
  object PageControl1: TPageControl
    Left = 0
    Top = 0
    Width = 771
    Height = 305
    ActivePage = TabSheet2
    Align = alTop
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
        Width = 763
        Height = 275
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
    end
    object TabSheet3: TTabSheet
      Caption = #26399#26435#34892#24773
      ImageIndex = 2
      object FOptionQuotationGrid: TStringGrid
        Left = 0
        Top = 0
        Width = 763
        Height = 275
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
        Width = 763
        Height = 275
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
  object PopupMenu1: TPopupMenu
    Left = 496
    Top = 152
    object N1: TMenuItem
      Caption = #35746#38405#21512#32422
      OnClick = N1Click
    end
    object N2: TMenuItem
      Caption = #21024#38500#21512#32422
      OnClick = N2Click
    end
  end
end
