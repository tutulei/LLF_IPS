unit ufrmRemoveConteact;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls;

type
  TRemoveConteactForm = class(TForm)
    Button1: TButton;
    Button2: TButton;
    ListBox1: TListBox;
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }

  end;

var
  RemoveConteactForm: TRemoveConteactForm;

implementation

{$R *.dfm}

procedure TRemoveConteactForm.Button2Click(Sender: TObject);
begin
  Close;
end;


end.
