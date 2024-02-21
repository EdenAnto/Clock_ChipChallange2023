module alarmClock(
		input Clk,
		input [31:0] realTime,
		input [31:0] alarmTime,
		input active,
		input key,
		output alarmDone
);


reg done=0;

always @(posedge Clk)
begin
	if (active)begin
		if (realTime ==alarmTime)
			done =1;	
	end
	if(~key | ~active) 
		done=0;

end

assign alarmDone=done;




endmodule
