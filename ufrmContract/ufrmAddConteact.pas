unit ufrmAddConteact;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls,MainWIN;

type
  TAddConteactForm = class(TForm)
    Button1: TButton;
    Label1: TLabel;
    Edit1: TEdit;
    Button2: TButton;
    Label2: TLabel;
    procedure Button2Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  AddConteactForm: TAddConteactForm;

implementation

{$R *.dfm}

procedure TAddConteactForm.Button1Click(Sender: TObject);
var
  list: TStringList;
begin

  if Edit1.Text = '' then
  begin
    MessageBox(0,'��������ȷ��ʽ�ĺ�Լ����!','��ʾ',MB_OKCANCEL);
  end
  else
  begin
    list := TStringList.Create();
    list.CommaText := Edit1.Text;
    AddConteact(list);
    list.Free;
    Close;
  end;
end;

procedure TAddConteactForm.Button2Click(Sender: TObject);
begin
    Close;
end;

end.