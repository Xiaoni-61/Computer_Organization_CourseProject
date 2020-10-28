module IF(clk,of,jal,out);
  input of,jal,clk;
  output  [31:0]out;
 
  assign out=(jal)?5'b11111:5'b00000;
endmodule
