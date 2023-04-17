inherited framMedCardEdit: TframMedCardEdit
  Width = 478
  Height = 187
  Align = alClient
  ExplicitWidth = 478
  ExplicitHeight = 187
  object Label1: TLabel
    Left = 3
    Top = 8
    Width = 30
    Height = 15
    Caption = #1060#1048#1054':'
  end
  object Label2: TLabel
    Left = 3
    Top = 39
    Width = 65
    Height = 15
    Caption = #1044#1086#1083#1078#1085#1086#1089#1090#1100':'
  end
  object Label3: TLabel
    Left = 223
    Top = 8
    Width = 86
    Height = 15
    Caption = #1044#1072#1090#1072' '#1088#1086#1078#1076#1077#1085#1080#1103':'
  end
  object Label4: TLabel
    Left = 3
    Top = 70
    Width = 26
    Height = 15
    Caption = #1055#1086#1083':'
  end
  object Label5: TLabel
    Left = 258
    Top = 39
    Width = 51
    Height = 15
    Caption = #1058#1077#1083#1077#1092#1086#1085':'
  end
  object edtFio: TEdit
    Left = 74
    Top = 5
    Width = 143
    Height = 23
    TabOrder = 0
    Text = 'edtFio'
  end
  object dpDateBirth: TDatePicker
    Left = 315
    Top = 5
    Height = 25
    Date = 45031.000000000000000000
    DateFormat = 'dd/mm/yyyy'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Segoe UI'
    Font.Style = []
    TabOrder = 1
  end
  object edtPlaceWork: TEdit
    Left = 74
    Top = 36
    Width = 178
    Height = 23
    TabOrder = 2
    Text = 'edtFio'
  end
  object cmbGender: TComboBox
    Left = 74
    Top = 67
    Width = 143
    Height = 23
    Style = csDropDownList
    TabOrder = 3
    Items.Strings = (
      #1046
      #1052)
  end
  object Panel1: TPanel
    Left = 0
    Top = 146
    Width = 478
    Height = 41
    Align = alBottom
    TabOrder = 4
    object btnCancel: TButton
      Left = 390
      Top = 9
      Width = 75
      Height = 25
      Caption = #1054#1090#1084#1077#1085#1080#1090#1100
      TabOrder = 0
      OnClick = btnCancelClick
    end
    object BtnSave: TButton
      Left = 309
      Top = 9
      Width = 75
      Height = 25
      Caption = #1057#1086#1093#1088#1072#1085#1080#1090#1100
      TabOrder = 1
      OnClick = BtnSaveClick
    end
  end
  object edtPhone: TMaskEdit
    Left = 315
    Top = 36
    Width = 148
    Height = 23
    EditMask = '!\(999\)000-0000;1;_'
    MaxLength = 13
    TabOrder = 5
    Text = '(   )   -    '
  end
end
