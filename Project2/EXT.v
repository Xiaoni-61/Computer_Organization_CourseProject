module EXT(clk,imm16,imm32,ExtOp);
  input clk;
  input [1:0]ExtOp;
  input [15:0]imm16;
  output  reg[31:0]imm32;
  
  always@(*)
  begin
  if(ExtOp==2'b00)
    imm32={{16{1'b0}},imm16[15:0]};       //0
  
  else if(ExtOp==2'b01)
    imm32={{16{imm16[15]}},imm16[15:0]};  //sign 
    
  else if(ExtOp==2'b10)
    imm32={imm16[15:0],{16{1'b0}}};       //lui
  
  end
  //assign imm32=(ExtOp==2'b00)?{{16{1'b0}},imm16[15:0]}:((ExtOp==2'b01)?{{16{imm16[15]}},imm16[15:0]}:(ExtOp==2'b10)?{imm16[15:0],{16{1'b0}}}:{16{1'b0}});

  endmodule

