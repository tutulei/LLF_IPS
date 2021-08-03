unit ufrmlogin;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TForm3 = class(TForm)
    Label1: TLabel;
    brokerid: TEdit;
    Label2: TLabel;
    account: TEdit;
    Label3: TLabel;
    password: TEdit;
    Label4: TLabel;
    authcode: TEdit;
    Label5: TLabel;
    appid: TEdit;
    Button1: TButton;
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form3: TForm3;

implementation

{$R *.dfm}

procedure TForm3.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  if (Key = VK_RETURN) then Button1.SetFocus;
  if (Key = vk_Tab) then SelectNext(TwinControl(Sender), not (ssShift in Shift), True);
  If (Key = Vk_Up) Then SelectNext(TwinControl(Sender), false, true);
  If (Key = Vk_Down) Then SelectNext(TwinControl(Sender), True, True);
  If (Key = Vk_Up) Or (Key = Vk_Down)  Then Key := 0;
end;

end.
