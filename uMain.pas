unit uMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Classes.types.Archimedes, Vcl.ComCtrls, Vcl.ExtCtrls, Vcl.StdCtrls;

type
  TfrmMain = class(TForm)
    StatusBar1: TStatusBar;
    PageControl1: TPageControl;
    Panel1: TPanel;
    tabMedCard: TTabSheet;
    btnClose: TButton;
    btnAdd: TButton;
    btnDel: TButton;
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnCloseClick(Sender: TObject);
    procedure PageControl1Change(Sender: TObject);
    procedure BtnSaveClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure btnDelClick(Sender: TObject);
    procedure btnAddClick(Sender: TObject);
  private
    procedure controlPanelActivate(const aActivate: boolean);
    procedure refresh(Sender: TObject);
  protected
    Facade: TFacade;
  end;

var
  frmMain: TfrmMain;

implementation

uses
 uFramMedCard, Classes.db.Archimedes, uframMedCardEdit;

{$R *.dfm}

procedure TfrmMain.btnAddClick(Sender: TObject);
begin
  TframMedCardEdit.initCard(tabMedCard, Facade, 0);
end;

procedure TfrmMain.btnCancelClick(Sender: TObject);
begin
  controlPanelActivate(true);
end;

procedure TfrmMain.btnCloseClick(Sender: TObject);
begin
  Close();
end;

procedure TfrmMain.btnDelClick(Sender: TObject);
begin
  var vMedCardId: Integer:= TframMedCard.getCurrentMedCardId();
  if MessageDlg(Format('Вы действительно хотите удалить выбранную (%s) запись?', [Facade.Db.getFIO(vMedCardId)]),
    mtConfirmation, [mbYes, mbNo], 0, mbYes) = mrYes then
    Facade.MedCardDelete(vMedCardId);
end;

procedure TfrmMain.BtnSaveClick(Sender: TObject);
begin
  var vMedCardDb: TMedCardDb:= Facade.Db.getMedCardInfo(PageControl1.ActivePage.Tag);

  controlPanelActivate(true);
end;

procedure TfrmMain.controlPanelActivate(const aActivate: boolean);
begin
  btnAdd.Enabled:= aActivate;
  btnDel.Enabled:= aActivate;
end;

procedure TfrmMain.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Facade.Free;
end;

procedure TfrmMain.FormCreate(Sender: TObject);
begin
  try
    Facade:= TFacade.Create;
    Facade.fOnUpdateMainForm:= refresh;
  except on e:Exception do begin
    var vMsg: string:= 'В процессе инициализации приложения возникла ошибка:' + e.Message;
    Application.MessageBox(PWideChar(vMsg), 'Критическая ошибка', MB_OK or MB_ICONERROR);
    Application.Terminate;
  end;
  end;
end;

procedure TfrmMain.FormShow(Sender: TObject);
begin
  StatusBar1.Panels[0].Text:= Facade.Db.getConnectInfo();
  TframMedCard.inst(tabMedCard, Facade);
  controlPanelActivate(true);
end;

procedure TfrmMain.PageControl1Change(Sender: TObject);
begin
  controlPanelActivate(PageControl1.ActivePage = tabMedCard);
end;

procedure TfrmMain.refresh(Sender: TObject);
begin
  controlPanelActivate(PageControl1.ActivePage = tabMedCard);
end;

end.
