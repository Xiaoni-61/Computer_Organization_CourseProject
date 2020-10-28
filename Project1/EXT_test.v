module EXT_test;
  reg clk;
  
  reg [1:0]ExtOp;
  reg [15:0]imm16;
  wire [31:0]imm32;
  
  
  EXT i1(clk,imm16,imm32,ExtOp);
  
  initial
  begin
    clk=1;
    imm16=16'hFBCD;
    
    #50 ExtOp=2'b00;
    #50 ExtOp=2'b001;
    #50 ExtOp=2'b10;
    
     
    
    #50 ExtOp=2'b00;imm16=16'h1234;
    #50 ExtOp=2'b01;
    #50 ExtOp=2'b10;
  end  
  
  always
    #25 clk=~clk;
    
 endmodule   


