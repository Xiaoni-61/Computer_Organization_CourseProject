
module M1_test;
  reg clk;
  reg [1:0]GPRSel;
  reg [31:0]in0,in1,in2;
  wire [31:0]WrReg;
  
  M1 i1(clk,GPRSel,in0,in1,in2,WrReg);
  initial
  begin
    clk=1;
    in0=1;
    in1=2;
    in2=3;
    
    #50 GPRSel=2'b00;
    #50 GPRSel=3'b01;
    #50 GPRSel=3'b10;
    
  end  
  
  always
    #25 clk=~clk;
    
 endmodule   
