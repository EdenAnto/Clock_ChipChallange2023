module stopper (
    input CLK,
    input active,
    input [1:0] KEY,
    output reg [31:0] counter
);


initial begin
    counter = 0;
end
reg work=0;


always@(posedge CLK |~KEY[1])begin
	if(active) begin
		if(~KEY[0])
			work = ~work;
		else if (~KEY[1])
			counter=0;
	end
	if (work & KEY[1])
		counter=counter+1;
end
 

endmodule
