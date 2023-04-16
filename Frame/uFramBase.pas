unit uFramBase;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Classes.types.Archimedes;

type
  TframBase = class(TFrame)
  protected
    fFacade: TFacade;
    procedure Init; virtual;
  end;

implementation

{$R *.dfm}

{ TframBase }

{ TframBase }

procedure TframBase.Init;
begin

end;

end.
