object QuotationChangeForm: TQuotationChangeForm
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  Caption = 'QuotationChangeForm'
  ClientHeight = 168
  ClientWidth = 274
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 22
    Top = 16
    Width = 72
    Height = 13
    Caption = #24403#21069#34892#24773#22320#22336
  end
  object QuotationAddrLabel: TLabel
    Left = 22
    Top = 35
    Width = 104
    Height = 15
    Caption = 'QuotationAddrLabel'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Comic Sans MS'
    Font.Style = []
    ParentFont = False
    Layout = tlCenter
  end
  object Label2: TLabel
    Left = 32
    Top = 56
    Width = 14
    Height = 26
    Caption = ' || '#13#10' \/'
  end
  object NewQuotationAddrLabel: TLabel
    Left = 22
    Top = 88
    Width = 12
    Height = 15
    Caption = '---'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Comic Sans MS'
    Font.Style = []
    ParentFont = False
  end
  object ChangeButton: TButton
    Left = 150
    Top = 110
    Width = 91
    Height = 46
    Caption = #20999#25442
    TabOrder = 0
    OnClick = ChangeButtonClick
  end
  object Button1: TButton
    Left = 36
    Top = 118
    Width = 58
    Height = 29
    Caption = #36890#35759#37197#32622
    TabOrder = 1
    OnClick = Button1Click
  end
end
