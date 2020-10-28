module M3(clk,B,imm32,BSel,M3out);
  inout clk;
  input [31:0]B;
  input [31:0]imm32;
  input BSel;
  output  [31:0]M3out;
  
  
  //always@(*)
  //begin
  //  if(BSel==1'b1)
   //   M3out=imm32;
   // if(BSel==1'b0)
   //   M3out=B;
    
  assign M3out=(BSel)?imm32:B;
  
  
endmodule
