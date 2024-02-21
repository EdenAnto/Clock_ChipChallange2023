module Mux2_DateOrTime(input [31:0] bus,
								input S,
								output wire [7:0] left,
								output wire [7:0] middle,
								output wire [7:0] right);



assign left=(S)?((bus/10000)%31)+1:(bus/3600)%24;
assign middle=(S)? (((bus/100)%100)%12)+1:(bus%3600)/60;
assign right=(S)? bus%100:(bus%3600)%60;
endmodule 