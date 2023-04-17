inherited framMedCard: TframMedCard
  Align = alClient
  object DBGrid: TDBGrid
    Left = 0
    Top = 41
    Width = 640
    Height = 439
    Align = alClient
    DataSource = dsMedCard
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgTitleClick, dgTitleHotTrack]
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -12
    TitleFont.Name = 'Segoe UI'
    TitleFont.Style = []
    OnDrawColumnCell = DBGridDrawColumnCell
    OnDblClick = DBGridDblClick
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 640
    Height = 41
    Align = alTop
    TabOrder = 1
    object edtFioFind: TEdit
      Left = 15
      Top = 12
      Width = 338
      Height = 23
      TabOrder = 0
      TextHint = #1042#1074#1077#1076#1080#1090#1077' '#1086#1073#1088#1072#1079#1077#1094' '#1076#1083#1103' '#1087#1086#1080#1089#1082#1072'...'
    end
    object btnFind: TButton
      Left = 359
      Top = 9
      Width = 75
      Height = 25
      Caption = #1055#1086#1080#1089#1082
      TabOrder = 1
      OnClick = btnFindClick
    end
  end
  object dsMedCard: TDataSource
    DataSet = fdtMedCard
    Left = 240
    Top = 144
  end
  object fdtMedCard: TFDQuery
    Left = 128
    Top = 96
    object fdtMedCardfio: TStringField
      DisplayLabel = #1060#1048#1054
      FieldName = 'fio'
      Size = 255
    end
    object fdtMedCardid: TIntegerField
      FieldName = 'id'
      Visible = False
    end
    object fdtMedCardspr_people_id: TIntegerField
      FieldName = 'spr_people_id'
      Visible = False
    end
    object fdtMedCardplace_work: TStringField
      DisplayLabel = #1044#1086#1083#1078#1085#1086#1089#1090#1100
      FieldName = 'place_work'
      Size = 255
    end
    object fdtMedCarddate_birth: TStringField
      DisplayLabel = #1044#1072#1090#1072' '#1088#1086#1078#1076#1077#1085#1080#1103
      FieldName = 'date_birth'
      Size = 10
    end
    object fdtMedCardgender: TStringField
      DisplayLabel = #1055#1086#1083
      FieldName = 'gender'
      Size = 1
    end
    object fdtMedCardtelephone: TStringField
      DisplayLabel = #1058#1077#1083#1077#1092#1086#1085
      FieldName = 'telephone'
      Size = 14
    end
  end
end
