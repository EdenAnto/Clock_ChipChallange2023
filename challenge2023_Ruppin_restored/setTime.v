module setTime(input 		 CLK,
               input  [1:0] KEY,
					input  on,// for inner calls
					output [31:0] userTime,
					output finish,
					output [1:0] stage
					);
					
reg [1:0] state=0;
reg [31:0] timeTmp=0;
reg finishFlag=0;

always @(negedge KEY[0]) begin
	if(on) begin
		state=state+1;
		if (state==3) 
			finishFlag=1;
		else
			finishFlag=0;
	end

end

always @(negedge KEY[1]) begin
	if (on) begin
		if(timeTmp>=86400)begin
		timeTmp=timeTmp-86400;
		end
		case (state)
			0: timeTmp=timeTmp+3600;
			1: timeTmp=timeTmp+60;
			2: timeTmp=timeTmp+1;
			3: ;
		endcase
	end
	
end


assign userTime=timeTmp;
assign finish=finishFlag;
assign stage=state;
endmodule