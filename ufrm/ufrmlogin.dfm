object LoginTradeFrom: TLoginTradeFrom
  Left = 0
  Top = 0
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
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object accountlabel: TLabel
    Left = 56
    Top = 102
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
    Left = 56
    Top = 150
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
    Left = 40
    Top = 54
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
  object accountedit: TEdit
    Left = 104
    Top = 101
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
    Left = 104
    Top = 149
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
    Left = 104
    Top = 200
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
    Left = 104
    Top = 53
    Width = 150
    Height = 26
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Comic Sans MS'
    Font.Style = []
    ItemHeight = 18
    ParentFont = False
    TabOrder = 3
    OnClick = ComboBox1Click
  end
end
