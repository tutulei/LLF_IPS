object LoginTradeFrom: TLoginTradeFrom
  Left = 0
  Top = 0
  Caption = #30331#24405#20132#26131#36134#25143
  ClientHeight = 275
  ClientWidth = 443
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object brokeridlabel: TLabel
    Left = 48
    Top = 118
    Width = 71
    Height = 20
    Caption = 'BorkerID:'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'Comic Sans MS'
    Font.Style = []
    ParentFont = False
  end
  object accountlabel: TLabel
    Left = 48
    Top = 22
    Width = 36
    Height = 20
    Caption = #36134#25143':'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'Comic Sans MS'
    Font.Style = []
    ParentFont = False
  end
  object pwdlabel: TLabel
    Left = 48
    Top = 70
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
  object authcodelabel: TLabel
    Left = 47
    Top = 166
    Width = 72
    Height = 20
    Caption = 'AuthCode:'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'Comic Sans MS'
    Font.Style = []
    ParentFont = False
  end
  object appidlabel: TLabel
    Left = 47
    Top = 214
    Width = 50
    Height = 20
    Caption = 'AppID:'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'Comic Sans MS'
    Font.Style = []
    ParentFont = False
  end
  object brokeridedit: TEdit
    Left = 136
    Top = 117
    Width = 150
    Height = 26
    AutoSelect = False
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Comic Sans MS'
    Font.Style = []
    ParentFont = False
    TabOrder = 2
    OnKeyDown = KeyDown
  end
  object accountedit: TEdit
    Left = 96
    Top = 21
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
    Left = 96
    Top = 69
    Width = 150
    Height = 26
    AutoSelect = False
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Comic Sans MS'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
    OnKeyDown = KeyDown
  end
  object authcodeedit: TEdit
    Left = 136
    Top = 165
    Width = 150
    Height = 26
    AutoSelect = False
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Comic Sans MS'
    Font.Style = []
    ParentFont = False
    TabOrder = 3
    OnKeyDown = KeyDown
  end
  object appidedit: TEdit
    Left = 112
    Top = 213
    Width = 150
    Height = 26
    AutoSelect = False
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Comic Sans MS'
    Font.Style = []
    ParentFont = False
    TabOrder = 4
    OnKeyDown = KeyDown
  end
  object Button1: TButton
    Left = 320
    Top = 22
    Width = 105
    Height = 217
    Caption = #30331#24405
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Comic Sans MS'
    Font.Style = []
    ParentFont = False
    TabOrder = 5
    OnClick = Button1Click
  end
end
