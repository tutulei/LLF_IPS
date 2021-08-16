unit uTimer;

interface

uses
  ExtCtrls;

type
  TTimingEvent = class
  private
    timer: TTimer;
  public
    constructor Create(time: double);
  end;

implementation

constructor TTimingEvent.Create(time: double);
begin
  timer := TTimer.Create(nil);
//  timer.Interval := time;
//  timer.Enabled := True;
end;


procedure OnTimer();
begin

end;  

end.

