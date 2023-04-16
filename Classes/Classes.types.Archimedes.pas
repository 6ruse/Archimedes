unit Classes.types.Archimedes;

interface

uses
  Vcl.ComCtrls, System.Generics.Collections, Classes.db.Archimedes,
  System.Classes;

type
  TMedCard = class;
  TMedCardlist = TObjectList<TMedCard>;

  TFacade = class
  private
    fMedCardlist: TMedCardlist;
    fDb: TDb;
  public
    fOnUpdate: TNotifyEvent;
    fOnUpdateMainForm: TNotifyEvent;

    constructor Create();
    destructor Destroy; override;

    property MedCardlist: TMedCardlist read fMedCardlist write fMedCardlist;
    property Db: TDb read fDb write fDb;

    procedure SaveMedCard(const aMedCardDb: TMedCardDb);
    procedure deleteSheetCard(const aMedCardId: Integer);
    procedure MedCardDelete(const aMedCardId: Integer);

    function isCreatedSheet(aMedCardId: Integer): boolean;
  end;

  TMedCard = class
  private
    fTTabSheet: TTabSheet;
    fMedCardId: Integer;
  public
    property TabSheet: TTabSheet read fTTabSheet write fTTabSheet;

    constructor Create(const aPageControl: TPageControl; aMedCardId: Integer);
    destructor Destroy; override;
  end;

implementation

{ TMedCard }

constructor TMedCard.Create(const aPageControl: TPageControl; aMedCardId: Integer);
begin
  fTTabSheet := TTabSheet.Create(aPageControl);
  fTTabSheet.Caption := 'New Tab Sheet';
  fTTabSheet.PageControl := aPageControl;

  fMedCardId:= aMedCardId;

end;

destructor TMedCard.Destroy;
begin
  fTTabSheet.Destroy;
  inherited;
end;

{ TFacade }

constructor TFacade.Create;
begin
  fMedCardlist:= TMedCardlist.Create;
  fDb:= TDb.Create;
end;

procedure TFacade.deleteSheetCard(const aMedCardId: Integer);
begin
  for var vMedCard: TMedCard in fMedCardlist do begin
    if vMedCard.fMedCardId = aMedCardId then begin
      fMedCardlist.Delete(fMedCardlist.IndexOf(vMedCard));
      fOnUpdate(self);
      fOnUpdateMainForm(self);
    end;
  end;
end;

destructor TFacade.Destroy;
begin
  fMedCardlist.Free;
  fDb.Free;
  inherited;
end;

function TFacade.isCreatedSheet(aMedCardId: Integer): boolean;
begin
  result:= false;
  for var vMedCard: TMedCard in fMedCardlist do begin
    if vMedCard.fMedCardId = aMedCardId then
      result:= true;
  end;

end;

procedure TFacade.MedCardDelete(const aMedCardId: Integer);
begin
  db.MedCardDelete(aMedCardId);
  fOnUpdate(self);
end;

procedure TFacade.SaveMedCard(const aMedCardDb: TMedCardDb);
begin
  db.SaveMedCard(aMedCardDb);
  deleteSheetCard(aMedCardDb.Id);
end;

end.
