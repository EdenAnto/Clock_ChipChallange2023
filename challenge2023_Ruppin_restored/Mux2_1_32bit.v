module Mux2_1_32bit(D0, D1, S, Y);

output [31:0] Y;
input  [31:0] D0, D1;
input  S;

assign Y=(S)?D1:D0;
endmodule 