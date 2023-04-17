unit uFramMedCard;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uFramBase, Data.DB, Vcl.ExtCtrls,
  Vcl.Grids, Vcl.DBGrids, Classes.types.Archimedes, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.StdCtrls;

type
  TframMedCard = class(TframBase)
    DBGrid: TDBGrid;
    Panel1: TPanel;
    dsMedCard: TDataSource;
    fdtMedCard: TFDQuery;
    fdtMedCardfio: TStringField;
    fdtMedCardid: TIntegerField;
    fdtMedCardspr_people_id: TIntegerField;
    fdtMedCardplace_work: TStringField;
    fdtMedCarddate_birth: TStringField;
    fdtMedCardgender: TStringField;
    edtFioFind: TEdit;
    btnFind: TButton;
    fdtMedCardtelephone: TStringField;
    procedure DBGridDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure DBGridDblClick(Sender: TObject);
    procedure btnFindClick(Sender: TObject);
  private
    class var FInstance: TframMedCard;

    procedure refresh(Sender: TObject);
    procedure find();
  protected
    procedure Init; override;
  public
    class function inst(const aWinControl: TWinControl; aFacade: TFacade): TframMedCard;
    class function getCurrentMedCardId(): Integer;
  end;


implementation

uses
  uframMedCardEdit;

{$R *.dfm}

{ TframMedCard }

class function TframMedCard.inst(const aWinControl: TWinControl; aFacade: TFacade): TframMedCard;
begin
  if not Assigned(FInstance) then begin
    FInstance:= TframMedCard.Create(nil);
  end;
  FInstance.Parent:= aWinControl;
  FInstance.fFacade:= aFacade;
  FInstance.Init();
  Result:= FInstance;
end;

procedure TframMedCard.refresh(Sender: TObject);
begin
  fdtMedCard.Close;
  fdtMedCard.Open;
end;

procedure TframMedCard.btnFindClick(Sender: TObject);
begin
  inherited;
  find();
end;

procedure TframMedCard.DBGridDblClick(Sender: TObject);
begin
  inherited;
  TframMedCardEdit.initCard(FInstance.Parent, FInstance.fFacade, fdtMedCard.FieldByName('id').AsInteger);
end;

procedure TframMedCard.DBGridDrawColumnCell(Sender: TObject; const Rect: TRect;
  DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
  var w: integer := 40 + DBGrid.Canvas.TextExtent(Column.Field.DisplayText).cx;
  if w > column.Width then Column.Width:= w;
end;

procedure TframMedCard.find;
begin
  if edtFioFind.Text = EmptyStr then Exit();
  
  var vWhere: string:= ' where  sp.fio like ''%' + edtFioFind.Text + '%'';';
  fdtMedCard.Close;
  fdtMedCard.Open(fFacade.Db.cnstMedCardSlct + vWhere);
end;

class function TframMedCard.getCurrentMedCardId: Integer;
begin
  result:= 0;
  if Assigned(FInstance) then
    result:= FInstance.fdtMedCard.FieldByName('id').AsInteger;
end;

procedure TframMedCard.Init;
begin
  inherited;
  fFacade.fOnUpdate:= refresh;

  fdtMedCard.Connection:= fFacade.Db.DConnection;
  fdtMedCard.Open(fFacade.Db.cnstMedCardSlct);

  for var i: integer:= 0 to DBGrid.Columns.Count - 1 do
    DBGrid.Columns[i].Width:= 40 + DBGrid.Canvas.TextWidth(DBGrid.Columns[i].title.caption)

end;

end.
