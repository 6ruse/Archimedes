object frmMain: TfrmMain
  Left = 0
  Top = 0
  Caption = 'Archimedes'
  ClientHeight = 442
  ClientWidth = 628
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poScreenCenter
  OnClose = FormClose
  OnCreate = FormCreate
  OnShow = FormShow
  TextHeight = 15
  object StatusBar1: TStatusBar
    Left = 0
    Top = 423
    Width = 628
    Height = 19
    Panels = <
      item
        Width = 50
      end>
    ExplicitTop = 422
    ExplicitWidth = 624
  end
  object PageControl1: TPageControl
    Left = 0
    Top = 0
    Width = 628
    Height = 382
    ActivePage = tabMedCard
    Align = alClient
    TabOrder = 1
    OnChange = PageControl1Change
    ExplicitWidth = 624
    ExplicitHeight = 381
    object tabMedCard: TTabSheet
      Caption = #1052#1077#1076#1080#1094#1080#1085#1089#1082#1080#1077' '#1082#1072#1088#1090#1099
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 382
    Width = 628
    Height = 41
    Align = alBottom
    TabOrder = 2
    ExplicitTop = 381
    ExplicitWidth = 624
    object btnClose: TButton
      Left = 549
      Top = 9
      Width = 75
      Height = 25
      Caption = #1047#1072#1082#1088#1099#1090#1100
      TabOrder = 0
      OnClick = btnCloseClick
    end
    object btnAdd: TButton
      Left = 4
      Top = 9
      Width = 75
      Height = 25
      Caption = #1044#1086#1073#1072#1074#1080#1090#1100
      TabOrder = 1
      OnClick = btnAddClick
    end
    object btnDel: TButton
      Left = 85
      Top = 9
      Width = 75
      Height = 25
      Caption = #1059#1076#1072#1083#1080#1090#1100
      TabOrder = 2
      OnClick = btnDelClick
    end
  end
end
