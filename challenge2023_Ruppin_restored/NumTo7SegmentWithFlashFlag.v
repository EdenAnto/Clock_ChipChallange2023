module NumTo7SegmentWithFlashFlag(num,FlashFlag,ans10,ans1);
input FlashFlag;
input[31:0] num;
output [3:0] ans10,ans1;



assign ans10=FlashFlag?15:(num/10); //15=all on
assign ans1=FlashFlag?15:(num%10);
 
 
endmodule