object LoginTradeFrom: TLoginTradeFrom
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  Caption = #30331#24405#20132#26131#36134#25143
  ClientHeight = 275
  ClientWidth = 339
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
  object accountlabel: TLabel
    Left = 60
    Top = 117
    Width = 36
    Height = 20
    Caption = #36134#21495':'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'Comic Sans MS'
    Font.Style = []
    ParentFont = False
  end
  object pwdlabel: TLabel
    Left = 60
    Top = 154
    Width = 36
    Height = 20
    Caption = #23494#30721':'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'Comic Sans MS'
    Font.Style = []
    ParentFont = False
  end
  object Label1: TLabel
    Left = 28
    Top = 85
    Width = 68
    Height = 20
    Caption = #36873#25321#36134#25143':'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'Comic Sans MS'
    Font.Style = []
    ParentFont = False
  end
  object AddrLabel: TLabel
    Left = 32
    Top = 50
    Width = 55
    Height = 17
    Caption = 'AddrLabel'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Comic Sans MS'
    Font.Style = []
    ParentFont = False
  end
  object Label2: TLabel
    Left = 28
    Top = 20
    Width = 84
    Height = 14
    Caption = #24403#21069#20132#26131#22320#22336#65306
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object accountedit: TEdit
    Left = 102
    Top = 116
    Width = 150
    Height = 26
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Comic Sans MS'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    OnKeyDown = KeyDown
  end
  object passwordedit: TEdit
    Left = 102
    Top = 148
    Width = 150
    Height = 26
    AutoSelect = False
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Comic Sans MS'
    Font.Style = []
    ParentFont = False
    PasswordChar = '*'
    TabOrder = 1
    OnKeyDown = KeyDown
  end
  object Button1: TButton
    Left = 110
    Top = 196
    Width = 118
    Height = 47
    Caption = #30331#24405
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Comic Sans MS'
    Font.Style = []
    ParentFont = False
    TabOrder = 2
    OnClick = Button1Click
  end
  object ComboBox1: TComboBox
    Left = 102
    Top = 84
    Width = 150
    Height = 26
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Comic Sans MS'
    Font.Style = []
    ItemHeight = 0
    ParentFont = False
    TabOrder = 3
    OnClick = ComboBox1Click
  end
  object Button2: TButton
    Left = 273
    Top = 16
    Width = 58
    Height = 25
    Caption = #36890#35759#37197#32622
    TabOrder = 4
    OnClick = Button2Click
  end
end
