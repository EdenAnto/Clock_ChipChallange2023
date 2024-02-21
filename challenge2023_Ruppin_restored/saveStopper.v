module saveStopper(
	 input CLK,
	 input active,
    input [1:0] KEY,
    input [31:0] in,
    output [31:0] out1,
	 output [31:0] out2,
	 output [31:0] out3

);

    parameter SAVE1_STATE = 0;
    parameter SAVE2_STATE = 1;
	 parameter SAVE3_STATE = 2;


    reg [1:0] current_state=SAVE1_STATE;
	 reg [31:0] out1Tmp,out2Tmp,out3Tmp;
	
	 
	 initial begin
		current_state=SAVE1_STATE;
		//out1=0;
		//out2=0;
		end

    always @(negedge KEY[0]) begin
		if (active) begin
        case (current_state) 
		  0: begin
						current_state=SAVE2_STATE;
						out1Tmp= in;
				end
		  
		  1: begin
						current_state=SAVE3_STATE;
						out2Tmp= in;
				end
				
		  2: begin
						current_state=SAVE1_STATE;
						out3Tmp= in;
				end
        endcase
		end
    end
	 
	 assign out1=out1Tmp;
	 assign out2=out2Tmp;
	 assign out3=out3Tmp;
	 
endmodule
