module rise_det (
  input  clk,
  input  signal,
  output  rise
);

reg signal_d1;

wire detect;

assign detect = (signal_d1 == 1'b0 && signal == 1'b1);

always @(posedge clk) begin
  signal_d1 <= signal;
end

assign rise = (detect) ? 1'b1 : 1'b0;

endmodule
