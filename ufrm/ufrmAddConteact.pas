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
    procedure Edit1KeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
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
    MessageBox(0,'请输入正确格式的合约内容!','提示',MB_OKCANCEL);
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

procedure TAddConteactForm.Edit1KeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  if (Key = VK_RETURN) then SelectNext(TwinControl(Sender), True, True);
  if (Key = vk_Tab) then SelectNext(TwinControl(Sender), not (ssShift in Shift), True);
  If (Key = Vk_Up) Then SelectNext(TwinControl(Sender), false, true);
  If (Key = Vk_Down) Then SelectNext(TwinControl(Sender), True, True);
  If (Key = Vk_Up) Or (Key = Vk_Down)  Then Key := 0;
end;

end.
