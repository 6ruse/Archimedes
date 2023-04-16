program Archimedes;

uses
  Vcl.Forms,
  uMain in 'uMain.pas' {frmMain},
  Classes.db.Archimedes in 'Classes\Classes.db.Archimedes.pas',
  uFramBase in 'Frame\uFramBase.pas' {framBase: TFrame},
  uFramMedCard in 'Frame\uFramMedCard.pas' {framMedCard: TFrame},
  uframMedCardEdit in 'Frame\uframMedCardEdit.pas' {framMedCardEdit: TFrame},
  Classes.types.Archimedes in 'Classes\Classes.types.Archimedes.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmMain, frmMain);
  Application.Run;
end.
