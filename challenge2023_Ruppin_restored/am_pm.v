module am_pm(
		 input clk,
		 input active,
		 input [4:0] hour,
		 output [4:0] am_pm_hour,
		 output reg pm_indicator
		 );
		
reg [4:0] tmpHour;		
always@(posedge clk & active) begin
	if (hour>12)begin 
		tmpHour=hour-12;
		pm_indicator=1;
	end
	else begin
		tmpHour=hour;
		pm_indicator=0;
		end
end

assign am_pm_hour=tmpHour;
endmodule	