object FrmFind: TFrmFind
  Left = 246
  Top = 443
  Width = 248
  Height = 161
  Caption = #1055#1086#1080#1089#1082
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
  object LblNum: TLabel
    Left = 24
    Top = 16
    Width = 89
    Height = 13
    Caption = #1058#1072#1073#1077#1083#1100#1085#1099#1081' '#1085#1086#1084#1077#1088
  end
  object SpEdNum: TSpinEdit
    Left = 24
    Top = 35
    Width = 121
    Height = 22
    MaxValue = 10000
    MinValue = 1
    TabOrder = 0
    Value = 1
  end
  object BtnOK: TButton
    Left = 24
    Top = 80
    Width = 81
    Height = 25
    Caption = #1055#1088#1080#1085#1103#1090#1100
    ModalResult = 1
    TabOrder = 1
  end
  object BtnCncl: TButton
    Left = 120
    Top = 80
    Width = 81
    Height = 25
    Caption = #1054#1090#1084#1077#1085#1072
    ModalResult = 2
    TabOrder = 2
  end
end
