object fmAddEditEntry: TfmAddEditEntry
  Left = 192
  Top = 107
  BorderStyle = bsDialog
  ClientHeight = 205
  ClientWidth = 367
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  PixelsPerInch = 96
  TextHeight = 13
  object laCPU: TLabel
    Left = 12
    Top = 16
    Width = 59
    Height = 13
    Caption = #1055'&'#1088#1086#1094#1077#1089#1089#1086#1088':'
    FocusControl = edCPU
  end
  object laRAMSpace: TLabel
    Left = 12
    Top = 112
    Width = 64
    Height = 13
    Caption = #1054#1073#1098#1077#1084' &'#1054#1047#1059':'
    FocusControl = sedRAMSpace
  end
  object laHDDSpace: TLabel
    Left = 120
    Top = 112
    Width = 61
    Height = 13
    Caption = #1054#1073#1098#1077#1084' &'#1046#1044':'
    FocusControl = sedHDDSpace
  end
  object laOS: TLabel
    Left = 12
    Top = 64
    Width = 18
    Height = 13
    Caption = #1054'&'#1057':'
    FocusControl = edOS
  end
  object laCost: TLabel
    Left = 240
    Top = 112
    Width = 58
    Height = 13
    Caption = #1057'&'#1090#1086#1080#1084#1086#1089#1090#1100':'
    FocusControl = sedCost
  end
  object edCPU: TEdit
    Left = 12
    Top = 32
    Width = 343
    Height = 21
    MaxLength = 25
    TabOrder = 0
  end
  object sedRAMSpace: TSpinEdit
    Left = 12
    Top = 128
    Width = 81
    Height = 22
    MaxValue = 2147483647
    MinValue = 0
    TabOrder = 2
    Value = 0
  end
  object sedHDDSpace: TSpinEdit
    Left = 120
    Top = 128
    Width = 81
    Height = 22
    MaxValue = 2147483647
    MinValue = 0
    TabOrder = 3
    Value = 0
  end
  object edOS: TEdit
    Left = 12
    Top = 80
    Width = 343
    Height = 21
    MaxLength = 25
    TabOrder = 1
  end
  object sedCost: TSpinEdit
    Left = 240
    Top = 128
    Width = 89
    Height = 22
    MaxValue = 2147483647
    MinValue = 0
    TabOrder = 4
    Value = 0
  end
  object btOk: TButton
    Left = 86
    Top = 170
    Width = 91
    Height = 25
    Caption = #1054#1050
    Default = True
    ModalResult = 1
    TabOrder = 5
  end
  object btCancel: TButton
    Left = 190
    Top = 170
    Width = 91
    Height = 25
    Cancel = True
    Caption = #1054#1090#1084#1077#1085#1072
    ModalResult = 2
    TabOrder = 6
  end
end
