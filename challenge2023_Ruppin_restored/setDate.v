module setDate(input 		 CLK,
               input  [1:0] KEY,
					input  on,// for inner calls
					input [31:0] iniDate,
					output [31:0] userDate,
					output finish,
					output [1:0] stage
					);
					
reg [1:0] state=3;
reg [31:0] dateTmp;
reg finishFlag=0;
reg first=1;

always @(negedge KEY[0]) begin
	if(on) begin
		state=state+1;
		first=0;
		if (state==3) 
			finishFlag=1;
		else
			finishFlag=0;
	end

end

always @(negedge KEY[1]) begin
	if (on) begin
		case (state)
			0: dateTmp=dateTmp+10000;
			1: dateTmp=dateTmp+100;
			2: dateTmp=dateTmp+1;
			3: ;
		endcase
	end
	
end


assign userDate= (first)? iniDate:dateTmp;
assign finish=finishFlag;
assign stage=state;
endmodule