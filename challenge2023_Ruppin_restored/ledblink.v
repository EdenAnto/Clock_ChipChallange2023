module ledBlink(
		 input in,
		 input secGen,
		 output out
		 );
		
reg counter;
reg active=0;
reg regOut=0;


always @(posedge secGen) begin
	if (in) begin
		counter=~counter;
			if(counter) 
				regOut=1;
			else 
				regOut=0;
	end
			else 
				regOut=0;
end		

assign out=regOut;


endmodule 
