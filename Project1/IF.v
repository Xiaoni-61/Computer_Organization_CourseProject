module IF(clk,of,jal,out);
  input of,jal,clk;
  output reg [31:0]out;
  always@(*)
  begin
    
     if(jal)
      out=5'b11111;
      
  end
endmodule