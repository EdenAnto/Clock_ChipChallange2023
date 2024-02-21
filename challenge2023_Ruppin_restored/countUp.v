module countUp (
  input CLK,
  input [31:0] initialValue,
  output [31:0] count,
  input change
  );

reg [31:0] counter;

reg initialTime=1;

always @(posedge CLK)begin
	if(counter>=86400)begin
		counter <= counter - 86400;
		end
	counter <= counter + 1;  	//  increase seconds by 1

	if(initialTime==1 | change) begin
	    counter <= initialValue;
		 initialTime=0;
	end
	
	
end

assign count = (initialTime)? initialValue: counter;

endmodule
