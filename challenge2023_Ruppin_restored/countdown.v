module countdown (
  input CLK,
  input [31:0] initialValue,
  input start,
  input active,
  input resetN,
  input change,
  output [31:0] count,
  output done
);

reg [31:0] counter;
reg initialTime=1;
reg run;
reg led;

always @(posedge CLK) begin

	if (~resetN & active) begin
    counter <= initialValue;
	 run =0;
	 led=0;
  end 
  else if (active) begin
			led=(~initialTime & counter==0)? 1 : 0;
			if (initialTime | change) begin
				counter <= initialValue;
				initialTime <= 0;
				run=1;
			end 
			else if (counter > 0 & run & start) 
				counter <= counter - 1;
				
			
  end
end

assign count = (initialTime) ? initialValue : counter;
assign done =led;

endmodule