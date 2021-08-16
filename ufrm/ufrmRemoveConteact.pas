unit ufrmRemoveConteact;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls,MainWIN;

type
  TRemoveConteactForm = class(TForm)
    Button1: TButton;
    Button2: TButton;
    ListBox1: TListBox;
    procedure Button2Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
//    constructor Create(AOwner: TComponent);
  end;

var
  RemoveConteactForm: TRemoveConteactForm;

implementation

{$R *.dfm}

procedure TRemoveConteactForm.Button2Click(Sender: TObject);
begin
  Close;
end;


procedure TRemoveConteactForm.FormActivate(Sender: TObject);
var
  pWin: ^TMainWindow;
  list: TStringList;
  I: Integer;
begin
  ListBox1.Clear;
  pWin := @MainWindow;
  list := FDataSchedule.FFuturesSeatingList;
  for I := 0 to list.Count - 1 do
  begin
    ListBox1.Items.Add(list[I]);
  end;

end;

//constructor TRemoveConteactForm.Create(AOwner: TComponent);
//begin
//  inherited;
//
//end;

end.
