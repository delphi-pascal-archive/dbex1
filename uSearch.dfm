object fmSearch: TfmSearch
  Left = 192
  Top = 107
  BorderStyle = bsDialog
  Caption = #1055#1086#1080#1089#1082' '#1087#1086' '#1087#1086#1083#1102' "'#1055#1088#1086#1094#1077#1089#1089#1086#1088'"'
  ClientHeight = 319
  ClientWidth = 529
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
  object laResult: TLabel
    Left = 8
    Top = 56
    Width = 55
    Height = 13
    Caption = #1056#1077'&'#1079#1091#1083#1100#1090#1072#1090':'
    FocusControl = lvResult
  end
  object laQuery: TLabel
    Left = 8
    Top = 8
    Width = 40
    Height = 13
    Caption = #1047#1072'&'#1087#1088#1086#1089':'
    FocusControl = edQuery
  end
  object lvResult: TListView
    Left = 8
    Top = 72
    Width = 513
    Height = 235
    Columns = <
      item
        Caption = #1055#1088#1086#1094#1077#1089#1089#1086#1088
        Width = 100
      end
      item
        Caption = #1054#1073#1098#1077#1084' '#1054#1047#1059
        Width = 100
      end
      item
        Caption = #1054#1073#1098#1077#1084' HDD'
        Width = 100
      end
      item
        Caption = #1054#1057
        Width = 100
      end
      item
        Caption = #1062#1077#1085#1072
        Width = 100
      end>
    ColumnClick = False
    ReadOnly = True
    RowSelect = True
    TabOrder = 2
    ViewStyle = vsReport
  end
  object edQuery: TEdit
    Left = 8
    Top = 24
    Width = 169
    Height = 21
    MaxLength = 25
    TabOrder = 0
  end
  object btGo: TButton
    Left = 192
    Top = 22
    Width = 75
    Height = 25
    Caption = #1048#1089'&'#1082#1072#1090#1100
    Default = True
    TabOrder = 1
    OnClick = btGoClick
  end
end
