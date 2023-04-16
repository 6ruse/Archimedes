unit Classes.db.Archimedes;

interface

uses
  FireDAC.Comp.Client, FireDAC.Stan.Def, FireDAC.Phys.SQLiteVDataSet,
  FireDAC.Phys.SQLite, FireDAC.Phys.SQLiteDef, FireDAC.VCLUI.Wait,
  FireDAC.Phys.SQLiteWrapper;

type
  TMedCardDb = class
  private
    fId: Integer;
    fFio: string;
    fDateBirth: string;
    fGender: string;
    fTelephone: string;
    fPlaceWork: string;
    fSprPeopleId: Integer;
  public
    property Id: Integer read fId write fId;
    property Fio: string read fFio write fFio;
    property DateBirth: string read fDateBirth write fDateBirth;
    property Gender: string read fGender write fGender;
    property Telephone: string read fTelephone write fTelephone;
    property PlaceWork: string read fPlaceWork write fPlaceWork;
    property SprPeopleId: Integer read fSprPeopleId write fSprPeopleId;

    function getGender(): integer;
    function getDateBirth(): Tdate;
  end;

  TDb = class
  private const
    cnstDbName = 'Archimedes.db';
    sqlInsPeople = 'insert into spr_people(fio, date_birth, gender, telephone) values(:fio, :date_birth, :gender, :telephone)';
    sqlUpdPeople = 'update spr_people set fio = :fio, date_birth = :date_birth, gender = :gender, telephone = :telephone where id = :id';
 public const
    cnstMedCardSlct = 'select mc.id, sp.id as spr_people_id, sp.fio, mc.place_work, sp.date_birth, sp.gender, sp.telephone from med_card mc join spr_people sp on sp.id = mc.spr_people_id';
  private
    FDConnection: TFDConnection;
    fQuery: TFDQuery;

    procedure connectDb();
    procedure updateMedCard(const aMedCardDb: TMedCardDb);
    procedure insertMedCard(const aMedCardDb: TMedCardDb);

    function GetLastInsertRowID(): Int64;

  public
    constructor Create;
    destructor Destroy; override;

    property DConnection: TFDConnection read FDConnection write FDConnection;

    procedure SaveMedCard(const aMedCardDb: TMedCardDb);
    procedure MedCardDelete(const aMedCardId: Integer);

    function getConnectInfo(): string;
    function getFIO(const aMedCardId: Integer): string;
    function getMedCardInfo(const aMedCardId: Integer): TMedCardDb;
  end;

implementation

uses
  System.SysUtils, Uni;

{ TDb }

procedure TDb.connectDb;
begin
  FDConnection.Open();
end;

constructor TDb.Create;
begin
  if FileExists(cnstDbName) then begin
    FDConnection:= TFDConnection.Create(nil);

    FDConnection.DriverName:= 'SQLite';
    FDConnection.Params.Values['ColumnMetadataSupported'] := 'False';
    FDConnection.Params.Values['Database'] := cnstDbName;

    fQuery:= TFDQuery.Create(FDConnection);
    fQuery.Connection:= FDConnection;

    connectDb();

  end
  else raise Exception.Create('Не найден файл БД: ' + cnstDbName);
end;

destructor TDb.Destroy;
begin
  if Assigned(fQuery) then
    fQuery.Destroy;

  if Assigned(FDConnection) then begin
    FDConnection.Close();
    FDConnection.Free;
  end;
  inherited;
end;

function TDb.getConnectInfo: string;
begin
  if FDConnection.Connected then
    result:= Format('Подключен к БД: %s', [cnstDbName])
  else
    result:= Format('Нет подключения к БД: %s', [cnstDbName])
end;

function TDb.getFIO(const aMedCardId: Integer): string;
begin
  fQuery.Close;
  fQuery.SQL.Text:= 'select sp.fio from med_card mc join spr_people sp on sp.id = mc.spr_people_id where mc.id = ' + aMedCardId.ToString;
  fQuery.Open;
  if not fQuery.eof then
    resuLt:= fQuery.FieldByName('fio').AsString;

  fQuery.Close;
end;

function TDb.GetLastInsertRowID: Int64;
begin
  result:= Int64((TObject(FDConnection.CliObj) as TSQLiteDatabase).LastInsertRowid);
end;

function TDb.getMedCardInfo(const aMedCardId: Integer): TMedCardDb;
begin
  fQuery.Close;
  fQuery.SQL.Text:= 'select mc.id, sp.id as spr_people_id, sp.fio, mc.place_work, sp.date_birth, sp.gender, sp.telephone from med_card mc join spr_people sp on sp.id = mc.spr_people_id where mc.id = ' + aMedCardId.ToString;
  fQuery.Open;
  if not fQuery.eof then begin
    result:= TMedCardDb.Create;
    resuLt.Fio:= fQuery.FieldByName('fio').AsString;
    resuLt.DateBirth:= fQuery.FieldByName('date_birth').AsString;
    resuLt.Gender:= fQuery.FieldByName('gender').AsString;
    resuLt.Telephone:= fQuery.FieldByName('telephone').AsString;
    resuLt.PlaceWork:= fQuery.FieldByName('place_work').AsString;
    resuLt.SprPeopleId:= fQuery.FieldByName('spr_people_id').AsInteger;
    resuLt.id:= fQuery.FieldByName('id').AsInteger;
  end;
  fQuery.Close;
end;

procedure TDb.insertMedCard(const aMedCardDb: TMedCardDb);
begin
  fQuery.Close;

  if aMedCardDb.SprPeopleId = 0 then
    fQuery.SQL.Text:= sqlInsPeople;

  fQuery.ParamByName('fio').AsString:= aMedCardDb.Fio;
  fQuery.ParamByName('date_birth').AsString:= aMedCardDb.DateBirth;
  fQuery.ParamByName('gender').AsString:= aMedCardDb.Gender;
  fQuery.ParamByName('telephone').AsString:= aMedCardDb.Telephone;

  fQuery.ExecSQL;

  var vIdPeople: Integer:= GetLastInsertRowID();

  fQuery.Close;
  fQuery.SQL.Text:= 'insert into med_card(spr_people_id, place_work) values(:spr_people_id, :place_work)';

  fQuery.ParamByName('spr_people_id').AsInteger:= vIdPeople;
  fQuery.ParamByName('place_work').AsString:= aMedCardDb.PlaceWork;

  fQuery.ExecSQL;
  fQuery.Close;
end;

procedure TDb.MedCardDelete(const aMedCardId: Integer);
const
  sql = 'delete from med_card where id = :id';
begin
  fQuery.Close;
  fQuery.SQL.Text:= sql;
  fQuery.ParamByName('id').AsInteger:= aMedCardId;
  fQuery.ExecSQL;
  fQuery.Close;
end;

procedure TDb.SaveMedCard(const aMedCardDb: TMedCardDb);
begin
  if aMedCardDb.Id = 0 then begin
    insertMedCard(aMedCardDb);
  end else
    updateMedCard(aMedCardDb);
end;

procedure TDb.updateMedCard(const aMedCardDb: TMedCardDb);
begin
  fQuery.Close;

  if aMedCardDb.SprPeopleId = 0 then
    fQuery.SQL.Text:= sqlInsPeople
  else begin
    fQuery.SQL.Text:= sqlUpdPeople;
    fQuery.ParamByName('id').AsInteger:= aMedCardDb.SprPeopleId;
  end;

  fQuery.ParamByName('fio').AsString:= aMedCardDb.Fio;
  fQuery.ParamByName('date_birth').AsString:= aMedCardDb.DateBirth;
  fQuery.ParamByName('gender').AsString:= aMedCardDb.Gender;
  fQuery.ParamByName('telephone').AsString:= aMedCardDb.Telephone;

  fQuery.ExecSQL;

  fQuery.Close;
end;

{ TMedCardDb }

function TMedCardDb.getDateBirth: Tdate;
var

  s: string;
  dt: TDateTime;
begin
  var fs: TFormatSettings:= TFormatSettings.Create;
  fs.DateSeparator := '-';
  fs.ShortDateFormat := 'dd.MM.yyyy';
  result:= strToDate(DateBirth, fs);
end;

function TMedCardDb.getGender: integer;
begin
  if fgender = 'М' then
    result:= 1
  else
    result:= 0;
end;


end.
