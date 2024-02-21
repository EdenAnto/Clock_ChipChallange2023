module halfSecGenNew(
		input CLK,
		input [7:0] number,
		input [1:0] currentState,
		input [1:0] blinkState,
		input activeBlink,
		output reg [7:0] blinkedNumber
		);

reg [7:0] tmpNumber;
reg [31:0] count=0;

always @(posedge CLK) begin
	count=count+1;
	if (currentState == blinkState & ~activeBlink) begin
		if(count % 50000000 <= 10000000) 
			tmpNumber=number;
		else 
			tmpNumber=~8'b00000000;
			
	end
	else begin
		tmpNumber=number;
	end
blinkedNumber=tmpNumber;

	
end

 //assign pulse=flag;
endmodule
