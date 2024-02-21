// Copyright (C) 2019  Intel Corporation. All rights reserved.
// Your use of Intel Corporation's design tools, logic functions 
// and other software and tools, and any partner logic 
// functions, and any output files from any of the foregoing 
// (including device programming or simulation files), and any 
// associated documentation or information are expressly subject 
// to the terms and conditions of the Intel Program License 
// Subscription Agreement, the Intel Quartus Prime License Agreement,
// the Intel FPGA IP License Agreement, or other applicable license
// agreement, including, without limitation, that your use is for
// the sole purpose of programming logic devices manufactured by
// Intel and sold by Intel or its authorized distributors.  Please
// refer to the applicable agreement for further details, at
// https://fpgasoftware.intel.com/eula.

// PROGRAM		"Quartus Prime"
// VERSION		"Version 19.1.0 Build 670 09/22/2019 SJ Lite Edition"
// CREATED		"Wed Dec 28 20:22:39 2022"

module secgen(
	resetN,
	clk,
	run_stopN,
	t_out,
	sym_out
);


input wire	resetN;
input wire	clk;
input wire	run_stopN;
output wire	t_out;
output reg	sym_out;

wire	SYNTHESIZED_WIRE_0;
wire	SYNTHESIZED_WIRE_1;
wire	SYNTHESIZED_WIRE_2;

assign	t_out = SYNTHESIZED_WIRE_2;




lpm_counter2	b2v_inst(
	.sclr(SYNTHESIZED_WIRE_0),
	.clock(clk),
	.cnt_en(run_stopN),
	.aclr(SYNTHESIZED_WIRE_1),
	.cout(SYNTHESIZED_WIRE_2)
	);

assign	SYNTHESIZED_WIRE_1 =  ~resetN;

assign	SYNTHESIZED_WIRE_0 =  ~run_stopN;


always@(posedge clk)
begin
	sym_out <= sym_out ^ SYNTHESIZED_WIRE_2;
end


endmodule
