object FrmEdt: TFrmEdt
  Left = 76
  Top = 162
  Width = 401
  Height = 236
  Caption = #1056#1077#1076#1072#1082#1090#1080#1088#1086#1074#1072#1085#1080#1077'/'#1044#1086#1073#1072#1074#1083#1077#1085#1080#1077
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnHide = FormHide
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object LblFIO: TLabel
    Left = 16
    Top = 16
    Width = 39
    Height = 16
    Caption = #1060'.'#1048'.'#1054'.'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object LblZarp: TLabel
    Left = 16
    Top = 74
    Width = 55
    Height = 16
    Caption = #1047#1072#1088#1087#1083#1072#1090#1072
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object LblNum: TLabel
    Left = 176
    Top = 74
    Width = 106
    Height = 16
    Caption = #1058#1072#1073#1077#1083#1100#1085#1099#1081' '#1085#1086#1084#1077#1088
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object EdtFIO: TEdit
    Left = 22
    Top = 38
    Width = 329
    Height = 21
    TabOrder = 0
    OnChange = EdtFIOChange
  end
  object SpEdZarp: TSpinEdit
    Left = 22
    Top = 96
    Width = 105
    Height = 22
    MaxValue = 1000000
    MinValue = 0
    TabOrder = 1
    Value = 0
  end
  object SpEdNum: TSpinEdit
    Left = 185
    Top = 96
    Width = 129
    Height = 22
    MaxValue = 10000
    MinValue = 1
    TabOrder = 2
    Value = 1
  end
  object BtnOK: TButton
    Left = 80
    Top = 148
    Width = 97
    Height = 29
    Caption = 'OK'
    Enabled = False
    ModalResult = 1
    TabOrder = 3
  end
  object BtnCncl: TButton
    Left = 208
    Top = 148
    Width = 97
    Height = 30
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 4
  end
end
