unit uframMedCardEdit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  uFramBase, Vcl.StdCtrls, Classes.types.Archimedes, Vcl.ComCtrls,
  Vcl.WinXPickers, Vcl.ExtCtrls, Classes.db.Archimedes, Vcl.Mask;

type
  TframMedCardEdit = class(TframBase)
    Label1: TLabel;
    edtFio: TEdit;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    dpDateBirth: TDatePicker;
    edtPlaceWork: TEdit;
    cmbGender: TComboBox;
    Panel1: TPanel;
    btnCancel: TButton;
    BtnSave: TButton;
    edtPhone: TMaskEdit;
    procedure btnCancelClick(Sender: TObject);
    procedure BtnSaveClick(Sender: TObject);
  private
    fMedCardId: integer;
    fMedCardDb: TMedCardDb;

    class var FInstance: TframMedCardEdit;

    procedure clearField();
    function fieldValidation(): Boolean;
  protected
    procedure Init; override;
  public
    class procedure initCard(const aWinControl: TWinControl;
      aFacade: TFacade; aMedCardId: integer);
  end;


implementation

{$R *.dfm}

{ TframMedCardEdit }

class procedure TframMedCardEdit.initCard(const aWinControl: TWinControl; aFacade: TFacade;
  aMedCardId: integer);
begin
  if not aFacade.isCreatedSheet(aMedCardId) then
    if (aWinControl is TTabSheet) then begin
      var vMedCard: TMedCard:= TMedCard.Create((aWinControl as TTabSheet).PageControl, aMedCardId);
      var framMedCardEdit:= TframMedCardEdit.create(vMedCard.TabSheet);

      aFacade.MedCardlist.Add(vMedCard);

      framMedCardEdit.Parent:= vMedCard.TabSheet;
      
      vMedCard.TabSheet.Tag:= aMedCardId;
      if aMedCardId > 0 then
        vMedCard.TabSheet.Caption:= aFacade.Db.getFIO(aMedCardId)
      else vMedCard.TabSheet.Caption:= 'Новая мед.карта';

      framMedCardEdit.fFacade:= aFacade;
      framMedCardEdit.fMedCardId:= aMedCardId;
      framMedCardEdit.Init();      

      (aWinControl as TTabSheet).PageControl.ActivePage:= vMedCard.TabSheet;
    end;
end;

procedure TframMedCardEdit.btnCancelClick(Sender: TObject);
begin
  inherited;
  fFacade.deleteSheetCard(fMedCardDb.Id);
end;

procedure TframMedCardEdit.BtnSaveClick(Sender: TObject);
begin
  inherited;
  if fieldValidation() then begin
    fMedCardDb.Fio:= edtFio.Text;
    fMedCardDb.PlaceWork:= edtPlaceWork.Text;
    fMedCardDb.Telephone:= edtPhone.Text;
    fMedCardDb.Gender:= cmbGender.Items[cmbGender.ItemIndex];
    fMedCardDb.DateBirth:= DateToStr(dpDateBirth.Date);

    fFacade.SaveMedCard(fMedCardDb);

  end;
end;

procedure TframMedCardEdit.clearField;
begin
  edtFio.Text:= EmptyStr;
  edtPlaceWork.Text:= EmptyStr;
  edtPhone.Text:= EmptyStr;
  cmbGender.ItemIndex:= -1;
  dpDateBirth.Date:= Now();
end;

function TframMedCardEdit.fieldValidation: Boolean;
begin
  result:= True;
  if edtFio.Text = EmptyStr then begin
    Application.MessageBox('Нужно ввести ФИО пациента', 'Ошибка', MB_OK or MB_ICONERROR);
    edtFio.SetFocus;
    result:= false;
  end;

  if cmbGender.ItemIndex = -1 then begin
    Application.MessageBox('Нужно выбрать пол пациента', 'Ошибка', MB_OK or MB_ICONERROR);
    cmbGender.SetFocus;
    result:= false;
  end;
end;

procedure TframMedCardEdit.Init;
begin
  inherited;
  clearField();

  fMedCardDb:= fFacade.Db.getMedCardInfo(fMedCardId);
  if Assigned(fMedCardDb) then begin
    edtFio.Text:= fMedCardDb.Fio;
    edtPlaceWork.Text:= fMedCardDb.PlaceWork;
    edtPhone.Text:= fMedCardDb.Telephone;
    cmbGender.ItemIndex:= fMedCardDb.getGender;
    dpDateBirth.Date:= fMedCardDb.getDateBirth;  
  end else fMedCardDb:= TMedCardDb.Create;
end;

end.
