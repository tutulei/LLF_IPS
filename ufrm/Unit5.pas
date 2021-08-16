unit Unit5;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, jpeg, ExtCtrls,Unit1;

type
  TForm5 = class(TForm)
    Panel1: TPanel;
    Image1: TImage;
    GroupBox1: TGroupBox;
    Edit1: TEdit;
    Label1: TLabel;
    Button1: TButton;
    Edit2: TEdit;
    Label2: TLabel;
    Edit3: TEdit;
    Label3: TLabel;
    Edit4: TEdit;
    Label4: TLabel;
    Label5: TLabel;
    Edit5: TEdit;
    Edit6: TEdit;
    Label6: TLabel;
    LoginButton: TButton;
    ExitButton: TButton;
    procedure FormShow(Sender: TObject);
    procedure Panel1MouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
    procedure Panel1MouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure Panel1MouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure ExitButtonClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    moveFlag: Boolean;
    moveX:Integer;
    moveY:Integer;
    { Private declarations }
  public
    { Public declarations }
    procedure DoInvisible();
  end;

var
  Form5: TForm5;

implementation

{$R *.dfm}

procedure TForm5.ExitButtonClick(Sender: TObject);
begin
  Close;
end;

procedure TForm5.Button1Click(Sender: TObject);
begin
  Form1.Show;
end;

procedure TForm5.DoInvisible;  //透明
var
  control: TControl;
  index, margin, X, Y, ctlX, ctlY, i: Integer;
  fullRgn, clientRgn, ctlRgn: THandle;
begin
  margin := (Width - ClientWidth) div 2;
  fullRgn := CreateRectRgn(0, 0, Width, Height); //创建总裁剪区域
  X := margin;
  Y := Height - ClientHeight - margin;
  clientRgn := CreateRectRgn(X, Y, X + ClientWidth, Y + ClientHeight);
  CombineRgn(fullRgn, fullRgn, clientRgn, RGN_DIFF); //合并区域，RGN_DIFF差集

  for index := 0 to ControlCount - 1 do   //遍历控件
  begin
    control := Controls[index];
    if (control is TWinControl) or (control is TGraphicControl) then
      with control do
      begin
        if Visible then
        begin
          ctlX := X + Left;
          ctlY := Y + Top;
//          ctlRgn := CreateRectRgn(CtlX, CtlY, CtlX + Width, CtlY + Height);
          ctlRgn := CreateRoundRectRgn(ctlX, ctlY, ctlX + Width, ctlY + Height, 20, 20);
          CombineRgn(fullRgn, fullRgn, ctlRgn, RGN_OR);  //RGN_OR并集

        end;
      end;
  end;
  SetWindowRgn(Handle, fullRgn, True);    //设置重绘窗口
end;

procedure TForm5.FormShow(Sender: TObject);
begin
  DoInvisible();
  moveFlag := False;
end;

procedure TForm5.Panel1MouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  moveFlag := true;
  moveX := X;
  moveY := Y;
end;

procedure TForm5.Panel1MouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
begin
  if (moveFlag) then
  begin

    self.Top := Mouse.CursorPos.y - moveY;
    self.Left := Mouse.CursorPos.x - moveX;
  end;
end;

procedure TForm5.Panel1MouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  moveFlag := False;
end;

end.

